// Declarations for head helper utilities (compute-only).
#pragma once
#include <cstdint>
#include "../../../top_params.hpp"



void init_head_ctx(HeadCtx &ctx, int layer_idx, int head_idx);

// Single-head driver: issues compute_start when ready, advances on compute_done.
// Returns true when the head reaches DONE and is not waiting on compute.
bool run_single_head(
    HeadCtx     &ctx,
    int         layer_idx,
    bool        start, 
    ControlMemSpace ctrl_mem,  
    bool     &error         
);

bool drive_group_head_phase(
    HeadCtx     (&head_ctx_ref)[HEADS_PARALLEL],
    int         layer_idx,
    bool        start, 
    ControlMemSpace ctrl_mem,  
    bool     &error         
);
