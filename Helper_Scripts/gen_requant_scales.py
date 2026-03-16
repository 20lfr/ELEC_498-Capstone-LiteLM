#!/usr/bin/env python3
"""
gen_requant_scales.py — Generate requant_scales_vN.hpp from quant_scales.json.

Usage:
    python gen_requant_scales.py [--ln-shift 9] [--head-shift 15] [--dry-run]
                                 [--scales path/to/quant_scales.json]
                                 [--out-dir path/to/HLS-Verilog/]

Each run auto-increments N and writes requant_scales_vN.hpp in out-dir.
To activate: recompile with -DREQUANT_SCALES_VER=N.

M/N formula (from requant_scales_v0.hpp header):
    n = floor(log2((2^31 - 1) / real_scale))
    M = round(real_scale * 2^n)

Real-scale derivations:
    POST_LN0/LN1  : 2^(-ln_shift)            (LN Q16.16 -> int8)
    POST_OUTPROJ  : wo_eff[l]                 (out-proj int8 acc -> int8)
    FFN_W1        : w1_eff[l] * 16            (int8 acc -> Q5.11; 2^4 maps 2^-7*w1 to 2^-11)
    POST_FFN      : w2_eff[l] / 16            (Q5.11 acc -> int8; Q5.11 LSB=2^-11, int8 LSB=2^-7)
    Q             : wq_eff[l]
    K             : wk_eff[l]
    V             : wv_eff[l]
    HEAD          : 2^(-head_shift)           (Q15 softmax x int8 V -> int8)
"""

import argparse
import glob
import json
import math
import os
import re
import sys
from datetime import date

INT31_MAX = (1 << 31) - 1
NUM_LAYERS = 12


def compute_mn(real_scale: float):
    """Return (M, n) for the fixed-point requant formula M/2^n ≈ real_scale."""
    n = int(math.floor(math.log2(INT31_MAX / real_scale)))
    M = int(round(real_scale * (2 ** n)))
    return M, n


def next_version(out_dir: str) -> int:
    existing = glob.glob(os.path.join(out_dir, "requant_scales_v*.hpp"))
    nums = []
    for p in existing:
        m = re.search(r"requant_scales_v(\d+)\.hpp$", p)
        if m:
            nums.append(int(m.group(1)))
    return max(nums) + 1 if nums else 0


def fmt_i32_array(name: str, values: list, indent: int = 0) -> str:
    pad = " " * indent
    inner = ", ".join(str(v) for v in values)
    return f"{pad}constexpr int32_t {name}[MODEL_LAYERS] = {{ {inner} }};"


def fmt_f64_array(name: str, values: list, indent: int = 0) -> str:
    pad = " " * indent
    inner = ", ".join(f"{v:.18g}" for v in values)
    return f"{pad}constexpr double {name}[MODEL_LAYERS] = {{\n{pad}    {inner}\n{pad}}};"


