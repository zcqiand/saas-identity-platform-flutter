// @entry M00.F03.I02
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'role_providers.dart';

/// 角色表单弹窗（M00.F03.I02 创建 + I04 更新，双态，member_form_dialog 同构）：
/// existing == null = 创建（契约 `CreateSysRoleRequest` 恰 clientId/roleCode/
/// roleName 必填 + description/isPreset 可选——isPreset 后端固定 false 不收）；
/// 非空 = 编辑（契约 `UpdateSysRoleRequest` 的 UI 面恰 roleName/description，
/// status 端点在但树口径「不动权限与菜单绑定」不呈现）。选填留空不随 body。
class RoleFormDialog extends ConsumerStatefulWidget {
  const RoleFormDialog({super.key, required this.tenantId, this.existing});

  final String tenantId;

  /// 非空 = 编辑态（回填来源）；null = 创建态。
  final SysRole? existing;

  @override
  ConsumerState<RoleFormDialog> createState() => _RoleFormDialogState();
}

class _RoleFormDialogState extends ConsumerState<RoleFormDialog> {
  late final TextEditingController _clientCtrl;
  late final TextEditingController _codeCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _clientCtrl = TextEditingController();
    _codeCtrl = TextEditingController();
    _nameCtrl = TextEditingController(text: widget.existing?.roleName ?? '');
    _descCtrl = TextEditingController(text: widget.existing?.description ?? '');
  }

  @override
  void dispose() {
    _clientCtrl.dispose();
    _codeCtrl.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_isEdit &&
        (_clientCtrl.text.trim().isEmpty ||
            _codeCtrl.text.trim().isEmpty ||
            _nameCtrl.text.trim().isEmpty)) {
      setState(() => _error = '请完整填写客户端标识、角色代码与角色名称');
      return;
    }
    if (_isEdit && _nameCtrl.text.trim().isEmpty) {
      setState(() => _error = '角色名称不能为空');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final api = ref.read(roleApiProvider);
      if (_isEdit) {
        await api.tenantRolesUpdateSysRole(
          tenantId: widget.tenantId,
          roleId: widget.existing!.id,
          updateSysRoleRequest: UpdateSysRoleRequest(
            (b) => b
              ..roleName = _nameCtrl.text.trim()
              ..description = _optional(_descCtrl.text),
          ),
        );
      } else {
        await api.tenantRolesCreateSysRole(
          tenantId: widget.tenantId,
          createSysRoleRequest: CreateSysRoleRequest(
            (b) => b
              ..clientId = _clientCtrl.text.trim()
              ..roleCode = _codeCtrl.text.trim()
              ..roleName = _nameCtrl.text.trim()
              ..description = _optional(_descCtrl.text),
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
      title: Text(_isEdit ? '编辑角色' : '新建角色'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 创建态专有：clientId/roleCode（tenant×client 双作用域，
            // 编辑态契约不可改不呈现）。
            if (!_isEdit) ...[
              TextField(
                controller: _clientCtrl,
                enabled: !_saving,
                decoration: _dec('客户端标识'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _codeCtrl,
                enabled: !_saving,
                decoration: _dec('角色代码'),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _nameCtrl,
              enabled: !_saving,
              decoration: _dec('角色名称'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              enabled: !_saving,
              decoration: _dec('描述'),
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
