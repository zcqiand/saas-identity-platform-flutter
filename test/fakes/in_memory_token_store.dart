import 'package:saas_identity_platform_flutter/core/auth/token_store.dart';

/// 测试专用内存 fake：接口契约的确定性实现（键名与生产共用常量）。
class InMemoryTokenStore implements TokenStore {
  String? _accessToken;
  String? _refreshToken;

  /// 测试专用：构造「只剩 refreshToken」等非常规前置态（T5 restore 分支用）。
  void debugOverwrite({String? accessToken, String? refreshToken}) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  @override
  Future<String?> readAccessToken() async => _accessToken;

  @override
  Future<String?> readRefreshToken() async => _refreshToken;

  @override
  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  @override
  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
  }
}
