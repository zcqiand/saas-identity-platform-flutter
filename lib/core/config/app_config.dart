/// 应用运行配置：全部经 `--dart-define` 注入，缺一即 fail-fast（suite 硬规则 §1）。
///
/// `String.fromEnvironment` 在缺失时返回**空串**——不能当默认值用；
/// 这里显式断言拦截，启动即崩并给出修复提示。
class AppConfig {
  AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// 启动校验入口：main() 第一行调用。
  static void validate() => validateBaseUrl(apiBaseUrl);

  /// 纯函数化便于测试（不依赖编译期常量，任何环境下行为确定）。
  static void validateBaseUrl(String url) {
    if (url.isEmpty) {
      throw StateError(
        'API_BASE_URL 未注入：用 --dart-define=API_BASE_URL=<url> 传入。'
        '取值表见 docs/conventions/flutter-app.md'
        '（web: http://localhost:<后端槽位>；Android 模拟器: http://10.0.2.2:<槽位>）',
      );
    }
  }
}
