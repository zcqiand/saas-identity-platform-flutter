// @entry M00.F05.I02
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_providers.dart';

/// 订阅应用弹窗（M00.F05.I02）：契约 `SubscribeTenantApplicationRequest`
/// 恰 clientId 必填 + expireTime 可选（yyyy-MM-dd，留空不随 body——选填
/// 留空不随请求，禁空串兜底 ADR-0019 同源纪律）。
class SubscribeApplicationDialog extends ConsumerStatefulWidget {
  const SubscribeApplicationDialog({super.key, required this.tenantId});

  final String tenantId;

  @override
  ConsumerState<SubscribeApplicationDialog> createState() =>
      _SubscribeApplicationDialogState();
}

class _SubscribeApplicationDialogState
    extends ConsumerState<SubscribeApplicationDialog> {
  late final TextEditingController _clientCtrl;
  late final TextEditingController _expireCtrl;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _clientCtrl = TextEditingController();
    _expireCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _clientCtrl.dispose();
    _expireCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    if (_clientCtrl.text.trim().isEmpty) {
      setState(() => _error = '请填写客户端标识');
      return;
    }
    // 到期时间选填：填了必须是 yyyy-MM-dd 可解析。Iso8601DateTimeSerializer
    // 只收 UTC——按日期分量重建 UTC 零点（本地解析实例序列化即炸）。
    DateTime? expire;
    final expireText = _expireCtrl.text.trim();
    if (expireText.isNotEmpty) {
      final parsed = DateTime.tryParse(expireText);
      if (parsed == null) {
        setState(() => _error = '到期时间格式应为 yyyy-MM-dd');
        return;
      }
      expire = DateTime.utc(parsed.year, parsed.month, parsed.day);
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(tenantApplicationsApiProvider)
          .tenantApplicationsSubscribeTenantApplication(
            tenantId: widget.tenantId,
            subscribeTenantApplicationRequest:
                SubscribeTenantApplicationRequest(
                  (b) => b
                    ..clientId = _clientCtrl.text.trim()
                    ..expireTime = expire,
                ),
          );
      if (!mounted) return;
      Navigator.of(context).pop(true); // 页侧凭 true 出 SnackBar + 回刷
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = e.response == null ? '无法连接服务器' : '保存失败，请重试';
      });
    }
  }

  InputDecoration _dec(String label) => InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    isDense: true,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('订阅应用'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _clientCtrl,
              enabled: !_saving,
              decoration: _dec('客户端标识'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _expireCtrl,
              enabled: !_saving,
              decoration: const InputDecoration(
                labelText: '到期时间',
                helperText: 'yyyy-MM-dd，选填',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
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
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: const Text('保存'),
        ),
      ],
    );
  }
}
