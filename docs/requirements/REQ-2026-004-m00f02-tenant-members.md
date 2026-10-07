# REQ-2026-004 M00.F02 租户成员切片（Flutter web）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-07 |
| 优先级 | P0 |
| 状态 | 开发中 |
| 关联 ADR | — |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（API 面只认 dart-dio 生成物）；M00.F01 租户维护三切片（REQ-2026-002/003，已上线）同仓扩建；生成物已核 `tenant_members_*` 七方法（`/api/v1/tenants/{tenantId}/members` 面） |

## 1. 需求描述

**用户裁定**（2026-10-07）：「还有很多规划状态没有上线，请继续，加快进程」——租户维护 GA 后按树序推进 M00.F02 租户成员。

**我的理解**：
- I01 成员列表：租户详情页「成员」入口 → `MembersListPage(tenantId)`，`GET /api/v1/tenants/{tenantId}/members?page=0&pageSize=50`（契约 0 基判例）+ 状态 chip 服务端参数（`TenantMemberStatus` 四值 active/invited/suspended/disabled）；响应 `{items, page, pageSize, total}` 服务端分页。
- I02 创建成员：FAB → 弹窗（username + password 必填，email/mobile 可选——契约 `CreateSysUserRequest` 恰此四字段）→ `POST .../members`。
- I03 成员详情：行 onTap → 详情页（`GET .../members/{userId}` 八字段卡：id/tenantId/username/email/status/roleIds/createdAt/updatedAt）。
- I04 更新成员：行编辑 → 弹窗（email/mobile 两可空字段回填——契约 `UpdateSysUserRequest` 恰此二；username/password 契约不可改，不呈现）→ `PUT .../members/{userId}`。
- I05 删除成员：行删除 → 确认弹窗（明示「仅解除与租户的关系，不删除全局用户」）→ `DELETE .../members/{userId}`；取消零请求。
- I06 邀请成员：列表 appbar 入口 → 弹窗（email 必填 + mobile 可选——契约 `TenantMembersInviteTenantUserRequest`）→ `POST .../members/invitations` → SnackBar「邀请已发送」。
- I08 状态切换：行内动作 active⇄suspended（`TenantMembersChangeTenantUserStatusRequest{status}` → `POST .../members/{userId}/status`）；invited/disabled 仅徽标呈现。
- **I07 接受邀请不入本切片**：树行已注「被邀侧口径，待 BASE 先行」——生成面无 accept 端点，硬做即越契约。
- 写半边全走弹窗自持（REQ-2026-003 同构）：必填缺失 fail-fast 不发请求；失败留窗保输入；成功收窗 + SnackBar + 列表 silent 回刷。
- API 只用 shared 生成物 barrel；零新依赖。

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | 已登录、mock 后端 | 成员列表加载 | GET 固定 `page=0&pageSize=50` + status chip 参数正确拼接；sealed UiState 四态渲染 |
| AC-2 | FAB 弹窗 | 填 username/password(±email/mobile) 保存 | POST body 恰 CreateSysUserRequest 四字段；成功收窗 + SnackBar + silent 回刷 |
| AC-3 | 必填缺失 / 端点失败 | 空保存 / 500 | fail-fast 文案上屏不发请求；失败留窗保输入 |
| AC-4 | 行已有成员 | 点行进详情 | 八字段卡渲染，返回不带残留 |
| AC-5 | 行编辑 | 改 email/mobile 保存 | 弹窗回填；PUT body 恰 UpdateSysUserRequest 两字段 |
| AC-6 | 行删除 | 确认 / 取消 | 确认弹窗含「不删除全局用户」文案；确认 DELETE + SnackBar + 回刷；取消零请求 |
| AC-7 | appbar 邀请 | 填 email(±mobile) 发送 | POST invitations body 恰两字段；SnackBar 邀请已发送 |
| AC-8 | 行状态动作 | 启用⇄停用 | POST /status body {status}；成功回刷；四值徽标正确着色 |
| AC-9 | 全切片完成 | trace_cmd + 门禁 | trace 恰含本切片 7 ID；全门 exit 0 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 状态 |
|---|---|---|---|---|
| T1 | REQ + 树 8 行翻转（规划→开发中）+ 测试先行（red） | 实现 | Claude | 开发中 |
| T2 | 成员列表（I01）+ 创建/编辑/邀请弹窗（I02/I04/I06） | 实现 | Claude | 开发中 |
| T3 | 详情页（I03）+ 删除确认（I05）+ 状态切换（I08） | 实现 | Claude | 开发中 |
| T4 | trace/门禁/联调 + GA 翻转 | 实现 | Claude | 开发中 |

## 4. 功能影响（需求与功能对齐的唯一位置）

> ID 均已存在于 `docs/functions/function-tree.md`。状态翻转随实现任务分批走（mirror 免批，reason 带 REQ-2026-004）；GA 翻转（→已上线）归联调人工验收后收尾（ACCEPTANCE-2026-10-07 系列同款档案）。I07 不翻转（待 BASE）。

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M00.F02 | 租户成员 | 变更 | 状态 规划 → 开发中（T1）；I07 待 BASE 不入本片 | T1-T4 |
| M00.F02.I01 | 成员列表 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F02.I02 | 创建成员 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F02.I03 | 成员详情 | 变更 | 规划 → 开发中（T3） | T3 |
| M00.F02.I04 | 更新成员 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F02.I05 | 删除成员 | 变更 | 规划 → 开发中（T3） | T3 |
| M00.F02.I06 | 邀请成员 | 变更 | 规划 → 开发中（T2） | T2 |
| M00.F02.I08 | 状态切换 | 变更 | 规划 → 开发中（T3） | T3 |
