# Memory FSM + Control — requirements draft

The Memory FSM is the traffic cop between the scheduler/compute blocks and on/off-chip storage. It should hide data movement latency and present simple ready/done handshakes to compute.

## Responsibilities
- **Serve compute requests**: Accept a compute request (op code + operand addresses + sizes + location hints). Populate the operand buffers expected by the selected compute block, then return a ready signal so compute can start.
- **Buffer management per op**: Each compute type has dedicated operand/output buffers (e.g., Q/K/V MAC uses `valueA[d_model]` and `valueB[d_model * d_heads]`; softmax will use `valueA[L]` plus a scalar). Memory FSM writes operands into the correct buffers and reads results back from the matching output buffers.
- **Source/target selection**: Handle BRAM vs URAM vs external memory (via AXI-Full). Use `BRAM_en_*` / `URAM_en_*` qualifiers and internal addresses to choose the right space.
- **DMA ingestion**: Honor scheduler `memory_request` + `dma_address` + DMA ID. Launch AXI-Full bursts (via weight stager/loader), place incoming data into BRAM/URAM, and bookkeep locations keyed by DMA ID.
- **ID-based lookup**: Other blocks request data by DMA ID; memory FSM resolves where it lives, how large it is, and which buffer to fill.
- **AXI-Stream ingest**: Accept streamed input from PS when scheduler asserts AXIS ready, place into memory, and assign an ID for later lookup.
- **AXI-Stream emit**: On stream-out requests, stream stored outputs (e.g., logits) via AXIS using the stored ID to locate data and length.
- **Write-back**: After compute_done, pull the result from the compute block’s output buffer, write it to the designated memory destination, and record where it was stored (address/ID/hash) and the size. Ack back when finished.
- **Bookkeeping**: Track outstanding requests, element counts, IDs, and completion status to avoid overwriting live buffers.

## Interfaces (high level)
- **Compute block side**
  - Inputs: op code, addr/valueA info, addr/valueB info, sizeA, sizeB, BRAM/URAM enables.
  - Actions: fill operand buffers; later drain output buffer to memory; provide “memory_ready/memory_done” style handshakes.
- **AXI-Full (external)**: Burst reads/writes for off-chip weights/activations; DMA address generation and length control.
- **AXI-Stream (optional/outbound)**: Stream-out path if/when results need to be emitted rather than stored.





## Compute Flow example (Q/K/V MAC)
1) Scheduler asserts compute_start + ComputeOp (CMP_Q/K/V) with addresses/sizes and BRAM/URAM enables.  
2) Memory FSM pulls operand A/B from indicated memory (BRAM/URAM) into QKV operand buffers.  
3) Signals compute block that operands are ready; compute runs and asserts compute_done.  
4) Memory FSM takes the MAC outputs from the compute output buffer, writes to target memory, logs address + size, then acks completion.  

## Notes
- Softmax and other ops will introduce different operand/output buffer shapes; extend routing per `compute_op`.
- Keep the compute-facing contract simple: compute should not worry about where data lives; it only sees ready/done and pre-filled buffers.


## DMA flow
1) Scheduler asserts memory_request + dma_address + dma ID. using the Weight Stager and loader
2) Memory Managment system takes requests (if not busy) and commisions AXI-full to fetch data
3) AXI full responds and incrementally, feeds data to memory management system 
4) The system should now properly find space in URAM or BRAM to put the data, and bookkeep locations using the dma ID
5) When other blocks (like the compute block) need specific data, all they need to do is request for the dma ID, and the memory management system should know exactly where to find the data, where to put the data (ie which buffer), and how much data there is to transfer. 

## AXI-Stream IN flow
1) Scheduler asserts axis ready signal, and the PS will start streaming data
2) The scheduler should be able to recieve this stream data, and map it to locations in memory providing its own ID for the streamed data
3) Do until FSM moves to next state (ie axis_in_last)

## AXI-Stream OUT flow
1) Scheduler asserts stream_out, and the memory manager should take the bookkept ID of the output logits and stream them into the AXI stream out interface. 
2) Do this until all logits are streamed
