# 人工验收记录 — saas-identity-platform-flutter（REQ-2026-003 M00.F01 租户 CRUD）

> **✅ 人工验收通过**（验收人：用户，2026-10-07；浏览器 http://localhost:5108
> 走 AC-1~AC-4 全路径。GA 翻转凭本档执行——REQ-2026-002 先例同构）。

## 环境（验收时实证 2026-10-07）

| 项 | 值 |
|---|---|
| 后端 | saas-identity-platform-nextjs dev，`http://localhost:5101`，`/api/health` → 200 |
| 前端 | saas-identity-platform-flutter `d58e2da`（REQ-2026-003 T3 头，工作树 clean），`flutter run -d web-server --web-port 5108 --dart-define=API_BASE_URL=http://localhost:5101 --dart-define=SAAS_CLIENT_ID=saas-console` → HTTP 200 |
| 凭据 | alice / dev123456（clientId=`saas-console`） |
| 数据 | PG `saas_dev`（100.79.128.25:5432 Tailscale），tenant 表 3 行（acme/globex/initech） |

## 机器可证部分（预填实证）

| 项 | 证据 |
|---|---|
| 远门 | flutter test **53/53**、analyze 0、gate 全绿 **EXIT=0** |
| trace | 10 测试挂 **恰 5 ID**（M00.F01.I01~I05 全锚，零 inert；本切片 I02/I04/I05 各 1） |
| red 证据 | 实现 commit（9c873f3）前捕获 `+0 -1` 装载失败（T1 red，phase lock 留痕） |

## 分场景实录（AC 编号见 REQ-2026-003 §2）

| AC | 场景 | 结果 |
|---|---|---|
| AC-1 | FAB 创建：POST body 恰 {tenantKey, name} + 收窗 + SnackBar + silent 回刷 | ✅（人批 2026-10-07） |
| AC-2 | 必填缺失 fail-fast 文案上屏不发请求 / 端点 500 弹窗留窗保输入 | ✅（弹窗测机器可证） |
| AC-3 | 行编辑：弹窗回填（名称预填 + 状态下拉）→ PUT /{id} body 全量随 | ✅（人批 2026-10-07） |
| AC-4 | 行删除：确认弹窗含级联清理文案 → DELETE + SnackBar + 回刷；取消零请求 | ✅（人批 2026-10-07） |
| AC-5 | trace 恰 3 ID + 门禁 EXIT=0 | ✅（上文机器可证） |

> 数据观察：initech 显示「启用」为 `saas_dev.tenant.status=3` 契约外值所致
> （前档 `ACCEPTANCE-2026-10-06-m00f01.md` 已记，BFF 映射面内行为一致），
> 非本切片缺陷。

## 验收后动作（已执行 2026-10-07）

- ✅ GA 翻转：`docs/functions/function-tree.md` M00.F01.I02/I04/I05「→已上线」
  ——`tree_change.py --apply` 免批通道（GA 翻转凭 REQ 验收记录）。
