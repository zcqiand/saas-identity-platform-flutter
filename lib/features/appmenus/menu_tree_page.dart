// @entry M04.F04.I01
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/features/appmenus/menu_form_dialog.dart';
import 'package:saas_identity_platform_flutter/features/appmenus/menu_tree_controller.dart';
import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_menus_providers.dart';

/// 菜单管理页（REQ-2026-011 M04.F04.I01）：client-scoped，扁平 list 按
/// parentId 链组树 DFS 渲染（缩进=层级）。行内 上移/下移（I06）/移动
/// （I07）/编辑（I04）/删除（I05），行 onTap 详情（I03），FAB 新建（I02）。
/// 入口：应用详情页「菜单」。
class MenuTreePage extends ConsumerStatefulWidget {
  const MenuTreePage({super.key, required this.clientId});

  final String clientId;

  @override
  ConsumerState<MenuTreePage> createState() => _MenuTreePageState();
}

class _MenuTreePageState extends ConsumerState<MenuTreePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(menuTreeControllerProvider(widget.clientId).notifier).load(),
    );
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// 扁平 → DFS 序 (menu, depth)。根 = parentId 零 UUID。
  List<(SysMenu, int)> _dfs(BuiltList<SysMenu> items) {
    final byParent = <String, List<SysMenu>>{};
    for (final m in items) {
      byParent.putIfAbsent(m.parentId, () => []).add(m);
    }
    for (final list in byParent.values) {
      list.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }
    final out = <(SysMenu, int)>[];
    void walk(String parentId, int depth) {
      for (final m in byParent[parentId] ?? const <SysMenu>[]) {
        out.add((m, depth));
        walk(m.id, depth + 1);
      }
    }

    walk(kMenuRootParentId, 0);
    // 防御：孤儿节点（父不在集中）挂尾，不静默丢行。
    final seen = out.map((e) => e.$1.id).toSet();
    for (final m in items) {
      if (!seen.contains(m.id)) out.add((m, 0));
    }
    return out;
  }

  /// 同级序列（含自身，按 sortOrder）——I06 上移/下移的全量 orderedMenuIds。
  BuiltList<String> _siblingIds(BuiltList<SysMenu> items, SysMenu m) {
    final siblings = items.where((x) => x.parentId == m.parentId).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return BuiltList<String>(siblings.map((x) => x.id));
  }

  Future<void> _reorder(SysMenu m, int shift) async {
    final state = ref.read(menuTreeControllerProvider(widget.clientId));
    if (state is! MenuTreeLoaded) return;
    final ids = _siblingIds(state.items, m);
    final idx = ids.indexOf(m.id);
    final target = idx + shift;
    if (target < 0 || target >= ids.length) return; // 已在端头
    final next = ids.rebuild((b) {
      final id = b.removeAt(idx);
      b.insert(target, id);
    });
    final ok = await ref
        .read(menuTreeControllerProvider(widget.clientId).notifier)
        .reorder(m.id, next);
    if (!mounted) return;
    _toast(ok ? '排序已更新' : '排序失败，请重试');
  }

  Future<void> _openForm([SysMenu? existing]) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) =>
          MenuFormDialog(clientId: widget.clientId, existing: existing),
    );
    if (!mounted) return;
    if (saved ?? false) {
      _toast(existing == null ? '菜单已创建' : '菜单已更新');
    }
  }

  /// 详情（I03）：GET 单体全字段弹窗。
  Future<void> _openDetail(SysMenu m) async {
    final scaffold = ScaffoldMessenger.of(context);
    try {
      final resp = await ref
          .read(clientMenusApiProvider)
          .clientMenusGetSysMenu(clientId: widget.clientId, menuId: m.id);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => _MenuDetailDialog(menu: resp.data!),
      );
    } on Exception {
      scaffold.showSnackBar(const SnackBar(content: Text('无法连接服务器')));
    }
  }

  /// 移动（I07）：父级选择弹窗（顶级 + 除自身外全部节点），选中后
  /// 「移动」确认（两段式，误触即弹不友好）。
  Future<void> _openMove(SysMenu m) async {
    final state = ref.read(menuTreeControllerProvider(widget.clientId));
    if (state is! MenuTreeLoaded) return;
    final picked = await showDialog<String>(
      context: context,
      builder: (_) => _MoveDialog(menu: m, candidates: state.items),
    );
    if (picked == null || !mounted) return;
    final ok = await ref
        .read(menuTreeControllerProvider(widget.clientId).notifier)
        .move(m.id, picked);
    if (!mounted) return;
    _toast(ok ? '已移动' : '移动失败，请重试');
  }

  /// 删除确认（I05）：明示级联语义（子菜单 + 角色授权一并清理）。
  Future<void> _confirmDelete(SysMenu m) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除菜单'),
        content: Text('确认删除菜单「${m.title}」？将级联清理其子菜单与角色菜单授权，不可恢复。'),
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
        .read(menuTreeControllerProvider(widget.clientId).notifier)
        .remove(m.id);
    if (!mounted) return;
    _toast(ok ? '菜单已删除' : '删除失败，请重试');
  }

  String _typeLabel(SysMenuType t) => _menuTypeLabel(t);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(menuTreeControllerProvider(widget.clientId));
    return Scaffold(
      appBar: AppBar(title: Text('菜单 · ${widget.clientId}')),
      floatingActionButton: FloatingActionButton(
        tooltip: '新建菜单',
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
      body: switch (state) {
        MenuTreeLoading() => const Center(child: CircularProgressIndicator()),
        MenuTreeEmpty() => const Center(child: Text('暂无菜单')),
        MenuTreeError(:final message) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              TextButton(
                onPressed: () => ref
                    .read(menuTreeControllerProvider(widget.clientId).notifier)
                    .load(),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
        MenuTreeLoaded(:final items) => RefreshIndicator(
          onRefresh: () => ref
              .read(menuTreeControllerProvider(widget.clientId).notifier)
              .load(silent: true),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final rows = _dfs(items);
              if (i >= rows.length) return const SizedBox.shrink();
              final (m, depth) = rows[i];
              return ListTile(
                contentPadding: EdgeInsets.only(left: 16 + depth * 24.0),
                leading: Icon(_menuTypeIcon(m.type)),
                title: Text(m.title),
                subtitle: Text(
                  '${_typeLabel(m.type)}${m.path == null ? '' : ' · ${m.path}'}',
                ),
                // 行尾写半边（I06 排序 / I07 移动 / I04 编辑 / I05 删除）。
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: '上移',
                      icon: const Icon(Icons.arrow_upward_outlined),
                      onPressed: () => _reorder(m, -1),
                    ),
                    IconButton(
                      tooltip: '下移',
                      icon: const Icon(Icons.arrow_downward_outlined),
                      onPressed: () => _reorder(m, 1),
                    ),
                    IconButton(
                      tooltip: '移动',
                      icon: const Icon(Icons.drive_file_move_outlined),
                      onPressed: () => _openMove(m),
                    ),
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
                  ],
                ),
                onTap: () => _openDetail(m),
              );
            },
            separatorBuilder: (_, _) => const Divider(height: 1),
          ),
        ),
      },
    );
  }
}

