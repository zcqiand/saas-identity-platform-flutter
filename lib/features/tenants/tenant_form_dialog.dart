// @entry M00.F01.I02
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'tenant_providers.dart';
import 'tenant_status_label.dart';

/// 租户表单弹窗（M00.F01.I02 创建 + I04 更新，双态）：existing == null =
/// 创建（tenantKey + name，契约 CreateTenantRequest 恰此二必填）；
/// 非空 = 编辑（name 回填 + status 下拉，契约 UpdateTenantRequest 恰此二
/// 可空字段）。保存成功 pop(true)（页侧 SnackBar + silent 回刷）；失败留窗
/// 保输入（lab F03 录入 sheet 同构）。「绑定初始管理员与默认配置」为后端
/// act 语义，前端只提交契约面字段。
class TenantFormDialog extends ConsumerStatefulWidget {
  const TenantFormDialog({super.key, this.existing});

  /// 非空 = 编辑态（回填来源）；null = 创建态。
  final Tenant? existing;

  @override
  ConsumerState<TenantFormDialog> createState() => _TenantFormDialogState();
}

class _TenantFormDialogState extends ConsumerState<TenantFormDialog> {
  late final TextEditingController _keyCtrl;
  late final TextEditingController _nameCtrl;
  TenantStatus? _status;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _keyCtrl = TextEditingController();
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _status = widget.existing?.status;
  }

  @override
  void dispose() {
    _keyCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (_saving) return;
    if (!_isEdit && _keyCtrl.text.trim().isEmpty) {
      setState(() => _error = '请完整填写租户标识与名称');
      return;
    }
    if (name.isEmpty) {
      setState(() => _error = '请完整填写租户标识与名称');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final api = ref.read(adminTenantsApiProvider);
      if (_isEdit) {
        await api.adminTenantsUpdateTenant(
          id: widget.existing!.id,
          updateTenantRequest: UpdateTenantRequest(
            (b) => b
              ..name = name
              ..status = _status,
          ),
        );
      } else {
        await api.adminTenantsCreateTenant(
          createTenantRequest: CreateTenantRequest(
            (b) => b
              ..tenantKey = _keyCtrl.text.trim()
              ..name = name,
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEdit ? '编辑租户' : '新建租户'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 创建态专有：租户标识（创建后契约不可改，编辑态不呈现）。
            if (!_isEdit)
              TextField(
                controller: _keyCtrl,
                enabled: !_saving,
                decoration: const InputDecoration(
                  labelText: '租户标识',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            if (!_isEdit) const SizedBox(height: 12),
            TextField(
              controller: _nameCtrl,
              enabled: !_saving,
              decoration: const InputDecoration(
                labelText: '租户名称',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            if (_isEdit) ...[
              const SizedBox(height: 12),
              // 状态下拉（I04）：initialValue 只在首建读，程序性改值靠
              // ValueKey 重建（Flutter 3.33+ FormField 语义）。
              DropdownButtonFormField<TenantStatus>(
                key: ValueKey('status#${_status?.name}'),
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: '状态',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: [
                  for (final s in const [
                    TenantStatus.active,
                    TenantStatus.suspended,
                  ])
                    DropdownMenuItem(
                      value: s,
                      child: Text(tenantStatusLabel(s)),
                    ),
                ],
                onChanged: _saving ? null : (v) => setState(() => _status = v),
              ),
            ],
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
