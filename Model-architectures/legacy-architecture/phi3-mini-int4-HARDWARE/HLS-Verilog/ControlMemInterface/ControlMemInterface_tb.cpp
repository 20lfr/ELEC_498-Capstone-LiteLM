#include "ControlMemInterface.hpp"
#include <iostream>
#include <iomanip>

void ControlTest_Top(ControlMemSpace cfg, StatusMemSpace &stat, bool done, bool err);

int main() {
    ControlMemSpace cfg = {0};
    StatusMemSpace stat = {0};
    
    std::cout << "--- Control Logic Verification ---" << std::endl;

    // TEST 1: Alignment Check
    cfg.wq_offset = 0x00000003; // Misaligned
    
    ControlTest_Top(cfg, stat, false, false);

    if (stat.irq_status & IRQ_ERROR_BIT) {
        std::cout << "[PASS] Caught Misalignment (0x" << std::hex << stat.error_code << ")" << std::endl;
    } else {
        std::cout << "[FAIL] Failed to catch misalignment" << std::endl;
        return 1;
    }

    // TEST 2: Valid Config & Execution
    cfg.wq_offset = 0x00000040; // Aligned 64-byte
    
    // Clear previous error
    cfg.irq_clear = IRQ_ERROR_BIT;
    ControlTest_Top(cfg, stat, false, false);
    
    // Run with 'done' trigger
    ControlTest_Top(cfg, stat, true, false);

    if ((stat.irq_status & IRQ_INFER_DONE_BIT) &&
        stat.status == static_cast<uint32_t>(S_IDLE)) {
        std::cout << "[PASS] Execution Done & Status Returned To S_IDLE" << std::endl;
    } else {
        std::cout << "[FAIL] Done logic incorrect" << std::endl;
        return 1;
    }

    return 0;
}
