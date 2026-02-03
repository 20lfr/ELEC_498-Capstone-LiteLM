#pragma once
#include "../top_params.hpp"

class ControlMemInterface {
private:
    StatusMemSpace local_status;
    
public:
    ControlMemInterface() {
        local_status = {0, 0, 0, 0};
    }

    // 1. Process Inputs (PS -> PL)
    // Call this at the start
    void update_inputs(const ControlMemSpace &config) {

        // Check DMA Length (all must be non-zero)
        if (config.dma_layer_len == 0 || config.dma_head_len == 0 || config.dma_tile_len == 0) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_DMA_ZERO_LEN;
        }

        // Check strides are non-zero (zero stride causes DMA issues)
        if (config.layer_stride == 0 || 
            config.wq_head_stride == 0 || config.wk_head_stride == 0 || config.wv_head_stride == 0 ||
            config.k_cache_stride == 0 || config.v_cache_stride == 0 ||
            config.wo_tile_stride == 0 || config.w1_tile_stride == 0 || config.w2_tile_stride == 0) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_DMA_ZERO_LEN;  // Reuse zero-length error code
        }

        // Base address alignment (check 64-byte alignment for all DMA addresses)
        if ((config.wq_base_addr & 0x3F) != 0 || (config.wk_base_addr & 0x3F) != 0 || 
            (config.wv_base_addr & 0x3F) != 0 || (config.wo_base_addr & 0x3F) != 0 ||
            (config.w1_base_addr & 0x3F) != 0 || (config.w2_base_addr & 0x3F) != 0 ||
            (config.k_cache_addr & 0x3F) != 0 || (config.v_cache_addr & 0x3F) != 0) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_DMA_ALIGNMENT;
        }

        // other safety checks
        // ...

        // Handle "Write-1-to-Clear" logic here (runs last so PS can clear errors)
        if (config.irq_clear != 0) {
            local_status.irq_status &= ~config.irq_clear;
            // clear error code if error flag is cleared
            if (config.irq_clear & IRQ_ERROR_BIT) {
                local_status.error_code = ERR_NONE;
                local_status.status &= ~STATUS_ERROR;
            }
        }
    }

    // 2. Output State (PL -> PS)
    // call at the end to push data to AXI
    StatusMemSpace& get_mutable_status() {
        return local_status;
    }
};
