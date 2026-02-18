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
    void check_errors(const ControlMemSpace &ctrl_mem,
                      bool scheduler_error,
                      bool compute_error,
                      bool mmu_invalid,
                      bool mmu_overflow,
                      uint32_t mmu_error_code) {
        #pragma HLS INLINE

        const bool irq_error_en = (((ctrl_mem.irq_mask & 2u) >> 1) & 0x1u) != 0;

        // Check DMA Length (all must be non-zero)
        if (ctrl_mem.dma_layer_len == 0 || ctrl_mem.dma_head_len == 0 || ctrl_mem.dma_tile_len == 0) {
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_DMA_ZERO_LEN;
            }
        }

        // Check strides are non-zero (zero stride causes DMA issues)
        if (ctrl_mem.layer_stride == 0 || 
            ctrl_mem.wq_head_stride == 0 || ctrl_mem.wk_head_stride == 0 || ctrl_mem.wv_head_stride == 0 ||
            ctrl_mem.k_cache_stride == 0 || ctrl_mem.v_cache_stride == 0 ||
            ctrl_mem.wo_tile_stride == 0 || ctrl_mem.w1_tile_stride == 0 || ctrl_mem.w2_tile_stride == 0) {
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_DMA_ZERO_STRIDE;  // Reuse zero-length error code
            }
        }

        // Base address alignment (check 64-byte alignment for all DMA addresses)
        if ((ctrl_mem.wq_base_addr & 0x3F) != 0 || (ctrl_mem.wk_base_addr & 0x3F) != 0 || 
            (ctrl_mem.wv_base_addr & 0x3F) != 0 || (ctrl_mem.wo_base_addr & 0x3F) != 0 ||
            (ctrl_mem.w1_base_addr & 0x3F) != 0 || (ctrl_mem.w2_base_addr & 0x3F) != 0 ||
            (ctrl_mem.k_cache_addr & 0x3F) != 0 || (ctrl_mem.v_cache_addr & 0x3F) != 0) {
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_DMA_ALIGNMENT;
            }
        }
    
        if(scheduler_error){
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_SCHEDULER_ERROR;
            }
        }
        if(compute_error){
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_COMPUTE_ERROR;
            }
        }
        if(mmu_invalid){
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_MMU_INVALID;
            }
        }
        if(mmu_overflow){
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= ERR_MMU_OVERFLOW;
            }
        }
        if (mmu_error_code != ERR_NONE) {
            if (irq_error_en) {
                local_status.irq_status |= IRQ_ERROR_BIT;
                local_status.status = STATUS_ERROR;
                local_status.error_code |= mmu_error_code;
            }
        }
    
    
    }
    // 2. Check Control and Generate Status (PL -> PS)
    void check_control(const ControlMemSpace &ctrl_mem, bool infer_done) {
        // Handle "Write-1-to-Clear" logic here (runs last so PS can clear errors)
        if (ctrl_mem.irq_clear != 0) {
            local_status.irq_status = 0;
        } else if (infer_done){
            local_status.irq_status |= IRQ_INFER_DONE_BIT;
        }

        // Handle reset
        if ((ctrl_mem.control & CTRL_RESETN_BIT) == 0) {
            local_status.irq_status = 0;
            local_status.status = STATUS_IDLE;
            local_status.error_code = ERR_NONE;
        }
    }

    // 3. Compute IRQ output (replaces irq_wizard)
    // Call after scheduler sets done/error flags
    // Returns: true if IRQ should be asserted to PS
    inline bool compute_irq(uint32_t irq_mask) {
        #pragma HLS INLINE
        return (local_status.irq_status & (irq_mask & kMaskableBits)) != 0; 
    }

    // 4. Output State (PL -> PS)
    // call at the end to push data to AXI
    StatusMemSpace& get_mutable_status() {
        #pragma HLS INLINE
        return local_status;
    }
};
