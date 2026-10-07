# REQ-2026-008 M01 用户管理切片（Flutter web）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-07 |
| 优先级 | P0 |
| 状态 | 开发中 |
| 关联 ADR | — |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（API 面只认 dart-dio 生成物）；REQ-2026-007 租户应用切片（已交付）同仓扩建；生成物已核 `meWhoami`（GET `/api/v1/me` → `CurrentUser`）/ `meListMyTenants`（GET `/api/v1/me/tenants` → `BuiltList<TenantMembership>`）/ `meSwitchTenant`（POST `/api/v1/me/tenants/{tenantId}/switch` → `SwitchTenantResponse`）/ `tenantMembersAssignTenantMemberRoles`（PUT `/api/v1/tenants/{tenantId}/members/{userId}/roles`，body `SetTenantMemberRolesRequest{roleIds}`）四方法 |

## 1. 需求描述

**用户裁定**（2026-10-07）：「还有很多规划状态没有上线，请继续，加快进程」——M00 模块五切片全交付后按树序推进 M01 用户管理域（F04 SSO 三子项已上线，余 F01/F02/F03）。

**我的理解**：
- **M01.F01.I01 whoami**：「我」页（`MePage`，`_Shell` appbar「我」入口）→ `meWhoami()`；渲染 用户ID / 邮箱 / 当前租户（`currentTenantId`，空显 `—`）。**树口径说明写的是 id/email/displayName，生成物 `CurrentUser` 无 displayName 字段、带 `memberships`/`currentTenantId`——API 面只认生成物（suite 硬规则 §4），按生成物渲染。**
- **M01.F03.I01 列出我的租户成员关系**：「我」页内成员关系列表 → `meListMyTenants()`；行渲染 tenantId + 角色数（roleIds.length）+ 状态徽标 + 加入日期。状态是枚举四值：active→启用 / invited→邀请中 / suspended→停用 / disabled→禁用，**穷举 switch 其他值 throw（禁静默回退，前片同源纪律）**。
- **M01.F03.I02 切换当前租户**：成员关系行「切换」→ `meSwitchTenant(tenantId)`；成功 SnackBar「已切换到 <tenantId>」+ whoami silent 回刷（当前租户展示更新）。`SwitchTenantResponse` 带 token 四字段是 OAuth 态契约形状，本端会话走 cookie——**UI 只消费调用成功事实，不落 token**。
- **M01.F02.I01 分配角色**：成员列表行「角色」IconButton → `AssignMemberRolesDialog(tenantId, member)`：加载 `tenantRolesListSysRoles(tenantId)`（全客户端角色池），CheckboxListTile 预勾 `member.roleIds`；保存 `PUT .../members/{userId}/roles` body `{roleIds}` **全量覆盖**（清空=合法语义）；成功收窗 SnackBar「角色已更新」+ 成员列表 silent 回刷；失败留窗保勾选。
- 寻址/同路径安全：switch 与 list 不同路径、roles GET 与成员 roles PUT 不同路径（无 ③c 折叠需求）；whoami 回刷与业务写零同径。
- API 只用 shared 生成物 barrel；零新依赖。

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | 已登录、mock 后端 | 「我」页加载 | GET `/api/v1/me`；用户ID/邮箱/当前租户渲染 |
| AC-2 | 「我」页加载 | 成员关系列表 | GET `/api/v1/me/tenants`；行渲染 tenantId/角色数/状态徽标/加入日期 |
| AC-3 | 关系行点「切换」 | 切换租户 | POST `/api/v1/me/tenants/{tenantId}/switch`；SnackBar + whoami 回刷当前租户更新 |
| AC-4 | 成员列表行点「角色」 | 勾选保存 | 弹窗预勾既有 roleIds；PUT body 恰 `{roleIds}` 全量覆盖；成功收窗 + 回刷 |
| AC-5 | 弹窗失败路径 | 500 | 留窗保勾选；whoami/tenants 失败错误态可重试 |
| AC-6 | 全切片完成 | trace_cmd + 门禁 | trace 恰含本切片 4 ID；全门 exit 0 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 状态 |
|---|---|---|---|---|
| T1 | REQ + 树 8 行翻转（规划→开发中）+ 测试先行（red，锚随写随带） | 实现 | Claude | 开发中 |
| T2 | 「我」页（I01+F03 两件）+ 分配角色弹窗（F02.I01）+ 入口接线 | 实现 | Claude | 开发中 |
| T3 | trace/门禁/联调 + GA 翻转 | 实现 | Claude | 开发中 |

## 4. 功能影响（需求与功能对齐的唯一位置）

> ID 均已存在于 `docs/functions/function-tree.md`。状态翻转随实现任务走（mirror 免批，reason 带 REQ-2026-008）；GA 翻转（→已上线）归联调人工验收后收尾。

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M01 | 用户管理 | 变更 | 状态 规划 → 开发中（T1，模块行随域开工翻转） | T1-T3 |
| M01.F01 | 用户维护 | 变更 | 状态 规划 → 开发中（T1） | T1-T3 |
| M01.F01.I01 | 当前用户 whoami | 变更 | 规划 → 开发中（T2） | T2 |
| M01.F02 | 角色成员 | 变更 | 状态 规划 → 开发中（T1） | T1-T3 |
| M01.F02.I01 | 分配角色 | 变更 | 规划 → 开发中（T2） | T2 |
| M01.F03 | 租户成员 | 变更 | 状态 规划 → 开发中（T1） | T1-T3 |
| M01.F03.I01 | 列出我的租户成员关系 | 变更 | 规划 → 开发中（T2） | T2 |
| M01.F03.I02 | 切换当前租户 | 变更 | 规划 → 开发中（T2） | T2 |
