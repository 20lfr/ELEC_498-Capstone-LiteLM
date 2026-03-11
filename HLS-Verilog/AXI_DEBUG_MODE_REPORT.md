## AXI Debug Mode Firmware Notes

Use the existing control register. No `ControlMemSpace` expansion is required.

### Control word
- Set `CTRL_DEBUG_MODE_BIT`
- Set `control[7:4] = DEBUG_MODE_AXI_SIGNATURE`
- Field layout:
  - `control[3]` = debug enable
  - `control[7:4]` = debug mode selector
- AXI debug control pattern:
  - idle/reset-enabled = `0x29`
  - start asserted = `0x2B`
  - clear-start back to idle = `0x29`

### Runtime behavior
- Do not expect `stream_out` data in this mode
- This mode skips `S_STREAM_IN` entirely
- Launch normally and wait for the usual done IRQ/status
- Error handling stays on the normal error path

### Internal flow
For each debug request, hardware now does:
1. DMA read from parameter DDR
2. Compute `sum(bytes) % DEBUG_AXI_SIG_MODULUS`
3. Store compute result through the normal MMU compute-write path
4. DMA writeback one 32-bit signature into K cache

Requests are processed in this order:
- `req0`: WQ
- `req1`: WK
- `req2`: WV
- `req3`: WO + WO bias
- `req4`: W1 + W1 bias
- `req5`: W2 + W2 bias
- `req6`: WLOGIT

### Readback
- After done, read `DEBUG_AXI_REQ_COUNT` 32-bit signatures from the K-cache base:
  - `k_cache_offset + req_idx * 4`
- Each result is a 32-bit little-endian word
- Stride is 4 bytes per request

### Constants firmware should import
- `CTRL_DEBUG_MODE_BIT`
- `CTRL_DEBUG_MODE_SEL_SHIFT`
- `CTRL_DEBUG_MODE_SEL_MASK`
- `DEBUG_MODE_AXI_SIGNATURE`
- `DEBUG_AXI_SIG_MODULUS`
- `DEBUG_AXI_REQ_COUNT`
- `k_cache_offset` from the programmed control memory

### Intent
- This mode validates AXI-full reads from the parameter DDR path
- The hardware computes one `sum(bytes) % DEBUG_AXI_SIG_MODULUS` signature per canonical request
- The resulting 32-bit signatures are written into the K-cache region starting
  at `k_cache_offset`, in request order
