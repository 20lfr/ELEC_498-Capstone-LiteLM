#include "IRQ_Wizard.hpp"

namespace {

constexpr uint32_t kMaskableBits = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT; // clear bit bypasses mask

} 

bool irq_wizard(uint32_t &irq_status, uint32_t irq_mask, bool infer_done, bool error) {
    #pragma HLS INLINE

    if (infer_done) {
        irq_status |= IRQ_INFER_DONE_BIT;
    }
    if (error) {
        irq_status |= IRQ_ERROR_BIT;
    }

    return (irq_status & (irq_mask & kMaskableBits)) != 0; 
}
