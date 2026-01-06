#include "ControlMemInterface.hpp"
#include <iostream>
#include <iomanip>

void ControlTest_Top(ControlMemSpace cfg, StatusMemSpace &stat, uint32_t clr, bool done, bool err);

int main() {
    ControlMemSpace cfg = {0};
    StatusMemSpace stat = {0};
    
    std::cout << "--- Control Logic Verification ---" << std::endl;

    // TEST 1: Alignment Check
    cfg.wq_base_addr = 0x10000003; // Misaligned
    cfg.dma_layer_len = 100;       // Valid
    
    ControlTest_Top(cfg, stat, 0, false, false);

    if (stat.irq_status & IRQ_ERROR_BIT) {
        std::cout << "[PASS] Caught Misalignment (0x" << std::hex << stat.error_code << ")" << std::endl;
    } else {
        std::cout << "[FAIL] Failed to catch misalignment" << std::endl;
    }

    // TEST 2: Valid Config & Execution
    cfg.wq_base_addr = 0x10000000; // Aligned 64-byte
    
    // Clear previous error
    ControlTest_Top(cfg, stat, IRQ_ERROR_BIT, false, false);
    
    // Run with 'done' trigger
    ControlTest_Top(cfg, stat, 0, true, false);

    if ((stat.irq_status & IRQ_INFER_DONE_BIT) && !(stat.status & STATUS_BUSY_BIT)) {
        std::cout << "[PASS] Execution Done & Busy Cleared" << std::endl;
    } else {
        std::cout << "[FAIL] Done logic incorrect" << std::endl;
    }

    return 0;
}