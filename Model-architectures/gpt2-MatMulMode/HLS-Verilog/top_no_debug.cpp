#include "top_no_debug.hpp"
#include "MMU/mmu_luka.hpp"

// Helper: extract one byte from a 512-bit AXI-Full DMA staging buffer.
static inline uint8_t dma_buf_get_byte(const axi_gmem_word_t *buf, uint32_t byte_idx) {
    const uint32_t word_idx = byte_idx / static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
    const uint32_t lane     = byte_idx % static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
    return static_cast<uint8_t>(buf[word_idx].range(lane * 8u + 7u, lane * 8u));
}

// Helper: write one byte into a 512-bit AXI-Full DMA staging buffer.
static inline void dma_buf_set_byte(axi_gmem_word_t *buf, uint32_t byte_idx, uint8_t value) {
    const uint32_t word_idx = byte_idx / static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
    const uint32_t lane     = byte_idx % static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
    buf[word_idx].range(lane * 8u + 7u, lane * 8u) = static_cast<ap_uint<8>>(value);
}

// Shared helper: extract one byte lane from an AXI-Full word.
static inline uint8_t gmem_get_byte(const axi_gmem_word_t &word, uint32_t lane) {
    const uint32_t hi = ((lane + 1u) * 8u) - 1u;
    const uint32_t lo = lane * 8u;
    return static_cast<uint8_t>(word.range(hi, lo));
}

// Shared helper: overwrite one byte lane inside an AXI-Full word.
static inline void gmem_set_byte(axi_gmem_word_t &word, uint32_t lane, uint8_t value) {
    const uint32_t hi = ((lane + 1u) * 8u) - 1u;
    const uint32_t lo = lane * 8u;
    word.range(hi, lo) = static_cast<ap_uint<8>>(value);
}

#ifndef __SYNTHESIS__
// C-sim helper: with offset-only addressing the MMU emits direct byte offsets
// into the compact shared DDR image, so no remap is required.
static inline uint64_t map_csim_ddr_addr(uint64_t byte_addr, const ControlMemSpace &ctrl_mem) {
    (void)ctrl_mem;
    return byte_addr;
}
#endif

