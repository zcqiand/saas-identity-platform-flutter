# REQ-2026-010 — M04 应用管理第一片：应用维护 + 启用/停用（M04.F01 / M04.F02）

> 范围：M04.F01 应用维护 6 子项 + M04.F02 启用/停用 1 子项，共 **7 I 行**。
> M04.F03 身份认证（OAuth authorize/token）与 M04.F04 菜单管理 flutter 侧**不在本片**，
> 后续切片。M04.F04 后端侧已随 REQ-2026-008 瘦身切片上线（树行备注）。

## 背景

- 树内 M04 模块 4 F 全规划态。后端（saas-nextjs :5101）`/api/v1/admin/clients`
  面已上线（REQ-2026-002 console 批），本片补 flutter 控制台面。
- 生成物齐备：`AdminClientsApi`（create/delete/get/list/setStatus/update 六方法）
  + `ClientsApi.clientsGetClient`（公共元数据匿名端点）。

## 锚定子项（AC）

### M04.F01 应用维护

| ID | 子项 | AC |
|---|---|---|
| M04.F01.I01 | OAuth 应用列表 | GET `/api/v1/admin/clients`（分页响应 items/page/pageSize/total）；行渲染 clientName + clientId + 状态徽标（1=启用/0=停用，家族 smallint 约定） |
| M04.F01.I02 | 创建 OAuth 应用 | POST `/api/v1/admin/clients`；契约必填五件 clientId/clientName/clientSecret/grantTypes/redirectUris——clientSecret 表单侧自动生成（`sec-` 前缀随机，与 nextjs 同款），grantTypes 默认 `authorization_code,client_credentials`；scopes 逗号串选填；成功收窗+回刷 |
| M04.F01.I03 | OAuth 应用详情 | GET `/api/v1/admin/clients/{clientId}`；全字段渲染；**clientSecret 不在响应契约**（仅指纹不回显），详情页明示「密钥不回显」 |
| M04.F01.I04 | 更新 OAuth 应用 | PUT `/api/v1/admin/clients/{clientId}`；body clientName/redirectUris/scopes（生成物 UpdateOAuthClientRequest 无 icon/sortOrder——nextjs 页多出的字段**不搬**，生成物为准）；PUT 响应回填列表（GET 重拉返旧快照坑，application_list_controller 同款） |
| M04.F01.I05 | 删除 OAuth 应用 | DELETE `/api/v1/admin/clients/{clientId}`；确认弹窗明示「移除应用并吊销该 client 名下所有 access/refresh token」语义；成功回刷 |
| M04.F01.I06 | 公共 client 元数据 | GET `/api/v1/clients/{clientId}`（匿名端点）；详情页「公共元数据」卡对照呈现 clientId/clientName/status |

### M04.F02 应用启用/停用

| ID | 子项 | AC |
|---|---|---|
| M04.F02.I01 | 启用/停用应用 | PUT `/api/v1/admin/clients/{clientId}/status` body `{status: 0|1}`；行内切换即时翻转（PUT 响应回填）；停用语义=OAuth/token 端点立即拒绝（展示面只管切换） |

## 生成物口径（漂移登记）

- 树行 I02 文案「密钥生成」：生成物 `CreateOAuthClientRequest.clientSecret` 是**必填**
  String——生成动作在表单侧（nextjs 同款），非后端生成。
- nextjs admin 页的 icon/sortOrder/isFirstParty 字段**不在** dart-dio 生成物
  `UpdateOAuthClientRequest` 中——flutter 面不实现（生成物为准；nextjs 页属历史漂移，
  不在本片修）。
- status 为 int（0/1），非枚举类；label 函数穷尽 0/1/其他 throw。

## 测试计划

`test/features/appadmin/client_admin_test.dart` 8 测（7 锚 + 1 错误态）：
路径面 ③c 无冲突（list GET / create POST 同路径异方法异路由；detail admin GET 与
public GET 异路径；status PUT 独立路径）。fixtures：`clientJson`/`clientListJson`/
`clientPublicJson` 入 `tenant_fixtures.dart`。

## 任务

- T1：本 REQ + 树 10 行翻转（模块 M04 + F01 + F02 + 7 I）+ 测试先行（red）
- T2：实现（providers/label/controller/form dialog/list page/detail page + main.dart 入口）
- T3：trace + gate 全绿
- T4：commit + push + handoff

## 影响表

| 层 | 文件/对象 | 动作 |
|---|---|---|
| module | M04 应用管理 | 树 规划→开发中 |
| F | M04.F01 应用维护 | 树 规划→开发中 |
| F | M04.F02 应用启用/停用 | 树 规划→开发中 |
| I | M04.F01.I01~I06 | 树 规划→开发中（6 行） |
| I | M04.F02.I01 | 树 规划→开发中 |
| lib | features/appadmin/*（6 新文件） | 新增 |
| lib | main.dart | 壳加「应用」入口 |
| test | features/appadmin/client_admin_test.dart | 新增 |
| test | support/tenant_fixtures.dart | 追加 3 fixture |