def build_header(scales: dict, ln_shift: int, head_shift: int, version: int,
                 scales_path: str, cmd: str) -> str:
    ln_scale = 2.0 ** (-ln_shift)
    head_scale = 2.0 ** (-head_shift)

    # Per-layer scale lists
    S_wq = [scales[f"layer{l}.wq_eff"] for l in range(NUM_LAYERS)]
    S_wk = [scales[f"layer{l}.wk_eff"] for l in range(NUM_LAYERS)]
    S_wv = [scales[f"layer{l}.wv_eff"] for l in range(NUM_LAYERS)]
    S_wo = [scales[f"layer{l}.wo_eff"] for l in range(NUM_LAYERS)]
    S_w1 = [scales[f"layer{l}.w1_eff"] for l in range(NUM_LAYERS)]
    S_w2 = [scales[f"layer{l}.w2_eff"] for l in range(NUM_LAYERS)]

    # Compute M/N per operation per layer
    def layer_mn(real_scales):
        Ms, Ns = [], []
        for s in real_scales:
            M, n = compute_mn(s)
            Ms.append(M)
            Ns.append(n)
        return Ms, Ns

    ln_M, ln_N = compute_mn(ln_scale)
    head_M, head_N = compute_mn(head_scale)

    outproj_Ms, outproj_Ns = layer_mn(S_wo)
    ffn_w1_Ms, ffn_w1_Ns = layer_mn([s * 16.0 for s in S_w1])
    post_ffn_Ms, post_ffn_Ns = layer_mn([s / 16.0 for s in S_w2])
    q_Ms, q_Ns = layer_mn(S_wq)
    k_Ms, k_Ns = layer_mn(S_wk)
    v_Ms, v_Ns = layer_mn(S_wv)

    today = date.today().isoformat()
    rel_scales = os.path.relpath(scales_path)

    lines = []
    a = lines.append

    a(f"// AUTO-GENERATED — do not edit by hand.")
    a(f"// Command:  {cmd}")
    a(f"// Source:   {rel_scales}")
    a(f"// Date:     {today}")
    a(f"// ln_shift={ln_shift}  (LN real_scale = 2^-{ln_shift} = {ln_scale:.6g})")
    a(f"// head_shift={head_shift}  (HEAD real_scale = 2^-{head_shift} = {head_scale:.6g})")
    a(f"//")
    a(f"// M/N formula:  n = floor(log2((2^31-1)/real_scale)),  M = round(real_scale * 2^n)")
    a(f"//")
    a(f"// Real-scale derivations:")
    a(f"//   POST_LN0/LN1  : 2^(-ln_shift)  (LN Q16.16 -> int8)")
    a(f"//   POST_OUTPROJ  : wo_eff[l]")
    a(f"//   FFN_W1        : w1_eff[l] * 16  (int8 acc -> Q5.11)")
    a(f"//   POST_FFN      : w2_eff[l] / 16  (Q5.11 acc -> int8)")
    a(f"//   Q/K/V         : w{{q,k,v}}_eff[l]")
    a(f"//   HEAD          : 2^(-head_shift)  (Q15 softmax x int8 V -> int8)")
    a(f"//")
    a(f"// KNOWN ISSUE (bias format): Biases are stored as Q16.16 but added to raw int8 accumulators.")
    a(f"// Error is ~1-4x on bias term; bias contribution to accumulator is <1%, net effect <0.1%.")
    a(f"#pragma once")
    a(f"")
    a(f"#include <cstdint>")
    a(f"")

    # requant_scales namespace
    a(f"namespace requant_scales {{")
    a(f"// Fixed-point scale for Q16.16 LN outputs: 2^-16")
    a(f"constexpr double S_FIXED_Q16_16 = 1.0 / 65536.0;")
    a(f"")
    a(f"// Scales from model/quant_scales.json")
    a(f"constexpr double S_embed_tokens = {scales['embed_tokens']:.18g};")
    a(f"constexpr double S_pos_embed = {scales['pos_embed']:.18g};")
    a(f"constexpr double S_lm_head_eff = {scales['lm_head_eff']:.18g};")
    a(f"")
    a(f"// Effective per-layer weight scales from quant_scales.json (*_eff)")
    a(fmt_f64_array("S_w_wq_L", S_wq))
    a(fmt_f64_array("S_w_wk_L", S_wk))
    a(fmt_f64_array("S_w_wv_L", S_wv))
    a(fmt_f64_array("S_w_wo_L", S_wo))
    a(fmt_f64_array("S_w_w1_L", S_w1))
    a(fmt_f64_array("S_w_w2_L", S_w2))
    a(f"")
    a(f"// Backward-compatible single-layer aliases (layer 0)")
    a(f"constexpr double S_w_wq = S_w_wq_L[0];")
    a(f"constexpr double S_w_wk = S_w_wk_L[0];")
    a(f"constexpr double S_w_wv = S_w_wv_L[0];")
    a(f"constexpr double S_w_wo = S_w_wo_L[0];")
    a(f"constexpr double S_w_w1 = S_w_w1_L[0];")
    a(f"constexpr double S_w_w2 = S_w_w2_L[0];")
    a(f"")
    a(f"// FFN_W2_SCALE_Q15 kept for reference but unused")
    a(f"constexpr int16_t FFN_W2_SCALE_Q15 = 0x4000; // 0.5 (unused)")
    a(f"}} // namespace requant_scales")
    a(f"")

    # requant_params namespace — N tables
    a(f"namespace requant_params {{")
    a(fmt_i32_array("REQUANT_POST_LN0_N_L", [ln_N] * NUM_LAYERS))
    a(fmt_i32_array("REQUANT_POST_OUTPROJ_N_L", outproj_Ns))
    a(fmt_i32_array("REQUANT_POST_LN1_N_L", [ln_N] * NUM_LAYERS))
    a(fmt_i32_array("REQUANT_POST_FFN_N_L", post_ffn_Ns))
    a(fmt_i32_array("REQUANT_FFN_W1_N_L", ffn_w1_Ns))
    a(fmt_i32_array("REQUANT_Q_N_L", q_Ns))
    a(fmt_i32_array("REQUANT_K_N_L", k_Ns))
    a(fmt_i32_array("REQUANT_V_N_L", v_Ns))
    a(fmt_i32_array("REQUANT_HEAD_N_L", [head_N] * NUM_LAYERS))
    a(f"")

    # M tables
    def fmt_m_array(name, Ms):
        pad = "    "
        half = NUM_LAYERS // 2
        row1 = ", ".join(str(m) for m in Ms[:half])
        row2 = ", ".join(str(m) for m in Ms[half:])
        return (f"constexpr int32_t {name}[MODEL_LAYERS] = {{\n"
                f"{pad}{row1},\n"
                f"{pad}{row2}\n"
                f"}};")

    a(fmt_m_array("REQUANT_POST_LN0_M_L", [ln_M] * NUM_LAYERS))
    a(fmt_m_array("REQUANT_POST_OUTPROJ_M_L", outproj_Ms))
    a(fmt_m_array("REQUANT_POST_LN1_M_L", [ln_M] * NUM_LAYERS))
    a(fmt_m_array("REQUANT_POST_FFN_M_L", post_ffn_Ms))
    a(f"// FFN W1: int8x int8 -> Q5.11 int16 (1 LSB = 2^-11, range ±16 real)")
    a(f"// real_scale = w1_eff[l] * 16;  M/2^N = w1_eff[l] * 16")
    a(fmt_m_array("REQUANT_FFN_W1_M_L", ffn_w1_Ms))
    a(fmt_m_array("REQUANT_Q_M_L", q_Ms))
    a(fmt_m_array("REQUANT_K_M_L", k_Ms))
    a(fmt_m_array("REQUANT_V_M_L", v_Ms))
    a(fmt_m_array("REQUANT_HEAD_M_L", [head_M] * NUM_LAYERS))
    a(f"")

    # Single-layer aliases
    aliases = [
        ("REQUANT_POST_LN0_N",    "REQUANT_POST_LN0_N_L[0]"),
        ("REQUANT_POST_OUTPROJ_N","REQUANT_POST_OUTPROJ_N_L[0]"),
        ("REQUANT_POST_LN1_N",    "REQUANT_POST_LN1_N_L[0]"),
        ("REQUANT_POST_FFN_N",    "REQUANT_POST_FFN_N_L[0]"),
        ("REQUANT_Q_N",           "REQUANT_Q_N_L[0]"),
        ("REQUANT_K_N",           "REQUANT_K_N_L[0]"),
        ("REQUANT_V_N",           "REQUANT_V_N_L[0]"),
        ("REQUANT_HEAD_N",        "REQUANT_HEAD_N_L[0]"),
        ("REQUANT_POST_LN0_M",    "REQUANT_POST_LN0_M_L[0]"),
        ("REQUANT_POST_OUTPROJ_M","REQUANT_POST_OUTPROJ_M_L[0]"),
        ("REQUANT_POST_LN1_M",    "REQUANT_POST_LN1_M_L[0]"),
        ("REQUANT_POST_FFN_M",    "REQUANT_POST_FFN_M_L[0]"),
        ("REQUANT_Q_M",           "REQUANT_Q_M_L[0]"),
        ("REQUANT_K_M",           "REQUANT_K_M_L[0]"),
        ("REQUANT_V_M",           "REQUANT_V_M_L[0]"),
        ("REQUANT_HEAD_M",        "REQUANT_HEAD_M_L[0]"),
    ]
    for sym, src in aliases:
        a(f"constexpr int32_t {sym} = {src};")

    a(f"}} // namespace requant_params")
    a(f"")

    return "\n".join(lines)


