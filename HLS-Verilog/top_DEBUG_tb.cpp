// Minimal testbench for Simple_Scheduler_FSM.
// Mirrors the style of Scheduler_tb_minimal.cpp but against the simplified scheduler interface.
#include <cstdio>
#include <cstdint>
#include <string>

#include "top.hpp"

static const char *state_name(SchedState st) {
    switch (st) {
    case S_IDLE:            return "S_IDLE";
    case S_STREAM_IN:       return "S_STREAM_IN";
    case S_LAYER_COUNT:     return "S_LAYER_COUNT";
    case S_ATTENTION_HEADS: return "S_ATT_HEADS";
    case S_HEAD_CONCAT:     return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:  return "S_OUT_PROJ";
    case S_REQUANT1:        return "S_RQ1";
    case S_RES_ADD_1:       return "S_RES_ADD_1";
    case S_LAYER_NORM_0:    return "S_LN_0";
    case S_REQUANT2:        return "S_RQ2";
    case S_FFN:             return "S_FFN";
    case S_REQUANT3:        return "S_RQ3";
    case S_RES_ADD_2:       return "S_RES_ADD_2";
    case S_LAYER_NORM_1:    return "S_LN_1";
    case S_REQUANT4:        return "S_RQ4";
    case S_LOOP_CHECK:      return "S_LOOP_CHECK";
    case S_FINAL_NORM:      return "S_FINAL_NORM";
    case S_STREAM_OUT:      return "S_STREAM_OUT";
    default:                return "UNKNOWN";
    }
}

static const char *op_name(ComputeOp op) {
    switch (op) {
    case CMP_NONE:         return "-";
    case CMP_Q:            return "Q";
    case CMP_K:            return "K";
    case CMP_V:            return "V";
    case CMP_K_REQUANT:    return "K_RQ";
    case CMP_V_REQUANT:    return "V_RQ";
    case CMP_REQUANT_Q:    return "RQ_Q";
    case CMP_ATT_SCORES:   return "ATT_SCORES";
    case CMP_VALUE_SCALE:  return "VALUE_SCALE";
    case CMP_SOFTMAX:      return "SOFTMAX";
    case CMP_ATT_VALUE:    return "ATT_VALUE";
    case CMP_HEAD_REQUANT: return "HEAD_RQ";
    case CMP_CONCAT:       return "CONCAT";
    case CMP_OUT_PROJ:     return "OUT_PROJ";
    case CMP_REQUANT1:     return "RQ1";
    case CMP_RESID0:       return "RESID0";
    case CMP_LN0:          return "LN0";
    case CMP_REQUANT2:     return "RQ2";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_REQUANT3:     return "RQ3";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN1:          return "LN1";
    case CMP_REQUANT4:     return "RQ4";
    case CMP_DEQUANT:      return "DEQUANT";
    case CMP_FINAL_NORM:   return "FINAL_NORM";
    case CMP_LOGITS:       return "LOGITS";
    default:               return "UNK";
    }
}

static inline ComputeOp decode_op(uint32_t packed_op) {
    return static_cast<ComputeOp>(packed_op & 0xFFu);
}

static const char *dma_name(DmaSel sel) {
    switch (sel) {
    case DMASEL_NONE:   return "-";
    case DMASEL_WQ:     return "WQ";
    case DMASEL_WK:     return "WK";
    case DMASEL_WV:     return "WV";
    case DMASEL_CTX_K:  return "CTX_K";
    case DMASEL_CTX_V:  return "CTX_V";
    case DMASEL_K_WRITE:return "K_WR";
    case DMASEL_V_WRITE:return "V_WR";
    case DMASEL_WO:     return "WO";
    case DMASEL_W1:     return "W1";
    case DMASEL_W2:     return "W2";
    case DMASEL_WLOGIT: return "WLOGIT";
    case DMASEL_CONCAT: return "CONCAT";
    default:            return "UNK";
    }
}

static const char *phase_name(HeadPhase ph) {
    switch (ph) {
    case HeadPhase::IDLE:              return "IDLE";
    case HeadPhase::Q:                 return "Q";
    case HeadPhase::K:                 return "K";
    case HeadPhase::K_REQUANT:         return "K_RQ";
    case HeadPhase::K_WRITEBACK:       return "K_WR";
    case HeadPhase::V:                 return "V";
    case HeadPhase::V_REQUANT:         return "V_RQ";
    case HeadPhase::V_WRITEBACK:       return "V_WR";
    case HeadPhase::REQUANT_Q:         return "Q_RQ";
    case HeadPhase::ATT_SCORES:        return "ATT";
    case HeadPhase::VALUE_SCALE_CLAMP: return "SCL";
    case HeadPhase::ATT_SOFTMAX:       return "SMX";
    case HeadPhase::ATT_VALUE:         return "VAL";
    case HeadPhase::HEAD_REQUANT:     return "HEAD_RQ";
    case HeadPhase::DONE:              return "DONE";
    default:                           return "UNK";
    }
}

static void print_buffer(const char *label, const uint8_t *buf, int size) {
    std::printf("%s[%d]:\n", label, size);
    for (int i = 0; i < size; ++i) {
        if ((i % 16) == 0) {
            std::printf("  %04x:", i);
        }
        std::printf(" %02x", static_cast<unsigned>(buf[i]));
        if ((i % 16) == 15 || i == size - 1) {
            std::printf("\n");
        }
    }
}

static void print_ln_in_buf(const uint8_t *in_buf) {
    std::printf("LN in_buf (decoded):\n  X:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::LayerNormLayout::X + i)));
    }
    std::printf("\n  GAMMA:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::LayerNormLayout::GAMMA + (i * 4))));
    }
    const int32_t eps = compute_buf::read_i32(in_buf, compute_buf::LayerNormLayout::EPS);
    std::printf("\n  EPS: %d\n", static_cast<int>(eps));
}

static void print_ln_out_buf(const uint8_t *out_buf) {
    std::printf("LN out_buf (decoded):\n  Y:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, compute_buf::LayerNormLayout::X + (i * 4))));
    }
    std::printf("\n");
}

