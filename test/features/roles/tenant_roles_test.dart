import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/roles/role_form_dialog.dart';
import 'package:saas_identity_platform_flutter/features/roles/role_list_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// M00.F03 租户角色切片（REQ-2026-005）。
/// 同构 REQ-2026-004 成员切片；status 是 smallint（1=启用/0=停用）非 enum。
/// 测试名保持声明单行（trace_cmd 逐行扫描，dart format 折行 = 锚失效）。
void main() {
  Future<void> pumpRoles(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: RoleListPage(tenantId: 't-1')),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('角色列表：page=0&pageSize=50 + 行渲染（I01 证明）', (tester) async {
    // fn: M00.F03.I01
    var path = '';
    var query = <String, dynamic>{};
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, (RequestOptions options) {
        path = options.uri.path;
        query = options.queryParameters;
        return roleListJson([roleJson()]);
      });
    });
    await pumpRoles(tester, dio);
    expect(path, '/api/v1/tenants/t-1/roles');
    expect(query['page'], 0); // dio queryParameters 保 int 型
    expect(query['pageSize'], 50);
    expect(find.text('角色-r-1'), findsOneWidget);
    expect(find.text('code-r-1'), findsOneWidget);
    expect(find.text('启用'), findsWidgets);
  });

  testWidgets('FAB 创建角色：POST body 恰五字段 + 收窗回刷（I02 证明）', (tester) async {
    // fn: M00.F03.I02
    CreateSysRoleRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          captured = standardSerializers.deserializeWith(
            CreateSysRoleRequest.serializer,
            options.data as Map<String, dynamic>,
          )!;
          return roleJson(id: 'r-new');
        }
        return roleListJson([roleJson()]);
      });
    });
    await pumpRoles(tester, dio);
    await tester.tap(find.byTooltip('新建角色'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '客户端标识'),
      'saas-console',
    );
    await tester.enterText(find.widgetWithText(TextField, '角色代码'), 'editor');
    await tester.enterText(find.widgetWithText(TextField, '角色名称'), '编辑者');
    await tester.enterText(find.widgetWithText(TextField, '描述'), '可编辑内容');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.clientId, 'saas-console');
    expect(captured!.roleCode, 'editor');
    expect(captured!.roleName, '编辑者');
    expect(captured!.description, '可编辑内容');
    expect(captured!.isPreset, isNull); // 后端固定 false，不随 body
    expect(find.byType(RoleFormDialog), findsNothing);
    expect(find.text('创建成功'), findsOneWidget);
  });

  testWidgets('创建必填缺失：fail-fast 不发请求', (tester) async {
    var writeCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          writeCalls++;
          return roleJson();
        }
        return roleListJson([roleJson()]);
      });
    });
    await pumpRoles(tester, dio);
    await tester.tap(find.byTooltip('新建角色'));
    await tester.pumpAndSettle();
    // 只填客户端标识，角色代码/角色名称留空 → fail-fast
    await tester.enterText(
      find.widgetWithText(TextField, '客户端标识'),
      'saas-console',
    );
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('请完整填写客户端标识、角色代码与角色名称'), findsOneWidget);
    expect(writeCalls, 0);
    expect(find.byType(RoleFormDialog), findsOneWidget);
  });

  testWidgets('创建失败 500：弹窗留窗保输入', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, roleListJson([roleJson()]));
    });
    await pumpRoles(tester, dio);
    adapter.onPost(
      '/api/v1/tenants/t-1/roles',
      (server) => server.reply(500, <String, dynamic>{'message': 'boom'}),
    );
    await tester.tap(find.byTooltip('新建角色'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '客户端标识'),
      'saas-console',
    );
    await tester.enterText(find.widgetWithText(TextField, '角色代码'), 'editor');
    await tester.enterText(find.widgetWithText(TextField, '角色名称'), '编辑者');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('保存失败，请重试'), findsOneWidget);
    expect(find.byType(RoleFormDialog), findsOneWidget);
  });

  testWidgets('行进详情：十字段卡（I03 证明）', (tester) async {
    // fn: M00.F03.I03
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, roleListJson([roleJson()]));
    });
    adapter.onGet('/api/v1/tenants/t-1/roles/r-1', (server) {
      server.reply(200, roleJson());
    });
    await pumpRoles(tester, dio);
    await tester.tap(find.text('角色-r-1'));
    await tester.pumpAndSettle();
    // 十字段卡：id/tenantId/clientId/roleCode/roleName/description/isPreset/
    // status/createdAt/updatedAt（find.text 默认 skipOffstage——列表路由被
    // 压 offstage，只数详情卡）
    expect(find.text('角色-r-1'), findsWidgets);
    expect(find.text('code-r-1'), findsOneWidget);
    expect(find.text('saas-console'), findsOneWidget);
    expect(find.text('r-1'), findsOneWidget);
    expect(find.text('t-1'), findsOneWidget);
    expect(find.text('desc-r-1'), findsOneWidget);
    expect(find.text('否'), findsOneWidget); // isPreset=false
  });

  testWidgets('行编辑：PUT body 恰 roleName/description（I04 证明）', (tester) async {
    // fn: M00.F03.I04
    UpdateSysRoleRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, roleListJson([roleJson()]));
    });
    adapter.onPut('/api/v1/tenants/t-1/roles/r-1', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          UpdateSysRoleRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return roleJson();
      });
    });
    await pumpRoles(tester, dio);
    await tester.tap(find.byTooltip('编辑'));
    await tester.pumpAndSettle();
    // 回填：角色名称/描述预填既有值
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, '角色名称'))
          .controller!
          .text,
      '角色-r-1',
    );
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, '描述'))
          .controller!
          .text,
      'desc-r-1',
    );
    await tester.enterText(find.widgetWithText(TextField, '角色名称'), '新名称');
    await tester.enterText(find.widgetWithText(TextField, '描述'), '新描述');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.roleName, '新名称');
    expect(captured!.description, '新描述');
    expect(find.byType(RoleFormDialog), findsNothing);
  });

  testWidgets('行删除：确认文案 + DELETE + 回刷（I05 证明）', (tester) async {
    // fn: M00.F03.I05
    var deleteCalls = 0;
    var getCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, (RequestOptions options) {
        getCalls++;
        return roleListJson([roleJson()]);
      });
    });
    adapter.onDelete('/api/v1/tenants/t-1/roles/r-1', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpRoles(tester, dio);
    expect(getCalls, 1);
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    // 确认弹窗明示级联清理语义（树 I05 行文：移除角色并清理成员绑定与权限关联）
    expect(find.textContaining('成员角色绑定与权限关联'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '删除'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 1);
    expect(find.text('删除成功'), findsOneWidget);
    expect(getCalls, 2); // silent 回刷
  });

  testWidgets('删除取消：零请求', (tester) async {
    var deleteCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(200, roleListJson([roleJson()]));
    });
    adapter.onDelete('/api/v1/tenants/t-1/roles/r-1', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpRoles(tester, dio);
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '取消'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 0);
    expect(find.byType(AlertDialog), findsNothing);
  });
}
