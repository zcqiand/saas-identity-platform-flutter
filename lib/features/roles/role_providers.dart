import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// 角色域 API 供给（member_providers 同构）。
final roleApiProvider = Provider<TenantRolesApi>(
  (ref) => TenantRolesApi(ref.watch(dioProvider), standardSerializers),
);
