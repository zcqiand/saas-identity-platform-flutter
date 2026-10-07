# REQ-2026-005 M00.F03 租户角色切片（Flutter web）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-07 |
| 优先级 | P0 |
| 状态 | 开发中 |
| 关联 ADR | ADR-0025（role_permissions 端点已废弃，M00.F04 权限矩阵不实现——本片不动权限面） |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（API 面只认 dart-dio 生成物）；M00.F02 租户成员切片（REQ-2026-004，已交付）同仓扩建；生成物已核 `tenant_roles_*` 五方法（`/api/v1/tenants/{tenantId}/roles` 面）+ 后端 zod 校验（saas-nextjs roles route） |

## 1. 需求描述

**用户裁定**（2026-10-07）：「还有很多规划状态没有上线，请继续，加快进程」——租户成员切片交付后按树序推进 M00.F03 租户角色。

**我的理解**：
- 域模型：角色是 **tenant × client 双作用域**（`sys_role` 唯一索引 `uk_tenant_client_role_code`）；`clientId` 创建时必填（zod `min(1)`），列表支持 clientId 过滤（服务端 query 参数）。
- I01 角色列表：租户详情页「角色」入口 → `RoleListPage(tenantId)`，`GET /api/v1/tenants/{tenantId}/roles?page=0&pageSize=50`（0 基判例同构）+ clientId chip 服务端过滤（本机已知 client：saas-console/lab-management，即家族档案 SSO clientId 值表）；响应 `{items, page, pageSize, total}` 服务端分页。
- I02 创建角色：FAB → 弹窗（clientId + roleCode + roleName 必填，description 可选——契约 `CreateSysRoleRequest` 恰此五字段，isPreset 由后端固定 false 不收）→ `POST .../roles`。
- I03 角色详情：行 onTap → 详情页（`GET .../roles/{roleId}` 十字段卡：id/tenantId/clientId/roleCode/roleName/description/isPreset/status/createdAt/updatedAt）。
- I04 更新角色：行编辑 → 弹窗（roleName/description 回填——契约 `UpdateSysRoleRequest` 的 UI 面；status 端点存在但树口径「不动权限与菜单绑定」、无启停场景，不呈现）→ `PUT .../roles/{roleId}`。
- I05 删除角色：行删除 → 确认弹窗（明示「同时移除成员角色绑定与权限关联」树口径）→ `DELETE .../roles/{roleId}`；取消零请求。
- **status 是 smallint 非 enum**（生成面 `int get status`；DB `smallint().default(1)`）：映射 1→启用 / 0→停用，**其他值 throw ArgumentError（禁静默回退）**；`statusFromSmallint` 后端透传无转换。
- 写半边全走弹窗自持（REQ-2026-004 同构）：必填缺失 fail-fast 不发请求；失败留窗保输入；成功收窗 + SnackBar + 列表 silent 回刷。
- API 只用 shared 生成物 barrel；零新依赖。

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | 已登录、mock 后端 | 角色列表加载 | GET 固定 `page=0&pageSize=50` + clientId chip 参数正确拼接；sealed UiState 四态渲染 |
| AC-2 | FAB 弹窗 | 填 clientId/roleCode/roleName(±description) 保存 | POST body 恰 CreateSysRoleRequest 五字段（isPreset 缺省不随）；成功收窗 + SnackBar + silent 回刷 |
| AC-3 | 必填缺失 / 端点失败 | 空保存 / 500 | fail-fast 文案上屏不发请求；失败留窗保输入 |
| AC-4 | 行已有角色 | 点行进详情 | 十字段卡渲染，返回不带残留 |
| AC-5 | 行编辑 | 改 roleName/description 保存 | 弹窗回填；PUT body 恰 UpdateSysRoleRequest 两字段 |
| AC-6 | 行删除 | 确认 / 取消 | 确认弹窗含「成员绑定与权限关联」文案；确认 DELETE + SnackBar + 回刷；取消零请求 |
| AC-7 | 全切片完成 | trace_cmd + 门禁 | trace 恰含本切片 5 ID；全门 exit 0 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 状态 |
|---|---|---|---|---|
| T1 | REQ + 树 5 行翻转（规划→开发中）+ 测试先行（red） | 实现 | Claude | 开发中 |
| T2 | 角色列表（I01）+ 创建/编辑弹窗（I02/I04） | 实现 | Claude | 开发中 |
| T3 | 详情页（I03）+ 删除确认（I05） | 实现 | Claude | 开发中 |
| T4 | trace/门禁/联调 + GA 翻转 | 实现 | Claude | 开发中 |

## 4. 功能影响（需求与功能对齐的唯一位置）

> ID 均已存在于 `docs/functions/function-tree.md`。状态翻转随实现任务分批走（mirror 免批，reason 带 REQ-2026-005）；GA 翻转（→已上线）归联调人工验收后收尾（ACCEPTANCE-2026-10-07 系列同款档案）。

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M00.F03 | 租户角色 | 变更 | 状态 规划 → 开发中（T1） | T1-T4 |
| M00.F03.I01 | 角色列表 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F03.I02 | 创建角色 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F03.I03 | 角色详情 | 变更 | 规划 → 开发中（T3） | T3 |
| M00.F03.I04 | 更新角色 | 变更 | 规划 → 开发中（T2 弹窗双态） | T2 |
| M00.F03.I05 | 删除角色 | 变更 | 规划 → 开发中（T3） | T3 |
