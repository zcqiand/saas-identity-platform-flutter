# REQ-2026-006 M00.F04 角色菜单授权切片（Flutter web）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-07 |
| 优先级 | P0 |
| 状态 | 开发中 |
| 关联 ADR | ADR-0025（role_permissions 端点全家族废弃——本片只做菜单授权，不做权限矩阵；I01 已废弃不翻转） |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（API 面只认 dart-dio 生成物）；M00.F03 租户角色切片（REQ-2026-005，已交付）同仓扩建；生成物已核 `tenant_role_menus_*` 三方法 + 菜单目录 `client_menus_list_sys_menus`（`/api/v1/clients/{clientId}/menus`） |

## 1. 需求描述

**用户裁定**（2026-10-07）：「还有很多规划状态没有上线，请继续，加快进程」——租户角色切片交付后按树序推进 M00.F04 角色菜单授权。

**我的理解**：
- 域模型：授权对象是 **role ↔ menu 集合**（`RoleMenuGrant{roleId, tenantId, menuIds, updatedAt}`）；菜单目录按角色所属 clientId 拉（`clientMenusListSysMenus` → `BuiltList<SysMenu>`，title/path 渲染）——角色是 tenant×client 作用域，菜单是 client 作用域，二者经 clientId 对齐。
- I02 已授权菜单查询：角色列表行「菜单授权」入口 → `RoleMenuGrantPage(tenantId, roleId, clientId, roleName)`，并行拉目录 + 现授权（`GET .../roles/{roleId}/menus`），勾选回显（已授权 checked）。
- I03 整批设置：勾选集变化后「保存授权」→ `PUT .../roles/{roleId}/menus` body `SetSysRoleMenusRequest{menuIds}` **全量替换**（契约语义，恰当前勾选全集）→ SnackBar「授权已保存」+ 静默回读。
- I04 清空：「清空授权」→ 确认弹窗（明示「清空后该角色登录不再渲染任何菜单」）→ `DELETE .../roles/{roleId}/menus` → SnackBar「已清空」+ 回读；取消零请求。
- I01 权限矩阵已废弃（ADR-0025 / shared deprecated-items §1）：不翻转不实现，本片树行只有 F04 + I02/I03/I04。
- 写半边自持：保存/清空失败 SnackBar 留在页内（勾选态不动）；成功才回读。
- API 只用 shared 生成物 barrel；零新依赖。

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | 已登录、mock 后端、角色行有「菜单授权」钮 | 进授权页 | 并行 GET 目录（`/clients/{clientId}/menus`）+ 现授权（`/roles/{roleId}/menus`）；已授权项 checked 回显 |
| AC-2 | 勾选变化 | 保存授权 | PUT body `menuIds` 恰勾选全集（全量替换）；SnackBar + 回读 |
| AC-3 | 清空按钮 | 确认 / 取消 | 确认弹窗含「不再渲染任何菜单」文案；确认 DELETE + SnackBar + 回读；取消零请求 |
| AC-4 | 端点失败 | 500 | SnackBar 失败文案，勾选态原地不动 |
| AC-5 | 全切片完成 | trace_cmd + 门禁 | trace 恰含本切片 3 ID；全门 exit 0 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 状态 |
|---|---|---|---|---|
| T1 | REQ + 树 4 行翻转（规划→开发中）+ 测试先行（red） | 实现 | Claude | 开发中 |
| T2 | 授权页（I02 回显 + I03 整批设置 + I04 清空）+ 角色行入口 | 实现 | Claude | 开发中 |
| T3 | trace/门禁/联调 + GA 翻转 | 实现 | Claude | 开发中 |

## 4. 功能影响（需求与功能对齐的唯一位置）

> ID 均已存在于 `docs/functions/function-tree.md`。状态翻转随实现任务走（mirror 免批，reason 带 REQ-2026-006）；GA 翻转（→已上线）归联调人工验收后收尾。I01 已废弃不翻转。

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M00.F04 | 角色权限 | 变更 | 状态 规划 → 开发中（T1）；只做菜单授权面（ADR-0025） | T1-T3 |
| M00.F04.I02 | 角色已授权菜单查询 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F04.I03 | 整批设置角色菜单 | 变更 | 规划 → 开发中（T2，PUT 全量替换） | T2 |
| M00.F04.I04 | 清空角色菜单 | 变更 | 规划 → 开发中（T2，DELETE + 确认） | T2 |
