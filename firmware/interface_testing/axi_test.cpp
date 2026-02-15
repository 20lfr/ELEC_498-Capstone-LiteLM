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

    PLInterface pl(g_logger, g_err, false);
    if(!pl.init("axi_top", cfg.hardware.stream_reg_base_addr)) {
        printf("Init failed: %s\n", g_err->getLastErrorMessage().c_str());
        pl.cleanup();
        delete g_logger;
        delete g_err;
        return 1;
    }
    if(cfg.hardware.dmabuf0_max_size < cfg.memory.dmabuf0_real_size) {
        printf("Error: dmabuf0_max_size is smaller than dmabuf0_real_size\n");
        printf("dmabuf0_max_size: %zu\n", cfg.hardware.dmabuf0_max_size);
        printf("dmabuf0_real_size: %zu\n", cfg.memory.dmabuf0_real_size);
        pl.cleanup();
        delete g_logger;
        delete g_err;
        return 1;
    }
    if(cfg.hardware.dmabuf1_max_size < cfg.memory.dmabuf1_real_size) {
        printf("Error: dmabuf1_max_size is smaller than dmabuf1_real_size\n");
        printf("dmabuf1_max_size: %zu\n", cfg.hardware.dmabuf1_max_size);
        printf("dmabuf1_real_size: %zu\n", cfg.memory.dmabuf1_real_size);
        pl.cleanup();
        delete g_logger;
        delete g_err;
        return 1;
    }
    if(!pl.initDMA(cfg.hardware.dmabuf0_name, cfg.hardware.dmabuf0_max_size, cfg.hardware.dmabuf1_name, cfg.hardware.dmabuf1_max_size)) {
        printf("DMA init failed: %s\n", g_err->getLastErrorMessage().c_str());
        pl.cleanup();
        delete g_logger;
        delete g_err;
        return 1;
    }
    pl.beginConfig();
    pl.writeReg(PLReg::CONTROL, PLReg::CTRL_RESETN_BIT);

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

    // DDR base addressesd
    pl.writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO, pl.getDDRBaseAddr(DmaBufferType::WEIGHTS));
    pl.writeReg64(RegBus::ADDR, AddrReg::KV_CACHE_BASE_LO, pl.getDDRBaseAddr(DmaBufferType::KV_CACHE));

    // 32-bit word offsets (within ctrl_mem struct)
    pl.writeReg(PLReg::WQ_OFFSET, cfg.memory.wq_offset);
    pl.writeReg(PLReg::WK_OFFSET, cfg.memory.wk_offset);
    pl.writeReg(PLReg::WV_OFFSET, cfg.memory.wv_offset);
    pl.writeReg(PLReg::WO_OFFSET, cfg.memory.wo_offset);
    pl.writeReg(PLReg::W1_OFFSET, cfg.memory.w1_offset);
    pl.writeReg(PLReg::W2_OFFSET, cfg.memory.w2_offset);
    pl.writeReg(PLReg::K_CACHE_OFFSET, cfg.memory.k_cache_offset);
    pl.writeReg(PLReg::V_CACHE_OFFSET, cfg.memory.v_cache_offset);

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

    // Arm stream, then set start — HLS auto_restart picks it up
    pl.streamInitRecv(cfg.memory.output_offset, D_MODEL_TEST);
    pl.streamInitSend(cfg.memory.input_offset, send_data, D_MODEL_TEST);
    pl.writeReg(PLReg::CONTROL, PLReg::CTRL_RESETN_BIT | PLReg::CTRL_START_BIT);

    if (!pl.streamWaitSend(5000))
        printf("Stream send timeout: %s\n", pl.streamStatusString().c_str());
    if (!pl.streamWaitRecv(cfg.memory.output_offset, recv_data, D_MODEL_TEST, 5000))
        printf("Stream recv timeout: %s\n", pl.streamStatusString().c_str());

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
    printf("Stream:     %s\n", pl.streamStatusString().c_str());

    pl.cleanup();
    delete g_logger;
    delete g_err;
    return 0;
}
