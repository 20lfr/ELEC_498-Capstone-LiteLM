#!/usr/bin/env python3
import argparse
import os
import re
import struct
from pathlib import Path


CTRL_MEM_WORDS = 25
NUM_STREAM_TOKENS = 4

# This script lives under <HLS_ROOT>/test_data, so infer HLS root locally
# instead of assuming a fixed repo layout.
HLS_ROOT = Path(__file__).resolve().parents[1]
SHARED_PARAMS_PATH = HLS_ROOT / "shared_params.hpp"
OUT_DIR = Path(__file__).resolve().parent


def sanitize_expr(expr: str) -> str:
    expr = expr.split("//", 1)[0].strip()
    expr = expr.replace("sizeof(int32_t)", "4")
    expr = expr.replace("sizeof(uint32_t)", "4")
    expr = re.sub(r"static_cast<[^>]+>\(", "(", expr)
    expr = re.sub(r"\b(0x[0-9A-Fa-f]+|\d+)([uUlL]+)\b", r"\1", expr)
    expr = expr.replace("/", "//")
    return expr


def is_full_model_test_defined() -> bool:
    """Return True if FULL_MODEL_TEST is an active (uncommented) #define in shared_params.hpp."""
    define_re = re.compile(r"^\s*#\s*define\s+FULL_MODEL_TEST\b")
    with SHARED_PARAMS_PATH.open("r", encoding="utf-8") as f:
        for line in f:
            if define_re.match(line):
                return True
    return False


def parse_shared_params() -> dict[str, int]:
    full_model = is_full_model_test_defined()
    values: dict[str, int] = {}
    env = {
        "align64_u32": lambda v: (v + 63) & ~63,
        "align64_u64": lambda v: (v + 63) & ~63,
        "max2_constexpr": max,
        "min2_constexpr": min,
        "div_ceil_constexpr": lambda a, b: (a + b - 1) // b,
    }
    constexpr_re = re.compile(
        r"^\s*constexpr\s+[^=;]+\s+([A-Za-z_]\w*)\s*=\s*(.+?);(?:\s*//.*)?$"
    )
    ifdef_re = re.compile(r"^\s*#\s*ifdef\s+FULL_MODEL_TEST\b")
    else_re  = re.compile(r"^\s*#\s*else\b")
    endif_re = re.compile(r"^\s*#\s*endif\b")

    # None = outside any FULL_MODEL_TEST block; True = inside #ifdef branch; False = inside #else branch
    in_block: bool | None = None

    with SHARED_PARAMS_PATH.open("r", encoding="utf-8") as f:
        for line in f:
            if ifdef_re.match(line):
                in_block = True
                continue
            if else_re.match(line) and in_block is not None:
                in_block = False
                continue
            if endif_re.match(line) and in_block is not None:
                in_block = None
                continue

            # Skip lines from the inactive branch of #ifdef FULL_MODEL_TEST
            if in_block is True and not full_model:
                continue
            if in_block is False and full_model:
                continue

            match = constexpr_re.match(line)
            if not match:
                continue
            name, expr = match.groups()
            expr = sanitize_expr(expr)
            try:
                values[name] = int(eval(expr, {"__builtins__": {}}, env | values))
            except Exception:
                continue
    return values


def packed_i8_bytes(elems: int) -> int:
    return elems


def clamp_i8(value: int) -> int:
    return max(-128, min(127, value))


def build_i8_row(elem_count: int, seed: int, base_mag: int) -> bytes:
    out = bytearray()
    for elem_idx in range(elem_count):
        phase = seed + (elem_idx * 7) + ((elem_idx * elem_idx) % 11)
        raw = (phase % (2 * base_mag + 1)) - base_mag
        if raw == 0:
            raw = 3 if ((seed + elem_idx) & 1) else -3
        out.append(clamp_i8(raw) & 0xFF)
    return bytes(out)


