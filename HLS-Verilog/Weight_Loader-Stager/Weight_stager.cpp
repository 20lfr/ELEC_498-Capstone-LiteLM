#include "Weight_stager.hpp"

uint32_t weight_stager(   
    bool        reset,
    bool        wl_start,       
    DmaSel      wl_addr_sel, 
    int         wl_layer,     
    int         wl_head,        
    int         wl_tile, 
    ControlMemSpace ctrl_mem,

    bool        &wl_ready,
    bool        &memory_request,
    bool        &error
) {
#pragma HLS INLINE
    static uint32_t addr_latched = 0;
#pragma HLS reset variable = addr_latched
    wl_ready = true;
    memory_request = false;

    if (reset) {
        addr_latched = 0;
        wl_ready = true;
        memory_request = false;
        error = false;
        return 0;
    }

    // Basic validation
    if (wl_start && (wl_layer < 0)) {
        wl_ready = false;
        error = true;
        return 0;
    }
    // Head validation (if requesting head-specific DMA)
    if (wl_start && (wl_head < 0) && (wl_addr_sel == DmaSel::DMASEL_WQ || 
                                    wl_addr_sel == DmaSel::DMASEL_WK || 
                                    wl_addr_sel == DmaSel::DMASEL_WV || 
                                    wl_addr_sel == DmaSel::DMASEL_CTX_K || 
                                    wl_addr_sel == DmaSel::DMASEL_CTX_V)) {
        wl_ready = false;
        error = true;
        return 0;
    }
    // Tile validation (if requesting tile-specific DMA)
    if (wl_start && (wl_tile < 0) && (wl_addr_sel == DmaSel::DMASEL_WO || 
                                    wl_addr_sel == DmaSel::DMASEL_W1 || 
                                    wl_addr_sel == DmaSel::DMASEL_W2)) {
        wl_ready = false;
        error = true;
        return 0;
    }
    if (wl_start) {
        wl_ready = false;
        switch (wl_addr_sel) {
            case DmaSel::DMASEL_WQ:
                addr_latched = ctrl_mem.wq_base_addr + wl_layer * ctrl_mem.layer_stride + wl_head * ctrl_mem.wq_head_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_WK:
                addr_latched = ctrl_mem.wk_base_addr + wl_layer * ctrl_mem.layer_stride + wl_head * ctrl_mem.wk_head_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_WV:
                addr_latched = ctrl_mem.wv_base_addr + wl_layer * ctrl_mem.layer_stride + wl_head * ctrl_mem.wv_head_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_CTX_K:
                addr_latched = ctrl_mem.k_cache_addr + wl_layer * ctrl_mem.layer_stride + wl_head * ctrl_mem.k_cache_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_CTX_V:
                addr_latched = ctrl_mem.v_cache_addr + wl_layer * ctrl_mem.layer_stride + wl_head * ctrl_mem.v_cache_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_WO:
                addr_latched = ctrl_mem.wo_base_addr + wl_layer * ctrl_mem.layer_stride + wl_tile * ctrl_mem.wo_tile_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_W1:
                addr_latched = ctrl_mem.w1_base_addr + wl_layer * ctrl_mem.layer_stride + wl_tile * ctrl_mem.w1_tile_stride;
                memory_request = true;
                break;
            case DmaSel::DMASEL_W2:
                addr_latched = ctrl_mem.w2_base_addr + wl_layer * ctrl_mem.layer_stride + wl_tile * ctrl_mem.w2_tile_stride;
                memory_request = true;
                break;
            default:
                addr_latched = 0;
                memory_request = false;
                break;
        }
    }
    return addr_latched;
}
