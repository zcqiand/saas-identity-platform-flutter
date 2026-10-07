// @entry M01.F02.I01
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/features/members/member_providers.dart';
import 'package:saas_identity_platform_flutter/features/roles/role_providers.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

/// 分配角色弹窗（M01.F02.I01）：member↔role 关系面，全量覆盖语义——
/// 预勾 member.roleIds，勾选集即 PUT body，空选=合法清空。
class AssignMemberRolesDialog extends ConsumerStatefulWidget {
  const AssignMemberRolesDialog({
    super.key,
    required this.tenantId,
    required this.member,
  });

  final String tenantId;
  final TenantMemberUserView member;

  @override
  ConsumerState<AssignMemberRolesDialog> createState() =>
      _AssignMemberRolesDialogState();
}

class _AssignMemberRolesDialogState
    extends ConsumerState<AssignMemberRolesDialog> {
  List<SysRole>? _roles;
  String? _loadError;
  late final Set<String> _selected = widget.member.roleIds.toSet();
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    setState(() {
      _loadError = null;
      _roles = null;
    });
    try {
      final resp = await ref
          .read(roleApiProvider)
          .tenantRolesListSysRoles(tenantId: widget.tenantId);
      if (!mounted) return;
      setState(() => _roles = resp.data!.items.toList());
    } on DioException {
      if (!mounted) return;
      setState(() => _loadError = '无法连接服务器');
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(tenantMembersApiProvider)
          .tenantMembersAssignTenantMemberRoles(
            tenantId: widget.tenantId,
            userId: widget.member.id,
            setTenantMemberRolesRequest: SetTenantMemberRolesRequest(
              (b) => b..roleIds.replace(BuiltList<String>(_selected.toList())),
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

  @override
  Widget build(BuildContext context) {
    final roles = _roles;
    return AlertDialog(
      title: const Text('分配角色'),
      content: SizedBox(
        width: 360,
        child: roles == null
            ? _loadError != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_loadError!),
                        TextButton(
                          onPressed: _loadRoles,
                          child: const Text('重试'),
                        ),
                      ],
                    )
                  : const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...roles.map(
                      (r) => CheckboxListTile(
                        value: _selected.contains(r.id),
                        title: Text(r.roleName),
                        subtitle: Text(r.roleCode),
                        onChanged: _saving
                            ? null
                            : (checked) => setState(() {
                                checked!
                                    ? _selected.add(r.id)
                                    : _selected.remove(r.id);
                              }),
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          _error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: roles == null || _saving ? null : _save,
          child: const Text('保存'),
        ),
      ],
    );
  }
}
