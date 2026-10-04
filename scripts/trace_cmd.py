#!/usr/bin/env python3
"""trace_cmd：扫 test/ 源码 `// fn: <功能ID>` 字面 → 产出 .state/trace.json。

契约（suite harness.py 契约二）：
    {"schema": 1, "tests": [{"test": "...", "fns": ["M01.F01.I01"], "inert": false}]}

机制（同 swift 仓 trace_cmd 人裁先例）：dart test 没有 pytest marker 生态，走源码字面扫描——
`// fn:` 注释写在 test()/testWidgets() 声明行之后的回调体内（惯例：紧随声明行）。
纪律与各家栈相同：扫描只证明「存在一个声称覆盖该 ID 的测试」，不证明真执行到；
挂 ID = 人审 diff。skip 的测试不写 fn 字面（inert 恒 false，写了也是违规，人审拦截）。

硬规则：
- trace.json 禁手写——本脚本每次全量重写；手改的内容重跑即被覆盖（AC-8）。

用法（.harness/stack.json trace_cmd 调用，cwd = 仓根）：
    python scripts/trace_cmd.py
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TESTS_DIR = ROOT / "test"
OUT = ROOT / ".state" / "trace.json"

# 与 suite harness.py FUNCTION_ID_RE 同语法的统一 ID 正则（M / M.F / M.F.I 三级）。
FN_ID_RE = re.compile(r"\bM\d{2}(?:\.F\d{2}(?:\.I\d{2})?)?\b")
# dart test 声明：test('name', ...) / testWidgets('name', ...)。
TEST_RE = re.compile(r"""\b(?:test|testWidgets)\s*\(\s*['\"](.+?)['\"]""")

# trace 条目里的 test 名 = 相对路径::描述（与 swift 仓 path::Class.method 同风格）。


def _scan_file(path: Path) -> tuple[list[dict], list[str]]:
    """返回 (该文件的 trace 条目, 该文件里锚定失败的 fn 字面描述列表)。"""
    entries: list[dict] = []
    dangling: list[str] = []
    current = ""
    order: list[str] = []  # 保序去重：一个测试挂多个 ID 时按源码出现顺序

    def flush() -> None:
        nonlocal current, order
        if current and order:
            entries.append(
                {
                    "test": f"{path.relative_to(ROOT).as_posix()}::{current}",
                    "fns": order,
                    "inert": False,
                }
            )
        current, order = "", []

    for raw in path.read_text(encoding="utf-8", errors="replace").splitlines():
        if m := TEST_RE.search(raw):
            flush()
            current = m.group(1)
        if "// fn:" in raw:
            ids = FN_ID_RE.findall(raw)
            if not ids:
                dangling.append(f"{path.name}: `{raw.strip()}`（fn 注释里没有合法功能 ID）")
            elif not current:
                dangling.append(f"{path.name}: `{raw.strip()}`（不在任何 test/testWidgets 内）")
            else:
                for fid in ids:
                    if fid not in order:
                        order.append(fid)
    flush()
    return entries, dangling


def main() -> int:
    if not TESTS_DIR.is_dir():
        print(f"trace_cmd: {TESTS_DIR} 不存在", file=sys.stderr)
        return 1
    entries: list[dict] = []
    dangling: list[str] = []
    for path in sorted(TESTS_DIR.rglob("*.dart")):
        file_entries, file_dangling = _scan_file(path)
        entries.extend(file_entries)
        dangling.extend(file_dangling)

    if dangling:
        print("trace_cmd: fn 字面锚定失败（挂 ID 是承诺，位置错了必须停下修）：", file=sys.stderr)
        for d in dangling:
            print(f"  - {d}", file=sys.stderr)
        return 1

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(
        json.dumps({"schema": 1, "tests": entries}, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    ids = sorted({fid for e in entries for fid in e["fns"]})
    print(f"trace_cmd: {len(entries)} 个测试挂 {len(ids)} 个功能 ID → .state/trace.json")
    return 0


if __name__ == "__main__":
    sys.exit(main())
