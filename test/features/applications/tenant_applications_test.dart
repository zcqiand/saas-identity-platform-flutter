import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/applications/subscribe_application_dialog.dart';
import 'package:saas_identity_platform_flutter/features/applications/application_list_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// M00.F05 租户应用切片（REQ-2026-007）。寻址键是 clientId；status int
/// 0=pending/1=active/2=disabled。测试名保持声明单行（trace_cmd 逐行扫描）。
void main() {
  Future<void> pumpApps(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: ApplicationListPage(tenantId: 't-1')),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('应用列表：行渲染 clientId/徽标/到期时间（I01 证明）', (tester) async {
    // fn: M00.F05.I01
    var path = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, (RequestOptions options) {
        path = options.uri.path;
        return appListJson([
          appJson(),
          appJson(
            clientId: 'saas-console',
            overrides: {'status': 2, 'expireTime': '2027-12-31T00:00:00Z'},
          ),
        ]);
      });
    });
    await pumpApps(tester, dio);
    expect(path, '/api/v1/tenants/t-1/applications');
    expect(find.text('lab-management'), findsOneWidget);
    expect(find.text('saas-console'), findsOneWidget);
    expect(find.text('已启用'), findsOneWidget);
    expect(find.text('已停用'), findsOneWidget);
    expect(find.text('2027-12-31'), findsOneWidget); // 到期时间仅日期渲染
  });

  testWidgets('FAB 订阅应用：POST body 恰两字段 + 收窗回刷（I02 证明）', (tester) async {
    // fn: M00.F05.I02
    SubscribeTenantApplicationRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          captured = standardSerializers.deserializeWith(
            SubscribeTenantApplicationRequest.serializer,
            options.data as Map<String, dynamic>,
          )!;
          return appJson(clientId: 'lab-management');
        }
        return appListJson([appJson()]);
      });
    });
    await pumpApps(tester, dio);
    await tester.tap(find.byTooltip('订阅应用'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '客户端标识'),
      'lab-management',
    );
    await tester.enterText(
      find.widgetWithText(TextField, '到期时间'),
      '2027-12-31',
    );
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.clientId, 'lab-management');
    expect(captured!.expireTime, isNotNull); // yyyy-MM-dd 解析随 body
    expect(find.byType(SubscribeApplicationDialog), findsNothing);
    expect(find.text('订阅已添加'), findsOneWidget);
  });

  testWidgets('订阅必填缺失：fail-fast 不发请求', (tester) async {
    var writeCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          writeCalls++;
          return appJson();
        }
        return appListJson([appJson()]);
      });
    });
    await pumpApps(tester, dio);
    await tester.tap(find.byTooltip('订阅应用'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('请填写客户端标识'), findsOneWidget);
    expect(writeCalls, 0);
    expect(find.byType(SubscribeApplicationDialog), findsOneWidget);
  });

  testWidgets('订阅失败 500：弹窗留窗保输入', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, appListJson([appJson()]));
    });
    await pumpApps(tester, dio);
    adapter.onPost(
      '/api/v1/tenants/t-1/applications',
      (server) => server.reply(500, <String, dynamic>{'message': 'boom'}),
    );
    await tester.tap(find.byTooltip('订阅应用'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '客户端标识'),
      'lab-management',
    );
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('保存失败，请重试'), findsOneWidget);
    expect(find.byType(SubscribeApplicationDialog), findsOneWidget);
  });

  testWidgets('行内启停：PUT body 恰 status 且 expireTime 不随（I03 证明）', (tester) async {
    // fn: M00.F05.I03
    UpdateTenantApplicationRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, appListJson([appJson()]));
    });
    await pumpApps(tester, dio);
    adapter.onPut('/api/v1/tenants/t-1/applications/lab-management', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          UpdateTenantApplicationRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return appJson(overrides: {'status': 2});
      });
    });
    await tester.tap(find.byTooltip('停用'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.status, 2);
    expect(captured!.expireTime, isNull); // 不动不随 body
    expect(find.text('已停用'), findsOneWidget); // 回刷徽标
  });

  testWidgets('行移除：确认文案 + DELETE + 回刷（I04 证明）', (tester) async {
    // fn: M00.F05.I04
    var deleteCalls = 0;
    var getCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, (RequestOptions options) {
        getCalls++;
        return appListJson([appJson()]);
      });
    });
    await pumpApps(tester, dio);
    expect(getCalls, 1);
    adapter.onDelete('/api/v1/tenants/t-1/applications/lab-management', (
      server,
    ) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    // 确认弹窗明示树口径：取消订阅不删除应用本体
    expect(find.textContaining('不删除应用本体'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '删除'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 1);
    expect(find.text('已移除订阅'), findsOneWidget);
    expect(getCalls, 2); // silent 回刷
  });

  testWidgets('移除取消：零请求', (tester) async {
    var deleteCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/applications', (server) {
      server.reply(200, appListJson([appJson()]));
    });
    await pumpApps(tester, dio);
    adapter.onDelete('/api/v1/tenants/t-1/applications/lab-management', (
      server,
    ) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '取消'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 0);
    expect(find.byType(AlertDialog), findsNothing);
  });
}
