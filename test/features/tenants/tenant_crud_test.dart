import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/tenants/tenant_form_dialog.dart';
import 'package:saas_identity_platform_flutter/features/tenants/tenants_list_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// M00.F01.I02/I04/I05 租户 CRUD 切片（REQ-2026-003）。
/// 注意：UrlRequestMatcher 不比 method（lab F03 实证）——GET/POST 同路径
/// （/api/v1/admin/tenants）必须折进单 handler 按 options.method 分流。
void main() {
  Future<void> pumpList(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: TenantsListPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'FAB 创建：POST body 恰 tenantKey/name + 收窗 + SnackBar + silent 回刷（@entry I02 证明）',
    (tester) async {
      // fn: M00.F01.I02
      CreateTenantRequest? captured;
      var getCalls = 0;
      final (dio, adapter) = tenantRig();
      adapter.onGet('/api/v1/admin/tenants', (server) {
        server.reply(200, (RequestOptions options) {
          if (options.method == 'POST') {
            captured = standardSerializers.deserializeWith(
              CreateTenantRequest.serializer,
              options.data as Map<String, dynamic>,
            )!;
            return tenantJson(id: 't-new', overrides: {'name': 'Acme'});
          }
          getCalls++;
          return tenantListJson([tenantJson(id: 't-1')]);
        });
      });
      await pumpList(tester, dio);
      expect(getCalls, 1);
      await tester.tap(find.byTooltip('新建租户'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, '租户标识'), 'acme');
      await tester.enterText(find.widgetWithText(TextField, '租户名称'), 'Acme');
      await tester.tap(find.widgetWithText(FilledButton, '保存'));
      await tester.pumpAndSettle();
      expect(captured, isNotNull);
      expect(captured!.tenantKey, 'acme');
      expect(captured!.name, 'Acme');
      // 收窗 + SnackBar + 列表 silent 回刷（第二轮流向 GET）
      expect(find.byType(TenantFormDialog), findsNothing);
      expect(find.text('创建成功'), findsOneWidget);
      expect(getCalls, 2);
    },
  );

  testWidgets('创建必填缺失：文案上屏不发请求（AC-2 fail-fast）', (tester) async {
    var writeCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/tenants', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          writeCalls++;
          return tenantJson();
        }
        return tenantListJson([tenantJson(id: 't-1')]);
      });
    });
    await pumpList(tester, dio);
    await tester.tap(find.byTooltip('新建租户'));
    await tester.pumpAndSettle();
    // 只填名称，标识留空 → fail-fast
    await tester.enterText(find.widgetWithText(TextField, '租户名称'), 'Acme');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('请完整填写租户标识与名称'), findsOneWidget);
    expect(writeCalls, 0);
    expect(find.byType(TenantFormDialog), findsOneWidget); // 留窗
  });

  testWidgets('创建失败（500）：弹窗留窗保输入 + 错误文案上屏', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/tenants', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          return <String, dynamic>{'message': 'boom'};
        }
        return tenantListJson([tenantJson(id: 't-1')]);
      });
    });
    // 500 与 200 折不进单 reply（status 分流不支持）——POST 分支延后注册。
    await pumpList(tester, dio);
    adapter.onPost(
      '/api/v1/admin/tenants',
      (server) => server.reply(500, <String, dynamic>{'message': 'boom'}),
    );
    await tester.tap(find.byTooltip('新建租户'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '租户标识'), 'acme');
    await tester.enterText(find.widgetWithText(TextField, '租户名称'), 'Acme');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('保存失败，请重试'), findsOneWidget);
    expect(find.byType(TenantFormDialog), findsOneWidget);
    // 输入仍在（可重试）
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, '租户标识'))
          .controller!
          .text,
      'acme',
    );
  });

  testWidgets('行编辑：弹窗回填 + PUT /{id} body 全量随（I04 证明）', (tester) async {
    // fn: M00.F01.I04
    UpdateTenantRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(200, tenantListJson([tenantJson(id: 't-1')])),
    );
    adapter.onPut('/api/v1/admin/tenants/t-1', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          UpdateTenantRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return tenantJson(id: 't-1');
      });
    });
    await pumpList(tester, dio);
    await tester.tap(find.byTooltip('编辑'));
    await tester.pumpAndSettle();
    // 回填：名称预填既有值
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, '租户名称'))
          .controller!
          .text,
      '示例租户',
    );
    await tester.enterText(find.widgetWithText(TextField, '租户名称'), '改名租户');
    // 状态下拉：开菜单 → 选「停用」（弹窗内定位，避列表 chip 同文案）
    await tester.tap(
      find
          .descendant(of: find.byType(AlertDialog), matching: find.text('启用'))
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('停用').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.name, '改名租户');
    expect(captured!.status, TenantStatus.suspended);
    expect(find.byType(TenantFormDialog), findsNothing);
  });

  testWidgets('行删除：确认弹窗（级联文案）→ DELETE /{id} + SnackBar + 回刷（I05 证明）', (
    tester,
  ) async {
    // fn: M00.F01.I05
    var deleteCalls = 0;
    var getCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/tenants', (server) {
      server.reply(200, (RequestOptions options) {
        getCalls++;
        return tenantListJson([tenantJson(id: 't-1')]);
      });
    });
    adapter.onDelete('/api/v1/admin/tenants/t-1', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpList(tester, dio);
    expect(getCalls, 1);
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    // 确认弹窗明示级联清理语义（树 I05 行文）
    expect(find.textContaining('级联清理'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '删除'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 1);
    expect(find.text('删除成功'), findsOneWidget);
    expect(getCalls, 2); // silent 回刷
  });

  testWidgets('删除取消：零请求', (tester) async {
    var deleteCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(200, tenantListJson([tenantJson(id: 't-1')])),
    );
    adapter.onDelete('/api/v1/admin/tenants/t-1', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpList(tester, dio);
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '取消'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 0);
    expect(find.byType(AlertDialog), findsNothing);
  });
}
