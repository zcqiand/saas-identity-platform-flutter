import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
// riverpod 3 把 Override 挪到 misc 导出面（flutter_riverpod.dart 不再带它）。
import 'package:flutter_riverpod/misc.dart' show Override;

import 'package:saas_identity_platform_flutter/core/api/session_guard.dart';
import 'package:saas_identity_platform_flutter/core/auth/auth_controller.dart';
import 'package:saas_identity_platform_flutter/core/auth/auth_state.dart';
import 'package:saas_identity_platform_flutter/core/auth/login_page.dart';
import 'package:saas_identity_platform_flutter/core/auth/providers.dart';

import '../../fakes/in_memory_token_store.dart';

const _okBody = <String, dynamic>{
  // user 须满足生成物 SysUser 必填面：id/username/status/createdAt/updatedAt。
  'user': {
    'id': 'u-1',
    'username': 'alice',
    'status': 'active',
    'createdAt': '2026-01-01T00:00:00Z',
    'updatedAt': '2026-01-01T00:00:00Z',
  },
  'availableTenants': <dynamic>[],
  'userId': 'u-1',
  'currentTenantId': null,
  'accessToken': 'at-1',
  'refreshToken': 'rt-1',
  'tokenType': 'Bearer',
  'expiresIn': 3600,
  'clientId': 'saas-console',
};

/// RF#1 UI 侧用的提交中桩：直接以 AuthSubmitting 为 build 态，零时序竞争。
class _SubmittingStubController extends AuthController {
  @override
  AuthState build() => const AuthSubmitting();
}

/// 测试装配：dio + 自绑 adapter（0.6.1 构造签名 DioAdapter({required this.dio})）。
/// matcher 换 UrlRequestMatcher：默认 FullHttpRequestMatcher 对注册时无 data
/// 匹配器的路由不命中任何带体请求（T5 实证），login POST 全带体。
(Dio, DioAdapter) _loginRig() {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
  final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
  return (dio, adapter);
}

Future<void> pumpLogin(
  WidgetTester tester,
  Dio dio, [
  List<Override> extraOverrides = const [],
]) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dioProvider.overrideWithValue(dio),
        tokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
        sessionGuardProvider.overrideWithValue(SessionGuard()),
        appConfigClientIdProvider.overrideWithValue('saas-console'),
        ...extraOverrides,
      ],
      child: const MaterialApp(home: LoginPage()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('登录成功 → 按钮恢复可用、无失败文案（controller 态由 T5 覆盖）', (tester) async {
    // fn: M01.F04.I03
    final (dio, adapter) = _loginRig();
    adapter.onPost(
      '/api/v1/auth/login',
      (server) => server.reply(200, _okBody),
    );
    await pumpLogin(tester, dio);
    await tester.enterText(find.widgetWithText(TextField, '用户名'), 'alice');
    await tester.enterText(find.widgetWithText(TextField, '密码'), 'dev123456');
    await tester.tap(find.text('登录'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    expect(find.text('登录中…'), findsNothing);
  });

  testWidgets('401 → failed 文案上屏', (tester) async {
    final (dio, adapter) = _loginRig();
    adapter.onPost(
      '/api/v1/auth/login',
      (server) =>
          server.reply(401, {'code': 'BAD_CREDENTIALS', 'message': 'x'}),
    );
    await pumpLogin(tester, dio);
    await tester.enterText(find.widgetWithText(TextField, '用户名'), 'alice');
    await tester.enterText(find.widgetWithText(TextField, '密码'), 'bad');
    await tester.tap(find.text('登录'));
    await tester.pumpAndSettle();
    expect(find.text('用户名或密码错误'), findsOneWidget);
  });

  testWidgets('submitting 期间按钮禁用 +「登录中…」（RF#1 UI 侧）', (tester) async {
    final (dio, _) = _loginRig(); // stub 态零请求，adapter 仅装配自绑
    await pumpLogin(tester, dio, [
      authControllerProvider.overrideWith(_SubmittingStubController.new),
    ]);
    expect(find.text('登录中…'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });
}
