import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/appadmin/client_detail_page.dart';
import 'package:saas_identity_platform_flutter/features/appadmin/client_form_dialog.dart';
import 'package:saas_identity_platform_flutter/features/appadmin/client_list_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// REQ-2026-010 M04 应用管理第一片：应用维护（F01 六子项）+ 启用/停用
/// （F02.I01）。status int 1=启用/0=停用（家族 smallint 约定）；密钥
/// 创建侧自动生成、响应契约不回显。
void main() {
  Future<void> pumpAdmin(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: ClientListPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  void stubList(DioAdapter adapter, [List<Map<String, dynamic>>? items]) {
    adapter.onGet('/api/v1/admin/clients', (server) {
      server.reply(
        200,
        clientListJson(items ?? [clientJson(), clientJson(clientId: 'app-2')]),
      );
    });
  }

  testWidgets('应用列表：GET /api/v1/admin/clients + 行渲染名称/标识/状态徽标（F01.I01 证明）', (
    tester,
  ) async {
    // fn: M04.F01.I01
    var listPath = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/clients', (server) {
      server.reply(200, (RequestOptions options) {
        listPath = options.uri.path;
        return clientListJson([
          clientJson(),
          clientJson(clientId: 'app-2', overrides: {'status': 0}),
        ]);
      });
    });
    await pumpAdmin(tester, dio);
    expect(listPath, '/api/v1/admin/clients');
    expect(find.text('应用-app-1'), findsOneWidget);
    expect(find.text('应用-app-2'), findsOneWidget);
    expect(find.text('app-1'), findsWidgets); // 行副标题 + 徽标语义
    expect(find.text('app-2'), findsWidgets);
    expect(find.text('启用'), findsOneWidget); // status 1
    expect(find.text('停用'), findsOneWidget); // status 0
  });

  testWidgets('创建应用：POST 必填五件（密钥自动生成 sec- 前缀）+ 回刷（F01.I02 证明）', (
    tester,
  ) async {
    // fn: M04.F01.I02
    CreateOAuthClientRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpAdmin(tester, dio);
    adapter.onPost('/api/v1/admin/clients', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          CreateOAuthClientRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return clientJson(clientId: 'app-new');
      });
    });
    await tester.tap(find.byTooltip('新建应用'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '客户端标识'),
      'app-new',
    );
    await tester.enterText(find.widgetWithText(TextField, '应用名称'), '新应用');
    await tester.enterText(
      find.widgetWithText(TextField, '回调地址'),
      'https://lab.local/cb',
    );
    await tester.tap(find.widgetWithText(FilledButton, '创建'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.clientId, 'app-new');
    expect(captured!.clientName, '新应用');
    expect(captured!.clientSecret, startsWith('sec-')); // 表单侧自动生成
    expect(captured!.grantTypes, 'authorization_code,client_credentials');
    expect(captured!.redirectUris, 'https://lab.local/cb');
    expect(find.byType(ClientFormDialog), findsNothing);
    expect(find.text('应用已创建'), findsOneWidget);
  });

  testWidgets('应用详情：GET 单体 + 全字段渲染 + 密钥不回显（F01.I03 证明）', (
    tester,
  ) async {
    // fn: M04.F01.I03
    var detailPath = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/clients/app-1', (server) {
      server.reply(200, (RequestOptions options) {
        detailPath = options.uri.path;
        return clientJson();
      });
    });
    adapter.onGet('/api/v1/clients/app-1', (server) {
      server.reply(200, clientPublicJson());
    });
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: ClientDetailPage(clientId: 'app-1')),
      ),
    );
    await tester.pumpAndSettle();
    expect(detailPath, '/api/v1/admin/clients/app-1');
    expect(find.text('应用-app-1'), findsWidgets);
    expect(
      find.text('authorization_code,client_credentials'),
      findsOneWidget,
    );
    expect(find.text('https://lab.local/cb'), findsOneWidget);
    expect(find.text('lab.read'), findsOneWidget);
    expect(find.text('3600'), findsOneWidget); // accessTokenValidity
    expect(find.text('86400'), findsOneWidget); // refreshTokenValidity
    expect(find.text('密钥不回显'), findsOneWidget); // 契约不返明文
  });

  testWidgets('编辑应用：PUT body 名称/回调/scopes + 响应回填（F01.I04 证明）', (
    tester,
  ) async {
    // fn: M04.F01.I04
    UpdateOAuthClientRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpAdmin(tester, dio);
    adapter.onPut('/api/v1/admin/clients/app-1', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          UpdateOAuthClientRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return clientJson(
          overrides: {
            'clientName': '改名应用',
            'scopes': 'lab.read,lab.write',
          },
        );
      });
    });
    await tester.tap(find.byTooltip('编辑').first);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '应用名称'),
      '改名应用',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Scopes'),
      'lab.read,lab.write',
    );
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.clientName, '改名应用');
    expect(captured!.scopes, 'lab.read,lab.write');
    expect(captured!.status, isNull); // 启停走 F02.I01 独立端点，编辑不带
    expect(find.text('应用已更新'), findsOneWidget);
    expect(find.text('改名应用'), findsOneWidget); // PUT 响应回填，无重拉
  });

  testWidgets('删除应用：确认明示吊销语义 + DELETE + 回刷（F01.I05 证明）', (
    tester,
  ) async {
    // fn: M04.F01.I05
    var deletePath = '';
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpAdmin(tester, dio);
    adapter.onDelete('/api/v1/admin/clients/app-2', (server) {
      server.reply(200, (RequestOptions options) {
        deletePath = options.uri.path;
        return <void>;
      });
    });
    await tester.tap(find.byTooltip('删除').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('吊销'), findsOneWidget); // 确认文案明示吊销
    await tester.tap(find.widgetWithText(TextButton, '删除').last);
    await tester.pumpAndSettle();
    expect(deletePath, '/api/v1/admin/clients/app-2');
    expect(find.text('应用已删除'), findsOneWidget);
  });

  testWidgets('公共元数据：GET /api/v1/clients/{clientId} 匿名端点对照（F01.I06 证明）', (
    tester,
  ) async {
    // fn: M04.F01.I06
    var publicPath = '';
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/clients/app-1', (server) {
      server.reply(200, clientJson());
    });
    adapter.onGet('/api/v1/clients/app-1', (server) {
      server.reply(200, (RequestOptions options) {
        publicPath = options.uri.path;
        return clientPublicJson();
      });
    });
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: ClientDetailPage(clientId: 'app-1')),
      ),
    );
    await tester.pumpAndSettle();
    expect(publicPath, '/api/v1/clients/app-1');
    expect(find.text('公共元数据'), findsOneWidget);
    expect(find.text('应用-app-1'), findsWidgets); // 管理面 + 公共面同 clientId
  });

  testWidgets('启停应用：PUT status 0/1 行内即时翻转（F02.I01 证明）', (
    tester,
  ) async {
    // fn: M04.F02.I01
    AdminClientsSetClientStatusRequest? captured;
    final (dio, adapter) = tenantRig();
    stubList(adapter);
    await pumpAdmin(tester, dio);
    adapter.onPut('/api/v1/admin/clients/app-1/status', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          AdminClientsSetClientStatusRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return clientJson(overrides: {'status': 0});
      });
    });
    await tester.tap(find.byTooltip('停用').first);
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.status, 0); // 启用 → 停用
    expect(find.text('停用'), findsWidgets); // 徽标即时翻转（PUT 响应回填）
    expect(find.text('应用已停用'), findsOneWidget);
  });

  testWidgets('列表失败：错误态可重试', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/admin/clients', (server) {
      server.reply(500, <String, dynamic>{'message': 'boom'});
    });
    await pumpAdmin(tester, dio);
    expect(find.text('无法连接服务器'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
  });
}
