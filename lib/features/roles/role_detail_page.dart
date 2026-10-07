// @entry M00.F03.I03
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'role_providers.dart';
import 'role_status_label.dart';

/// 角色详情（M00.F03.I03）：契约十字段卡（SysRole 全字段——id/tenantId/
/// clientId/roleCode/roleName/description/isPreset/status/createdAt/
/// updatedAt）。appbar 标题=角色名。
class RoleDetailPage extends ConsumerStatefulWidget {
  const RoleDetailPage({
    super.key,
    required this.tenantId,
    required this.roleId,
  });

  final String tenantId;
  final String roleId;

  @override
  ConsumerState<RoleDetailPage> createState() => _RoleDetailPageState();
}

class _RoleDetailPageState extends ConsumerState<RoleDetailPage> {
  SysRole? _role;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _error = null;
    });
    try {
      final resp = await ref
          .read(roleApiProvider)
          .tenantRolesGetSysRole(
            tenantId: widget.tenantId,
            roleId: widget.roleId,
          );
      if (!mounted) return;
      setState(() => _role = resp.data);
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.response == null ? '无法连接服务器' : '加载失败');
    }
  }

  /// 本地时区 'yyyy-MM-dd HH:mm'（无 intl 依赖，零新依赖约束 G-3）。
  String _fmt(DateTime dt) {
    final l = dt.toLocal();
    final mm = l.month.toString().padLeft(2, '0');
    final dd = l.day.toString().padLeft(2, '0');
    final hh = l.hour.toString().padLeft(2, '0');
    final mi = l.minute.toString().padLeft(2, '0');
    return '${l.year}-$mm-$dd $hh:$mi';
  }

  @override
  Widget build(BuildContext context) {
    final role = _role;
    return Scaffold(
      appBar: AppBar(title: Text(role?.roleName ?? '角色详情')),
      body: role == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!),
                        const SizedBox(height: 8),
                        FilledButton(onPressed: _load, child: const Text('重试')),
                      ],
                    ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                role.roleName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            _StatusBadge(role.status),
                          ],
                        ),
                        const Divider(height: 24),
                        _row('角色 ID', role.id),
                        _row('租户', role.tenantId),
                        _row('客户端', role.clientId),
                        _row('角色代码', role.roleCode),
                        _row('描述', role.description ?? '—'),
                        _row('预设', role.isPreset ? '是' : '否'),
                        _row('状态', roleStatusLabel(role.status)),
                        _row('创建时间', _fmt(role.createdAt)),
                        _row('更新时间', _fmt(role.updatedAt)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

/// 状态徽标（smallint 两值映射，roleStatusLabel 穷尽 throw）。
class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);

  final int status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final enabled = status == 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: enabled
            ? cs.primaryContainer
            : cs.errorContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        roleStatusLabel(status),
        style: TextStyle(
          fontSize: 12,
          color: enabled ? cs.onPrimaryContainer : cs.onErrorContainer,
        ),
      ),
    );
  }
}
