// pl_interface.hpp - AXI-Lite control + inline DMA stream transport
#ifndef PL_INTERFACE_HPP
#define PL_INTERFACE_HPP

#include <cstdint>
#include <string>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <poll.h>
#include <errno.h>
#include <cstring>
#include <dirent.h>

#include "dma_buffer.hpp"
// TODO: Replace with final HLS-generated header
#include "xaxi_top_hw.h"

class Logger;
class ErrorHandler;
enum class ErrorCode;

// =============================================================================
// HLS REGISTER OFFSETS - UPDATE AFTER SYNTHESIS
// Get actual values from: hardware_overlay/drivers/<top>/src/x<top>_hw.h
// =============================================================================
namespace PLReg {
    // TODO: Replace these with actual HLS-generated offsets
    constexpr uint32_t AXIL_AP_CTRL     = XAXI_TOP_CONTROL_ADDR_AP_CTRL;
    constexpr uint32_t AXIL_GIE         = XAXI_TOP_CONTROL_ADDR_GIE;
    constexpr uint32_t AXIL_IER         = XAXI_TOP_CONTROL_ADDR_IER;
    constexpr uint32_t AXIL_ISR         = XAXI_TOP_CONTROL_ADDR_ISR;

    // AXI-Lite Control Register Bits (From Vitis HLS UG1399)
    constexpr uint32_t AP_START         = (1u << 0);
    constexpr uint32_t AP_DONE          = (1u << 1);
    constexpr uint32_t AP_IDLE          = (1u << 2);
    constexpr uint32_t AP_READY         = (1u << 3);
    constexpr uint32_t AP_AUTO_RESTART  = (1u << 7);

    constexpr uint32_t CTRL_BASE        = XAXI_TOP_CONTROL_ADDR_CTRL_MEM_DATA;
    
    // ControlMemSpace (PS->PL writes)
    constexpr uint32_t CONTROL          = CTRL_BASE + 0x00;
    
    // IRQ enable mask - write (IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT) to enable, 0 to disable
    // Maps to: ctrl_mem.irq_enable_mask
    constexpr uint32_t IRQ_ENABLE_MASK  = CTRL_BASE + 0x04;
    
    // IRQ clear - write-1-to-clear
    // Rule: irq_clear = !irq_enable_mask during config (both for defense-in-depth)
    // Maps to: ctrl_mem.irq_clear
    constexpr uint32_t IRQ_CLEAR        = CTRL_BASE + 0x08;
    
    constexpr uint32_t DMA_LAYER_LEN    = CTRL_BASE + 0x0C;
    constexpr uint32_t DMA_HEAD_LEN     = CTRL_BASE + 0x10;
    constexpr uint32_t DMA_TILE_LEN     = CTRL_BASE + 0x14;
    constexpr uint32_t LAYER_STRIDE     = CTRL_BASE + 0x18;
    constexpr uint32_t WQ_HEAD_STRIDE   = CTRL_BASE + 0x1C;
    constexpr uint32_t WK_HEAD_STRIDE   = CTRL_BASE + 0x20;
    constexpr uint32_t WV_HEAD_STRIDE   = CTRL_BASE + 0x24;
    constexpr uint32_t K_CACHE_STRIDE   = CTRL_BASE + 0x28;
    constexpr uint32_t V_CACHE_STRIDE   = CTRL_BASE + 0x2C;
    constexpr uint32_t WO_TILE_STRIDE   = CTRL_BASE + 0x30;
    constexpr uint32_t W1_TILE_STRIDE   = CTRL_BASE + 0x34;
    constexpr uint32_t W2_TILE_STRIDE   = CTRL_BASE + 0x38;
    
