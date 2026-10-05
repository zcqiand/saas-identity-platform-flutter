import 'package:dio/dio.dart';

import 'auth_interceptor.dart';

/// dio 装配：BaseUrl + 拦截器链。超时给 dev 联调常用值，Phase 2 接真后端时再调。
Dio buildDio({required String baseUrl, required AuthInterceptor interceptor}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  dio.interceptors.add(interceptor);
  return dio;
}
