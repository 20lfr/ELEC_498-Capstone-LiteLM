#include "compute_controller.hpp"

#include <cstdio>
#include <cstdint>
#include <cstring>
#include <algorithm>
#include <vector>

namespace {

uint32_t make_instruction(ComputeOp op, uint8_t layer, int8_t head, int8_t tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(layer) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(head)) << 16)
        | (static_cast<uint32_t>(static_cast<uint8_t>(tile)) << 24);
}

void init_inputs(
    int8_t valueA[D_MODEL],
    int4_t full_weights[D_MODEL * D_MODEL],
    int32_t full_bias[D_MODEL]
) {
    for (int i = 0; i < D_MODEL; ++i) {
        const int v = (i * 23 + 11) % 101; // 0..100
        valueA[i] = static_cast<int8_t>((i & 1) ? -v : v);
        full_bias[i] = 7;
    }
    for (int out = 0; out < D_MODEL; ++out) {
        for (int i = 0; i < D_MODEL; ++i) {
            full_weights[out * D_MODEL + i] = int4_t(7);
        }
    }
}

void expected_out_proj_full(
    const int8_t valueA[D_MODEL],
    const int4_t full_weights[D_MODEL * D_MODEL],
    const int32_t full_bias[D_MODEL],
    int32_t expected[D_MODEL]
) {
    for (int out = 0; out < D_MODEL; ++out) {
        int32_t acc = 0;
        for (int i = 0; i < D_MODEL; ++i) {
            const int4_t w = full_weights[out * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        expected[out] = acc + static_cast<int32_t>(full_bias[out]);
    }
}

void choose_requant_params(const int32_t *x, int len, int32_t &M, int32_t &N) {
    int32_t max_abs = 0;
    for (int i = 0; i < len; ++i) {
        const int32_t v = x[i];
        const int32_t a = (v < 0) ? -v : v;
        if (a > max_abs) {
            max_abs = a;
        }
    }
    M = 1;
    N = 0;
    if (max_abs == 0) {
        return;
    }
    // Keep outputs within int8 range with a little margin.
    const int32_t target = 120;
    while (N < 31 && (max_abs >> N) > target) {
        ++N;
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
    case CMP_REQUANT2:     return "RQ2";
    case CMP_CONCAT:       return "CONCAT";
    case CMP_OUT_PROJ:     return "OUT_PROJ";
    case CMP_REQUANT1:     return "RQ1";
    case CMP_RESID0:       return "RESID0";
    case CMP_LN0:          return "LN0";
    case CMP_REQUANT3:     return "RQ3";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_REQUANT4:     return "RQ4";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN1:          return "LN1";
    case CMP_DEQUANT:      return "DEQUANT";
    case CMP_LOGITS:       return "LOGITS";
    default:               return "UNK";
    }
}

void print_valueA(const int8_t valueA[D_MODEL]) {
    std::printf("valueA[%d]:", D_MODEL);
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(valueA[i]));
    }
    std::printf("\n");
}

void print_bias(const int32_t full_bias[D_MODEL]) {
    std::printf("bias[%d]:", D_MODEL);
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(full_bias[i]));
    }
    std::printf("\n");
}

void load_tile_weights(
    int4_t tile_weights[D_MODEL * D_TILE_WO],
    const int4_t full_weights[D_MODEL * D_MODEL],
    int tile_idx
) {
    const int out_base = tile_idx * D_TILE_WO;
    for (int t = 0; t < D_TILE_WO; ++t) {
        const int out = out_base + t;
        for (int i = 0; i < D_MODEL; ++i) {
            tile_weights[t * D_MODEL + i] = full_weights[out * D_MODEL + i];
        }
    }
}

void load_tile_weights_w1(
    int4_t tile_weights[D_MODEL * D_TILE_W1],
    const int4_t full_weights[D_MODEL * D_MODEL],
    int tile_idx
) {
    const int out_base = tile_idx * D_TILE_W1;
    for (int t = 0; t < D_TILE_W1; ++t) {
        const int out = out_base + t;
        for (int i = 0; i < D_MODEL; ++i) {
            tile_weights[t * D_MODEL + i] = full_weights[out * D_MODEL + i];
        }
    }
}

