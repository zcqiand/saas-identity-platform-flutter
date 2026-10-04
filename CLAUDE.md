# CLAUDE.md — SaaS身份平台

> 镜像仓 + harness 门禁仓双身份。入口，不是手册。L0 门强制上限 60 行。
> 本仓是 SaaS 多租户多应用身份平台的 Flutter 客户端变体（**Android + Web**，学习路线驱动分期交付）：需求与 API 基线 = `saas-identity-platform-shared` TypeSpec SSOT（API 只用 shared 生成物，硬规则 §4）；react 仓仅为 UI/交互参照实现，不是基线；不绑书稿。

## 1. 项目定位

SaaS身份平台（`saas-identity-platform-flutter`，技术栈 `flutter`）。一句话定位见 README.md。

## 2. 铁律

- **TDD**：每个模块先写失败测试 → 跑确认失败 → 实现 → 跑确认绿 → commit
- **版本钉死**：依赖与 `version-lock.json` 的 `version_lock` 一致；不引入 lock 外的库
- **tag 即放行**：全量回归绿后打 `v<MAJOR>.<MINOR>.<PATCH>-<YYYYMMDD>`（如 `v0.3.54-20260826`）
- **mock-friendly**：安装 + 测试必须在无 Key、无 Docker、无网下全绿
- **功能清单是锚点**：改 `docs/functions/function-tree.md` 走 `/tree-change` 提案，由人批准；
  改功能与改功能清单必须同一个 commit；废弃只改状态，编号永不复用；禁止给 skip 的测试挂功能 ID

- **前端 only**：不实现任何后端。后端可在 saas 家族 nextjs / springboot / aspnetcore 之间切换，API 面只认 `saas-identity-platform-shared` TypeSpec 契约生成物（suite 硬规则 §4）
- **Flutter 客户端**：基线 Flutter 3.47.6 stable + Dart 3.13.5 + Riverpod + dio。构建/测试在本机 Windows 跑（本机装 Flutter SDK），无远程构建机；首批平台 Android + Web，iOS 缓做
- **禁止 env 默认值兜底**：`--dart-define` 缺失必须 fail-fast，不写 `String.fromEnvironment` 空串直通
- **禁止业务身份字段兜底到 demo 字面量**（硬规则 §3，ADR-0019）：dev 凭据只进 fixtures/测试配置

## 3. 技术栈与版本（钉死于 version-lock.json）

技术栈 `flutter`（L0..L5 全门）。真身基线：Flutter 3.47.6 stable + Dart 3.13.5 + Riverpod + dio；codegen = openapi-generator 7.25.0 `dart-dio`（产物 commit 进 `lib/generated/`，禁手改）。明细见 `version-lock.json` 与 README.md 技术栈表。

门禁命令见 `.harness/stack.json`。**不要改它来让门变松。**

## 4. 验收

- 在 **suite 根目录** 跑 `python scripts/gate.py -p saas-identity-platform-flutter`；exit 0 才算完成
- 本地命令见 README.md「快速开始」

## 5. 指向别处

- 功能清单（唯一锚点） → `docs/functions/function-tree.md`
- 需求 → 任务 → 功能影响 → `docs/requirements/`
- 流程/设计 与功能对齐 → `docs/design/`（人评审，机器只查引用）
- 决策背景 → `docs/adr/`；编码细则 → `docs/conventions/`（不进主上下文）
- 待办与迭代方向 → `PLAN.md`；版本变更 → `CHANGELOG.md`

## 6. 工作循环

0. **开工前分诊**：先过 `using-skills`，把激活 skill 的清单落成 todo。
   顺序：规格(brainstorming)→计划(writing-plans)→测试先红(red-first)→实现(executing-plans)
1. 读 `.state/session.json` 恢复上下文
2. 最小改动
3. 跑 `python scripts/gate.py -p saas-identity-platform-flutter`；exit 1 回到第 2 步；exit 2 停下问人
4. `/handoff` 更新 `.state/session.json`

> 家族值表与治理规则：suite docs/families/saas.md 与 docs/conventions/multi-repo-family.md §10