def build_i32_block(count: int, seed: int, base_mag: int) -> bytes:
    out = bytearray()
    for idx in range(count):
        phase = seed + (idx * 5) + ((idx * idx) % 13)
        value = (phase % (2 * base_mag + 1)) - base_mag
        if value == 0:
            value = 5 if ((seed + idx) & 1) else -5
        out.extend(struct.pack("<i", value))
    return bytes(out)


def build_gamma_block(count: int, seed: int, unity_q: int, taper_q: int) -> bytes:
    out = bytearray()
    for idx in range(count):
        ripple = (idx % 8) - 3
        gamma = max(0x00000100, unity_q - taper_q + (ripple * 0x10) + seed)
        out.extend(struct.pack("<I", gamma & 0xFFFFFFFF))
    return bytes(out)

def build_beta_block(count: int) -> bytes:
    return b"\x00\x00\x00\x00" * count


def build_vocab_i8_row(elem_count: int, vocab_row: int) -> bytes:
    out = bytearray()
    for model_col in range(elem_count):
        seed = (
            (vocab_row * 97)
            + (model_col * 53)
            + ((vocab_row ^ (model_col * 7)) * 11)
            + (vocab_row * model_col * 3)
            + 19
        )
        mixed = seed ^ (seed >> 2) ^ (seed >> 5)
        raw = (mixed & 0xFF) - 128
        if raw == 0:
            raw = 3 if ((vocab_row + model_col) & 1) else -3
        out.append(clamp_i8(raw) & 0xFF)
    return bytes(out)


def initialize_sparse_file(path: Path, size: int) -> None:
    with path.open("wb") as f:
        if size > 0:
            f.seek(size - 1)
            f.write(b"\x00")


def write_bytes_checked(f, file_size: int, addr: int, data: bytes, label: str) -> None:
    end = addr + len(data)
    if addr < 0 or end > file_size:
        raise ValueError(
            f"{label} write outside sparse DDR image: addr=0x{addr:X} len={len(data)} "
            f"size=0x{file_size:X}"
        )
    f.seek(addr)
    f.write(data)


def overlay_word_map(word_map: dict[int, int], addr: int, data: bytes) -> None:
    for byte_off, byte_value in enumerate(data):
        abs_addr = addr + byte_off
        word_idx = abs_addr >> 2
        byte_lane = abs_addr & 0x3
        cur = word_map.get(word_idx, 0)
        cur &= ~(0xFF << (byte_lane * 8))
        cur |= (byte_value & 0xFF) << (byte_lane * 8)
        word_map[word_idx] = cur & 0xFFFFFFFF


def write_hex_map(path: Path, word_map: dict[int, int]) -> None:
    with path.open("w", encoding="ascii") as f:
        for word_idx in sorted(word_map):
            f.write(f"{(word_idx * 4):08X} {word_map[word_idx] & 0xFFFFFFFF:08X}\n")


def build_ctrl_words(c: dict[str, int]) -> list[int]:
    words = [0] * CTRL_MEM_WORDS
    words[0] = c["CTRL_RESETN_BIT"]
    words[1] = c["IRQ_ERROR_BIT"] | c["IRQ_INFER_DONE_BIT"]
    words[2] = 0
    words[3] = c["WQ_OFF"]
    words[4] = c["WK_OFF"]
    words[5] = c["WV_OFF"]
    words[6] = c["WO_OFF"]
    words[7] = c["W1_OFF"]
    words[8] = c["W2_OFF"]
    words[9] = c["K_CACHE_OFF"]
    words[10] = c["V_CACHE_OFF"]
    words[11] = c["WQ_BIAS_OFF"]
    words[12] = c["WK_BIAS_OFF"]
    words[13] = c["WV_BIAS_OFF"]
    words[14] = c["WO_BIAS_OFF"]
    words[15] = c["W1_BIAS_OFF"]
    words[16] = c["W2_BIAS_OFF"]
    words[17] = c["LN0_GAMMA_OFF"]
    words[18] = c["LN1_GAMMA_OFF"]
    words[19] = c["FINAL_NORM_GAMMA_OFF"]
    words[20] = c["LN0_EPS_OFF"]
    words[21] = c["LN1_EPS_OFF"]
    words[22] = c["FINAL_NORM_EPS_OFF"]
    words[23] = c["WLOGIT_OFF"]
    words[24] = 0
    return words


