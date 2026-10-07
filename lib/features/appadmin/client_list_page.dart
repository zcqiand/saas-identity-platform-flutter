// @entry M04.F01.I01
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'client_detail_page.dart';
import 'client_form_dialog.dart';
import 'client_list_controller.dart';
import 'client_status_label.dart';

/// 平台 admin 应用列表（REQ-2026-010 M04.F01.I01）：行内 编辑（I04）/
/// 删除（I05）/ 启停（M04.F02.I01），行 onTap 详情（I03），FAB 新建
/// （I02）。入口：主壳「应用」。
class ClientListPage extends ConsumerStatefulWidget {
  const ClientListPage({super.key});

  @override
  ConsumerState<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends ConsumerState<ClientListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(clientListControllerProvider.notifier).load(),
    );
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openForm([OAuthClient? existing]) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => ClientFormDialog(existing: existing),
    );
    if (!mounted) return;
    if (saved ?? false) {
      _toast(existing == null ? '应用已创建' : '应用已更新');
    }
  }

  /// 删除确认（I05）：文案明示「吊销该 client 名下所有 access/refresh
  /// token」语义；确认 → DELETE + 回刷。
  Future<void> _confirmDelete(OAuthClient c) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除应用'),
        content: Text(
          '确认删除应用「${c.clientName}」？将移除应用并吊销该 client 名下所有 access/refresh token，不可恢复。',
        ),
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
    final ok = await ref
        .read(clientListControllerProvider.notifier)
        .remove(c.clientId);
    if (!mounted) return;
    _toast(ok ? '应用已删除' : '删除失败，请重试');
  }

  /// 启停（M04.F02.I01）：1=启用 ⇄ 0=停用；PUT 响应回填即时翻转。
  Future<void> _toggleStatus(OAuthClient c) async {
    final target = c.status == 1 ? 0 : 1;
    final ok = await ref
        .read(clientListControllerProvider.notifier)
        .setStatus(c, target);
    if (!mounted) return;
    _toast(ok ? (target == 0 ? '应用已停用' : '应用已启用') : '状态切换失败，请重试');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientListControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('应用')),
      floatingActionButton: FloatingActionButton(
        tooltip: '新建应用',
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
      body: switch (state) {
        ClientListLoading() => const Center(child: CircularProgressIndicator()),
        ClientListEmpty() => const Center(child: Text('暂无应用')),
        ClientListError(:final message) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              TextButton(
                onPressed: () =>
                    ref.read(clientListControllerProvider.notifier).load(),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
        ClientListLoaded(:final items) => RefreshIndicator(
          onRefresh: () => ref
              .read(clientListControllerProvider.notifier)
              .load(silent: true),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final c = items[i];
              final active = c.status == 1;
              return ListTile(
                title: Text(c.clientName),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: active
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.errorContainer
                                  .withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        clientStatusLabel(c.status),
                        style: TextStyle(
                          fontSize: 12,
                          color: active
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(c.clientId),
                  ],
                ),
                // 行尾写半边（I04 编辑 / I05 删除 / F02.I01 启停）；
                // IconButton 自吞点击不与行 onTap 打架。
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: active ? '停用' : '启用',
                      icon: Icon(
                        active
                            ? Icons.block_outlined
                            : Icons.check_circle_outline,
                      ),
                      onPressed: () => _toggleStatus(c),
                    ),
                    IconButton(
                      tooltip: '编辑',
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _openForm(c),
                    ),
                    IconButton(
                      tooltip: '删除',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _confirmDelete(c),
                    ),
                  ],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => ClientDetailPage(clientId: c.clientId),
                  ),
                ),
              );
            },
            separatorBuilder: (_, _) => const Divider(height: 1),
          ),
        ),
      },
    );
  }
}
