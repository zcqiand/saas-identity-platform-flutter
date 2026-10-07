// @entry M00.F02.I01
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'member_detail_page.dart';
import 'member_form_dialog.dart';
import 'member_invite_dialog.dart';
import 'member_list_controller.dart';
import 'member_providers.dart';
import 'member_status_label.dart';

/// 成员列表（M00.F02.I01）：tenant-scoped（family by tenantId）；状态 chip
/// 走服务端参数（契约有 status 过滤，与租户列表客户端侧过滤不同源）；行
/// onTap 详情，行尾 编辑/删除/状态切换。入口：租户详情页「成员」。
class MemberListPage extends ConsumerStatefulWidget {
  const MemberListPage({super.key, required this.tenantId});

  final String tenantId;

  @override
  ConsumerState<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends ConsumerState<MemberListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(memberListControllerProvider(widget.tenantId).notifier)
          .load(),
    );
  }

  /// 表单弹窗入口（I02 创建 / I04 编辑）：收窗后 SnackBar + silent 回刷。
  Future<void> _openForm([TenantMemberUserView? existing]) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) =>
          MemberFormDialog(tenantId: widget.tenantId, existing: existing),
    );
    if (!mounted) return;
    if (saved ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(existing == null ? '创建成功' : '保存成功')),
      );
    }
    await ref
        .read(memberListControllerProvider(widget.tenantId).notifier)
        .load(silent: true);
  }

  /// 邀请入口（I06）：收窗后 SnackBar + silent 回刷（被邀人 invited 入列）。
  Future<void> _openInvite() async {
    final sent = await showDialog<bool>(
      context: context,
      builder: (_) => MemberInviteDialog(tenantId: widget.tenantId),
    );
    if (!mounted) return;
    if (sent ?? false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('邀请已发送')));
    }
    await ref
        .read(memberListControllerProvider(widget.tenantId).notifier)
        .load(silent: true);
  }

  /// 删除入口（I05）：确认弹窗明示「不删除全局用户」语义；确认 → DELETE +
  /// SnackBar + silent 回刷，失败 SnackBar（列表原地不动）。
  Future<void> _confirmDelete(TenantMemberUserView m) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除成员'),
        content: Text('确认删除成员「${m.username}」？仅解除其与租户的关系，不删除全局用户记录。'),
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
          .read(tenantMembersApiProvider)
          .tenantMembersDeleteTenantUser(
            tenantId: widget.tenantId,
            userId: m.id,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('删除成功')));
      await ref
          .read(memberListControllerProvider(widget.tenantId).notifier)
          .load(silent: true);
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response == null ? '无法连接服务器' : '删除失败，请重试')),
      );
    }
  }

  /// 状态切换（I08）：active⇄suspended 行内动作；invited/disabled 不呈现
  /// 切换钮（树行「启用/停用成员账号」口径）。
  Future<void> _toggleStatus(TenantMemberUserView m) async {
    final target = m.status == TenantMemberStatus.active
        ? TenantMemberStatus.suspended
        : TenantMemberStatus.active;
    try {
      await ref
          .read(tenantMembersApiProvider)
          .tenantMembersChangeTenantUserStatus(
            tenantId: widget.tenantId,
            userId: m.id,
            tenantMembersChangeTenantUserStatusRequest:
                TenantMembersChangeTenantUserStatusRequest(
                  (b) => b..status = target,
                ),
          );
      if (!mounted) return;
      await ref
          .read(memberListControllerProvider(widget.tenantId).notifier)
          .load(silent: true);
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response == null ? '无法连接服务器' : '状态切换失败，请重试')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(memberListControllerProvider(widget.tenantId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('成员'),
        actions: [
          // 邀请入口（I06）。
          IconButton(
            tooltip: '邀请成员',
            icon: const Icon(Icons.person_add_alt_1_outlined),
            onPressed: _openInvite,
          ),
        ],
      ),
      // 创建入口（I02）：FAB 悬浮，弹窗双态复用（I04 编辑走行内入口）。
      floatingActionButton: FloatingActionButton(
        tooltip: '新建成员',
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('全部'),
                  selected: _chipSelected(listState, null),
                  onSelected: (_) => ref
                      .read(
                        memberListControllerProvider(widget.tenantId).notifier,
                      )
                      .setStatusFilter(null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('启用'),
                  selected: _chipSelected(listState, TenantMemberStatus.active),
                  onSelected: (_) => ref
                      .read(
                        memberListControllerProvider(widget.tenantId).notifier,
                      )
                      .setStatusFilter(TenantMemberStatus.active),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('停用'),
                  selected: _chipSelected(
                    listState,
                    TenantMemberStatus.suspended,
                  ),
                  onSelected: (_) => ref
                      .read(
                        memberListControllerProvider(widget.tenantId).notifier,
                      )
                      .setStatusFilter(TenantMemberStatus.suspended),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (listState) {
              MemberListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              MemberListEmpty() => const Center(child: Text('暂无成员')),
              MemberListError(:final message) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => ref
                          .read(
                            memberListControllerProvider(widget.tenantId)
                                .notifier,
                          )
                          .load(),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
              MemberListLoaded(:final items) =>
                items.isEmpty
                    ? const Center(child: Text('无匹配成员'))
                    : RefreshIndicator(
                        onRefresh: () => ref
                            .read(
                              memberListControllerProvider(widget.tenantId)
                                  .notifier,
                            )
                            .load(silent: true),
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            final m = items[i];
                            return ListTile(
                              title: Text(m.username),
                              subtitle: Text(m.email ?? ''),
                              // 行尾写半边（I04 编辑 / I05 删除 / I08 切换）
                              // + 状态徽标；IconButton 自吞点击不与行 onTap 打架。
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _StatusBadge(m.status),
                                  IconButton(
                                    tooltip: '编辑',
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => _openForm(m),
                                  ),
                                  IconButton(
                                    tooltip: '删除',
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => _confirmDelete(m),
                                  ),
                                  if (m.status == TenantMemberStatus.active ||
                                      m.status == TenantMemberStatus.suspended)
                                    IconButton(
                                      tooltip:
                                          m.status == TenantMemberStatus.active
                                          ? '停用'
                                          : '启用',
                                      icon: Icon(
                                        m.status == TenantMemberStatus.active
                                            ? Icons.block_outlined
                                            : Icons.check_circle_outline,
                                      ),
                                      onPressed: () => _toggleStatus(m),
                                    ),
                                ],
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => MemberDetailPage(
                                    tenantId: widget.tenantId,
                                    userId: m.id,
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

  bool _chipSelected(MemberListState s, TenantMemberStatus? filter) =>
      s is MemberListLoaded && s.statusFilter == filter;
}

/// 状态徽标（四值中文映射，memberStatusLabel 穷尽 switch）。
class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);

  final TenantMemberStatus status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ok = status == TenantMemberStatus.active;
    final invited = status == TenantMemberStatus.invited;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: ok
            ? cs.primaryContainer
            : invited
            ? cs.secondaryContainer
            : cs.errorContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        memberStatusLabel(status),
        style: TextStyle(
          fontSize: 12,
          color: ok
              ? cs.onPrimaryContainer
              : invited
              ? cs.onSecondaryContainer
              : cs.onErrorContainer,
        ),
      ),
    );
  }
}
