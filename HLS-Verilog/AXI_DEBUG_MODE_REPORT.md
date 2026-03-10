## AXI Debug Mode Firmware Notes

Use the existing control register. No `ControlMemSpace` expansion is required.

### Control word
- Set `CTRL_DEBUG_MODE_BIT`
- Set `control[7:4] = DEBUG_MODE_AXI_SIGNATURE`

### Runtime behavior
- Do not expect `stream_out` data in this mode
- Launch normally and wait for the usual done IRQ/status
- Error handling stays on the normal error path

### Readback
- After done, read `DEBUG_AXI_REQ_COUNT` 32-bit signatures from the K-cache base:
  - `k_cache_offset + req_idx * DEBUG_AXI_SCRATCH_STRIDE`
- Reconstruct each signature as little-endian:
  - `sig = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)`

### Constants firmware should import
- `CTRL_DEBUG_MODE_BIT`
- `CTRL_DEBUG_MODE_SEL_SHIFT`
- `CTRL_DEBUG_MODE_SEL_MASK`
- `DEBUG_MODE_AXI_SIGNATURE`
- `DEBUG_AXI_SIG_MODULUS`
- `DEBUG_AXI_REQ_COUNT`
- `DEBUG_AXI_SCRATCH_STRIDE`
- `k_cache_offset` from the programmed control memory

### Intent
- This mode validates AXI-full reads from the parameter DDR path
- The hardware computes one `sum(bytes) % DEBUG_AXI_SIG_MODULUS` signature per
  canonical read:
  - WQ
  - WK
  - WV
  - WO
  - W1
  - W2
  - WLOGIT
- The resulting 32-bit signatures are written into the K-cache region starting
  at `k_cache_offset`, in request order
