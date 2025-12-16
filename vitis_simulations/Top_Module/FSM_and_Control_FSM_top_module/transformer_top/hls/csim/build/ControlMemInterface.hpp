#pragma once
#include <cstdint>
#include "../top_params.hpp"


// ------------------------------------------------------------
// Simple read/write helpers (usable in top.cpp or SW TB)
// ------------------------------------------------------------
uint32_t ctrl_read(const ControlMemSpace &mem, ControlReg reg);
void     ctrl_write(ControlMemSpace &mem, ControlReg reg, uint32_t value);

// Convenience helpers for top-level modules
inline bool ctrl_start(const ControlMemSpace &mem)   { return (mem.control & CTRL_START_BIT) != 0; }
inline bool ctrl_reset_n(const ControlMemSpace &mem) { return (mem.control & CTRL_RESETN_BIT) != 0; }

void init_mem_space(ControlMemSpace& mem);
void ControlMemInterface(
    ControlMemSpace &mem,               // Memory Space defined Outside of this scope
    ControlReg      address,            // Control Register Defined address
    uint32_t        data_in,            // Data In
    uint32_t        &data_out,          // Data Out

    bool            read_control,       // Read enable
    bool            write_control,      // Write enable
    
    bool            chip_enable,        // Chip enable
    bool            reset_n             // Reset enable

);
