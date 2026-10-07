import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'providers.dart';
import 'sso_redirect.dart';

/// SSO 登录回跳参数（REQ-2026-012 M04.F03.I01）。RP 带来的 OAuth 查询参数；
/// [fromUri] conservative parse——全参齐且 responseType=code 才算 SSO，
/// 否则 null（回正常 console 登录，参数缺失不是本端错误）。
class SsoParams {
  const SsoParams({
    required this.clientId,
    required this.redirectUri,
    required this.state,
    this.scope = '',
  });

  final String clientId;
  final String redirectUri;
  final String state;
  final String scope;

  static SsoParams? fromUri(Uri uri) {
    final q = uri.queryParameters;
    final clientId = q['clientId'] ?? '';
    final redirectUri = q['redirectUri'] ?? '';
    final state = q['state'] ?? '';
    if (clientId.isEmpty || redirectUri.isEmpty || state.isEmpty) return null;
    if (q['responseType'] != 'code') return null;
    return SsoParams(
      clientId: clientId,
      redirectUri: redirectUri,
      state: state,
      scope: q['scope'] ?? '',
    );
  }

  AuthorizeCodeRequest toRequest() => AuthorizeCodeRequest(
    (b) => b
      ..clientId = clientId
      ..redirectUri = redirectUri
      ..responseType = AuthorizeCodeRequestResponseTypeEnum.code
      ..scope = scope.isEmpty ? null : scope
      ..state = state,
  );
}

/// 组回跳 URL：redirectUri 已带 query 用 & 追加（RFC 6749 §3.1.2），
/// code/state 走组件编码。
String buildSsoRedirectUrl(String redirectUri, String code, String state) {
  final sep = redirectUri.contains('?') ? '&' : '?';
  return '$redirectUri$sep'
      'code=${Uri.encodeQueryComponent(code)}'
      '&state=${Uri.encodeQueryComponent(state)}';
}

/// SSO 交接页：Authed 且 URL 带 SSO 参数时由 main 接管（restore 已登录
/// 用户带参进入也覆盖）。init → authorize 领一次性 code → 组 URL →
/// 浏览器跳回 RP。失败只给文案不重定向（错误归属 RP 重发起）。
class SsoHandoff extends ConsumerStatefulWidget {
  const SsoHandoff({super.key, required this.sso, this.onRedirect});

  final SsoParams sso;

  /// 测试注入口；生产缺省走条件导入的浏览器重定向。
  final void Function(String url)? onRedirect;

  @override
  ConsumerState<SsoHandoff> createState() => _SsoHandoffState();
}

class _SsoHandoffState extends ConsumerState<SsoHandoff> {
  String? _error;

  /// 已跳回 RP（web 整页卸载；测试/桌面停在终态文案，杜绝转圈不 settle）。
  bool _handedOff = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_handoff);
  }

  Future<void> _handoff() async {
    final api = ref.read(oauthApiProvider);
    try {
      final resp = await api.oAuthAuthorize(
        authorizeCodeRequest: widget.sso.toRequest(),
      );
      final code = resp.data?.code ?? '';
      if (code.isEmpty) {
        setState(() => _error = '授权失败：服务端响应缺少 code');
        return;
      }
      final url = buildSsoRedirectUrl(
        widget.sso.redirectUri,
        code,
        widget.sso.state,
      );
      (widget.onRedirect ?? redirectTo)(url);
      if (mounted) setState(() => _handedOff = true);
    } on DioException {
      if (mounted) setState(() => _error = '授权失败，请从应用重新发起登录');
    } on Exception {
      if (mounted) setState(() => _error = '授权失败，请从应用重新发起登录');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SSO 授权')),
      body: Center(
        child: _error != null
            ? Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              )
            : _handedOff
            ? const Text('已签发授权码，正在返回应用…')
            : const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('正在签发授权码并返回应用…'),
                ],
              ),
      ),
    );
  }
}