    // 64-bit addresses (LOW/HIGH pairs)
    constexpr uint32_t WQ_BASE_LO       = CTRL_BASE + 0x3C;
    constexpr uint32_t WQ_BASE_HI       = CTRL_BASE + 0x40;
    constexpr uint32_t WK_BASE_LO       = CTRL_BASE + 0x44;
    constexpr uint32_t WK_BASE_HI       = CTRL_BASE + 0x48;
    constexpr uint32_t WV_BASE_LO       = CTRL_BASE + 0x4C;
    constexpr uint32_t WV_BASE_HI       = CTRL_BASE + 0x50;
    constexpr uint32_t WO_BASE_LO       = CTRL_BASE + 0x54;
    constexpr uint32_t WO_BASE_HI       = CTRL_BASE + 0x58;
    constexpr uint32_t W1_BASE_LO       = CTRL_BASE + 0x5C;
    constexpr uint32_t W1_BASE_HI       = CTRL_BASE + 0x60;
    constexpr uint32_t W2_BASE_LO       = CTRL_BASE + 0x64;
    constexpr uint32_t W2_BASE_HI       = CTRL_BASE + 0x68;
    constexpr uint32_t K_CACHE_LO       = CTRL_BASE + 0x6C;
    constexpr uint32_t K_CACHE_HI       = CTRL_BASE + 0x70;
    constexpr uint32_t V_CACHE_LO       = CTRL_BASE + 0x74;
    constexpr uint32_t V_CACHE_HI       = CTRL_BASE + 0x78;
    
    // Quantization
    constexpr uint32_t LOGIT_SCALE_QV   = CTRL_BASE + 0x7C;
    constexpr uint32_t SCALE_Q          = CTRL_BASE + 0x80;
    constexpr uint32_t ZERO_POINT_Q     = CTRL_BASE + 0x84;
    constexpr uint32_t SCALE_K          = CTRL_BASE + 0x88;
    constexpr uint32_t ZERO_POINT_K     = CTRL_BASE + 0x8C;
    constexpr uint32_t SCALE_V          = CTRL_BASE + 0x90;
    constexpr uint32_t ZERO_POINT_V     = CTRL_BASE + 0x94;
    
    // StatusMemSpace (PL->PS reads)
    constexpr uint32_t STATUS_BASE      = XAXI_TOP_CONTROL_ADDR_STATUS_MEM_DATA;
    constexpr uint32_t STATUS           = STATUS_BASE + 0x00;
    constexpr uint32_t IRQ_STATUS       = STATUS_BASE + 0x04;
    constexpr uint32_t ERROR_CODE       = STATUS_BASE + 0x08;
    constexpr uint32_t LAYER_INDEX      = STATUS_BASE + 0x0C;

    // Control bits (from top_params.hpp)
    constexpr uint32_t CTRL_RESETN_BIT      = 1u << 0;
    constexpr uint32_t CTRL_START_BIT       = 1u << 1;

    // Status bits
    constexpr uint32_t STATUS_IDLE_BIT      = 1u << 0;
    constexpr uint32_t STATUS_ERROR_BIT     = 1u << 1;
    constexpr uint32_t STATUS_BUSY_BIT      = 1u << 2;

    // IRQ bits
    constexpr uint32_t IRQ_ERROR_BIT        = 1u << 1;
    constexpr uint32_t IRQ_INFER_DONE_BIT   = 1u << 2;

    // Error codes
    constexpr uint32_t ERR_NONE             = 0x00;
    constexpr uint32_t ERR_DMA_ALIGNMENT    = 0x10;
    constexpr uint32_t ERR_DMA_ZERO_LEN     = 0x11;
}

// =============================================================================
// AXI DMA Register Offsets (PG021 Direct Register Mode)
// =============================================================================
namespace DmaReg {
    // MM2S (Memory-Map to Stream)
    constexpr uint32_t MM2S_CR     = 0x00;  // Control
    constexpr uint32_t MM2S_SR     = 0x04;  // Status
    constexpr uint32_t MM2S_SA     = 0x18;  // Source address low
    constexpr uint32_t MM2S_SA_MSB = 0x1C;  // Source address high
    constexpr uint32_t MM2S_LEN    = 0x28;  // Transfer length

    // S2MM (Stream to Memory-Map)
    constexpr uint32_t S2MM_CR     = 0x30;  // Control
    constexpr uint32_t S2MM_SR     = 0x34;  // Status
    constexpr uint32_t S2MM_DA     = 0x48;  // Dest address low
    constexpr uint32_t S2MM_DA_MSB = 0x4C;  // Dest address high
    constexpr uint32_t S2MM_LEN    = 0x58;  // Transfer length

