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

enum class DmaBufferType : uint8_t {
    WEIGHTS,
    KV_CACHE,
    IO_STREAM
};

// mmap'd register bus selector
enum class RegBus : uint8_t {
    CTRL,       // ctrl_mem + status_mem
    ADDR,       // m_axi base addresses (ddr_weights, ddr_kvcache)
    STREAM      // stream channel registers
};

// HLS REGISTER OFFSETS - UPDATE AFTER SYNTHESIS
// Get actual values from: hardware_overlay/drivers/<top>/src/x<top>_hw.h
namespace PLReg {
    // TODO: Replace these with actual HLS-generated offsets
    constexpr uint32_t AXIL_AP_CTRL     = XAXI_TOP_CONTROL_ADDR_AP_CTRL;
    constexpr uint32_t AXIL_GIE         = XAXI_TOP_CONTROL_ADDR_GIE;
    constexpr uint32_t AXIL_IER         = XAXI_TOP_CONTROL_ADDR_IER;
    constexpr uint32_t AXIL_ISR         = XAXI_TOP_CONTROL_ADDR_ISR;

    // AXI-Lite Control Register Bits (From Vitis HLS UG1399)
    constexpr uint32_t AP_START_BIT         = (1u << 0);
    constexpr uint32_t AP_DONE_BIT          = (1u << 1);
    constexpr uint32_t AP_IDLE_BIT          = (1u << 2);
    constexpr uint32_t AP_READY_BIT         = (1u << 3);
    constexpr uint32_t AP_AUTO_RESTART_BIT  = (1u << 7);

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
    
    constexpr uint32_t LAYER_STRIDE     = CTRL_BASE + 0x0C;
    constexpr uint32_t WQ_HEAD_STRIDE   = CTRL_BASE + 0x10;
    constexpr uint32_t WK_HEAD_STRIDE   = CTRL_BASE + 0x14;
    constexpr uint32_t WV_HEAD_STRIDE   = CTRL_BASE + 0x18;
    constexpr uint32_t K_CACHE_STRIDE   = CTRL_BASE + 0x1C;
    constexpr uint32_t V_CACHE_STRIDE   = CTRL_BASE + 0x20;
    constexpr uint32_t WO_TILE_STRIDE   = CTRL_BASE + 0x24;
    constexpr uint32_t W1_TILE_STRIDE   = CTRL_BASE + 0x28;
    constexpr uint32_t W2_TILE_STRIDE   = CTRL_BASE + 0x2C;
    
    // Weight/KV-cache word offsets (within ctrl_mem struct)
    constexpr uint32_t WQ_OFFSET        = CTRL_BASE + 0x30;
    constexpr uint32_t WK_OFFSET        = CTRL_BASE + 0x34;
    constexpr uint32_t WV_OFFSET        = CTRL_BASE + 0x38;
    constexpr uint32_t WO_OFFSET        = CTRL_BASE + 0x3C;
    constexpr uint32_t W1_OFFSET        = CTRL_BASE + 0x40;
    constexpr uint32_t W2_OFFSET        = CTRL_BASE + 0x44;
    constexpr uint32_t K_CACHE_OFFSET   = CTRL_BASE + 0x48;
    constexpr uint32_t V_CACHE_OFFSET   = CTRL_BASE + 0x4C;
    
    // Quantization
    constexpr uint32_t LOGIT_SCALE_QV   = CTRL_BASE + 0x50;
    constexpr uint32_t SCALE_Q          = CTRL_BASE + 0x54;
    constexpr uint32_t ZERO_POINT_Q     = CTRL_BASE + 0x58;
    constexpr uint32_t SCALE_K          = CTRL_BASE + 0x5C;
    constexpr uint32_t ZERO_POINT_K     = CTRL_BASE + 0x60;
    constexpr uint32_t SCALE_V          = CTRL_BASE + 0x64;
    constexpr uint32_t ZERO_POINT_V     = CTRL_BASE + 0x68;
    
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
    // these will late come from shared filed between firmware and HLS code
    constexpr uint32_t ERR_NONE             = 0x00;
    constexpr uint32_t ERR_DMA_ALIGNMENT    = 0x10;
    constexpr uint32_t ERR_DMA_ZERO_STRIDE  = 0x11;
}

// m_axi Base Address Registers (on s_axi_control_r bundle)
// These live on a SEPARATE AXI-Lite interface from PLReg — use RegBus::ADDR
namespace AddrReg {
    constexpr uint32_t WEIGHTS_BASE_LO  = XAXI_TOP_CONTROL_R_ADDR_DDR_WEIGHTS_DATA;
    constexpr uint32_t WEIGHTS_BASE_HI  = XAXI_TOP_CONTROL_R_ADDR_DDR_WEIGHTS_DATA + 4;
    constexpr uint32_t KV_CACHE_BASE_LO = XAXI_TOP_CONTROL_R_ADDR_DDR_KVCACHE_DATA;
    constexpr uint32_t KV_CACHE_BASE_HI = XAXI_TOP_CONTROL_R_ADDR_DDR_KVCACHE_DATA + 4;
}

