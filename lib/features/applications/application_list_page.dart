// @entry M00.F05.I01
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_providers.dart';
import 'application_list_controller.dart';
import 'application_status_label.dart';
import 'subscribe_application_dialog.dart';

/// 应用列表页（M00.F05.I01）：行寻址键=clientId；行内启停（I03）body
/// 恰 status、移除确认（I04）明示不删除应用本体。
class ApplicationListPage extends ConsumerStatefulWidget {
  const ApplicationListPage({super.key, required this.tenantId});

  final String tenantId;

  @override
  ConsumerState<ApplicationListPage> createState() =>
      _ApplicationListPageState();
}

class _ApplicationListPageState extends ConsumerState<ApplicationListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(applicationListControllerProvider(widget.tenantId).notifier)
          .load(),
    );
  }

  ApplicationListController get _controller =>
      ref.read(applicationListControllerProvider(widget.tenantId).notifier);

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _subscribe() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => SubscribeApplicationDialog(tenantId: widget.tenantId),
    );
    if (ok != true) return;
    await _controller.load(silent: true);
    if (!mounted) return;
    _toast('订阅已添加');
  }

  /// 行内启停（M00.F05.I03）：body 恰 status（expireTime 不随），
  /// 成功后以 PUT 响应原位替换该行（后端回包即权威状态）。
  Future<void> _toggle(TenantApplication app) async {
    final ok = await _controller.setStatus(app, app.status == 1 ? 2 : 1);
    if (!mounted) return;
    if (!ok) _toast('操作失败，请重试');
  }

  /// 移除订阅（M00.F05.I04）：确认文案明示只解绑、不删除应用本体。
  Future<void> _remove(TenantApplication app) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('移除订阅'),
        content: Text(
          '确认移除订阅「${app.clientId}」？仅解除本租户与该应用的绑定，'
          '不删除应用本体。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref
          .read(tenantApplicationsApiProvider)
          .tenantApplicationsRemoveTenantApplication(
            tenantId: widget.tenantId,
            clientId: app.clientId,
          );
      await _controller.load(silent: true);
      if (!mounted) return;
      _toast('已移除订阅');
    } on DioException {
      if (!mounted) return;
      _toast('操作失败，请重试');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(applicationListControllerProvider(widget.tenantId));
    return Scaffold(
      appBar: AppBar(title: const Text('应用')),
      floatingActionButton: FloatingActionButton(
        tooltip: '订阅应用',
        onPressed: _subscribe,
        child: const Icon(Icons.add),
      ),
      body: switch (state) {
        ApplicationListLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        ApplicationListError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message),
              TextButton(onPressed: _controller.load, child: const Text('重试')),
            ],
          ),
        ),
        ApplicationListEmpty() => const Center(child: Text('暂无订阅应用')),
        ApplicationListLoaded() => RefreshIndicator(
          onRefresh: _controller.load,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.items.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final app = state.items[index];
              final active = app.status == 1;
              return ListTile(
                title: Text(app.clientId),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatusBadge(label: applicationStatusLabel(app.status)),
                    if (app.expireTime != null)
                      Text(_dateOnly(app.expireTime!)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: active ? '停用' : '启用',
                      icon: Icon(
                        active
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                      ),
                      onPressed: () => _toggle(app),
                    ),
                    IconButton(
                      tooltip: '删除',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _remove(app),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      },
    );
  }

  String _dateOnly(DateTime d) =>
      d.toLocal().toIso8601String().substring(0, 10);
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: scheme.onSecondaryContainer),
      ),
    );
  }
}
