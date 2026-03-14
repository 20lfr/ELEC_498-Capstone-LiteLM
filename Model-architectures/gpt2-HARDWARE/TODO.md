# List of things to bring over from phi3-mini architecture
1. Bring all logic over first (this includes all the hls files inside the directory /home/luka/Scripting/ELEC_498-Capstone-LiteLM/Model-architectures/phi3-mini-int4-HARDWARE) into /home/luka/Scripting/ELEC_498-Capstone-LiteLM/Model-architectures/gpt2-HARDWARE (DONE)
2. Convert RMSnorms to LayerNorms (using Q19.13 fixed point representation using the ap_fixed<> format) (DONE)
3. Switch Swiglu to Gelu (DONE)
4. Remove W1 up and W2 gate, and just have a single matrix that is W1, that is D_MODEL*D_FFN (DONE)
5. Weights are now all int8 (previously int4) (DONE)
6. Maintain control params in shared_params.hpp and top_params.hpp (DONE)
7. Reformat the scheduler fsm flow from phi3-mini to gpt2 (DONE)
8. ATTN_SCALE_Q15 gotta switch from 1 / sqrt(96) to 1 / sqrt (64) (DONE)
9. Change attentions heads to REMOVE roping all together and do the  straight dot product with Q and K cache (DONE)
10. ONCE COMPLETE, list out all that might be left to do and report back

NOTES: for any complicated operations like E^x, or sin/cos, use a look up table to approximate outputs

# POST change:
1. Clean up repo to not include old functions that we don't use (that being the RoPE luts and logic, old legacy compute blocks, scheduler_states-if needed). (DONE)
2. If there are any voided inputs or useless inputs to functions get rid of them (DONE)

# Things to DO once Andy has got the model specs:
1. Get the real offsets, strides and ctrl mem information (and update it in shared_params.hpp and top_params.hpp)
2. Get the real MODEL_* params for the gpt2 architecture
