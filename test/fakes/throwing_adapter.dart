import 'dart:typed_data';

import 'package:dio/dio.dart';

/// 测试专用：任何请求都抛连接错误（网络不可达分支用）。
class ThrowingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException.connectionError(
      requestOptions: options,
      reason: 'connection refused (test)',
    );
  }

  @override
  void close({bool force = false}) {}
}
