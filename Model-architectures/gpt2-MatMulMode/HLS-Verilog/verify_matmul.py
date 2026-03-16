#!/usr/bin/env python3
"""
verify_matmul.py — Python reference verifier for matmul_mode_tb

Reads matmul_results.bin (produced by matmul_mode_tb) and independently
computes every expected int32 dot product from the DDR image weights and
the same activation inputs used by the testbench.

Usage:
    python verify_matmul.py [--results matmul_results.bin] [--ddr ddr_image.bin]
                            [--stream-in stream_in.bin] [--verbose]

All paths default to locations relative to this script's directory.

Record binary format (matches C++ write_result_record):
    uint8  op
    uint8  layer
    uint8  head
    uint16 tile       (little-endian)
    uint8  n_int32s
    int32  out[n_int32s]  (little-endian)
"""

import argparse
import os
import struct
import sys

import numpy as np

# ---------------------------------------------------------------------------
# Architecture constants — must match shared_params.hpp / top_params.hpp
# ---------------------------------------------------------------------------
NUM_LAYERS          = 12
NUM_HEADS           = 12
D_MODEL             = 768
D_HEADS             = 64
D_FFN               = 3072
D_VOCAB             = 50257
D_HEAD_TILE_QKV     = 4
D_TILE_WO           = 16
D_TILE_W1           = 16
D_TILE_W2           = 8
D_TILE_LOGIT        = 16
ATT_CTX_BLOCK       = 64
D_HEAD_TILE_ATT_VALUE = 4
CONTEXT_LENGTH      = 1024
NUM_QKV_HEAD_TILES  = D_HEADS // D_HEAD_TILE_QKV           # 16
NUM_WO_TILES        = D_MODEL // D_TILE_WO                 # 48
NUM_W1_TILES        = D_FFN   // D_TILE_W1                 # 192
NUM_W2_TILES        = D_MODEL // D_TILE_W2                 # 96
NUM_LOGIT_TILES     = (D_VOCAB + D_TILE_LOGIT - 1) // D_TILE_LOGIT  # 3142
NUM_ATT_CTX_BLOCKS  = CONTEXT_LENGTH // ATT_CTX_BLOCK      # 16
NUM_ATT_VALUE_HEAD_TILES = D_HEADS // D_HEAD_TILE_ATT_VALUE  # 16

STREAM_IN_BUF_BYTES = D_FFN     # 3072

# Op codes — must match ComputeOp enum in top_params.hpp
CMP_NONE       = 0
CMP_Q          = 1
CMP_K          = 2
CMP_V          = 3
CMP_ATT_SCORES = 4
CMP_ATT_VALUE  = 5
CMP_OUT_PROJ   = 6
CMP_FFN_W1     = 7
CMP_FFN_W2     = 8
CMP_LOGITS     = 9

# DDR base byte offsets (from model/layout.txt / shared_params.hpp)
# All in bytes.
OFF_WQ     = 0x00000000
OFF_WK     = 0x006C0000
OFF_WV     = 0x00D80000
OFF_WO     = 0x01440000
OFF_W1     = 0x01B00000
OFF_W2     = 0x03600000
OFF_WLOGIT = 0x05100000

# KV cache offsets (must match K_CACHE_OFF / V_CACHE_OFF)
# K and V caches are separate regions each KV_CACHE_TOTAL_BYTES in size.
KV_CACHE_TOTAL_BYTES = NUM_LAYERS * NUM_HEADS * CONTEXT_LENGTH * D_HEADS  # int8 bytes
K_CACHE_OFF = 0
V_CACHE_OFF = KV_CACHE_TOTAL_BYTES  # immediately after K cache

# Per-layer / per-head strides inside each weight matrix
# WQ/WK/WV: [NUM_LAYERS × NUM_HEADS × D_HEADS × D_MODEL]
WQ_LAYER_STRIDE = NUM_HEADS * D_HEADS * D_MODEL   # 589824
WQ_HEAD_STRIDE  = D_HEADS * D_MODEL               # 49152
WQK_TILE_BYTES  = D_HEAD_TILE_QKV * D_MODEL       # 3072

# WO: [NUM_LAYERS × NUM_WO_TILES × D_TILE_WO × D_MODEL]
WO_LAYER_STRIDE = NUM_WO_TILES * D_TILE_WO * D_MODEL  # 589824
WO_TILE_BYTES   = D_TILE_WO * D_MODEL                  # 12288

