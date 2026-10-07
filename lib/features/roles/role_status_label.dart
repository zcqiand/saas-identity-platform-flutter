/// 角色状态中文映射（M00.F03）：`sys_role.status` 是 smallint 非 enum
/// （生成面 `int get status`；DB `smallint().default(1)`，后端透传无转换）。
/// 1=启用 / 0=停用；其他值 throw——禁静默回退（ADR-0019 同源纪律）。
String roleStatusLabel(int status) => switch (status) {
  1 => '启用',
  0 => '停用',
  _ => throw ArgumentError('未知的角色状态: $status'),
};
