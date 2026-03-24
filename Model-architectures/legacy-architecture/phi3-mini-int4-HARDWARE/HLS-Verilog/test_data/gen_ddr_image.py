#!/usr/bin/env python3
import os
import re
import struct
from pathlib import Path


CTRL_MEM_WORDS = 23
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


def parse_shared_params() -> dict[str, int]:
    values: dict[str, int] = {}
    env = {
        "align64_u32": lambda v: (v + 63) & ~63,
        "align64_u64": lambda v: (v + 63) & ~63,
        "max2_constexpr": max,
        "min2_constexpr": min,
    }
    constexpr_re = re.compile(
        r"^\s*constexpr\s+[^=;]+\s+([A-Za-z_]\w*)\s*=\s*(.+?);(?:\s*//.*)?$"
    )

    with SHARED_PARAMS_PATH.open("r", encoding="utf-8") as f:
        for line in f:
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


def packed_i4_bytes(elems: int) -> int:
    return (elems + 1) // 2


def clamp_i4(value: int) -> int:
    return max(-8, min(7, value))


def pack_i4_word(values: list[int]) -> bytes:
    packed = 0
    for nibble_idx, value in enumerate(values):
        packed |= (clamp_i4(value) & 0xF) << (nibble_idx * 4)
    return struct.pack("<I", packed & 0xFFFFFFFF)


def build_i4_row(elem_count: int, seed: int, base_mag: int) -> bytes:
    out = bytearray()
    for group_base in range(0, elem_count, 8):
        vals: list[int] = []
        for lane in range(8):
            elem_idx = group_base + lane
            phase = seed + (elem_idx * 7) + ((elem_idx * elem_idx) % 11)
            raw = (phase % (2 * base_mag + 1)) - base_mag
            if raw == 0:
                raw = 3 if ((seed + elem_idx) & 1) else -3
            vals.append(raw)
        out.extend(pack_i4_word(vals))
    return bytes(out[:packed_i4_bytes(elem_count)])


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


