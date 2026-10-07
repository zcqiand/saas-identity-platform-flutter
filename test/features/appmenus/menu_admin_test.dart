import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/appmenus/menu_form_dialog.dart';
import 'package:saas_identity_platform_flutter/features/appmenus/menu_tree_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// REQ-2026-011 M04.F04 菜单管理 flutter 侧（client-scoped SysMenu）。
/// 方法面：create POST / update PATCH / move PATCH /parent / reorder PUT。
/// 根 parentId=零 UUID（后端 b.parentId ?? 0-uuid）。I08 待契约修正不在本片。
void main() {
  const root = '00000000-0000-0000-0000-000000000000';

  Map<String, dynamic> treeMenus() => <String, dynamic>{
    // d-1(目录, 根) → m-1/m-2(菜单, 同级) → b-1(按钮, 挂 m-1)
    'items': <Map<String, dynamic>>[
      menuJson(id: 'd-1', overrides: {
        'clientId': 'app-1',
        'title': '目录-d-1',
        'type': 'directory',
        'path': null,
      }),
      menuJson(id: 'm-1', overrides: {'clientId': 'app-1', 'parentId': 'd-1'}),
      menuJson(id: 'm-2', overrides: {'clientId': 'app-1', 'parentId': 'd-1'}),
      menuJson(id: 'b-1', overrides: {
        'clientId': 'app-1',
        'parentId': 'm-1',
        'type': 'button',
        'path': null,
      }),
    ],
  };

  Future<void> pumpMenus(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: MenuTreePage(clientId: 'app-1')),
      ),
    );
    await tester.pumpAndSettle();
  }

  void stubList(DioAdapter adapter) {
    adapter.onGet('/api/v1/clients/app-1/menus', (server) {
      server.reply(200, treeMenus());
    });
  }

  testWidgets('菜单列表：GET /api/v1/clients/{clientId}/menus + 组树 DFS 层级渲染（F04.I01 证明）', (
    tester,
  ) async {
    // fn: M04.F04.I01
    var listPath = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/clients/app-1/menus', (server) {
      server.reply(200, (RequestOptions options) {
        listPath = options.uri.path;
        return treeMenus();
      });
    });
    await pumpMenus(tester, dio);
    expect(listPath, '/api/v1/clients/app-1/menus');
    expect(find.text('目录-d-1'), findsOneWidget);
    expect(find.text('菜单-m-1'), findsOneWidget);
    expect(find.text('菜单-m-2'), findsOneWidget);
    expect(find.text('菜单-b-1'), findsOneWidget);
    // DFS 层级序：父先于子（d-1 → m-1 → b-1 → m-2）
    final titles = tester
        .widgetList<ListTile>(find.byType(ListTile))
        .map((t) => (t.title as Text).data)
        .toList();
    expect(titles.indexOf('目录-d-1'), lessThan(titles.indexOf('菜单-m-1')));
    expect(titles.indexOf('菜单-m-1'), lessThan(titles.indexOf('菜单-b-1')));
    expect(titles.indexOf('菜单-m-1'), lessThan(titles.indexOf('菜单-m-2')));
  });

  testWidgets('创建菜单：POST body 类型/父级/路径 + 回刷（F04.I02 证明）', (tester) async {
    // fn: M04.F04.I02
    CreateSysMenuRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpMenus(tester, dio);
    adapter.onPost('/api/v1/clients/app-1/menus', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          CreateSysMenuRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return menuJson(id: 'm-new', overrides: {'clientId': 'app-1'});
      });
    });
    await tester.tap(find.byTooltip('新建菜单'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '标题'), '新菜单');
    await tester.enterText(find.widgetWithText(TextField, '路径'), '/new');
    await tester.tap(find.widgetWithText(FilledButton, '创建'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.title, '新菜单');
    expect(captured!.type, SysMenuType.menu);
    expect(captured!.parentId, root); // 未选父级 = 顶级（零 UUID）
    expect(captured!.path, '/new');
    expect(find.byType(MenuFormDialog), findsNothing);
    expect(find.text('菜单已创建'), findsOneWidget);
  });

  testWidgets('菜单详情：GET 单体 + 全字段弹窗（F04.I03 证明）', (tester) async {
    // fn: M04.F04.I03
    var detailPath = '';
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpMenus(tester, dio);
    adapter.onGet('/api/v1/clients/app-1/menus/m-1', (server) {
      server.reply(200, (RequestOptions options) {
        detailPath = options.uri.path;
        return menuJson(id: 'm-1', overrides: {
          'clientId': 'app-1',
          'parentId': 'd-1',
          'perms': 'lab.read',
          'icon': 'home',
        });
      });
    });
    await tester.tap(find.text('菜单-m-1'));
    await tester.pumpAndSettle();
    expect(detailPath, '/api/v1/clients/app-1/menus/m-1');
    expect(find.text('菜单详情'), findsOneWidget);
    expect(find.text('菜单-m-1'), findsWidgets);
    expect(find.text('lab.read'), findsOneWidget); // 权限码
    expect(find.text('home'), findsOneWidget); // icon
  });

  testWidgets('更新菜单：PATCH 不带 parentId（不动父子结构）+ 响应回填（F04.I04 证明）', (tester) async {
    // fn: M04.F04.I04
    UpdateSysMenuRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpMenus(tester, dio);
    adapter.onPatch('/api/v1/clients/app-1/menus/m-1', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          UpdateSysMenuRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return menuJson(
          id: 'm-1',
          overrides: {'clientId': 'app-1', 'parentId': 'd-1', 'title': '改名菜单'},
        );
      });
    });
    await tester.tap(find.byTooltip('编辑').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '标题'), '改名菜单');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.title, '改名菜单');
    expect(captured!.parentId, isNull); // 父子结构变更归 I07 专用端点
    expect(find.text('菜单已更新'), findsOneWidget);
    expect(find.text('改名菜单'), findsOneWidget);
  });

  testWidgets('删除菜单：确认明示级联语义 + DELETE + 回刷（F04.I05 证明）', (tester) async {
    // fn: M04.F04.I05
    var deletePath = '';
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpMenus(tester, dio);
    adapter.onDelete('/api/v1/clients/app-1/menus/b-1', (server) {
      server.reply(200, (RequestOptions options) {
        deletePath = options.uri.path;
        return <String, dynamic>{};
      });
    });
    await tester.tap(find.byTooltip('删除').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('级联'), findsOneWidget); // 子菜单+角色授权一并清理
    await tester.tap(find.widgetWithText(TextButton, '删除').last);
    await tester.pumpAndSettle();
    expect(deletePath, '/api/v1/clients/app-1/menus/b-1');
    expect(find.text('菜单已删除'), findsOneWidget);
  });

  testWidgets('同级排序：上移 → PUT /reorder 同级新顺序（F04.I06 证明）', (tester) async {
    // fn: M04.F04.I06
    ReorderSysMenuRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpMenus(tester, dio);
    adapter.onPut('/api/v1/clients/app-1/menus/m-2/reorder', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          ReorderSysMenuRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return treeMenus()['items'];
      });
    });
    await tester.tap(find.byTooltip('上移').last);
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    // m-2 原列 m-1 之后；上移后同级新顺序 = [m-2, m-1]（含自身全量）
    expect(captured!.orderedMenuIds.toList(), <String>['m-2', 'm-1']);
    expect(find.text('排序已更新'), findsOneWidget);
  });

  testWidgets('切换父级：PATCH /parent 换挂目录（F04.I07 证明）', (tester) async {
    // fn: M04.F04.I07
    ClientMenusMoveSysMenuRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpMenus(tester, dio);
    adapter.onPatch('/api/v1/clients/app-1/menus/m-2/parent', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          ClientMenusMoveSysMenuRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return menuJson(
          id: 'm-2',
          overrides: {'clientId': 'app-1', 'parentId': 'm-1'},
        );
      });
    });
    await tester.tap(find.byTooltip('移动').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('菜单-m-1').last); // 父级选择：挂到 m-1
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '移动'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.parentId, 'm-1');
    expect(find.text('已移动'), findsOneWidget);
  });

  testWidgets('列表失败：错误态可重试', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/clients/app-1/menus', (server) {
      server.reply(500, <String, dynamic>{'message': 'boom'});
    });
    await pumpMenus(tester, dio);
    expect(find.text('无法连接服务器'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
  });
}
