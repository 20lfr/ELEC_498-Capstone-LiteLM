/**
 * pl_cli.cpp — Interactive CLI for testing axi_top custom IP
 *
 * Usage:  ./pl_cli [--mock] [--debug]
 *
 * Commands mirror the axi_top FSM states so you can exercise
 * each DMA / stream / compute path individually from the PS.
 */
#include "config.hpp"
#include "error_handler.hpp"
#include "logger.hpp"
#include "pl_interface.hpp"

#include <cstdio>
#include <cstring>
#include <sstream>
#include <string>

// ─── Globals ───────────────────────────────────────────────────
Logger *g_logger = nullptr;
ErrorHandler *g_err = nullptr;
SystemConfig cfg;
PLInterface *g_pl = nullptr;

// ─── Helpers ───────────────────────────────────────────────────

static void print_status() {
    if (!g_pl || !g_pl->isInitialized()) {
        printf("  ERROR: call 'init' first\n");
        return;
    }
    printf("  AP_CTRL:    0x%08X\n", g_pl->readReg(PLReg::AXIL_AP_CTRL));
    printf("  Status:     0x%08X\n", g_pl->readReg(PLReg::STATUS));
    printf("  IRQ Status: 0x%08X\n", g_pl->readReg(PLReg::IRQ_STATUS));
    printf("  Error Code: 0x%08X  %s\n", g_pl->readReg(PLReg::ERROR_CODE),
           g_pl->getErrorCodeString().c_str());
    printf("  Layer:      %u\n", g_pl->readReg(PLReg::LAYER_INDEX));
    printf("  Stream:     %s\n", g_pl->streamStatusString().c_str());
}

/** Issue a single FSM command, poll for AXI_DONE or INFER_DONE, clear IRQs.
 *  For fire-and-forget commands (INCR_*), set wait_irq=false. */
static bool send_cmd(uint32_t cmd_bit, const char *name,
                     uint32_t expected_status, bool wait_irq = true,
                     uint32_t timeout_ms = 5000) {
    if (!g_pl || !g_pl->isInitialized()) {
        printf("  ERROR: call 'init' first\n");
        return false;
    }

    // Issue command
    g_pl->writeReg(PLReg::CONTROL, CTRL_RESETN_BIT | CTRL_START_BIT | cmd_bit);

    bool result = false;

    if (!wait_irq) {
        // Fire-and-forget: state check above is sufficient
        result = true;
    } else {
        // Poll for completion
        for (uint32_t t = 0; t < timeout_ms; t += 5) {
            uint32_t irq = g_pl->readReg(PLReg::IRQ_STATUS);
            if (irq & IRQ_ERROR_BIT) {
                printf("  [%s] ERROR: 0x%08X  %s\n", name,
                       g_pl->readReg(PLReg::ERROR_CODE),
                       g_pl->getErrorCodeString().c_str());
                g_pl->clearIRQ();
                break;
            }
            if (irq &
                (IRQ_AXI_DONE_BIT | IRQ_INFER_DONE_BIT)) {
                printf("  [%s] OK  (IRQ=0x%02X)\n", name, irq);
                g_pl->clearIRQ();
                result = true;
                break;
            }
            usleep(5000);
        }
        if (!result)
            printf("  [%s] TIMEOUT\n", name);
    }

    // Verify the IP entered the expected FSM state
    usleep(500);
    uint32_t st = g_pl->readReg(PLReg::STATUS);
    uint32_t expect = STATUS_BUSY | expected_status;
    if ((st & expect) == expect) {
        printf("  [%s] state OK (status=0x%04X)\n", name, st);
    } else {
        printf("  [%s] state MISMATCH: got 0x%04X, expected 0x%04X\n", name, st,
               expect);
    }

    // Cleanup: clear command bits so the IP returns to IDLE on next
    // auto-restart.
    g_pl->writeReg(PLReg::CONTROL,
                   CTRL_RESETN_BIT | CTRL_START_BIT);

    return result;
}

// ─── Command Implementations ──────────────────────────────────

