#pragma once

#include <cstdint>
#include "Head_Helpers/head_helpers.hpp"
#include "../../top_params.hpp"


// ------------------------------------------------------------
// Scheduler FSM top-level
// ------------------------------------------------------------
void scheduler_hls(
    bool cntrl_reset_n,
    bool cntrl_start,
    bool debug_mode_en,
    bool ctrl_error,
    bool axis_token_complete,
    bool      dma_done,
    bool      wl_ready,
    bool      wl_accept,
    uint64_t  &wl_instruction,
    bool      &wl_start,
    bool        compute_ready,
    bool        compute_done,
    HeadCtx (&head_ctx_ref)[HEADS_PARALLEL],
    int         &head_group_idx,
    bool        &compute_start,
    uint64_t   &compute_instruction,
    bool        debug_done,
    bool        stream_ready,
    bool        &stream_start,
    bool        stream_done,
    bool        &done,
    bool &error,
    uint32_t &layer_index_out,
    SchedState &STATE
);
