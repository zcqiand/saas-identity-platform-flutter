// @entry M00.F01.I01
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'tenant_list_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(tenantListControllerProvider);
    return Scaffold(
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
                              trailing: _StatusBadge(t.status),
                              // T3 接线：详情页落地后推 TenantDetailPage
                              onTap: () {},
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
