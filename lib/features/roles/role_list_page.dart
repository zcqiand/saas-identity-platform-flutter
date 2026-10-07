// @entry M00.F03.I01
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'role_detail_page.dart';
import 'role_form_dialog.dart';
import 'role_list_controller.dart';
import 'role_providers.dart';
import 'role_status_label.dart';

/// 角色列表（M00.F03.I01）：tenant-scoped（family by tenantId）；clientId
/// chip 走服务端参数（契约有 clientId 过滤——tenant×client 双作用域，chip 值
/// 取家族 SSO clientId：saas-console 本族 / lab-management lab 族）；行
/// onTap 详情，行尾 编辑/删除。入口：租户详情页「角色」。
class RoleListPage extends ConsumerStatefulWidget {
  const RoleListPage({super.key, required this.tenantId});

  final String tenantId;

  @override
  ConsumerState<RoleListPage> createState() => _RoleListPageState();
}

/// clientId chip 值（家族值表 docs/families/saas.md + lab.md SSO 接线）。
const _knownClients = <String?>[null, 'saas-console', 'lab-management'];

const _clientChipLabels = <String?, String>{
  null: '全部',
  'saas-console': 'saas-console',
  'lab-management': 'lab-management',
};

class _RoleListPageState extends ConsumerState<RoleListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(roleListControllerProvider(widget.tenantId).notifier).load(),
    );
  }

  /// 表单弹窗入口（I02 创建 / I04 编辑）：收窗后 SnackBar + silent 回刷。
  Future<void> _openForm([SysRole? existing]) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) =>
          RoleFormDialog(tenantId: widget.tenantId, existing: existing),
    );
    if (!mounted) return;
    if (saved ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(existing == null ? '创建成功' : '保存成功')),
      );
    }
    await ref
        .read(roleListControllerProvider(widget.tenantId).notifier)
        .load(silent: true);
  }

  /// 删除入口（I05）：确认弹窗明示级联清理语义；确认 → DELETE + SnackBar +
  /// silent 回刷，失败 SnackBar（列表原地不动）。
  Future<void> _confirmDelete(SysRole r) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除角色'),
        content: Text('确认删除角色「${r.roleName}」？将同时移除其全部成员角色绑定与权限关联。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref
          .read(roleApiProvider)
          .tenantRolesDeleteSysRole(tenantId: widget.tenantId, roleId: r.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('删除成功')));
      await ref
          .read(roleListControllerProvider(widget.tenantId).notifier)
          .load(silent: true);
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response == null ? '无法连接服务器' : '删除失败，请重试')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(roleListControllerProvider(widget.tenantId));
    return Scaffold(
      appBar: AppBar(title: const Text('角色')),
      // 创建入口（I02）：FAB 悬浮，弹窗双态复用（I04 编辑走行内入口）。
      floatingActionButton: FloatingActionButton(
        tooltip: '新建角色',
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                for (final client in _knownClients) ...[
                  FilterChip(
                    label: Text(_clientChipLabels[client]!),
                    selected: _chipSelected(listState, client),
                    onSelected: (_) => ref
                        .read(
                          roleListControllerProvider(widget.tenantId).notifier,
                        )
                        .setClientFilter(client),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          Expanded(
            child: switch (listState) {
              RoleListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              RoleListEmpty() => const Center(child: Text('暂无角色')),
              RoleListError(:final message) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => ref
                          .read(
                            roleListControllerProvider(widget.tenantId)
                                .notifier,
                          )
                          .load(),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
              RoleListLoaded(:final items) =>
                items.isEmpty
                    ? const Center(child: Text('无匹配角色'))
                    : RefreshIndicator(
                        onRefresh: () => ref
                            .read(
                              roleListControllerProvider(widget.tenantId)
                                  .notifier,
                            )
                            .load(silent: true),
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            final r = items[i];
                            return ListTile(
                              title: Text(r.roleName),
                              subtitle: Text(r.roleCode),
                              // 行尾写半边（I04 编辑 / I05 删除）+ 状态徽标；
                              // IconButton 自吞点击不与行 onTap 打架。
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _StatusBadge(r.status),
                                  IconButton(
                                    tooltip: '编辑',
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => _openForm(r),
                                  ),
                                  IconButton(
                                    tooltip: '删除',
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => _confirmDelete(r),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => RoleDetailPage(
                                    tenantId: widget.tenantId,
                                    roleId: r.id,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, _) => const Divider(height: 1),
                        ),
                      ),
            },
          ),
        ],
      ),
    );
  }

  bool _chipSelected(RoleListState s, String? client) =>
      s is RoleListLoaded && s.clientFilter == client;
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
