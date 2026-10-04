#!/bin/bash
# Generate Dart(Dio) API client locally from shared's OpenAPI.yaml.
#
# 架构（家族同款）：shared 仓是纯契约源（TypeSpec → OpenAPI.yaml only），
# 语言产物在各消费仓本地生成（suite 硬规则 §4：API 面只认生成物，禁手写接口层）。
# 本脚本：先触发 shared emit，再跑 openapi-generator dart-dio 产 dio client，
# 产物拷进 lib/generated/（禁手改，regen 先删后写）。
#
# 生成需 Node + Java + Dart SDK（Flutter SDK 捆绑）：openapi-generator 走 npx
# （Node+Java）；dart-dio 产物含 `part '*.g.dart'` 时在临时包内跑 build_runner 补齐。
# 产物 committed；门禁/测试机器只需 Flutter SDK，不需生成器。
set -euo pipefail

SHARED_DIR="$(cd "$(dirname "$0")/../../saas-identity-platform-shared" && pwd)"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "[gen-shared] step 1/3 — shared: emit OpenAPI.yaml..."
(cd "$SHARED_DIR" && npm run emit:openapi)

OPENAPI="$SHARED_DIR/generated/openapi/openapi.yaml"
if [ ! -f "$OPENAPI" ]; then
  echo "[gen-shared] ERROR: missing $OPENAPI" >&2
  exit 1
fi

echo "[gen-shared] step 2/3 — dart-dio: openapi-generator → .openapi-tmp..."
# hideGenerationTimestamp=true（swift 5.70 同教训）：不关则每次 regen 全量 diff 污染 commit。
rm -rf "$ROOT/.openapi-tmp"
npx --yes @openapitools/openapi-generator-cli generate \
  -g dart-dio \
  -i "$OPENAPI" \
  -o "$ROOT/.openapi-tmp/dart" \
  --additional-properties=hideGenerationTimestamp=true,pubName=saas_shared_generated

