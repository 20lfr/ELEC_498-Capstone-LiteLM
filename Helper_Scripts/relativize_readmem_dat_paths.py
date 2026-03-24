#!/usr/bin/env python3
"""
Description:
    Convert absolute .dat paths in $readmemh/$readmemb calls back to plain
    filenames, making generated RTL portable after the repo is moved/renamed.

Usage:
    python3 relativize_readmem_dat_paths.py --rtl-dir <rtl_dir>

Args:
    --rtl-dir   Directory containing generated .v/.sv files to patch (required).

Example:
    python3 Helper_Scripts/relativize_readmem_dat_paths.py \
      --rtl-dir Model-architectures/phi3-mini-int4-HARDWARE/HLS-Verilog/Verilog-top-module
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


READMEM_PATTERN = re.compile(
    r'(?P<prefix>\$readmem[hb]\s*\(\s*")'
    r'(?P<path>/[^"\n]*?\.dat)'
    r'(?P<suffix>"\s*,)',
    flags=re.IGNORECASE,
)


def rewrite_file(path: Path) -> int:
    text = path.read_text()
    replacements = 0

    def repl(match: re.Match[str]) -> str:
        nonlocal replacements
        abs_path = match.group("path")
        filename = Path(abs_path).name
        replacements += 1
        return f'{match.group("prefix")}{filename}{match.group("suffix")}'

    new_text = READMEM_PATTERN.sub(repl, text)
    if new_text != text:
        path.write_text(new_text)
    return replacements


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Relativize absolute .dat paths in $readmemh/$readmemb calls."
    )
    parser.add_argument(
        "--rtl-dir",
        required=True,
        help="Directory containing generated RTL files (.v/.sv).",
    )
    args = parser.parse_args()

    rtl_dir = Path(args.rtl_dir).resolve()
    if not rtl_dir.is_dir():
        raise SystemExit(f"ERROR: --rtl-dir does not exist: {rtl_dir}")

    files = sorted(list(rtl_dir.rglob("*.v")) + list(rtl_dir.rglob("*.sv")))
    changed_files = 0
    total_replacements = 0

    for file_path in files:
        before = file_path.read_text()
        replacements = rewrite_file(file_path)
        if replacements > 0 and file_path.read_text() != before:
            changed_files += 1
            total_replacements += replacements

    print(f"RTL dir          : {rtl_dir}")
    print(f"Files scanned    : {len(files)}")
    print(f"Files modified   : {changed_files}")
    print(f"Path replacements: {total_replacements}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
