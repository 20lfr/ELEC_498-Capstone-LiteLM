#!/usr/bin/env python3
"""
Description:
    Rewrite relative .dat file paths in $readmemh/$readmemb calls to absolute
    realpaths so RTL can find the data regardless of the working directory.

Usage:
    python3 fix_readmemh_dat_paths.py --rtl-dir <rtl_dir> [--dat-root <dat_root>]

Args:
    --rtl-dir   Directory containing generated .v/.sv files to patch (required).
    --dat-root  Base directory used to resolve .dat files; defaults to --rtl-dir.

Example:
    python3 fix_readmemh_dat_paths.py \
      --rtl-dir HLS-Verilog/Verilog-top-module/MMU_Top_module_Integration/verilog
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


READMEM_PATTERN = re.compile(
    r'(?P<prefix>\$readmem[hb]\s*\(\s*")'
    r'(?P<dat>(?!/)[^"\n]*?\.dat)'
    r'(?P<suffix>"\s*,)',
    flags=re.IGNORECASE,
)


def rewrite_file(path: Path, dat_root: Path) -> int:
    text = path.read_text()
    replacements = 0

    def repl(match: re.Match[str]) -> str:
        nonlocal replacements
        dat_rel = match.group("dat")
        # Normalize leading "./" and build realpath under dat_root.
        dat_abs = (dat_root / dat_rel.lstrip("./")).resolve()
        replacements += 1
        return f'{match.group("prefix")}{dat_abs}{match.group("suffix")}'

    new_text = READMEM_PATTERN.sub(repl, text)
    if new_text != text:
        path.write_text(new_text)
    return replacements


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Convert relative .dat paths in readmem calls to absolute realpaths."
    )
    parser.add_argument(
        "--rtl-dir",
        required=True,
        help="Directory containing generated RTL files (.v/.sv).",
    )
    parser.add_argument(
        "--dat-root",
        default=None,
        help="Root directory used to resolve .dat files. Defaults to --rtl-dir.",
    )
    args = parser.parse_args()

    rtl_dir = Path(args.rtl_dir).resolve()
    dat_root = Path(args.dat_root).resolve() if args.dat_root else rtl_dir

    if not rtl_dir.is_dir():
        raise SystemExit(f"ERROR: --rtl-dir does not exist: {rtl_dir}")
    if not dat_root.is_dir():
        raise SystemExit(f"ERROR: --dat-root does not exist: {dat_root}")

    files = sorted(list(rtl_dir.rglob("*.v")) + list(rtl_dir.rglob("*.sv")))
    changed_files = 0
    total_replacements = 0

    for file_path in files:
        before = file_path.read_text()
        replacements = rewrite_file(file_path, dat_root)
        if replacements > 0 and file_path.read_text() != before:
            changed_files += 1
            total_replacements += replacements

    print(f"RTL dir          : {rtl_dir}")
    print(f"DAT root         : {dat_root}")
    print(f"Files scanned    : {len(files)}")
    print(f"Files modified   : {changed_files}")
    print(f"Path replacements: {total_replacements}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
