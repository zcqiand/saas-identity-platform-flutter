// @entry M00.F02.I06
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'member_providers.dart';

/// 邀请成员弹窗（M00.F02.I06）：契约 `TenantMembersInviteTenantUserRequest`
/// 恰 email 必填 + mobile 可选；成功 pop(true)（页侧 SnackBar「邀请已发送」
/// + 回刷——被邀人 status=invited，接受走 I07 被邀侧待 BASE，本仓不呈现入口）。
class MemberInviteDialog extends ConsumerStatefulWidget {
  const MemberInviteDialog({super.key, required this.tenantId});

  final String tenantId;

  @override
  ConsumerState<MemberInviteDialog> createState() => _MemberInviteDialogState();
}

class _MemberInviteDialogState extends ConsumerState<MemberInviteDialog> {
  late final TextEditingController _emailCtrl;
  late final TextEditingController _mobileCtrl;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
    _mobileCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_sending) return;
    if (_emailCtrl.text.trim().isEmpty) {
      setState(() => _error = '请填写邮箱');
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref
          .read(tenantMembersApiProvider)
          .tenantMembersInviteTenantUser(
            tenantId: widget.tenantId,
            tenantMembersInviteTenantUserRequest:
                TenantMembersInviteTenantUserRequest(
                  (b) => b
                    ..email = _emailCtrl.text.trim()
                    ..mobile = _mobileCtrl.text.trim().isEmpty
                        ? null
                        : _mobileCtrl.text.trim(),
                ),
          );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = e.response == null ? '无法连接服务器' : '邀请失败，请重试';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('邀请成员'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailCtrl,
              enabled: !_sending,
              decoration: const InputDecoration(
                labelText: '邮箱',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _mobileCtrl,
              enabled: !_sending,
              decoration: const InputDecoration(
                labelText: '手机号',
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
          onPressed: _sending ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _sending ? null : _send,
          child: const Text('发送邀请'),
        ),
      ],
    );
  }
}
