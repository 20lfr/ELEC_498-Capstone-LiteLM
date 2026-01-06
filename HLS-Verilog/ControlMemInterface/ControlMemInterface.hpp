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
    void update_inputs(const ControlMemSpace &config, uint32_t irq_clear_mask) {
        // Handle "Write-1-to-Clear" logic here
        if (irq_clear_mask != 0) {
            local_status.irq_status &= ~irq_clear_mask;
            // clear error code if error flag is cleared
            if (irq_clear_mask & IRQ_ERROR_BIT) {
                local_status.error_code = ERR_NONE;
            }
        }

        // Check DMA Length
        if (config.dma_layer_len == 0 || config.dma_head_len == 0 || config.dma_tile_len == 0) {
            set_error(ERR_DMA_ZERO_LEN);
        }

        // base address Alignment (check 64 byte alighment)
        // probably check all
        if ((config.wq_base_addr & 0x3F) != 0) {
            set_error(ERR_DMA_ALIGNMENT);
        }

        // 4. other safety checks
        // ...
    }

    // 2. Hardware Logic (PL Internal updates)
    void set_busy(bool busy) {
        if (busy) local_status.status |= STATUS_BUSY_BIT;
        else local_status.status &= ~STATUS_BUSY_BIT;
    }

    void set_done() {
        set_busy(false);
        local_status.irq_status |= IRQ_INFER_DONE_BIT;
    }

    void set_error(uint32_t code) {
        local_status.irq_status |= IRQ_ERROR_BIT;
        local_status.status = code;
    }

    void update_progress(uint32_t layer_idx) {
        local_status.current_layer = layer_idx;
    }

    bool is_safe_to_start() {
        return (local_status.irq_status & IRQ_ERROR_BIT) == 0;
    }

    // 3. Output State (PL -> PS)
    // call at the end to push data to AXI
    StatusMemSpace get_status_output() {
        return local_status;
    }
};