def build_stream_bytes(stream_in_buf_bytes: int) -> bytes:
    token_patterns = [
        (-3, -2, -1, 0, 1, 2, 3, 1),
        (2, 1, 0, -1, -2, -3, 0, 3),
        (-4, -1, 2, 4, 1, -2, -3, 0),
        (1, 3, 2, 0, -1, -3, -2, 4),
    ]

    stream_bytes = bytearray()
    for token_idx in range(NUM_STREAM_TOKENS):
        pattern = token_patterns[token_idx % len(token_patterns)]
        token = bytes(
            (pattern[i % len(pattern)] & 0xFF) for i in range(stream_in_buf_bytes)
        )
        stream_bytes.extend(token)
    return bytes(stream_bytes)


def build_generated_mem_map_svh(c: dict[str, int]) -> str:
    img_span_w1 = c["MEM_W1_GATE"]
    return f"""// Auto-generated by gen_ddr_image.py. Do not hand-edit.
  localparam int DDR_IMAGE_BYTES       = 'h{c["WEIGHTS_SIZE"]:08X};
  localparam int IMG_SPAN_WQ           = 'h{c["MEM_WQ"]:08X};
  localparam int IMG_SPAN_WK           = 'h{c["MEM_WK"]:08X};
  localparam int IMG_SPAN_WV           = 'h{c["MEM_WV"]:08X};
  localparam int IMG_SPAN_WO           = 'h{c["MEM_WO"]:08X};
  localparam int IMG_SPAN_W1           = 'h{img_span_w1:08X};
  localparam int IMG_SPAN_W2           = 'h{c["MEM_W2"]:08X};
	  localparam int IMG_SPAN_K_CACHE      = 'h{c["MEM_K_CACHE"]:08X};
	  localparam int IMG_SPAN_V_CACHE      = 'h{c["MEM_V_CACHE"]:08X};
	  localparam int IMG_SPAN_WQ_BIAS      = 'h{c.get("MEM_WQ_BIAS", 0):08X};
	  localparam int IMG_SPAN_WK_BIAS      = 'h{c.get("MEM_WK_BIAS", 0):08X};
	  localparam int IMG_SPAN_WV_BIAS      = 'h{c.get("MEM_WV_BIAS", 0):08X};
  localparam int IMG_SPAN_WO_BIAS      = 'h{c["MEM_WO_BIAS"]:08X};
  localparam int IMG_SPAN_W1_BIAS      = 'h{c["MEM_W1_BIAS"]:08X};
  localparam int IMG_SPAN_W2_BIAS      = 'h{c["MEM_W2_BIAS"]:08X};
  localparam int IMG_SPAN_WVOCAB       = 'h{c["MEM_WLOGIT"]:08X};
  localparam int IMG_SPAN_WVOCAB_BIAS  = 'h00000000;
  localparam int IMG_SPAN_LN_GAMMA     = 'h{c["MEM_LN0_GAMMA"]:08X};
  localparam int IMG_SPAN_WO_BIAS_ALT  = 'h{c["MEM_WO_BIAS"]:08X};
  localparam int IMG_SPAN_W1_BIAS_ALT  = 'h{c["MEM_W1_BIAS"]:08X};
  localparam int IMG_SPAN_W2_BIAS_ALT  = 'h{c["MEM_W2_BIAS"]:08X};
  localparam int IMG_SPAN_LN0_GAMMA    = 'h{c["MEM_LN0_GAMMA"]:08X};
  localparam int IMG_SPAN_LN0_BETA     = 'h{c["MEM_LN0_BETA"]:08X};
  localparam int IMG_SPAN_LN1_GAMMA    = 'h{c["MEM_LN1_GAMMA"]:08X};
  localparam int IMG_SPAN_LN1_BETA     = 'h{c["MEM_LN1_BETA"]:08X};
  localparam int IMG_SPAN_FINAL_NORM_GAMMA = 'h{c["MEM_FINAL_NORM_GAMMA"]:08X};
  localparam int IMG_SPAN_FINAL_NORM_BETA  = 'h{c["MEM_FINAL_NORM_BETA"]:08X};
  localparam int IMG_SPAN_LN_EPS       = 'h{c["MEM_LN0_EPS"]:08X};
  localparam int IMG_SPAN_LN0_EPS      = 'h{c["MEM_LN0_EPS"]:08X};
  localparam int IMG_SPAN_LN1_EPS      = 'h{c["MEM_LN1_EPS"]:08X};
  localparam int IMG_SPAN_FINAL_NORM_EPS   = 'h{c["MEM_FINAL_NORM_EPS"]:08X};

  localparam int IMG_BASE_WQ               = 'h{c["WQ_OFF"]:08X};
  localparam int IMG_BASE_WK               = 'h{c["WK_OFF"]:08X};
  localparam int IMG_BASE_WV               = 'h{c["WV_OFF"]:08X};
	  localparam int IMG_BASE_WO               = 'h{c["WO_OFF"]:08X};
	  localparam int IMG_BASE_W1               = 'h{c["W1_OFF"]:08X};
	  localparam int IMG_BASE_W2               = 'h{c["W2_OFF"]:08X};
	  localparam int IMG_BASE_K_CACHE          = 'h{c["K_CACHE_OFF"]:08X};
	  localparam int IMG_BASE_V_CACHE          = 'h{c["V_CACHE_OFF"]:08X};
	  localparam int IMG_BASE_WQ_BIAS          = 'h{c.get("WQ_BIAS_OFF", 0):08X};
	  localparam int IMG_BASE_WK_BIAS          = 'h{c.get("WK_BIAS_OFF", 0):08X};
	  localparam int IMG_BASE_WV_BIAS          = 'h{c.get("WV_BIAS_OFF", 0):08X};
  localparam int IMG_BASE_WO_BIAS          = 'h{c["WO_BIAS_OFF"]:08X};
  localparam int IMG_BASE_W1_BIAS          = 'h{c["W1_BIAS_OFF"]:08X};
  localparam int IMG_BASE_W2_BIAS          = 'h{c["W2_BIAS_OFF"]:08X};
  localparam int IMG_BASE_WVOCAB           = 'h{c["WLOGIT_OFF"]:08X};
  localparam int IMG_BASE_WVOCAB_BIAS      = 'h00000000;
  localparam int IMG_BASE_LN0_GAMMA        = 'h{c["LN0_GAMMA_OFF"]:08X};
  localparam int IMG_BASE_LN0_BETA         = 'h{c["LN0_BETA_OFF"]:08X};
  localparam int IMG_BASE_LN1_GAMMA        = 'h{c["LN1_GAMMA_OFF"]:08X};
  localparam int IMG_BASE_LN1_BETA         = 'h{c["LN1_BETA_OFF"]:08X};
  localparam int IMG_BASE_FINAL_NORM_GAMMA = 'h{c["FINAL_NORM_GAMMA_OFF"]:08X};
  localparam int IMG_BASE_FINAL_NORM_BETA  = 'h{c["FINAL_NORM_BETA_OFF"]:08X};
  localparam int IMG_BASE_LN0_EPS          = 'h{c["LN0_EPS_OFF"]:08X};
  localparam int IMG_BASE_LN1_EPS          = 'h{c["LN1_EPS_OFF"]:08X};
  localparam int IMG_BASE_FINAL_NORM_EPS   = 'h{c["FINAL_NORM_EPS_OFF"]:08X};
"""