void load_tile_weights_w2(
    int4_t tile_weights[D_FFN * D_TILE_W2],
    const int4_t full_weights[D_FFN * D_FFN],
    int tile_idx
) {
    const int out_base = tile_idx * D_TILE_W2;
    for (int t = 0; t < D_TILE_W2; ++t) {
        const int out = out_base + t;
        for (int i = 0; i < D_FFN; ++i) {
            tile_weights[t * D_FFN + i] = full_weights[out * D_FFN + i];
        }
    }
}

void print_full_weights(const int4_t full_weights[D_MODEL * D_MODEL]) {
    std::printf("weights[%d][%d]:\n", D_MODEL, D_MODEL);
    for (int out = 0; out < D_MODEL; ++out) {
        std::printf("  out %d:", out);
        for (int i = 0; i < D_MODEL; ++i) {
            const int idx = out * D_MODEL + i;
            std::printf(" %d", static_cast<int>(full_weights[idx]));
        }
        std::printf("\n");
    }
}

void print_buffer(const char *label, const uint8_t *buf, int size) {
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

void print_ln_in_buf(const uint8_t *in_buf) {
    std::printf("LN in_buf (decoded):\n  X:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INLayerNormLayout::X + i)));
    }
    std::printf("\n  GAMMA:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4))));
    }
    const int32_t eps = compute_buf::read_i32(in_buf, compute_buf::INLayerNormLayout::EPS);
    std::printf("\n  EPS: %d\n", static_cast<int>(eps));
}

void print_ln_out_buf(const uint8_t *out_buf) {
    std::printf("LN out_buf (decoded):\n  Y:");
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(compute_buf::read_i32(out_buf, compute_buf::INLayerNormLayout::X + (i * 4))));
    }
    std::printf("\n");
}

void print_in_buf_decoded(ComputeOp op, const uint8_t *in_buf) {
    switch (op) {
    case ComputeOp::CMP_OUT_PROJ: {
        std::printf("OUT_PROJ in_buf (decoded):\n  ACT:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INOutProjLayout::ACT + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INOutProjLayout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_WO; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INOutProjLayout::B + (i * 4))));
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
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4))));
        }
        const int32_t M = compute_buf::read_i32(in_buf, compute_buf::INRequantLayout::M);
        const int32_t N = compute_buf::read_i32(in_buf, compute_buf::INRequantLayout::N);
        std::printf("\n  M: %d\n  N: %d\n", static_cast<int>(M), static_cast<int>(N));
        break;
    }
    case ComputeOp::CMP_RESID0:
    case ComputeOp::CMP_RESID1: {
        std::printf("RESID in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::X + i)));
        }
        std::printf("\n  R:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INResidLayout::R + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LN0:
    case ComputeOp::CMP_LN1:
        print_ln_in_buf(in_buf);
        break;
    case ComputeOp::CMP_FFN_W1: {
        std::printf("FFN_W1 in_buf (decoded):\n  X:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(in_buf, compute_buf::INFfnW1Layout::X + i)));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INFfnW1Layout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INFfnW1Layout::B + (i * 4))));
        }
        std::printf("\n  S:");
        for (int i = 0; i < D_TILE_W1; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnW1Layout::S + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_ACT: {
        std::printf("FFN_ACT in_buf (decoded):\n  GATE:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::GATE + (i * 2))));
        }
        std::printf("\n  UP:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnActLayout::UP + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_FFN_W2: {
        std::printf("FFN_W2 in_buf (decoded):\n  X:");
        for (int i = 0; i < D_FFN; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnW2Layout::X + (i * 2))));
        }
        std::printf("\n  W:");
        for (int i = 0; i < D_FFN * D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i4(in_buf, (compute_buf::INFfnW2Layout::W * 2) + i)));
        }
        std::printf("\n  B:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i32(in_buf, compute_buf::INFfnW2Layout::B + (i * 4))));
        }
        std::printf("\n  S:");
        for (int i = 0; i < D_TILE_W2; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(in_buf, compute_buf::INFfnW2Layout::S + (i * 2))));
        }
        std::printf("\n");
        break;
    }
    default:
        std::printf("in_buf (decoded): <no decoder>\n");
        break;
    }
}

