// 浏览器重定向（web → dart:js_interop；VM/stub 为 no-op）。
// 条件导入：测试（VM）落 stub，生产 web 落 _web。
export 'sso_redirect_stub.dart'
    if (dart.library.js_interop) 'sso_redirect_web.dart';
