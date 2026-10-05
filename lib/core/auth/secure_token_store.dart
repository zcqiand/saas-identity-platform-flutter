import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'token_store.dart';

/// 生产实现：Android Keystore 级；Web 端 localStorage 级（与 react 参照同级，不夸大）。
class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readAccessToken() =>
      _storage.read(key: TokenStore.accessKey);

  @override
  Future<String?> readRefreshToken() =>
      _storage.read(key: TokenStore.refreshKey);

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: TokenStore.accessKey, value: accessToken);
    await _storage.write(key: TokenStore.refreshKey, value: refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: TokenStore.accessKey);
    await _storage.delete(key: TokenStore.refreshKey);
  }
}
