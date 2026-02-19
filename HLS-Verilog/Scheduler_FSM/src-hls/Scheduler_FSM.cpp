#include "Scheduler_FSM.hpp"
#include "../../Weight_Loader-Stager/Weight_stager.hpp"
#include <cstdint>

// Minimal, single-path scheduler FSM used to bring RTL back to a known-good
// baseline. All I/O signatures are preserved, but parallel head handling and
// resource arbitration are stripped out. Each state launches at most one
// compute operation and waits for its corresponding done pulse before
// advancing.

// Drive a three-step LayerNorm (reduction -> scalar math -> elementwise) using
// the shared compute interface.
// Pass 1 (reduction):
//   1) S = sum_i y_i
//   2) Q = sum_i y_i^2
// Scalar computation:
//   3) mu        = S / d
//   4) E[y^2]    = Q / d
//   5) sigma2    = E[y^2] - mu^2
//   6) v         = sigma2 + eps
//   7) inv_std   = 1 / sqrt(v)
// Pass 2 (element-wise):
//   8) y_hat[i]  = (y_i - mu) * inv_std
//   9) z_i       = gamma_i * y_hat[i]
//  10) o_i       = z_i + beta_i
// Output: o_i
static inline uint32_t pack_compute_instruction(ComputeOp op, int layer, int head, int tile) {
#pragma HLS INLINE
  const uint32_t op_field = static_cast<uint32_t>(op) & 0xFFu;
  const uint32_t layer_field = static_cast<uint32_t>(layer) & 0xFFu;
  const uint32_t head_field = static_cast<uint32_t>(head) & 0xFFu;
  const uint32_t tile_field = static_cast<uint32_t>(tile) & 0xFFu;
  return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}

static inline uint32_t pack_dma_op(DmaSel op, int layer, int head, int tile) {
#pragma HLS INLINE
  const uint32_t op_field = static_cast<uint32_t>(op) & 0xFFu;
  const uint32_t layer_field = static_cast<uint32_t>(layer) & 0xFFu;
  const uint32_t head_field = static_cast<uint32_t>(head) & 0xFFu;
  const uint32_t tile_field = static_cast<uint32_t>(tile) & 0xFFu;
  return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}



