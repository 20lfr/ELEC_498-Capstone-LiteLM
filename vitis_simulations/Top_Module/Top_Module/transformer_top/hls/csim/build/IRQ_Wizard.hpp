#pragma once
#include "../top_params.hpp"

// Lightweight helper that models the IRQ wizard logic around the shared control
// memory space. Keeps the register manipulation separated from the scheduler.
bool irq_wizard(ControlMemSpace &mem, bool infer_done, bool error);
