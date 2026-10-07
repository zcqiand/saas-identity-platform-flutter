/// 应用订阅状态中文映射（M00.F05）：status 是 int 三值（后端
/// normalizeStatus 口径：0=pending / 1=active / 2=disabled）。
/// 其他值 throw——禁静默回退（role_status_label 同源纪律）。
String applicationStatusLabel(int status) => switch (status) {
  0 => '待生效',
  1 => '已启用',
  2 => '已停用',
  _ => throw ArgumentError('未知的应用订阅状态: $status'),
};
