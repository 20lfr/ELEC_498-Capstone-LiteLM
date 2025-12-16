#include "IRQ_Wizard.hpp"

namespace {

constexpr uint32_t kStatusMask   = IRQ_CLEAR_BIT | IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT ;
constexpr uint32_t kMaskableBits = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT; // clear bit bypasses mask

inline bool evaluate_irq(const ControlMemSpace &mem) {
    return (mem.irq_status & (mem.irq_enable & kMaskableBits)) != 0;
}

} 


bool irq_wizard(ControlMemSpace &mem, bool infer_done, bool error) {
    #pragma HLS INLINE
    uint32_t &status = mem.irq_status;

    // PS wrote the clear bit; drop the status register and interrupt.
    if (status & IRQ_CLEAR_BIT) {
        status = 0;
        return false;
    }
    if (infer_done) {
        status |= IRQ_INFER_DONE_BIT;
    }
    if (error) {
        status |= IRQ_ERROR_BIT;
    }

    return evaluate_irq(mem);
}