static bool cmd_init(bool mock) {
    if (g_pl && g_pl->isInitialized()) {
        printf("  Already initialised. Use 'reset' to re-init.\n");
        return true;
    }

    g_pl = new PLInterface(g_logger, g_err, mock);
    if (!g_pl->init("axi_top", cfg.hardware.stream_reg_base_addr)) {
        printf("  Init failed: %s\n", g_err->getLastErrorMessage().c_str());
        return false;
    }
    if (!g_pl->initDMA(cfg.hardware.dmabuf_name, cfg.hardware.dmabuf_size)) {
        printf("  DMA init failed: %s\n", g_err->getLastErrorMessage().c_str());
        return false;
    }

    // Configure all registers (same as axi_test.cpp)
    g_pl->beginConfig();
    g_pl->writeReg(PLReg::CONTROL, CTRL_RESETN_BIT);

    // Strides
    g_pl->writeReg(PLReg::LAYER_STRIDE, cfg.model.layer_stride);
    g_pl->writeReg(PLReg::WQ_HEAD_STRIDE, cfg.model.wq_head_stride);
    g_pl->writeReg(PLReg::WK_HEAD_STRIDE, cfg.model.wk_head_stride);
    g_pl->writeReg(PLReg::WV_HEAD_STRIDE, cfg.model.wv_head_stride);
    g_pl->writeReg(PLReg::K_CACHE_STRIDE, cfg.model.k_cache_stride);
    g_pl->writeReg(PLReg::V_CACHE_STRIDE, cfg.model.v_cache_stride);
    g_pl->writeReg(PLReg::WO_TILE_STRIDE, cfg.model.wo_tile_stride);
    g_pl->writeReg(PLReg::W1_TILE_STRIDE, cfg.model.w1_tile_stride);
    g_pl->writeReg(PLReg::W2_TILE_STRIDE, cfg.model.w2_tile_stride);

    // DDR base addresses
    g_pl->writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO,
                     g_pl->getDDRBaseAddr());

    // Offsets
    g_pl->writeReg(PLReg::WQ_OFFSET, cfg.memory.wq_offset);
    g_pl->writeReg(PLReg::WK_OFFSET, cfg.memory.wk_offset);
    g_pl->writeReg(PLReg::WV_OFFSET, cfg.memory.wv_offset);
    g_pl->writeReg(PLReg::WO_OFFSET, cfg.memory.wo_offset);
    g_pl->writeReg(PLReg::W1_OFFSET, cfg.memory.w1_offset);
    g_pl->writeReg(PLReg::W2_OFFSET, cfg.memory.w2_offset);
    g_pl->writeReg(PLReg::K_CACHE_OFFSET, cfg.memory.k_cache_offset);
    g_pl->writeReg(PLReg::V_CACHE_OFFSET, cfg.memory.v_cache_offset);

    // Quantization
    g_pl->writeReg(PLReg::LOGIT_SCALE_QV, cfg.model.logit_scale_qv);
    g_pl->writeReg(PLReg::SCALE_Q,
                   *reinterpret_cast<const uint32_t *>(&cfg.model.scale_q));
    g_pl->writeReg(PLReg::ZERO_POINT_Q,
                   static_cast<uint32_t>(cfg.model.zero_point_q));
    g_pl->writeReg(PLReg::SCALE_K,
                   *reinterpret_cast<const uint32_t *>(&cfg.model.scale_k));
    g_pl->writeReg(PLReg::ZERO_POINT_K,
                   static_cast<uint32_t>(cfg.model.zero_point_k));
    g_pl->writeReg(PLReg::SCALE_V,
                   *reinterpret_cast<const uint32_t *>(&cfg.model.scale_v));
    g_pl->writeReg(PLReg::ZERO_POINT_V,
                   static_cast<uint32_t>(cfg.model.zero_point_v));

    g_pl->endConfig();

    printf("  Initialised OK\n");
    print_status();
    return true;
}

static bool cmd_reset() {
    if (!g_pl || !g_pl->isInitialized()) {
        printf("  ERROR: call 'init' first\n");
        return false;
    }

    g_pl->reset();
    printf("  Reset OK\n");
    print_status();
    return true;
}

static bool cmd_weights() {
    // Seed DDR weights region with test pattern
    const uint32_t sz = STRIDE_QKV_HEAD;
    uint8_t *pat = new uint8_t[sz];
    for (uint32_t i = 0; i < sz; i++)
        pat[i] = (uint8_t)(i & 0xFF);
    g_pl->writeDDR(cfg.memory.wq_offset, pat, sz);
    delete[] pat;
    printf("  DDR weights seeded (%u bytes at offset 0x%X)\n", sz,
           cfg.memory.wq_offset);

    return send_cmd(CTRL_WEIGHTS_GET_BIT, "WEIGHTS_GET",
                    STAT_WEIGHTS_GET_BIT);
}

