#pragma once
#include "../top_params.hpp"

class ControlMemInterface {
private:
    StatusMemSpace local_status{};
    
    // Maskable bits for IRQ generation
    static constexpr uint32_t kMaskableBits = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
    
public:
    ControlMemInterface() = default;

    // 1. Process Inputs (PS -> PL)
    // Call this at the start
    void update_inputs(const ControlMemSpace &ctrl_mem) {
        #pragma HLS INLINE

        // Check DMA Length (all must be non-zero)
        if (ctrl_mem.dma_layer_len == 0 || ctrl_mem.dma_head_len == 0 || ctrl_mem.dma_tile_len == 0) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_DMA_ZERO_LEN;
        }

        // Check strides are non-zero (zero stride causes DMA issues)
        if (ctrl_mem.layer_stride == 0 || 
            ctrl_mem.wq_head_stride == 0 || ctrl_mem.wk_head_stride == 0 || ctrl_mem.wv_head_stride == 0 ||
            ctrl_mem.k_cache_stride == 0 || ctrl_mem.v_cache_stride == 0 ||
            ctrl_mem.wo_tile_stride == 0 || ctrl_mem.w1_tile_stride == 0 || ctrl_mem.w2_tile_stride == 0) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_DMA_ZERO_LEN;  // Reuse zero-length error code
        }

        // Base address alignment (check 64-byte alignment for all DMA addresses)
        if ((ctrl_mem.wq_base_addr & 0x3F) != 0 || (ctrl_mem.wk_base_addr & 0x3F) != 0 || 
            (ctrl_mem.wv_base_addr & 0x3F) != 0 || (ctrl_mem.wo_base_addr & 0x3F) != 0 ||
            (ctrl_mem.w1_base_addr & 0x3F) != 0 || (ctrl_mem.w2_base_addr & 0x3F) != 0 ||
            (ctrl_mem.k_cache_addr & 0x3F) != 0 || (ctrl_mem.v_cache_addr & 0x3F) != 0) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
            local_status.error_code = ERR_DMA_ALIGNMENT;
        }

        // other safety checks
        // ...

        // Handle "Write-1-to-Clear" logic here (runs last so PS can clear errors)
        if (ctrl_mem.irq_clear != 0) {
            local_status.irq_status &= ~ctrl_mem.irq_clear;
            // clear error code if error flag is cleared
            if (ctrl_mem.irq_clear & IRQ_ERROR_BIT) {
                local_status.error_code = ERR_NONE;
                local_status.status &= ~STATUS_ERROR;
            }
        }

        // Handle reset
        if ((ctrl_mem.control & CTRL_RESETN_BIT) == 0) {
            local_status.irq_status = 0;
            local_status.status = STATUS_IDLE;
            local_status.error_code = ERR_NONE;
        }

    }

    // 2. Compute IRQ output (replaces irq_wizard)
    // Call after scheduler sets done/error flags
    // Returns: true if IRQ should be asserted to PS
    bool compute_irq(uint32_t irq_mask, bool infer_done, bool error) {
        #pragma HLS INLINE
        
        if (infer_done) {
            local_status.irq_status |= IRQ_INFER_DONE_BIT;
            local_status.status = STATUS_IDLE;
        }
        if (error) {
            local_status.irq_status |= IRQ_ERROR_BIT;
            local_status.status = STATUS_ERROR;
        }

        return (local_status.irq_status & (irq_mask & kMaskableBits)) != 0; 
    }

    // 3. Output State (PL -> PS)
    // call at the end to push data to AXI
    StatusMemSpace& get_mutable_status() {
        #pragma HLS INLINE
        return local_status;
    }
};
