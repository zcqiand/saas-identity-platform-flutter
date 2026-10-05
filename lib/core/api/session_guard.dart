/// 401 会话失效回调持有器：controller 依赖 ApiClient 发请求，拦截器 401 时
/// 需回调 controller——经此持有器转手，两侧互不 import。无 handler 时 no-op。
class SessionGuard {
  void Function()? onUnauthorized;
  void fire() => onUnauthorized?.call();
}
