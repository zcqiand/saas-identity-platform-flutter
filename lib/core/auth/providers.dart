import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/core/config/app_config.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../api/api_client.dart';
import '../api/auth_interceptor.dart';
import '../api/session_guard.dart';
import 'secure_token_store.dart';
import 'token_store.dart';

/// provider 图：测试经 ProviderScope(overrides:[...]) 整体替换
/// （dioProvider/tokenStoreProvider/appConfigClientIdProvider 必 override）。

final sessionGuardProvider =
    Provider<SessionGuard>((ref) => SessionGuard());

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());

/// clientId 编译期常量的可测出口：测试 override 成 'saas-console'。
final appConfigClientIdProvider =
    Provider<String>((ref) => AppConfig.saasClientId);

final dioProvider = Provider<Dio>((ref) {
  return buildDio(
    baseUrl: AppConfig.apiBaseUrl,
    interceptor: AuthInterceptor(
      readAccessToken: ref.watch(tokenStoreProvider).readAccessToken,
      guard: ref.watch(sessionGuardProvider),
    ),
  );
});

final authApiProvider =
    Provider<AuthApi>((ref) => AuthApi(ref.watch(dioProvider), standardSerializers));
