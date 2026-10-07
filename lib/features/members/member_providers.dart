import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../core/auth/providers.dart';

/// M00.F02 成员 API provider（adminTenantsApiProvider 同构：dioProvider 复用
/// Phase 1 装配，此处仅挂生成物 TenantMembersApi——API 面只认生成物，硬规则 §4）。
final tenantMembersApiProvider = Provider<TenantMembersApi>(
  (ref) => TenantMembersApi(ref.watch(dioProvider), standardSerializers),
);