// Production top-level wrapper with reduced debug ports.
void transformer_top(
    // AXI4-STREAM INPUT/OUTPUT
    hls::stream<axis512_t> &s_axis_in,
    hls::stream<axis512_t> &m_axis_out,
    volatile axi_gmem_word_t *ddr_mem,
    volatile axi_gmem_word_t *kv_cache,

    // AXI4-LITE INTERFACING (PL <-> PS)
    ControlMemSpace ctrl_mem,
    StatusMemSpace &status_mem,

    // INTERRUPT INTERFACING (PL -> PS)
    bool            &irq_ps,
    SchedState      &dbg_state
) {
#pragma HLS INLINE off
#pragma HLS INTERFACE axis port=s_axis_in
#pragma HLS INTERFACE axis port=m_axis_out
#pragma HLS INTERFACE m_axi port=ddr_mem offset=slave bundle=gmem depth=TOP_DMA_BUF_WORDS
#pragma HLS INTERFACE m_axi port=kv_cache offset=slave bundle=kv_gmem depth=TOP_DMA_BUF_WORDS
#pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
#pragma HLS INTERFACE s_axilite port=status_mem bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS INTERFACE ap_none port=irq_ps

    bool done                   = false;
    bool scheduler_error        = false;
    bool compute_error          = false;

    static ControlMemInterface ctrl_mem_interface;
    StatusMemSpace &active_status_mem = ctrl_mem_interface.get_mutable_status();

    static bool             compute_ready                  = false;
    static bool             compute_done                   = false;
    static bool             compute_start                  = false;
    static uint64_t         compute_instruction            = 0;
    static SchedState       state_local                    = S_IDLE;

    // MMU-owned compute buffers
    static uint8_t          mmu_in_buf[compute_buf::IN_BUF_BYTES];
#pragma HLS BIND_STORAGE variable=mmu_in_buf type=ram_t2p impl=bram
    static uint8_t          mmu_out_buf[compute_buf::OUT_BUF_BYTES];
#pragma HLS BIND_STORAGE variable=mmu_out_buf type=ram_t2p impl=bram

    // Per-invocation output activation buffer (tile outputs accumulated here, then streamed out).
    static uint8_t          stream_out_buf_local[STREAM_OUT_BUF_BYTES];
#pragma HLS BIND_STORAGE variable=stream_out_buf_local type=ram_t2p impl=bram

    // 512-bit AXI-Full DMA staging buffers.
    static axi_gmem_word_t  dma_rx_buf_local[TOP_DMA_BUF_WORDS];
#pragma HLS BIND_STORAGE variable=dma_rx_buf_local type=ram_t2p impl=uram
    static axi_gmem_word_t  dma_tx_buf_local[TOP_DMA_BUF_WORDS];
#pragma HLS BIND_STORAGE variable=dma_tx_buf_local type=ram_t2p impl=uram

    static bool             dma_ready_local                = true;
    static bool             dma_done_local                 = false;
    static bool             dma_busy_local                 = false;
    static int              dma_countdown_local            = 0;
    static uint64_t         dma_addr_latched_local         = 0;
    static uint32_t         dma_len_latched_local          = 0;
    static bool             dma_is_write_latched_local     = false;
    static bool             dma_use_kv_cache_latched_local = false;
    static bool             dma_start_local                = false;
    static uint64_t         dma_addr_local                 = 0;
    static uint32_t         dma_len_local                  = 0;
    static bool             dma_is_write_local             = false;
    static bool             dma_use_kv_cache_local         = false;
    static bool             stream_start_local             = false;
    static bool             stream_done_local              = false;
    static bool             stream_done_pulse_local        = false;
    static bool             stream_tx_active_local         = false;
    static uint32_t         stream_tx_index_local          = 0;
    static uint32_t         stream_tx_len_local            = 0;
    static bool             token_loaded_complete_local    = false;

    static uint32_t         full_out_write_offset          = 0;

    // Tile writeback handshake
    static bool             tile_wb_done_local             = false;

    // Latched op from last compute_start (valid through tile writeback and stream-out).
    static uint8_t          latched_op                     = 0;

    // MMU external DMA/status interface state
    static Status           mmu_status;
    static bool             mmu_req_ready_wire            = true;
    static bool             mmu_main_dma_done_wire        = false;
    static bool             mmu_main_mem_transfer_done_wire = false;
    static bool             scheduler_wl_start            = false;
    static bool             scheduler_wl_accept           = false;
    static uint64_t         scheduler_wl_instruction      = 0;
    static bool             main_mem_read_request         = false;
    static bool             main_mem_write_request        = false;
    static uint64_t         main_mem_op                   = 0;
    static bool             debug_sum_done_local          = false;
    static int32_t          debug_sum_value_local         = 0;
    static bool             prev_start                    = false;
    static uint32_t         scheduler_layer_index_local   = 0;

    // Active-low reset derived from control register.
    const bool reset_n = (ctrl_mem.control & CTRL_RESETN_BIT) != 0u;
    const bool reset = !reset_n;
    const bool start_en = (ctrl_mem.control & CTRL_START_BIT) != 0u;
    const bool start_edge = start_en && !prev_start;
    const bool debug_mode_en = (ctrl_mem.control & CTRL_DEBUG_MODE_BIT) != 0u;
    const bool ctrl_error =
        ((active_status_mem.irq_status & IRQ_ERROR_BIT) != 0u) ||
        (active_status_mem.error_code != ERR_NONE);
    const uint16_t token_position_local = static_cast<uint16_t>(ctrl_mem.token_position);

    // Reset once at boot, then re-arm run-local state on each new start pulse.
    if (reset || start_edge) {
        compute_ready = true;
        compute_done = false;
        compute_start = false;
        compute_instruction = 0;
        state_local = S_IDLE;
        mmu_req_ready_wire = true;
        mmu_main_dma_done_wire = false;
        mmu_main_mem_transfer_done_wire = false;
        mmu_status = Status();
        dma_ready_local = true;
        scheduler_wl_start = false;
        scheduler_wl_accept = false;
        scheduler_wl_instruction = 0;
        main_mem_read_request = false;
        main_mem_write_request = false;
        main_mem_op = 0;
        debug_sum_done_local = false;
        debug_sum_value_local = 0;
        scheduler_layer_index_local = 0;
        dma_done_local = false;
        dma_busy_local = false;
        dma_countdown_local = 0;
        dma_addr_latched_local = 0;
        dma_len_latched_local = 0;
        dma_is_write_latched_local = false;
        dma_use_kv_cache_latched_local = false;
        dma_start_local = false;
        dma_addr_local = 0;
        dma_len_local = 0;
        dma_is_write_local = false;
        dma_use_kv_cache_local = false;
        stream_start_local = false;
        stream_done_local = false;
        stream_done_pulse_local = false;
        stream_tx_active_local = false;
        stream_tx_index_local = 0;
        stream_tx_len_local = 0;
        token_loaded_complete_local = false;
        full_out_write_offset = 0;
        tile_wb_done_local = false;
        latched_op = 0;

        if (reset) {
            prev_start = false;
        }

        for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
            mmu_in_buf[i] = 0;
        }
        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
            mmu_out_buf[i] = 0;
        }
        for (int i = 0; i < TOP_DMA_BUF_WORDS; ++i) {
            dma_rx_buf_local[i] = axi_gmem_word_t(0);
            dma_tx_buf_local[i] = axi_gmem_word_t(0);
        }
    }
    if (reset) {
        prev_start = false;
    } else {
        prev_start = start_en;
    }

    // AXI4-Stream ingress: read one 512-bit beat when the scheduler is in S_STREAM_IN state.
    // Raw beat data is passed to mmu_fsm which unpacks it 64 bytes at a time into stream_in_capture_buf.
    const bool axis_in_ready_wire = (reset_n && (state_local == S_STREAM_IN) && !token_loaded_complete_local);
    bool axis_in_valid = false;
    bool axis_in_last = false;
    ap_uint<AXI_GMEM_WORD_BITS> axis_in_data = 0;
    if (axis_in_ready_wire && !s_axis_in.empty()) {
        axis512_t beat = s_axis_in.read();
        axis_in_valid = true;
        axis_in_last  = (beat.last != 0);
        axis_in_data  = beat.data;
        if (beat.last != 0) {
            token_loaded_complete_local = true;
        }
    }

    const bool stream_ready_local = !stream_tx_active_local;
    stream_done_local = stream_done_pulse_local;
    stream_done_pulse_local = false;

    // SCHEDULER FSM
    bool tile_wb_start_local = false;
    scheduler_hls(
        reset_n,
        start_edge,
        ctrl_mem.instr,
        token_loaded_complete_local,
        mmu_main_dma_done_wire,
        mmu_req_ready_wire,
        scheduler_wl_accept,
        scheduler_wl_instruction,
        scheduler_wl_start,
        compute_ready,
        compute_done,
        compute_start,
        compute_instruction,
        stream_ready_local,
        stream_start_local,
        stream_done_local,
        tile_wb_start_local,
        tile_wb_done_local,
        done,
        scheduler_error,
        scheduler_layer_index_local,
        state_local
    );

    // Capture op from compute_start for use during tile writeback and final stream-out.
    if (compute_start) {
        latched_op = static_cast<uint8_t>(compute_instruction & 0xFu);
    }

    // Tile writeback: copy one tile's results from mmu_out_buf into stream_out_buf_local at offset.
    tile_wb_done_local = false;
    if (tile_wb_start_local) {
        const uint32_t tile_bytes = tile_out_bytes_for_op(latched_op);
        for (uint32_t i = 0; i < tile_bytes; ++i) {
#pragma HLS PIPELINE II=1
            stream_out_buf_local[full_out_write_offset + i] = mmu_out_buf[i];
        }
        full_out_write_offset += tile_bytes;
        tile_wb_done_local = true;
    }

    // AXIS token completion is a per-token ingress latch. Once the scheduler
    // has advanced beyond STREAM_IN, clear it so the next token can be accepted.
    if (token_loaded_complete_local && (state_local != S_STREAM_IN)) {
        token_loaded_complete_local = false;
    }

    if (!stream_tx_active_local) {
        debug_sum_done_local = false;
    }

    // Local throwaway variables for compute_controller debug ports.
    // HLS will optimize these away since they are never read externally.
    ComputeState cc_dbg_state;
    uint64_t     cc_dbg_req_instruction;
    uint8_t      cc_dbg_req_op;
    uint8_t      cc_dbg_req_layer;
    uint8_t      cc_dbg_req_head;
    uint16_t     cc_dbg_req_tile;
    bool         cc_dbg_mac_start;
    bool         cc_dbg_mac_ready;
    bool         cc_dbg_mac_complete;

    compute_controller(
        reset_n && !start_edge,
        compute_start,
        compute_instruction,
        compute_ready,
        compute_done,

        mmu_main_mem_transfer_done_wire,
        main_mem_read_request,
        main_mem_write_request,
        main_mem_op,
        mmu_in_buf,
        mmu_out_buf,

        // Throwaway debug outputs (optimized away by HLS)
        cc_dbg_state,
        cc_dbg_req_instruction,
        cc_dbg_req_op,
        cc_dbg_req_layer,
        cc_dbg_req_head,
        cc_dbg_req_tile,
        cc_dbg_mac_start,
        cc_dbg_mac_ready,
        cc_dbg_mac_complete,
        compute_error
    );

    mmu_fsm(
        reset_n,
        ctrl_mem,
        token_position_local,
        dma_ready_local,
        dma_done_local,
        dma_rx_buf_local,
        dma_tx_buf_local,
        dma_start_local,
        dma_addr_local,
        dma_len_local,
        dma_is_write_local,
        dma_use_kv_cache_local,
        axis_in_valid,
        axis_in_last,
        axis_in_ready_wire,
        axis_in_data,
        scheduler_wl_start,
        scheduler_wl_instruction,
        mmu_req_ready_wire,
        scheduler_wl_accept,
        mmu_main_dma_done_wire,
        main_mem_read_request,
        main_mem_write_request,
        main_mem_op,
        mmu_main_mem_transfer_done_wire,
        mmu_in_buf,
        mmu_out_buf,
        mmu_status
    );

    if (!dma_busy_local && dma_start_local && dma_ready_local) {
        dma_busy_local = true;
        dma_countdown_local = 1;
        dma_addr_latched_local = dma_addr_local;
        dma_len_latched_local = dma_len_local;
        dma_is_write_latched_local = dma_is_write_local;
        dma_use_kv_cache_latched_local = dma_use_kv_cache_local;
    } else if (dma_busy_local) {
        if (dma_countdown_local > 0) {
            dma_countdown_local--;
        } else {
            const uint32_t bytes = dma_len_latched_local;
            if (!dma_is_write_latched_local) {
                const uint32_t rx_words =
                    (bytes + static_cast<uint32_t>(AXI_GMEM_WORD_BYTES) - 1u)
                    / static_cast<uint32_t>(AXI_GMEM_WORD_BYTES);
                for (uint32_t i = 0; i < rx_words; ++i) {
                    dma_rx_buf_local[i] = axi_gmem_word_t(0);
                }
            }
            for (uint32_t i = 0; i < bytes; ++i) {
                const uint64_t byte_addr = dma_addr_latched_local + static_cast<uint64_t>(i);
#ifndef __SYNTHESIS__
                const uint64_t sim_byte_addr = map_csim_ddr_addr(byte_addr, ctrl_mem);
#else
                const uint64_t sim_byte_addr = byte_addr;
#endif
                const uint64_t word_idx_raw =
                    sim_byte_addr / static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
                const uint32_t lane =
                    static_cast<uint32_t>(sim_byte_addr % static_cast<uint64_t>(AXI_GMEM_WORD_BYTES));
                const uint64_t idx = word_idx_raw;
                if (dma_use_kv_cache_latched_local) {
                    axi_gmem_word_t beat = kv_cache[idx];
                    if (dma_is_write_latched_local) {
                        gmem_set_byte(beat, lane, dma_buf_get_byte(dma_tx_buf_local, i));
                        kv_cache[idx] = beat;
                    } else {
                        dma_buf_set_byte(dma_rx_buf_local, i, gmem_get_byte(beat, lane));
                    }
                } else {
                    axi_gmem_word_t beat = ddr_mem[idx];
                    if (dma_is_write_latched_local) {
                        gmem_set_byte(beat, lane, dma_buf_get_byte(dma_tx_buf_local, i));
                        ddr_mem[idx] = beat;
                    } else {
                        dma_buf_set_byte(dma_rx_buf_local, i, gmem_get_byte(beat, lane));
                    }
                }
            }
            dma_busy_local = false;
            dma_done_local = true;
        }
    } else {
        dma_done_local = false;
    }

    if (!stream_tx_active_local && stream_start_local) {
        stream_tx_active_local = true;
        stream_tx_index_local  = 0;
        stream_tx_len_local    = full_out_bytes_for_op(latched_op);
    }
    // AXI4-Stream egress: pack up to 64 bytes per 512-bit beat.
    if (stream_tx_active_local) {
        axis512_t out_beat{};
        out_beat.data = ap_uint<AXI_GMEM_WORD_BITS>(0);
        out_beat.keep = ap_uint<AXI_GMEM_WORD_BYTES>(0);
        out_beat.strb = ap_uint<AXI_GMEM_WORD_BYTES>(0);

        const uint32_t bytes_remaining = stream_tx_len_local - stream_tx_index_local;
        const uint32_t this_beat_bytes =
            (bytes_remaining > static_cast<uint32_t>(AXI_GMEM_WORD_BYTES))
            ? static_cast<uint32_t>(AXI_GMEM_WORD_BYTES)
            : bytes_remaining;

        for (uint32_t b = 0; b < static_cast<uint32_t>(AXI_GMEM_WORD_BYTES); ++b) {
#pragma HLS UNROLL
            if (b < this_beat_bytes) {
                out_beat.data.range(b * 8u + 7u, b * 8u) =
                    static_cast<ap_uint<8>>(stream_out_buf_local[stream_tx_index_local + b]);
                out_beat.keep[b] = 1;
                out_beat.strb[b] = 1;
            }
        }
        const bool is_last = (stream_tx_index_local + this_beat_bytes >= stream_tx_len_local);
        out_beat.last = is_last ? ap_uint<1>(1) : ap_uint<1>(0);

        if (m_axis_out.write_nb(out_beat)) {
            stream_tx_index_local += this_beat_bytes;
            if (is_last) {
                stream_tx_active_local  = false;
                stream_done_pulse_local = true;
                stream_tx_index_local   = 0;
            }
        }
    }

    ctrl_mem_interface.check_errors(ctrl_mem,
                                    scheduler_error,
                                    compute_error,
                                    mmu_status.invalid,
                                    mmu_status.overflow,
                                    mmu_status.error_code,
                                    mmu_status.error_subcode);
    ctrl_mem_interface.check_control(ctrl_mem, done);
    active_status_mem.status = static_cast<uint32_t>(state_local);
    active_status_mem.layer_index = scheduler_layer_index_local;
    active_status_mem.token_index = static_cast<uint32_t>(token_position_local);
    active_status_mem.cfg_num_layers = static_cast<uint32_t>(NUM_LAYERS);
    active_status_mem.cfg_d_model = static_cast<uint32_t>(D_MODEL);
    active_status_mem.cfg_d_ffn = static_cast<uint32_t>(D_FFN);
    active_status_mem.cfg_d_vocab = static_cast<uint32_t>(D_VOCAB);
    active_status_mem.cfg_context_length = static_cast<uint32_t>(CONTEXT_LENGTH);
    active_status_mem.cfg_d_heads = static_cast<uint32_t>(D_HEADS);
    active_status_mem.cfg_num_heads = static_cast<uint32_t>(NUM_HEADS);
    active_status_mem.cfg_d_tile_wo = static_cast<uint32_t>(D_TILE_WO);
    active_status_mem.cfg_d_tile_w1 = static_cast<uint32_t>(D_TILE_W1);
    active_status_mem.cfg_d_tile_w2 = static_cast<uint32_t>(D_TILE_W2);
    active_status_mem.cfg_d_head_tile_qkv = static_cast<uint32_t>(D_HEAD_TILE_QKV);
    active_status_mem.cfg_att_ctx_block = static_cast<uint32_t>(ATT_CTX_BLOCK);
    active_status_mem.cfg_d_head_tile_att_value = static_cast<uint32_t>(D_HEAD_TILE_ATT_VALUE);
    irq_ps = ctrl_mem_interface.compute_irq(ctrl_mem.irq_mask);

    status_mem = active_status_mem;
    dbg_state = state_local;
}