def build_generated_params_svh(c: dict[str, int]) -> str:
    def req(name: str) -> int:
        if name not in c:
            raise KeyError(f"Missing required shared_params.hpp constant: {name}")
        return int(c[name])

    def get(name: str, default: int) -> int:
        return int(c.get(name, default))

    num_layers = req("NUM_LAYERS")
    d_model = req("D_MODEL")
    d_ffn = req("D_FFN")
    d_vocab = req("D_VOCAB")
    context_length = req("CONTEXT_LENGTH")
    d_heads = req("D_HEADS")
    num_heads = get("NUM_HEADS", d_model // d_heads)

    heads_parallel = req("HEADS_PARALLEL")
    num_wo_tiles = req("NUM_WO_TILES")
    num_w1_tiles = req("NUM_W1_TILES")
    num_w2_tiles = req("NUM_W2_TILES")
    num_logit_tiles = req("NUM_LOGIT_TILES")
    num_qkv_head_tiles = req("NUM_QKV_HEAD_TILES")
    num_att_value_head_tiles = req("NUM_ATT_VALUE_HEAD_TILES")
    att_ctx_block = req("ATT_CTX_BLOCK")

    d_head_tile_qkv = get("D_HEAD_TILE_QKV", d_heads // num_qkv_head_tiles)
    d_tile_wo = get("D_TILE_WO", d_model // num_wo_tiles)
    d_tile_w1 = get("D_TILE_W1", d_ffn // num_w1_tiles)
    d_tile_w2 = get("D_TILE_W2", d_model // num_w2_tiles)
    d_tile_logit = get("D_TILE_LOGIT", d_vocab // num_logit_tiles)
    d_head_tile_att_value = get(
        "D_HEAD_TILE_ATT_VALUE", d_heads // num_att_value_head_tiles
    )
    num_att_ctx_blocks = get("NUM_ATT_CTX_BLOCKS", context_length // att_ctx_block)
    num_head_groups = get(
        "NUM_HEAD_GROUPS", (num_heads + heads_parallel - 1) // heads_parallel
    )

    stream_in_buf_bytes = get("STREAM_IN_BUF_BYTES", d_model)
    stream_out_buf_bytes = get("STREAM_OUT_BUF_BYTES", 4)
    axi_gmem_word_bytes = get("AXI_GMEM_WORD_BYTES", 4)

    return f"""// Auto-generated by gen_ddr_image.py. Do not hand-edit.
  // Model/architecture constants (compact HLS config)
  localparam int NUM_LAYERS = {num_layers};
  localparam int D_MODEL = {d_model};
  localparam int D_FFN = {d_ffn};
  localparam int D_VOCAB = {d_vocab};
  localparam int CONTEXT_LENGTH = {context_length};
  localparam int D_HEADS = {d_heads};
  localparam int NUM_HEADS = {num_heads};

  // Tiling/parallelism
  localparam int HEADS_PARALLEL = {heads_parallel};
  localparam int NUM_WO_TILES = {num_wo_tiles};
  localparam int NUM_W1_TILES = {num_w1_tiles};
  localparam int NUM_W2_TILES = {num_w2_tiles};
  localparam int NUM_LOGIT_TILES = {num_logit_tiles};
  localparam int NUM_QKV_HEAD_TILES = {num_qkv_head_tiles};
  localparam int NUM_ATT_VALUE_HEAD_TILES = {num_att_value_head_tiles};
  localparam int ATT_CTX_BLOCK = {att_ctx_block};

  // Derived
  localparam int D_HEAD_TILE_QKV = {d_head_tile_qkv};
  localparam int D_TILE_WO = {d_tile_wo};
  localparam int D_TILE_W1 = {d_tile_w1};
  localparam int D_TILE_W2 = {d_tile_w2};
  localparam int D_TILE_LOGIT = {d_tile_logit};
  localparam int D_HEAD_TILE_ATT_VALUE = {d_head_tile_att_value};
  localparam int NUM_ATT_CTX_BLOCKS = {num_att_ctx_blocks};
  localparam int NUM_HEAD_GROUPS = {num_head_groups};

  // Stream sizing
  localparam int STREAM_IN_BUF_BYTES = {stream_in_buf_bytes};
  localparam int STREAM_OUT_BUF_BYTES = {stream_out_buf_bytes};

  // AXI sizing
  localparam int AXI_GMEM_WORD_BYTES = {axi_gmem_word_bytes};

  // Control memory layout (25x32b = 800b wire ctrl_mem)
  localparam int CTRL_MEM_WORDS = {CTRL_MEM_WORDS};
"""


def emit_synthetic_image(c: dict[str, int], out_path: Path) -> dict[int, int]:
    initialize_sparse_file(out_path, c["WEIGHTS_SIZE"])
    compact_hidden_bytes = packed_i8_bytes(c["D_MODEL"])
    compact_ffn_bytes = packed_i8_bytes(c["D_FFN"])
    qkv_row_stride = c["D_MODEL"]
    w2_row_stride = c["D_FFN"]
    word_map: dict[int, int] = {}

    with out_path.open("r+b") as f:
        def write_region(addr: int, data: bytes, label: str) -> None:
            write_bytes_checked(f, c["WEIGHTS_SIZE"], addr, data, label)
            overlay_word_map(word_map, addr, data)

        for layer in range(c["NUM_LAYERS"]):
            for head in range(c["NUM_HEADS"]):
                head_row_base = head * c["D_HEADS"]
                for row in range(c["D_HEADS"]):
                    row_seed = (layer * 101) + (head * 17) + row
                    row_addr = (
                        c["WQ_OFF"]
                        + layer * c["STRIDE_WQ_LAYER"]
                        + (head_row_base + row) * qkv_row_stride
                    )
                    write_region(row_addr, build_i8_row(c["D_MODEL"], 11 + row_seed, 3), "WQ")
                    row_addr = (
                        c["WK_OFF"]
                        + layer * c["STRIDE_WK_LAYER"]
                        + (head_row_base + row) * qkv_row_stride
                    )
                    write_region(row_addr, build_i8_row(c["D_MODEL"], 23 + row_seed, 3), "WK")
                    row_addr = (
                        c["WV_OFF"]
                        + layer * c["STRIDE_WV_LAYER"]
                        + (head_row_base + row) * qkv_row_stride
                    )
                    write_region(row_addr, build_i8_row(c["D_MODEL"], 37 + row_seed, 4), "WV")

            for tile in range(c["NUM_WO_TILES"]):
                for row in range(c["D_TILE_WO"]):
                    abs_row = tile * c["D_TILE_WO"] + row
                    row_addr = (
                        c["WO_OFF"]
                        + layer * c["STRIDE_WO_LAYER"]
                        + abs_row * qkv_row_stride
                    )
                    write_region(
                        row_addr,
                        build_i8_row(c["D_MODEL"], 51 + (layer * 53) + (tile * 11) + row, 3),
                        "WO",
                    )

            for tile in range(c["NUM_W1_TILES"]):
                for row in range(c["D_TILE_W1"]):
                    abs_row = tile * c["D_TILE_W1"] + row
                    gate_addr = (
                        c["W1_OFF"]
                        + layer * c["STRIDE_W1_GATE_LAYER"]
                        + abs_row * qkv_row_stride
                    )
                    write_region(
                        gate_addr,
                        build_i8_row(c["D_MODEL"], 67 + (layer * 59) + (tile * 13) + row, 2),
                        "W1_GATE",
                    )

            for tile in range(c["NUM_W2_TILES"]):
                for row in range(c["D_TILE_W2"]):
                    abs_row = tile * c["D_TILE_W2"] + row
                    row_addr = (
                        c["W2_OFF"]
                        + layer * c["STRIDE_W2_LAYER"]
                        + abs_row * w2_row_stride
                    )
                    write_region(
                        row_addr,
                        build_i8_row(c["D_FFN"], 97 + (layer * 67) + (tile * 19) + row, 2)[:compact_ffn_bytes],
                        "W2",
                    )

            wq_bias_addr = c["WQ_BIAS_OFF"] + layer * (c["D_MODEL"] * 4)
            write_region(wq_bias_addr, build_i32_block(c["D_MODEL"], 41 + layer * 3, 9), "WQ_BIAS")

            wk_bias_addr = c["WK_BIAS_OFF"] + layer * (c["D_MODEL"] * 4)
            write_region(wk_bias_addr, build_i32_block(c["D_MODEL"], 61 + layer * 5, 7), "WK_BIAS")

            wv_bias_addr = c["WV_BIAS_OFF"] + layer * (c["D_MODEL"] * 4)
            write_region(wv_bias_addr, build_i32_block(c["D_MODEL"], 81 + layer * 7, 5), "WV_BIAS")

            wo_bias_addr = c["WO_BIAS_OFF"] + layer * c["STRIDE_WO_BIAS_LAYER"]
            write_region(wo_bias_addr, build_i32_block(c["D_MODEL"], 101 + layer * 7, 8), "WO_BIAS")

            w1_bias_addr = c["W1_BIAS_OFF"] + layer * c["STRIDE_W1_BIAS_LAYER"]
            write_region(
                w1_bias_addr,
                build_i32_block(c["D_FFN"], 131 + layer * 11, 6),
                "W1_BIAS",
            )

            w2_bias_addr = c["W2_BIAS_OFF"] + layer * c["STRIDE_W2_BIAS_LAYER"]
            write_region(w2_bias_addr, build_i32_block(c["D_MODEL"], 151 + layer * 13, 6), "W2_BIAS")

            ln0_gamma_addr = c["LN0_GAMMA_OFF"] + layer * c["STRIDE_LN0_GAMMA"]
            write_region(
                ln0_gamma_addr,
                build_gamma_block(c["D_MODEL"], layer * 0x20, 0x00000800, 0x00000100),
                "LN0_GAMMA",
            )

            ln0_beta_addr = c["LN0_BETA_OFF"] + layer * c["STRIDE_LN0_GAMMA"]
            write_region(ln0_beta_addr, build_beta_block(c["D_MODEL"]), "LN0_BETA")

            ln1_gamma_addr = c["LN1_GAMMA_OFF"] + layer * c["STRIDE_LN1_GAMMA"]
            write_region(
                ln1_gamma_addr,
                build_gamma_block(c["D_MODEL"], layer * 0x18, 0x00000780, 0x00000100),
                "LN1_GAMMA",
            )

            ln1_beta_addr = c["LN1_BETA_OFF"] + layer * c["STRIDE_LN1_GAMMA"]
            write_region(ln1_beta_addr, build_beta_block(c["D_MODEL"]), "LN1_BETA")

            ln0_eps_addr = c["LN0_EPS_OFF"] + layer * c["STRIDE_LN0_EPS"]
            write_region(ln0_eps_addr, struct.pack("<I", 0x00000004), "LN0_EPS")
            ln1_eps_addr = c["LN1_EPS_OFF"] + layer * c["STRIDE_LN1_EPS"]
            write_region(ln1_eps_addr, struct.pack("<I", 0x00000004), "LN1_EPS")

        write_region(
            c["FINAL_NORM_GAMMA_OFF"],
            build_gamma_block(c["D_MODEL"], 0x40, 0x00000700, 0x00000080),
            "FINAL_NORM_GAMMA",
        )
        write_region(c["FINAL_NORM_BETA_OFF"], build_beta_block(c["D_MODEL"]), "FINAL_NORM_BETA")
        write_region(c["FINAL_NORM_EPS_OFF"], struct.pack("<I", 0x00000004), "FINAL_NORM_EPS")

        for tile in range(c["NUM_LOGIT_TILES"]):
            for row in range(c["D_TILE_LOGIT"]):
                vocab_row = tile * c["D_TILE_LOGIT"] + row
                if vocab_row >= c["D_VOCAB"]:
                    continue
                row_addr = c["WLOGIT_OFF"] + vocab_row * qkv_row_stride
                write_region(
                    row_addr,
                    build_vocab_i8_row(c["D_MODEL"], vocab_row)[:compact_hidden_bytes],
                    "WLOGIT",
                )

        if "POS_EMBED_OFF" in c and "MEM_POS_EMBED" in c and c["MEM_POS_EMBED"] > 0:
            pos_bytes = bytearray()
            for i in range(c["MEM_POS_EMBED"]):
                pos_bytes.append(clamp_i8(((i * 13) ^ (i >> 3)) % 17 - 8) & 0xFF)
            write_region(c["POS_EMBED_OFF"], bytes(pos_bytes), "POS_EMBED")

    return word_map


def build_stream_bytes_from_embed(embed_path: Path, token_id: int,
                                   stream_in_buf_bytes: int) -> bytes:
    """Read a single token embedding row from embed_tokens.bin."""
    with embed_path.open("rb") as f:
        f.seek(token_id * stream_in_buf_bytes)
        row = f.read(stream_in_buf_bytes)
    if len(row) != stream_in_buf_bytes:
        raise IOError(
            f"Failed to read embedding row {token_id} from {embed_path} "
            f"(got {len(row)} bytes, expected {stream_in_buf_bytes})"
        )
    return row


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Generate testbench data files from shared_params.hpp."
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=OUT_DIR,
        help="Directory to write generated files (default: test_data/ next to this script).",
    )
    parser.add_argument(
        "--embed-path",
        type=Path,
        default=None,
        help="Path to embed_tokens.bin. When provided, stream_in.bin is built from "
             "token-0's real embedding instead of synthetic data.",
    )
    args = parser.parse_args()

    out = args.output_dir
    out.mkdir(parents=True, exist_ok=True)

    c = parse_shared_params()
    full_model = is_full_model_test_defined()

    ctrl_path = out / "ctrl_mem.bin"
    stream_path = out / "stream_in.bin"
    mem_map_path = out / "generated_mem_map.svh"
    params_path = out / "generated_params.svh"

    # DDR image: only generated for synthetic (test) mode.
    # In full-model mode the real gpt2_weights_int8.bin already exists in model/.
    if not full_model:
        ddr_path = out / "ddr_image.bin"
        ddr_hex_path = out / "ddr_image.hex"
        word_map = emit_synthetic_image(c, ddr_path)
        write_hex_map(ddr_hex_path, word_map)
        print(ddr_path)
        print(ddr_hex_path)

    ctrl_words = build_ctrl_words(c)
    with ctrl_path.open("wb") as f:
        for word in ctrl_words:
            f.write(struct.pack("<I", word & 0xFFFFFFFF))

    if args.embed_path is not None:
        stream_data = build_stream_bytes_from_embed(
            args.embed_path, 0, c["STREAM_IN_BUF_BYTES"]
        )
    else:
        stream_data = build_stream_bytes(c["STREAM_IN_BUF_BYTES"])
    with stream_path.open("wb") as f:
        f.write(stream_data)

    with mem_map_path.open("w", encoding="ascii") as f:
        f.write(build_generated_mem_map_svh(c))

    with params_path.open("w", encoding="ascii") as f:
        f.write(build_generated_params_svh(c))

    print(ctrl_path)
    print(stream_path)
    print(mem_map_path)
    print(params_path)


if __name__ == "__main__":
    main()
