# 更新日志

## v0.2.0 — 2026-10-05

- M01 认证 Phase 1：密码直登（/auth/login，clientId 门 SAAS_CLIENT_ID）、token 安全存储（TokenStore 缝：SecureTokenStore/InMemory）、401 会话失效（SessionGuard 缝）、登出（best-effort+清必达）、登录页（@entry M01.F04.I03）
- 锚 M01.F04.I01 / I03 / I06 挂 trace；树三 ID 推进开发中
- 依赖：flutter_secure_storage 11.2.0 / http_mock_adapter 0.6.1（version-lock 钉死）

## v0.1.0 — 2026-10-04

- Phase 0a 骨架：flutter 栈档接入 + Flutter 3.47.6 壳 + 树镜像（M00/M01/M04 全规划）+ 门禁 L0/L5 绿
