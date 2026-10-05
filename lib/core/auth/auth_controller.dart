import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'auth_state.dart';
import 'providers.dart';
import 'token_store.dart';

/// 认证状态机（riverpod Notifier）。
/// - login：submitting 门（防并发）→ sessionsLogin → token 非空校验 → save → Authed
/// - 四分支错误映射：423 锁定 / 401 错凭据 / 网络不可达 / 响应缺令牌
/// - restore：accessToken 非空 → Authed（无 whoami，userId 空）；空 → Anonymous
/// - sessionExpired：清 store + 回 anonymous（401 缝回调）
/// - logout：best-effort 通知 + 本地清必达
class AuthController extends Notifier<AuthState> {
  late final AuthApi _api;
  late final TokenStore _store;
  late final String _clientId;

  @override
  AuthState build() {
    _api = ref.watch(authApiProvider);
    _store = ref.watch(tokenStoreProvider);
    _clientId = ref.watch(appConfigClientIdProvider);

    final guard = ref.watch(sessionGuardProvider);
    guard.onUnauthorized = sessionExpired;
    ref.onDispose(() => guard.onUnauthorized = null);

    Future.microtask(() async {
      final token = await _store.readAccessToken();
      if (state is AuthRestoring) {
        state = (token != null && token.isNotEmpty)
            ? const Authed()
            : const AuthAnonymous();
      }
    });
    return const AuthRestoring();
  }

  /// 密码登录（M01.F04.I01）。submitting 期间再调用是 no-op（RF#1）。
  Future<void> login(String username, String password) async {
    if (state is AuthSubmitting) return;
    state = const AuthSubmitting();
    final request = LoginRequest(
      (b) => b
        ..username = username
        ..password = password
        ..clientId = _clientId,
    );
    try {
      final response = await _api.sessionsLogin(loginRequest: request);
      final body = response.data;
      final access = body?.accessToken;
      final refresh = body?.refreshToken;
      if (body == null ||
          access == null ||
          access.isEmpty ||
          refresh == null ||
          refresh.isEmpty) {
        state = const AuthFailed('登录失败：服务端响应缺少令牌');
        return;
      }
      await _store.save(accessToken: access, refreshToken: refresh);
      state = Authed(
        userId: body.userId,
        currentTenantId: body.currentTenantId,
      );
    } on DioException catch (e) {
      state = AuthFailed(_message(e));
    } catch (_) {
      state = const AuthFailed('无法连接服务器');
    }
  }

  /// 登出（M01.F04.I06）：服务端尽力通知，本地清空必达（lab-swift 先例）。
  Future<void> logout() async {
    try {
      await _api.sessionsLogout();
    } catch (_) {
      // best-effort：服务端失败不阻断本地清理。
    }
    await _store.clear();
    state = const AuthAnonymous();
  }

  /// 401 缝回调（SessionGuard.fire）：清 store + 回 anonymous。
  Future<void> sessionExpired() async {
    await _store.clear();
    if (state is! AuthAnonymous) state = const AuthAnonymous();
  }

  static String _message(DioException e) {
    final status = e.response?.statusCode;
    if (status == 423) return '账号已被锁定，请稍后再试';
    if (status == 401) return '用户名或密码错误';
    return '无法连接服务器';
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
