#pragma once
#include "../top_params.hpp"

class ControlMemInterface {
private:
    StatusMemSpace local_status{};
 
    // Maskable bits for IRQ generation
    static constexpr uint32_t kMaskableBits = PLRegBits::IRQ_ERROR_BIT 
                                            | PLRegBits::IRQ_INFER_DONE_BIT 
                                            | PLRegBits::IRQ_AXI_DONE_BIT;

public:
    ControlMemInterface() = default;

    // 1. Process Inputs (PS -> PL)
    void check_errors(const ControlMemSpace &ctrl_mem, bool scheduler_error, bool compute_error, bool axi_error) {
        #pragma HLS INLINE

        const bool irq_error_en = (((ctrl_mem.irq_mask & 2u) >> 1) & 0x1u) != 0;

        // Check strides are non-zero (zero stride causes DMA issues)
        if (ctrl_mem.layer_stride == 0 || 
            ctrl_mem.wq_head_stride == 0 || ctrl_mem.wk_head_stride == 0 || ctrl_mem.wv_head_stride == 0 ||
            ctrl_mem.k_cache_stride == 0 || ctrl_mem.v_cache_stride == 0 ||
            ctrl_mem.wo_tile_stride == 0 || ctrl_mem.w1_tile_stride == 0 || ctrl_mem.w2_tile_stride == 0) {
            if (irq_error_en) {
                local_status.irq_status |= PLRegBits::IRQ_ERROR_BIT;
                local_status.error_code |= PLRegBits::ERR_DMA_ZERO_STRIDE_BIT;
            }
        }

        // Base address alignment (check 64-byte alignment for all DMA addresses)
        if ((ctrl_mem.wq_offset & 0x3F) != 0 || (ctrl_mem.wk_offset & 0x3F) != 0 || 
            (ctrl_mem.wv_offset & 0x3F) != 0 || (ctrl_mem.wo_offset & 0x3F) != 0 ||
            (ctrl_mem.w1_offset & 0x3F) != 0 || (ctrl_mem.w2_offset & 0x3F) != 0 ||
            (ctrl_mem.k_cache_offset & 0x3F) != 0 || (ctrl_mem.v_cache_offset & 0x3F) != 0) {
            if (irq_error_en) {
                local_status.irq_status |= PLRegBits::IRQ_ERROR_BIT;
                local_status.error_code |= PLRegBits::ERR_DMA_ALIGNMENT_BIT;
            }
        }

        if(scheduler_error){
            if (irq_error_en) {
                local_status.irq_status |= PLRegBits::IRQ_ERROR_BIT;
                local_status.error_code |= PLRegBits::ERR_SCHEDULER_ERROR_BIT;
            }
        }
        if(compute_error){
            if (irq_error_en) {
                local_status.irq_status |= PLRegBits::IRQ_ERROR_BIT;
                local_status.error_code |= PLRegBits::ERR_COMPUTE_ERROR_BIT;
            }
        }
         if(axi_error){
            if (irq_error_en) {
                local_status.irq_status |= PLRegBits::IRQ_ERROR_BIT;
                // let axi calls set erorr value in top function
            }
        }
    }
    // 2. Check Control and Generate Status (PL -> PS)
    void check_control(const ControlMemSpace &ctrl_mem, bool infer_done, bool axi_done) {
        // Handle "Write-1-to-Clear" logic here (runs last so PS can clear errors)
        if (ctrl_mem.irq_clear != 0) {
            local_status.irq_status &= ~ctrl_mem.irq_clear; // Clear by request
            // clear error code if error flag is cleared
            if (ctrl_mem.irq_clear & PLRegBits::IRQ_ERROR_BIT) {
                local_status.error_code = PLRegBits::ERR_NONE_BIT;
            }
        } else if (infer_done){
            local_status.irq_status |= PLRegBits::IRQ_INFER_DONE_BIT;
        } else if (axi_done) {
            local_status.irq_status |= PLRegBits::IRQ_AXI_DONE_BIT;
        }

        // Handle reset
        if ((ctrl_mem.control & PLRegBits::CTRL_RESETN_BIT) == 0) {
            local_status.irq_status = 0;
            local_status.status = PLRegBits::STAT_IDLE_BIT;
            local_status.error_code = PLRegBits::ERR_NONE_BIT;
        }
    }

    // 3. Compute IRQ output
    // Returns: true if IRQ should be asserted to PS
    inline bool compute_irq(uint32_t irq_mask) {
        #pragma HLS INLINE
        return (local_status.irq_status & (irq_mask & kMaskableBits)) != 0; 
    }

    StatusMemSpace& get_mutable_status() {
        #pragma HLS INLINE
        return local_status;
    }
};
