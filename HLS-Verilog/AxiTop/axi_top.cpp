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
struct KVCacheAddr {
    uint32_t base_addr;
    uint16_t token_offset;
    uint8_t head;
    bool valid;

    KVCacheAddr() : base_addr(0), token_offset(0), head(0), valid(false) {}
};

uint32_t mmu_calc_dma_size(DmaSel sel) {
#pragma HLS INLINE
    switch (sel) {
    case DmaSel::DMASEL_WQ:
    case DmaSel::DMASEL_WK:
    case DmaSel::DMASEL_WV:
        return Phi3Mini4K::dma_sizes::qkv_head;
    case DmaSel::DMASEL_K_WRITE:
    case DmaSel::DMASEL_V_WRITE:
        return Phi3Mini4K::dma_sizes::kv_token;
    case DmaSel::DMASEL_CTX_K:
    case DmaSel::DMASEL_CTX_V:
        return Phi3Mini4K::kv_cache_head_bytes;
    case DmaSel::DMASEL_WO:
        return Phi3Mini4K::dma_sizes::wo_tile;
    case DmaSel::DMASEL_W1:
        return Phi3Mini4K::dma_sizes::w1_tile;
    case DmaSel::DMASEL_W2:
        return Phi3Mini4K::dma_sizes::w2_tile;
    default:
        return 0;
    }
}

KVCacheAddr mmu_calc_kv_write_addr(uint32_t base, uint16_t token, int layer,
                                   int head) {
#pragma HLS INLINE
    KVCacheAddr addr;
    namespace strides = Phi3Mini4K::strides;
    addr.base_addr = base + layer * strides::kv_layer +
                     head * strides::kv_head + token * strides::kv_token;
    addr.token_offset = token;
    addr.head = head;
    addr.valid =
        (layer >= 0 && layer < Phi3Mini4K::num_layers && head >= 0 &&
         head < Phi3Mini4K::num_heads && token < Phi3Mini4K::context_len);
    return addr;
}

KVCacheAddr mmu_calc_kv_read_addr(uint32_t base, int layer, int head) {
#pragma HLS INLINE
    KVCacheAddr addr;

    namespace strides = Phi3Mini4K::strides;
    addr.base_addr = base + layer * strides::kv_layer + head * strides::kv_head;
    addr.token_offset = 0;
    addr.head = head;
    addr.valid = (layer >= 0 && layer < Phi3Mini4K::num_layers && head >= 0 &&
                  head < Phi3Mini4K::num_heads);
    return addr;
}

