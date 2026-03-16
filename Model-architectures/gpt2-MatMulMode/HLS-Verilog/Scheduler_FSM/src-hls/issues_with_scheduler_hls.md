# issues:
1. I dont like the way we don this. Here i swhat I want. Start in STATE S_DILE, then once start, read the ControlMemSpace::compute_instruction, where the top 16 bits are tile number, the next 6 bits as head number, the next 6 bits as layer and the last 4 bits for the opcode, which makes a 32 bit incstuciton. 

So teh flow should be:
start in S_IDLE, then wait for start
go to streamin that gets tehe input acitation
then go to DECODE that will decode the into either of the weighted ops. Convert below into the 32 bit version I mentioned earlier

static inline uint64_t pack_dma_op(DmaSel op, int layer, int head, int tile) {
#pragma HLS INLINE
  const uint64_t op_field    = static_cast<uint64_t>(static_cast<uint8_t>(op));
  const uint64_t layer_field = static_cast<uint64_t>(static_cast<uint8_t>(layer));
  const uint64_t head_field  = static_cast<uint64_t>(static_cast<uint8_t>(head));
  const uint64_t tile_field  = static_cast<uint64_t>(static_cast<uint32_t>(tile));
  return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}

static inline uint64_t pack_compute_instruction(ComputeOp op, int layer, int head, int tile) {
#pragma HLS INLINE
  const uint64_t op_field    = static_cast<uint64_t>(static_cast<uint8_t>(op));
  const uint64_t layer_field = static_cast<uint64_t>(static_cast<uint8_t>(layer));
  const uint64_t head_field  = static_cast<uint64_t>(static_cast<uint8_t>(head));
  const uint64_t tile_field  = static_cast<uint64_t>(static_cast<uint32_t>(tile));
  return op_field | (layer_field << 8) | (head_field << 16) | (tile_field << 24);
}




The basicaly doing teh following:
case WEIGHT_EXAMPLE_OP: {
      if (!weight_decoded_started && wl_ready) {
        weight_decoded_compute_done = false;
        weight_decoded_dma_done = false;
        wl_start = 1;
        wl_instruction = pack_dma_op(DmaSel::decoded_op, n, n, n);
        weight_decoded_started = true;
        weight_decoded_dma_busy = true;
      } else if (weight_decoded_started && weight_decoded_dma_busy && weight_decoded_dma_done) {
        weight_decoded_dma_busy = false;
        weight_decoded_dma_done = false;
        weight_decoded_comp_busy = true;
      } else if (weight_decoded_started && weight_decoded_comp_busy && compute_ready) {
        weight_decoded_compute_done = false;
        compute_start = 1;
        compute_instruction = pack_compute_instruction(CMP_xxx, n, n, n);
        weight_decoded_comp_busy = false;
      } else if (weight_decoded_started && !weight_decoded_dma_busy && !weight_decoded_comp_busy && weight_decoded_compute_done) {
        weight_decoded_started = false;
        weight_decoded_compute_done = false;
        st = S_STREAM_OUT;
      }
      break;
    }

You can use our old scheudler as an example (/home/luka/Scripting/ELEC_498-Capstone-LiteLM/Model-architectures/gpt2-HARDWARE/HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_tb.cpp)

Then go to stream out and stream out the output of what we caclualted

Make sure that mmu_fsm and compute_controller can accept wl_instruction and compute_instructions