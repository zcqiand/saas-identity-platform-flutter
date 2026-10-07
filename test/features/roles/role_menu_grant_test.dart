import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/roles/role_menu_grant_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// M00.F04 角色菜单授权切片（REQ-2026-006）。
/// 目录按角色 clientId 拉（client 作用域），现授权按 roleId 拉——经 clientId
/// 对齐。测试名保持声明单行（trace_cmd 逐行扫描，折行 = 锚失效）。
void main() {
  Future<void> pumpGrant(
    WidgetTester tester,
    Dio dio, {
    String clientId = 'saas-console',
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: MaterialApp(
          home: RoleMenuGrantPage(
            tenantId: 't-1',
            roleId: 'r-1',
            clientId: clientId,
            roleName: '角色-r-1',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  void stubCatalog(DioAdapter adapter) {
    adapter.onGet('/api/v1/clients/saas-console/menus', (server) {
      server.reply(200, [menuJson(id: 'm-1'), menuJson(id: 'm-2')]);
    });
  }

  testWidgets('进授权页：目录 + 现授权并行拉，勾选回显（I02 证明）', (tester) async {
    var grantPath = '';
    final (dio, adapter) = tenantRig();
    stubCatalog(adapter);
    adapter.onGet('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(200, (RequestOptions options) {
        grantPath = options.uri.path;
        return roleGrantJson(['m-1']);
      });
    });
    await pumpGrant(tester, dio);
    expect(grantPath, '/api/v1/tenants/t-1/roles/r-1/menus');
    // 回显：m-1 已授权（checked），m-2 未授权（unchecked）
    expect(
      tester.widget<CheckboxListTile>(
        find.widgetWithText(CheckboxListTile, '菜单-m-1'),
      ).value,
      isTrue,
    );
    expect(
      tester.widget<CheckboxListTile>(
        find.widgetWithText(CheckboxListTile, '菜单-m-2'),
      ).value,
      isFalse,
    );
  });

  testWidgets('保存授权：PUT body menuIds 恰勾选全集（I03 证明）', (tester) async {
    SetSysRoleMenusRequest? captured;
    final (dio, adapter) = tenantRig();
    stubCatalog(adapter);
    adapter.onGet('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(200, roleGrantJson(['m-1']));
    });
    adapter.onPut('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          SetSysRoleMenusRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return roleGrantJson(['m-1', 'm-2']);
      });
    });
    await pumpGrant(tester, dio);
    await tester.tap(find.text('菜单-m-2'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存授权'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.menuIds.toList(), ['m-1', 'm-2']); // 全量替换语义
    expect(find.text('授权已保存'), findsOneWidget);
  });

  testWidgets('清空授权：确认文案 + DELETE + 回读（I04 证明）', (tester) async {
    var deleteCalls = 0;
    var grantCalls = 0;
    final (dio, adapter) = tenantRig();
    stubCatalog(adapter);
    adapter.onGet('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(200, (RequestOptions options) {
        grantCalls++;
        return roleGrantJson(['m-1']);
      });
    });
    adapter.onDelete('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpGrant(tester, dio);
    await tester.tap(find.widgetWithText(OutlinedButton, '清空授权'));
    await tester.pumpAndSettle();
    // 确认弹窗明示后果（树 I04 行文：清空后该角色登录不再渲染菜单）
    expect(find.textContaining('不再渲染任何菜单'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '确认清空'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 1);
    expect(find.text('已清空'), findsOneWidget);
    expect(grantCalls, 2); // 回读
  });

  testWidgets('清空取消：零请求', (tester) async {
    var deleteCalls = 0;
    final (dio, adapter) = tenantRig();
    stubCatalog(adapter);
    adapter.onGet('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(200, roleGrantJson(['m-1']));
    });
    adapter.onDelete('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpGrant(tester, dio);
    await tester.tap(find.widgetWithText(OutlinedButton, '清空授权'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '取消'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 0);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('保存失败 500：SnackBar 留页，勾选态不动', (tester) async {
    final (dio, adapter) = tenantRig();
    stubCatalog(adapter);
    adapter.onGet('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(200, roleGrantJson(['m-1']));
    });
    adapter.onPut('/api/v1/tenants/t-1/roles/r-1/menus', (server) {
      server.reply(500, <String, dynamic>{'message': 'boom'});
    });
    await pumpGrant(tester, dio);
    await tester.tap(find.text('菜单-m-2'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存授权'));
    await tester.pumpAndSettle();
    expect(find.text('保存失败，请重试'), findsOneWidget);
    // 勾选态原地不动：m-2 仍呈勾选
    expect(
      tester.widget<CheckboxListTile>(
        find.widgetWithText(CheckboxListTile, '菜单-m-2'),
      ).value,
      isTrue,
    );
  });
}
