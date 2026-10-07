# REQ-2026-012 · M04.F03.I01 授权码签发（SSO 登录回跳 · flutter 半）

> 功能树：`M04.F03 身份认证`（模块行 + I01 翻开发中；I02 留规划见 §4）。
> 状态机：REQ 落盘 → 树翻转 → red → 实现 → 绿 → trace → gate → 提交推送 → 人工验收 → GA。

## 1. 需求

saas IdP 的 RP（如 lab-management）把用户带到 IdP 登录页并携带 OAuth 参数
（`clientId/redirectUri/responseType/scope/state`）。登录成功后 IdP 前端调
`POST /api/v1/oauth/authorize`（携带刚拿到的 Bearer session）签发一次性
authorization_code，再 302/浏览器跳转回 `redirectUri?code=..&state=..`。

镜像 nextjs 同款流程（`src/app/login/page.tsx` 登录成功后领 code 跳回 RP，
不落 /tenants）。flutter 侧落在：登录成功态（Authed）且 URL 带 SSO 参数时，
由 `SsoHandoff` 自动完成 authorize + 组跳转 URL + 浏览器重定向。

## 2. 契约面（生成物为准）

| 方法 | 端点 | 请求 | 响应 |
|---|---|---|---|
| POST | `/api/v1/oauth/authorize` | `AuthorizeCodeRequest{clientId, redirectUri, responseType=code, scope?, state}` | `OAuthAuthorize200Response{code, state}` |

生成物：`OauthApi.oAuthAuthorize`（`lib/generated/api/oauth_api.dart`）。
鉴权：Authorize 依赖登录 session（Bearer）——与 nextjs I01 的
「无 Authorization → 401」边界一致；flutter 侧不重复造边界（后端已 GA）。

## 3. 设计

- **入口判定**：`SsoParams.fromUri(Uri.base)`——`clientId/redirectUri/state`
  全非空且 `responseType=code` 才视为 SSO 回跳，否则回正常 console 登录
  （conservative parse：参数缺失不是本端错误，不该打断普通登录）。
- **接线**：`main.dart` 启动解析一次；`Authed && sso != null` → `SsoHandoff`
  （restore 已登录用户带参进入也覆盖，比 nextjs 只在 login page 更完整）。
- **SsoHandoff**：init → `oAuthAuthorize(五字段)` → `buildSsoRedirectUrl` →
  `redirectTo(url)`（条件导入：web=`dart:html` location.assign，VM=stub no-op；
  测试注入 `onRedirect` 捕获）。失败 → 错误文案，不重定向。
- **URL 组装**：`redirectUri` 已带 query 用 `&` 追加（RFC 6749 §3.1.2），
  `code/state` 走 `Uri.encodeQueryComponent`。

## 4. 范围裁剪（I02 不在片）

`M04.F03.I02 OIDC token 端点（双 grant）`的语义是**token 端点本身**
（消费方 = RP，如 lab 家族）；saas 侧前后端半 = nextjs `route.ts`（已 GA）。
flutter 仓无后端：AuthApi 仅 login/logout，控制台 JWT 流程不调 `/oauth/token`，
**flutter 对 I02 无实现面**。mirror 该行保持规划（M00.F02.I07「待 BASE 先行」
同款先例），是否按「无前端面」口径登记豁免，待人裁。

## 5. 测试计划（test/core/auth/sso_handoff_test.dart）

| 测试 | 证明 |
|---|---|
| 参数解析：全参齐才算 SSO（缺 state / responseType≠code 回退） | 入口判定（无锚，纯函数） |
| SSO 回跳：authorize POST 五字段 + code/state 组跳转 URL | **M04.F03.I01** |
| 跳转 URL 组装：redirectUri 带 query 用 & 追加 | RFC §3.1.2 边界（无锚） |
| authorize 失败：错误文案 + 不重定向 | 失败面（无锚） |

## 6. 任务

- T1：REQ + 树翻转（模块行 + I01，共 2 行）+ red 测试
- T2：SsoHandoff + SsoParams + buildSsoRedirectUrl + 条件导入 redirectTo
  + oauthApiProvider + main.dart 接线
- T3：dart format → flutter test 全量 → trace_cmd → gate → 提交推送

## 7. 影响表

| 文件 | 动作 |
|---|---|
| `lib/core/auth/sso_handoff.dart` | 新建 |
| `lib/core/auth/sso_redirect{,_stub,_web}.dart` | 新建（条件导入） |
| `lib/core/auth/providers.dart` | +oauthApiProvider |
| `lib/main.dart` | Authed 分支接 SsoHandoff |
| `test/core/auth/sso_handoff_test.dart` | 新建 4 测 |
