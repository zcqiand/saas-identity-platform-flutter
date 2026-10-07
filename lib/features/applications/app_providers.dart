import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// 应用域 API 供给（role_providers 同构）。
final tenantApplicationsApiProvider = Provider<TenantApplicationsApi>(
  (ref) => TenantApplicationsApi(ref.watch(dioProvider), standardSerializers),
);
