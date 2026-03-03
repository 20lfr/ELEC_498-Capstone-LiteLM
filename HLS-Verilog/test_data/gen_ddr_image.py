#!/usr/bin/env python3
import os
import struct


CTRL_MEM_WORDS = 56
STREAM_IN_BUF_BYTES = 16

NUM_LAYERS = 4

# Compact image layout used by both testbenches as backing data.
IMG_BASE_WQ = 0x00000
IMG_BASE_WK = 0x04000
IMG_BASE_WV = 0x08000
IMG_BASE_WO = 0x0C000
IMG_BASE_W1 = 0x10000
IMG_BASE_W2 = 0x16000
IMG_BASE_K_CACHE = 0x1C000
IMG_BASE_V_CACHE = 0x20000
IMG_BASE_WQ_BIAS = 0x24000
IMG_BASE_WK_BIAS = 0x28000
IMG_BASE_WV_BIAS = 0x2C000
IMG_BASE_WO_BIAS = 0x30000
IMG_BASE_W1_BIAS = 0x34000
IMG_BASE_W2_BIAS = 0x3A000
IMG_BASE_WVOCAB = 0x40000
IMG_BASE_WVOCAB_BIAS = 0x41000
IMG_BASE_LN0_GAMMA = 0x42000
IMG_BASE_LN1_GAMMA = 0x42400
IMG_BASE_FINAL_NORM_GAMMA = 0x42800
IMG_BASE_LN0_EPS = 0x42C00
IMG_BASE_LN1_EPS = 0x42C40
IMG_BASE_FINAL_NORM_EPS = 0x42C80

DDR_IMAGE_BYTES = 0x43000
LAYER_STRIDE_BYTES = 0x1000

QKV_SPAN_BYTES = 0x4000
MAIN_SPAN_BYTES = 0x4000
FFN_SPAN_BYTES = 0x6000
WVOCAB_SPAN_BYTES = 0x1000
LN_GAMMA_SPAN_BYTES = 0x0400


def clamp_i4(value: int) -> int:
    return max(-8, min(7, value))

def write_word_le(image: bytearray, addr: int, value: int) -> None:
    if addr < 0 or (addr + 4) > len(image):
        raise ValueError(f"address 0x{addr:X} outside image")
    image[addr:addr + 4] = struct.pack("<I", value & 0xFFFFFFFF)