# W1: [NUM_LAYERS × NUM_W1_TILES × D_TILE_W1 × D_MODEL]
W1_LAYER_STRIDE = NUM_W1_TILES * D_TILE_W1 * D_MODEL  # 2359296
W1_TILE_BYTES   = D_TILE_W1 * D_MODEL                  # 12288

# W2: [NUM_LAYERS × NUM_W2_TILES × D_TILE_W2 × D_FFN]
W2_LAYER_STRIDE = NUM_W2_TILES * D_TILE_W2 * D_FFN    # 2359296
W2_TILE_BYTES   = D_TILE_W2 * D_FFN                    # 24576

# WLOGIT: [NUM_LOGIT_TILES × D_TILE_LOGIT × D_MODEL] (last tile may be partial)
WLOGIT_TILE_BYTES = D_TILE_LOGIT * D_MODEL              # 12288

# KV cache strides (int8 layout)
KV_LAYER_STRIDE = NUM_HEADS * NUM_ATT_CTX_BLOCKS * ATT_CTX_BLOCK * D_HEADS  # 786432
KV_HEAD_STRIDE  = NUM_ATT_CTX_BLOCKS * ATT_CTX_BLOCK * D_HEADS              # 65536
KV_CTX_STRIDE   = ATT_CTX_BLOCK * D_HEADS                                   # 4096

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def script_dir() -> str:
    return os.path.dirname(os.path.abspath(__file__))


def default_path(name: str) -> str:
    return os.path.join(script_dir(), name)


def default_model_path(name: str) -> str:
    return os.path.join(script_dir(), "..", "model", name)


def load_bytes(path: str) -> bytes:
    with open(path, "rb") as f:
        return f.read()


def act_len_for_op(op: int) -> int:
    if op == CMP_ATT_SCORES:
        return D_HEADS
    if op == CMP_ATT_VALUE:
        return CONTEXT_LENGTH * 2  # int16[CONTEXT_LENGTH]
    if op == CMP_FFN_W2:
        return D_FFN
    return D_MODEL


def valid_n_out(op: int) -> int:
    return {
        CMP_Q:          D_HEAD_TILE_QKV,
        CMP_K:          D_HEAD_TILE_QKV,
        CMP_V:          D_HEAD_TILE_QKV,
        CMP_ATT_SCORES: ATT_CTX_BLOCK,
        CMP_ATT_VALUE:  D_HEAD_TILE_ATT_VALUE,
        CMP_OUT_PROJ:   D_TILE_WO,
        CMP_FFN_W1:     D_TILE_W1,
        CMP_FFN_W2:     D_TILE_W2,
        CMP_LOGITS:     D_TILE_LOGIT,
    }.get(op, 0)


def op_name(op: int) -> str:
    return {
        CMP_Q:          "Q",
        CMP_K:          "K",
        CMP_V:          "V",
        CMP_ATT_SCORES: "ATT_SCORES",
        CMP_ATT_VALUE:  "ATT_VALUE",
        CMP_OUT_PROJ:   "OUT_PROJ",
        CMP_FFN_W1:     "W1",
        CMP_FFN_W2:     "W2",
        CMP_LOGITS:     "LOGITS",
    }.get(op, f"?{op}")


# ---------------------------------------------------------------------------
# Weight tile extraction from DDR bytes
# ---------------------------------------------------------------------------

def get_wqkv_tile(ddr: bytes, op: int, layer: int, head: int, tile: int) -> np.ndarray:
    """Extract WQ/WK/WV tile: [D_HEAD_TILE_QKV × D_MODEL] int8."""
    base = {CMP_Q: OFF_WQ, CMP_K: OFF_WK, CMP_V: OFF_WV}[op]
    off = base + layer * WQ_LAYER_STRIDE + head * WQ_HEAD_STRIDE + tile * WQK_TILE_BYTES
    raw = ddr[off: off + WQK_TILE_BYTES]
    return np.frombuffer(raw, dtype=np.int8).reshape(D_HEAD_TILE_QKV, D_MODEL)


