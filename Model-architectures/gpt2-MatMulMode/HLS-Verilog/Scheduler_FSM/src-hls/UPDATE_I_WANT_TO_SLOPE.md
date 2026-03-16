# I want the following:

PS requests by writing instruction to ControlMemSpace, then asserting start for control reg in ControlMemSpace (keep control mem space instruction as 32bits). But the instruction only requests for head, layer and op. Leaving out tile, since we will do that optimization on the PL

PL will recieve this an internally break up weighted matrices into tiles defined in shared_params:
constexpr int D_TILE_WO            = 16;  // 48 tiles over D_MODEL=768
    constexpr int D_TILE_W1            = 16;  // 192 tiles over D_FFN=3072
    constexpr int D_TILE_W2            = 8;   // 96 tiles over D_MODEL=768; increased from 4 to unlock MAC_OP_TO_BUF_OUT_UNROLL=8
    constexpr int D_TILE_LOGIT         = 16;  // 3142 tiles over D_VOCAB=50257 (ceil); must be divisible by MAC_OP_TO_BUF_OUT_UNROLL_TARGET
    constexpr int D_HEAD_TILE_QKV      = 4;   // 16 tiles over D_HEADS=64
    constexpr int ATT_CTX_BLOCK        = 64;
    constexpr int D_HEAD_TILE_ATT_VALUE = 4;  // 16 tiles over D_HEADS=64


Then internally the PL will split up the weighted matrices and data members into tiles (as seen before in /home/luka/Scripting/ELEC_498-Capstone-LiteLM/Model-architectures/gpt2-HARDWARE/HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.cpp). 

Then we do the regular flow using the pack_compute_instruction and pack_dma_op with the 64 bit new instrutctions