void print_out_buf_decoded(ComputeOp op, const uint8_t *out_buf) {
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
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, compute_buf::INRequantLayout::X + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_RESID0:
    case ComputeOp::CMP_RESID1: {
        std::printf("RESID out_buf (decoded):\n  Y:");
        for (int i = 0; i < D_MODEL; ++i) {
            std::printf(" %d", static_cast<int>(compute_buf::read_i8(out_buf, compute_buf::INResidLayout::X + i)));
        }
        std::printf("\n");
        break;
    }
    case ComputeOp::CMP_LN0:
    case ComputeOp::CMP_LN1:
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
            std::printf(" %d", static_cast<int>(compute_buf::read_i16(out_buf, compute_buf::INFfnActLayout::OUT + (i * 2))));
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

} // namespace

int main() {
    const int MAX_CYCLES = 400;

    bool compute_ready = false;
    bool compute_done = false;
    bool error = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    bool mem_transfer_done = false;
    uint32_t mem_op = 0;

    int8_t valueA_mem[D_MODEL] = {};
    int4_t valueB_in[D_MODEL * D_TILE_WO] = {};
    int4_t full_weights[D_MODEL * D_MODEL] = {};
    int32_t full_bias[D_MODEL] = {};
    int4_t ffn1_weights[D_MODEL * D_TILE_W1] = {};
    int16_t ffn1_out[D_TILE_W1] = {};
    int16_t ffn1_out_full[D_MODEL] = {};
    int4_t ffn1_weights_full[D_MODEL * D_MODEL] = {};
    int32_t ffn1_bias_full[D_MODEL] = {};
    int16_t ffn1_scale_full[D_MODEL] = {};
    int16_t ffn_act_out[D_FFN] = {};
    int4_t ffn2_weights[D_FFN * D_TILE_W2] = {};
    int32_t ffn2_out[D_TILE_W2] = {};
    int4_t ffn2_weights_full[D_FFN * D_FFN] = {};
    int32_t ffn2_bias_full[D_FFN] = {};
    int16_t ffn2_scale_full[D_FFN] = {};
    int32_t ffn2_out_full[D_MODEL] = {};
    int8_t rq1_out[D_MODEL] = {};
    int8_t head_requant_out[D_MODEL] = {};
    int8_t rq3_out[D_MODEL] = {};
    int8_t rq4_out[D_MODEL] = {};
    int8_t resid0_out[D_MODEL] = {};
    int8_t resid1_out[D_MODEL] = {};
    int32_t ln0_out[D_MODEL] = {};
    int32_t ln1_out[D_MODEL] = {};
    int32_t requant_x32[D_MODEL] = {};
    int32_t rq1_in[D_MODEL] = {};
    int32_t rq2_in[D_MODEL] = {};
    int32_t rq3_in[D_MODEL] = {};
    int32_t rq4_in[D_MODEL] = {};
    int8_t resid0_x[D_MODEL] = {};
    int8_t resid0_r[D_MODEL] = {};
    int8_t resid1_x[D_MODEL] = {};
    int8_t resid1_r[D_MODEL] = {};
    int8_t ln0_x[D_MODEL] = {};
    int8_t ln1_x[D_MODEL] = {};
    int32_t ln0_gamma[D_MODEL] = {};
    int32_t ln1_gamma[D_MODEL] = {};
    int32_t ln0_eps = 0;
    int32_t ln1_eps = 0;
    int8_t ffn1_x[D_MODEL] = {};
    int16_t ffn_gate_in[D_FFN] = {};
    int16_t ffn_up_in[D_FFN] = {};
    int16_t ffn2_x[D_FFN] = {};
    int32_t rq1_M = 1;
    int32_t rq1_N = 0;
    int32_t rq2_M = 1;
    int32_t rq2_N = 0;
    int32_t rq3_M = 1;
    int32_t rq3_N = 0;
    int32_t rq4_M = 1;
    int32_t rq4_N = 0;
    uint8_t in_buf[compute_buf::IN_BUF_BYTES] = {};
    uint8_t out_buf[compute_buf::OUT_BUF_BYTES] = {};
    ComputeState dbg_state = ComputeState::IDLE;
    uint32_t dbg_req_instruction = 0;
    uint8_t dbg_req_op = 0;
    uint8_t dbg_req_layer = 0;
    uint8_t dbg_req_head = 0;
    uint8_t dbg_req_tile = 0;
    bool dbg_mac_start = false;
    bool dbg_mac_ready = false;
    bool dbg_mac_complete = false;
    int32_t expected_full[D_MODEL] = {};
    int32_t full_accum[D_MODEL] = {};

    const int MEM_LAT = 2;
    bool mem_busy = false;
    int mem_timer = 0;
    enum class MemPending { NONE, READ, WRITE };
    MemPending mem_pending = MemPending::NONE;
    int mem_tile_idx = -1;
    bool writeback_pending = false;
    int mem_done_hold = 0;

    init_inputs(valueA_mem, full_weights, full_bias);
    for (int i = 0; i < D_MODEL * D_MODEL; ++i) {
        ffn1_weights_full[i] = int4_t(3);
    }
    for (int i = 0; i < D_MODEL; ++i) {
        ffn1_bias_full[i] = 5;
        ffn1_scale_full[i] = 16384; // 0.5 in Q1.15
    }
    for (int i = 0; i < D_FFN * D_FFN; ++i) {
        ffn2_weights_full[i] = int4_t(2);
    }
    for (int i = 0; i < D_FFN; ++i) {
        ffn2_bias_full[i] = 4;
        ffn2_scale_full[i] = 16384; // 0.5 in Q1.15
    }
    for (int i = 0; i < D_MODEL; ++i) {
        rq1_in[i] = (i * 7) - 15;
        rq2_in[i] = (i * 5) + 9;
        rq3_in[i] = (i * 3) - 7;
        rq4_in[i] = (i * 11) - 20;
        resid0_x[i] = static_cast<int8_t>((i & 1) ? -(i + 3) : (i + 2));
        resid0_r[i] = static_cast<int8_t>((i & 1) ? (i + 1) : -(i + 2));
        resid1_x[i] = static_cast<int8_t>((i & 1) ? -(i + 5) : (i + 4));
        resid1_r[i] = static_cast<int8_t>((i & 1) ? (i + 3) : -(i + 1));
        ln0_x[i] = static_cast<int8_t>((i & 1) ? -(i + 2) : (i + 1));
        ln1_x[i] = static_cast<int8_t>((i & 1) ? -(i + 4) : (i + 3));
        ln0_gamma[i] = (i & 1) ? 2 : 1;
        ln1_gamma[i] = (i & 1) ? 3 : 1;
        ffn1_x[i] = static_cast<int8_t>((i & 1) ? -(i + 1) : (i + 1));
    }
    ln0_eps = 2;
    ln1_eps = 3;
    for (int i = 0; i < D_FFN; ++i) {
        ffn_gate_in[i] = static_cast<int16_t>((i * 13) - 40);
        ffn_up_in[i] = static_cast<int16_t>((i * 7) - 20);
        ffn2_x[i] = static_cast<int16_t>((i * 9) - 30);
    }
    choose_requant_params(rq1_in, D_MODEL, rq1_M, rq1_N);
    choose_requant_params(rq2_in, D_MODEL, rq2_M, rq2_N);
    choose_requant_params(rq3_in, D_MODEL, rq3_M, rq3_N);
    choose_requant_params(rq4_in, D_MODEL, rq4_M, rq4_N);
    expected_out_proj_full(valueA_mem, full_weights, full_bias, expected_full);
    std::printf("D_MODEL=%d D_TILE_WO=%d NUM_WO_TILES=%d\n", D_MODEL, D_TILE_WO, NUM_WO_TILES);
    print_valueA(valueA_mem);
    print_bias(full_bias);
    print_full_weights(full_weights);

    struct Step {
        ComputeOp op;
        int tile;
    };
    std::vector<Step> steps;
    for (int t = 0; t < NUM_WO_TILES; ++t) {
        steps.push_back({ComputeOp::CMP_OUT_PROJ, t});
    }
    steps.push_back({ComputeOp::CMP_REQUANT1, 0});
    steps.push_back({ComputeOp::CMP_RESID0, 0});
    steps.push_back({ComputeOp::CMP_LN0, 0});
    steps.push_back({ComputeOp::CMP_REQUANT2, 0});
    for (int t = 0; t < NUM_W1_TILES; ++t) {
        steps.push_back({ComputeOp::CMP_FFN_W1, t});
    }
    steps.push_back({ComputeOp::CMP_FFN_ACT, 0});
    for (int t = 0; t < NUM_W2_TILES; ++t) {
        steps.push_back({ComputeOp::CMP_FFN_W2, t});
    }
    steps.push_back({ComputeOp::CMP_REQUANT3, 0});
    steps.push_back({ComputeOp::CMP_RESID1, 0});
    steps.push_back({ComputeOp::CMP_LN1, 0});
    steps.push_back({ComputeOp::CMP_REQUANT4, 0});

    enum class TbState {
        RESET,
        WAIT_READY,
        WAIT_DONE,
        DONE
    };

    TbState state = TbState::RESET;
    uint32_t compute_instruction = 0;
    bool compute_start = false;
    int tile_idx = 0;
    size_t step_idx = 0;

    std::printf("%-6s %-5s %-5s %-5s %-5s %-6s %-6s %-6s %-6s %-10s %-10s %-5s %-5s %-5s %-5s %-7s %-10s %-8s %-5s %-5s %-5s %-5s %-5s %-5s Acc[0:%d]\n",
                "Cycle", "Rst", "Start", "Ready", "Done", "Err",
                "MRead", "MWrite", "MDone", "MOp", "Instr", "Op", "Layer", "Head", "Tile",
                "State", "ReqInstr", "ReqOp", "ReqL", "ReqH", "ReqT",
                "MacS", "MacR", "MacC",
                D_MODEL - 1);

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset = (cycle < 2);

        mem_transfer_done = false;
        if (mem_done_hold > 0) {
            mem_transfer_done = true;
            --mem_done_hold;
        }
        if (mem_busy) {
            if (mem_timer == 0) {
                mem_transfer_done = true;
                mem_done_hold = 2;
                mem_busy = false;
                if (mem_pending == MemPending::READ) {
                    std::memset(in_buf, 0, sizeof(in_buf));
                    const ComputeOp mem_op_code = static_cast<ComputeOp>(mem_op & 0xFFu);
                    switch (mem_op_code) {
                        case ComputeOp::CMP_OUT_PROJ: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(
                                    in_buf,
                                    compute_buf::INOutProjLayout::ACT + i,
                                    valueA_mem[i]);
                            }

                            load_tile_weights(valueB_in, full_weights, mem_tile_idx);
                            for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
                                compute_buf::write_i4(
                                    in_buf,
                                    (compute_buf::INOutProjLayout::W * 2) + i,
                                    valueB_in[i]);
                            }

                            const int out_base = mem_tile_idx * D_TILE_WO;
                            for (int t = 0; t < D_TILE_WO; ++t) {
                                compute_buf::write_i32(
                                    in_buf,
                                    compute_buf::INOutProjLayout::B + (t * 4),
                                    full_bias[out_base + t]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4), rq1_in[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::M, rq1_M);
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::N, rq1_N);
                            break;
                        }
                        case ComputeOp::CMP_REQUANT2: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4), rq2_in[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::M, rq2_M);
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::N, rq2_N);
                            break;
                        }
                        case ComputeOp::CMP_REQUANT3: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4), rq3_in[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::M, rq3_M);
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::N, rq3_N);
                            break;
                        }
                        case ComputeOp::CMP_REQUANT4: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::X + (i * 4), rq4_in[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::M, rq4_M);
                            compute_buf::write_i32(in_buf, compute_buf::INRequantLayout::N, rq4_N);
                            break;
                        }
                        case ComputeOp::CMP_RESID0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::X + i, resid0_x[i]);
                                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::R + i, resid0_r[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_RESID1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::X + i, resid1_x[i]);
                                compute_buf::write_i8(in_buf, compute_buf::INResidLayout::R + i, resid1_r[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::INLayerNormLayout::X + i, ln0_x[i]);
                                compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), ln0_gamma[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::EPS, ln0_eps);
                            break;
                        }
                        case ComputeOp::CMP_LN1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::INLayerNormLayout::X + i, ln1_x[i]);
                                compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::GAMMA + (i * 4), ln1_gamma[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::INLayerNormLayout::EPS, ln1_eps);
                            break;
                        }
                        case ComputeOp::CMP_FFN_W1: {
                            const int out_base = mem_tile_idx * D_TILE_W1;
                            load_tile_weights_w1(ffn1_weights, ffn1_weights_full, mem_tile_idx);
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::INFfnW1Layout::X + i, ffn1_x[i]);
                            }
                            for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
                                compute_buf::write_i4(in_buf, (compute_buf::INFfnW1Layout::W * 2) + i, ffn1_weights[i]);
                            }
                            for (int i = 0; i < D_TILE_W1; ++i) {
                                const int idx = out_base + i;
                                const int32_t b = (idx < D_MODEL) ? ffn1_bias_full[idx] : 0;
                                const int16_t s = (idx < D_MODEL) ? ffn1_scale_full[idx] : 0;
                                compute_buf::write_i32(in_buf, compute_buf::INFfnW1Layout::B + (i * 4), b);
                                compute_buf::write_i16(in_buf, compute_buf::INFfnW1Layout::S + (i * 2), s);
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_ACT: {
                            for (int i = 0; i < D_FFN; ++i) {
                                compute_buf::write_i16(
                                    in_buf,
                                    compute_buf::INFfnActLayout::GATE + (i * 2),
                                    ffn_gate_in[i]);
                                compute_buf::write_i16(
                                    in_buf,
                                    compute_buf::INFfnActLayout::UP + (i * 2),
                                    ffn_up_in[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_W2: {
                            const int out_base = mem_tile_idx * D_TILE_W2;
                            load_tile_weights_w2(ffn2_weights, ffn2_weights_full, mem_tile_idx);
                            for (int i = 0; i < D_FFN; ++i) {
                                compute_buf::write_i16(in_buf, compute_buf::INFfnW2Layout::X + (i * 2), ffn2_x[i]);
                            }
                            for (int i = 0; i < D_FFN * D_TILE_W2; ++i) {
                                compute_buf::write_i4(in_buf, (compute_buf::INFfnW2Layout::W * 2) + i, ffn2_weights[i]);
                            }
                            for (int i = 0; i < D_TILE_W2; ++i) {
                                const int idx = out_base + i;
                                const int32_t b = (idx < D_FFN) ? ffn2_bias_full[idx] : 0;
                                const int16_t s = (idx < D_FFN) ? ffn2_scale_full[idx] : 0;
                                compute_buf::write_i32(in_buf, compute_buf::INFfnW2Layout::B + (i * 4), b);
                                compute_buf::write_i16(in_buf, compute_buf::INFfnW2Layout::S + (i * 2), s);
                            }
                            break;
                        }
                        case ComputeOp::CMP_DEQUANT:
                        case ComputeOp::CMP_LOGITS:
                            break;
                        default:
                            break;
                    }
                    print_buffer("in_buf (send)", in_buf, compute_buf::IN_BUF_BYTES);
                    print_in_buf_decoded(mem_op_code, in_buf);
                } else if (mem_pending == MemPending::WRITE) {
                    const ComputeOp mem_op_code = static_cast<ComputeOp>(mem_op & 0xFFu);
                    switch (mem_op_code) {
                        case ComputeOp::CMP_OUT_PROJ: {
                            for (int t = 0; t < D_TILE_WO; ++t) {
                                const int out = mem_tile_idx * D_TILE_WO + t;
                                full_accum[out] = compute_buf::read_i32(out_buf, t * 4);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                rq1_out[i] = compute_buf::read_i8(out_buf, compute_buf::INRequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT2: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                head_requant_out[i] = compute_buf::read_i8(out_buf, compute_buf::INRequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT3: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                rq3_out[i] = compute_buf::read_i8(out_buf, compute_buf::INRequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT4: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                rq4_out[i] = compute_buf::read_i8(out_buf, compute_buf::INRequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_RESID0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                resid0_out[i] = compute_buf::read_i8(out_buf, compute_buf::INResidLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_RESID1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                resid1_out[i] = compute_buf::read_i8(out_buf, compute_buf::INResidLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                ln0_out[i] = compute_buf::read_i32(out_buf, compute_buf::INLayerNormLayout::X + (i * 4));
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                ln1_out[i] = compute_buf::read_i32(out_buf, compute_buf::INLayerNormLayout::X + (i * 4));
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_W1: {
                            for (int i = 0; i < D_TILE_W1; ++i) {
                                ffn1_out[i] = compute_buf::read_i16(out_buf, i * 2);
                            }
                            for (int i = 0; i < D_TILE_W1; ++i) {
                                const int idx = mem_tile_idx * D_TILE_W1 + i;
                                if (idx < D_MODEL) {
                                    ffn1_out_full[idx] = ffn1_out[i];
                                }
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_ACT: {
                            for (int i = 0; i < D_FFN; ++i) {
                                ffn_act_out[i] = compute_buf::read_i16(out_buf, compute_buf::INFfnActLayout::OUT + (i * 2));
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_W2: {
                            for (int i = 0; i < D_TILE_W2; ++i) {
                                ffn2_out[i] = compute_buf::read_i32(out_buf, i * 4);
                            }
                            for (int i = 0; i < D_TILE_W2; ++i) {
                                const int idx = mem_tile_idx * D_TILE_W2 + i;
                                if (idx < D_MODEL) {
                                    ffn2_out_full[idx] = ffn2_out[i];
                                }
                            }
                            break;
                        }
                        default:
                            break;
                    }
                    // print_buffer("out_buf", out_buf, compute_buf::OUT_BUF_BYTES);
                    writeback_pending = false;
                }
                mem_pending = MemPending::NONE;
                mem_tile_idx = -1;
            } else {
                --mem_timer;
            }
        }

        const uint8_t op_field_pre = static_cast<uint8_t>(compute_instruction & 0xFFu);
        const ComputeOp op_pre = static_cast<ComputeOp>(op_field_pre);

        (void)op_pre;

        ControlMemSpace ctrl_mem{};
        ctrl_mem.control = reset ? 0u : CTRL_RESETN_BIT;

        compute_controller(
            ctrl_mem,
            compute_start,
            compute_instruction,
            compute_ready,
            compute_done,
            mem_transfer_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            in_buf,
            out_buf,
            dbg_state,
            dbg_req_instruction,
            dbg_req_op,
            dbg_req_layer,
            dbg_req_head,
            dbg_req_tile,
            dbg_mac_start,
            dbg_mac_ready,
            dbg_mac_complete,
            error);

        if (compute_done) {
            print_buffer("out_buf (done)", out_buf, compute_buf::OUT_BUF_BYTES);
            print_out_buf_decoded(op_pre, out_buf);
        }

        const uint8_t op_field = static_cast<uint8_t>(compute_instruction & 0xFFu);
        const uint8_t layer_field = static_cast<uint8_t>((compute_instruction >> 8) & 0xFFu);
        const int8_t head_field = static_cast<int8_t>((compute_instruction >> 16) & 0xFFu);
        const int8_t tile_field = static_cast<int8_t>((compute_instruction >> 24) & 0xFFu);

        std::printf("%-6d %-5d %-5d %-5d %-5d %-6d %-6d %-6d %-6d %-10s 0x%08x %-10s %-5d %-5d %-5d %-7d 0x%08x %-8s %-5d %-5d %-5d %-5d %-5d %-5d",
                    cycle,
                    reset ? 1 : 0,
                    compute_start ? 1 : 0,
                    compute_ready ? 1 : 0,
                    compute_done ? 1 : 0,
                    error ? 1 : 0,
                    mem_read_request ? 1 : 0,
                    mem_write_request ? 1 : 0,
                    mem_transfer_done ? 1 : 0,
                    op_name(static_cast<ComputeOp>(mem_op & 0xFFu)),
                    compute_instruction,
                    op_name(static_cast<ComputeOp>(op_field)),
                    static_cast<int>(layer_field),
                    static_cast<int>(head_field),
                    static_cast<int>(tile_field),
                    static_cast<int>(dbg_state),
                    dbg_req_instruction,
                    op_name(static_cast<ComputeOp>(dbg_req_op)),
                    static_cast<int>(dbg_req_layer),
                    static_cast<int>(static_cast<int8_t>(dbg_req_head)),
                    static_cast<int>(static_cast<int8_t>(dbg_req_tile)),
                    dbg_mac_start ? 1 : 0,
                    dbg_mac_ready ? 1 : 0,
                    dbg_mac_complete ? 1 : 0);

        // for (int out = 0; out < D_MODEL; ++out) {
        //     std::printf(" %d", static_cast<int>(full_accum[out]));
        // }
        std::printf("\n");

        if (!mem_busy) {
            if (mem_read_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::READ;
                mem_tile_idx = tile_idx;
            } else if (mem_write_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::WRITE;
                mem_tile_idx = tile_idx;
                writeback_pending = true;
            }
        }

        compute_start = false;
        if (reset) {
            mem_busy = false;
            mem_timer = 0;
            mem_pending = MemPending::NONE;
            mem_tile_idx = -1;
            writeback_pending = false;
            state = TbState::RESET;
            continue;
        }

        switch (state) {
            case TbState::RESET: {
                if (compute_ready && !steps.empty()) {
                    step_idx = 0;
                    tile_idx = steps[step_idx].tile;
                    compute_instruction = make_instruction(steps[step_idx].op, 1, -1, tile_idx);
                    compute_start = true;
                    state = TbState::WAIT_DONE;
                }
                break;
            }
            case TbState::WAIT_DONE: {
                if (compute_done) {
                    if (steps[step_idx].op == ComputeOp::CMP_OUT_PROJ) {
                        for (int t = 0; t < D_TILE_WO; ++t) {
                            const int out = tile_idx * D_TILE_WO + t;
                            const int32_t got = compute_buf::read_i32(out_buf, t * 4);
                            if (got != expected_full[out]) {
                                std::fprintf(stderr,
                                             "CMP_OUT_PROJ failed at out %d: got %d expected %d\n",
                                             out, static_cast<int>(got),
                                             static_cast<int>(expected_full[out]));
                                return 1;
                            }
                        }
                    }
                    if (error) {
                        std::fprintf(stderr, "Op %s asserted error unexpectedly.\n",
                                     op_name(steps[step_idx].op));
                        return 1;
                    }
                    ++step_idx;
                    if (step_idx >= steps.size()) {
                        state = TbState::DONE;
                    } else {
                        state = TbState::WAIT_READY;
                    }
                }
                break;
            }
            case TbState::WAIT_READY: {
                if (compute_ready) {
                    tile_idx = steps[step_idx].tile;
                    compute_instruction = make_instruction(steps[step_idx].op, 1, -1, tile_idx);
                    compute_start = true;
                    state = TbState::WAIT_DONE;
                }
                break;
            }
            case TbState::DONE: {
                break;
            }
        }

        if (state == TbState::DONE) {
            break;
        }
    }

    if (state != TbState::DONE) {
        std::fprintf(stderr, "Testbench timed out before completion.\n");
        return 1;
    }

    std::printf("compute_controller_tb: PASS\n");
    return 0;
}