    // Control bits
    constexpr uint32_t CR_RS       = (1u << 0);
    constexpr uint32_t CR_RESET    = (1u << 2);
    constexpr uint32_t CR_IOC_EN   = (1u << 12);
    constexpr uint32_t CR_ERR_EN   = (1u << 14);

    // Status bits
    constexpr uint32_t SR_HALTED   = (1u << 0);
    constexpr uint32_t SR_IDLE     = (1u << 1);
    constexpr uint32_t SR_INT_ERR  = (1u << 4);
    constexpr uint32_t SR_SLV_ERR  = (1u << 5);
    constexpr uint32_t SR_DEC_ERR  = (1u << 6);
    constexpr uint32_t SR_IOC_IRQ  = (1u << 12);
    constexpr uint32_t SR_ERR_IRQ  = (1u << 14);
    constexpr uint32_t SR_ALL_ERR  = SR_INT_ERR | SR_SLV_ERR | SR_DEC_ERR;
    constexpr uint32_t SR_ALL_IRQ  = SR_IOC_IRQ | SR_ERR_IRQ;

    constexpr size_t DMA_REGS_PAGE = 0x1000;  // AXI DMA register space is always one page
}


class PLInterface {
private:
    // AXI-Lite (HLS IP control — UIO auto-discovered)
    int _ctrl_fd;
    volatile uint32_t* _ctrl_regs;
    size_t _ctrl_size;

    // DDR (/dev/mem mapped)
    void* _ddr_base;
    uint64_t _ddr_phys;
    size_t _ddr_size;

    // DMA stream (inline — /dev/mem mapped registers + udmabuf data)
    volatile uint32_t* _dma_regs;
    DmaBuffer _stream_buf;

    bool _initialized;
    bool _mock_mode;
    Logger* _logger;
    ErrorHandler* _err;
    uint32_t _mock_regs[512];

public:
    PLInterface(Logger* log, ErrorHandler* error);
    ~PLInterface();
    
    bool init(const std::string& device_name, bool mock = false);
    bool initDDR(uint64_t addr, size_t size);
    bool initDMA(uint64_t dma_base_addr, size_t buf_size = 0x100000);
    void cleanup();
    
    // Register access (AXI-Lite)
    uint32_t readReg(uint32_t offset);
    void writeReg(uint32_t offset, uint32_t value);
    void writeReg64(uint32_t offset_lo, uint64_t value);
    uint64_t readReg64(uint32_t offset_lo);
    void setRegBits(uint32_t offset, uint32_t mask);
    void clearRegBits(uint32_t offset, uint32_t mask);
    bool testRegBits(uint32_t offset, uint32_t mask);
    
    // Control
    bool reset();
    bool start();
    bool waitDone(uint32_t timeout_ms);
    bool isBusy();
    bool isError();
    bool clearIRQ();
    void beginConfig();
    void endConfig();
    
    // Memory
    bool writeDDR(uint64_t offset, const void* data, size_t size);
    bool readDDR(uint64_t offset, void* data, size_t size);
    void* getDDRPtr(uint64_t offset);
    
    // DMA Stream
    bool sendStream(const void* data, size_t size, uint32_t timeout_ms = 1000);
    bool recvStream(void* data, size_t size, uint32_t timeout_ms = 1000);
    bool resetDMA();
    std::string dmaStatusString() const;
    
    // IRQ
    bool waitIRQ(uint32_t timeout_ms);
    uint32_t getIRQStatus();
    uint32_t getErrorCode();
    
    bool isInitialized() const { return _initialized; }
    bool isMockMode() const { return _mock_mode; }

private:
    bool findAndOpenUIO(const std::string& device_name);
    bool mapDDR();
    bool mapDmaRegs(uint64_t phys_addr);
    void unmapAll();

    // DMA register helpers (operate on dma_regs)
    uint32_t dmaRead(uint32_t offset) const;
    void dmaWrite(uint32_t offset, uint32_t val);
    bool dmaResetChannel(uint32_t cr_off, uint32_t sr_off, uint32_t timeout_us = 10000);
    bool dmaTransfer(uint32_t cr_off, uint32_t sr_off, uint32_t addr_off,
                     uint32_t addr_msb_off, uint32_t len_off,
                     uint64_t phys_addr, uint32_t length);
    bool dmaWait(uint32_t sr_off, uint32_t timeout_ms);
};

#endif
