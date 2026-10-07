// @entry M04.F01.I03
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/features/appadmin/client_status_label.dart';
import 'package:saas_identity_platform_flutter/features/appmenus/menu_tree_page.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_admin_providers.dart';

/// 应用详情（REQ-2026-010 M04.F01.I03）：管理面全字段 + 「公共元数据」卡
/// （M04.F01.I06 匿名端点对照呈现）。契约不返 clientSecret——「密钥不回显」
/// 明示，防「字段丢了」误读。
class ClientDetailPage extends ConsumerStatefulWidget {
  const ClientDetailPage({super.key, required this.clientId});

  final String clientId;

  @override
  ConsumerState<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends ConsumerState<ClientDetailPage> {
  OAuthClient? _client;
  OAuthClientPublicInfo? _public;
  String? _error;

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    try {
      final resp = await ref
          .read(adminClientsApiProvider)
          .adminClientsGetClient(clientId: widget.clientId);
      final pub = await ref
          .read(clientsApiProvider)
          .clientsGetClient(clientId: widget.clientId);
      if (!mounted) return;
      setState(() {
        _client = resp.data!;
        _public = pub.data!;
      });
    } on Exception {
      if (!mounted) return;
      setState(() => _error = '无法连接服务器');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientId),
        // 菜单管理入口（REQ-2026-011 M04.F04.I01）：client-scoped 管理面。
        actions: [
          IconButton(
            tooltip: '菜单',
            icon: const Icon(Icons.menu_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => MenuTreePage(clientId: widget.clientId),
              ),
            ),
          ),
        ],
      ),
      body: _error != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_error!),
                  TextButton(onPressed: _load, child: const Text('重试')),
                ],
              ),
            )
          : _client == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _card('应用配置', [
                  _row('客户端标识', _client!.clientId),
                  _row('应用名称', _client!.clientName),
                  _row('授权类型', _client!.grantTypes),
                  _row('回调地址', _client!.redirectUris),
                  _row('Scopes', _client!.scopes ?? '—'),
                  _row(
                    'Access Token 有效期(秒)',
                    '${_client!.accessTokenValidity}',
                  ),
                  _row(
                    'Refresh Token 有效期(秒)',
                    '${_client!.refreshTokenValidity}',
                  ),
                  _row('自动批准', _client!.autoApprove ? '是' : '否'),
                  _row('状态', clientStatusLabel(_client!.status)),
                  const Row(
                    children: [
                      Text('密钥不回显'),
                      SizedBox(width: 6),
                      Icon(Icons.visibility_off_outlined, size: 16),
                    ],
                  ),
                ]),
                const SizedBox(height: 12),
                if (_public != null)
                  _card('公共元数据', [
                    _row('客户端标识', _public!.clientId),
                    _row('应用名称', _public!.clientName),
                    _row('状态', clientStatusLabel(_public!.status)),
                  ]),
              ],
            ),
    );
  }

  Widget _card(String title, List<Widget> rows) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...rows,
        ],
      ),
    ),
  );

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(label, style: Theme.of(context).textTheme.labelSmall),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