/// SysMenuType 中文/图标（EnumClass 非密封：穷举 + 其他 throw，
/// member_status_label 同款纪律；三处共用防漂移）。
String _menuTypeLabel(SysMenuType t) => switch (t) {
  SysMenuType.directory => '目录',
  SysMenuType.menu => '菜单',
  SysMenuType.button => '按钮',
  _ => throw ArgumentError('未知 SysMenuType: ${t.name}'),
};

IconData _menuTypeIcon(SysMenuType t) => switch (t) {
  SysMenuType.directory => Icons.folder_outlined,
  SysMenuType.menu => Icons.article_outlined,
  SysMenuType.button => Icons.radio_button_checked_outlined,
  _ => throw ArgumentError('未知 SysMenuType: ${t.name}'),
};

/// 移动弹窗（I07）：单选父级，「移动」FilledButton 确认。
class _MoveDialog extends StatefulWidget {
  const _MoveDialog({required this.menu, required this.candidates});

  final SysMenu menu;
  final BuiltList<SysMenu> candidates;

  @override
  State<_MoveDialog> createState() => _MoveDialogState();
}

class _MoveDialogState extends State<_MoveDialog> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('移动到'),
      content: SizedBox(
        width: 280,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: const Text('顶级'),
              selected: _selected == kMenuRootParentId,
              onTap: () => setState(() => _selected = kMenuRootParentId),
            ),
            ...widget.candidates
                .where((x) => x.id != widget.menu.id)
                .map(
                  (x) => ListTile(
                    leading: const Icon(Icons.folder_outlined),
                    title: Text(x.title),
                    selected: _selected == x.id,
                    onTap: () => setState(() => _selected = x.id),
                  ),
                ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _selected == null
              ? null
              : () => Navigator.of(context).pop(_selected),
          child: const Text('移动'),
        ),
      ],
    );
  }
}

/// 详情弹窗（I03）：GET 单体全字段。
class _MenuDetailDialog extends StatelessWidget {
  const _MenuDetailDialog({required this.menu});

  final SysMenu menu;

  @override
  Widget build(BuildContext context) {
    String yn(bool v) => v ? '是' : '否';
    return AlertDialog(
      title: const Text('菜单详情'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row('ID', menu.id),
          _row('标题', menu.title),
          _row('类型', _menuTypeLabel(menu.type)),
          _row('父级', menu.parentId),
          _row('路径', menu.path ?? '—'),
          _row('组件', menu.component ?? '—'),
          _row('权限码', menu.perms ?? '—'),
          _row('图标', menu.icon ?? '—'),
          _row('排序号', '${menu.sortOrder}'),
          _row('状态', yn(menu.status == 1)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 72, child: Text(label)),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
