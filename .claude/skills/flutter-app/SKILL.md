---
name: flutter-app
description: flutter 仓开发时使用——dart-dio 生成物坑指纹、trace 锚纪律、http_mock_adapter 配方、UTC 序列化、小节顺序按开发动线排列。
---

# Flutter App

## 生成物（lib/generated/）——只认管线，不手改

API 面只认 gen-shared.sh 产物（suite 硬规则 §4）。红在 generated/ 下先对指纹：

| 红的指纹 | 真因 | 处置 |
|---|---|---|
| `constant_identifier_names ×N` | 契约枚举值大写 | 生成目录 analysis_options.yaml 已自动关此 lint；勿手改成员名 |
| `static const X  = _$;` 非法代码 / exit 3「修补② 失配」 | 生成器/契约形状漂移 | 停下查，勿放水 |
| `class_used_as_mixin ×N` | 生成模型尾部的枚举 mixin 触发行 | gen-shared.sh 修补已删触发行；再现 = 修补失效 |

契约枚举命名随家族：swift 与 dart 同枚举同命名（RequirementComparison `gte/lte`，wireName 保持符号）。

## trace 锚纪律（三犯过的坑）

- `// fn:` 锚写在 test 回调体内第一行；`// @entry` 是文件级 alignment.json 锚，写在文件第一行。两类锚不同位次，勿混。
- Write 测试文件的同一 action 内必须带锚行，写完 `grep -c "fn:"` 自查。trace_cmd 报出的测试数/ID 数若等于旧账，就是锚缺失信号。
- format 之后补跑一次 trace_cmd 验锚。一个 ID 至少一锚，每锚必证该 ID 的行为；同 ID 多锚允许。
- 长测试名折行：trace_cmd 已支持声明折行归并匹配（2026-10-12），名字横跨多行也能锚上；名字保持单行仍是好习惯。

## http_mock_adapter 0.6.1

- `DioAdapter(dio: dio, matcher: const UrlRequestMatcher())`。dio 必填，无参构造编译不过；默认 FullHttpRequestMatcher 对「注册时无 data: 的路由」永不匹配带体请求，login 等 POST 全炸成「无法连接服务器」。
- UrlRequestMatcher 只比 path 不比 method，同路径注册后者覆盖前者。
  - 无回读场景：写 handler 在初始 load 之后注册。
  - 同路径「写后回读」：后注册会顶掉读，回读撞写 handler 后 `r.data!` 炸。必须折成单 handler，按 `options.method` 分流（DELETE 用 void 契约可吞 body）。
- 契约非空字段 fixture 给 null，会反序列化静默炸进错误态（SysMenu.parentId 先例）。探针：`tester.allWidgets.whereType<Text>().map((t) => t.data)` 打屏面看走了哪个分支。

## 序列化：Iso8601DateTimeSerializer 只收 UTC

本地时区 DateTime 进 serialize 即炸，包成 `DioException(type: unknown, response: null)`，页面全走「无法连接服务器」，拦截器与 adapter 都看不到请求（炸在序列化层，先于 wire）。

日期字段用 `DateTime.utc(y, m, d)` 构造，保住用户选的日期语义；勿裸 `.toUtc()`，否则 ±8 时区日期漂移。

探针：直接调生成 API 层，catch DioException 打 `e.error`，一击即中。

## barrel 同名冲突

生成 barrel 导出契约 `AuthState`（SSO 授权枚举），与应用 sealed `AuthState` 同名，同文件双 import 编译歧义。barrel import 加 `hide AuthState`（应用版胜出）；要生成版必须换 `as gen` 前缀 import（hide 无法反向暴露）。新仓接认证切片 day-one 就撞，import 写法照此。

## 测试 rig：别让 override 绕过 401 缝

`dioProvider.overrideWithValue(裸 Dio)` 使 buildDio 永不执行，AuthInterceptor 不在链上，mock 401 到不了 SessionGuard（红灯 `Expected AuthAnonymous / Actual Authed` 即此指纹）。rig 手动 `dio.interceptors.add(AuthInterceptor(...))`，真实 interceptor 加同一 store/guard 实例端到端。

缝测试红在 state 断言而非 DioException，先查 rig 有没有 interceptor。

## 杂项

- riverpod 3.4.3：先 read 挂载再 pumpEventQueue（先 pump 再 read 是 no-op）；NotifierProvider 默认 keepAlive；widget 测试 pumpWidget 加 pumpAndSettle 够用。
- `dio.get/post` 裸调用加 `<dynamic>`（strict-inference）。
- trace.json 形状 `{"schema":1,"tests":[{"test":...,"fns":[...]}]}`，选择器按 `tests[].fns` 展开，别按顶层键写。
- saas 家族 list 端点 page 是 0 基（判例 M96.F02.I60/I61）；lab 家族另查 lab 判例，勿想当然。
