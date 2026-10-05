import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:saas_identity_platform_flutter/core/api/session_guard.dart';
import 'package:saas_identity_platform_flutter/core/auth/auth_controller.dart';
import 'package:saas_identity_platform_flutter/core/auth/auth_state.dart';
import 'package:saas_identity_platform_flutter/core/auth/providers.dart';
import '../../fakes/in_memory_token_store.dart';
import '../../fakes/throwing_adapter.dart';

/// 测试装配：恒定 overrides + DioAdapter dio。用例里经 adapter.onPost 挂路由。
(ProviderContainer, DioAdapter, InMemoryTokenStore, SessionGuard) _rig() {
  final store = InMemoryTokenStore();
  final guard = SessionGuard();
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
  // 0.6.1 构造签名：DioAdapter({required this.dio})，构造体内自绑 httpClientAdapter。
  // matcher 换 UrlRequestMatcher：默认 FullHttpRequestMatcher 对带体请求要求
  // 注册时给 data 匹配器（无 data 的路由不匹配任何带体请求），路由匹配已覆盖用例意图。
  final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
  final container = ProviderContainer(overrides: [
    dioProvider.overrideWithValue(dio),
    tokenStoreProvider.overrideWithValue(store),
    sessionGuardProvider.overrideWithValue(guard),
    appConfigClientIdProvider.overrideWithValue('saas-console'),
  ]);
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

Future<AuthState> _settled(ProviderContainer c) async {
  c.read(authControllerProvider); // 挂载即触发 restore 微任务
  await pumpEventQueue(); // 等落地（riverpod 3：read 前无元素可 pump）
  return c.read(authControllerProvider);
}

void main() {
  test('restore：存储有 accessToken → Authed', () async {
    final (container, _, store, _) = _rig();
    addTearDown(container.dispose);
    await store.save(accessToken: 'at-1', refreshToken: 'rt-1');
    await _settled(container);
    expect(container.read(authControllerProvider), const Authed());
  });

  test('restore：存储空 → Anonymous', () async {
    final (container, _, _, _) = _rig();
    addTearDown(container.dispose);
    await _settled(container);
    expect(container.read(authControllerProvider), const AuthAnonymous());
  });

  test('restore：只剩 refreshToken（accessToken 空）→ Anonymous（RF#2）', () async {
    final (container, _, store, _) = _rig();
    addTearDown(container.dispose);
    store.debugOverwrite(accessToken: null, refreshToken: 'rt-1');
    await _settled(container);
    expect(container.read(authControllerProvider), const AuthAnonymous());
  });

  test('登录成功换 JWT 并持久化', () async {
    // fn: M01.F04.I01
    final (container, adapter, store, _) = _rig();
    addTearDown(container.dispose);
    adapter.onPost('/api/v1/auth/login', (server) => server.reply(200, _okBody));
    await _settled(container); // 先落 Anonymous
    await container.read(authControllerProvider.notifier).login('alice', 'dev123456');
    final state = container.read(authControllerProvider);
    expect(state, const Authed(userId: 'u-1', currentTenantId: null));
    expect(await store.readAccessToken(), 'at-1');
    expect(await store.readRefreshToken(), 'rt-1');
  });

  test('423 锁定 → failed 文案', () async {
    final (container, adapter, _, _) = _rig();
    addTearDown(container.dispose);
    adapter.onPost('/api/v1/auth/login', (server) => server.reply(423, {
          'code': 'ACCOUNT_LOCKED',
          'message': 'locked',
          'lockedUntil': '2026-10-05T00:00:00Z',
        }));
    await _settled(container);
    await container.read(authControllerProvider.notifier).login('alice', 'bad');
    expect(
      container.read(authControllerProvider),
      const AuthFailed('账号已被锁定，请稍后再试'),
    );
  });

  test('401 错凭据 → failed 文案（且不触发 guard）', () async {
    final (container, adapter, store, guard) = _rig();
    addTearDown(container.dispose);
    var fired = 0;
    guard.onUnauthorized = () => fired++;
    adapter.onPost('/api/v1/auth/login', (server) => server.reply(401, {
          'code': 'BAD_CREDENTIALS',
          'message': '用户名或密码错误',
        }));
    await _settled(container);
    await container.read(authControllerProvider.notifier).login('alice', 'bad');
    expect(container.read(authControllerProvider),
        const AuthFailed('用户名或密码错误'));
    expect(fired, 0); // auth 路径排除
    expect(await store.readAccessToken(), isNull);
  });

  test('网络不可达 → failed 文案', () async {
    final (container, _, _, _) = _rig();
    addTearDown(container.dispose);
    // 独立 dio：ThrowingAdapter 模拟连不上。
    final dio = container.read(dioProvider);
    dio.httpClientAdapter = ThrowingAdapter();
    await _settled(container);
    await container.read(authControllerProvider.notifier).login('alice', 'x');
    expect(container.read(authControllerProvider),
        const AuthFailed('无法连接服务器'));
  });

  test('submitting 期间重复 login 是 no-op（RF#1 状态机侧）', () async {
    final (container, adapter, _, _) = _rig();
    addTearDown(container.dispose);
    var calls = 0;
    adapter.onPost('/api/v1/auth/login', (server) {
      calls++;
      return server.reply(200, _okBody);
    });
    await _settled(container);
    final notifier = container.read(authControllerProvider.notifier);
    await Future.wait([notifier.login('a', 'b'), notifier.login('a', 'b')]);
    expect(calls, 1);
  });

  test('响应缺令牌（accessToken null）→ failed', () async {
    final (container, adapter, store, _) = _rig();
    addTearDown(container.dispose);
    final body = Map<String, dynamic>.of(_okBody)..['accessToken'] = null;
    adapter.onPost('/api/v1/auth/login', (server) => server.reply(200, body));
    await _settled(container);
    await container.read(authControllerProvider.notifier).login('alice', 'x');
    expect(container.read(authControllerProvider),
        const AuthFailed('登录失败：服务端响应缺少令牌'));
    expect(await store.readAccessToken(), isNull);
  });
}
