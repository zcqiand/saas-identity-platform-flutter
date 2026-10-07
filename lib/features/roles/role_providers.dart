import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// 角色域 API 供给（member_providers 同构）。
final roleApiProvider = Provider<TenantRolesApi>(
  (ref) => TenantRolesApi(ref.watch(dioProvider), standardSerializers),
);

/// 角色菜单授权 API（M00.F04；授权方法在独立 API 类，非 TenantRolesApi）。
final roleMenuGrantApiProvider = Provider<TenantRoleMenusApi>(
  (ref) => TenantRoleMenusApi(ref.watch(dioProvider), standardSerializers),
);

/// client 作用域菜单目录 API（授权页目录数据源）。
final clientMenusApiProvider = Provider<ClientMenusApi>(
  (ref) => ClientMenusApi(ref.watch(dioProvider), standardSerializers),
);
