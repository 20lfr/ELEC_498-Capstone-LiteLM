// pl_interface.hpp - Corrected for HLS ControlMemSpace/StatusMemSpace
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

class Logger;
class ErrorHandler;
enum class ErrorCode;

// =============================================================================
// HLS REGISTER OFFSETS - UPDATE AFTER SYNTHESIS
// Get actual values from: <project>/solution/impl/ip/drivers/<top>/src/x<top>_hw.h
// =============================================================================
namespace PLReg {
    // TODO: Replace these with actual HLS-generated offsets
    constexpr uint32_t CTRL_BASE = 0x10;  // Verify with HLS driver
    
    // ControlMemSpace (PS->PL writes)
    constexpr uint32_t CONTROL         = CTRL_BASE + 0x00;
    
    // IRQ enable mask - write (IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT) to enable, 0 to disable
    // Maps to: ctrl_mem.irq_enable_mask
    constexpr uint32_t IRQ_ENABLE_MASK = CTRL_BASE + 0x04;
    
    // IRQ clear - write-1-to-clear
    // Rule: irq_clear = !irq_enable_mask during config (both for defense-in-depth)
    // Maps to: ctrl_mem.irq_clear
    constexpr uint32_t IRQ_CLEAR       = CTRL_BASE + 0x08;
    
    constexpr uint32_t DMA_LAYER_LEN   = CTRL_BASE + 0x0C;
    constexpr uint32_t DMA_HEAD_LEN    = CTRL_BASE + 0x10;
    constexpr uint32_t DMA_TILE_LEN    = CTRL_BASE + 0x14;
    constexpr uint32_t LAYER_STRIDE    = CTRL_BASE + 0x18;
    constexpr uint32_t WQ_HEAD_STRIDE  = CTRL_BASE + 0x1C;
    constexpr uint32_t WK_HEAD_STRIDE  = CTRL_BASE + 0x20;
    constexpr uint32_t WV_HEAD_STRIDE  = CTRL_BASE + 0x24;
    constexpr uint32_t K_CACHE_STRIDE  = CTRL_BASE + 0x28;
    constexpr uint32_t V_CACHE_STRIDE  = CTRL_BASE + 0x2C;
    constexpr uint32_t WO_TILE_STRIDE  = CTRL_BASE + 0x30;
    constexpr uint32_t W1_TILE_STRIDE  = CTRL_BASE + 0x34;
    constexpr uint32_t W2_TILE_STRIDE  = CTRL_BASE + 0x38;
    
    // 64-bit addresses (LOW/HIGH pairs)
    constexpr uint32_t WQ_BASE_LO      = CTRL_BASE + 0x3C;
    constexpr uint32_t WQ_BASE_HI      = CTRL_BASE + 0x40;
    constexpr uint32_t WK_BASE_LO      = CTRL_BASE + 0x44;
    constexpr uint32_t WK_BASE_HI      = CTRL_BASE + 0x48;
    constexpr uint32_t WV_BASE_LO      = CTRL_BASE + 0x4C;
    constexpr uint32_t WV_BASE_HI      = CTRL_BASE + 0x50;
    constexpr uint32_t WO_BASE_LO      = CTRL_BASE + 0x54;
    constexpr uint32_t WO_BASE_HI      = CTRL_BASE + 0x58;
    constexpr uint32_t W1_BASE_LO      = CTRL_BASE + 0x5C;
    constexpr uint32_t W1_BASE_HI      = CTRL_BASE + 0x60;
    constexpr uint32_t W2_BASE_LO      = CTRL_BASE + 0x64;
    constexpr uint32_t W2_BASE_HI      = CTRL_BASE + 0x68;
    constexpr uint32_t K_CACHE_LO      = CTRL_BASE + 0x6C;
    constexpr uint32_t K_CACHE_HI      = CTRL_BASE + 0x70;
    constexpr uint32_t V_CACHE_LO      = CTRL_BASE + 0x74;
    constexpr uint32_t V_CACHE_HI      = CTRL_BASE + 0x78;
    
    // Quantization
    constexpr uint32_t LOGIT_SCALE_QV  = CTRL_BASE + 0x7C;
    constexpr uint32_t SCALE_Q         = CTRL_BASE + 0x80;
    constexpr uint32_t ZERO_POINT_Q    = CTRL_BASE + 0x84;
    constexpr uint32_t SCALE_K         = CTRL_BASE + 0x88;
    constexpr uint32_t ZERO_POINT_K    = CTRL_BASE + 0x8C;
    constexpr uint32_t SCALE_V         = CTRL_BASE + 0x90;
    constexpr uint32_t ZERO_POINT_V    = CTRL_BASE + 0x94;
    
    // StatusMemSpace (PL->PS reads)
    constexpr uint32_t STATUS_BASE = 0xA0;  // Verify with HLS driver
    constexpr uint32_t STATUS          = STATUS_BASE + 0x00;
    constexpr uint32_t IRQ_STATUS      = STATUS_BASE + 0x04;
    constexpr uint32_t ERROR_CODE      = STATUS_BASE + 0x08;
    constexpr uint32_t LAYER_INDEX     = STATUS_BASE + 0x0C;
}

// Control bits (from top_params.hpp)
constexpr uint32_t CTRL_RESETN_BIT     = 1u << 0;
constexpr uint32_t CTRL_START_BIT      = 1u << 1;

// Status bits
constexpr uint32_t STATUS_IDLE_BIT     = 1u << 0;
constexpr uint32_t STATUS_ERROR_BIT    = 1u << 1;
constexpr uint32_t STATUS_BUSY_BIT     = 1u << 2;

// IRQ bits
constexpr uint32_t IRQ_ERROR_BIT       = 1u << 1;
constexpr uint32_t IRQ_INFER_DONE_BIT  = 1u << 2;

// Error codes
constexpr uint32_t ERR_NONE            = 0x00;
constexpr uint32_t ERR_DMA_ALIGNMENT   = 0x10;
constexpr uint32_t ERR_DMA_ZERO_LEN    = 0x11;

class PLInterface {
private:
    int uio_fd;
    int stream_in_fd;
    int stream_out_fd;
    volatile uint32_t* ctrl_regs;
    void* ddr_base;
    uint64_t ctrl_phys;
    size_t ctrl_size;
    uint64_t ddr_phys;
    size_t ddr_size;
    std::string uio_dev;
    bool initialized;
    bool mock_mode;
    Logger* logger;
    ErrorHandler* err;
    uint32_t mock_regs[512];

public:
    PLInterface(Logger* log, ErrorHandler* error);
    ~PLInterface();
    
    bool init(const std::string& uio, uint64_t addr, size_t size, bool mock = false);
    bool initDDR(uint64_t addr, size_t size);
    bool initAXIStream(const std::string& in_dev, const std::string& out_dev);
    void cleanup();
    
    // Register access
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
    
    // Stream
    ssize_t writeStream(const void* data, size_t size);
    ssize_t readStream(void* data, size_t size);
    bool drainStream();
    
    // IRQ
    bool waitIRQ(uint32_t timeout_ms);
    uint32_t getIRQStatus();
    uint32_t getErrorCode();
    
    bool isInitialized() const { return initialized; }
    bool isMockMode() const { return mock_mode; }

private:
    bool openUIO(const std::string& dev);
    bool mapCtrlRegs();
    bool mapDDR();
    void unmapAll();
};

#endif
