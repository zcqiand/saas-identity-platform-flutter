import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// 「我」域 API 供给（app_providers 同构）。
final meApiProvider = Provider<MeApi>(
  (ref) => MeApi(ref.watch(dioProvider), standardSerializers),
);