# dart-dio 产物含 part 指令（json_serializable）时，在临时包内跑 build_runner 补 .g.dart。
if grep -rq "part '" "$ROOT/.openapi-tmp/dart/lib" 2>/dev/null; then
  if ! command -v dart >/dev/null 2>&1; then
    echo "[gen-shared] fail-loud：产物含 part '*.g.dart' 但本机无 dart——先装 Flutter SDK（README 快速开始）再跑" >&2
    exit 3
  fi
  echo "[gen-shared] step 2.5/3 — build_runner 补 .g.dart..."
  # dart-dio 枚举模板 × Dart 3 已知互斥（首跑实证 2026-10-04）：枚举模型尾部
  # `abstract class XMixin = Object with _$XMixin;`（built_value 枚举 mixin 触发行，
  # 见生成文件内自带注释）会令 built_value_generator 产出 `abstract class _$XMixin`，
  # 而 Dart 3 禁止普通 class 进 with 子句 → class_used_as_mixin error ×4
  # （SysMenuType / SysUserStatus / TenantMemberStatus / TenantStatus）。
  # built_value 官方语义：删触发行即不生成 mixin（Angular 时代遗物，消费方无人用）。
  # 同 swift 仓「已知生成器缺陷脚本内修补」先例；确定性 sed，幂等。
  sed -i '/^abstract class .*Mixin = Object with _\$/d' "$ROOT"/.openapi-tmp/dart/lib/src/model/*.dart
  (cd "$ROOT/.openapi-tmp/dart" && dart pub get)
  (cd "$ROOT/.openapi-tmp/dart" && dart run build_runner build --delete-conflicting-outputs)
fi

echo "[gen-shared] step 3/3 — 拷 lib/ → lib/generated/（先删后写，手改被机械抹掉）..."
# dart-dio 7.25.0 实测布局：lib/src/{api,auth,model} + lib/<pubName>.dart（barrel）。
# 拷贝时削掉 src/ 层（守卫按 lib/generated/api|model 检查；消费方 import 路径也更短），
# barrel 一并带入。
mkdir -p "$ROOT/lib/generated"
rm -rf "$ROOT/lib/generated"/*
cp -r "$ROOT/.openapi-tmp/dart/lib/src/." "$ROOT/lib/generated/"
cp "$ROOT/.openapi-tmp/dart/lib/saas_shared_generated.dart" "$ROOT/lib/generated/"
# 生成物以生成包名自 import（package:saas_shared_generated/src/...，39 处文件实测）；
# 进宿主包后该前缀失效，确定性 sed 改写到宿主 generated/ 路径（幂等：对已改写文本零影响）。
LC_ALL=C.UTF-8 grep -rl 'package:saas_shared_generated/src/' "$ROOT/lib/generated" \
  | xargs -r sed -i 's#package:saas_shared_generated/src/#package:saas_identity_platform_flutter/generated/#g'
# 守卫前置：包名自 import 残留 = 改写漏网（生成器换了 import 形状），停下查。
if grep -rq 'package:saas_shared_generated/' "$ROOT/lib/generated"; then
  echo "[gen-shared] fail-loud：残留 package:saas_shared_generated/ 自 import（改写规则失配）" >&2
  exit 3
fi
# 生成器已知缺陷守卫（swift5 「case +=」同款先例）：枚举 mixin 触发行必须已被
# 2.5 步修补删净；残留 = 生成器模板漂移，Dart 3 下必然 class_used_as_mixin 红编译。
if grep -rn "Mixin = Object with" "$ROOT/lib/generated" >/dev/null 2>&1; then
  echo "[gen-shared] fail-loud：枚举 mixin 触发行残留（step 2.5 修补失配？）" >&2
  exit 3
fi
# 生成物目录级 analyzer 配置：error/warning 分析保留（生成物照样过类型检查），
# 仅关闭生成器风格类 lint（首跑 322 info × 6 规则）与生成器固有噪声告警
# （unused_import ×24 / strict_raw_type / unused_element_parameter）。
# 手写代码不受影响（仓库根严格档仍全开）；目录被本脚本先删后写，故每跑必重写（幂等）。
cat > "$ROOT/lib/generated/analysis_options.yaml" <<'EOF'
# AUTO-WRITTEN BY scripts/gen-shared.sh — DO NOT EDIT (regen wipes this dir).
# 生成物保留 error/warning 级分析（类型检查全量），linter 风格规则与生成器
# 固有噪声告警在本目录关闭；手写代码沿用仓库根 analysis_options 严格档。
include: ../../analysis_options.yaml
analyzer:
  errors:
    unused_import: ignore
    strict_raw_type: ignore
    unused_element_parameter: ignore
linter:
  rules:
    no_leading_underscores_for_local_identifiers: false
    use_function_type_syntax_for_parameters: false
    unnecessary_this: false
    unnecessary_lambdas: false
    use_super_parameters: false
    unnecessary_brace_in_string_interps: false
EOF
# dart format 落盘：生成器输出与当前 SDK 格式化器有出入（首跑 126 文件红 L1），
# 格式化后的字节即 committed 形态；同 SDK 重跑格式化零变化 → 幂等不破。
if command -v dart >/dev/null 2>&1; then
  dart format "$ROOT/lib/generated" >/dev/null
else
  echo "[gen-shared] fail-loud：无 dart，无法格式化生成物（L1 门会红）" >&2
  exit 3
fi
rm -rf "$ROOT/.openapi-tmp"

# fail-loud 结构守卫：关键产物缺任一 = 生成器输出结构漂移，停下查（同 swift 仓守卫先例）。
if [ -z "$(find "$ROOT/lib/generated/api" -name '*.dart' 2>/dev/null)" ] \
  || [ -z "$(find "$ROOT/lib/generated/model" -name '*.dart' 2>/dev/null)" ]; then
  echo "[gen-shared] fail-loud：lib/generated/api|model 无 dart 文件（生成器输出结构漂移？）" >&2
  exit 3
fi

# 生成器已知缺陷守卫：swift5 有符号枚举非法 case 缺陷（family 记忆），dart-dio 首跑
# 若发现同类缺陷，在此追加 fail-loud grep（同 swift 仓「case +=」守卫先例）。

# ADR-0026 marker（同 sha 零写入，5.77 同款）。
SHARED_SHA=$(cd "$SHARED_DIR" && git rev-parse HEAD)
MARKER="$ROOT/.state/last-gen-shared.json"
mkdir -p "$ROOT/.state"
python3 - "$MARKER" "$SHARED_SHA" <<'PYEOF' || echo "[gen-shared] WARN: marker 写失败（staleness 将报 UNKNOWN）" >&2
import datetime, json, sys

marker_path, shared_sha = sys.argv[1:3]
try:
    with open(marker_path, encoding="utf-8") as f:
        marker = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    marker = {}

if marker.get("api_synced_sha") == shared_sha:
    print("[marker] api_synced_sha unchanged - zero write (5.77)")
    sys.exit(0)

marker["api_synced_sha"] = shared_sha
marker["api_synced_at"] = datetime.datetime.now(datetime.timezone.utc).isoformat()
marker["api_synced_cmd"] = "gen-shared.sh"
marker["shared_sha"] = shared_sha
marker["consumer_repo"] = "saas-identity-platform-flutter"

with open(marker_path, "w", encoding="utf-8") as f:
    json.dump(marker, f, ensure_ascii=False, indent=2)
    f.write("\n")
PYEOF

echo "[gen-shared] OK (shared HEAD ${SHARED_SHA:0:7})"
