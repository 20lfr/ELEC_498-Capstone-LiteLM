#!/usr/bin/env python3
import os
import struct


CTRL_MEM_WORDS = 68
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
IMG_BASE_LN0_GAMMA = 0x42000
IMG_BASE_LN1_GAMMA = 0x42400
IMG_BASE_FINAL_NORM_GAMMA = 0x42800
IMG_BASE_LN0_EPS = 0x42C00
IMG_BASE_LN1_EPS = 0x42C40
IMG_BASE_FINAL_NORM_EPS = 0x42C80

DDR_IMAGE_BYTES = 0x43000

# Restored SV TB 64-bit control-space addresses.
CTRL_BASE_WQ = 0x0000_0001_6000_0000
CTRL_BASE_WK = 0x0000_0001_6100_0000
CTRL_BASE_WV = 0x0000_0001_6200_0000
CTRL_BASE_WO = 0x0000_0001_6300_0000
CTRL_BASE_W1 = 0x0000_0001_6400_0000
CTRL_BASE_W2 = 0x0000_0001_6500_0000
CTRL_BASE_K_CACHE = 0x0000_0001_6600_0000
CTRL_BASE_V_CACHE = 0x0000_0001_6700_0000
CTRL_BASE_WQ_BIAS = 0x0000_0001_6008_0000
CTRL_BASE_WK_BIAS = 0x0000_0001_6108_0000
CTRL_BASE_WV_BIAS = 0x0000_0001_6208_0000
CTRL_BASE_WO_BIAS = 0x0000_0001_6308_0000
CTRL_BASE_W1_BIAS = 0x0000_0001_6408_0000
CTRL_BASE_W2_BIAS = 0x0000_0001_6508_0000
CTRL_BASE_LN0_GAMMA = 0x0000_0001_6800_0000
CTRL_BASE_LN1_GAMMA = 0x0000_0001_6900_0000
CTRL_BASE_FINAL_NORM_GAMMA = 0x0000_0001_6C00_0000
CTRL_BASE_LN0_EPS = 0x0000_0001_6A00_0000
CTRL_BASE_LN1_EPS = 0x0000_0001_6B00_0000
CTRL_BASE_FINAL_NORM_EPS = 0x0000_0001_6D00_0000


def write_word_le(image: bytearray, addr: int, value: int) -> None:
    if addr < 0 or (addr + 4) > len(image):
        raise ValueError(f"address 0x{addr:X} outside image")
    image[addr:addr + 4] = struct.pack("<I", value & 0xFFFFFFFF)


def fill_pattern_region(image: bytearray, base: int, span_bytes: int, seed: int) -> None:
    for off in range(0, span_bytes, 4):
        write_word_le(image, base + off, seed + (off // 4))


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
    words[21] = 0x0000_0004  # ln0 gamma stride
    words[22] = 0x0000_0004  # ln1 gamma stride
    words[23] = 0x0000_0004  # final norm gamma stride
    words[24] = 0x0000_0004  # ln0 eps stride
    words[25] = 0x0000_0004  # ln1 eps stride
    words[26] = 0x0000_0004  # final norm eps stride
    words[27] = 0x0000_0000  # align pad

    def put_u64(idx_lo: int, value: int) -> None:
        words[idx_lo] = value & 0xFFFFFFFF
        words[idx_lo + 1] = (value >> 32) & 0xFFFFFFFF

    put_u64(28, CTRL_BASE_WQ)
    put_u64(30, CTRL_BASE_WK)
    put_u64(32, CTRL_BASE_WV)
    put_u64(34, CTRL_BASE_WO)
    put_u64(36, CTRL_BASE_W1)
    put_u64(38, CTRL_BASE_W2)
    put_u64(40, CTRL_BASE_K_CACHE)
    put_u64(42, CTRL_BASE_V_CACHE)
    put_u64(44, CTRL_BASE_WQ_BIAS)
    put_u64(46, CTRL_BASE_WK_BIAS)
    put_u64(48, CTRL_BASE_WV_BIAS)
    put_u64(50, CTRL_BASE_WO_BIAS)
    put_u64(52, CTRL_BASE_W1_BIAS)
    put_u64(54, CTRL_BASE_W2_BIAS)
    put_u64(56, CTRL_BASE_LN0_GAMMA)
    put_u64(58, CTRL_BASE_LN1_GAMMA)
    put_u64(60, CTRL_BASE_FINAL_NORM_GAMMA)
    put_u64(62, CTRL_BASE_LN0_EPS)
    put_u64(64, CTRL_BASE_LN1_EPS)
    put_u64(66, CTRL_BASE_FINAL_NORM_EPS)
    return words


def build_stream_bytes() -> bytes:
    # One token payload, matching the restored SV testbench.
    return bytes(((0x10 + i) & 0xFF) for i in range(STREAM_IN_BUF_BYTES))


def main() -> None:
    image = bytearray(DDR_IMAGE_BYTES)

    # Match the old SV TB region patterns.
    fill_pattern_region(image, IMG_BASE_WQ, 0x4000, 0xA1000000)
    fill_pattern_region(image, IMG_BASE_WK, 0x4000, 0xA2000000)
    fill_pattern_region(image, IMG_BASE_WV, 0x4000, 0xA3000000)
    fill_pattern_region(image, IMG_BASE_WO, 0x4000, 0xA4000000)
    fill_pattern_region(image, IMG_BASE_W1, 0x6000, 0xA5000000)
    fill_pattern_region(image, IMG_BASE_W2, 0x6000, 0xA6000000)

    fill_pattern_region(image, IMG_BASE_WQ_BIAS, 0x4000, 0x00000100)
    fill_pattern_region(image, IMG_BASE_WK_BIAS, 0x4000, 0x00000200)
    fill_pattern_region(image, IMG_BASE_WV_BIAS, 0x4000, 0x00000300)
    fill_pattern_region(image, IMG_BASE_WO_BIAS, 0x4000, 0x00000400)
    fill_pattern_region(image, IMG_BASE_W1_BIAS, 0x6000, 0x00000500)
    fill_pattern_region(image, IMG_BASE_W2_BIAS, 0x6000, 0x00000600)

    fill_pattern_region(image, IMG_BASE_LN0_GAMMA, 0x0400, 0x00002000)
    fill_pattern_region(image, IMG_BASE_LN1_GAMMA, 0x0400, 0x00002100)
    fill_pattern_region(image, IMG_BASE_FINAL_NORM_GAMMA, 0x0400, 0x00002200)

    for layer in range(NUM_LAYERS):
        write_word_le(image, IMG_BASE_LN0_EPS + layer * 4, 0x00000001)
        write_word_le(image, IMG_BASE_LN1_EPS + layer * 4, 0x00000001)
        write_word_le(image, IMG_BASE_FINAL_NORM_EPS + layer * 4, 0x00000001)

    out_dir = os.path.dirname(__file__)

    with open(os.path.join(out_dir, "ddr_image.bin"), "wb") as f:
        f.write(image)

    ctrl_words = build_ctrl_words()
    with open(os.path.join(out_dir, "ctrl_mem.bin"), "wb") as f:
        for word in ctrl_words:
            f.write(struct.pack("<I", word))

    with open(os.path.join(out_dir, "stream_in.bin"), "wb") as f:
        f.write(build_stream_bytes())

    print(os.path.join(out_dir, "ctrl_mem.bin"))
    print(os.path.join(out_dir, "ddr_image.bin"))
    print(os.path.join(out_dir, "stream_in.bin"))


if __name__ == "__main__":
    main()