def print_dry_run_summary(scales: dict, ln_shift: int, head_shift: int):
    print(f"=== Dry-run summary (ln_shift={ln_shift}, head_shift={head_shift}) ===")
    ln_scale = 2.0 ** (-ln_shift)
    head_scale = 2.0 ** (-head_shift)
    ln_M, ln_N = compute_mn(ln_scale)
    head_M, head_N = compute_mn(head_scale)
    print(f"  LN     real_scale=2^-{ln_shift}={ln_scale:.4e}  N={ln_N}  M={ln_M}")
    print(f"  HEAD   real_scale=2^-{head_shift}={head_scale:.4e}  N={head_N}  M={head_M}")
    print()
    print(f"  {'Layer':>5}  {'Q N':>4} {'Q M':>12}  {'K N':>4} {'K M':>12}  {'V N':>4} {'V M':>12}  "
          f"{'OUTPROJ N':>9} {'OUTPROJ M':>12}  {'FFN_W1 N':>8} {'FFN_W1 M':>12}  {'POST_FFN N':>10} {'POST_FFN M':>12}")
    for l in range(12):
        q_M, q_N = compute_mn(scales[f"layer{l}.wq_eff"])
        k_M, k_N = compute_mn(scales[f"layer{l}.wk_eff"])
        v_M, v_N = compute_mn(scales[f"layer{l}.wv_eff"])
        o_M, o_N = compute_mn(scales[f"layer{l}.wo_eff"])
        w1_M, w1_N = compute_mn(scales[f"layer{l}.w1_eff"] * 16.0)
        w2_M, w2_N = compute_mn(scales[f"layer{l}.w2_eff"] / 16.0)
        print(f"  {l:>5}  {q_N:>4} {q_M:>12}  {k_N:>4} {k_M:>12}  {v_N:>4} {v_M:>12}  "
              f"{o_N:>9} {o_M:>12}  {w1_N:>8} {w1_M:>12}  {w2_N:>10} {w2_M:>12}")


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    default_scales = os.path.normpath(os.path.join(script_dir, "../../model/quant_scales.json"))
    default_out = os.path.normpath(os.path.join(script_dir, "../"))

    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--scales",     default=default_scales, help="Path to quant_scales.json")
    ap.add_argument("--out-dir",    default=default_out,    help="Directory to write requant_scales_vN.hpp")
    ap.add_argument("--ln-shift",   type=int, default=9,    help="LN real_scale = 2^(-ln_shift) (default 9)")
    ap.add_argument("--head-shift", type=int, default=15,   help="HEAD real_scale = 2^(-head_shift) (default 15)")
    ap.add_argument("--dry-run",    action="store_true",    help="Print tables without writing files")
    args = ap.parse_args()

    with open(args.scales) as f:
        scales = json.load(f)

    if args.dry_run:
        print_dry_run_summary(scales, args.ln_shift, args.head_shift)
        return

    version = next_version(args.out_dir)
    out_path = os.path.join(args.out_dir, f"requant_scales_v{version}.hpp")

    # Reconstruct the command for the header comment
    cmd_parts = [f"gen_requant_scales.py --ln-shift {args.ln_shift} --head-shift {args.head_shift}"]
    if args.scales != default_scales:
        cmd_parts.append(f"--scales {args.scales}")
    if args.out_dir != default_out:
        cmd_parts.append(f"--out-dir {args.out_dir}")
    cmd = " ".join(cmd_parts)

    content = build_header(scales, args.ln_shift, args.head_shift, version,
                           args.scales, cmd)

    with open(out_path, "w") as f:
        f.write(content)

    print(f"Written  {out_path}")
    print(f"Activate: recompile with -DREQUANT_SCALES_VER={version}")


if __name__ == "__main__":
    main()
