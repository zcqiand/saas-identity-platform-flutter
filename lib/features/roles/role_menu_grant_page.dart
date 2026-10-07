// @entry M00.F04.I02
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'role_providers.dart';

/// 角色菜单授权页（M00.F04.I02 回显 / I03 整批设置 / I04 清空）：
/// 目录按角色 clientId 拉（client 作用域），现授权按 roleId 拉——经 clientId
/// 对齐；保存 = PUT 全量替换（契约语义，恰勾选全集）；清空 = DELETE +
/// 确认（明示「清空后该角色登录不再渲染任何菜单」）。入口：角色列表行
/// 「菜单授权」。I01 权限矩阵已废弃（ADR-0025）不呈现。
class RoleMenuGrantPage extends ConsumerStatefulWidget {
  const RoleMenuGrantPage({
    super.key,
    required this.tenantId,
    required this.roleId,
    required this.clientId,
    required this.roleName,
  });

  final String tenantId;
  final String roleId;
  final String clientId;
  final String roleName;

  @override
  ConsumerState<RoleMenuGrantPage> createState() => _RoleMenuGrantPageState();
}

class _RoleMenuGrantPageState extends ConsumerState<RoleMenuGrantPage> {
  BuiltList<SysMenu>? _catalog;
  Set<String> _checked = <String>{};
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// 并行拉目录 + 现授权（I02）；任一失败整页错误态。
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await Future.wait([
        ref
            .read(clientMenusApiProvider)
            .clientMenusListSysMenus(clientId: widget.clientId)
            .then((r) => r.data!),
        ref
            .read(roleMenuGrantApiProvider)
            .tenantRoleMenusListSysRoleMenus(
              tenantId: widget.tenantId,
              roleId: widget.roleId,
            )
            .then((r) => r.data!),
      ]);
      if (!mounted) return;
      setState(() {
        _catalog = results[0] as BuiltList<SysMenu>;
        _checked = (results[1] as RoleMenuGrant).menuIds.toSet();
        _loading = false;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.response == null ? '无法连接服务器' : '加载失败';
        _loading = false;
      });
    }
  }

  /// 整批设置（I03）：PUT body 恰当前勾选全集（全量替换语义）。
  Future<void> _save() async {
    try {
      await ref
          .read(roleMenuGrantApiProvider)
          .tenantRoleMenusSetSysRoleMenus(
            tenantId: widget.tenantId,
            roleId: widget.roleId,
            setSysRoleMenusRequest: SetSysRoleMenusRequest(
              (b) => b..menuIds.replace(BuiltList<String>(_checked)),
            ),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('授权已保存')));
      await _load(); // 静默回读（勾选态与服务端对齐）
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response == null ? '无法连接服务器' : '保存失败，请重试')),
      );
    }
  }

  /// 清空（I04）：确认 → DELETE → 回读；取消零请求。
  Future<void> _confirmClear() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('清空授权'),
        content: Text('确认清空角色「${widget.roleName}」的全部菜单授权？清空后该角色登录将不再渲染任何菜单。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('确认清空'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref
          .read(roleMenuGrantApiProvider)
          .tenantRoleMenusClearSysRoleMenus(
            tenantId: widget.tenantId,
            roleId: widget.roleId,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已清空')));
      await _load();
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response == null ? '无法连接服务器' : '清空失败，请重试')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final catalog = _catalog;
    return Scaffold(
      appBar: AppBar(title: Text('菜单授权 · ${widget.roleName}')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_error!),
                  const SizedBox(height: 8),
                  FilledButton(onPressed: _load, child: const Text('重试')),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      FilledButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('保存授权'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: _confirmClear,
                        icon: const Icon(Icons.clear_all),
                        label: const Text('清空授权'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (final m in catalog!)
                        CheckboxListTile(
                          value: _checked.contains(m.id),
                          title: Text(m.title),
                          subtitle: Text(m.path ?? ''),
                          onChanged: (v) => setState(() {
                            if (v ?? false) {
                              _checked.add(m.id);
                            } else {
                              _checked.remove(m.id);
                            }
                          }),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