def get_wo_tile(ddr: bytes, layer: int, tile: int) -> np.ndarray:
    """Extract WO tile: [D_TILE_WO × D_MODEL] int8."""
    off = OFF_WO + layer * WO_LAYER_STRIDE + tile * WO_TILE_BYTES
    raw = ddr[off: off + WO_TILE_BYTES]
    return np.frombuffer(raw, dtype=np.int8).reshape(D_TILE_WO, D_MODEL)


def get_w1_tile(ddr: bytes, layer: int, tile: int) -> np.ndarray:
    """Extract W1 tile: [D_TILE_W1 × D_MODEL] int8."""
    off = OFF_W1 + layer * W1_LAYER_STRIDE + tile * W1_TILE_BYTES
    raw = ddr[off: off + W1_TILE_BYTES]
    return np.frombuffer(raw, dtype=np.int8).reshape(D_TILE_W1, D_MODEL)


def get_w2_tile(ddr: bytes, layer: int, tile: int) -> np.ndarray:
    """Extract W2 tile: [D_TILE_W2 × D_FFN] int8."""
    off = OFF_W2 + layer * W2_LAYER_STRIDE + tile * W2_TILE_BYTES
    raw = ddr[off: off + W2_TILE_BYTES]
    return np.frombuffer(raw, dtype=np.int8).reshape(D_TILE_W2, D_FFN)


def get_wlogit_tile(ddr: bytes, tile: int) -> np.ndarray:
    """Extract WLOGIT tile: [n_rows × D_MODEL] int8, n_rows may be < D_TILE_LOGIT on last tile."""
    off = OFF_WLOGIT + tile * WLOGIT_TILE_BYTES
    row_start = tile * D_TILE_LOGIT
    n_rows = min(D_TILE_LOGIT, D_VOCAB - row_start)
    raw = ddr[off: off + n_rows * D_MODEL]
    return np.frombuffer(raw, dtype=np.int8).reshape(n_rows, D_MODEL)


def get_kv_tile(kv_bytes: bytes, kv_base_off: int,
                layer: int, head: int, ctx_block: int,
                n_rows: int, n_cols: int) -> np.ndarray:
    """Extract K or V tile: [n_rows × n_cols] int8."""
    off = kv_base_off + layer * KV_LAYER_STRIDE + head * KV_HEAD_STRIDE + ctx_block * KV_CTX_STRIDE
    raw = kv_bytes[off: off + n_rows * n_cols]
    return np.frombuffer(raw, dtype=np.int8).reshape(n_rows, n_cols)


# ---------------------------------------------------------------------------
# Int8 × int8 → int32 matmul (pure integer, no float)
# ---------------------------------------------------------------------------

def matmul_int8_to_int32(weight: np.ndarray, act: np.ndarray) -> np.ndarray:
    """
    weight: [n_out × n_in]  int8
    act:    [n_in]           int8
    returns [n_out]          int32
    """
    return (weight.astype(np.int32) @ act.astype(np.int32))


# ---------------------------------------------------------------------------
# Read result records from binary file
# ---------------------------------------------------------------------------

