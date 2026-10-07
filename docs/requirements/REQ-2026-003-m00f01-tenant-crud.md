# REQ-2026-003 M00.F01.I02/I04/I05 租户 CRUD 切片（Flutter web）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-07 |
| 优先级 | P0 |
| 状态 | 开发中 |
| 关联 ADR | — |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（API 面只认 dart-dio 生成物）；M00.F01 列表/详情（REQ-2026-002，已上线）同仓扩建；生成物已核 `adminTenantsCreateTenant/UpdateTenant/DeleteTenant` |

## 1. 需求描述

**用户裁定**（2026-10-07）：「还有很多规划状态没有上线，请继续，加快进程」——租户维护列表/详情已上线，补齐 CRUD 写半边：I02 创建 / I04 更新 / I05 删除。

**我的理解**：
- I02 创建租户：列表页 FAB → 创建弹窗（tenantKey + name 两必填，契约 `CreateTenantRequest` 恰此二字段；「绑定初始管理员与默认配置」为后端 act 语义，前端只提交两字段）→ `POST /api/v1/admin/tenants` → 成功收窗 + SnackBar + 列表 silent 回刷。
- I04 更新租户：行编辑入口 → 编辑弹窗（name 回填 + status 下拉 启用/停用，契约 `UpdateTenantRequest` 恰此两可空字段）→ `PUT /api/v1/admin/tenants/{id}`。
- I05 删除租户：行删除入口 → 确认弹窗（明示「成员、角色与应用订阅将级联清理」）→ `DELETE /api/v1/admin/tenants/{id}` → 成功收窗 + SnackBar + silent 回刷；取消不发请求。
- 必填缺失 fail-fast 文案上屏不发请求；端点失败弹窗留窗保输入可重试（F03 录入 sheet 同构）。
- API 只用 shared 生成物 barrel；零新依赖；列表 sealed 状态机不动（写半边走弹窗自持，成功回刷复用 `load(silent:true)`）。

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | 已登录、mock 后端 | FAB → 填 tenantKey/name → 保存 | POST body 恰 {tenantKey, name}；成功收窗 + SnackBar + silent 回刷 |
| AC-2 | 必填缺失 / 端点 500 | 空保存 / 失败保存 | fail-fast 文案上屏**不发请求**；失败弹窗留窗保输入 |
| AC-3 | 行已有租户 | 点编辑 → 改名/改状态 → 保存 | 弹窗回填；PUT /{id} body {name, status} 全量随 |
| AC-4 | 行已有租户 | 点删除 → 确认 / 取消 | 确认弹窗含级联清理文案；确认 → DELETE /{id} + SnackBar + 回刷；取消零请求 |
| AC-5 | 全切片完成 | trace_cmd + 门禁 | trace 恰含本切片 3 ID；全门 exit 0 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 状态 |
|---|---|---|---|---|
| T1 | REQ-2026-003 + 树 3 行翻转（规划→开发中）+ 测试先行（red） | 实现 | Claude | 开发中 |
| T2 | 租户表单弹窗（create/edit 双态）+ 列表页 FAB/行入口接线 | 实现 | Claude | 开发中 |
| T3 | trace 锚验证 + 门禁 + 推送 | 实现 | Claude | 开发中 |

## 4. 功能影响（需求与功能对齐的唯一位置）

> ID 均已存在于 `docs/functions/function-tree.md`。状态翻转随实现任务分批走（mirror 免批，reason 带 REQ-2026-003）；GA 翻转（→已上线）归联调人工验收后收尾（ACCEPTANCE-2026-10-06 同款档案）。

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M00.F01.I02 | 创建租户 | 变更 | 规划 → 开发中（T1） | T1, T2 |
| M00.F01.I04 | 更新租户 | 变更 | 规划 → 开发中（T1） | T1, T2 |
| M00.F01.I05 | 删除租户 | 变更 | 规划 → 开发中（T1） | T1, T2 |


## 5. 人工验收记录（GA 前置锚）

- 远门 2026-10-07：53/53 测试 + analyze 0 + suite 门禁全绿 EXIT=0；trace M00.F01
  恰 5 ID（I01~I05 全锚，本切片 I02/I04/I05 各 1，零 inert）。
- **✅ 2026-10-07 人工验收通过**：AC-1~AC-5 全路径过（浏览器 http://localhost:5108
  走 FAB 创建/必填 fail-fast/行编辑回填+状态下拉/删除确认级联文案/取消零请求；
  环境与分场景实录见 `ACCEPTANCE-2026-10-07-m00f01-crud.md`，人批同日给出）。
  环境：saas-nextjs `:5101` + saas-flutter `:5108`；凭据 alice/dev123456
  （clientId=saas-console）。GA 翻转 I02/I04/I05 共 3 行随批执行
  （`tree_change.py --apply` 免批通道，REQ-2026-002 先例同构）。