// AXI DMA Register Offsets (PG021 Direct Register Mode)
namespace StreamReg {
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

    constexpr size_t STREAM_REGS_PAGE = 0x1000;  // AXI DMA register space is always one page
}


class PLInterface {
private:
    // ctrl_mem + status_mem (UIO map0)
    int _ctrl_fd;
    volatile uint32_t* _ctrl_regs;
    size_t _ctrl_size;

    // m_axi base addresses (UIO map1)
    volatile uint32_t* _addr_regs;
    size_t _addr_size;

    // DDR buffer for weights transfers
    DmaBuffer _dma_buf0;
    // DDR buffer for I/O streams & KV cache transfers
    DmaBuffer _dma_buf1;

    // AXI DMA IP registers (/dev/mem mapped)
    volatile uint32_t* _stream_regs;

    bool _initialized;
    bool _mock_mode;
    Logger* _logger;
    ErrorHandler* _err;
    uint32_t _mock_regs[512];

public:
    PLInterface(Logger* log, ErrorHandler* error, bool mock = false);
    ~PLInterface();
    
    bool init(const std::string& device_name, uint64_t stream_reg_base_addr);
    bool initDMA(const std::string& dmabuf0_name, size_t dmabuf0_size, const std::string& dmabuf1_name, size_t dmabuf1_size);
    void cleanup();
    
    // Default overloads use RegBus::CTRL
    uint32_t readReg(uint32_t offset) const { return readReg(RegBus::CTRL, offset); }
    void writeReg(uint32_t offset, uint32_t value) { writeReg(RegBus::CTRL, offset, value); }
    uint32_t readReg(RegBus bus, uint32_t offset) const;
    void writeReg(RegBus bus, uint32_t offset, uint32_t value);
    
    void writeReg64(RegBus bus, uint32_t offset_lo, uint64_t value);
    void writeReg64(uint32_t offset_lo, uint64_t value) { writeReg64(RegBus::CTRL, offset_lo, value); }
    uint64_t readReg64(RegBus bus, uint32_t offset_lo) const;
    uint64_t readReg64(uint32_t offset_lo) { return readReg64(RegBus::CTRL, offset_lo); }
    
    void setRegBits(uint32_t offset, uint32_t mask) {
        writeReg(offset, readReg(offset) | mask);
    }
    void clearRegBits(uint32_t offset, uint32_t mask) {
        writeReg(offset, readReg(offset) & ~mask);
    }
    bool testRegBits(uint32_t offset, uint32_t mask) {
        return (readReg(offset) & mask) != 0;
    }
    
    // Control
    bool reset();
    bool start();
    bool waitDone(uint32_t timeout_ms);
    bool isBusy() { return testRegBits(PLReg::STATUS, PLReg::STATUS_BUSY_BIT); }
    bool isError() { return testRegBits(PLReg::STATUS, PLReg::STATUS_ERROR_BIT); }
    bool clearIRQ();
    void beginConfig();
    void endConfig();

    // Memory
    bool writeDDR(DmaBufferType type, uint32_t dma_offset, const void* data, size_t size);
    bool readDDR(DmaBufferType type, uint32_t dma_offset, void* data, size_t size);
    uint64_t getDDRBaseAddr(DmaBufferType type) const { 
        if (type == DmaBufferType::WEIGHTS) return _dma_buf0.phys(); 
        else return _dma_buf1.phys(); 
    }
    
    // DMA Stream (non-blocking kick/wait)
    bool streamInitSend(uint32_t dma_offset, const void* data, size_t size);
    bool streamInitRecv(uint32_t dma_offset, size_t size);
    bool streamWaitSend(uint32_t timeout_ms = 1000);
    bool streamWaitRecv(uint32_t dma_offset, void* data, size_t size, uint32_t timeout_ms);
    
    bool resetStream();
    std::string streamStatusString() const;
    
    // IRQ
    bool waitIRQ(uint32_t timeout_ms);
    uint32_t getErrorCode() { return readReg(PLReg::ERROR_CODE); }
    uint32_t getIRQStatus() { return readReg(PLReg::IRQ_STATUS); }
    
    bool isInitialized() const { return _initialized; }
    bool isMockMode() const { return _mock_mode; }

private:
    volatile uint32_t* busPtr(RegBus bus) const;
    bool findAndOpenUIO(const std::string& device_name);
    bool mapStreamRegs(uint64_t phys_addr);
    void unmapAll();

    // AXI Stream DMA IP helpers (PG021)
    bool streamTransfer(uint32_t cr_off, uint32_t sr_off, uint32_t addr_off,
                     uint32_t addr_msb_off, uint32_t len_off,
                     uint64_t phys_addr, uint32_t length);
    bool streamWait(uint32_t sr_off, uint32_t timeout_ms);
};

#endif
