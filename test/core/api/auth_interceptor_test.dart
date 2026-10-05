import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:saas_identity_platform_flutter/core/api/api_client.dart';
import 'package:saas_identity_platform_flutter/core/api/auth_interceptor.dart';
import 'package:saas_identity_platform_flutter/core/api/session_guard.dart';

void main() {
  late SessionGuard guard;
  late Dio dio;
  late DioAdapter adapter;
  var fired = 0;

  setUp(() {
    guard = SessionGuard();
    fired = 0;
    guard.onUnauthorized = () => fired++;
    dio = buildDio(
      baseUrl: 'http://localhost:5101',
      interceptor: AuthInterceptor(
        readAccessToken: () async => null,
        guard: guard,
      ),
    );
    // 0.6.1 构造签名：DioAdapter({required this.dio})，构造体内自绑 httpClientAdapter。
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
  });

  test('无 token 时请求不带 Authorization 头', () async {
    Object? captured;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        captured = options.headers['Authorization'];
        handler.next(options);
      },
    ));
    adapter.onGet('/api/v1/ping', (server) => server.reply(200, {'ok': 1}));
    await dio.get<dynamic>('/api/v1/ping');
    expect(captured, isNull);
  });

  test('有 token 时请求带 Bearer 头', () async {
    Object? captured;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        captured = options.headers['Authorization'];
        handler.next(options);
      },
    ));
    // 换一个带 token 读取的拦截器实例。
    dio.interceptors[0] = AuthInterceptor(
      readAccessToken: () async => 'tok-1',
      guard: guard,
    );
    adapter.onGet('/api/v1/ping', (server) => server.reply(200, {'ok': 1}));
    await dio.get<dynamic>('/api/v1/ping');
    expect(captured, 'Bearer tok-1');
  });

  test('受保护请求 401 触发 guard.fire', () async {
    adapter.onGet('/api/v1/tenants', (server) => server.reply(401, {
          'code': 'UNAUTHORIZED',
          'message': 'token expired',
        }));
    await expectLater(
      dio.get<dynamic>('/api/v1/tenants'),
      throwsA(isA<DioException>().having(
        (e) => e.response?.statusCode, 'status', 401,
      )),
    );
    expect(fired, 1);
  });

  test('auth 端点自身 401 不触发 guard（react 先例）', () async {
    adapter.onPost('/api/v1/auth/login', (server) => server.reply(401, {
          'code': 'BAD_CREDENTIALS',
          'message': '用户名或密码错误',
        }));
    await expectLater(
      dio.post<dynamic>('/api/v1/auth/login'),
      throwsA(isA<DioException>()),
    );
    expect(fired, 0);
  });

  test('SessionGuard 无 handler 时 fire() no-op', () async {
    final bare = SessionGuard();
    expect(bare.onUnauthorized, isNull);
    bare.fire(); // 不抛即通过
  });

  test('token 读失败不挂死——无头继续请求', () async {
    Object? captured;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        captured = options.headers['Authorization'];
        handler.next(options);
      },
    ));
    dio.interceptors[0] = AuthInterceptor(
      readAccessToken: () async => throw StateError('storage boom'),
      guard: guard,
    );
    adapter.onGet('/api/v1/ping', (server) => server.reply(200, {'ok': 1}));
    await dio.get<dynamic>('/api/v1/ping'); // 完成即通过（不挂起）
    expect(captured, isNull);
  });
}
