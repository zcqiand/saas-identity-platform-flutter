import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// TenantMemberStatus → 中文标签（契约恰四值，EnumClass 非 sealed：
/// 漏一值时测试先红，未知枚举值 fail-fast——禁静默回退，tenantStatusLabel 同款）。
String memberStatusLabel(TenantMemberStatus status) {
  return switch (status) {
    TenantMemberStatus.active => '启用',
    TenantMemberStatus.invited => '已邀请',
    TenantMemberStatus.suspended => '停用',
    TenantMemberStatus.disabled => '禁用',
    _ => throw ArgumentError('未知 TenantMemberStatus: ${status.name}'),
  };
}
