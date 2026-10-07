// @entry M01.F01.I01
// @entry M01.F03.I01（成员关系列表）
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/features/members/member_status_label.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'me_controller.dart';

/// 「我」页（REQ-2026-008）：whoami 身份卡（M01.F01.I01）+ 我的租户
/// 成员关系列表（M01.F03.I01）+ 行内切换当前租户（M01.F03.I02）。
/// 树口径 displayName 与生成物不符——渲染以生成物 CurrentUser 为准。
class MePage extends ConsumerStatefulWidget {
  const MePage({super.key});

  @override
  ConsumerState<MePage> createState() => _MePageState();
}

class _MePageState extends ConsumerState<MePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(meControllerProvider.notifier).load());
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// 切换当前租户（M01.F03.I02）：成功 SnackBar（回刷在控制器内已完成）。
  Future<void> _switch(TenantMembership m) async {
    final ok = await ref
        .read(meControllerProvider.notifier)
        .switchTenant(m.tenantId);
    if (!mounted) return;
    if (ok) {
      _toast('已切换到 ${m.tenantId}');
    } else {
      _toast('切换失败，请重试');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(meControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('我')),
      body: switch (state) {
        MeLoading() => const Center(child: CircularProgressIndicator()),
        MeError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message),
              TextButton(
                onPressed: () => ref.read(meControllerProvider.notifier).load(),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
        MeLoaded() => RefreshIndicator(
          onRefresh: () => ref.read(meControllerProvider.notifier).load(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '用户ID',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(state.user.id),
                      const SizedBox(height: 8),
                      Text('邮箱', style: Theme.of(context).textTheme.labelSmall),
                      Text(state.user.email ?? '—'),
                      const SizedBox(height: 8),
                      Text(
                        '当前租户',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(state.user.currentTenantId ?? '—'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '我的租户成员关系',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ...state.memberships.map(
                (m) => _MembershipTile(m: m, onSwitch: () => _switch(m)),
              ),
            ],
          ),
        ),
      },
    );
  }
}

class _MembershipTile extends StatelessWidget {
  const _MembershipTile({required this.m, required this.onSwitch});

  final TenantMembership m;
  final Future<void> Function() onSwitch;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(m.tenantId),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  memberStatusLabel(m.status),
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          Text('角色 ${m.roleIds.length} 项'),
          Text(_dateOnly(m.joinedAt)),
        ],
      ),
      trailing: IconButton(
        tooltip: '切换',
        icon: const Icon(Icons.swap_horiz),
        onPressed: onSwitch,
      ),
    );
  }

  String _dateOnly(DateTime d) =>
      d.toLocal().toIso8601String().substring(0, 10);
}