static void print_in_buf_decoded(ComputeOp op, const uint8_t *in_buf) {
    switch (op) {
    case ComputeOp::CMP_OUT_PROJ: {
        std::printf("OUT_PROJ in_buf (decoded):\n  ACT:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::OutProjLayout::ACT + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::OutProjLayout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::OutProjLayout::B + (i * 4))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_REQUANT1:
    case ComputeOp::CMP_REQUANT2:
    case ComputeOp::CMP_REQUANT3:
    case ComputeOp::CMP_REQUANT4: {
        std::printf("REQUANT in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::RequantLayout::X + (i * 4))));
        }
        const int32_t M = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::M);
        const int32_t N = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::N);
        const int32_t Z = compute_buf::read_i32(in_buf, compute_buf::RequantLayout::Z);
        std::printf("\n  M: %d\n  N: %d\n  Z: %d\n", static_cast<int>(M), static_cast<int>(N), static_cast<int>(Z));
        break;
    }
    case ComputeOp::CMP_RESID0:
    case ComputeOp::CMP_RESID1: {
        std::printf("RESID in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::ResidLayout::X + i)));
        }
        std::printf("\n  R:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::ResidLayout::R + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LN0:
    case ComputeOp::CMP_LN1:
    case ComputeOp::CMP_FINAL_NORM:
        print_ln_in_buf(in_buf);
        break;
    case ComputeOp::CMP_FFN_W1: {
        std::printf("FFN_W1 in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::FfnW1Layout::X + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::FfnW1Layout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::FfnW1Layout::B + (i * 4))));
        }
        std::printf("\n  S:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::FfnW1Layout::S + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_ACT: {
        std::printf("FFN_ACT in_buf (decoded):\n  X:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::FfnActLayout::X + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_W2: {
        std::printf("FFN_W2 in_buf (decoded):\n  X:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::FfnW2Layout::X + (i * 2))));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_FFN * D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::FfnW2Layout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::FfnW2Layout::B + (i * 4))));
        }
        std::printf("\n  S:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::FfnW2Layout::S + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("in_buf (decoded): <no decoder>\n");
        break;
    }
}

static void print_out_buf_decoded(ComputeOp op, const uint8_t *out_buf) {
    switch (op) {
    case ComputeOp::CMP_OUT_PROJ: {
        std::printf("OUT_PROJ out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_REQUANT1:
    case ComputeOp::CMP_REQUANT2:
    case ComputeOp::CMP_REQUANT3:
    case ComputeOp::CMP_REQUANT4: {
        std::printf("REQUANT out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, compute_buf::RequantLayout::X + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_RESID0:
    case ComputeOp::CMP_RESID1: {
        std::printf("RESID out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, compute_buf::ResidLayout::X + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LN0:
    case ComputeOp::CMP_LN1:
    case ComputeOp::CMP_FINAL_NORM:
        print_ln_out_buf(out_buf);
        break;
    case ComputeOp::CMP_FFN_W1: {
        std::printf("FFN_W1 out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, i * 2)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_ACT: {
        std::printf("FFN_ACT out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, compute_buf::FfnActLayout::X + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_W2: {
        std::printf("FFN_W2 out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, i * 4)));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("out_buf (decoded): <no decoder>\n");
        break;
    }
}

struct DmaFields {
    DmaSel sel;
    int layer;
    int head;
    int tile;
};

static inline DmaFields decode_wl_instruction(uint32_t instr) {
    DmaFields f;
    f.sel = static_cast<DmaSel>(instr & 0xFFu);
    f.layer = static_cast<int>((instr >> 8) & 0xFFu);
    f.head = static_cast<int>(static_cast<int8_t>((instr >> 16) & 0xFFu));
    f.tile = static_cast<int>(static_cast<int8_t>((instr >> 24) & 0xFFu));
    return f;
}

static uint32_t compute_wl_address(uint32_t instr, const ControlMemSpace &ctrl) {
    const DmaFields f = decode_wl_instruction(instr);
    if (f.layer < 0) {
        return 0;
    }
    const uint32_t layer_u = static_cast<uint32_t>(f.layer);
    switch (f.sel) {
    case DMASEL_WQ:
        if (f.head < 0) return 0;
        return ctrl.wq_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.head) * ctrl.wq_head_stride;
    case DMASEL_WK:
        if (f.head < 0) return 0;
        return ctrl.wk_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.head) * ctrl.wk_head_stride;
    case DMASEL_WV:
        if (f.head < 0) return 0;
        return ctrl.wv_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.head) * ctrl.wv_head_stride;
    case DMASEL_CTX_K:
        if (f.head < 0) return 0;
        return ctrl.k_cache_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.head) * ctrl.k_cache_stride;
    case DMASEL_CTX_V:
        if (f.head < 0) return 0;
        return ctrl.v_cache_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.head) * ctrl.v_cache_stride;
    case DMASEL_WO:
        if (f.tile < 0) return 0;
        return ctrl.wo_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.tile) * ctrl.wo_tile_stride;
    case DMASEL_W1:
        if (f.tile < 0) return 0;
        return ctrl.w1_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.tile) * ctrl.w1_tile_stride;
    case DMASEL_W2:
        if (f.tile < 0) return 0;
        return ctrl.w2_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(f.tile) * ctrl.w2_tile_stride;
    case DMASEL_CONCAT:
        return 0;
    default:
        return 0;
    }
}

static uint32_t compute_wl_address(
    DmaSel sel,
    int layer,
    int head,
    int tile,
    const ControlMemSpace &ctrl
) {
    if (layer < 0) {
        return 0;
    }
    const uint32_t layer_u = static_cast<uint32_t>(layer);
    switch (sel) {
    case DMASEL_WQ:
        if (head < 0) return 0;
        return ctrl.wq_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.wq_head_stride;
    case DMASEL_WK:
        if (head < 0) return 0;
        return ctrl.wk_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.wk_head_stride;
    case DMASEL_WV:
        if (head < 0) return 0;
        return ctrl.wv_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.wv_head_stride;
    case DMASEL_CTX_K:
        if (head < 0) return 0;
        return ctrl.k_cache_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.k_cache_stride;
    case DMASEL_CTX_V:
        if (head < 0) return 0;
        return ctrl.v_cache_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(head) * ctrl.v_cache_stride;
    case DMASEL_WO:
        if (tile < 0) return 0;
        return ctrl.wo_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(tile) * ctrl.wo_tile_stride;
    case DMASEL_W1:
        if (tile < 0) return 0;
        return ctrl.w1_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(tile) * ctrl.w1_tile_stride;
    case DMASEL_W2:
        if (tile < 0) return 0;
        return ctrl.w2_base_addr + layer_u * ctrl.layer_stride +
               static_cast<uint32_t>(tile) * ctrl.w2_tile_stride;
    default:
        return 0;
    }
}

// Helper to decode status register bits
static const char *status_name(uint32_t status) {
    if (status & STATUS_ERROR)    return "ERROR";
    if (status & STATUS_BUSY_BIT) return "BUSY";
    if (status & STATUS_IDLE)     return "IDLE";
    return "-";
}

static const char *irq_name(uint32_t irq) {
    if (irq & IRQ_ERROR_BIT)        return "ERROR";
    if (irq & IRQ_INFER_DONE_BIT)   return "DONE";
    return "-";
}

ControlMemSpace ctrl_mem_init(bool init) {
    ControlMemSpace ctrl_mem{};
    if(init) {
        ctrl_mem.control = CTRL_RESETN_BIT;
        ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
        ctrl_mem.irq_clear = 0;
        // DMA lengths (non-zero required)
        ctrl_mem.dma_layer_len = 0x00000100;
        ctrl_mem.dma_head_len  = 0x00000100;
        ctrl_mem.dma_tile_len  = 0x00000100;
        // Strides (non-zero required) - match OG testbench values
        ctrl_mem.layer_stride    = 0x00001000;
        ctrl_mem.wq_head_stride  = 0x00000100;
        ctrl_mem.wk_head_stride  = 0x00000100;
        ctrl_mem.wv_head_stride  = 0x00000100;
        ctrl_mem.k_cache_stride  = 0x00000400;
        ctrl_mem.v_cache_stride  = 0x00000400;
        ctrl_mem.wo_tile_stride  = 0x00000100;
        ctrl_mem.w1_tile_stride  = 0x00000300;
        ctrl_mem.w2_tile_stride  = 0x00000800;
        // Base addresses - MUST be 64-byte aligned (& 0x3F == 0)
        ctrl_mem.wq_base_addr = 0x10000000;
        ctrl_mem.wk_base_addr = 0x20000000;
        ctrl_mem.wv_base_addr = 0x30000000;
        ctrl_mem.wo_base_addr = 0x60000000;
        ctrl_mem.w1_base_addr = 0x70000000;
        ctrl_mem.w2_base_addr = 0x80000000;
        ctrl_mem.k_cache_addr = 0x40000000;
        ctrl_mem.v_cache_addr = 0x50000000;
        // Quantization params
        ctrl_mem.logit_scale_qv = 0x00000100;
        ctrl_mem.scale_q        = 0x00000100;
        ctrl_mem.zero_point_q   = 0x00000000;
        ctrl_mem.scale_k        = 0x00000100;
        ctrl_mem.zero_point_k   = 0x00000000;
        ctrl_mem.scale_v        = 0x00000100;
        ctrl_mem.zero_point_v   = 0x00000000;
    }
    return ctrl_mem;
}

static inline void write_i4(uint8_t *buf, int nibble_idx, int8_t value) {
    const uint8_t v = static_cast<uint8_t>(value) & 0x0F;
    const int byte_addr = nibble_idx / 2;
    if (nibble_idx % 2) {
        buf[byte_addr] = (buf[byte_addr] & 0x0F) | (v << 4);
    } else {
        buf[byte_addr] = (buf[byte_addr] & 0xF0) | v;
    }
}

int main() {
    const int MAX_CYCLES = 4000;
    const int COMP_LAT   = 3;
    const int DMA_LAT    = 3;
    const int AXIS_BEATS = 3;
    const int MEM_LAT     = 5;


    bool wl_ready        = false;
    bool wl_start        = false;
    uint32_t wl_instruction = 0;
    HeadCtx head_ctx_ref[NUM_HEADS];
    bool dma_done        = false;
    bool wl_dma_request  = false;
    uint32_t wl_dma_address = 0;

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    bool axis_in_ready   = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;

    bool mem_transfer_done = false;
    bool mem_read_request  = false;
    bool mem_write_request = false;
    uint32_t mem_op         = 0;
    uint32_t mem_op_latched = 0;
    uint8_t in_buf[compute_buf::IN_BUF_BYTES] = {};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES] = {};
    bool mem_busy = false;
    int  mem_timer = 0;
    enum class MemPending { None, Read, Write };
    MemPending mem_pending = MemPending::None;

    int8_t out_proj_act[D_MODEL] = {};
    int8_t out_proj_w[D_MODEL * D_MODEL] = {};
    int32_t out_proj_b[D_MODEL] = {};

    int32_t rq1_x[D_MODEL] = {};
    int32_t rq2_x[D_MODEL] = {};
    int32_t rq3_x[D_MODEL] = {};
    int32_t rq4_x[D_MODEL] = {};
    int32_t rq1_M = 1, rq1_N = 0, rq1_Z = 0;
    int32_t rq2_M = 2, rq2_N = 1, rq2_Z = 0;
    int32_t rq3_M = 1, rq3_N = 2, rq3_Z = 0;
    int32_t rq4_M = 3, rq4_N = 1, rq4_Z = 0;

    int8_t resid0_x[D_MODEL] = {};
    int8_t resid0_r[D_MODEL] = {};
    int8_t resid1_x[D_MODEL] = {};
    int8_t resid1_r[D_MODEL] = {};

    int8_t ln0_x[D_MODEL] = {};
    int8_t ln1_x[D_MODEL] = {};
    int8_t final_norm_x[D_MODEL] = {};
    int32_t ln0_gamma[D_MODEL] = {};
    int32_t ln1_gamma[D_MODEL] = {};
    int32_t final_norm_gamma[D_MODEL] = {};
    int32_t ln0_eps = 1;
    int32_t ln1_eps = 2;
    int32_t final_norm_eps = 3;

    int8_t ffn1_x[D_MODEL] = {};
    int8_t ffn1_w[D_MODEL * D_MODEL] = {};
    int32_t ffn1_b[D_MODEL] = {};
    int16_t ffn1_s[D_MODEL] = {};

    int16_t ffn_act_in[D_FFN] = {};

    int16_t ffn2_x[D_FFN] = {};
    int8_t  ffn2_w[D_FFN * D_FFN] = {};
    int32_t ffn2_b[D_FFN] = {};
    int16_t ffn2_s[D_FFN] = {};

    bool head_lane_busy[HEADS_PARALLEL] = {false};
    int  head_lane_timer[HEADS_PARALLEL] = {0};
    int  head_lane_active_idx[HEADS_PARALLEL] = {0};
    bool head_start_seen[NUM_HEADS] = {false};
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        head_lane_active_idx[lane] = -1;
    }
    bool head_dma_busy[HEADS_PARALLEL] = {false};
    int  head_dma_timer[HEADS_PARALLEL] = {0};
    int  head_dma_active_idx[HEADS_PARALLEL] = {0};
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
        head_dma_active_idx[lane] = -1;
    }

    bool stream_ready    = true;
    bool stream_start    = false;
    bool stream_done     = false;

    SchedState dbg_state     = S_IDLE;
    bool irq_ps              = false;
    bool irq_interupt_flagged = false;
    uint32_t interupt_data = 0;

    bool dma_busy        = false;
    int  dma_timer       = 0;
    bool stream_busy     = false;
    bool reset_released  = false;
    bool start_pulsed    = false;
    bool pending_start_clear = false;
    bool assign_base_addresses = false;
    bool seen_stream_out = false;
    int  idle_after_stream = 0;
    bool seen_done       = false;
    int  post_done_cycles= 0;
    bool seen_idle_after = false;
    bool seen_attn       = false;
    bool seen_concat     = false;
    int  base_assign_step = 0;
    enum class CtrlInitStage { 
        TestCtrlInit,           // 0: Initialize with valid config
        TestDmaZeroLen,         // 1: Test DMA zero-length error
        TestDmaZeroLenCheck,    // 2: Verify error was flagged
        TestDmaZeroLenClear,    // 3: Clear the error
        TestZeroStride,         // 4: Test zero-stride error  
        TestZeroStrideCheck,    // 5: Verify error was flagged
        TestZeroStrideClear,    // 6: Clear the error
        TestAlignment,          // 7: Test misaligned address error
        TestAlignmentCheck,     // 8: Verify error was flagged
        TestAlignmentClear,     // 9: Clear the error
        AssertReset,            // 10: Normal operation begins
        DeassertReset, 
        ProgramBases, 
        AssertStart, 
        ClearStart, 
        Done 
    };
    CtrlInitStage ctrl_stage = CtrlInitStage::TestCtrlInit;
    // Test tracking
    bool test_error_detected = false;
    int  test_errors_passed = 0;
    int  test_errors_failed = 0;
    bool dbg_done = false;
    bool dbg_error = false;
    
    ControlMemSpace ctrl_mem{};
    StatusMemSpace status_mem{};
    
    for (int i = 0; i < D_MODEL; ++i) {
        out_proj_act[i] = static_cast<int8_t>(i + 1);
        out_proj_b[i] = 7;
        rq1_x[i] = (i * 3) - 20;
        rq2_x[i] = (i * 2) + 5;
        rq3_x[i] = 100 - (i * 4);
        rq4_x[i] = (i * 5) - 11;
        resid0_x[i] = static_cast<int8_t>(i);
        resid0_r[i] = static_cast<int8_t>(i * 2);
        resid1_x[i] = static_cast<int8_t>(-i);
        resid1_r[i] = static_cast<int8_t>(i + 1);
        ln0_x[i] = static_cast<int8_t>(i + 1);
        ln1_x[i] = static_cast<int8_t>(i + 2);
        final_norm_x[i] = static_cast<int8_t>(i + 3);
        ln0_gamma[i] = 1;
        ln1_gamma[i] = 2;
        final_norm_gamma[i] = 3;
        ffn1_x[i] = static_cast<int8_t>(i + 3);
        ffn1_b[i] = 7;
        ffn1_s[i] = 0x4000;
    }
    for (int r = 0; r < D_MODEL; ++r) {
        for (int c = 0; c < D_MODEL; ++c) {
            out_proj_w[r * D_MODEL + c] = static_cast<int8_t>((r + c) & 0x7);
            ffn1_w[r * D_MODEL + c] = 1;
        }
    }
    for (int i = 0; i < D_FFN; ++i) {
        ffn_act_in[i] = static_cast<int16_t>((i * 3) - 20);
        ffn2_x[i] = static_cast<int16_t>((i * 2) + 1);
        ffn2_b[i] = 5;
        ffn2_s[i] = 0x4000;
    }
    for (int r = 0; r < D_FFN; ++r) {
        for (int c = 0; c < D_FFN; ++c) {
            ffn2_w[r * D_FFN + c] = 1;
        }
    }

    // DEBUG - UNUSED
    uint32_t ctrl_data_in = 0;
    uint32_t ctrl_data_out = 0;
    uint32_t ctrl_shadow_control = 0;
    bool ctrl_resetn_in = false;
    int ctrl_gap_cycles = 0; // spacing between control bus transactions
    bool seen_irq_done = false;

    ControlMemSpace dbg_ctrl_mem{};

    ComputeState dbg_compute_state = ComputeState::IDLE;
    bool dbg_compute_start = false;
    uint32_t dbg_compute_instruction = 0;
    bool dbg_compute_ready = false;
    bool dbg_compute_done = false;
    uint32_t dbg_req_instruction = 0;
    uint8_t dbg_req_op = 0;
    uint8_t dbg_req_layer = 0;
    uint8_t dbg_req_head = 0;
    uint8_t dbg_req_tile = 0;
    bool dbg_mac_start = false;
    bool dbg_mac_ready = false;
    bool dbg_mac_complete = false;
    bool dbg_ctrl_reset_asserted = false;

    uint32_t control_reg    = 0;
    uint32_t irq_status_reg     = 0;
    uint32_t irq_enable_reg     = 0;
    uint32_t wq_base_addr   = 0;
    uint32_t wk_base_addr   = 0;
    uint32_t wv_base_addr   = 0;
    uint32_t wo_base_addr   = 0;
    uint32_t w1_base_addr   = 0;
    uint32_t w2_base_addr   = 0;
    uint32_t wq_head_stride     = 0;
    uint32_t wk_head_stride     = 0;
    uint32_t wv_head_stride     = 0;
    uint32_t wo_tile_stride     = 0;
    uint32_t w1_tile_stride     = 0;
    uint32_t w2_tile_stride     = 0;

    std::printf("%-8s %-6s %-6s %-6s %-10s %-6s %-10s %-6s %-10s %-6s %-6s %-13s | %-10s %-6s %-10s %-10s %-6s | Heads: [idx:phase  C_St C_Dn  CompInstr WL_St DMA   DMADn]\n",
                "Cycle", "Start", "Reset", "CtrlR", "WlInstr", "DbgSt", "ReqInstr", "C_St", "CompInstr", "C_Rdy", "C_Dn", "DbgState",
                "MemCtrl", "MemIRQ", "MemMsk", "Status", "ErrCd");

    auto dash_or = [](bool v) { return v ? "1" : "-"; };

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Space out control transactions to model multi-cycle AXI-lite access
        if (ctrl_gap_cycles > 0) {
            ctrl_gap_cycles--;
        } else if (ctrl_stage == CtrlInitStage::TestCtrlInit) {
            // Start with valid config
            ctrl_mem = ctrl_mem_init(true);
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            std::printf("[TEST] Starting ControlMemInterface error tests...\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLen;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLen) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.dma_layer_len = 0;      // Inject error: zero length
            std::printf("[TEST 1] Injecting dma_layer_len=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestDmaZeroLenCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenCheck) {
            // Check if error was detected
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 1] PASS: ERR_DMA_ZERO_LEN detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 1] FAIL: Expected ERR_DMA_ZERO_LEN (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            // Clear the error
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestDmaZeroLenClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestDmaZeroLenClear) {
            ctrl_mem.irq_clear = 0;  // One-shot clear
            ctrl_mem = ctrl_mem_init(true);  // Restore valid config
            ctrl_stage = CtrlInitStage::TestZeroStride;
            ctrl_gap_cycles = 1;
        
        // ========== TEST 2: Zero Stride ==========
        } else if (ctrl_stage == CtrlInitStage::TestZeroStride) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.layer_stride = 0;       // Inject error: zero stride
            std::printf("[TEST 2] Injecting layer_stride=0 (expect ERR_DMA_ZERO_LEN)\n");
            ctrl_stage = CtrlInitStage::TestZeroStrideCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestZeroStrideCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ZERO_LEN) {
                std::printf("[TEST 2] PASS: Zero stride error detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 2] FAIL: Expected zero stride error (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestZeroStrideClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestZeroStrideClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(true);
            ctrl_stage = CtrlInitStage::TestAlignment;
            ctrl_gap_cycles = 1;
        
        // ========== TEST 3: Address Alignment ==========
        } else if (ctrl_stage == CtrlInitStage::TestAlignment) {
            ctrl_mem = ctrl_mem_init(true);  // Start fresh
            ctrl_mem.wq_base_addr = 0x10000001;  // Inject error: not 64-byte aligned
            std::printf("[TEST 3] Injecting wq_base_addr=0x10000001 (expect ERR_DMA_ALIGNMENT)\n");
            ctrl_stage = CtrlInitStage::TestAlignmentCheck;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentCheck) {
            if ((status_mem.irq_status & IRQ_ERROR_BIT) && status_mem.error_code == ERR_DMA_ALIGNMENT) {
                std::printf("[TEST 3] PASS: ERR_DMA_ALIGNMENT detected (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_passed++;
            } else {
                std::printf("[TEST 3] FAIL: Expected ERR_DMA_ALIGNMENT (irq=0x%X, err=0x%X)\n",
                            status_mem.irq_status, status_mem.error_code);
                test_errors_failed++;
            }
            ctrl_mem.irq_clear = IRQ_ERROR_BIT;
            ctrl_stage = CtrlInitStage::TestAlignmentClear;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::TestAlignmentClear) {
            ctrl_mem.irq_clear = 0;
            ctrl_mem = ctrl_mem_init(false);  
            std::printf("[TEST] Error tests complete: %d passed, %d failed\n", 
                        test_errors_passed, test_errors_failed);
            ctrl_stage = CtrlInitStage::AssertReset;  // Continue to normal operation
            ctrl_gap_cycles = 1;
        
        // ========== NORMAL OPERATION ==========
        } else if (ctrl_stage == CtrlInitStage::AssertReset) {
            ctrl_mem = ctrl_mem_init(false); // Restore default config
            ctrl_mem.control = 0x00000000;
            ctrl_data_in = 0x00000000;
            ctrl_shadow_control = 0x00000000;
            ctrl_resetn_in = false;
            ctrl_stage = CtrlInitStage::DeassertReset;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::DeassertReset) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            ctrl_stage = CtrlInitStage::ProgramBases;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ProgramBases) {
            // Program control-space base addresses and strides with reset asserted
            switch (base_assign_step) {
            case 0:
                // Clear any pending interrupts during programming
                ctrl_mem.irq_clear = IRQ_ERROR_BIT;
                ctrl_data_in  = IRQ_ERROR_BIT;
                break;
            case 1:
                ctrl_mem.dma_layer_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 2:
                ctrl_mem.dma_head_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 3:
                ctrl_mem.dma_tile_len = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 4:
                ctrl_mem.layer_stride = 0x00001000;
                ctrl_data_in  = 0x00001000;
                break;
            case 5:
                ctrl_mem.wq_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 6:
                ctrl_mem.wk_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 7:
                ctrl_mem.wv_head_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 8:
                ctrl_mem.k_cache_stride = 0x00000400;
                ctrl_data_in  = 0x00000400;
                break;
            case 9:
                ctrl_mem.v_cache_stride = 0x00000400;
                ctrl_data_in  = 0x00000400;
                break;
            case 10:
                ctrl_mem.wo_tile_stride = 0x00000100;
                ctrl_data_in  = 0x00000100;
                break;
            case 11:
                ctrl_mem.w1_tile_stride = 0x00000300;
                ctrl_data_in  = 0x00000300;
                break;
            case 12:
                ctrl_mem.w2_tile_stride = 0x00000800;
                ctrl_data_in  = 0x00000800;
                break;
            case 13:
                ctrl_mem.wq_base_addr = 0x10000000;
                ctrl_data_in  = 0x10000000;
                break;
            case 14:
                ctrl_mem.wk_base_addr = 0x20000000;
                ctrl_data_in  = 0x20000000;
                break;
            case 15:
                ctrl_mem.wv_base_addr = 0x30000000;
                ctrl_data_in  = 0x30000000;
                break;
            case 16:
                ctrl_mem.k_cache_addr = 0x40000000;
                ctrl_data_in  = 0x40000000;
                break;
            case 17:
                ctrl_mem.v_cache_addr = 0x50000000;
                ctrl_data_in  = 0x50000000;
                break;
            case 18:
                ctrl_mem.wo_base_addr = 0x60000000;
                ctrl_data_in  = 0x60000000;
                break;
            case 19:
                ctrl_mem.w1_base_addr = 0x70000000;
                ctrl_data_in  = 0x70000000;
                break;
            case 20:
                ctrl_mem.w2_base_addr = 0x80000000;
                ctrl_data_in  = 0x80000000;
                break;
            case 21:
                // Disabled interrupt clearing
                ctrl_mem.irq_clear = 0;
                ctrl_data_in  = 0;
                break;
            case 22:
                // Enable interrupts
                ctrl_mem.irq_mask = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
                ctrl_data_in  = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
                assign_base_addresses = true;
                ctrl_stage = CtrlInitStage::AssertStart;
                break;
            default:
                assign_base_addresses = true;
                ctrl_stage = CtrlInitStage::AssertStart;
                break;
            }
            if (!assign_base_addresses) {
                base_assign_step++;
            }
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::AssertStart) {
            ctrl_mem.control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_data_in = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT | CTRL_START_BIT;
            ctrl_resetn_in = true;
            reset_released = true;
            start_pulsed   = true;
            pending_start_clear = true;
            ctrl_stage = CtrlInitStage::ClearStart;
            ctrl_gap_cycles = 1;
        } else if (ctrl_stage == CtrlInitStage::ClearStart) {
            ctrl_mem.control = CTRL_RESETN_BIT;
            ctrl_data_in = CTRL_RESETN_BIT;
            ctrl_shadow_control = CTRL_RESETN_BIT;
            ctrl_resetn_in = true;
            pending_start_clear = false;
            ctrl_stage = CtrlInitStage::Done;
            ctrl_gap_cycles = 1;
        } else if(seen_irq_done){
            ctrl_mem.irq_clear = IRQ_INFER_DONE_BIT;
            ctrl_data_in = IRQ_INFER_DONE_BIT;
            ctrl_gap_cycles = 1;
            seen_irq_done = false;
        }
        else if(irq_ps){
            ctrl_gap_cycles = 1;
            irq_interupt_flagged = true;
            interupt_data = status_mem.irq_status;
        }

        // Clear per-head compute_done pulse
        for (int i = 0; i < NUM_HEADS; ++i) {
            head_ctx_ref[i].compute_done = false;
            head_ctx_ref[i].dma_done = false;
        }

        // Complete outstanding per-head compute operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_lane_busy[lane]) {
                if (head_lane_timer[lane] == 0) {
                    int idx = head_lane_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].compute_done = true;
                    }
                    head_lane_busy[lane] = false;
                    head_lane_active_idx[lane] = -1;
                } else {
                    --head_lane_timer[lane];
                }
            }
        }

        // Complete outstanding per-head DMA operations
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
            if (head_dma_busy[lane]) {
                if (head_dma_timer[lane] == 0) {
                    int idx = head_dma_active_idx[lane];
                    if (idx >= 0 && idx < NUM_HEADS) {
                        head_ctx_ref[idx].dma_done = true;
                    }
                    head_dma_busy[lane] = false;
                    head_dma_active_idx[lane] = -1;
                } else {
                    --head_dma_timer[lane];
                }
            }
        }

        // Complete outstanding DMA transfers
        dma_done = false;
        if (dma_busy) {
            if (dma_timer == 0) {
                dma_done = true;
                dma_busy = false;
            } else {
                --dma_timer;
            }
        }

        // Stream completion: single-cycle pulse after start
        stream_done = false;
        if (stream_busy) {
            stream_done = true;
            stream_busy = false;
        }

        // Ready signals depend on busy flags
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            head_ctx_ref[i].compute_ready = !head_lane_busy[lane];
            head_ctx_ref[i].wl_ready      = !head_dma_busy[lane];
        }
        stream_ready  = !stream_busy;
        wl_ready = !dma_busy;
        wl_dma_request = false;

        // Drive AXIS ingress: send a short burst when ready is asserted
        if (!axis_feed_done && (axis_drive || (((ctrl_shadow_control & CTRL_RESETN_BIT) != 0) && start_pulsed))) {
            axis_drive = true;
            if (!axis_in_valid && axis_in_ready) {
                axis_in_valid = true;
                axis_in_last  = (axis_sent == AXIS_BEATS - 1);
            }
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        // Memory manager model for compute_controller
        mem_transfer_done = false;
        if (mem_busy) {
            if (mem_timer == 0) {
                mem_transfer_done = true;
                mem_busy = false;
                if (mem_pending == MemPending::Read) {
                    const ComputeOp op = decode_op(mem_op_latched);
                    const int tile = static_cast<int>(static_cast<int8_t>((mem_op_latched >> 24) & 0xFFu));
                    for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
                        in_buf[i] = 0;
                    }
                    switch (op) {
                    case CMP_OUT_PROJ: {
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::OutProjLayout::ACT + i, out_proj_act[i]);
                        }
                        if (tile >= 0 && tile < NUM_WO_TILES) {
                            const int out_base = tile * D_TILE_WO;
                            for (int t = 0; t < D_TILE_WO; ++t) {
                                for (int i = 0; i < D_MODEL; ++i) {
                                    write_i4(in_buf, (compute_buf::OutProjLayout::W * 2) + (t * D_MODEL) + i,
                                             out_proj_w[(out_base + t) * D_MODEL + i]);
                                }
                                compute_buf::write_i32(in_buf, compute_buf::OutProjLayout::B + (t * 4), out_proj_b[out_base + t]);
                            }
                        }
                        break;
                    }
                    case CMP_REQUANT1:
                    case CMP_REQUANT2:
                    case CMP_REQUANT3:
                    case CMP_REQUANT4: {
                        const int32_t *src = (op == CMP_REQUANT1) ? rq1_x
                                           : (op == CMP_REQUANT2) ? rq2_x
                                           : (op == CMP_REQUANT3) ? rq3_x
                                           : rq4_x;
                        const int32_t M = (op == CMP_REQUANT1) ? rq1_M
                                         : (op == CMP_REQUANT2) ? rq2_M
                                         : (op == CMP_REQUANT3) ? rq3_M
                                         : rq4_M;
                        const int32_t N = (op == CMP_REQUANT1) ? rq1_N
                                         : (op == CMP_REQUANT2) ? rq2_N
                                         : (op == CMP_REQUANT3) ? rq3_N
                                         : rq4_N;
                        const int32_t Z = (op == CMP_REQUANT1) ? rq1_Z
                                         : (op == CMP_REQUANT2) ? rq2_Z
                                         : (op == CMP_REQUANT3) ? rq3_Z
                                         : rq4_Z;
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::X + (i * 4), src[i]);
                        }
                        compute_buf::write_i32(in_buf, compute_buf::RequantLayout::M, M);
                        compute_buf::write_i32(in_buf, compute_buf::RequantLayout::N, N);
                        compute_buf::write_i32(in_buf, compute_buf::RequantLayout::Z, Z);
                        break;
                    }
                    case CMP_RESID0:
                    case CMP_RESID1: {
                        const int8_t *x = (op == CMP_RESID0) ? resid0_x : resid1_x;
                        const int8_t *r = (op == CMP_RESID0) ? resid0_r : resid1_r;
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::ResidLayout::X + i, x[i]);
                            compute_buf::write_i8(in_buf, compute_buf::ResidLayout::R + i, r[i]);
                        }
                        break;
                    }
                    case CMP_LN0:
                    case CMP_LN1:
                    case CMP_FINAL_NORM: {
                        const int8_t *x = (op == CMP_LN0) ? ln0_x
                                           : (op == CMP_LN1) ? ln1_x
                                           : final_norm_x;
                        const int32_t *gamma = (op == CMP_LN0) ? ln0_gamma
                                             : (op == CMP_LN1) ? ln1_gamma
                                             : final_norm_gamma;
                        const int32_t eps = (op == CMP_LN0) ? ln0_eps
                                         : (op == CMP_LN1) ? ln1_eps
                                         : final_norm_eps;
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::LayerNormLayout::X + i, x[i]);
                            compute_buf::write_i32(in_buf, compute_buf::LayerNormLayout::GAMMA + (i * 4), gamma[i]);
                        }
                        compute_buf::write_i32(in_buf, compute_buf::LayerNormLayout::EPS, eps);
                        break;
                    }
                    case CMP_FFN_W1: {
                        for (int i = 0; i < D_MODEL; ++i) {
                            compute_buf::write_i8(in_buf, compute_buf::FfnW1Layout::X + i, ffn1_x[i]);
                        }
                        if (tile >= 0 && tile < NUM_W1_TILES) {
                            const int out_base = tile * D_TILE_W1;
                            for (int t = 0; t < D_TILE_W1; ++t) {
                                for (int i = 0; i < D_MODEL; ++i) {
                                    write_i4(in_buf, (compute_buf::FfnW1Layout::W * 2) + (t * D_MODEL) + i,
                                             ffn1_w[(out_base + t) * D_MODEL + i]);
                                }
                                compute_buf::write_i32(in_buf, compute_buf::FfnW1Layout::B + (t * 4), ffn1_b[out_base + t]);
                                compute_buf::write_i16(in_buf, compute_buf::FfnW1Layout::S + (t * 2), ffn1_s[out_base + t]);
                            }
                        }
                        break;
                    }
                    case CMP_FFN_ACT: {
                        for (int i = 0; i < D_FFN; ++i) {
                            compute_buf::write_i16(in_buf, compute_buf::FfnActLayout::X + (i * 2), ffn_act_in[i]);
                        }
                        break;
                    }
                    case CMP_FFN_W2: {
                        for (int i = 0; i < D_FFN; ++i) {
                            compute_buf::write_i16(in_buf, compute_buf::FfnW2Layout::X + (i * 2), ffn2_x[i]);
                        }
                        if (tile >= 0 && tile < NUM_W2_TILES) {
                            const int out_base = tile * D_TILE_W2;
                            for (int t = 0; t < D_TILE_W2; ++t) {
                                for (int i = 0; i < D_FFN; ++i) {
                                    write_i4(in_buf, (compute_buf::FfnW2Layout::W * 2) + (t * D_FFN) + i,
                                             ffn2_w[(out_base + t) * D_FFN + i]);
                                }
                                compute_buf::write_i32(in_buf, compute_buf::FfnW2Layout::B + (t * 4), ffn2_b[out_base + t]);
                                compute_buf::write_i16(in_buf, compute_buf::FfnW2Layout::S + (t * 2), ffn2_s[out_base + t]);
                            }
                        }
                        break;
                    }
                    default:
                        break;
                    }
                    print_buffer("in_buf (send)", in_buf, compute_buf::IN_BUF_BYTES);
                    print_in_buf_decoded(op, in_buf);
                }
                if (mem_pending == MemPending::Write) {
                    const ComputeOp op = decode_op(mem_op_latched);
                    print_buffer("out_buf (done)", out_buf, compute_buf::OUT_BUF_BYTES);
                    print_out_buf_decoded(op, out_buf);
                }
                mem_pending = MemPending::None;
            } else {
                --mem_timer;
            }
        }

        transformer_top(
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            dma_done,
            wl_ready,
            wl_instruction,
            wl_start,
            mem_transfer_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            in_buf,
            out_buf,
            head_ctx_ref,
            stream_ready,
            stream_start,
            stream_done,
            ctrl_mem,
            status_mem,
            irq_ps,
            dbg_state, 
            dbg_ctrl_mem,
            control_reg,
            irq_status_reg,
            irq_enable_reg,
            wq_base_addr,
            wk_base_addr,
            wv_base_addr,
            wo_base_addr,
            w1_base_addr,
            w2_base_addr,
            wq_head_stride,
            wk_head_stride,
            wv_head_stride,
            wo_tile_stride,
            w1_tile_stride,
            w2_tile_stride,
            dbg_compute_start,
            dbg_compute_instruction,
            dbg_compute_ready,
            dbg_compute_done,
            dbg_compute_state,
            dbg_req_instruction,
            dbg_req_op,
            dbg_req_layer,
            dbg_req_head,
            dbg_req_tile,
            dbg_mac_start,
            dbg_mac_ready,
            dbg_mac_complete,
            dbg_ctrl_reset_asserted,
            dbg_done,
            dbg_error
        );

        if (wl_start && dbg_state == S_HEAD_CONCAT) {
            seen_concat = true;
        }

        if (!mem_busy) {
            if (mem_read_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::Read;
                mem_op_latched = mem_op;
            } else if (mem_write_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::Write;
                mem_op_latched = mem_op;
            }
        }

        if (wl_start && !dma_busy) {
            wl_dma_request = true;
            wl_dma_address = compute_wl_address(wl_instruction, dbg_ctrl_mem);
            dma_busy  = true;
            dma_timer = DMA_LAT - 1;
        }

        const bool cntrl_start   = ((ctrl_shadow_control & CTRL_START_BIT) != 0);
        const bool cntrl_reset_n = ((ctrl_shadow_control & CTRL_RESETN_BIT) != 0);
        std::printf("%-8d %-6d %-6d %-6s 0x%08X %-6d 0x%08X %-6s 0x%08X %-6s %-6s %-13s | 0x%08X %-6s 0x%08X %-10s 0x%04X",
                    cycle,
                    cntrl_start ? 1 : 0,
                    cntrl_reset_n ? 1 : 0,
                    dash_or(dbg_ctrl_reset_asserted),
                    wl_instruction,
                    static_cast<int>(dbg_compute_state),
                    dbg_req_instruction,
                    dash_or(dbg_compute_start),
                    dbg_compute_instruction,
                    dash_or(dbg_compute_ready),
                    dash_or(dbg_compute_done),
                    state_name(dbg_state),
                    // CtrlMemSpace/StatusMemSpace info:
                    dbg_ctrl_mem.control,
                    irq_name(status_mem.irq_status),
                    dbg_ctrl_mem.irq_mask,
                    status_name(status_mem.status),
                    status_mem.error_code);
        for (int i = 0; i < NUM_HEADS; ++i) {
            char buf[128];
            const DmaFields head_fields = decode_wl_instruction(head_ctx_ref[i].wl_instruction);
            std::snprintf(buf, sizeof(buf), "%d:%-6s %-2s %-2s 0x%08X %-2s %-4s %-2s",
                          i,
                          phase_name(head_ctx_ref[i].phase),
                          dash_or(head_ctx_ref[i].compute_start),
                          dash_or(head_ctx_ref[i].compute_done),
                          head_ctx_ref[i].compute_op,
                          dash_or(head_ctx_ref[i].wl_start),
                          dma_name(head_fields.sel),
                          dash_or(head_ctx_ref[i].dma_done));
            std::printf(" %s", buf);
        }
        std::printf("\n");

        // Track the tail of the sequence: once we hit STREAM_OUT, watch for 4 idle cycles
        if (dbg_state == S_STREAM_OUT) {
            seen_stream_out = true;
            idle_after_stream = 0;
        } else if (seen_stream_out && dbg_state == S_IDLE) {
            idle_after_stream++;
        } else if (seen_stream_out) {
            idle_after_stream = 0;
        }

        // Launch head compute requests onto their dedicated lanes
        for (int i = 0; i < NUM_HEADS; ++i) {
            int lane = i % HEADS_PARALLEL;
            if (!head_ctx_ref[i].compute_start) {
                head_start_seen[i] = false;
            }
            if (head_ctx_ref[i].compute_start && !head_start_seen[i] && !head_lane_busy[lane]) {
                head_lane_busy[lane] = true;
                head_lane_timer[lane] = COMP_LAT - 1;
                head_lane_active_idx[lane] = i;
                head_start_seen[i] = true;
                ComputeOp launched_op = decode_op(head_ctx_ref[i].compute_op);
                if (launched_op == CMP_ATT_SCORES) seen_attn = true;
            }
            if (head_ctx_ref[i].wl_start && !head_dma_busy[lane]) {
                head_dma_busy[lane] = true;
                head_dma_timer[lane] = DMA_LAT - 1;
                head_dma_active_idx[lane] = i;
            }
        }

        if (stream_start) {
            stream_busy = true;
        }

        // Consume AXIS transfer on handshake
        if (axis_in_valid && axis_in_ready) {
            axis_sent++;
            axis_in_valid = false;
            axis_in_last  = false;
            if (axis_sent >= AXIS_BEATS) {
                axis_feed_done = true;
                axis_drive     = false;
            }
        }

        if (irq_interupt_flagged && (interupt_data & IRQ_INFER_DONE_BIT)) {
            seen_done = true;
            irq_interupt_flagged = false;
            interupt_data = 0;
            seen_irq_done = true;
        }
        else if (seen_done){
            post_done_cycles++;
            if (post_done_cycles >= 2) {
                seen_idle_after = true;
                seen_irq_done = false;
            }
        }

        if (!cntrl_start && seen_done && seen_idle_after && seen_stream_out && idle_after_stream >= 4) {
            break;
        }
    }

    bool ok = seen_stream_out && (idle_after_stream >= 4) && seen_attn && seen_concat;
    bool error_tests_ok = (test_errors_passed == 3) && (test_errors_failed == 0);
    
    if (!error_tests_ok) {
        std::fprintf(stderr, "ERROR: ControlMemInterface error tests: %d passed, %d failed (expected 3/0)\n",
                     test_errors_passed, test_errors_failed);
    }
    
    if (!ok) {
        if (!seen_stream_out) std::fprintf(stderr, "ERROR: STREAM_OUT state never reached\n");
        if (idle_after_stream < 4) std::fprintf(stderr, "ERROR: Did not remain in IDLE for 4 cycles after STREAM_OUT\n");
        if (!seen_attn)       std::fprintf(stderr, "ERROR: ATT_SCORES compute op never issued\n");
        if (!seen_concat)     std::fprintf(stderr, "ERROR: CONCAT DMA request never issued\n");
        return 1;
    }
    
    if (!error_tests_ok) {
        return 1;
    }

    std::printf("PASS: All ControlMemInterface error tests passed (%d/3)\n", test_errors_passed);
    std::printf("PASS: STREAM_OUT reached and FSM stayed IDLE for %d cycles after.\n",
                idle_after_stream);
    return 0;
}
