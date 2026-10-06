# REQ-2026-002 租户维护切片（M00.F01 Phase 2：平台 admin 租户列表+详情）

| 项 | 值 |
|---|---|
| 提出人 | zcqiand |
| 提出日期 | 2026-10-06 |
| 优先级 | P1 |
| 状态 | **开发中** |
| 关联 ADR | —（本仓尚无 ADR） |
| 上游 | saas-identity-platform-shared TypeSpec SSOT（需求与 API 基线）；已批 spec `xr-code-suite/docs/superpowers/specs/2026-10-04-family-flutter-stacks-design.md` §7 Phase 2 行；lab-flutter Phase 1/2（v0.3.0-20261006）为配方参照 |

## 1. 需求描述

**用户原话**：家族 spec §7 Phase 2——saas-flutter 落地 M00.F01 租户列表+详情，
各家族 4 后端 CORS dev 白名单追加 flutter web 端口（5108），接真后端联调。

**理解**：saas-identity-platform-flutter 首个业务切片（Phase 1 认证基建已上线）。
tenant-admin 配置面入口：平台 admin 登录后 `_Shell` 占位壳换租户列表首页，点行进
详情。API 面**只认生成物**（suite 硬规则 §4，`lib/generated/` 已就位，本阶段零
codegen）。契约无名称/状态过滤参数（G-11 盘上核实）——过滤为客户端侧（列表全量
拉取 + 本地过滤 chips），web console 同构。全程 mock-friendly（`flutter test`
无后端全绿），树推进「开发中」。

### 范围

| 关注点 | 内容 |
|---|---|
| 列表 I01 | `GET /api/v1/admin/tenants` 显式 `page:1, pageSize:50`；客户端侧 keyword/状态过滤；TenantStatus 两值标签 |
| 详情 I03 | `GET /api/v1/admin/tenants/{id}` 按路由参数 id 拉（不透传列表行对象）；六字段卡 |
| `_Shell` 接线 | 占位壳 body 换 `TenantsListPage`；appbar 登出保留 |
| CORS T4 | saas 4 后端 dev 白名单追加 5108（fastapi 补 CORSMiddleware，其余纯 env） |

### 非范围

I02 创建/I04 更新/I05 删除租户（后续切片）；到期时间/订阅应用数（不在契约
`Tenant` 六字段面，web console 组合面）；租户成员/角色/应用（M00.F02-F05）；
SSO（Phase 3）；iOS。

### 澄清记录

- 树 I03 行文本「含状态/到期时间/订阅应用数」超出契约 `Tenant` 面——交付时随树
  行勘误为契约六字段口径（G-11）。
- 403：非平台 admin 登录态拉列表得 403——落「加载失败，请重试」带响应分支，
  不崩栈不空白（Review Focus 1）。

## 2. 验收标准

| # | 前置 | 操作 | 期望 |
|---|---|---|---|
| AC-1 | 已登录、mock 后端 | 列表加载 | 显式 `page=0&pageSize=50` query（契约 0 基——M96.F02.I60/I61 判例，2026-10-07 联调勘误）；sealed UiState 四态渲染 |
| AC-2 | 列表有数据 | 过滤 | keyword 收敛行数；状态 chips 全部/启用/停用，两值标签全覆盖 |
| AC-3 | 点列表行 | 进详情 | 详情请求 path 带**正确 id**（两租户 fixture 交叉）；六字段卡渲染；suspended 徽标「停用」 |
| AC-4 | 异常面 | 无响应/403/404 | 「无法连接服务器」/「加载失败，请重试」/「加载失败，请重试」，不崩栈 |
| AC-5 | 全切片完成 | `python scripts/trace_cmd.py` | trace 恰 5 个 ID（M01.F04 三 + M00.F01.I01/I03） |
| AC-6 | CORS | OPTIONS 预检探针 | 4 后端对 Origin 5108 回 `access-control-allow-origin`（fastapi 探针实证） |

## 3. 任务拆解

T1 REQ+fixtures → T2 列表页+controller+`_Shell` → T3 详情页 → T4 CORS 四后端 →
T5 trace+门禁 → T6 联调+GA+ACCEPTANCE（人批门）。详见
`xr-code-suite/docs/superpowers/plans/2026-10-06-saas-flutter-phase2-m00f01.md`。

## 4. 功能影响（需求与功能对齐的唯一位置）

| 树行 | 变化 |
|---|---|
| M00.F01.I01 | 规划 → 开发中（T2）→ 已上线（T6 人批后） |
| M00.F01.I03 | 规划 → 开发中（T3）→ 已上线（T6 人批后，行文本随 G-11 勘误） |

## 5. 人工验收记录（GA 前置锚）

- **✅ 2026-10-07 人工验收通过**：AC-1~AC-3 全路径过（浏览器 http://localhost:5108
  走列表/过滤/详情；环境与分场景实录见 `ACCEPTANCE-2026-10-06-m00f01.md`，人批同日
  给出）。环境：saas-nextjs `:5101` + saas-fastapi `:5107`（CORS 预检实证）+
  saas-flutter `:5108`；凭据 alice/dev123456（clientId=`saas-console`）。
  GA 翻转 M00 模块/F01/I01/I03 共 4 行随批执行（`tree_change.py --apply` 免批通道，
  lab M03.F01 先例同构）。
