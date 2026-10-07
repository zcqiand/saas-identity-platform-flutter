# REQ-2026-011 — M04.F04 菜单管理 flutter 侧（7 子项；I08 待契约修正排除）

> 范围：M04.F04.I01~I07 共 **7 I 行**。I08 当前用户有效菜单**不在本片**——
> 树行口径「待 PLAN-2026-004 shared 契约修正后补角」，保持规划态。

## 背景

- 后端侧已随 REQ-2026-008 瘦身切片上线（树 F04 行备注：CRUD+组树）；
  本片补 flutter 控制台面（client-scoped SysMenu 管理）。
- 生成物齐备：`ClientMenusApi` 七方法。**方法面注意**：create=POST、
  update=**PATCH**、move=**PATCH** `/parent`、reorder=**PUT** `/reorder`、
  delete=DELETE、get/list=GET。
- 消费侧已有 `role_menu_grant_page.dart`（M00.F04.I02，角色授权菜单）读
  同一 list——本片是管理面（CRUD/排序/移动），互不覆盖。

## 锚定子项（AC）

| ID | 子项 | AC |
|---|---|---|
| M04.F04.I01 | 菜单列表 | GET `/api/v1/clients/{clientId}/menus`（BuiltList 扁平）；按 parentId 链组树 DFS 渲染，层级缩进可见 |
| M04.F04.I02 | 创建菜单 | POST 同路径；body title(必填)/type(directory/menu/button)/parentId(可空=顶级)/path/component/perms/icon/sortOrder；成功回刷 |
| M04.F04.I03 | 菜单详情 | GET `.../menus/{menuId}`；全字段弹窗呈现 |
| M04.F04.I04 | 更新菜单 | **PATCH** `.../menus/{menuId}`；body title/path/component/perms/icon/sortOrder——**不带 parentId**（树口径「不动父子结构」，父子变更走 I07） |
| M04.F04.I05 | 删除菜单 | DELETE `.../menus/{menuId}`；确认弹窗明示「级联清理子菜单与角色菜单授权」语义 |
| M04.F04.I06 | 同级排序 | **PUT** `.../menus/{menuId}/reorder` body `{orderedMenuIds}`=该菜单同级（含自身）新顺序；行内 上移/下移 |
| M04.F04.I07 | 切换父级 | **PATCH** `.../menus/{menuId}/parent` body `{parentId}`；「移动」入口弹父级选择（顶级 + 目录节点） |

## 生成物口径

- `SysMenuType` 枚举 directory/menu/button → 目录/菜单/按钮。
- 根菜单 parentId wire=零 UUID `00000000-0000-0000-0000-000000000000`
  （后端 `b.parentId ?? 0-uuid`，契约 parentId 非空——组树时零 UUID 视为根）。
- `UpdateSysMenuRequest.parentId` 存在但**不用于 I04**（树口径父子结构变更
  归 I07 专用端点）。

## 入口

应用详情页（REQ-2026-010 `ClientDetailPage`）appbar 加「菜单」→
`MenuTreePage(clientId)`（client-scoped）。

## 测试计划

`test/features/appmenus/menu_admin_test.dart` 8 测（7 锚 + 1 错误态）。
路径 ③c 无冲突：list GET vs create POST 异方法；detail GET vs update
PATCH vs delete DELETE 异方法同路径（folded 各自 handler）；reorder PUT
与 move PATCH 异路径。fixtures 复用 `menuJson`（clientId 可覆写）。

## 任务

- T1：本 REQ + 树 8 行翻转（F04 + 7 I）+ 测试先行（red）
- T2：实现（providers/tree page/form dialog/detail+move 弹窗 + 详情页入口）
- T3：trace + gate 全绿
- T4：commit + push + handoff

## 影响表

| 层 | 文件/对象 | 动作 |
|---|---|---|
| F | M04.F04 菜单管理 | 树 规划→开发中 |
| I | M04.F04.I01~I07 | 树 规划→开发中（7 行） |
| I | M04.F04.I08 | 保持 规划（待 PLAN-2026-004 契约修正） |
| lib | features/appmenus/*（4 新文件） | 新增 |
| lib | features/appadmin/client_detail_page.dart | 加「菜单」入口 |
| test | features/appmenus/menu_admin_test.dart | 新增 |
