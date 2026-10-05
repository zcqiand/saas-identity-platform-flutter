import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:saas_identity_platform_flutter/core/api/auth_interceptor.dart';
import 'package:saas_identity_platform_flutter/core/api/session_guard.dart';
import 'package:saas_identity_platform_flutter/core/auth/auth_controller.dart';
import 'package:saas_identity_platform_flutter/core/auth/auth_state.dart';
import 'package:saas_identity_platform_flutter/core/auth/providers.dart';

import '../../fakes/in_memory_token_store.dart';

/// 测试装配：恒定 overrides + DioAdapter dio。用例里经 adapter 挂路由。
(ProviderContainer, DioAdapter, InMemoryTokenStore, SessionGuard) _rig() {
  final store = InMemoryTokenStore();
  final guard = SessionGuard();
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
  // 401 缝用例证明的是「拦截器→guard→controller」整条接线：dio 须按生产
  // buildDio 同款挂上真 AuthInterceptor（裸 Dio 的 401 没人 fire guard），
  // 读写都指向本 rig 的 store/guard 实例（与 provider overrides 同源）。
  dio.interceptors.add(
    AuthInterceptor(readAccessToken: store.readAccessToken, guard: guard),
  );
  // 0.6.1 构造签名：DioAdapter({required this.dio})，构造体内自绑 httpClientAdapter。
  // matcher 换 UrlRequestMatcher：默认 FullHttpRequestMatcher 对带体请求要求
  // 注册时给 data 匹配器（无 data 的路由不匹配任何带体请求），路由匹配已覆盖用例意图。
  final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
  final container = ProviderContainer(
    overrides: [
      dioProvider.overrideWithValue(dio),
      tokenStoreProvider.overrideWithValue(store),
      sessionGuardProvider.overrideWithValue(guard),
      appConfigClientIdProvider.overrideWithValue('saas-console'),
    ],
  );
  return (container, adapter, store, guard);
}

const _okBody = <String, dynamic>{
  // user 须满足生成物 SysUser 必填面：id/username/status/createdAt/updatedAt。
  'user': {
    'id': 'u-1',
    'username': 'alice',
    'status': 'active',
    'createdAt': '2026-01-01T00:00:00Z',
    'updatedAt': '2026-01-01T00:00:00Z',
  },
  'availableTenants': <dynamic>[],
  'userId': 'u-1',
  'currentTenantId': null,
  'accessToken': 'at-1',
  'refreshToken': 'rt-1',
  'tokenType': 'Bearer',
  'expiresIn': 3600,
  'clientId': 'saas-console',
};

Future<void> _loginAndSettle(ProviderContainer c, DioAdapter a) async {
  a.onPost('/api/v1/auth/login', (server) => server.reply(200, _okBody));
  c.read(authControllerProvider); // 挂载即触发 restore 微任务 + guard 接线
  await pumpEventQueue(); // restore 落 Anonymous（riverpod 3：read 前无元素可 pump）
  await c.read(authControllerProvider.notifier).login('alice', 'dev123456');
}

void main() {
  test('受保护请求 401 → guard 接线生效：清 store + 回 anonymous（RF#3）', () async {
    // 步骤：登录成功 → 再发一个受保护请求吃 401 → 断言会话已清。
    final (container, adapter, store, _) = _rig();
    addTearDown(container.dispose);
    await _loginAndSettle(container, adapter);
    expect(container.read(authControllerProvider), const Authed(userId: 'u-1'));
    adapter.onGet(
      '/api/v1/me',
      (server) =>
          server.reply(401, {'code': 'UNAUTHORIZED', 'message': 'expired'}),
    );
    await expectLater(
      container.read(dioProvider).get<dynamic>('/api/v1/me'),
      throwsA(isA<DioException>()),
    );
    await pumpEventQueue(); // guard.fire() 的 sessionExpired Future 排干
    expect(container.read(authControllerProvider), const AuthAnonymous());
    expect(await store.readAccessToken(), isNull);
  });

  test('登录成功→登出：本地清必达 + 回 anonymous', () async {
    // fn: M01.F04.I06
    final (container, adapter, store, _) = _rig();
    addTearDown(container.dispose);
    await _loginAndSettle(container, adapter);
    adapter.onPost('/api/v1/auth/logout', (server) => server.reply(204, null));
    await container.read(authControllerProvider.notifier).logout();
    expect(container.read(authControllerProvider), const AuthAnonymous());
    expect(await store.readAccessToken(), isNull);
    expect(await store.readRefreshToken(), isNull);
  });

  test('登出服务端 500 仍本地清必达（RF#4）', () async {
    // fn: M01.F04.I06
    final (container, adapter, store, _) = _rig();
    addTearDown(container.dispose);
    await _loginAndSettle(container, adapter);
    adapter.onPost(
      '/api/v1/auth/logout',
      (server) => server.reply(500, {'code': 'INTERNAL', 'message': 'boom'}),
    );
    await container.read(authControllerProvider.notifier).logout();
    expect(container.read(authControllerProvider), const AuthAnonymous());
    expect(await store.readAccessToken(), isNull);
    expect(await store.readRefreshToken(), isNull);
  });
}