def build_vocab_i4_row(elem_count: int, vocab_row: int) -> bytes:
    out = bytearray()
    for group_base in range(0, elem_count, 8):
        vals: list[int] = []
        for lane in range(8):
            model_col = group_base + lane
            seed = (
                (vocab_row * 97)
                + (model_col * 53)
                + ((vocab_row ^ (model_col * 7)) * 11)
                + (vocab_row * model_col * 3)
                + 19
            )
            mixed = seed ^ (seed >> 2) ^ (seed >> 5)
            raw = (mixed & 0xF) - 8
            if raw == 0:
                raw = 3 if ((vocab_row + model_col) & 1) else -3
            vals.append(raw)
        out.extend(pack_i4_word(vals))
    return bytes(out[:packed_i4_bytes(elem_count)])


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
    words[8] = c["W1_UP_OFF"]
    words[9] = c["W2_OFF"]
    words[10] = c["K_CACHE_OFF"]
    words[11] = c["V_CACHE_OFF"]
    words[12] = c["WO_BIAS_OFF"]
    words[13] = c["W1_BIAS_OFF"]
    words[14] = c["W2_BIAS_OFF"]
    words[15] = c["LN0_GAMMA_OFF"]
    words[16] = c["LN1_GAMMA_OFF"]
    words[17] = c["FINAL_NORM_GAMMA_OFF"]
    words[18] = c["LN0_EPS_OFF"]
    words[19] = c["LN1_EPS_OFF"]
    words[20] = c["FINAL_NORM_EPS_OFF"]
    words[21] = c["WLOGIT_OFF"]
    words[22] = 0
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
    img_span_w1 = c["MEM_W1_GATE"] + c["MEM_W1_UP"]
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
  localparam int IMG_SPAN_WQ_BIAS      = 'h00000000;
  localparam int IMG_SPAN_WK_BIAS      = 'h00000000;
  localparam int IMG_SPAN_WV_BIAS      = 'h00000000;
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
  localparam int IMG_SPAN_LN1_GAMMA    = 'h{c["MEM_LN1_GAMMA"]:08X};
  localparam int IMG_SPAN_FINAL_NORM_GAMMA = 'h{c["MEM_FINAL_NORM_GAMMA"]:08X};
  localparam int IMG_SPAN_LN_EPS       = 'h{c["MEM_LN0_EPS"]:08X};
  localparam int IMG_SPAN_LN0_EPS      = 'h{c["MEM_LN0_EPS"]:08X};
  localparam int IMG_SPAN_LN1_EPS      = 'h{c["MEM_LN1_EPS"]:08X};
  localparam int IMG_SPAN_FINAL_NORM_EPS   = 'h{c["MEM_FINAL_NORM_EPS"]:08X};

  localparam int IMG_BASE_WQ               = 'h{c["WQ_OFF"]:08X};
  localparam int IMG_BASE_WK               = 'h{c["WK_OFF"]:08X};
  localparam int IMG_BASE_WV               = 'h{c["WV_OFF"]:08X};
  localparam int IMG_BASE_WO               = 'h{c["WO_OFF"]:08X};
  localparam int IMG_BASE_W1               = 'h{c["W1_OFF"]:08X};
  localparam int IMG_BASE_W1_UP            = 'h{c["W1_UP_OFF"]:08X};
  localparam int IMG_BASE_W2               = 'h{c["W2_OFF"]:08X};
  localparam int IMG_BASE_K_CACHE          = 'h{c["K_CACHE_OFF"]:08X};
  localparam int IMG_BASE_V_CACHE          = 'h{c["V_CACHE_OFF"]:08X};
  localparam int IMG_BASE_WQ_BIAS          = 'h00000000;
  localparam int IMG_BASE_WK_BIAS          = 'h00000000;
  localparam int IMG_BASE_WV_BIAS          = 'h00000000;
  localparam int IMG_BASE_WO_BIAS          = 'h{c["WO_BIAS_OFF"]:08X};
  localparam int IMG_BASE_W1_BIAS          = 'h{c["W1_BIAS_OFF"]:08X};
  localparam int IMG_BASE_W2_BIAS          = 'h{c["W2_BIAS_OFF"]:08X};
  localparam int IMG_BASE_WVOCAB           = 'h{c["WLOGIT_OFF"]:08X};
  localparam int IMG_BASE_WVOCAB_BIAS      = 'h00000000;
  localparam int IMG_BASE_LN0_GAMMA        = 'h{c["LN0_GAMMA_OFF"]:08X};
  localparam int IMG_BASE_LN1_GAMMA        = 'h{c["LN1_GAMMA_OFF"]:08X};
  localparam int IMG_BASE_FINAL_NORM_GAMMA = 'h{c["FINAL_NORM_GAMMA_OFF"]:08X};
  localparam int IMG_BASE_LN0_EPS          = 'h{c["LN0_EPS_OFF"]:08X};
  localparam int IMG_BASE_LN1_EPS          = 'h{c["LN1_EPS_OFF"]:08X};
  localparam int IMG_BASE_FINAL_NORM_EPS   = 'h{c["FINAL_NORM_EPS_OFF"]:08X};
