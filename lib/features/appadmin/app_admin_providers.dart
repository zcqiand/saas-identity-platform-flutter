// REQ-2026-010 M04 应用管理第一片：providers。
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// 平台 admin 应用管理 API（M04.F01/F02）。
final adminClientsApiProvider = Provider<AdminClientsApi>(
  (ref) => AdminClientsApi(ref.watch(dioProvider), standardSerializers),
);

/// 公共 client 元数据匿名端点（M04.F01.I06）。
final clientsApiProvider = Provider<ClientsApi>(
  (ref) => ClientsApi(ref.watch(dioProvider), standardSerializers),
);
