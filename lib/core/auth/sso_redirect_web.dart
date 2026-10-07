import 'dart:js_interop';

// web：整页跳回 RP（redirectUri?code=..&state=..）。
// dart:js_interop 为现行推荐面（dart:html 已弃用且触发
// avoid_web_libraries_in_flutter）；globalThis.location.assign 即整页跳转。
@JS('location')
external _JSLocation get _location;

extension type _JSLocation._(JSObject _) implements JSObject {
  external void assign(String url);
}

void redirectTo(String url) => _location.assign(url);
