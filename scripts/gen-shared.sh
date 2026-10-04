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
  (cd "$ROOT/.openapi-tmp/dart" && dart pub get)
  (cd "$ROOT/.openapi-tmp/dart" && dart run build_runner build --delete-conflicting-outputs)
fi

echo "[gen-shared] step 3/3 — 拷 lib/ → lib/generated/（先删后写，手改被机械抹掉）..."
mkdir -p "$ROOT/lib/generated"
rm -rf "$ROOT/lib/generated"/*
cp -r "$ROOT/.openapi-tmp/dart/lib/." "$ROOT/lib/generated/"
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
