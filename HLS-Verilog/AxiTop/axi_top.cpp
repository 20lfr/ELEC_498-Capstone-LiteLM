#include "axi_top.hpp"
#include <cstdint>
/** AXI Top-Level Implementation
 *
 * Tests all three AXI interface types in one IP:
 *   AXI-Lite  – ctrl_mem / status_mem
 *   AXI-Stream – token in / logit out
 *   m_axi      – weight read + KV cache r/w
 *
 */

struct BufferField {
    uint32_t offset;
    uint32_t size;
    BufDType dtype;
    uint16_t num_elements;

    BufferField() : offset(0), size(0), dtype(BufDType::NONE), num_elements(0) {}
    BufferField(uint32_t off, uint32_t sz, BufDType dt, uint16_t n)
        : offset(off), size(sz), dtype(dt), num_elements(n) {}
};

struct KVCacheAddr {
    uint32_t base_addr;
    uint16_t token_offset;
    uint8_t  head;
    bool     valid;

    KVCacheAddr() : base_addr(0), token_offset(0), head(0), valid(false) {}
};

uint32_t mmu_calc_dma_size(DmaSel sel) {
#pragma HLS INLINE
    switch (sel) {
        case DmaSel::DMASEL_WQ: case DmaSel::DMASEL_WK: case DmaSel::DMASEL_WV:
            return (Phi3Mini2K::head_dim * Phi3Mini2K::d_model / 2) + (Phi3Mini2K::head_dim / 2);
        case DmaSel::DMASEL_K_WRITE: case DmaSel::DMASEL_V_WRITE:
            return Phi3Mini2K::head_dim;
        case DmaSel::DMASEL_CTX_K: case DmaSel::DMASEL_CTX_V:
            return Phi3Mini2K::context_len * Phi3Mini2K::head_dim;
        case DmaSel::DMASEL_WO:
            return (Phi3Mini2K::w_out_tile_cols * Phi3Mini2K::d_model / 2) + (Phi3Mini2K::w_out_tile_cols * 4);
        case DmaSel::DMASEL_W1:
            return (Phi3Mini2K::ffn_tile_cols * Phi3Mini2K::d_model / 2) + (Phi3Mini2K::ffn_tile_cols * 4) + (Phi3Mini2K::ffn_tile_cols * 2);
        case DmaSel::DMASEL_W2:
            return (Phi3Mini2K::ffn_tile_cols * Phi3Mini2K::d_ffn / 2) + (Phi3Mini2K::ffn_tile_cols * 4) + (Phi3Mini2K::ffn_tile_cols * 2);
        default:
            return 0;
    }
}

KVCacheAddr mmu_calc_kv_write_addr(uint32_t base, uint16_t token, int layer, int head) {
#pragma HLS INLINE
    KVCacheAddr addr;
    uint32_t layer_stride = Phi3Mini2K::num_heads * Phi3Mini2K::context_len * Phi3Mini2K::head_dim;
    uint32_t head_stride = Phi3Mini2K::context_len * Phi3Mini2K::head_dim;
    uint32_t token_stride = Phi3Mini2K::head_dim;

    addr.base_addr = base + layer * layer_stride + head * head_stride + token * token_stride;
    addr.token_offset = token;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < Phi3Mini2K::num_layers &&
                  head >= 0 && head < Phi3Mini2K::num_heads &&
                  token < Phi3Mini2K::context_len);
    return addr;
}

KVCacheAddr mmu_calc_kv_read_addr(uint32_t base, int layer, int head) {
#pragma HLS INLINE
    KVCacheAddr addr;
    uint32_t layer_stride = Phi3Mini2K::num_heads * Phi3Mini2K::context_len * Phi3Mini2K::head_dim;
    uint32_t head_stride = Phi3Mini2K::context_len * Phi3Mini2K::head_dim;

    addr.base_addr = base + layer * layer_stride + head * head_stride;
    addr.token_offset = 0;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < Phi3Mini2K::num_layers && head >= 0 && head < Phi3Mini2K::num_heads);
    return addr;
}

