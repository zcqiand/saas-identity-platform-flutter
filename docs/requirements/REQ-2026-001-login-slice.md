# REQ-2026-001 登录直进切片（M01 认证 Phase 1：密码直登闭环）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-05 |
| 优先级 | P1 |
| 状态 | **开发中**（T1-T4 完成；GA 翻转待 Phase 2 真后端联调人工验收） |
| 关联 ADR | —（clientId fail-fast 口径 = suite ADR-0019；本仓尚无 ADR） |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（需求与 API 基线）；已批 spec `xr-code-suite/docs/superpowers/specs/2026-10-05-saas-flutter-phase1-auth-design.md`；saas-react 登录实现为交互参照；lab-swift 认证架构（Seams）为结构参照 |

## 1. 需求描述

**用户原话**：「为 saas 与 lab 两个家族各增加一个 flutter 版本的应用」（家族 spec
`2026-10-04-family-flutter-stacks-design.md`）；本仓 Phase 1 切片 =「M01 认证（密码直登）」，
两家族认证流非同构、各自独立成文（2026-10-05 人裁）。

**理解**：saas-identity-platform-flutter 首个功能切片。需求面从 saas-identity-platform-shared
契约取；API 面**只认生成物**（suite 硬规则 §4，`lib/generated/` Phase 0 已就位，本阶段零
codegen）。交付密码直登闭环：登录页 → `/auth/login` 换 JWT → token 安全存储 → dio 拦截器
带 token → 401 清会话回登录页 → 登出（best-effort 通知 + 本地清必达）。全程 mock-friendly
（`flutter test` 无后端全绿），首批功能锚挂上，树推进「开发中」。

### 范围

| 关注点 | 内容 |
|---|---|
| clientId 门 | `--dart-define=SAAS_CLIENT_ID` 必填，缺失 fail-fast 启动即抛（硬规则 §1；本仓值 `saas-console`） |
| TokenStore 缝 | 抽象接口 save/clear/read（accessToken+refreshToken）；生产绑 flutter_secure_storage（Web 端 localStorage 级，与 react 参照同级，诚实记录），测试绑内存 fake |
| AuthController | riverpod Notifier 状态机：login 成功/423 锁定/401 错凭据/网络不可达四分支 + restore（读存储非空→authed，不发校验请求） |
| dio 装配 | BaseUrl + AuthInterceptor（非空 token 加 Bearer；401 且非 auth 端点 → 注入的会话失效回调：清 TokenStore + 置 anonymous，再原样上抛） |
| 登出 | `sessionsLogout()` best-effort（try 吞错）+ 本地清 TokenStore 必达 + 回 anonymous |
| UI 壳 | LoginPage（表单+校验+错误分支）+ main.dart 按 AuthState 条件渲染（不引路由库） |

**非范围**（本阶段出界）：自动 token 刷新（契约无 refresh 端点；react 先例「401 直接清会话
踢登录页」2026-09-12 人裁同款）；租户切换 UI（availableTenants 只存不用）；whoami 启动校验；
menus；SSO（Phase 3）；真后端联调与 CORS 白名单（Phase 2）；iOS。

### 澄清记录

| 疑问 | 澄清结论 | 澄清人 | 日期 |
|---|---|---|---|
| Q1 树范围 | 恰 3 锚：M01.F04.I01 / I03 / I06（本表 §4）；父行与 whoami 不动 | 人裁 | 2026-10-05 |
| Q2 mock 基建 | http_mock_adapter exact 钉死；兼容探针在 plan 首步，红则降级手写 HttpClientAdapter（计划内预案） | 人裁 | 2026-10-05 |
| Q3 与 lab 仓关系 | 两认证流非同构，lab Phase 1 另立 spec，互不阻塞 | 人裁 | 2026-10-05 |

## 2. 验收标准

