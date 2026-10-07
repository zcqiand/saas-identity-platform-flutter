// @entry M04.F01.I02
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'client_list_controller.dart';

/// 应用表单弹窗（REQ-2026-010）：I02 创建 / I04 编辑双态复用。
/// 契约必填五件里 clientSecret 表单侧自动生成（sec- 前缀随机，nextjs
/// 同款，不收用户输入）；grantTypes 固定默认 authorization_code,
/// client_credentials（创建侧）；scopes 逗号串选填。编辑只提交
/// clientName/redirectUris/scopes（生成物 UpdateOAuthClientRequest 面内，
/// status 启停走 F02.I01 独立端点不混提）。
class ClientFormDialog extends ConsumerStatefulWidget {
  const ClientFormDialog({super.key, this.existing});

  final OAuthClient? existing;

  @override
  ConsumerState<ClientFormDialog> createState() => _ClientFormDialogState();
}

class _ClientFormDialogState extends ConsumerState<ClientFormDialog> {
  late final TextEditingController _name;
  late final TextEditingController _clientId;
  late final TextEditingController _redirectUris;
  late final TextEditingController _scopes;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.clientName);
    _clientId = TextEditingController(text: widget.existing?.clientId);
    _redirectUris = TextEditingController(text: widget.existing?.redirectUris);
    _scopes = TextEditingController(text: widget.existing?.scopes);
  }

  @override
  void dispose() {
    _name.dispose();
    _clientId.dispose();
    _redirectUris.dispose();
    _scopes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    final controller = ref.read(clientListControllerProvider.notifier);
    if (_isEdit) {
      setState(() => _saving = true);
      final ok = await controller.update(
        widget.existing!.clientId,
        UpdateOAuthClientRequest(
          (b) => b
            ..clientName = name
            ..redirectUris = _redirectUris.text.trim()
            ..scopes = _scopes.text.trim(),
        ),
      );
      if (!mounted) return;
      if (ok) {
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _saving = false;
          _error = '保存失败，请重试';
        });
      }
      return;
    }
    final clientId = _clientId.text.trim();
    if (clientId.isEmpty) {
      setState(() => _error = '请填写客户端标识');
      return;
    }
    if (name.isEmpty) {
      setState(() => _error = '请填写应用名称');
      return;
    }
    setState(() => _saving = true);
    final ok = await controller.create(
      CreateOAuthClientRequest(
        (b) => b
          ..clientId = clientId
          ..clientName = name
          ..clientSecret =
              'sec-${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}'
              '${Random().nextInt(0x7fffffff).toRadixString(36)}'
          ..grantTypes = 'authorization_code,client_credentials'
          ..redirectUris = _redirectUris.text.trim()
          ..scopes = _scopes.text.trim(),
      ),
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _saving = false;
        _error = '保存失败，请重试';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEdit ? '编辑应用' : '新建应用'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _clientId,
              enabled: !_isEdit,
              decoration: const InputDecoration(
                labelText: '客户端标识',
                helperText: '创建后不可改',
              ),
            ),
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: '应用名称'),
            ),
            TextField(
              controller: _redirectUris,
              decoration: const InputDecoration(
                labelText: '回调地址',
                helperText: '逗号分隔，可空',
              ),
            ),
            TextField(
              controller: _scopes,
              decoration: const InputDecoration(
                labelText: 'Scopes',
                helperText: '逗号分隔，选填',
              ),
            ),
            if (_isEdit)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('密钥不回显'),
                ),
              ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_isEdit ? '保存' : '创建'),
        ),
      ],
    );
  }
}
