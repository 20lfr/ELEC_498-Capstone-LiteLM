#include "pl_interface.hpp"
#include "logger.hpp"
#include "error_handler.hpp"
#include "config.hpp"

#define D_MODEL_TEST 16
Logger* g_logger = nullptr;
ErrorHandler* g_err = nullptr;
SystemConfig cfg;

int main(int argc, char* argv[]) {
    bool mock = false;
    printf("AXI Interface Test: %s\n", mock ? "MOCK" : "HARDWARE");

    LogLevel lvl = (argc > 1 && std::string(argv[1]) == "--debug") ? LogLevel::DEBUG : LogLevel::INFO;
    g_logger = new Logger(lvl, "axi_test.log");
    g_err = new ErrorHandler();

    PLInterface pl(g_logger, g_err);
    if(!pl.init("axi_top", mock)) {
        printf("Init failed: %s\n", g_err->getLastErrorMessage().c_str());
        pl.cleanup();
        delete g_logger;
        delete g_err;
        return 1;
    }
    if(!pl.initDMA(cfg.hardware.dma_reg_base_addr, cfg.hardware.dma_buffer_size)) {
        printf("DMA init failed: %s\n", g_err->getLastErrorMessage().c_str());
        pl.cleanup();
        delete g_logger;
        delete g_err;
        return 1;
    }
    pl.beginConfig();
    pl.writeReg(PLReg::CONTROL, PLReg::CTRL_RESETN_BIT);

    // DMA lengths (required non-zero)
    pl.writeReg(PLReg::DMA_LAYER_LEN, cfg.model.dma_layer_len);
    pl.writeReg(PLReg::DMA_HEAD_LEN, cfg.model.dma_head_len);
    pl.writeReg(PLReg::DMA_TILE_LEN, cfg.model.dma_tile_len);

    // Strides (required non-zero)
    pl.writeReg(PLReg::LAYER_STRIDE, cfg.model.layer_stride);
    pl.writeReg(PLReg::WQ_HEAD_STRIDE, cfg.model.wq_head_stride);
    pl.writeReg(PLReg::WK_HEAD_STRIDE, cfg.model.wk_head_stride);
    pl.writeReg(PLReg::WV_HEAD_STRIDE, cfg.model.wv_head_stride);
    pl.writeReg(PLReg::K_CACHE_STRIDE, cfg.model.k_cache_stride);
    pl.writeReg(PLReg::V_CACHE_STRIDE, cfg.model.v_cache_stride);
    pl.writeReg(PLReg::WO_TILE_STRIDE, cfg.model.wo_tile_stride);
    pl.writeReg(PLReg::W1_TILE_STRIDE, cfg.model.w1_tile_stride);
    pl.writeReg(PLReg::W2_TILE_STRIDE, cfg.model.w2_tile_stride);

    // 64-bit base addresses
    pl.writeReg64(PLReg::WQ_BASE_LO, cfg.memory.wq_offset);
    pl.writeReg64(PLReg::WK_BASE_LO, cfg.memory.wk_offset);
    pl.writeReg64(PLReg::WV_BASE_LO, cfg.memory.wv_offset);
    pl.writeReg64(PLReg::WO_BASE_LO, cfg.memory.wo_offset);
    pl.writeReg64(PLReg::W1_BASE_LO, cfg.memory.w1_offset);
    pl.writeReg64(PLReg::W2_BASE_LO, cfg.memory.w2_offset);
    pl.writeReg64(PLReg::K_CACHE_LO, cfg.memory.k_cache_offset);
    pl.writeReg64(PLReg::V_CACHE_LO, cfg.memory.v_cache_offset);

    // Quantization
    pl.writeReg(PLReg::LOGIT_SCALE_QV, cfg.model.logit_scale_qv);
    pl.writeReg(PLReg::SCALE_Q, *reinterpret_cast<const uint32_t*>(&cfg.model.scale_q));
    pl.writeReg(PLReg::ZERO_POINT_Q, static_cast<uint32_t>(cfg.model.zero_point_q));
    pl.writeReg(PLReg::SCALE_K, *reinterpret_cast<const uint32_t*>(&cfg.model.scale_k));
    pl.writeReg(PLReg::ZERO_POINT_K, static_cast<uint32_t>(cfg.model.zero_point_k));
    pl.writeReg(PLReg::SCALE_V, *reinterpret_cast<const uint32_t*>(&cfg.model.scale_v));
    pl.writeReg(PLReg::ZERO_POINT_V, static_cast<uint32_t>(cfg.model.zero_point_v));

    pl.endConfig();

    int8_t send_data[D_MODEL_TEST];
    int8_t recv_data[D_MODEL_TEST];
    for (int i = 0; i < D_MODEL_TEST; i++) {
        send_data[i] = i - D_MODEL_TEST/2;
        recv_data[i] = 0;
    }

    // Arm DMA, then set start — HLS auto_restart picks it up
    pl.dmaKickRecv(D_MODEL_TEST);
    pl.dmaKickSend(send_data, D_MODEL_TEST);
    pl.writeReg(PLReg::CONTROL, PLReg::CTRL_RESETN_BIT | PLReg::CTRL_START_BIT);

    if (!pl.dmaWaitSend(5000))
        printf("DMA send timeout: %s\n", pl.dmaStatusString().c_str());
    if (!pl.dmaWaitRecv(recv_data, D_MODEL_TEST, 5000))
        printf("DMA recv timeout: %s\n", pl.dmaStatusString().c_str());

    // HLS does token_buf[i] + 1
    printf("\n=== Results ===\n");
    for (int i = 0; i < D_MODEL_TEST; i++) {
        printf("  [%2d] sent=%4d  recv=%4d  %s\n",
               i, send_data[i], recv_data[i],
               (recv_data[i] == send_data[i] + 1) ? "OK" : "FAIL");
    }

    printf("\nAP_CTRL:    0x%08X\n", pl.readReg(PLReg::AXIL_AP_CTRL));
    printf("Status:     0x%08X\n", pl.readReg(PLReg::STATUS));
    printf("IRQ Status: 0x%08X\n", pl.readReg(PLReg::IRQ_STATUS));
    printf("Error Code: 0x%08X\n", pl.readReg(PLReg::ERROR_CODE));
    printf("DMA STATUS: %s\n", pl.dmaStatusString().c_str());

    pl.cleanup();
    delete g_logger;
    delete g_err;
    return 0;
}
