import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// TenantStatus → 中文标签（G-11 契约恰两值，漏一值测试即红）。
String tenantStatusLabel(TenantStatus status) {
  return switch (status) {
    TenantStatus.active => '启用',
    TenantStatus.suspended => '停用',
    // EnumClass 非 sealed，编译器不认穷举：漏一值时测试先红，未知枚举值
    // fail-fast（禁静默回退，suite-hard-rules §1 同纪律；lab flowStatusLabel 同款）。
    _ => throw ArgumentError('未知 TenantStatus: ${status.name}'),
  };
}
