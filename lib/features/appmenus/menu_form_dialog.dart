// @entry M04.F04.I02
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'menu_tree_controller.dart';

/// 菜单表单弹窗（REQ-2026-011）：I02 创建 / I04 编辑双态复用。
/// 创建可选父级（顶级=零 UUID）；编辑不提交 parentId（树口径「不动父子
/// 结构」，父子变更走 I07 移动端点）。
class MenuFormDialog extends ConsumerStatefulWidget {
  const MenuFormDialog({super.key, required this.clientId, this.existing});

  final String clientId;
  final SysMenu? existing;

  @override
  ConsumerState<MenuFormDialog> createState() => _MenuFormDialogState();
}

class _MenuFormDialogState extends ConsumerState<MenuFormDialog> {
  late final TextEditingController _title;
  late final TextEditingController _path;
  late final TextEditingController _icon;
  late final TextEditingController _perms;
  late final TextEditingController _sortOrder;
  SysMenuType _type = SysMenuType.menu;
  String? _parentId; // null=顶级
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  /// 父级候选 = 目录节点（本片口径：菜单挂目录）。
  List<SysMenu> get _parentCandidates {
    final state = ref.watch(menuTreeControllerProvider(widget.clientId));
    return state is MenuTreeLoaded
        ? state.items
              .where(
                (m) =>
                    m.type == SysMenuType.directory &&
                    m.id != widget.existing?.id,
              )
              .toList()
        : const <SysMenu>[];
  }

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _title = TextEditingController(text: e?.title);
    _path = TextEditingController(text: e?.path);
    _icon = TextEditingController(text: e?.icon);
    _perms = TextEditingController(text: e?.perms);
    _sortOrder = TextEditingController(
      text: e == null ? null : '${e.sortOrder}',
    );
    _type = e?.type ?? SysMenuType.menu;
    _parentId = e?.parentId;
  }

  @override
  void dispose() {
    _title.dispose();
    _path.dispose();
    _icon.dispose();
    _perms.dispose();
    _sortOrder.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) {
      setState(() => _error = '请填写标题');
      return;
    }
    final controller = ref.read(
      menuTreeControllerProvider(widget.clientId).notifier,
    );
    final sortOrder = int.tryParse(_sortOrder.text.trim());
    setState(() => _saving = true);
    bool ok;
    if (_isEdit) {
      ok = await controller.update(
        widget.existing!.id,
        UpdateSysMenuRequest(
          (b) => b
            ..title = title
            ..type = _type
            ..path = _path.text.trim()
            ..icon = _icon.text.trim()
            ..perms = _perms.text.trim()
            ..sortOrder = sortOrder,
        ),
      );
    } else {
      ok = await controller.create(
        CreateSysMenuRequest(
          (b) => b
            ..title = title
            ..type = _type
            ..parentId = _parentId ?? kMenuRootParentId
            ..path = _path.text.trim()
            ..icon = _icon.text.trim()
            ..perms = _perms.text.trim()
            ..sortOrder = sortOrder,
        ),
      );
    }
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _saving = false;
        _error = '保存失败，请重试';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final parents = _parentCandidates;
    return AlertDialog(
      title: Text(_isEdit ? '编辑菜单' : '新建菜单'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: '标题'),
            ),
            DropdownButtonFormField<SysMenuType>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: '类型'),
              items: const [
                DropdownMenuItem(
                  value: SysMenuType.directory,
                  child: Text('目录'),
                ),
                DropdownMenuItem(value: SysMenuType.menu, child: Text('菜单')),
                DropdownMenuItem(value: SysMenuType.button, child: Text('按钮')),
              ],
              onChanged: (v) => setState(() => _type = v!),
            ),
            if (!_isEdit)
              DropdownButtonFormField<String>(
                initialValue: _parentId,
                decoration: const InputDecoration(labelText: '父级'),
                items: [
                  const DropdownMenuItem<String>(child: Text('顶级')),
                  ...parents.map(
                    (p) => DropdownMenuItem<String>(
                      value: p.id,
                      child: Text(p.title),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _parentId = v),
              ),
            TextField(
              controller: _path,
              decoration: const InputDecoration(
                labelText: '路径',
                helperText: '选填',
              ),
            ),
            TextField(
              controller: _icon,
              decoration: const InputDecoration(
                labelText: '图标',
                helperText: '选填',
              ),
            ),
            TextField(
              controller: _perms,
              decoration: const InputDecoration(
                labelText: '权限码',
                helperText: '选填',
              ),
            ),
            TextField(
              controller: _sortOrder,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '排序号',
                helperText: '整数，选填',
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_isEdit ? '保存' : '创建'),
        ),
      ],
    );
  }
}
