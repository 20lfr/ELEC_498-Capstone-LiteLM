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
        valueA[i] = static_cast<int8_t>(127);
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

void print_layer_norm_inputs(
    const int8_t x[D_MODEL],
    int32_t gamma,
    int32_t epsilon
) {
    std::printf("LayerNorm x[%d] (epsilon=%d):", D_MODEL, static_cast<int>(epsilon));
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(x[i]));
    }
    std::printf("\n");
    std::printf("LayerNorm gamma[%d]:", D_MODEL);
    for (int i = 0; i < D_MODEL; ++i) {
        std::printf(" %d", static_cast<int>(gamma));
    }
    std::printf("\n");
    std::printf("LayerNorm epsilon: %d\n", static_cast<int>(epsilon));
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
    bool printed_in_buf = false;
    bool printed_out_buf = false;

    init_inputs(valueA_mem, full_weights, full_bias);
    // Override LN input with varied values (including negatives).
    static const int8_t ln_x[D_MODEL] = { -64, -32, -8, -1, 1, 7, 31, 63 };
    for (int i = 0; i < D_MODEL; ++i) {
        valueA_mem[i] = ln_x[i];
    }
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
    steps.push_back({ComputeOp::CMP_LN0, 0});

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

    print_layer_norm_inputs(valueA_mem, 1, 1);

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
                                    compute_buf::OutProjLayout::ACT + i,
                                    valueA_mem[i]);
                            }

                            load_tile_weights(valueB_in, full_weights, mem_tile_idx);
                            for (int i = 0; i < D_MODEL * D_TILE_WO; ++i) {
                                compute_buf::write_i4(
                                    in_buf,
                                    (compute_buf::OutProjLayout::W * 2) + i,
                                    valueB_in[i]);
                            }

                            const int out_base = mem_tile_idx * D_TILE_WO;
                            for (int t = 0; t < D_TILE_WO; ++t) {
                                compute_buf::write_i32(
                                    in_buf,
                                    compute_buf::OutProjLayout::B + (t * 4),
                                    full_bias[out_base + t]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::RequantLayout::X + (i * 4), full_accum[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::M, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::N, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::Z, 0);
                            break;
                        }
                        case ComputeOp::CMP_REQUANT2: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::RequantLayout::X + (i * 4), ln0_out[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::M, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::N, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::Z, 0);
                            break;
                        }
                        case ComputeOp::CMP_REQUANT3: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::RequantLayout::X + (i * 4), ffn2_out_full[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::M, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::N, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::Z, 0);
                            break;
                        }
                        case ComputeOp::CMP_REQUANT4: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i32(in_buf, compute_buf::RequantLayout::X + (i * 4), ln1_out[i]);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::M, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::N, 1);
                            compute_buf::write_i32(in_buf, compute_buf::RequantLayout::Z, 0);
                            break;
                        }
                        case ComputeOp::CMP_RESID0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::ResidLayout::X + i, rq1_out[i]);
                                compute_buf::write_i8(in_buf, compute_buf::ResidLayout::R + i, valueA_mem[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_RESID1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::ResidLayout::X + i, rq3_out[i]);
                                compute_buf::write_i8(in_buf, compute_buf::ResidLayout::R + i, valueA_mem[i]);
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::LayerNormLayout::X + i, valueA_mem[i]);
                                compute_buf::write_i32(in_buf, compute_buf::LayerNormLayout::GAMMA + (i * 4), 1);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::LayerNormLayout::EPS, 1);
                            if (!printed_in_buf) {
                                print_buffer("in_buf (LN0 request)", in_buf, compute_buf::IN_BUF_BYTES);
                                printed_in_buf = true;
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::LayerNormLayout::X + i, resid1_out[i]);
                                compute_buf::write_i32(in_buf, compute_buf::LayerNormLayout::GAMMA + (i * 4), 1);
                            }
                            compute_buf::write_i32(in_buf, compute_buf::LayerNormLayout::EPS, 1);
                            break;
                        }
                        case ComputeOp::CMP_FFN_W1: {
                            const int out_base = mem_tile_idx * D_TILE_W1;
                            load_tile_weights_w1(ffn1_weights, ffn1_weights_full, mem_tile_idx);
                            for (int i = 0; i < D_MODEL; ++i) {
                                compute_buf::write_i8(in_buf, compute_buf::FfnW1Layout::X + i, head_requant_out[i]);
                            }
                            for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
                                compute_buf::write_i4(in_buf, (compute_buf::FfnW1Layout::W * 2) + i, ffn1_weights[i]);
                            }
                            for (int i = 0; i < D_TILE_W1; ++i) {
                                const int idx = out_base + i;
                                const int32_t b = (idx < D_MODEL) ? ffn1_bias_full[idx] : 0;
                                const int16_t s = (idx < D_MODEL) ? ffn1_scale_full[idx] : 0;
                                compute_buf::write_i32(in_buf, compute_buf::FfnW1Layout::B + (i * 4), b);
                                compute_buf::write_i16(in_buf, compute_buf::FfnW1Layout::S + (i * 2), s);
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_ACT: {
                            for (int i = 0; i < D_FFN; ++i) {
                                const int16_t v = (i < D_MODEL) ? ffn1_out_full[i] : 0;
                                compute_buf::write_i16(
                                    in_buf,
                                    compute_buf::FfnActLayout::X + (i * 2),
                                    v);
                            }
                            break;
                        }
                        case ComputeOp::CMP_FFN_W2: {
                            const int out_base = mem_tile_idx * D_TILE_W2;
                            load_tile_weights_w2(ffn2_weights, ffn2_weights_full, mem_tile_idx);
                            for (int i = 0; i < D_FFN; ++i) {
                                compute_buf::write_i16(in_buf, compute_buf::FfnW2Layout::X + (i * 2), ffn_act_out[i]);
                            }
                            for (int i = 0; i < D_FFN * D_TILE_W2; ++i) {
                                compute_buf::write_i4(in_buf, (compute_buf::FfnW2Layout::W * 2) + i, ffn2_weights[i]);
                            }
                            for (int i = 0; i < D_TILE_W2; ++i) {
                                const int idx = out_base + i;
                                const int32_t b = (idx < D_FFN) ? ffn2_bias_full[idx] : 0;
                                const int16_t s = (idx < D_FFN) ? ffn2_scale_full[idx] : 0;
                                compute_buf::write_i32(in_buf, compute_buf::FfnW2Layout::B + (i * 4), b);
                                compute_buf::write_i16(in_buf, compute_buf::FfnW2Layout::S + (i * 2), s);
                            }
                            break;
                        }
                        case ComputeOp::CMP_DEQUANT:
                        case ComputeOp::CMP_LOGITS:
                            break;
                        default:
                            break;
                    }
                    // print_buffer("in_buf", in_buf, compute_buf::IN_BUF_BYTES);
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
                                rq1_out[i] = compute_buf::read_i8(out_buf, compute_buf::RequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT2: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                head_requant_out[i] = compute_buf::read_i8(out_buf, compute_buf::RequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT3: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                rq3_out[i] = compute_buf::read_i8(out_buf, compute_buf::RequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_REQUANT4: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                rq4_out[i] = compute_buf::read_i8(out_buf, compute_buf::RequantLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_RESID0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                resid0_out[i] = compute_buf::read_i8(out_buf, compute_buf::ResidLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_RESID1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                resid1_out[i] = compute_buf::read_i8(out_buf, compute_buf::ResidLayout::X + i);
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN0: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                ln0_out[i] = compute_buf::read_i32(out_buf, compute_buf::LayerNormLayout::X + (i * 4));
                            }
                            break;
                        }
                        case ComputeOp::CMP_LN1: {
                            for (int i = 0; i < D_MODEL; ++i) {
                                ln1_out[i] = compute_buf::read_i32(out_buf, compute_buf::LayerNormLayout::X + (i * 4));
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
                                ffn_act_out[i] = compute_buf::read_i16(out_buf, compute_buf::FfnActLayout::X + (i * 2));
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

        if (compute_start && compute_ready) {
            print_buffer("in_buf (send)", in_buf, compute_buf::IN_BUF_BYTES);
        }

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
                    if (!printed_out_buf && steps[step_idx].op == ComputeOp::CMP_LN0) {
                        print_buffer("out_buf (LN0 done)", out_buf, compute_buf::OUT_BUF_BYTES);
                        printed_out_buf = true;
                    }
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

    std::printf("compute_controller_layer_norm_tb: PASS\n");
    return 0;
}