| 编号 | 场景（给定） | 操作（当） | 预期（则） |
|---|---|---|---|
| AC-1 | mock 环境 | 跑登录四分支测试（成功 / 423 锁定 / 401 错凭据 / 网络不可达） | 各一条测试，全绿；成功分支换得 LoginResponse，accessToken 落 TokenStore |
| AC-2 | 已登录，任意受保护请求 | 服务端返回 401 | TokenStore 清空 + 状态回 anonymous；auth 端点自身的 401 不触发缝 |
| AC-3 | 已登录 | 点登出（服务端失败/不可达） | 本地清 TokenStore 必达 + 回 anonymous，不等网络 |
| AC-4 | 构建缺 `SAAS_CLIENT_ID` | 启动 | fail-fast 启动即抛，无兜底字面量 |
| AC-5 | 启动时 TokenStore 非空 / 空 | restore | 非空→authed（不发校验请求）；空→LoginPage |
| AC-6 | Phase 1 全部测试就位 | `trace_cmd` 产出 trace.json | 恰含 3 个 ID（I01/I03/I06），`// @entry M01.F04.I03` 被 L5 source_index 识别；skip 测试不挂 ID |
| AC-7 | 全仓 | suite 根跑 `python scripts/gate.py -p saas-identity-platform-flutter` | L0..L5 全绿且幂等（重跑零 diff）；README/PLAN/CHANGELOG 同步 |

## 3. 任务拆解

| 任务 ID | 任务描述 | 类型 | 负责人 | 预估 | 状态 |
|---|---|---|---|---|---|
| T1 | 依赖钉死（dio/riverpod/http_mock_adapter/flutter_secure_storage）+ version-lock 同 commit | 基建 | Claude | — | 完成（77a6df0+949a327） |
| T2 | AppConfig clientId 门（SAAS_CLIENT_ID fail-fast） | 开发 | Claude | — | 完成（ec3dae5） |
| T3 | TokenStore 缝（抽象 + SecureTokenStore + 内存 fake） | 开发 | Claude | — | 完成（d6998fb） |
| T4 | dio 装配 + AuthInterceptor（Bearer + 401 缝）+ SessionGuard | 开发 | Claude | — | 完成（7831c35+2389961） |
| T5 | AuthState 状态机 + AuthController（login/restore 四分支）+ I01 锚 + 树推进 | 开发 | Claude | — | 开发中 |
| T6 | 401 缝接线（controller↔interceptor）+ 登出 + I06 锚 + 树推进 | 开发 | Claude | — | 待开始 |
| T7 | LoginPage + main.dart 壳 + I03 @entry/锚 + 树推进 | 开发 | Claude | — | 待开始 |
| T8 | docs 同步 + trace.json（trace_cmd）+ 全门绿 | 对齐 | Claude | — | 待开始 |

## 4. 功能影响（需求与功能对齐的唯一位置）

| 功能 ID | 功能名称 | 影响类型 | 说明 | 关联任务 |
|---|---|---|---|---|
| M01.F04.I01 | 密码登录（接口） | 变更 | 规划→开发中：AuthController 登录闭环（AC-1/4/5） | T5 |
| M01.F04.I03 | 密码登录 UI | 变更 | 规划→开发中：LoginPage + 壳（AC-1；@entry 锚） | T7 |
| M01.F04.I06 | 登出（本地清理 + 全局 SSO） | 变更 | 规划→开发中：登出 + 401 缝（AC-2/3） | T6 |

## 5. 流程影响

无（本仓尚无流程文档；与 saas-swift 同款，流程账为待人裁遗留项）。

## 6. 风险与回滚

| 风险 | 影响面 | 缓解 | 回滚方式 |
|---|---|---|---|
| Web 端 token 存储实为 localStorage 级（flutter_secure_storage Web 实现） | Web 会话安全 | 与 react 参照同级，诚实记录不夸大；Android 真机为 Keystore 级 | — |
| 401 无自动刷新，长会话被踢登录页 | 用户体验 | 契约无 refresh 端点；react 先例人裁同款；Phase 3 SSO 再看 | — |
| Phase 1 整体回归 | 本切片全部 | git revert Phase 1 commit 集；树状态回退另走 tree_change 提案 | git revert |
