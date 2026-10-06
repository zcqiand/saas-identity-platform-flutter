import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../../core/auth/providers.dart';

/// M00.F01 租户 API provider。dioProvider 复用 Phase 1 装配
/// （core/auth/providers.dart：buildDio + AuthInterceptor + 401 缝），
/// 此处仅挂生成物 AdminTenantsApi（API 面只认生成物，suite 硬规则 §4）。
final adminTenantsApiProvider = Provider<AdminTenantsApi>(
  (ref) => AdminTenantsApi(ref.watch(dioProvider), standardSerializers),
);
