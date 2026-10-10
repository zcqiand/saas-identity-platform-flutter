# SaaS身份平台 · Flutter 端

SaaS 多租户多应用身份平台的 Flutter 客户端（Android + Web）。学习路线驱动（roadmap.sh/flutter），需求与 API 基线 = `saas-identity-platform-shared` TypeSpec SSOT；react 仓仅为 UI/交互参照实现。

API 面只认 `saas-identity-platform-shared` TypeSpec 生成物（openapi.yaml → dart-dio client），后端可在 nextjs / springboot / aspnetcore 之间切换。

## 快速开始

```bash
# 0) 中国镜像（PowerShell，用户级 env）
[Environment]::SetEnvironmentVariable('PUB_HOSTED_URL','https://pub.flutter-io.cn','User')
[Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL','https://storage.flutter-io.cn','User')

# 1) 装 Flutter SDK 3.47.6 stable（官方 zip：
#    https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.47.6-stable.zip
#    解压到无空格路径如 %LOCALAPPDATA%\flutter，PATH 加 flutter\bin）
flutter doctor

# 2) 平台目录（一次；pubspec 不会被覆盖，git diff review；fresh clone 本仓后即在仓库根，无需 cd）
flutter create --platforms=android,web --project-name saas_identity_platform_flutter .

# 3) 依赖
flutter pub get

# 4) 跑起来（web dev 端口钉死 5108——随机端口进不了 CORS 白名单）
flutter run -d chrome --web-port 5108 --dart-define=API_BASE_URL=http://localhost:5101 --dart-define=SAAS_CLIENT_ID=saas-console

# 5) 生成客户端（需 Node+Java+Dart）
bash scripts/gen-shared.sh
```

> Phase 1 起登录需 `SAAS_CLIENT_ID`（本仓 `saas-console`，缺失启动即崩——硬规则 §1）。
> token 存储走 `TokenStore` 缝：Android Keystore 级 / **Web 端 localStorage 级**
> （flutter_secure_storage web 实现，与 react 参照同级，联调正式凭据前知悉）。

## 生产部署

prod = `https://saas-flutter.xiangru.uk`（saas 家族 X08 扩展槽位，2026-10-10 启用）。
形态与 saas-react 同款：CI 构建 Flutter Web release → `nginx:alpine` 静态容器（容器内 :80）→ VPS `127.0.0.1:5108:80` → nginx vhost 反代。prod 配置由根 `Dockerfile` `--dart-define` 烘焙（`API_BASE_URL=https://saas-nextjs.xiangru.uk` + `SAAS_CLIENT_ID=saas-console`），禁兜底、缺失 fail-fast。

```bash
# tag 即放行：全量回归绿后打（tag 命名铁律 v<X>.<Y>.<Z>-<YYYYMMDD>）
git tag v0.2.1-20261010
git push origin master v0.2.1-20261010   # CI test → 镜像 → VPS → vhost 自渲染，全自动
```

首次配置需 5 个 GitHub secrets（无 app secret）：`DOCKER_USERNAME` / `DOCKER_PASSWORD` / `VPS_HOST` / `VPS_USER` / `VPS_SSH_KEY`。回滚 = VPS 重跑 deploy 脚本带旧 tag。

## 功能特性

镜像 saas-swift 树 M00/M01/M04 三模块（F 级 diff 实证与 shared 全树一致），全部 `规划`（学习路线分期：Phase 1 认证 → Phase 2 租户列表 → Phase 3 SSO 跳板）。

## 技术栈

| 技术 | 版本 |
| :--- | :--- |
| Flutter | 3.47.6 stable |
| Dart | 3.13.5 |
| 状态管理 | flutter_riverpod 3.4.3 |
| 网络 | dio 5.11.1 |
| codegen | openapi-generator 7.25.0 dart-dio |
| 目标平台 | Android + Web（iOS 缓做） |

> 依赖版本与 `version-lock.json` 的 `version_lock` 一致，不引入 lock 外的库。

## 需求基线

- **需求与 API 基线 = `saas-identity-platform-shared` TypeSpec SSOT**：行为规格读 `tsp/*.tsp`，API client 只用 shared 仓 `generated/openapi/openapi.yaml` 生成的 dart-dio 代码（禁手写接口层，suite 硬规则 §4）。
- 范围：M00/M01/M04；M/F 编号沿用 swift 树（同 shared BASE 双账本），便于跨仓对照。
- UI/交互参照：`../saas-identity-platform-react`（参照实现，非基线）。

## 快速链接

- [CLAUDE.md](CLAUDE.md) — 开发约定与编码规范
- [功能规格.md](docs/functions/function-tree.md) — 功能名称、描述与验收标准
- [未来开发计划](PLAN.md) — 待办与迭代方向
- [更新日志](CHANGELOG.md) — 版本变更记录
