// @entry M00.F02.I02
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'member_providers.dart';

/// 成员表单弹窗（M00.F02.I02 创建 + I04 更新，双态，tenant_form_dialog 同构）：
/// existing == null = 创建（契约 `CreateSysUserRequest` 恰 username/password
/// 必填 + email/mobile 可选——密码是业务身份字段，缺失 fail-fast 不发请求，
/// ADR-0019 禁兜底）；非空 = 编辑（契约 `UpdateSysUserRequest` 恰 email/mobile
/// 两可空字段，username/password 契约不可改不呈现）。选填留空不随 body。
class MemberFormDialog extends ConsumerStatefulWidget {
  const MemberFormDialog({super.key, required this.tenantId, this.existing});

  final String tenantId;

  /// 非空 = 编辑态（回填来源）；null = 创建态。
  final TenantMemberUserView? existing;

  @override
  ConsumerState<MemberFormDialog> createState() => _MemberFormDialogState();
}

class _MemberFormDialogState extends ConsumerState<MemberFormDialog> {
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _mobileCtrl;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _emailCtrl = TextEditingController(text: widget.existing?.email ?? '');
    _mobileCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_isEdit &&
        (_usernameCtrl.text.trim().isEmpty || _passwordCtrl.text.isEmpty)) {
      setState(() => _error = '请完整填写用户名与密码');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final api = ref.read(tenantMembersApiProvider);
      if (_isEdit) {
        await api.tenantMembersUpdateTenantUser(
          tenantId: widget.tenantId,
          userId: widget.existing!.id,
          updateSysUserRequest: UpdateSysUserRequest(
            (b) => b
              ..email = _optional(_emailCtrl.text)
              ..mobile = _optional(_mobileCtrl.text),
          ),
        );
      } else {
        await api.tenantMembersCreateTenantUser(
          tenantId: widget.tenantId,
          createSysUserRequest: CreateSysUserRequest(
            (b) => b
              ..username = _usernameCtrl.text.trim()
              ..password = _passwordCtrl.text
              ..email = _optional(_emailCtrl.text)
              ..mobile = _optional(_mobileCtrl.text),
          ),
        );
      }
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

  /// 选填留空不随 body（契约可空字段，禁空串兜底）。
  String? _optional(String text) => text.trim().isEmpty ? null : text.trim();

  InputDecoration _dec(String label) => InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    isDense: true,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEdit ? '编辑成员' : '新建成员'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 创建态专有：username/password（契约不可改，编辑态不呈现）。
            if (!_isEdit) ...[
              TextField(
                controller: _usernameCtrl,
                enabled: !_saving,
                decoration: _dec('用户名'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordCtrl,
                enabled: !_saving,
                obscureText: true,
                decoration: _dec('密码'),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _emailCtrl,
              enabled: !_saving,
              decoration: _dec('邮箱'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _mobileCtrl,
              enabled: !_saving,
              decoration: _dec('手机号'),
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
