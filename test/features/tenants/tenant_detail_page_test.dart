import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/tenants/tenant_detail_page.dart';
import 'package:saas_identity_platform_flutter/features/tenants/tenants_list_page.dart';

import '../../fakes/throwing_adapter.dart';
import '../../support/tenant_fixtures.dart';

void main() {
  Future<void> pumpDetail(
    WidgetTester tester,
    Dio dio, {
    required String tenantId,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: MaterialApp(home: TenantDetailPage(tenantId: tenantId)),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('两租户 id 交叉：详情请求 path 带正确 id + 六字段卡（@entry I03 证明）', (
    tester,
  ) async {
    // fn: M00.F01.I03
    final paths = <String>[];
    final (dio, adapter) = tenantRig();
    // 精确双注册（0.6.1 的 ** 通配不命中）：各自回各自 fixture——
    // 若详情请求错带 id，字段断言即失败，交叉身份由 path+数据双证。
    adapter.onGet('/api/v1/admin/tenants/t-2', (server) {
      server.reply(200, (RequestOptions options) {
        paths.add(options.uri.path);
        return tenantJson(
          id: 't-2',
          overrides: {'name': '停用租户', 'status': 'suspended'},
        );
      });
    });
    adapter.onGet('/api/v1/admin/tenants/t-1', (server) {
      server.reply(200, (RequestOptions options) {
        paths.add(options.uri.path);
        return tenantJson(id: 't-1');
      });
    });
    // 交叉一：t-2（suspended）
    await pumpDetail(tester, dio, tenantId: 't-2');
    expect(paths.single, '/api/v1/admin/tenants/t-2');
    // appbar 标题 + 卡片头各渲染一次租户名
    expect(find.text('停用租户'), findsNWidgets(2));
    expect(find.text('tenant-t-2'), findsOneWidget);
    expect(find.text('停用'), findsOneWidget);
    expect(find.textContaining('2026-10-06'), findsNWidgets(2)); // 创建/更新时间

    // 交叉二：t-1（active）——详情身份随路由参数，不带上一单残留
    await tester.pumpWidget(const SizedBox.shrink());
    await pumpDetail(tester, dio, tenantId: 't-1');
    expect(paths.last, '/api/v1/admin/tenants/t-1');
    expect(find.text('示例租户'), findsNWidgets(2));
  });

  testWidgets('suspended 租户详情状态徽标「停用」', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants/t-2',
      (server) => server.reply(
        200,
        tenantJson(
          id: 't-2',
          overrides: {'name': '停用租户', 'status': 'suspended'},
        ),
      ),
    );
    await pumpDetail(tester, dio, tenantId: 't-2');
    expect(find.text('停用'), findsOneWidget);
  });

  testWidgets('网络不可达 → 「无法连接服务器」+ 重试', (tester) async {
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
    dio.httpClientAdapter = ThrowingAdapter();
    await pumpDetail(tester, dio, tenantId: 't-1');
    expect(find.text('无法连接服务器'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
  });

  testWidgets('404 → 「加载失败，请重试」', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants/t-x',
      (server) => server.reply(404, <String, dynamic>{'message': 'nf'}),
    );
    await pumpDetail(tester, dio, tenantId: 't-x');
    expect(find.text('加载失败，请重试'), findsOneWidget);
  });

  testWidgets('列表行 tap → TenantDetailPage 入栈（onTap 接线）', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet(
      '/api/v1/admin/tenants',
      (server) => server.reply(200, tenantListJson([tenantJson(id: 't-1')])),
    );
    adapter.onGet(
      '/api/v1/admin/tenants/t-1',
      (server) => server.reply(200, tenantJson(id: 't-1')),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: TenantsListPage()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('示例租户'));
    await tester.pumpAndSettle();
    expect(find.byType(TenantDetailPage), findsOneWidget);
    expect(find.text('tenant-t-1'), findsOneWidget); // 详情字段上屏
  });
}