def read_results(path: str):
    records = []
    data = load_bytes(path)
    idx = 0
    while idx < len(data):
        if idx + 6 > len(data):
            break
        op    = data[idx];     idx += 1
        layer = data[idx];     idx += 1
        head  = data[idx];     idx += 1
        tile  = struct.unpack_from("<H", data, idx)[0]; idx += 2
        n     = data[idx];     idx += 1
        if idx + n * 4 > len(data):
            print(f"WARNING: truncated record at offset {idx}", file=sys.stderr)
            break
        vals = list(struct.unpack_from(f"<{n}i", data, idx)); idx += n * 4
        records.append({"op": op, "layer": layer, "head": head,
                         "tile": tile, "n": n, "out": vals})
    return records


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description="Verify matmul_mode_tb results against Python reference")
    ap.add_argument("--results",   default=default_path("matmul_results.bin"),
                    help="Path to matmul_results.bin from testbench")
    ap.add_argument("--ddr",       default=None,
                    help="Path to prebuilt DDR image (.bin). Defaults to auto-detected ddr_image.bin")
    ap.add_argument("--stream-in", default=None,
                    help="Path to stream_in.bin. Defaults to ../model/stream_in.bin")
    ap.add_argument("--verbose",   action="store_true",
                    help="Print each PASS result, not just failures")
    args = ap.parse_args()

    # --- Load DDR image -------------------------------------------------------
    if args.ddr:
        ddr_path = args.ddr
    else:
        # Try auto-detect: look for ddr_image.bin next to this script
        candidate = default_path("ddr_image.bin")
        if not os.path.exists(candidate):
            candidate = default_model_path("ddr_image.bin")
        ddr_path = candidate

    if not os.path.exists(ddr_path):
        print(f"ERROR: DDR image not found at {ddr_path}", file=sys.stderr)
        print("  Tip: set --ddr to the prebuilt DDR image path", file=sys.stderr)
        sys.exit(1)

    print(f"Loading DDR image: {ddr_path}")
    ddr_bytes = load_bytes(ddr_path)
    print(f"  {len(ddr_bytes):,} bytes")

    # --- Load stream_in -------------------------------------------------------
    if args.stream_in:
        si_path = args.stream_in
    else:
        si_path = default_model_path("stream_in.bin")
        if not os.path.exists(si_path):
            si_path = default_path(os.path.join("test_data", "stream_in.bin"))

    if not os.path.exists(si_path):
        print(f"ERROR: stream_in.bin not found at {si_path}", file=sys.stderr)
        sys.exit(1)

    print(f"Loading stream_in: {si_path}")
    stream_in_raw = load_bytes(si_path)
    stream_in = np.frombuffer(stream_in_raw[:STREAM_IN_BUF_BYTES], dtype=np.uint8).copy()
    # Pad to STREAM_IN_BUF_BYTES if shorter
    if len(stream_in) < STREAM_IN_BUF_BYTES:
        tmp = np.zeros(STREAM_IN_BUF_BYTES, dtype=np.uint8)
        tmp[:len(stream_in)] = stream_in
        stream_in = tmp
    stream_in_i8 = stream_in.view(np.int8)
    print(f"  {len(stream_in)} bytes (first 4 as int8: {stream_in_i8[:4].tolist()})")

    # --- Reconstruct KV cache fill (must match C++ fill_axi_mem_bytes) -------
    # Pattern: repeat stream_in[0:D_HEADS] throughout KV_CACHE_TOTAL_BYTES * 2
    kv_pattern = stream_in_i8[:D_HEADS]
    kv_total = KV_CACHE_TOTAL_BYTES * 2  # K + V caches
    kv_buf = np.tile(kv_pattern, (kv_total // D_HEADS) + 1)[:kv_total].copy()
    # kv_buf[0..KV_CACHE_TOTAL_BYTES-1] = K cache (int8)
    # kv_buf[KV_CACHE_TOTAL_BYTES..]    = V cache (int8)
    k_cache_bytes = bytes(kv_buf[:KV_CACHE_TOTAL_BYTES].view(np.uint8))
    v_cache_bytes = bytes(kv_buf[KV_CACHE_TOTAL_BYTES:].view(np.uint8))

    # --- Read results ---------------------------------------------------------
    print(f"\nLoading results: {args.results}")
    records = read_results(args.results)
    print(f"  {len(records)} records\n")

    if not records:
        print("No records found — nothing to verify.")
        sys.exit(0)

    # --- Verify ---------------------------------------------------------------
    total   = 0
    passed  = 0
    failed  = 0

    for rec in records:
        op    = rec["op"]
        layer = rec["layer"]
        head  = rec["head"]
        tile  = rec["tile"]
        hw_out = np.array(rec["out"], dtype=np.int32)
        n_out = valid_n_out(op)

        # Build activation (same logic as C++ testbench)
        alen = act_len_for_op(op)
        act = stream_in_i8[:alen].copy()  # may be shorter than D_MODEL etc.
        if len(act) < alen:
            tmp = np.zeros(alen, dtype=np.int8)
            tmp[:len(act)] = act
            act = tmp

        # Get weight tile and compute expected
        try:
            if op in (CMP_Q, CMP_K, CMP_V):
                W = get_wqkv_tile(ddr_bytes, op, layer, head, tile)
                act_vec = stream_in_i8[:D_MODEL].copy()
                expected = matmul_int8_to_int32(W, act_vec)

            elif op == CMP_ATT_SCORES:
                # Q activation: first D_HEADS bytes of stream_in
                q_vec = stream_in_i8[:D_HEADS].copy()
                # K cache tile: [ATT_CTX_BLOCK × D_HEADS] int8 from k_cache_bytes
                K = get_kv_tile(k_cache_bytes, K_CACHE_OFF,
                                layer, head, tile,
                                ATT_CTX_BLOCK, D_HEADS)
                # ATT_SCORES: K[i] · q for each row i → score[i]
                expected = matmul_int8_to_int32(K, q_vec)
                n_out = ATT_CTX_BLOCK

            elif op == CMP_ATT_VALUE:
                # No context chunking: tile is d_tile_idx (0..NUM_ATT_VALUE_HEAD_TILES-1)
                d_tile = tile
                # Softmax weights: int16[CONTEXT_LENGTH] derived from stream_in_i8
                # (mirrors the C++ TB packing: int16_t(int8_t(stream_in[t]))).
                w_i16 = stream_in_i8[:CONTEXT_LENGTH].astype(np.int16)
                # V cache full context: [CONTEXT_LENGTH × D_HEADS] — extract d_tile columns
                V_full = get_kv_tile(v_cache_bytes, 0,
                                     layer, head, 0,
                                     CONTEXT_LENGTH, D_HEADS)
                col0 = d_tile * D_HEAD_TILE_ATT_VALUE
                V_tile = V_full[:, col0: col0 + D_HEAD_TILE_ATT_VALUE]  # [CONTEXT_LENGTH × D_HEAD_TILE_ATT_VALUE]
                # Output[j] = sum_t(w[t] * V[t, j])
                expected = (V_tile.astype(np.int32).T @ w_i16.astype(np.int32)).astype(np.int32)
                n_out = D_HEAD_TILE_ATT_VALUE

            elif op == CMP_OUT_PROJ:
                W = get_wo_tile(ddr_bytes, layer, tile)
                act_vec = stream_in_i8[:D_MODEL].copy()
                expected = matmul_int8_to_int32(W, act_vec)

            elif op == CMP_FFN_W1:
                W = get_w1_tile(ddr_bytes, layer, tile)
                act_vec = stream_in_i8[:D_MODEL].copy()
                expected = matmul_int8_to_int32(W, act_vec)

            elif op == CMP_FFN_W2:
                W = get_w2_tile(ddr_bytes, layer, tile)
                act_vec = stream_in_i8[:D_FFN].copy()
                expected = matmul_int8_to_int32(W, act_vec)

            elif op == CMP_LOGITS:
                W = get_wlogit_tile(ddr_bytes, tile)
                act_vec = stream_in_i8[:D_MODEL].copy()
                expected = matmul_int8_to_int32(W, act_vec)
                n_out = len(expected)  # last tile may be shorter

            else:
                print(f"  SKIP: unknown op={op}")
                continue

        except Exception as e:
            print(f"  ERROR computing expected for {op_name(op)} L={layer} H={head} T={tile}: {e}")
            failed += 1
            total += 1
            continue

        # Compare
        total += 1
        hw_out_cmp = hw_out[:n_out]
        exp_cmp    = expected[:n_out]

        if np.array_equal(hw_out_cmp, exp_cmp):
            passed += 1
            if args.verbose:
                print(f"  PASS  {op_name(op):10s} L={layer:2d} H={head:2d} T={tile:4d}  "
                      f"out[0]={hw_out_cmp[0]}")
        else:
            failed += 1
            diff = hw_out_cmp - exp_cmp
            first_bad = int(np.argmax(diff != 0))
            print(f"  FAIL  {op_name(op):10s} L={layer:2d} H={head:2d} T={tile:4d}  "
                  f"first mismatch @ [{first_bad}]: hw={hw_out_cmp[first_bad]} expected={exp_cmp[first_bad]}")
            if args.verbose:
                print(f"    hw:  {hw_out_cmp[:8].tolist()}")
                print(f"    exp: {exp_cmp[:8].tolist()}")

    # --- Summary --------------------------------------------------------------
    print(f"\n=== Verification Summary ===")
    print(f"  Total:  {total}")
    print(f"  Passed: {passed}  ({100*passed//total if total else 0}%)")
    print(f"  Failed: {failed}")
    sys.exit(0 if failed == 0 else 1)


if __name__ == "__main__":
    main()
