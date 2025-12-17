#include <cassert>
#include <cstdint>
#include <cstdio>

#include "Weight_stager.hpp"

// Clock-style stimulus: drive wl_start pulses and observe wl_ready/mem_req/addr over cycles.
int main() {
    ControlMemSpace mem{};
    mem.layer_stride    = 0x1000;
    mem.wq_head_stride  = 0x0100;
    mem.wk_head_stride  = 0x0200;
    mem.wv_head_stride  = 0x0300;
    mem.k_cache_stride  = 0x0400;
    mem.v_cache_stride  = 0x0500;
    mem.wo_tile_stride  = 0x0600;
    mem.w1_tile_stride  = 0x0700;
    mem.w2_tile_stride  = 0x0800;

    mem.wq_base_addr    = 0x10000000;
    mem.wk_base_addr    = 0x20000000;
    mem.wv_base_addr    = 0x30000000;
    mem.k_cache_addr    = 0x40000000;
    mem.v_cache_addr    = 0x50000000;
    mem.wo_base_addr    = 0x60000000;
    mem.w1_base_addr    = 0x70000000;
    mem.w2_base_addr    = 0x80000000;

    struct Stim {
        int cycle;
        DmaSel sel;
        int layer;
        int head;
        int tile;
    };

    // One pulse per request: WQ then W1 then an invalid layer.
    Stim requests[] = {
        {1, DmaSel::DMASEL_WQ, 1, 2, 0},
        {4, DmaSel::DMASEL_W1, 3, -1, 4},
        {7, DmaSel::DMASEL_WQ, -1, 0, 0},
    };

    bool wl_ready = false;
    bool mem_req  = false;
    bool error    = false;

    int req_idx = 0;
    const int NUM_REQ = sizeof(requests) / sizeof(requests[0]);

    std::puts("Cycle | start sel   layer head tile | ready mem_req err addr");
    for (int cycle = 0; cycle < 12; ++cycle) {
        bool wl_start = false;
        DmaSel sel = DmaSel::DMASEL_NONE;
        int layer = 0;
        int head = 0;
        int tile = 0;

        if (req_idx < NUM_REQ && cycle == requests[req_idx].cycle) {
            wl_start = true;
            sel   = requests[req_idx].sel;
            layer = requests[req_idx].layer;
            head  = requests[req_idx].head;
            tile  = requests[req_idx].tile;
            req_idx++;
        }

        uint32_t addr = weight_stager(
            wl_start,
            sel,
            layer,
            head,
            tile,
            mem,
            wl_ready,
            mem_req,
            error
        );

        std::printf("%5d |   %d   %-5d %5d %4d %4d |   %d      %d     %d  0x%08X\n",
                    cycle, wl_start, static_cast<int>(sel), layer, head, tile,
                    wl_ready, mem_req, error, addr);
    }

    std::puts("weight_stager_tb: stimulus complete.");
    return 0;
}
