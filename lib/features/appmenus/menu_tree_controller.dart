import 'package:built_collection/built_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_menus_providers.dart';

/// 根菜单 parentId（后端 b.parentId ?? 零 UUID；契约 parentId 非空）。
const String kMenuRootParentId = '00000000-0000-0000-0000-000000000000';

/// 菜单列表状态机（client_list_controller 同构）：sealed 四态。
sealed class MenuTreeState {
  const MenuTreeState();
}

class MenuTreeLoading extends MenuTreeState {
  const MenuTreeLoading();
}

class MenuTreeLoaded extends MenuTreeState {
  const MenuTreeLoaded({required this.items});

  /// 扁平全量（组树渲染由页面按 parentId 链 DFS 展开）。
  final BuiltList<SysMenu> items;
}

class MenuTreeEmpty extends MenuTreeState {
  const MenuTreeEmpty();
}

class MenuTreeError extends MenuTreeState {
  const MenuTreeError(this.message);

  final String message;
}

/// 菜单管理控制器（REQ-2026-011 M04.F04）：扁平 list + 增删改 + 排序 +
/// 移动。写成功后静默回刷（层级/顺序变更面大，逐项回填不划算；更新除
/// 外——PATCH 响应权威快照按 id 回填）。family by clientId（菜单是
/// client-scoped 面）。
class MenuTreeController extends Notifier<MenuTreeState> {
  MenuTreeController(this.clientId);

  final String clientId;

  @override
  MenuTreeState build() => const MenuTreeLoading();

  Future<void> load({bool silent = false}) async {
    if (!silent) state = const MenuTreeLoading();
    try {
      final resp = await ref
          .read(clientMenusApiProvider)
          .clientMenusListSysMenus(clientId: clientId);
      final items = resp.data!;
      state = items.isEmpty
          ? const MenuTreeEmpty()
          : MenuTreeLoaded(items: items);
    } on Exception {
      state = const MenuTreeError('无法连接服务器');
    }
  }

  /// 创建（I02）：parentId 空 = 顶级（零 UUID）。
  Future<bool> create(CreateSysMenuRequest request) async {
    try {
      await ref
          .read(clientMenusApiProvider)
          .clientMenusCreateSysMenu(
            clientId: clientId,
            createSysMenuRequest: request,
          );
      await load(silent: true);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 更新（I04）：PATCH 不带 parentId（不动父子结构）；响应按 id 回填。
  Future<bool> update(String menuId, UpdateSysMenuRequest request) async {
    try {
      final resp = await ref
          .read(clientMenusApiProvider)
          .clientMenusUpdateSysMenu(
            clientId: clientId,
            menuId: menuId,
            updateSysMenuRequest: request,
          );
      _replace(resp.data!);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 删除（I05）：级联清理子菜单与角色授权（后端语义，确认弹窗明示）。
  Future<bool> remove(String menuId) async {
    try {
      await ref
          .read(clientMenusApiProvider)
          .clientMenusDeleteSysMenu(clientId: clientId, menuId: menuId);
      await load(silent: true);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 同级排序（I06）：orderedMenuIds=该菜单同级（含自身）新顺序。
  Future<bool> reorder(String menuId, BuiltList<String> orderedMenuIds) async {
    try {
      await ref
          .read(clientMenusApiProvider)
          .clientMenusReorderSysMenus(
            clientId: clientId,
            menuId: menuId,
            reorderSysMenuRequest: ReorderSysMenuRequest(
              (b) => b..orderedMenuIds.replace(orderedMenuIds),
            ),
          );
      await load(silent: true);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 切换父级（I07）：PATCH /parent。
  Future<bool> move(String menuId, String? parentId) async {
    try {
      await ref
          .read(clientMenusApiProvider)
          .clientMenusMoveSysMenu(
            clientId: clientId,
            menuId: menuId,
            clientMenusMoveSysMenuRequest: ClientMenusMoveSysMenuRequest(
              (b) => b..parentId = parentId,
            ),
          );
      await load(silent: true);
      return true;
    } on Exception {
      return false;
    }
  }

  void _replace(SysMenu fresh) {
    final current = state;
    if (current is! MenuTreeLoaded) return;
    final idx = current.items.indexWhere((m) => m.id == fresh.id);
    if (idx < 0) return;
    state = MenuTreeLoaded(items: current.items.rebuild((b) => b[idx] = fresh));
  }
}

final menuTreeControllerProvider = NotifierProvider.autoDispose
    .family<MenuTreeController, MenuTreeState, String>(MenuTreeController.new);
