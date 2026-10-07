# REQ-2026-007 M00.F05 租户应用切片（Flutter web）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-07 |
| 优先级 | P0 |
| 状态 | 开发中 |
| 关联 ADR | — |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（API 面只认 dart-dio 生成物）；M00.F04 角色菜单授权切片（REQ-2026-006，已交付）同仓扩建；生成物已核 `tenant_applications_*` 四方法（`/api/v1/tenants/{tenantId}/applications` 面，**clientId 寻址**非自增 id）+ 后端 zod 校验（saas-nextjs applications route） |

## 1. 需求描述

**用户裁定**（2026-10-07）：「还有很多规划状态没有上线，请继续，加快进程」——角色菜单授权切片交付后按树序推进 M00.F05 租户应用。

**我的理解**：
- 域模型：`tenant_application` 订阅行（`TenantApplication{id, tenantId, clientId, status, expireTime?, createdAt}` 六字段）；**寻址键是 clientId**（I03/I04 路径 `/applications/{clientId}`）。
- I01 列出租户应用：租户详情页「应用」入口 → `ApplicationListPage(tenantId)`，`GET /api/v1/tenants/{tenantId}/applications`；行渲染 clientId + 状态徽标 + 到期时间。
- I02 订阅应用：FAB → 弹窗（clientId 必填 + 到期时间选填 `yyyy-MM-dd`——契约 `SubscribeTenantApplicationRequest{clientId, expireTime?}` 恰两字段，留空不随 body）→ `POST .../applications`。
- I03 更新订阅：行内启停（1⇄2）→ `PUT .../applications/{clientId}` body `UpdateTenantApplicationRequest{status}`（expireTime 不动不随 body）。
- I04 移除订阅：行删除 → 确认弹窗（明示「不删除应用本体」树口径）→ `DELETE .../applications/{clientId}`；取消零请求。
- **status 是 int 三值**（后端 normalizeStatus 口径：0=pending / 1=active / 2=disabled）：映射 0→待生效 / 1→已启用 / 2→已停用，**其他值 throw ArgumentError（禁静默回退）**。
- 写半边全走弹窗自持（REQ-2026-005/006 同构）：必填缺失 fail-fast 不发请求；失败留窗保输入；成功收窗 + SnackBar + 列表 silent 回刷。
- API 只用 shared 生成物 barrel；零新依赖。

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | 已登录、mock 后端 | 应用列表加载 | GET 拉订阅行；clientId/状态徽标/到期时间渲染 |
| AC-2 | FAB 弹窗 | 填 clientId(±到期时间) 保存 | POST body 恰 SubscribeTenantApplicationRequest 两字段（留空不随）；成功收窗 + SnackBar + silent 回刷 |
| AC-3 | 必填缺失 / 端点失败 | 空保存 / 500 | fail-fast 文案上屏不发请求；失败留窗保输入 |
| AC-4 | 行已有订阅 | 行内启停 | PUT body 恰 {status: 2 或 1}（expireTime 不随）；成功回刷徽标 |
| AC-5 | 行删除 | 确认 / 取消 | 确认弹窗含「不删除应用本体」文案；确认 DELETE + SnackBar + 回刷；取消零请求 |
| AC-6 | 全切片完成 | trace_cmd + 门禁 | trace 恰含本切片 4 ID；全门 exit 0 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 状态 |
|---|---|---|---|---|
| T1 | REQ + 树 5 行翻转（规划→开发中）+ 测试先行（red，锚随写随带） | 实现 | Claude | 开发中 |
| T2 | 应用列表（I01）+ 订阅弹窗（I02）+ 行内启停（I03）+ 移除确认（I04） | 实现 | Claude | 开发中 |
| T3 | trace/门禁/联调 + GA 翻转 | 实现 | Claude | 开发中 |

## 4. 功能影响（需求与功能对齐的唯一位置）

> ID 均已存在于 `docs/functions/function-tree.md`。状态翻转随实现任务走（mirror 免批，reason 带 REQ-2026-007）；GA 翻转（→已上线）归联调人工验收后收尾。

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M00.F05 | 租户应用 | 变更 | 状态 规划 → 开发中（T1） | T1-T3 |
| M00.F05.I01 | 列出租户应用 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F05.I02 | 订阅应用 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F05.I03 | 更新应用订阅 | 变更 | 规划 → 开发中（T2，行内启停） | T2 |
| M00.F05.I04 | 移除应用订阅 | 变更 | 规划 → 开发中（T2） | T2 |
