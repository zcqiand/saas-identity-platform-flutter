import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

/// M00.F01 租户切片 fixtures（G-11 契约六字段口径，禁超面）。
/// 日期 ISO 8601 字符串（serializers 解码 DateTime，lab receipt_fixtures 同款）。
const _now = '2026-10-06T08:00:00Z';

Map<String, dynamic> tenantJson({
  String id = 't-1',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': id,
    'tenantKey': 'tenant-$id',
    'name': '示例租户',
    'status': 'active',
    'createdAt': _now,
    'updatedAt': _now,
  };
  return <String, dynamic>{...base, ...overrides};
}

Map<String, dynamic> tenantListJson(List<Map<String, dynamic>> items) =>
    <String, dynamic>{
      'items': items,
      'page': 1,
      'pageSize': 50,
      'total': items.length,
    };

/// M00.F02 成员切片 fixtures（TenantMemberUserView 八字段口径，禁超面）。
Map<String, dynamic> memberJson({
  String id = 'u-1',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': id,
    'tenantId': 't-1',
    'username': 'user-$id',
    'email': '$id@example.com',
    'status': 'active',
    'roleIds': <String>['r-1'],
    'createdAt': _now,
    'updatedAt': _now,
  };
  return <String, dynamic>{...base, ...overrides};
}

Map<String, dynamic> memberListJson(List<Map<String, dynamic>> items) =>
    <String, dynamic>{
      'items': items,
      'page': 0,
      'pageSize': 50,
      'total': items.length,
    };

/// 邀请响应 TenantMemberView{member, user, roles}（member/user 内嵌全字段）。
Map<String, dynamic> inviteViewJson() => <String, dynamic>{
  'member': {
    'id': 'm-inv',
    'tenantId': 't-1',
    'userId': 'u-inv',
    'memberName': null,
    'isOwner': false,
    'status': 'invited',
    'createdAt': _now,
    'updatedAt': _now,
  },
  'user': {
    'id': 'u-inv',
    'username': 'inv@example.com',
    'email': 'inv@example.com',
    'mobile': null,
    'status': 'invited',
    'failedAttempts': null,
    'lockedUntil': null,
    'createdAt': _now,
    'updatedAt': _now,
  },
  'roles': <String>[],
};

(Dio, DioAdapter) tenantRig() {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
  final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
  return (dio, adapter);
}

/// M00.F03 角色切片 fixtures（SysRole 十字段口径，status smallint 1/0）。
Map<String, dynamic> roleJson({
  String id = 'r-1',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': id,
    'tenantId': 't-1',
    'clientId': 'saas-console',
    'roleCode': 'code-$id',
    'roleName': '角色-$id',
    'description': 'desc-$id',
    'isPreset': false,
    'status': 1,
    'createdAt': _now,
    'updatedAt': _now,
  };
  return <String, dynamic>{...base, ...overrides};
}

Map<String, dynamic> roleListJson(List<Map<String, dynamic>> items) =>
    <String, dynamic>{
      'items': items,
      'page': 0,
      'pageSize': 50,
      'total': items.length,
    };

/// M00.F04 角色菜单授权切片 fixtures（SysMenu 目录 + RoleMenuGrant）。
Map<String, dynamic> menuJson({
  String id = 'm-1',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': id,
    'clientId': 'saas-console',
    // 根菜单 wire=零 UUID（后端 b.parentId ?? 0-uuid；契约 parentId 非空）
    'parentId': '00000000-0000-0000-0000-000000000000',
    'title': '菜单-$id',
    'type': 'menu',
    'path': '/$id',
    'component': null,
    'perms': null,
    'icon': null,
    'sortOrder': 0,
    'status': 1,
    'createdAt': _now,
  };
  return <String, dynamic>{...base, ...overrides};
}

Map<String, dynamic> roleGrantJson(List<String> menuIds) => <String, dynamic>{
  'roleId': 'r-1',
  'tenantId': 't-1',
  'menuIds': menuIds,
  'updatedAt': _now,
};

/// M00.F05 租户应用切片 fixtures（TenantApplication 六字段，status int
/// 0=pending/1=active/2=disabled；寻址键 clientId）。
Map<String, dynamic> appJson({
  String clientId = 'lab-management',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': 'ta-$clientId',
    'tenantId': 't-1',
    'clientId': clientId,
    'status': 1,
    'expireTime': null,
    'createdAt': _now,
  };
  return <String, dynamic>{...base, ...overrides};
}

Map<String, dynamic> appListJson(List<Map<String, dynamic>> items) =>
    <String, dynamic>{
      'items': items,
      'page': 0,
      'pageSize': 50,
      'total': items.length,
    };

/// REQ-2026-008 M01 切片 fixtures（生成物口径，禁超面）。
/// TenantMembership 六字段：id/userId/tenantId/roleIds/status(枚举)/joinedAt。
Map<String, dynamic> membershipJson({
  String tenantId = 't-1',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': 'm-$tenantId',
    'userId': 'u-1',
    'tenantId': tenantId,
    'roleIds': <String>['r-1'],
    'status': 'active',
    'joinedAt': '2026-06-01T00:00:00Z',
  };
  return <String, dynamic>{...base, ...overrides};
}

/// CurrentUser 四字段：id/email?/memberships/currentTenantId?（生成物无
/// displayName——树口径说明滞后，API 面只认生成物）。
Map<String, dynamic> currentUserJson({
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': 'u-1',
    'email': 'u-1@example.com',
    'memberships': <Map<String, dynamic>>[membershipJson()],
    'currentTenantId': 't-1',
  };
  return <String, dynamic>{...base, ...overrides};
}

/// SwitchTenantResponse 四字段（OAuth 态契约形状；UI 只消费成功事实）。
Map<String, dynamic> switchResponseJson({
  String tenantId = 't-2',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'accessToken': 'at-$tenantId',
    'refreshToken': 'rt-$tenantId',
    'expiresAt': '2027-01-01T00:00:00Z',
    'tenantId': tenantId,
  };
  return <String, dynamic>{...base, ...overrides};
}
