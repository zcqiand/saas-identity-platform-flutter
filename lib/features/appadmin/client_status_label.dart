/// status int → 中文（家族 smallint 约定 1=启用/0=停用，REQ-2026-010）。
/// 非 EnumClass（int 直传），穷尽 0/1 + 其他 throw 与枚举 label 同款纪律。
String clientStatusLabel(int status) => switch (status) {
  1 => '启用',
  0 => '停用',
  _ => throw ArgumentError('未知 OAuthClient status: $status'),
};
