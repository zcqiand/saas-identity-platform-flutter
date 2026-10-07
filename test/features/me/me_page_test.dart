import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/me/me_page.dart';

import '../../support/tenant_fixtures.dart';

/// REQ-2026-008 M01 切片：「我」页（whoami + 我的租户成员关系 + 切换）。
/// 测试名保持声明单行（trace_cmd 逐行扫描）。
void main() {
  Future<void> pumpMe(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: MePage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  void stubMe(DioAdapter adapter, {String currentTenantId = 't-1'}) {
    adapter.onGet('/api/v1/me', (server) {
      server.reply(200, currentUserJson(overrides: {'currentTenantId': currentTenantId}));
    });
    adapter.onGet('/api/v1/me/tenants', (server) {
      server.reply(200, <Object>[
        membershipJson(),
        membershipJson(
          tenantId: 't-2',
          overrides: {'status': 'suspended', 'roleIds': <String>['r-1', 'r-2']},
        ),
      ]);
    });
  }

  testWidgets('我页 whoami：GET /api/v1/me + 用户ID/邮箱/当前租户渲染（I01 证明）', (tester) async {
    // fn: M01.F01.I01
    var mePath = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/me', (server) {
      server.reply(200, (RequestOptions options) {
        mePath = options.uri.path;
        return currentUserJson();
      });
    });
    adapter.onGet('/api/v1/me/tenants', (server) {
      server.reply(200, <Object>[membershipJson()]);
    });
    await pumpMe(tester, dio);
    expect(mePath, '/api/v1/me');
    expect(find.text('u-1'), findsWidgets); // whoami 卡用户ID
    expect(find.text('u-1@example.com'), findsOneWidget);
    expect(find.text('当前租户'), findsOneWidget);
    expect(find.text('t-1'), findsWidgets); // 卡 + 成员关系行
  });

  testWidgets('我页成员关系：GET /api/v1/me/tenants + 行渲染/状态徽标/角色数（F03.I01 证明）', (tester) async {
    // fn: M01.F03.I01
    var tenantsPath = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/me', (server) {
      server.reply(200, currentUserJson());
    });
    adapter.onGet('/api/v1/me/tenants', (server) {
      server.reply(200, (RequestOptions options) {
        tenantsPath = options.uri.path;
        return <Object>[
          membershipJson(),
          membershipJson(
            tenantId: 't-2',
            overrides: {'status': 'suspended', 'roleIds': <String>['r-1', 'r-2']},
          ),
        ];
      });
    });
    await pumpMe(tester, dio);
    expect(tenantsPath, '/api/v1/me/tenants');
    expect(find.text('我的租户成员关系'), findsOneWidget);
    expect(find.text('t-1'), findsWidgets);
    expect(find.text('t-2'), findsWidgets);
    expect(find.text('启用'), findsOneWidget); // active 徽标
    expect(find.text('停用'), findsOneWidget); // suspended 徽标
    expect(find.text('角色 1 项'), findsOneWidget);
    expect(find.text('角色 2 项'), findsOneWidget);
    expect(find.text('2026-06-01'), findsOneWidget); // joinedAt 仅日期
  });

  testWidgets('切换租户：POST switch + SnackBar + whoami 回刷当前租户（F03.I02 证明）', (tester) async {
    // fn: M01.F03.I02
    var switchPath = '';
    var meCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/me', (server) {
      server.reply(200, (RequestOptions options) {
        meCalls++;
        // 首拉当前 t-1；切换回刷后 t-2
        return currentUserJson(overrides: {'currentTenantId': meCalls == 1 ? 't-1' : 't-2'});
      });
    });
    adapter.onGet('/api/v1/me/tenants', (server) {
      server.reply(200, <Object>[membershipJson(tenantId: 't-2')]);
    });
    adapter.onPost('/api/v1/me/tenants/t-2/switch', (server) {
      server.reply(200, (RequestOptions options) {
        switchPath = options.uri.path;
        return switchResponseJson(tenantId: 't-2');
      });
    });
    await pumpMe(tester, dio);
    expect(meCalls, 1);
    await tester.tap(find.byTooltip('切换'));
    await tester.pumpAndSettle();
    expect(switchPath, '/api/v1/me/tenants/t-2/switch');
    expect(find.text('已切换到 t-2'), findsOneWidget);
    expect(meCalls, 2); // silent 回刷
    expect(find.text('t-2'), findsWidgets); // 行 + 当前租户卡均已更新
  });

  testWidgets('whoami 失败：错误态可重试', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/me', (server) {
      server.reply(500, <String, dynamic>{'message': 'boom'});
    });
    adapter.onGet('/api/v1/me/tenants', (server) {
      server.reply(200, <Object>[membershipJson()]);
    });
    await pumpMe(tester, dio);
    expect(find.text('无法连接服务器'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
  });
}
