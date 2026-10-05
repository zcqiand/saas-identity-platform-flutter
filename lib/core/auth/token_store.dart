/// token 存储缝：生产绑 SecureTokenStore（flutter_secure_storage），
/// 测试绑内存 fake——mock-friendly 铁律的存储面落地（lab-swift TokenStoring 先例）。
abstract class TokenStore {
  /// 两键名常量：生产与测试 fake 共用，杜绝键名漂移。
  static const String accessKey = 'saas.accessToken';
  static const String refreshKey = 'saas.refreshToken';

  Future<String?> readAccessToken();
  Future<String?> readRefreshToken();
  Future<void> save({
    required String accessToken,
    required String refreshToken,
  });
  Future<void> clear();
}