static bool cmd_kcache_read() {
    const uint32_t sz = KV_CACHE_HEAD_BYTES;
    uint8_t *pat = new uint8_t[sz];
    for (uint32_t i = 0; i < sz; i++)
        pat[i] = 0xBB;
    g_pl->writeDDR(cfg.memory.k_cache_offset, pat, sz);
    delete[] pat;
    printf("  DDR K-cache seeded (0xBB x %u bytes)\n", sz);

    return send_cmd(CTRL_KCACHE_GET_BIT, "KCACHE_GET",
                    STAT_KCACHE_GET_BIT);
}

static bool cmd_vcache_read() {
    const uint32_t sz = KV_CACHE_HEAD_BYTES;
    uint8_t *pat = new uint8_t[sz];
    for (uint32_t i = 0; i < sz; i++)
        pat[i] = 0xCC;
    g_pl->writeDDR(cfg.memory.v_cache_offset, pat, sz);
    delete[] pat;
    printf("  DDR V-cache seeded (0xCC x %u bytes)\n", sz);

    return send_cmd(CTRL_VCACHE_GET_BIT, "VCACHE_GET",
                    STAT_VCACHE_GET_BIT);
}

static bool cmd_kcache_write() {
    bool ok = send_cmd(CTRL_KCACHE_SEND_BIT, "KCACHE_SEND",
                       STAT_KCACHE_SEND_BIT);
    if (ok) {
        // Read back a few words to verify
        uint32_t peek[4] = {0};
        g_pl->readDDR(cfg.memory.k_cache_offset, peek,
                      sizeof(peek));
        printf("  DDR K-cache[0..3]: 0x%08X 0x%08X 0x%08X 0x%08X\n", peek[0],
               peek[1], peek[2], peek[3]);
    }
    return ok;
}

static bool cmd_vcache_write() {
    bool ok = send_cmd(CTRL_VCACHE_SEND_BIT, "VCACHE_SEND",
                       STAT_VCACHE_SEND_BIT);
    if (ok) {
        uint32_t peek[4] = {0};
        g_pl->readDDR(cfg.memory.v_cache_offset, peek,
                      sizeof(peek));
        printf("  DDR V-cache[0..3]: 0x%08X 0x%08X 0x%08X 0x%08X\n", peek[0],
               peek[1], peek[2], peek[3]);
    }
    return ok;
}

static int8_t g_send_data[D_MODEL];
static int8_t g_recv_data[D_MODEL];

static bool cmd_stream_in() {
    // Fill test token
    for (int i = 0; i < D_MODEL; i++)
        g_send_data[i] = (int8_t)(i & 0x7F);

    // Kick MM2S DMA first, then issue STREAM_IN command
    if (!g_pl->streamInitSend(cfg.memory.input_offset, g_send_data,
                              D_MODEL)) {
        printf("  streamInitSend failed\n");
        return false;
    }

    bool ok = send_cmd(CTRL_STREAM_IN_BIT, "STREAM_IN",
                       STAT_STREAM_IN_BIT);

    if (!g_pl->streamWaitSend(5000))
        printf("  Stream send DMA timeout: %s\n",
               g_pl->streamStatusString().c_str());

    return ok;
}

static bool cmd_compute() {
    return send_cmd(CTRL_COMPUTE_BIT, "COMPUTE",
                    STAT_COMPUTE_BIT);
}

static bool cmd_stream_out() {
    memset(g_recv_data, 0, sizeof(g_recv_data));

    // Arm S2MM recv before issuing command
    if (!g_pl->streamInitRecv(cfg.memory.output_offset, D_MODEL)) {
        printf("  streamInitRecv failed\n");
        return false;
    }

    bool ok = send_cmd(CTRL_STREAM_OUT_BIT, "STREAM_OUT",
                       STAT_STREAM_OUT_BIT);

    if (!g_pl->streamWaitRecv(cfg.memory.output_offset, g_recv_data,
                              D_MODEL, 5000)) {
        printf("  Stream recv DMA timeout: %s\n",
               g_pl->streamStatusString().c_str());
        return false;
    }

    // Print first 16 bytes
    printf("  Logit[0..15]: ");
    for (int i = 0; i < 16 && i < D_MODEL; i++)
        printf("%3d ", g_recv_data[i]);
    printf("...\n");

    return ok;
}

static bool cmd_incr(const char *name, uint32_t ctrl_bit, uint32_t stat_bit) {
    return send_cmd(ctrl_bit, name, stat_bit, /*wait_irq=*/false);
}