"""


def emit_synthetic_image(c: dict[str, int], out_path: Path) -> dict[int, int]:
    initialize_sparse_file(out_path, c["WEIGHTS_SIZE"])
    compact_hidden_bytes = packed_i4_bytes(c["D_MODEL"])
    compact_ffn_bytes = packed_i4_bytes(c["D_FFN"])
    qkv_row_stride = c["MODEL_HIDDEN_SIZE"] // 2
    w2_row_stride = c["MODEL_INTERMEDIATE_SIZE"] // 2
    word_map: dict[int, int] = {}

    with out_path.open("r+b") as f:
        def write_region(addr: int, data: bytes, label: str) -> None:
            write_bytes_checked(f, c["WEIGHTS_SIZE"], addr, data, label)
            overlay_word_map(word_map, addr, data)

        for layer in range(c["NUM_LAYERS"]):
            for head in range(c["NUM_HEADS"]):
                head_row_base = head * c["MODEL_HEAD_DIMENSTION"]
                for row in range(c["D_HEADS"]):
                    row_seed = (layer * 101) + (head * 17) + row
                    row_addr = (
                        c["WQ_OFF"]
                        + layer * c["STRIDE_WQ_LAYER"]
                        + (head_row_base + row) * qkv_row_stride
                    )
                    write_region(row_addr, build_i4_row(c["D_MODEL"], 11 + row_seed, 3), "WQ")
                    row_addr = (
                        c["WK_OFF"]
                        + layer * c["STRIDE_WK_LAYER"]
                        + (head_row_base + row) * qkv_row_stride
                    )
                    write_region(row_addr, build_i4_row(c["D_MODEL"], 23 + row_seed, 3), "WK")
                    row_addr = (
                        c["WV_OFF"]
                        + layer * c["STRIDE_WV_LAYER"]
                        + (head_row_base + row) * qkv_row_stride
                    )
                    write_region(row_addr, build_i4_row(c["D_MODEL"], 37 + row_seed, 4), "WV")

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
                        build_i4_row(c["D_MODEL"], 51 + (layer * 53) + (tile * 11) + row, 3),
                        "WO",
                    )

            for tile in range(c["NUM_W1_TILES"] // 2):
                for row in range(c["D_TILE_W1"]):
                    abs_row = tile * c["D_TILE_W1"] + row
                    gate_addr = (
                        c["W1_OFF"]
                        + layer * c["STRIDE_W1_GATE_LAYER"]
                        + abs_row * qkv_row_stride
                    )
                    write_region(
                        gate_addr,
                        build_i4_row(c["D_MODEL"], 67 + (layer * 59) + (tile * 13) + row, 2),
                        "W1_GATE",
                    )
                    up_addr = (
                        c["W1_UP_OFF"]
                        + layer * c["STRIDE_W1_UP_LAYER"]
                        + abs_row * qkv_row_stride
                    )
                    write_region(
                        up_addr,
                        build_i4_row(c["D_MODEL"], 79 + (layer * 61) + (tile * 17) + row, 2),
                        "W1_UP",
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
                        build_i4_row(c["D_FFN"], 97 + (layer * 67) + (tile * 19) + row, 2)[
                            :compact_ffn_bytes
                        ],
                        "W2",
                    )

            wo_bias_addr = c["WO_BIAS_OFF"] + layer * c["STRIDE_WO_BIAS_LAYER"]
            write_region(wo_bias_addr, build_i32_block(c["D_MODEL"], 101 + layer * 7, 8), "WO_BIAS")

            w1_bias_addr = c["W1_BIAS_OFF"] + layer * c["STRIDE_W1_BIAS_LAYER"]
            write_region(
                w1_bias_addr,
                build_i32_block(c["D_FFN"] * 2, 131 + layer * 11, 6),
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

            ln1_gamma_addr = c["LN1_GAMMA_OFF"] + layer * c["STRIDE_LN1_GAMMA"]
            write_region(
                ln1_gamma_addr,
                build_gamma_block(c["D_MODEL"], layer * 0x18, 0x00000780, 0x00000100),
                "LN1_GAMMA",
            )

            ln0_eps_addr = c["LN0_EPS_OFF"] + layer * c["STRIDE_LN0_EPS"]
            write_region(ln0_eps_addr, struct.pack("<I", 0x00000004), "LN0_EPS")
            ln1_eps_addr = c["LN1_EPS_OFF"] + layer * c["STRIDE_LN1_EPS"]
            write_region(ln1_eps_addr, struct.pack("<I", 0x00000004), "LN1_EPS")

        write_region(
            c["FINAL_NORM_GAMMA_OFF"],
            build_gamma_block(c["D_MODEL"], 0x40, 0x00000700, 0x00000080),
            "FINAL_NORM_GAMMA",
        )
        write_region(c["FINAL_NORM_EPS_OFF"], struct.pack("<I", 0x00000004), "FINAL_NORM_EPS")

        for tile in range(c["NUM_LOGIT_TILES"]):
            for row in range(c["D_TILE_LOGIT"]):
                vocab_row = tile * c["D_TILE_LOGIT"] + row
                row_addr = c["WLOGIT_OFF"] + vocab_row * qkv_row_stride
                write_region(
                    row_addr,
                    build_vocab_i4_row(c["D_MODEL"], vocab_row)[:compact_hidden_bytes],
                    "WLOGIT",
                )

    return word_map


def main() -> None:
    c = parse_shared_params()

    ddr_path = OUT_DIR / "ddr_image.bin"
    ddr_hex_path = OUT_DIR / "ddr_image.hex"
    ctrl_path = OUT_DIR / "ctrl_mem.bin"
    stream_path = OUT_DIR / "stream_in.bin"
    mem_map_path = OUT_DIR / "generated_mem_map.svh"

    word_map = emit_synthetic_image(c, ddr_path)
    write_hex_map(ddr_hex_path, word_map)

    ctrl_words = build_ctrl_words(c)
    with ctrl_path.open("wb") as f:
        for word in ctrl_words:
            f.write(struct.pack("<I", word & 0xFFFFFFFF))

    with stream_path.open("wb") as f:
        f.write(build_stream_bytes(c["STREAM_IN_BUF_BYTES"]))

    with mem_map_path.open("w", encoding="ascii") as f:
        f.write(build_generated_mem_map_svh(c))

    print(ctrl_path)
    print(ddr_path)
    print(ddr_hex_path)
    print(stream_path)
    print(mem_map_path)


if __name__ == "__main__":
    main()
