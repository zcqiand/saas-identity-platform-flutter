// @entry M00.F01.I03
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import '../members/member_list_page.dart';
import 'tenant_detail_controller.dart';
import 'tenant_status_label.dart';

/// 租户详情（M00.F01.I03）：契约六字段卡（id 作副题，G-11 口径——
/// 到期时间/订阅应用数不在 Tenant 面）。appbar 标题=租户名。
class TenantDetailPage extends ConsumerStatefulWidget {
  const TenantDetailPage({required this.tenantId, super.key});

  final String tenantId;

  @override
  ConsumerState<TenantDetailPage> createState() => _TenantDetailPageState();
}

class _TenantDetailPageState extends ConsumerState<TenantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(tenantDetailControllerProvider.notifier)
          .load(tenantId: widget.tenantId),
    );
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
    final detailState = ref.watch(tenantDetailControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          detailState is TenantDetailLoaded ? detailState.tenant.name : '租户详情',
        ),
        actions: [
          // 成员入口（REQ-2026-004 M00.F02）：成员是 tenant-scoped 面。
          IconButton(
            tooltip: '成员',
            icon: const Icon(Icons.group_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => MemberListPage(tenantId: widget.tenantId),
              ),
            ),
          ),
        ],
      ),
      body: switch (detailState) {
        TenantDetailLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        TenantDetailError(:final message) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => ref
                    .read(tenantDetailControllerProvider.notifier)
                    .load(tenantId: widget.tenantId),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
        TenantDetailLoaded(:final tenant) => ListView(
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
                            tenant.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        _StatusBadge(tenant.status),
                      ],
                    ),
                    const Divider(height: 24),
                    _row('租户标识', tenant.tenantKey),
                    _row('租户 ID', tenant.id),
                    _row('创建时间', _fmt(tenant.createdAt)),
                    _row('更新时间', _fmt(tenant.updatedAt)),
                  ],
                ),
              ),
            ),
          ],
        ),
      },
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

/// 状态徽标（tenants_list_page 同款两值映射）。
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