def fill_pattern_region(image: bytearray, base: int, span_bytes: int, seed: int) -> None:
    for off in range(0, span_bytes, 4):
        write_word_le(image, base + off, seed + (off // 4))


def write_i4_packed_word(image: bytearray, addr: int, values: list[int]) -> None:
    if len(values) != 8:
        raise ValueError("expected 8 int4 values per packed word")
    packed = 0
    for nibble_idx, value in enumerate(values):
        packed |= (clamp_i4(value) & 0xF) << (nibble_idx * 4)
    write_word_le(image, addr, packed)


def fill_weight_region_soft(
    image: bytearray,
    base: int,
    span_bytes: int,
    *,
    phase_seed: int,
    base_mag: int,
) -> None:
    for off in range(0, span_bytes, 4):
        layer = min(off // LAYER_STRIDE_BYTES, max(NUM_LAYERS - 1, 0))
        layer_mag = max(1, base_mag - layer)
        word_idx = off // 4
        packed_vals = []
        for nibble_idx in range(8):
            phase = phase_seed + word_idx + nibble_idx + (layer * 3)
            raw = (phase % (2 * layer_mag + 1)) - layer_mag
            if raw == 0 and ((phase + layer) & 1):
                raw = 1
            packed_vals.append(raw)
        write_i4_packed_word(image, base + off, packed_vals)


def fill_i32_region_soft(
    image: bytearray,
    base: int,
    span_bytes: int,
    *,
    base_mag: int,
    phase_seed: int,
) -> None:
    for off in range(0, span_bytes, 4):
        layer = min(off // LAYER_STRIDE_BYTES, max(NUM_LAYERS - 1, 0))
        layer_mag = max(1, base_mag >> layer)
        word_idx = off // 4
        phase = phase_seed + word_idx + (layer * 5)
        value = (phase % (2 * layer_mag + 1)) - layer_mag
        write_word_le(image, base + off, value)


def fill_gamma_region_soft(
    image: bytearray,
    base: int,
    span_bytes: int,
    *,
    unity_q: int,
    taper_q: int,
) -> None:
    words_per_layer = LAYER_STRIDE_BYTES // 4
    for off in range(0, span_bytes, 4):
        layer = min(off // LAYER_STRIDE_BYTES, max(NUM_LAYERS - 1, 0))
        idx_in_layer = (off // 4) % words_per_layer
        ripple = (idx_in_layer % 8) - 3
        gamma = max(0x00000100, unity_q - (layer * taper_q) + (ripple * 0x10))
        write_word_le(image, base + off, gamma)


def build_ctrl_words() -> list[int]:
    words = [0] * CTRL_MEM_WORDS
    words[0] = 0x0000_0001  # CTRL_RESETN_BIT
    words[1] = 0x0000_0006  # IRQ mask
    words[2] = 0x0000_0000  # IRQ clear
    words[3] = 0x0000_0100  # DMA layer len
    words[4] = 0x0000_0040  # DMA head len
    words[5] = 0x0000_0020  # DMA tile len
    words[6] = 0x0000_1000  # layer stride
    words[7] = 0x0000_0100  # wq head stride
    words[8] = 0x0000_0100  # wk head stride
    words[9] = 0x0000_0100  # wv head stride
    words[10] = 0x0000_0100  # k cache stride
    words[11] = 0x0000_0100  # v cache stride
    words[12] = 0x0000_0020  # wo tile stride
    words[13] = 0x0000_0040  # w1 tile stride
    words[14] = 0x0000_0020  # w2 tile stride
    words[15] = 0x0000_0100  # wq bias head stride
    words[16] = 0x0000_0100  # wk bias head stride
    words[17] = 0x0000_0100  # wv bias head stride
    words[18] = 0x0000_0020  # wo bias tile stride
    words[19] = 0x0000_0040  # w1 bias tile stride
    words[20] = 0x0000_0020  # w2 bias tile stride
    words[21] = 0x0000_0080  # wlogit tile stride
    words[22] = 0x0000_0004  # ln0 gamma stride
    words[23] = 0x0000_0004  # ln1 gamma stride
    words[24] = 0x0000_0004  # final norm gamma stride
    words[25] = 0x0000_0004  # ln0 eps stride
    words[26] = 0x0000_0004  # ln1 eps stride
    words[27] = 0x0000_0004  # final norm eps stride
    words[28] = IMG_BASE_WQ
    words[29] = IMG_BASE_WK
    words[30] = IMG_BASE_WV
    words[31] = IMG_BASE_WO
    words[32] = IMG_BASE_W1
    words[33] = IMG_BASE_W2
    words[34] = IMG_BASE_K_CACHE
    words[35] = IMG_BASE_V_CACHE
    words[36] = IMG_BASE_WQ_BIAS
    words[37] = IMG_BASE_WK_BIAS
    words[38] = IMG_BASE_WV_BIAS
    words[39] = IMG_BASE_WO_BIAS
    words[40] = IMG_BASE_W1_BIAS
    words[41] = IMG_BASE_W2_BIAS
    words[42] = IMG_BASE_LN0_GAMMA
    words[43] = IMG_BASE_LN1_GAMMA
    words[44] = IMG_BASE_FINAL_NORM_GAMMA
    words[45] = IMG_BASE_LN0_EPS
    words[46] = IMG_BASE_LN1_EPS
    words[47] = IMG_BASE_FINAL_NORM_EPS
    words[48] = IMG_BASE_WVOCAB  # wlogit offset
    words[49] = 0x00000600  # lower attention/logit scale to reduce downstream saturation
    words[50] = 0x00000800  # scale_q
    words[51] = 0x00000000  # zero_point_q
    words[52] = 0x00000800  # scale_k
    words[53] = 0x00000000  # zero_point_k
    words[54] = 0x00000800  # scale_v
    words[55] = 0x00000000  # zero_point_v
    return words


def build_stream_bytes() -> bytes:
    # Keep the token deterministic but start from a much smaller activation range.
    pattern = (-3, -2, -1, 0, 1, 2, 3, 1)
    return bytes((pattern[i % len(pattern)] & 0xFF) for i in range(STREAM_IN_BUF_BYTES))


def build_generated_mem_map_svh() -> str:
    return f"""// Auto-generated by gen_ddr_image.py. Do not hand-edit.
  localparam int DDR_IMAGE_BYTES       = 'h{DDR_IMAGE_BYTES:05X};
  localparam int IMG_SPAN_WQ           = 'h04000;
  localparam int IMG_SPAN_WK           = 'h04000;
  localparam int IMG_SPAN_WV           = 'h04000;
  localparam int IMG_SPAN_WO           = 'h04000;
  localparam int IMG_SPAN_W1           = 'h06000;
  localparam int IMG_SPAN_W2           = 'h06000;
  localparam int IMG_SPAN_K_CACHE      = 'h04000;
  localparam int IMG_SPAN_V_CACHE      = 'h04000;
  localparam int IMG_SPAN_WQ_BIAS      = 'h04000;
  localparam int IMG_SPAN_WK_BIAS      = 'h04000;
  localparam int IMG_SPAN_WV_BIAS      = 'h04000;
  localparam int IMG_SPAN_WO_BIAS      = 'h04000;
  localparam int IMG_SPAN_W1_BIAS      = 'h06000;
  localparam int IMG_SPAN_W2_BIAS      = 'h06000;
  localparam int IMG_SPAN_WVOCAB       = 'h01000;
  localparam int IMG_SPAN_WVOCAB_BIAS  = 'h01000;
  localparam int IMG_SPAN_LN_GAMMA     = 'h00400;
  localparam int IMG_SPAN_LN_EPS       = 'h00040;

  localparam int IMG_BASE_WQ               = 'h{IMG_BASE_WQ:05X};
  localparam int IMG_BASE_WK               = 'h{IMG_BASE_WK:05X};
  localparam int IMG_BASE_WV               = 'h{IMG_BASE_WV:05X};
  localparam int IMG_BASE_WO               = 'h{IMG_BASE_WO:05X};
  localparam int IMG_BASE_W1               = 'h{IMG_BASE_W1:05X};
  localparam int IMG_BASE_W2               = 'h{IMG_BASE_W2:05X};
  localparam int IMG_BASE_K_CACHE          = 'h{IMG_BASE_K_CACHE:05X};
  localparam int IMG_BASE_V_CACHE          = 'h{IMG_BASE_V_CACHE:05X};
  localparam int IMG_BASE_WQ_BIAS          = 'h{IMG_BASE_WQ_BIAS:05X};
  localparam int IMG_BASE_WK_BIAS          = 'h{IMG_BASE_WK_BIAS:05X};
  localparam int IMG_BASE_WV_BIAS          = 'h{IMG_BASE_WV_BIAS:05X};
  localparam int IMG_BASE_WO_BIAS          = 'h{IMG_BASE_WO_BIAS:05X};
  localparam int IMG_BASE_W1_BIAS          = 'h{IMG_BASE_W1_BIAS:05X};
  localparam int IMG_BASE_W2_BIAS          = 'h{IMG_BASE_W2_BIAS:05X};
  localparam int IMG_BASE_WVOCAB           = 'h{IMG_BASE_WVOCAB:05X};
  localparam int IMG_BASE_WVOCAB_BIAS      = 'h{IMG_BASE_WVOCAB_BIAS:05X};
  localparam int IMG_BASE_LN0_GAMMA        = 'h{IMG_BASE_LN0_GAMMA:05X};
  localparam int IMG_BASE_LN1_GAMMA        = 'h{IMG_BASE_LN1_GAMMA:05X};
  localparam int IMG_BASE_FINAL_NORM_GAMMA = 'h{IMG_BASE_FINAL_NORM_GAMMA:05X};
  localparam int IMG_BASE_LN0_EPS          = 'h{IMG_BASE_LN0_EPS:05X};
  localparam int IMG_BASE_LN1_EPS          = 'h{IMG_BASE_LN1_EPS:05X};
  localparam int IMG_BASE_FINAL_NORM_EPS   = 'h{IMG_BASE_FINAL_NORM_EPS:05X};
"""


def main() -> None:
    image = bytearray(DDR_IMAGE_BYTES)

    # Use small bounded weights instead of huge monotonic ramps. Later layer
    # chunks are tapered further to keep the residual path from exploding.
    fill_weight_region_soft(image, IMG_BASE_WQ, QKV_SPAN_BYTES, phase_seed=1, base_mag=2)
    fill_weight_region_soft(image, IMG_BASE_WK, QKV_SPAN_BYTES, phase_seed=5, base_mag=2)
    fill_weight_region_soft(image, IMG_BASE_WV, QKV_SPAN_BYTES, phase_seed=9, base_mag=2)
    fill_weight_region_soft(image, IMG_BASE_WO, MAIN_SPAN_BYTES, phase_seed=13, base_mag=2)
    fill_weight_region_soft(image, IMG_BASE_W1, FFN_SPAN_BYTES, phase_seed=17, base_mag=1)
    fill_weight_region_soft(image, IMG_BASE_W2, FFN_SPAN_BYTES, phase_seed=21, base_mag=1)
    fill_weight_region_soft(image, IMG_BASE_WVOCAB, WVOCAB_SPAN_BYTES, phase_seed=25, base_mag=1)

    # Keep biases near zero so deeper layers do not accumulate a large DC offset.
    fill_i32_region_soft(image, IMG_BASE_WQ_BIAS, QKV_SPAN_BYTES, phase_seed=3, base_mag=8)
    fill_i32_region_soft(image, IMG_BASE_WK_BIAS, QKV_SPAN_BYTES, phase_seed=7, base_mag=8)
    fill_i32_region_soft(image, IMG_BASE_WV_BIAS, QKV_SPAN_BYTES, phase_seed=11, base_mag=8)
    fill_i32_region_soft(image, IMG_BASE_WO_BIAS, MAIN_SPAN_BYTES, phase_seed=15, base_mag=6)
    fill_i32_region_soft(image, IMG_BASE_W1_BIAS, FFN_SPAN_BYTES, phase_seed=19, base_mag=4)
    fill_i32_region_soft(image, IMG_BASE_W2_BIAS, FFN_SPAN_BYTES, phase_seed=23, base_mag=4)
    fill_i32_region_soft(image, IMG_BASE_WVOCAB_BIAS, WVOCAB_SPAN_BYTES, phase_seed=27, base_mag=3)

    # Keep norm gains closer to a soft unity and taper them by layer.
    fill_gamma_region_soft(image, IMG_BASE_LN0_GAMMA, LN_GAMMA_SPAN_BYTES, unity_q=0x00000800, taper_q=0x00000100)
    fill_gamma_region_soft(image, IMG_BASE_LN1_GAMMA, LN_GAMMA_SPAN_BYTES, unity_q=0x00000780, taper_q=0x00000100)
    fill_gamma_region_soft(image, IMG_BASE_FINAL_NORM_GAMMA, LN_GAMMA_SPAN_BYTES, unity_q=0x00000700, taper_q=0x00000080)

    for layer in range(NUM_LAYERS):
        write_word_le(image, IMG_BASE_LN0_EPS + layer * 4, 0x00000004)
        write_word_le(image, IMG_BASE_LN1_EPS + layer * 4, 0x00000004)
        write_word_le(image, IMG_BASE_FINAL_NORM_EPS + layer * 4, 0x00000004)

    out_dir = os.path.dirname(__file__)

    with open(os.path.join(out_dir, "ddr_image.bin"), "wb") as f:
        f.write(image)

    ctrl_words = build_ctrl_words()
    with open(os.path.join(out_dir, "ctrl_mem.bin"), "wb") as f:
        for word in ctrl_words:
            f.write(struct.pack("<I", word))

    with open(os.path.join(out_dir, "stream_in.bin"), "wb") as f:
        f.write(build_stream_bytes())

    with open(os.path.join(out_dir, "generated_mem_map.svh"), "w", encoding="ascii") as f:
        f.write(build_generated_mem_map_svh())

    print(os.path.join(out_dir, "ctrl_mem.bin"))
    print(os.path.join(out_dir, "ddr_image.bin"))
    print(os.path.join(out_dir, "stream_in.bin"))
    print(os.path.join(out_dir, "generated_mem_map.svh"))


if __name__ == "__main__":
    main()