void axi_top(
    // AXI4-Lite Control/Status
    ControlMemSpace ctrl_mem, StatusMemSpace &status_mem, bool &irq_ps,

    // AXI4-Stream Token/Logit
    axis_stream_t &input_token, axis_stream_t &output_logit,

    // AXI Full Weights/KV Cache
    const int32_t *ddr_weights, int32_t *ddr_kvcache) {
#pragma HLS INTERFACE s_axilite port = ctrl_mem bundle = control
#pragma HLS INTERFACE s_axilite port = status_mem bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control
#pragma HLS INTERFACE ap_none port = irq_ps

#pragma HLS INTERFACE axis port = input_token
#pragma HLS INTERFACE axis port = output_logit

#pragma HLS INTERFACE m_axi port = ddr_weights offset = slave bundle =         \
    gmem_weights depth = 256
#pragma HLS INTERFACE m_axi port = ddr_kvcache offset = slave bundle =         \
    gmem_kvcache depth = 256

    // Buffers — small token/logit stay on BRAM
    static int8_t token_buf[Phi3Mini4K::d_model / sizeof(int8_t)];
#pragma HLS BIND_STORAGE variable = token_buf type = ram_2p impl = bram
    static int8_t logit_buf[Phi3Mini4K::d_model / sizeof(int8_t)];
#pragma HLS BIND_STORAGE variable = logit_buf type = ram_2p impl = bram

    // Single shared scratch buffer on URAM — sized to largest consumer
    static constexpr uint32_t SCRATCH_BUF_WORDS =
        Phi3Mini4K::dma_sizes::w2_tile / sizeof(int32_t);
    static int32_t scratch_buf[SCRATCH_BUF_WORDS];
#pragma HLS BIND_STORAGE variable = scratch_buf type = ram_2p impl = bram

    static ControlMemInterface ctrl_iface;
    static LogitStreamInterface logit_iface;

    StatusMemSpace &local_status = ctrl_iface.get_mutable_status();
    bool done = false;
    bool axi_done = false;
    bool scheduler_error = false;
    bool compute_error = false;
    bool axi_error = false;

    static TestState state = TestState::NONE;
    static DmaSel dma_select;
    bool wt_rdy = 0, wt_req = 0, wt_err = 0, kv_rdy = 0, kv_req = 0, kv_err = 0;
    uint32_t wt_addr = 0, kv_addr = 0;
    static int wt_len = 0; // static for compute calculation
    int kv_len = 0;
    KVCacheAddr kv_wb;

    // Control Decode
    bool resetn = (ctrl_mem.control & PLRegBits::CTRL_RESETN_BIT) != 0;
    bool start = (ctrl_mem.control & PLRegBits::CTRL_START_BIT) != 0;

    if (!resetn) {
        // In reset - do nothing
        state = TestState::NONE;
        // let ctrl_iface.check_control handle reset
        // local_status.status = STAT_IDLE_BIT;
        local_status.error_code = PLRegBits::ERR_NONE_BIT;
        local_status.layer_index = 0;
        local_status.head_index = 0;
        local_status.token_index = 0;
        dma_select = DmaSel::DMASEL_NONE;
        irq_ps = false;
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
        if (!axi_error && !compute_error && !scheduler_error &&
            local_status.error_code == PLRegBits::ERR_NONE_BIT) {
            local_status.status = PLRegBits::STAT_IDLE_BIT;
        }
        break;

    case TestState::INCR_MATRIX:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_MATRIX_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_MATRIX_BIT;
        dma_select = static_cast<DmaSel>(static_cast<uint8_t>(dma_select) + 1);
        if (dma_select > DmaSel::DMASEL_CONCAT) {
            dma_select = DmaSel::DMASEL_NONE;
        }
        break;

    case TestState::INCR_LAYER:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_LAYER_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_LAYER_BIT;
        local_status.layer_index++;
        if (local_status.layer_index >= Phi3Mini4K::num_layers) {
            local_status.layer_index = 0;
        }
        break;

    case TestState::INCR_HEAD:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_HEAD_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_HEAD_BIT;
        local_status.head_index++;
        if (local_status.head_index >= Phi3Mini4K::num_heads) {
            local_status.head_index = 0;
        }
        break;

    case TestState::INCR_TOKEN:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_TOKEN_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_INCR_TOKEN_BIT;
        local_status.token_index++;
        if (local_status.token_index >= Phi3Mini4K::context_len) {
            local_status.token_index = 0;
        }
        break;

    case TestState::WEIGHTS_GET:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_WEIGHTS_GET_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_WEIGHTS_GET_BIT;

        weight_stager(false, true, DmaSel::DMASEL_WQ, local_status.layer_index,
                      local_status.head_index, 0, ctrl_mem, wt_rdy, wt_req,
                      wt_err, wt_addr);

        wt_len = mmu_calc_dma_size(DmaSel::DMASEL_WQ) / sizeof(int32_t);

        if (wt_req && !wt_err) {
            WeightTransferInterface::burst_read(
                ddr_weights, scratch_buf, wt_addr / sizeof(int32_t), wt_len);
        } else if (wt_err) {
            axi_error = true;
            local_status.error_code = PLRegBits::ERR_WEIGHTS_GET_BIT;
        }

        axi_done = true;
        break;

    case TestState::KCACHE_GET:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_GET_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_GET_BIT;

        weight_stager(false, true, DmaSel::DMASEL_CTX_K,
                      local_status.layer_index, local_status.head_index, 0,
                      ctrl_mem, kv_rdy, kv_req, kv_err, kv_addr);

        kv_len = mmu_calc_dma_size(DmaSel::DMASEL_CTX_K) / sizeof(int32_t);

        if (kv_req && !kv_err) {
            WeightTransferInterface::burst_read(
                ddr_kvcache, scratch_buf, kv_addr / sizeof(int32_t), kv_len);
        } else if (kv_err) {
            axi_error = true;
            local_status.error_code = PLRegBits::ERR_KCACHE_GET_BIT;
        }

        axi_done = true;
        break;

    case TestState::VCACHE_GET:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_GET_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_GET_BIT;

        weight_stager(false, true, DmaSel::DMASEL_CTX_V,
                      local_status.layer_index, local_status.head_index, 0,
                      ctrl_mem, kv_rdy, kv_req, kv_err, kv_addr);

        kv_len = mmu_calc_dma_size(DmaSel::DMASEL_CTX_V) / sizeof(int32_t);

        if (kv_req && !kv_err) {
            WeightTransferInterface::burst_read(
                ddr_kvcache, scratch_buf, kv_addr / sizeof(int32_t), kv_len);
        } else if (kv_err) {
            axi_error = true;
            local_status.error_code = PLRegBits::ERR_VCACHE_GET_BIT;
        }

        axi_done = true;
        break;

    case TestState::STREAM_IN:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_IN_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_IN_BIT;
        if (!logit_iface.receive_token(input_token, token_buf)) {
            axi_error = true;
            local_status.error_code = PLRegBits::ERR_INPUT_STREAM_BIT;
        }

        axi_done = true;
        break;

    case TestState::COMPUTE:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_COMPUTE_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_COMPUTE_BIT;
        // Compute placeholder
        for (int i = 0; i < Phi3Mini4K::d_model / sizeof(int8_t); i++) {
// #pragma HLS UNROLL factor = 4
            logit_buf[i] = token_buf[i] +
                           static_cast<int8_t>(scratch_buf[i % wt_len] & 0xFF);
        }

        break;

    case TestState::STREAM_OUT:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_OUT_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_STREAM_OUT_BIT;

        logit_iface.send_logit(output_logit, logit_buf);

        axi_done = true;
        done = true;
        break;

    case TestState::KCACHE_SEND:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_SEND_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_KCACHE_SEND_BIT;

        kv_wb = mmu_calc_kv_write_addr(
            ctrl_mem.k_cache_offset, local_status.token_index,
            local_status.layer_index, local_status.head_index);

        kv_len = mmu_calc_dma_size(DmaSel::DMASEL_K_WRITE) / sizeof(int32_t);

        for (int i = 0; i < kv_len; i++) {
// #pragma HLS PIPELINE II = 1
            int32_t packed = 0;
            for (int j = 0; j < sizeof(int32_t); j++) {
                packed |=
                    (static_cast<uint8_t>(logit_buf[i * 4 + j]) << (j * 8));
            }
            scratch_buf[i] = packed;
        }

        if (kv_wb.valid) {
            WeightTransferInterface::burst_write(
                ddr_kvcache, scratch_buf, kv_wb.base_addr / sizeof(int32_t),
                kv_len);
        } else {
            axi_error = true;
            local_status.error_code = PLRegBits::ERR_KCACHE_SEND_BIT;
        }

        axi_done = true;
        break;

    case TestState::VCACHE_SEND:
        if (local_status.status &
            (PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_SEND_BIT)) {
            break;
        }
        local_status.status =
            PLRegBits::STAT_BUSY_BIT | PLRegBits::STAT_VCACHE_SEND_BIT;

        kv_wb = mmu_calc_kv_write_addr(
            ctrl_mem.v_cache_offset, local_status.token_index,
            local_status.layer_index, local_status.head_index);

        kv_len = mmu_calc_dma_size(DmaSel::DMASEL_V_WRITE) / sizeof(int32_t);

        for (int i = 0; i < kv_len; i++) {
// #pragma HLS PIPELINE II = 1
            int32_t packed = 0;
            for (int j = 0; j < sizeof(int32_t); j++) {
                packed |=
                    (static_cast<uint8_t>(logit_buf[i * 4 + j]) << (j * 8));
            }
            scratch_buf[i] = packed;
        }

        if (kv_wb.valid) {
            WeightTransferInterface::burst_write(
                ddr_kvcache, scratch_buf, kv_wb.base_addr / sizeof(int32_t),
                kv_len);
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

    ctrl_iface.check_errors(ctrl_mem, scheduler_error, compute_error,
                            axi_error);
    ctrl_iface.check_control(ctrl_mem, done, axi_done);
    irq_ps = ctrl_iface.compute_irq(ctrl_mem.irq_mask);
    status_mem = local_status;
}
