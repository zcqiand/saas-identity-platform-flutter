import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/members/member_form_dialog.dart';
import 'package:saas_identity_platform_flutter/features/members/member_invite_dialog.dart';
import 'package:saas_identity_platform_flutter/features/members/member_list_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// M00.F02 租户成员切片（REQ-2026-004）。
/// 同路径多方法（/members 上 GET 列表 + POST 创建）折单 handler 按
/// options.method 分流（UrlRequestMatcher 不比 method，tenant_crud 实证）。
/// 测试名保持声明单行（trace_cmd 逐行扫描，dart format 折行 = 锚失效）。
void main() {
  Future<void> pumpMembers(WidgetTester tester, Dio dio) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const MaterialApp(home: MemberListPage(tenantId: 't-1')),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('成员列表：page=0&pageSize=50 + 行渲染（I01 证明）', (tester) async {
    var path = '';
    var query = <String, dynamic>{};
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, (RequestOptions options) {
        path = options.uri.path;
        query = options.queryParameters;
        return memberListJson([memberJson()]);
      });
    });
    await pumpMembers(tester, dio);
    expect(path, '/api/v1/tenants/t-1/members');
    expect(query['page'], '0');
    expect(query['pageSize'], '50');
    expect(find.text('user-u-1'), findsOneWidget);
    expect(find.text('u-1@example.com'), findsOneWidget);
    expect(find.text('启用'), findsWidgets);
  });

  testWidgets('FAB 创建成员：POST body 恰四字段 + 收窗回刷（I02 证明）', (tester) async {
    CreateSysUserRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          captured = standardSerializers.deserializeWith(
            CreateSysUserRequest.serializer,
            options.data as Map<String, dynamic>,
          )!;
          return memberJson(id: 'u-new');
        }
        return memberListJson([memberJson()]);
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.byTooltip('新建成员'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '用户名'), 'bob');
    await tester.enterText(find.widgetWithText(TextField, '密码'), 'secret123');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.username, 'bob');
    expect(captured!.password, 'secret123');
    expect(captured!.email, isNull); // 选填留空不随 body
    expect(captured!.mobile, isNull);
    expect(find.byType(MemberFormDialog), findsNothing);
    expect(find.text('创建成功'), findsOneWidget);
  });

  testWidgets('创建必填缺失：fail-fast 不发请求', (tester) async {
    var writeCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, (RequestOptions options) {
        if (options.method == 'POST') {
          writeCalls++;
          return memberJson();
        }
        return memberListJson([memberJson()]);
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.byTooltip('新建成员'));
    await tester.pumpAndSettle();
    // 只填用户名，密码留空 → fail-fast
    await tester.enterText(find.widgetWithText(TextField, '用户名'), 'bob');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('请完整填写用户名与密码'), findsOneWidget);
    expect(writeCalls, 0);
    expect(find.byType(MemberFormDialog), findsOneWidget);
  });

  testWidgets('创建失败 500：弹窗留窗保输入', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson()]));
    });
    await pumpMembers(tester, dio);
    adapter.onPost(
      '/api/v1/tenants/t-1/members',
      (server) => server.reply(500, <String, dynamic>{'message': 'boom'}),
    );
    await tester.tap(find.byTooltip('新建成员'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '用户名'), 'bob');
    await tester.enterText(find.widgetWithText(TextField, '密码'), 'secret123');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('保存失败，请重试'), findsOneWidget);
    expect(find.byType(MemberFormDialog), findsOneWidget);
  });

  testWidgets('行进详情：八字段卡（I03 证明）', (tester) async {
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson()]));
    });
    adapter.onGet('/api/v1/tenants/t-1/members/u-1', (server) {
      server.reply(200, memberJson());
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.text('user-u-1'));
    await tester.pumpAndSettle();
    // 八字段卡：id/tenantId/username/email/status/roleIds/createdAt/updatedAt
    expect(find.text('user-u-1'), findsWidgets);
    expect(find.text('u-1@example.com'), findsOneWidget);
    expect(find.text('u-1'), findsOneWidget);
    expect(find.text('t-1'), findsOneWidget);
    expect(find.textContaining('r-1'), findsWidgets);
  });

  testWidgets('行编辑：PUT body 恰 email/mobile（I04 证明）', (tester) async {
    UpdateSysUserRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson()]));
    });
    adapter.onPut('/api/v1/tenants/t-1/members/u-1', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          UpdateSysUserRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return memberJson();
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.byTooltip('编辑'));
    await tester.pumpAndSettle();
    // 回填：邮箱预填既有值
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, '邮箱'))
          .controller!
          .text,
      'u-1@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextField, '邮箱'),
      'new@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextField, '手机号'),
      '13800000000',
    );
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.email, 'new@example.com');
    expect(captured!.mobile, '13800000000');
    expect(find.byType(MemberFormDialog), findsNothing);
  });

  testWidgets('行删除：确认文案 + DELETE + 回刷（I05 证明）', (tester) async {
    var deleteCalls = 0;
    var getCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, (RequestOptions options) {
        getCalls++;
        return memberListJson([memberJson()]);
      });
    });
    adapter.onDelete('/api/v1/tenants/t-1/members/u-1', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpMembers(tester, dio);
    expect(getCalls, 1);
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    // 确认弹窗明示「不删除全局用户」语义（树 I05 行文）
    expect(find.textContaining('不删除全局用户'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '删除'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 1);
    expect(find.text('删除成功'), findsOneWidget);
    expect(getCalls, 2); // silent 回刷
  });

  testWidgets('删除取消：零请求', (tester) async {
    var deleteCalls = 0;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson()]));
    });
    adapter.onDelete('/api/v1/tenants/t-1/members/u-1', (server) {
      server.reply(204, (RequestOptions options) {
        deleteCalls++;
        return null;
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.byTooltip('删除'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '取消'));
    await tester.pumpAndSettle();
    expect(deleteCalls, 0);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('appbar 邀请：POST invitations body 恰两字段（I06 证明）', (tester) async {
    TenantMembersInviteTenantUserRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson()]));
    });
    adapter.onPost('/api/v1/tenants/t-1/members/invitations', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          TenantMembersInviteTenantUserRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return inviteViewJson();
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.byTooltip('邀请成员'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, '邮箱'),
      'inv@example.com',
    );
    await tester.tap(find.widgetWithText(FilledButton, '发送邀请'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.email, 'inv@example.com');
    expect(captured!.mobile, isNull);
    expect(find.byType(MemberInviteDialog), findsNothing);
    expect(find.text('邀请已发送'), findsOneWidget);
  });

  testWidgets('行状态动作：停用 POST /status body（I08 证明）', (tester) async {
    TenantMembersChangeTenantUserStatusRequest? captured;
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson()]));
    });
    adapter.onPost('/api/v1/tenants/t-1/members/u-1/status', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          TenantMembersChangeTenantUserStatusRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return memberJson(overrides: {'status': 'suspended'});
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.byTooltip('停用'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.status, TenantMemberStatus.suspended);
    // 回刷后徽标呈停用
    expect(find.text('停用'), findsWidgets);
  });

  testWidgets('状态 chip 过滤：status 参数随请求', (tester) async {
    var query = <String, dynamic>{};
    final (dio, adapter) = tenantRig();
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, (RequestOptions options) {
        query = options.queryParameters;
        return memberListJson([memberJson()]);
      });
    });
    await pumpMembers(tester, dio);
    await tester.tap(find.widgetWithText(FilterChip, '停用'));
    await tester.pumpAndSettle();
    expect(query['status'], 'suspended');
  });
}
