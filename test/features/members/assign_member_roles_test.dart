import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/features/members/assign_member_roles_dialog.dart';
import 'package:saas_identity_platform_flutter/features/members/member_list_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../support/tenant_fixtures.dart';

/// REQ-2026-008 M01.F02.I01 分配角色：member↔role 关系面（与 M00.F02
/// 字段维护不同维度）。PUT full-replace，空选=合法清空。
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

  void stubMembers(DioAdapter adapter) {
    adapter.onGet('/api/v1/tenants/t-1/members', (server) {
      server.reply(200, memberListJson([memberJson(id: 'u-1')]));
    });
  }

  void stubRoles(DioAdapter adapter) {
    adapter.onGet('/api/v1/tenants/t-1/roles', (server) {
      server.reply(
        200,
        roleListJson([roleJson(id: 'r-1'), roleJson(id: 'r-2')]),
      );
    });
  }

  testWidgets('分配角色：预勾 member.roleIds + PUT body 全量覆盖（F02.I01 证明）', (
    tester,
  ) async {
    // fn: M01.F02.I01
    SetTenantMemberRolesRequest? captured;
    final (dio, adapter) = tenantRig();
    stubMembers(adapter);
    stubRoles(adapter);
    await pumpMembers(tester, dio);
    adapter.onPut('/api/v1/tenants/t-1/members/u-1/roles', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          SetTenantMemberRolesRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return memberJson(id: 'u-1');
      });
    });
    await tester.tap(find.byTooltip('角色'));
    await tester.pumpAndSettle();
    // 预勾：member.roleIds=['r-1'] → r-1 勾选、r-2 未勾
    expect(
      tester
          .widget<CheckboxListTile>(
            find.widgetWithText(CheckboxListTile, '角色-r-1'),
          )
          .value,
      isTrue,
    );
    expect(
      tester
          .widget<CheckboxListTile>(
            find.widgetWithText(CheckboxListTile, '角色-r-2'),
          )
          .value,
      isFalse,
    );
    await tester.tap(find.text('角色-r-2'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured, isNotNull);
    expect(captured!.roleIds.toList(), <String>['r-1', 'r-2']); // 全量覆盖
    expect(find.byType(AssignMemberRolesDialog), findsNothing);
    expect(find.text('角色已更新'), findsOneWidget);
  });

  testWidgets('分配角色空选=合法清空：PUT roleIds 空', (tester) async {
    SetTenantMemberRolesRequest? captured;
    final (dio, adapter) = tenantRig();
    stubMembers(adapter);
    stubRoles(adapter);
    await pumpMembers(tester, dio);
    adapter.onPut('/api/v1/tenants/t-1/members/u-1/roles', (server) {
      server.reply(200, (RequestOptions options) {
        captured = standardSerializers.deserializeWith(
          SetTenantMemberRolesRequest.serializer,
          options.data as Map<String, dynamic>,
        )!;
        return memberJson(id: 'u-1');
      });
    });
    await tester.tap(find.byTooltip('角色'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('角色-r-1')); // 取消唯一勾选
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(captured!.roleIds.toList(), <String>[]);
    expect(find.text('角色已更新'), findsOneWidget);
  });

  testWidgets('分配角色失败 500：弹窗留窗保勾选', (tester) async {
    final (dio, adapter) = tenantRig();
    stubMembers(adapter);
    stubRoles(adapter);
    await pumpMembers(tester, dio);
    adapter.onPut('/api/v1/tenants/t-1/members/u-1/roles', (server) {
      server.reply(500, <String, dynamic>{'message': 'boom'});
    });
    await tester.tap(find.byTooltip('角色'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();
    expect(find.text('保存失败，请重试'), findsOneWidget);
    expect(find.byType(AssignMemberRolesDialog), findsOneWidget);
  });
}
