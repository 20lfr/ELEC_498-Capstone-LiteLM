#include "compute_controller.hpp"

#include <cstdio>
#include <cstdint>
#include <cstring>

namespace {

uint32_t make_instruction(ComputeOp op, uint8_t layer, int8_t head, int8_t tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(layer) << 8)
        | (static_cast<uint32_t>(static_cast<uint8_t>(head)) << 16)
        | (static_cast<uint32_t>(static_cast<uint8_t>(tile)) << 24);
}

void init_inputs(
    int8_t valueA[D_MODEL],
    int4_t full_weights[D_MODEL * D_MODEL]
) {
    for (int i = 0; i < D_MODEL; ++i) {
        valueA[i] = static_cast<int8_t>(i + 1);
    }
    for (int out = 0; out < D_MODEL; ++out) {
        for (int i = 0; i < D_MODEL; ++i) {
            const int sign = (out % 2 == 0) ? 1 : -1;
            full_weights[out * D_MODEL + i] = int4_t(sign);
        }
    }
}

void expected_out_proj_full(
    const int8_t valueA[D_MODEL],
    const int4_t full_weights[D_MODEL * D_MODEL],
    int32_t expected[D_MODEL]
) {
    for (int out = 0; out < D_MODEL; ++out) {
        int32_t acc = 0;
        for (int i = 0; i < D_MODEL; ++i) {
            const int4_t w = full_weights[out * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        expected[out] = acc;
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
    case CMP_HEAD_REQUANT: return "HEAD_RQ";
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
    case CMP_LN0_SUM:      return "LN0_SUM";
    case CMP_LN0_SUMSQ:    return "LN0_Q";
    case CMP_LN0_MEAN:     return "LN0_MEAN";
    case CMP_LN0_EYY:      return "LN0_EYY";
    case CMP_LN0_VAR:      return "LN0_VAR";
    case CMP_LN0_VAR_EPS:  return "LN0_VEPS";
    case CMP_LN0_INV_STD:  return "LN0_INV";
    case CMP_LN0_NORM:     return "LN0_NORM";
    case CMP_LN0_SCALE:    return "LN0_SCL";
    case CMP_LN0_SHIFT:    return "LN0_SHF";
    case CMP_LN1_SUM:      return "LN1_SUM";
    case CMP_LN1_SUMSQ:    return "LN1_Q";
    case CMP_LN1_MEAN:     return "LN1_MEAN";
    case CMP_LN1_EYY:      return "LN1_EYY";
    case CMP_LN1_VAR:      return "LN1_VAR";
    case CMP_LN1_VAR_EPS:  return "LN1_VEPS";
    case CMP_LN1_INV_STD:  return "LN1_INV";
    case CMP_LN1_NORM:     return "LN1_NORM";
    case CMP_LN1_SCALE:    return "LN1_SCL";
    case CMP_LN1_SHIFT:    return "LN1_SHF";
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

} // namespace

int main() {
    const int MAX_CYCLES = 80;

    bool compute_ready = false;
    bool compute_done = false;
    bool error = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    bool mem_transfer_done = false;
    uint32_t mem_op = 0;

    int8_t valueA_mem[D_MODEL] = {};
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
    int4_t full_weights[D_MODEL * D_MODEL] = {};
    int32_t expected_full[D_MODEL] = {};
    int32_t full_accum[D_MODEL] = {};

    int4_t ffn1_weights[D_MODEL * D_TILE_W1] = {};
    int4_t ffn1_biases[D_TILE_W1] = {};
    int16_t ffn1_scale[D_TILE_W1] = {};
    int16_t ffn1_output[D_TILE_W1] = {};

    int16_t relu_input[D_FFN] = {};
    int16_t relu_output[D_FFN] = {};

    int16_t ffn2_input[D_FFN] = {};
    int4_t ffn2_weights[D_TILE_W2 * D_FFN] = {};
    int4_t ffn2_biases[D_TILE_W2] = {};
    int16_t ffn2_scale[D_TILE_W2] = {};
    int32_t ffn2_output[D_MODEL] = {};

    int32_t requant_activation[D_MODEL] = {};
    int32_t requant_scale = 0;
    int32_t requant_shift = 0;
    int32_t requant_zero_point = 0;
    int8_t requant_output[D_MODEL] = {};

    int32_t layernorm_gamma[D_MODEL] = {};
    int32_t layernorm_beta[D_MODEL] = {};
    int32_t layernorm_epsilon = 0;
    int32_t layernorm_out[D_MODEL] = {};

    int8_t residual[D_MODEL] = {};
    int8_t residual_out[D_MODEL] = {};

    const int MEM_LAT = 2;
    bool mem_busy = false;
    int mem_timer = 0;
    enum class MemPending { NONE, READ, WRITE };
    MemPending mem_pending = MemPending::NONE;
    int mem_tile_idx = -1;
    bool writeback_pending = false;

    init_inputs(valueA_mem, full_weights);
    expected_out_proj_full(valueA_mem, full_weights, expected_full);
    std::printf("D_MODEL=%d D_TILE_WO=%d NUM_WO_TILES=%d\n", D_MODEL, D_TILE_WO, NUM_WO_TILES);
    print_valueA(valueA_mem);
    print_full_weights(full_weights);

    enum class TbState {
        RESET,
        WAIT_DONE_OUT,
        WAIT_READY_TILE,
        WAIT_READY_BAD,
        WAIT_DONE_BAD,
        DONE
    };

    TbState state = TbState::RESET;
    uint32_t compute_instruction = 0;
    bool compute_start = false;
    int tile_idx = 0;

    std::printf("%-6s %-5s %-5s %-5s %-5s %-6s %-6s %-6s %-6s %-10s %-10s %-5s %-5s %-5s Acc[0:%d]\n",
                "Cycle", "Rst", "Start", "Ready", "Done", "Err",
                "MRead", "MWrite", "MDone", "MOp", "Instr", "Op", "Layer", "Head", "Tile",
                D_MODEL - 1);

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        const bool reset = (cycle < 2);

        mem_transfer_done = false;
        if (mem_busy) {
            if (mem_timer == 0) {
                mem_transfer_done = true;
                mem_busy = false;
                if (mem_pending == MemPending::READ) {
                    std::memset(in_buf, 0, sizeof(in_buf));
                    for (int i = 0; i < D_MODEL; ++i) {
                        compute_buf::write_i8(
                            in_buf,
                            compute_buf::OutProjLayout::ACT + i,
                            valueA_mem[i]);
                    }
                    if ((mem_tile_idx >= 0) && (mem_tile_idx < NUM_WO_TILES)) {
                        const int out_base = mem_tile_idx * D_TILE_WO;
                        for (int t = 0; t < D_TILE_WO; ++t) {
                            for (int i = 0; i < D_MODEL; ++i) {
                                const int idx = (t * D_MODEL) + i;
                                compute_buf::write_i4(
                                    in_buf,
                                    (compute_buf::OutProjLayout::W * 2) + idx,
                                    full_weights[(out_base + t) * D_MODEL + i]);
                            }
                        }
                    }
                    for (int t = 0; t < D_TILE_WO; ++t) {
                        compute_buf::write_i4(
                            in_buf,
                            (compute_buf::OutProjLayout::B * 2) + t,
                            int4_t(0));
                    }
                } else if (mem_pending == MemPending::WRITE) {
                    for (int t = 0; t < D_TILE_WO; ++t) {
                        const int out = mem_tile_idx * D_TILE_WO + t;
                        full_accum[out] = compute_buf::read_i32(out_buf, t * 4);
                    }
                    writeback_pending = false;
                }
                mem_pending = MemPending::NONE;
                mem_tile_idx = -1;
            } else {
                --mem_timer;
            }
        }

        compute_controller(
            reset,
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

        const uint8_t op_field = static_cast<uint8_t>(compute_instruction & 0xFFu);
        const uint8_t layer_field = static_cast<uint8_t>((compute_instruction >> 8) & 0xFFu);
        const int8_t head_field = static_cast<int8_t>((compute_instruction >> 16) & 0xFFu);
        const int8_t tile_field = static_cast<int8_t>((compute_instruction >> 24) & 0xFFu);

        std::printf("%-6d %-5d %-5d %-5d %-5d %-6d %-6d %-6d %-6d %-10s 0x%08x %-10s %-5d %-5d %-5d",
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
                    static_cast<int>(tile_field));
        for (int out = 0; out < D_MODEL; ++out) {
            std::printf(" %d", static_cast<int>(full_accum[out]));
        }
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
            case TbState::RESET:
                if (compute_ready) {
                    tile_idx = 0;
                    compute_instruction = make_instruction(ComputeOp::CMP_OUT_PROJ, 1, -1, tile_idx);
                    compute_start = true;
                    state = TbState::WAIT_DONE_OUT;
                }
                break;
            case TbState::WAIT_DONE_OUT:
                if (compute_done) {
                for (int t = 0; t < D_TILE_WO; ++t) {
                    const int out = tile_idx * D_TILE_WO + t;
                    const int32_t got = compute_buf::read_i32(out_buf, t * 4);
                    if (!writeback_pending) {
                        full_accum[out] = got;
                    }
                    if (got != expected_full[out]) {
                        std::fprintf(stderr,
                                     "CMP_OUT_PROJ failed at out %d: got %d expected %d\n",
                                     out, static_cast<int>(got),
                                     static_cast<int>(expected_full[out]));
                        return 1;
                    }
                }
                    if (error) {
                        std::fprintf(stderr, "CMP_OUT_PROJ asserted error unexpectedly.\n");
                        return 1;
                    }
                    if (tile_idx + 1 < NUM_WO_TILES) {
                        state = TbState::WAIT_READY_TILE;
                    } else {
                        state = TbState::WAIT_READY_BAD;
                    }
                }
                break;
            case TbState::WAIT_READY_TILE:
                if (compute_ready) {
                    tile_idx++;
                    compute_instruction = make_instruction(ComputeOp::CMP_OUT_PROJ, 1, -1, tile_idx);
                    compute_start = true;
                    state = TbState::WAIT_DONE_OUT;
                }
                break;
            case TbState::WAIT_READY_BAD:
                if (compute_ready) {
                    compute_instruction = make_instruction(ComputeOp::CMP_NONE, 0, -1, -1);
                    compute_start = true;
                    state = TbState::WAIT_DONE_BAD;
                }
                break;
            case TbState::WAIT_DONE_BAD:
                if (compute_done) {
                    if (!error) {
                        std::fprintf(stderr, "Invalid op did not assert error.\n");
                        return 1;
                    }
                    state = TbState::DONE;
                }
                break;
            case TbState::DONE:
                break;
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
