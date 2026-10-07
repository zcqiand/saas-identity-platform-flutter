// REQ-2026-011 M04.F04 菜单管理 flutter 侧：providers。
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// client-scoped 菜单管理 API（M04.F04）。
final clientMenusApiProvider = Provider<ClientMenusApi>(
  (ref) => ClientMenusApi(ref.watch(dioProvider), standardSerializers),
);