static bool cmd_run() {
    printf("═══ Phase 1: Token → Weights → Compute → Stream Out ═══\n");
    if (!g_pl || !g_pl->isInitialized()) {
        printf("  ERROR: call 'init' first\n");
        return false;
    }
    if (!cmd_stream_in())
        return false;
    if (!cmd_weights())
        return false;
    if (!cmd_compute())
        return false;
    if (!cmd_stream_out())
        return false;

    printf("\n═══ Phase 2: KV Cache Round-Trip ═══\n");
    if (!cmd_kcache_read())
        return false;
    if (!cmd_kcache_write())
        return false;
    if (!cmd_vcache_read())
        return false;
    if (!cmd_vcache_write())
        return false;

    printf("\n═══ Final Status ═══\n");
    print_status();
    return true;
}

static void print_help() {
    printf("\n");
    printf("  ┌────────────────────────────────────────────────┐\n");
    printf("  │  PL CLI — axi_top Custom IP Test Shell         │\n");
    printf("  ├────────────────────────────────────────────────┤\n");
    printf("  │  init          Initialise PL + DMA + config    │\n");
    printf("  │  reset         Assert/release reset            │\n");
    printf("  │  status        Dump all status registers       │\n");
    printf("  │                                                │\n");
    printf("  │  stream_in     DMA-stream test token (PS→PL)   │\n");
    printf("  │  weights       Seed DDR + WEIGHTS_GET          │\n");
    printf("  │  compute       Run COMPUTE                     │\n");
    printf("  │  stream_out    STREAM_OUT + read logits (PL→PS)│\n");
    printf("  │                                                │\n");
    printf("  │  kcache_read   Seed DDR + KCACHE_GET           │\n");
    printf("  │  kcache_write  KCACHE_SEND + verify DDR        │\n");
    printf("  │  vcache_read   Seed DDR + VCACHE_GET           │\n");
    printf("  │  vcache_write  VCACHE_SEND + verify DDR        │\n");
    printf("  │                                                │\n");
    printf("  │  run           Full Phase 1 + Phase 2 auto     │\n");
    printf("  │  help          This message                    │\n");
    printf("  │  quit          Cleanup and exit                │\n");
    printf("  └────────────────────────────────────────────────┘\n\n");
}

// ─── Main ──────────────────────────────────────────────────────

int main(int argc, char *argv[]) {
    bool mock = false;
    LogLevel lvl = LogLevel::INFO;

    for (int i = 1; i < argc; i++) {
        std::string arg(argv[i]);
        if (arg == "--mock")
            mock = true;
        if (arg == "--debug")
            lvl = LogLevel::DEBUG;
    }

    if (!cfg.validate()) {
        printf("Config validation failed\n");
        return 1;
    }

    g_logger = new Logger(lvl, "pl_cli.log");
    g_err = new ErrorHandler();

    printf("PL CLI — axi_top test shell  [%s]\n", mock ? "MOCK" : "HARDWARE");
    printf("Type 'help' for commands.\n\n");

    char line[256];
    while (true) {
        printf("pl> ");
        fflush(stdout);
        if (!fgets(line, sizeof(line), stdin))
            break;

        // Trim newline
        char *nl = strchr(line, '\n');
        if (nl)
            *nl = '\0';

        std::string cmd(line);
        // Trim whitespace
        while (!cmd.empty() && cmd.front() == ' ')
            cmd.erase(cmd.begin());
        while (!cmd.empty() && cmd.back() == ' ')
            cmd.pop_back();
        if (cmd.empty())
            continue;

        if (cmd == "init")
            cmd_init(mock);
        else if (cmd == "reset")
            cmd_reset();
        else if (cmd == "status")
            print_status();
        else if (cmd == "weights")
            cmd_weights();
        else if (cmd == "kcache_read")
            cmd_kcache_read();
        else if (cmd == "vcache_read")
            cmd_vcache_read();
        else if (cmd == "kcache_write")
            cmd_kcache_write();
        else if (cmd == "vcache_write")
            cmd_vcache_write();
        else if (cmd == "stream_in")
            cmd_stream_in();
        else if (cmd == "compute")
            cmd_compute();
        else if (cmd == "stream_out")
            cmd_stream_out();
        else if (cmd == "run")
            cmd_run();
        else if (cmd == "help")
            print_help();
        else if (cmd == "quit" || cmd == "exit" || cmd == "q")
            break;
        else
            printf("  Unknown command: '%s'. Type 'help'.\n", cmd.c_str());
    }

    printf("Cleaning up...\n");
    if (g_pl) {
        g_pl->cleanup();
        delete g_pl;
    }
    delete g_logger;
    delete g_err;
    return 0;
}
