import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/core/auth/sso_handoff.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// REQ-2026-012 M04.F03.I01 授权码签发（SSO 登录回跳 flutter 半）。
/// RP 带 OAuth 参数来登录 → 登录后 authorize 领 code → 组 URL 跳回 RP。
/// 镜像 nextjs login/page.tsx 同款流程；token 端点（I02）flutter 无面。
void main() {
  const sso = SsoParams(
    clientId: 'lab-management',
    redirectUri: 'https://lab.local/cb',
    scope: 'lab.read',
    state: 'xyz',
  );

  Widget rig(WidgetTester tester, Dio dio, void Function(String url) onRedirect) =>
    ProviderScope(
      overrides: [dioProvider.overrideWithValue(dio)],
      child: MaterialApp(
        home: SsoHandoff(sso: sso, onRedirect: onRedirect),
      ),
    );

  test('参数解析：全参齐才算 SSO，缺一或 responseType≠code 回退', () {
    final ok = SsoParams.fromUri(
      Uri.parse(
        '/login?clientId=lab-management'
        '&redirectUri=https%3A%2F%2Flab.local%2Fcb'
        '&responseType=code&scope=lab.read&state=xyz',
      ),
    );
    expect(ok, isNotNull);
    expect(ok!.clientId, 'lab-management');
    expect(ok.redirectUri, 'https://lab.local/cb');
    expect(ok.scope, 'lab.read');
    expect(ok.state, 'xyz');
    // 缺 responseType / responseType≠code / 缺 clientId → 非法，回普通登录。
    expect(
      SsoParams.fromUri(
        Uri.parse('/login?clientId=c1&redirectUri=https%3A%2F%2Fa%2Fb&state=s'),
      ),
      isNull,
    );
    expect(
      SsoParams.fromUri(
        Uri.parse(
          '/login?clientId=c1&redirectUri=https%3A%2F%2Fa%2Fb'
          '&responseType=token&state=s',
        ),
      ),
      isNull,
    );
    expect(
      SsoParams.fromUri(
        Uri.parse(
          '/login?redirectUri=https%3A%2F%2Fa%2Fb&responseType=code&state=s',
        ),
      ),
      isNull,
    );
  });

  testWidgets('SSO 回跳：authorize 五字段+组 URL（F03.I01 证明）', (tester) async {
    // fn: M04.F03.I01
    Map<String, dynamic>? raw;
    String? redirected;
    final (dio, adapter) = tenantRig();
    adapter.onPost('/api/v1/oauth/authorize', (server) {
      server.reply(200, (RequestOptions options) {
        raw = options.data as Map<String, dynamic>;
        return <String, dynamic>{'code': 'c-1', 'state': 'xyz'};
      });
    });
    await tester.pumpWidget(rig(tester, dio, (u) => redirected = u));
    await tester.pumpAndSettle();
    final req = standardSerializers.deserializeWith(
      AuthorizeCodeRequest.serializer,
      raw!,
    )!;
    expect(req.clientId, 'lab-management');
    expect(req.redirectUri, 'https://lab.local/cb');
    expect(req.responseType, AuthorizeCodeRequestResponseTypeEnum.code);
    expect(req.scope, 'lab.read');
    expect(req.state, 'xyz');
    expect(redirected, 'https://lab.local/cb?code=c-1&state=xyz');
  });

  test('跳转 URL 组装：redirectUri 带 query 用 & 追加 + 编码', () {
    expect(
      buildSsoRedirectUrl('https://lab.local/cb', 'c1', 'st'),
      'https://lab.local/cb?code=c1&state=st',
    );
    expect(
      buildSsoRedirectUrl('https://lab.local/cb?from=lab', 'c 1', 's&t'),
      'https://lab.local/cb?from=lab&code=c%201&state=s%26t',
    );
  });

  testWidgets('authorize 失败：错误文案 + 不重定向', (tester) async {
    String? redirected;
    final (dio, adapter) = tenantRig();
    adapter.onPost('/api/v1/oauth/authorize', (server) {
      server.reply(400, <String, dynamic>{'error': 'INVALID_REDIRECT_URI'});
    });
    await tester.pumpWidget(rig(tester, dio, (u) => redirected = u));
    await tester.pumpAndSettle();
    expect(find.textContaining('授权失败'), findsOneWidget);
    expect(redirected, isNull);
  });
}
