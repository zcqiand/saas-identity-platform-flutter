// @entry M00.F01.I01
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'tenant_detail_page.dart';
import 'tenant_form_dialog.dart';
import 'tenant_list_controller.dart';
import 'tenant_providers.dart';
import 'tenant_status_label.dart';

/// 租户列表（M00.F01.I01）：契约无服务端过滤参数（G-11），关键字/状态
/// 过滤全部客户端侧；行 onTap 详情 T3 接线。AppBar 由 _Shell 承载（登出）。
class TenantsListPage extends ConsumerStatefulWidget {
  const TenantsListPage({super.key});

  @override
  ConsumerState<TenantsListPage> createState() => _TenantsListPageState();
}

class _TenantsListPageState extends ConsumerState<TenantsListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(tenantListControllerProvider.notifier).load(),
    );
  }

  /// 表单弹窗入口（I02 创建 / I04 编辑）：收窗（保存成功）后 SnackBar +
  /// 列表 silent 回刷。
  Future<void> _openForm([Tenant? existing]) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => TenantFormDialog(existing: existing),
    );
    if (!mounted) return;
    if (saved ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(existing == null ? '创建成功' : '保存成功')),
      );
    }
    await ref.read(tenantListControllerProvider.notifier).load(silent: true);
  }

  /// 删除入口（I05）：确认弹窗明示级联清理语义；确认 → DELETE，成功
  /// SnackBar + silent 回刷，失败 SnackBar（列表原地不动）。
  Future<void> _confirmDelete(Tenant t) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除租户'),
        content: Text('确认删除「${t.name}」？成员、角色与应用订阅将级联清理。'),
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
      await ref.read(adminTenantsApiProvider).adminTenantsDeleteTenant(
            id: t.id,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('删除成功')));
      await ref.read(tenantListControllerProvider.notifier).load(silent: true);
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response == null ? '无法连接服务器' : '删除失败，请重试'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(tenantListControllerProvider);
    return Scaffold(
      // 创建入口（I02）：FAB 悬浮，弹窗双态复用（I04 编辑走行内入口）。
      floatingActionButton: FloatingActionButton(
        tooltip: '新建租户',
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: '关键字',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: ref
                  .read(tenantListControllerProvider.notifier)
                  .setKeyword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('全部'),
                  selected: _chipSelected(listState, null),
                  onSelected: (_) => ref
                      .read(tenantListControllerProvider.notifier)
                      .setStatusFilter(null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('启用'),
                  selected: _chipSelected(listState, TenantStatus.active),
                  onSelected: (_) => ref
                      .read(tenantListControllerProvider.notifier)
                      .setStatusFilter(TenantStatus.active),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('停用'),
                  selected: _chipSelected(listState, TenantStatus.suspended),
                  onSelected: (_) => ref
                      .read(tenantListControllerProvider.notifier)
                      .setStatusFilter(TenantStatus.suspended),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (listState) {
              TenantListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              TenantListEmpty() => const Center(child: Text('暂无租户')),
              TenantListError(:final message) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => ref
                          .read(tenantListControllerProvider.notifier)
                          .load(),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
              TenantListLoaded(:final items) =>
                items.isEmpty
                    ? const Center(child: Text('无匹配租户'))
                    : RefreshIndicator(
                        onRefresh: () => ref
                            .read(tenantListControllerProvider.notifier)
                            .load(silent: true),
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            final t = items[i];
                            return ListTile(
                              title: Text(t.name),
                              subtitle: Text(t.tenantKey),
                              // 行尾写半边入口（I04 编辑 / I05 删除）+ 状态徽标；
                              // IconButton 自吞点击，不与行 onTap（详情）打架。
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _StatusBadge(t.status),
                                  IconButton(
                                    tooltip: '编辑',
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => _openForm(t),
                                  ),
                                  IconButton(
                                    tooltip: '删除',
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => _confirmDelete(t),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      TenantDetailPage(tenantId: t.id),
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

  bool _chipSelected(TenantListState s, TenantStatus? filter) =>
      s is TenantListLoaded && s.statusFilter == filter;
}

/// 状态徽标（两值中文映射，TenantStatusLabel 穷尽 switch）。
class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);

  final TenantStatus status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final enabled = status == TenantStatus.active;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: enabled
            ? cs.primaryContainer
            : cs.errorContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        tenantStatusLabel(status),
        style: TextStyle(
          fontSize: 12,
          color: enabled ? cs.onPrimaryContainer : cs.onErrorContainer,
        ),
      ),
    );
  }
}