void scheduler_hls(
    // ------------------------------------------------------------
    // AXI4-Lite CONTROL INTERFACE (PS → PL)
    // ------------------------------------------------------------
    ControlMemSpace ctrl_mem,
    StatusMemSpace &status_mem,

    // ------------------------------------------------------------
    // AXI4-STREAM INPUT (INGRESS: PS → PL)
    // ------------------------------------------------------------
    bool axis_in_valid,  // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,   // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready, // [OUTPUT] s_axis_in_tready

    // ------------------------------------------------------------
    // Memory Management System (WEIGHT LOADER via DMA)
    // ------------------------------------------------------------
    bool      dma_done,        // [INPUT]  DMA transfer completed (single-cycle pulse)
    bool      wl_ready,         // [INPUT]  Weight loader ready for a new request
    bool      wl_accept,        // [INPUT]  MMU accepted/captured scheduler wl request
    uint32_t  &wl_instruction,
    bool      &wl_start,        // [OUTPUT] Start weight load DMA

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)`
    // ------------------------------------------------------------
    bool compute_ready,  // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,   // [INPUT]  Compute operation finished (one-shot)
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]  Per-head context (in/out)
    int   &head_group_idx,        // [OUTPUT]  Current head group index (0 to NUM_HEADS/HEADS_PARALLEL-1) 
    bool &compute_start, // [OUTPUT] Trigger compute engine
    uint32_t &compute_instruction,     // [OUTPUT] Packed op|layer|head|tile for compute
    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start, // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,   // [INPUT]  Stream-out finished entire sequence

    // ------------------------------------------------------------
    // GLOBAL COMPLETION FLAG
    // ------------------------------------------------------------
    bool &done, // [OUTPUT] Inference pipeline fully complete
    bool &error, // [OUTPUT] Error flag (not used in this minimal FSM)
    SchedState &STATE // [OUTPUT] Current scheduler state

    // ------------------------------------------------------------
    // DEBUG STATE OUTPUT
    // ------------------------------------------------------------
    
) {
#pragma HLS INLINE off
#pragma HLS ARRAY_PARTITION variable=head_ctx_ref cyclic factor=HEADS_PARALLEL dim=1

  // Core FSM state
  static SchedState st;
#pragma HLS reset variable = st
  static int layer_idx;
#pragma HLS reset variable = layer_idx
    
  // One-shot guards for start pulses in each state
  static bool attn_started;
#pragma HLS reset variable = attn_started
  static bool attn_done;
#pragma HLS reset variable = attn_done
  static bool attn_compute_done;
#pragma HLS reset variable = attn_compute_done
  static bool concat_dma_done;
#pragma HLS reset variable = concat_dma_done
  static bool outproj_compute_done;
#pragma HLS reset variable = outproj_compute_done
  static bool resid0_compute_done;
#pragma HLS reset variable = resid0_compute_done
  static bool ln0_compute_done;
#pragma HLS reset variable = ln0_compute_done
  static bool ffn_w1_compute_done;
#pragma HLS reset variable = ffn_w1_compute_done
  static bool ffn_act_compute_done;
#pragma HLS reset variable = ffn_act_compute_done
  static bool ffn_w2_compute_done;
#pragma HLS reset variable = ffn_w2_compute_done
  static bool resid1_compute_done;
#pragma HLS reset variable = resid1_compute_done
  static bool ln1_compute_done;
#pragma HLS reset variable = ln1_compute_done
  static bool requant1_compute_done;
#pragma HLS reset variable = requant1_compute_done
  static bool requant2_compute_done;
#pragma HLS reset variable = requant2_compute_done
  static bool requant3_compute_done;
#pragma HLS reset variable = requant3_compute_done
  static bool requant4_compute_done;
#pragma HLS reset variable = requant4_compute_done
  static bool error_latched;
#pragma HLS reset variable = error_latched


// HEADED ATTENTION DATA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static bool attn_group_done;
#pragma HLS reset variable = attn_group_done
  static int group_idx;
#pragma HLS reset variable = group_idx
  static bool start_head_group;
#pragma HLS reset variable = start_head_group
// HEADED ATTENTION DATA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// POST-HEADED ATTENTION DATA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static bool concat_started;
#pragma HLS reset variable = concat_started
  static bool concat_dma_busy;
#pragma HLS reset variable = concat_dma_busy
  static bool outproj_started;
#pragma HLS reset variable = outproj_started
  static bool requant1_started;
#pragma HLS reset variable = requant1_started
  static bool resid0_started;
#pragma HLS reset variable = resid0_started
  static bool ln0_started;
#pragma HLS reset variable = ln0_started
  static bool ln0_dma_busy;
#pragma HLS reset variable = ln0_dma_busy
  static bool ln0_comp_busy;
#pragma HLS reset variable = ln0_comp_busy
  static bool requant2_started;
#pragma HLS reset variable = requant2_started
  enum class FfnStage : uint8_t { W1 = 0, ACT, W2 };
  static FfnStage ffn_stage;
#pragma HLS reset variable = ffn_stage
  static bool ffn_started;
#pragma HLS reset variable = ffn_started
  static bool requant3_started;
#pragma HLS reset variable = requant3_started
  static bool resid1_started;
#pragma HLS reset variable = resid1_started
  static bool ln1_started;
#pragma HLS reset variable = ln1_started
  static bool ln1_dma_busy;
#pragma HLS reset variable = ln1_dma_busy
  static bool ln1_comp_busy;
#pragma HLS reset variable = ln1_comp_busy
  static bool requant4_started;
#pragma HLS reset variable = requant4_started
  static bool final_norm_started;
#pragma HLS reset variable = final_norm_started
  static bool stream_started;
#pragma HLS reset variable = stream_started
  static int wo_tile;
#pragma HLS reset variable = wo_tile
  static bool wo_dma_busy;
#pragma HLS reset variable = wo_dma_busy
  static bool wo_comp_busy;
#pragma HLS reset variable = wo_comp_busy
  static int w1_tile;
#pragma HLS reset variable = w1_tile
  static bool w1_dma_busy;
#pragma HLS reset variable = w1_dma_busy
  static bool w1_comp_busy;
#pragma HLS reset variable = w1_comp_busy
  static int w2_tile;
#pragma HLS reset variable = w2_tile
  static bool w2_dma_busy;
#pragma HLS reset variable = w2_dma_busy
  static bool w2_comp_busy;
#pragma HLS reset variable = w2_comp_busy


  static bool wo_dma_done;
#pragma HLS reset variable = wo_dma_done
  static bool ln0_dma_done;
#pragma HLS reset variable = ln0_dma_done
  static bool ln1_dma_done;
#pragma HLS reset variable = ln1_dma_done
  static bool w1_dma_done;
#pragma HLS reset variable = w1_dma_done
  static bool w2_dma_done;
#pragma HLS reset variable = w2_dma_done
  static bool stream_done_seen;
#pragma HLS reset variable = stream_done_seen
  static bool final_norm_compute_done;
#pragma HLS reset variable = final_norm_compute_done
// POST-HEADED ATTENTION DATA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  // Control Memory Local Logic
  const bool cntrl_reset_n = (ctrl_mem.control & CTRL_RESETN_BIT) != 0;
  const bool reset = !cntrl_reset_n;
  const bool busy = (st != S_IDLE);
  // Mirror busy into status bit 2 without clobbering other bits
  status_mem.status = (status_mem.status & ~STATUS_BUSY_BIT) | (busy ? STATUS_BUSY_BIT : 0);
  // Expose a start bit that auto-clears once we leave IDLE
  const bool cntrl_start = (ctrl_mem.control & CTRL_START_BIT) != 0;
  const bool ctrl_error =
      ((status_mem.irq_status & IRQ_ERROR_BIT) != 0) ||
      ((status_mem.status & STATUS_ERROR) != 0) ||
      (status_mem.error_code != ERR_NONE);

  // FSM Reset
  if (reset) {
    st = S_IDLE;
    layer_idx = 0;
    // LayerNorm op tables

    // Attention
    attn_started = false;
    attn_done = false;
    attn_compute_done = false;
    attn_group_done = false;
    group_idx = 0;

    start_head_group = false;
    for (int i = 0; i < NUM_HEADS; ++i){
#pragma HLS UNROLL
        init_head_ctx(head_ctx_ref[i], -1, i);
    }
    
    // Requant
    requant1_started = false;
    requant2_started = false;
    requant3_started = false;
    requant4_started = false;

    requant1_compute_done = false;
    requant2_compute_done = false;
    requant3_compute_done = false;
    requant4_compute_done = false;


    // Head concat
    concat_dma_done = false;
    concat_started = false;
    concat_dma_busy = false;

    // Output projection
    outproj_started = false;
    outproj_compute_done = false;
    wo_dma_done = false;
    ln0_dma_done = false;
    ln1_dma_done = false;
    w1_dma_done = false;
    w2_dma_done = false;

    // Residual + LN (1st)
    resid0_started = false;
    resid0_compute_done = false;
    ln0_started = false;
    ln0_dma_busy = false;
    ln0_comp_busy = false;
    ln0_compute_done = false;

    // FFN
    ffn_w1_compute_done = false;
    ffn_act_compute_done = false;
    ffn_w2_compute_done = false;
    ffn_stage = FfnStage::W1;
    ffn_started = false;

    // Residual + LN (2nd)
    resid1_started = false;
    resid1_compute_done = false;
    ln1_started = false;
    ln1_dma_busy = false;
    ln1_comp_busy = false;
    ln1_compute_done = false;
    final_norm_started = false;
    final_norm_compute_done = false;
    stream_done_seen = false;

    // Global progress/tiles
    stream_started = false;
    wo_tile = 0;
    wo_dma_busy = false;
    wo_comp_busy = false;
    w1_tile = 0;
    w1_dma_busy = false;
    w1_comp_busy = false;
    w2_tile = 0;
    w2_dma_busy = false;
    w2_comp_busy = false;

    // Compute params
    compute_start = false;
    compute_instruction= pack_compute_instruction(ComputeOp::CMP_NONE, layer_idx, -1, -1);

    // Weight Stager and Loader params
    wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);
    wl_start = false;
    done = false;
    error = false;
    error_latched = false;
  }

  // Default outputs
  status_mem.layer_index = layer_idx;
  axis_in_ready = 0;
  if (wl_accept && wl_start){
        wl_start = false;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);
  }
  // wl_start = 0;
  if (!compute_ready && compute_start){
      compute_start = false;
      compute_instruction   = pack_compute_instruction(ComputeOp::CMP_NONE, layer_idx, -1, -1);
  }
  stream_start = 0;
  done = 0;

  if (reset) {
    head_group_idx = 0;
    STATE = st;
    return;
  }

  // Stall FSM whenever a ControlMemInterface error is latched.
  if (ctrl_error) {
    // Cancel all outputs and hold in error state
    axis_in_ready = 0;
    wl_start = false;
    wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);
    compute_start = false;
    compute_instruction = pack_compute_instruction(ComputeOp::CMP_NONE, layer_idx, -1, -1);
    stream_start = 0;
    done = 0;
    error = true;
    error_latched = true;
    head_group_idx = group_idx;
    STATE = st;
    return;
  }

  // If an error was latched and is now cleared, restart the current phase.
  if (error_latched) {
    switch (st) {
      case S_STREAM_IN: {
        break;
      }
      case S_LAYER_COUNT: {
        attn_started = false;
        attn_compute_done = false;
        attn_done = false;
        attn_group_done = false;
        group_idx = 0;
        start_head_group = true;
        requant1_started = false;
        requant2_started = false;
        requant3_started = false;
        requant4_started = false;
        requant1_compute_done = false;
        requant2_compute_done = false;
        requant3_compute_done = false;
        requant4_compute_done = false;
        concat_started = false;
        concat_dma_done = false;
        concat_dma_busy = false;
        outproj_started = false;
        outproj_compute_done = false;
        ln0_dma_done = false;
        ln1_dma_done = false;
        resid0_started = false;
        resid0_compute_done = false;
        ln0_started = false;
        ln0_dma_busy = false;
        ln0_comp_busy = false;
        ln0_compute_done = false;
        ffn_stage = FfnStage::W1;
        ffn_started = false;
        ffn_w1_compute_done = false;
        ffn_act_compute_done = false;
        ffn_w2_compute_done = false;
        resid1_started = false;
        resid1_compute_done = false;
        ln1_started = false;
        ln1_dma_busy = false;
        ln1_comp_busy = false;
        ln1_compute_done = false;
        final_norm_started = false;
        final_norm_compute_done = false;
        stream_started = false;
        wo_tile = 0;
        wo_dma_busy = false;
        wo_comp_busy = false;
        w1_tile = 0;
        w1_dma_busy = false;
        w1_comp_busy = false;
        w2_tile = 0;
        w2_dma_busy = false;
        w2_comp_busy = false;
        wl_start = false;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);
        compute_start = false;
        compute_instruction = pack_compute_instruction(ComputeOp::CMP_NONE, layer_idx, -1, -1);
        break;
      }
      case S_LAYER_NORM_0: {
        ln0_started = false;
        ln0_dma_busy = false;
        ln0_comp_busy = false;
        ln0_dma_done = false;
        ln0_compute_done = false;
        break;
      }
      case S_REQUANT1: {
        requant1_started = false;
        requant1_compute_done = false;
        break;
      }
      case S_ATTENTION_HEADS: {
        attn_started = false;
        attn_compute_done = false;
        attn_done = false;
        attn_group_done = false;
        group_idx = 0;
        start_head_group = true;
        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
          init_head_ctx(head_ctx_ref[i], layer_idx, i);
        }
        break;
      }
      case S_HEAD_CONCAT: {
        concat_started = false;
        concat_dma_done = false;
        concat_dma_busy = false;
        break;
      }
      case S_OUT_PROJECTION: {
        outproj_started = false;
        outproj_compute_done = false;
        wo_tile = 0;
        wo_dma_busy = false;
        wo_comp_busy = false;
        wo_dma_done = false;
        break;
      }
      case S_REQUANT2: {
        requant2_started = false;
        requant2_compute_done = false;
        break;
      }
      case S_RES_ADD_1: {
        resid0_started = false;
        resid0_compute_done = false;
        break;
      }
      case S_LAYER_NORM_1: {
        ln1_started = false;
        ln1_dma_busy = false;
        ln1_comp_busy = false;
        ln1_dma_done = false;
        ln1_compute_done = false;
        break;
      }
      case S_REQUANT3: {
        requant3_started = false;
        requant3_compute_done = false;
        break;
      }
      case S_FFN: {
        ffn_started = false;
        ffn_stage = FfnStage::W1;
        ffn_w1_compute_done = false;
        ffn_act_compute_done = false;
        ffn_w2_compute_done = false;
        w1_tile = 0;
        w2_tile = 0;
        w1_dma_busy = false;
        w2_dma_busy = false;
        w1_comp_busy = false;
        w2_comp_busy = false;
        w1_dma_done = false;
        w2_dma_done = false;
        break;
      }
      case S_REQUANT4: {
        requant4_started = false;
        requant4_compute_done = false;
        break;
      }
      case S_RES_ADD_2: {
        resid1_started = false;
        resid1_compute_done = false;
        break;
      }
      case S_LOOP_CHECK: {
        break;
      }
      case S_FINAL_NORM: {
        final_norm_started = false;
        final_norm_compute_done = false;
        break;
      }
      case S_STREAM_OUT: {
        stream_started = false;
        stream_done_seen = false;
        break;
      }
      case S_IDLE:
      default:
        break;
    }
    error_latched = false;
  }

  // Sticky stream_done capture
  if (stream_started && stream_done) {
    stream_done_seen = true;
  } else if (!stream_started) {
    stream_done_seen = false;
  }
  
  // Sticky capture of DMA done per phase so single-cycle pulses are retained temporarily,
  // mirroring the compute_done pattern.
  if (dma_done) {
    if (st == S_OUT_PROJECTION && outproj_started && wo_dma_busy) wo_dma_done = true;
    if (st == S_LAYER_NORM_0 && ln0_started && ln0_dma_busy) ln0_dma_done = true;
    if (st == S_LAYER_NORM_1 && ln1_started && ln1_dma_busy) ln1_dma_done = true;
    if (st == S_FFN && ffn_started) {
      if (ffn_stage == FfnStage::W1 && w1_dma_busy)      w1_dma_done = true;
      else if (ffn_stage == FfnStage::W2 && w2_dma_busy) w2_dma_done = true;
    }
    if (st == S_HEAD_CONCAT && concat_started && concat_dma_busy) concat_dma_done = true;
  } else {
    if (outproj_started && !wo_dma_busy) wo_dma_done = false;
    if (ln0_started && !ln0_dma_busy) ln0_dma_done = false;
    if (ln1_started && !ln1_dma_busy) ln1_dma_done = false;
    if (ffn_started && (ffn_stage == FfnStage::W1) && !w1_dma_busy) w1_dma_done = false;
    if (ffn_started && (ffn_stage == FfnStage::W2) && !w2_dma_busy) w2_dma_done = false;
    if (st == S_HEAD_CONCAT && concat_started && !concat_dma_busy) concat_dma_done = false;
  }
  if (compute_done && !compute_start) {
    if (st == S_ATTENTION_HEADS && attn_started)  attn_compute_done = true;
    if (st == S_OUT_PROJECTION && outproj_started) outproj_compute_done = true;
    if (st == S_REQUANT1 && requant1_started)     requant1_compute_done = true;
    if (st == S_RES_ADD_1 && resid0_started)      resid0_compute_done = true;
    if (st == S_LAYER_NORM_0 && ln0_started)      ln0_compute_done = true;
    if (st == S_REQUANT2 && requant2_started)     requant2_compute_done = true;
    if (st == S_FFN && ffn_started) {
      if (ffn_stage == FfnStage::W1)              ffn_w1_compute_done = true;
      else if (ffn_stage == FfnStage::ACT)        ffn_act_compute_done = true;
      else if (ffn_stage == FfnStage::W2)         ffn_w2_compute_done = true;
    }
    if (st == S_REQUANT3 && requant3_started)     requant3_compute_done = true;
    if (st == S_RES_ADD_2 && resid1_started)      resid1_compute_done = true;
    if (st == S_LAYER_NORM_1 && ln1_started)      ln1_compute_done = true;
    if (st == S_REQUANT4 && requant4_started)     requant4_compute_done = true;
    if (st == S_FINAL_NORM && final_norm_started) final_norm_compute_done = true;
  }

  int head_group_idx_out = group_idx;

  switch (st) {
    case S_IDLE: {
      if (cntrl_start) {
        st = S_STREAM_IN;

        // Attention
        attn_started = false;
        attn_done = false;
        attn_compute_done = false;
        attn_group_done = false;
        group_idx = 0;
        start_head_group = false;

        // Requant
        requant1_started = false;
        requant2_started = false;
        requant3_started = false;
        requant4_started = false;

        requant1_compute_done = false;
        requant2_compute_done = false;
        requant3_compute_done = false;
        requant4_compute_done = false;

        // Head concat
        concat_started = false;
        concat_dma_done = false;
        concat_dma_busy = false;

        // Output projection
        outproj_started = false;
        outproj_compute_done = false;
        ln0_dma_done = false;
        ln1_dma_done = false;

        // Residual + LN (1st)
        resid0_started = false;
        resid0_compute_done = false;
        ln0_started = false;
        ln0_dma_busy = false;
        ln0_comp_busy = false;
        ln0_compute_done = false;

        // FFN
        ffn_started = false;
        ffn_w1_compute_done = false;
        ffn_act_compute_done = false;
        ffn_w2_compute_done = false;

        // Residual + LN (2nd)
        resid1_started = false;
        resid1_compute_done = false;
        ln1_started = false;
        ln1_dma_busy = false;
        ln1_comp_busy = false;
        ln1_compute_done = false;
        final_norm_started = false;
        final_norm_compute_done = false;

        // Global progress/tiles
        stream_started = false;
        wo_tile = 0;
        wo_dma_busy = false;
        wo_comp_busy = false;
        w1_tile = 0;
        w1_dma_busy = false;
        w1_comp_busy = false;
        w2_tile = 0;
        w2_dma_busy = false;
        w2_comp_busy = false;

        // Weight Stager and Loader params
        wl_start = false;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);

        // Compute params
        compute_start = false;
        compute_instruction= pack_compute_instruction(ComputeOp::CMP_NONE, layer_idx, -1, -1);

        // Weight Stager and Loader params
        wl_start = false;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);

        done = false;
        error = false;
      }
      break;
    }
    case S_STREAM_IN: {
      axis_in_ready = 1;
      // Wait for final ingress beat handshake before starting layer processing.
      if (axis_in_valid && axis_in_last && axis_in_ready) {
        st = S_LAYER_COUNT;
      }
      break;
    }
    case S_LAYER_COUNT: {
      // Reset per-layer guards
      // Attention
      attn_started = false;
      attn_compute_done = false;
      attn_done = false;
      attn_group_done = false;
      group_idx = 0;

      start_head_group = true;
      for (int i = 0; i < NUM_HEADS; ++i){
  #pragma HLS UNROLL
          init_head_ctx(head_ctx_ref[i], layer_idx, i);
      }

      // Requant
      requant1_started = false;
      requant2_started = false;
      requant3_started = false;
      requant4_started = false;

      requant1_compute_done = false;
      requant2_compute_done = false;
      requant3_compute_done = false;
      requant4_compute_done = false;

      // Head concat
      concat_started = false;
      concat_dma_done = false;
      concat_dma_busy = false;

      // Output projection
      outproj_started = false;
      outproj_compute_done = false;
      ln0_dma_done = false;
      ln1_dma_done = false;

      // Residual + LN (1st)
      resid0_started = false;
      resid0_compute_done = false;
      ln0_started = false;
      ln0_dma_busy = false;
      ln0_comp_busy = false;
      ln0_compute_done = false;

      // FFN
      ffn_stage = FfnStage::W1;
      ffn_started = false;
      ffn_w1_compute_done = false;
      ffn_act_compute_done = false;
      ffn_w2_compute_done = false;

      // Residual + LN (2nd)
      resid1_started = false;
      resid1_compute_done = false;
      ln1_started = false;
      ln1_dma_busy = false;
      ln1_comp_busy = false;
      ln1_compute_done = false;
      final_norm_started = false;
      final_norm_compute_done = false;

      // Global progress/tiles
      wo_tile = 0;
      wo_dma_busy = false;
      wo_comp_busy = false;
      w1_tile = 0;
      w1_dma_busy = false;
      w1_comp_busy = false;
      w2_tile = 0;
      w2_dma_busy = false;
      w2_comp_busy = false;


      // Weight Stager and Loader params
      wl_start = false;
      wl_instruction = pack_dma_op(DmaSel::DMASEL_NONE, layer_idx, -1, -1);
      done = false;
      st = S_LAYER_NORM_0;

      break;}
    case S_LAYER_NORM_0: {
      if (!ln0_started && wl_ready) {
        ln0_compute_done = false;
        ln0_dma_done = false;
        wl_start = 1;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_LN0, layer_idx, -1, -1);
        ln0_started = true;
        ln0_dma_busy = true;
      } else if (ln0_started && ln0_dma_busy && ln0_dma_done) {
        ln0_dma_busy = false;
        ln0_dma_done = false;
        ln0_comp_busy = true;
      } else if (ln0_started && ln0_comp_busy && compute_ready) {
        ln0_compute_done = false;
        compute_start = 1;
        compute_instruction = pack_compute_instruction(CMP_LN0, layer_idx, -1, -1);
        ln0_comp_busy = false;
      } else if (ln0_started && !ln0_dma_busy && !ln0_comp_busy && ln0_compute_done) {
        ln0_started = false;
        ln0_compute_done = false;
        st = S_ATTENTION_HEADS;
      }
      break;
    }
    case S_REQUANT1: {
      st = S_ATTENTION_HEADS;
      break;
    }
    case S_ATTENTION_HEADS: {
      // Multiple, parallel attention

      const int group_base = group_idx * HEADS_PARALLEL;

      // Drive current head group; compute handshake handled externally
      head_group_idx_out = group_idx;
      attn_group_done = drive_group_head_phase(head_ctx_ref, group_base, layer_idx, start_head_group);

      // Kick off the first group as soon as we enter this state
      if (!attn_started) {
        attn_started = true;
        start_head_group = true;
      }

      // When a group finishes, advance to the next
      if (attn_started){
        if (attn_group_done) {
          group_idx++;
          start_head_group = true;
          if (group_idx >= NUM_HEAD_GROUPS) {
            attn_started = false;
            group_idx = 0;
            start_head_group = false;
            st = S_HEAD_CONCAT;
          }
        }else{
          start_head_group = false;
        }
      }
      
      break;
    }
    case S_HEAD_CONCAT: {
      if (!concat_started && wl_ready) {
        concat_dma_done = false;
        wl_start = 1;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_CONCAT, layer_idx, -1, -1);
        concat_started = true;
        concat_dma_busy = true;
      } else if (concat_started && concat_dma_busy && concat_dma_done) {
        concat_started = false;
        concat_dma_done = false;
        concat_dma_busy = false;
        st = S_OUT_PROJECTION;
      }
      break;
    }
    case S_OUT_PROJECTION: {
      if (wo_tile >= NUM_WO_TILES) {
        resid0_started = false;
        st = S_RES_ADD_1;
        break;
      }

      if (!outproj_started && wl_ready) {
        wl_start = 1;

        wl_instruction = pack_dma_op(DmaSel::DMASEL_WO, layer_idx, -1, wo_tile);
        wo_dma_busy = true;
        outproj_started = true;
      } else if (outproj_started && wo_dma_busy && wo_dma_done) {
        wo_dma_busy = false;
        wo_dma_done = false;
        wo_comp_busy = true;
      } else if (outproj_started && wo_comp_busy && compute_ready) {
        outproj_compute_done = false;
        compute_start = 1;
        compute_instruction= pack_compute_instruction(CMP_OUT_PROJ, layer_idx, -1, wo_tile);
        wo_comp_busy = false;
      } else if (outproj_started && !wo_dma_busy && !wo_comp_busy &&
                outproj_compute_done) {
        outproj_started = false;
        outproj_compute_done = false;
        wo_tile++;
      }
      break;
    }
    case S_REQUANT2: {
      st = S_RES_ADD_1;
      break;
    }
    case S_RES_ADD_1: {
      if (!resid0_started && compute_ready) {
        resid0_compute_done = false;
        compute_start = 1;
        compute_instruction= pack_compute_instruction(CMP_RESID1, layer_idx, -1, -1);
        resid0_started = true;
      } else if (resid0_started && resid0_compute_done) {
        resid0_started = false;
        resid0_compute_done = false;
        st = S_LAYER_NORM_1;
      }
      break;
    }
    case S_LAYER_NORM_1: {
      if (!ln1_started && wl_ready) {
        ln1_compute_done = false;
        ln1_dma_done = false;
        wl_start = 1;
        wl_instruction = pack_dma_op(DmaSel::DMASEL_LN1, layer_idx, -1, -1);
        ln1_started = true;
        ln1_dma_busy = true;
      } else if (ln1_started && ln1_dma_busy && ln1_dma_done) {
        ln1_dma_busy = false;
        ln1_dma_done = false;
        ln1_comp_busy = true;
      } else if (ln1_started && ln1_comp_busy && compute_ready) {
        ln1_compute_done = false;
        compute_start = 1;
        compute_instruction= pack_compute_instruction(CMP_LN1, layer_idx, -1, -1);
        ln1_comp_busy = false;
      } else if (ln1_started && !ln1_dma_busy && !ln1_comp_busy && ln1_compute_done) {
        ln1_started = false;
        ln1_compute_done = false;
        st = S_FFN;
      }
      break;
    }
    case S_REQUANT3: {
      st = S_FFN;
      break;
    }
    case S_FFN: {
      // Serialize W1 -> ACT -> W2
      switch (ffn_stage) {
        case FfnStage::W1: {
          if (w1_tile >= NUM_W1_TILES) {
            ffn_started = false;
            ffn_stage = FfnStage::ACT;
            break;
          }

          if (!ffn_started && wl_ready) {
            wl_start = 1;
            wl_instruction = pack_dma_op(DmaSel::DMASEL_W1, layer_idx, -1, w1_tile);
            w1_dma_busy = true;
            ffn_started = true;
          } else if (ffn_started && w1_dma_busy && (dma_done || w1_dma_done)) {
            w1_dma_busy = false;
            w1_dma_done = false;
            w1_comp_busy = true;
          } else if (ffn_started && w1_comp_busy && compute_ready) {
            ffn_w1_compute_done = false;
            compute_start = 1;
            compute_instruction= pack_compute_instruction(CMP_FFN_W1, layer_idx, -1, w1_tile);
            w1_comp_busy = false;
          } else if (ffn_started && !w1_dma_busy && !w1_comp_busy &&
                    ffn_w1_compute_done) {
            ffn_started = false;
            ffn_w1_compute_done = false;
            w1_tile++;
          }
          break;
        }
        case FfnStage::ACT:{
          if (!ffn_started && compute_ready) {
            ffn_act_compute_done = false;
            compute_start = 1;
            compute_instruction= pack_compute_instruction(CMP_FFN_ACT, layer_idx, -1, -1);
            ffn_started = true;
          } else if (ffn_started && ffn_act_compute_done) {
            ffn_started = false;
            ffn_act_compute_done = false;
            ffn_stage = FfnStage::W2;
          }
          break;
        }
        case FfnStage::W2: {
          if (w2_tile >= NUM_W2_TILES) {
            ffn_started = false;
            ffn_stage = FfnStage::W1;
            st = S_RES_ADD_2;
            break;
          }

          if (!ffn_started && wl_ready) {
            wl_start = 1;
            wl_instruction = pack_dma_op(DmaSel::DMASEL_W2, layer_idx, -1, w2_tile);
            w2_dma_busy = true;
            ffn_started = true;
          } else if (ffn_started && w2_dma_busy && (dma_done || w2_dma_done)) {
            w2_dma_busy = false;
            w2_dma_done = false;
            w2_comp_busy = true;
          } else if (ffn_started && w2_comp_busy && compute_ready) {
            ffn_w2_compute_done = false;
            compute_start = 1;
            compute_instruction= pack_compute_instruction(CMP_FFN_W2, layer_idx, -1, w2_tile);
            w2_comp_busy = false;
          } else if (ffn_started && !w2_dma_busy && !w2_comp_busy &&
                    ffn_w2_compute_done) {
            ffn_started = false;
            ffn_w2_compute_done = false;
            w2_tile++;
          }
          break;
        }
      }
        break;
    }
    case S_REQUANT4: {
      st = S_RES_ADD_2;
      break;
    }
    case S_RES_ADD_2: {
      if (!resid1_started && compute_ready) {
        resid1_compute_done = false;
        compute_start = 1;
        compute_instruction= pack_compute_instruction(CMP_RESID2, layer_idx, -1, -1);
        resid1_started = true;
      } else if (resid1_started && resid1_compute_done) {
        resid1_started = false;
        resid1_compute_done = false;
        st = S_LOOP_CHECK;
      }
      break;
    }
    case S_LOOP_CHECK: {
      if (layer_idx + 1 < NUM_LAYERS) {
        layer_idx++;
        st = S_LAYER_COUNT;
      } else {
        final_norm_started = false;
        final_norm_compute_done = false;
        st = S_FINAL_NORM;
        stream_started = false;
      }
      break;
    }
    case S_FINAL_NORM: {
      if (!final_norm_started && compute_ready) {
        final_norm_compute_done = false;
        compute_start = 1;
        // Reuse LN1 opcode for the terminal norm.
        compute_instruction= pack_compute_instruction(CMP_FINAL_NORM, layer_idx, -1, -1);
        final_norm_started = true;
      } else if (final_norm_started && final_norm_compute_done) {
        final_norm_started = false;
        final_norm_compute_done = false;
        st = S_STREAM_OUT;
      }
      break;
    }
    case S_STREAM_OUT: {
      if (!stream_started && stream_ready) {
        stream_start = 1;
        stream_started = true;
      } else if (stream_started && (stream_done_seen || stream_done)) {
        stream_started = false;
        stream_done_seen = false;
        done = 1;
        st = S_IDLE;
      }
      break;
    }
  }
    head_group_idx = head_group_idx_out;
    STATE = st;
}