void axi_top(
    // AXI4-Lite Control/Status
    ControlMemSpace ctrl_mem,
    StatusMemSpace& status_mem,
    bool &irq_ps,

    // AXI4-Stream Token/Logit
    axis_stream_t& input_token,
    axis_stream_t& output_logit,

    // AXI Full Weights/KV Cache
    const int32_t*   ddr_weights,
    int32_t*         ddr_kvcache
) {
    #pragma HLS INTERFACE s_axilite port=ctrl_mem   bundle=control
    #pragma HLS INTERFACE s_axilite port=status_mem bundle=control
    #pragma HLS INTERFACE s_axilite port=return     bundle=control
    #pragma HLS INTERFACE ap_none   port=irq_ps

    #pragma HLS INTERFACE axis port=input_token
    #pragma HLS INTERFACE axis port=output_logit

    #pragma HLS INTERFACE m_axi port=ddr_weights offset=slave bundle=gmem_weights depth=256
    #pragma HLS INTERFACE m_axi port=ddr_kvcache offset=slave bundle=gmem_kvcache depth=256

    // Buffers
    static int8_t  token_buf[Phi3Mini2K::d_model];
    #pragma HLS ARRAY_PARTITION variable=token_buf cyclic factor=NUM_BYTES_PER_STREAM
    static int8_t  logit_buf[Phi3Mini2K::d_model];
    #pragma HLS ARRAY_PARTITION variable=logit_buf cyclic factor=NUM_BYTES_PER_STREAM

    // W1 largest size
    static int32_t weight_buf[Phi3Mini2K::d_ffn*Phi3Mini2K::d_model/4];
    #pragma HLS ARRAY_PARTITION variable=weight_buf cyclic factor=32
    static int32_t kcache_buf[Phi3Mini2K::context_len*Phi3Mini2K::d_model/4];
    #pragma HLS ARRAY_PARTITION variable=kcache_buf cyclic factor=32
    static int32_t vcache_buf[Phi3Mini2K::context_len*Phi3Mini2K::d_model/4];
    #pragma HLS ARRAY_PARTITION variable=vcache_buf cyclic factor=32

    static ControlMemInterface  ctrl_iface;
    static LogitStreamInterface logit_iface;

    StatusMemSpace& local_status = ctrl_iface.get_mutable_status();
    bool done  = false;
    bool axi_done = false;
    bool scheduler_error = false;
    bool compute_error = false;
    bool axi_error = false;

    static TestState state = TestState::NONE;
    static DmaSel dma_select;
    bool wt_rdy=0, wt_req=0, wt_err=0, 
         kv_rdy=0, kv_req=0, kv_err=0;
    uint32_t wt_addr=0, kv_addr=0;
    static int wt_bytes=0, wt_words=0,
        kv_bytes=0, kv_words=0, kv_wb_len=0;
    KVCacheAddr kv_wb;

    // Control Decode
    bool resetn = (ctrl_mem.control & PLRegBits::CTRL_RESETN_BIT) != 0;
    bool start  = (ctrl_mem.control & PLRegBits::CTRL_START_BIT)  != 0;

    if (!resetn) {
        // In reset - do nothing
        state = TestState::NONE;
        // let ctrl_iface.check_control handle reset
        //local_status.status = STAT_IDLE_BIT;
        local_status.error_code = PLRegBits::ERR_NONE_BIT;
        local_status.layer_index = 0;
        local_status.head_index = 0;
        local_status.token_index = 0;
        dma_select = DmaSel::DMASEL_NONE;
        irq_ps = false;

        for (int i = 0; i < Phi3Mini2K::d_model; i++) {
            #pragma HLS PIPELINE II=1
            token_buf[i] = 0;
            logit_buf[i] = 0;
        }
        for (int i = 0; i < Phi3Mini2K::d_ffn*Phi3Mini2K::d_model/4; i++) {
            #pragma HLS PIPELINE II=1
            weight_buf[i] = 0;
        }
        for (int i = 0; i < Phi3Mini2K::context_len*Phi3Mini2K::d_model/4; i++) {
            #pragma HLS PIPELINE II=1
            kcache_buf[i] = 0;
            vcache_buf[i] = 0;
        }
    }

    if (start) {
        if (ctrl_mem.control & PLRegBits::CTRL_WEIGHTS_GET_BIT) {
            state = TestState::WEIGHTS_GET;
        } else if (ctrl_mem.control & PLRegBits::CTRL_KCACHE_GET_BIT) {
            state = TestState::KCACHE_GET;
        } else if (ctrl_mem.control & PLRegBits::CTRL_KCACHE_SEND_BIT) {
            state = TestState::KCACHE_SEND;
        } else if (ctrl_mem.control & PLRegBits::CTRL_VCACHE_GET_BIT) {
            state = TestState::VCACHE_GET;
        } else if (ctrl_mem.control & PLRegBits::CTRL_VCACHE_SEND_BIT) {
            state = TestState::VCACHE_SEND;
        } else if (ctrl_mem.control & PLRegBits::CTRL_STREAM_IN_BIT) {
            state = TestState::STREAM_IN;
        } else if (ctrl_mem.control & PLRegBits::CTRL_COMPUTE_BIT) {
            state = TestState::COMPUTE;
        } else if (ctrl_mem.control & PLRegBits::CTRL_STREAM_OUT_BIT) {
            state = TestState::STREAM_OUT;
        } else if (ctrl_mem.control & PLRegBits::CTRL_INCR_HEAD_BIT) {
            state = TestState::INCR_HEAD;
        } else if (ctrl_mem.control & PLRegBits::CTRL_INCR_LAYER_BIT) {
            state = TestState::INCR_LAYER;
        } else if (ctrl_mem.control & PLRegBits::CTRL_INCR_MATRIX_BIT) {
            state = TestState::INCR_MATRIX;
        } else {
            state = TestState::NONE; 
        }
    }

    switch (state) {
        case TestState::NONE:
            // maintain status only when no erorrs occur
            if (!axi_error && !compute_error && !scheduler_error && local_status.error_code == PLRegBits::ERR_NONE_BIT) {
                local_status.status = PLRegBits::STAT_IDLE_BIT;
            }
            break;

        case TestState::INCR_MATRIX:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_MATRIX_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_MATRIX_BIT;
            dma_select = static_cast<DmaSel>(static_cast<uint8_t>(dma_select) + 1);
            if (dma_select > DmaSel::DMASEL_CONCAT) {
                dma_select = DmaSel::DMASEL_NONE;
            }
            break;

        case TestState::INCR_LAYER:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_HEAD_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_LAYER_BIT;
            local_status.layer_index++;
            if (local_status.layer_index >= Phi3Mini2K::num_layers) {
                local_status.layer_index = 0;
            }
            break;

        case TestState::INCR_HEAD:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_HEAD_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_HEAD_BIT;
            local_status.head_index++;
            if (local_status.head_index >= Phi3Mini2K::num_heads) {
                local_status.head_index = 0;
            }
            break;

        case TestState::INCR_TOKEN:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_TOKEN_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_TOKEN_BIT;
            local_status.token_index++;
            if (local_status.token_index >= Phi3Mini2K::context_len) {
                local_status.token_index = 0;
            }
            break;

        case TestState::WEIGHTS_GET:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_WEIGHTS_GET_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_WEIGHTS_GET_BIT;

            weight_stager(false, true, DmaSel::DMASEL_WQ, local_status.layer_index, local_status.head_index, 0,
                        ctrl_mem, wt_rdy, wt_req, wt_err, wt_addr);

            wt_bytes = mmu_calc_dma_size(DmaSel::DMASEL_WQ);
            wt_words = wt_bytes / sizeof(int32_t);

            if (wt_req && !wt_err) {
                WeightTransferInterface::burst_read(ddr_weights, weight_buf, wt_addr, wt_words);
            } else if (wt_err) {
                axi_error = true;
                local_status.error_code = PLRegBits::ERR_WEIGHTS_GET_BIT;
            }

            axi_done = true;
            break;

        case TestState::KCACHE_GET:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_GET_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_GET_BIT;

            weight_stager(false, true, DmaSel::DMASEL_CTX_K, local_status.layer_index, local_status.head_index, 0,
                        ctrl_mem, kv_rdy, kv_req, kv_err, kv_addr);

            kv_bytes = mmu_calc_dma_size(DmaSel::DMASEL_CTX_K);
            kv_words = kv_bytes / sizeof(int32_t);

            if (kv_req && !kv_err) {
                WeightTransferInterface::burst_read(ddr_kvcache, kcache_buf, kv_addr, kv_words);
            } else if (kv_err) {
                axi_error = true;
                local_status.error_code = PLRegBits::ERR_KCACHE_GET_BIT;
            }

            axi_done = true;
            break;

        case TestState::VCACHE_GET:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_GET_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_GET_BIT;

            weight_stager(false, true, DmaSel::DMASEL_CTX_V, local_status.layer_index, local_status.head_index, 0,
                        ctrl_mem, kv_rdy, kv_req, kv_err, kv_addr);

            kv_bytes = mmu_calc_dma_size(DmaSel::DMASEL_CTX_V);
            kv_words = kv_bytes / sizeof(int32_t);

            if (kv_req && !kv_err) {
                WeightTransferInterface::burst_read(ddr_kvcache, vcache_buf, kv_addr, kv_words);
            } else if (kv_err) {
                axi_error = true;
                local_status.error_code = PLRegBits::ERR_VCACHE_GET_BIT;
            }

            axi_done = true;
            break;

        case TestState::STREAM_IN:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_IN_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_IN_BIT;
            if (!logit_iface.receive_token(input_token, token_buf)) {
                axi_error = true;
                local_status.error_code = PLRegBits::ERR_INPUT_STREAM_BIT;
            }

            axi_done = true;
            break;

        case TestState::COMPUTE:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_COMPUTE_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_COMPUTE_BIT;
            // Compute placeholder
            for (int i = 0; i < MODEL_HIDDEN_SIZE; i++) {
                #pragma HLS UNROLL factor=4
                logit_buf[i] = token_buf[i] + static_cast<int8_t>(weight_buf[i % wt_words] & 0xFF);
            }

            break;

        case TestState::STREAM_OUT:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_OUT_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_OUT_BIT;

            logit_iface.send_logit(output_logit, logit_buf);

            axi_done = true;
            done = true;
            break;

        case TestState::KCACHE_SEND:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_SEND_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_SEND_BIT;

            kv_wb = mmu_calc_kv_write_addr(ctrl_mem.k_cache_offset, local_status.token_index,
                                            local_status.layer_index, local_status.head_index);

            kv_wb_len = mmu_calc_dma_size(DmaSel::DMASEL_K_WRITE);

            for (int i = 0; i < kv_wb_len && i < Phi3Mini2K::d_model; i++) {
                #pragma HLS UNROLL factor=4
                // logit_buf for testing
                kcache_buf[i] = static_cast<int32_t>(logit_buf[i]);
            }

            if (kv_wb.valid) {
                WeightTransferInterface::burst_write(ddr_kvcache, kcache_buf, kv_wb.base_addr, kv_wb_len);
            } else {
                axi_error = true;
                local_status.error_code = PLRegBits::ERR_KCACHE_SEND_BIT;
            }

            axi_done = true;
            break;

        case TestState::VCACHE_SEND:
            if (local_status.status & (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_SEND_BIT)) { break; }
            local_status.status = PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_SEND_BIT;

            kv_wb = mmu_calc_kv_write_addr(ctrl_mem.v_cache_offset, local_status.token_index,
                                            local_status.layer_index, local_status.head_index);

            kv_wb_len = mmu_calc_dma_size(DmaSel::DMASEL_V_WRITE);

            for (int i = 0; i < kv_wb_len && i < Phi3Mini2K::d_model; i++) {
                #pragma HLS UNROLL factor=4
                // logit_buf for testing
                vcache_buf[i] = static_cast<int32_t>(logit_buf[i] + 1);
            }

            if (kv_wb.valid) {
                WeightTransferInterface::burst_write(ddr_kvcache, vcache_buf, kv_wb.base_addr, kv_wb_len);
            } else {
                axi_error = true;
                local_status.error_code = PLRegBits::ERR_VCACHE_SEND_BIT;
            }

            axi_done = true;
            break;

        default:
            state = TestState::NONE;
            break;
    }

    ctrl_iface.check_errors(ctrl_mem, scheduler_error, compute_error, axi_error);
    ctrl_iface.check_control(ctrl_mem, done, axi_done);
    irq_ps = ctrl_iface.compute_irq(ctrl_mem.irq_mask);
    status_mem = local_status;
}
