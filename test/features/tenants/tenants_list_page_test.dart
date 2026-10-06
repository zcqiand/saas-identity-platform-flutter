import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/tenants/tenants_list_page.dart';

import '../../fakes/throwing_adapter.dart';
import '../../support/tenant_fixtures.dart';

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

  testWidgets('两租户行渲染：name/tenantKey/状态标签两值上屏（@entry I01 证明）', (tester) async {
    // fn: M00.F01.I01
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(
        200,
        tenantListJson([
          tenantJson(id: 't-1'),
          tenantJson(
            id: 't-2',
            overrides: {'name': '停用租户', 'status': 'suspended'},
          ),
        ]),
      ),
    );
    await pumpList(tester, dio);
    expect(find.text('示例租户'), findsOneWidget);
    expect(find.text('停用租户'), findsOneWidget);
    expect(find.text('tenant-t-1'), findsOneWidget);
    expect(find.text('tenant-t-2'), findsOneWidget);
    // 状态标签两值全覆盖（chip 与徽标同文案，各 ≥1）
    expect(find.text('启用'), findsWidgets);
    expect(find.text('停用'), findsWidgets);
  });

  testWidgets('captured query 显式 page=1&pageSize=50（不依赖服务端默认）', (tester) async {
    final (dio, adapter) = tenantRig();
    final queries = <Map<String, String>>[];
    adapter.onGet('/api/v1/admin/tenants', (server) {
      server.reply(200, (RequestOptions options) {
        queries.add(options.uri.queryParameters);
        return tenantListJson([tenantJson()]);
      });
    });
    await pumpList(tester, dio);
    expect(queries.single['page'], '1');
    expect(queries.single['pageSize'], '50');
  });

  testWidgets('keyword 客户端侧过滤：行数收敛不发第二请求', (tester) async {
    final (dio, adapter) = tenantRig();
    var calls = 0;
    adapter.onGet('/api/v1/admin/tenants', (server) {
      server.reply(200, (RequestOptions options) {
        calls++;
        return tenantListJson([
          tenantJson(id: 't-1'),
          tenantJson(
            id: 't-2',
            overrides: {'name': '停用租户', 'status': 'suspended'},
          ),
        ]);
      });
    });
    await pumpList(tester, dio);
    await tester.enterText(find.widgetWithText(TextField, '关键字'), '停用');
    await tester.pumpAndSettle();
    expect(find.text('停用租户'), findsOneWidget);
    expect(find.text('示例租户'), findsNothing);
    // 客户端侧过滤：网络仅首载一轮
    expect(calls, 1);
  });

  testWidgets('statusFilter 停用 chip：只剩停用行；恢复全部两行齐', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(
        200,
        tenantListJson([
          tenantJson(id: 't-1'),
          tenantJson(
            id: 't-2',
            overrides: {'name': '停用租户', 'status': 'suspended'},
          ),
        ]),
      ),
    );
    await pumpList(tester, dio);
    await tester.tap(find.widgetWithText(FilterChip, '停用'));
    await tester.pumpAndSettle();
    expect(find.text('停用租户'), findsOneWidget);
    expect(find.text('示例租户'), findsNothing);
    await tester.tap(find.widgetWithText(FilterChip, '全部'));
    await tester.pumpAndSettle();
    expect(find.text('示例租户'), findsOneWidget);
    expect(find.text('停用租户'), findsOneWidget);
  });

  testWidgets('空列表 Empty 态', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(200, tenantListJson(const [])),
    );
    await pumpList(tester, dio);
    expect(find.text('暂无租户'), findsOneWidget);
  });

  testWidgets('网络不可达 → 「无法连接服务器」', (tester) async {
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
    dio.httpClientAdapter = ThrowingAdapter();
    await pumpList(tester, dio);
    expect(find.text('无法连接服务器'), findsOneWidget);
  });

  testWidgets('403（非平台 admin）→ 「加载失败，请重试」不崩栈', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(403, <String, dynamic>{'message': 'forbidden'}),
    );
    await pumpList(tester, dio);
    expect(find.text('加载失败，请重试'), findsOneWidget);
  });
}
