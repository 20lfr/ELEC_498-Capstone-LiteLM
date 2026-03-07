// pl_interface.cpp
#include "pl_interface.hpp"
#include "error_handler.hpp"
#include "logger.hpp"
#include <cstdio>
#include <cstdlib>

PLInterface::PLInterface(Logger *log, ErrorHandler *error, bool mock)
    : _ctrl_fd(-1), _ctrl_regs(nullptr), _ctrl_size(0), _addr_regs(nullptr),
      _addr_size(0), _stream_regs(nullptr), _initialized(false),
      _mock_mode(mock), _logger(log), _err(error) {
    if (_mock_mode) {
        memset(_mock_regs, 0, sizeof(_mock_regs));
    }
}

PLInterface::~PLInterface() { cleanup(); }

// Init / Cleanup
bool PLInterface::init(const std::string &device_name,
                       uint64_t stream_reg_base_addr) {

    if (_mock_mode) {
        LOG_INFO("PLInterface: Mock mode");
        _mock_regs[PLReg::CONTROL / 4] = CTRL_RESETN_BIT;
        // _mock_regs[PLReg::STATUS / 4] = STATUS_IDLE;
        _initialized = true;
        return true;
    }

    if (!findAndOpenUIO(device_name))
        return false;
    if (!mapStreamRegs(stream_reg_base_addr))
        return false;

    // Enable auto_restart so HLS loops; PS controls via ctrl_mem (UG1399)
    writeReg(PLReg::AXIL_AP_CTRL,
             PLReg::AP_AUTO_RESTART_BIT | PLReg::AP_START_BIT);
    // Reset (Ctrl and Stream)
    reset();

    _initialized = true;
    LOG_INFO("PLInterface: Initialized");
    return true;
}

// Unified DMA init
bool PLInterface::initDMA(const std::string &dmabuf_name, size_t dmabuf_size) {
    if (_mock_mode) {
        if (!_dma_buf.allocate(dmabuf_name, dmabuf_size, true))
            return false;
        // Mock registers for DMA
        _stream_regs =
            _mock_regs + (0x1000 / 4); // Just an offset in mock array
        return true;
    }

    if (!_dma_buf.allocate(dmabuf_name, dmabuf_size)) {
        _err->setError(ErrorCode::MMAP_FAILED, "DMA buffer alloc failed");
        return false;
    }

    // Clear buffer
    memset(_dma_buf.virt(), 0, dmabuf_size);

    std::string phys_str = std::to_string(_dma_buf.phys());
    std::string size_str = std::to_string(dmabuf_size / 1024 / 1024);
    _logger->info("DMA initialized: buf=0x" + phys_str + " (" + size_str +
                  " MB)");
    return true;
}

void PLInterface::cleanup() {
    if (_ctrl_fd >= 0) {
        close(_ctrl_fd);
        _ctrl_fd = -1;
    }
    _dma_buf.release();
    unmapAll();
    _initialized = false;
}

// UIO Device Discovery — maps both map0 (control) and map1 (control_r)
bool PLInterface::findAndOpenUIO(const std::string &device_name) {
    struct dirent **namelist;
    int n = scandir("/sys/class/uio", &namelist, nullptr, alphasort);
    if (n < 0) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND,
                       "Cannot scan /sys/class/uio");
        return false;
    }

    int uio_num = -1;
    for (int i = 0; i < n; i++) {
        if (uio_num < 0) {
            char path[256], name[64] = {0};
            snprintf(path, sizeof(path), "/sys/class/uio/%s/name",
                     namelist[i]->d_name);
            FILE *fp = fopen(path, "r");
            if (fp) {
                if (fgets(name, sizeof(name), fp)) {
                    // Strip trailing newline
                    char *nl = strchr(name, '\n');
                    if (nl)
                        *nl = '\0';
                }
                fclose(fp);
                if (device_name == name) {
                    uio_num = atoi(namelist[i]->d_name + 3); // skip "uio"
                }
            }
        }
        free(namelist[i]);
    }
    free(namelist);

    if (uio_num < 0) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND,
                       "UIO device '" + device_name + "' not found");
        return false;
    }

    // Read map0 size (control) and map1 size (control_r) from sysfs
    size_t map_sizes[2] = {0, 0};
    for (int i = 0; i < 2; i++) {
        char path[256];
        snprintf(path, sizeof(path), "/sys/class/uio/uio%d/maps/map%d/size",
                 uio_num, i);
        FILE *fp = fopen(path, "r");
        if (!fp) {
            if (i == 0) {
                _err->setError(ErrorCode::DEVICE_NOT_FOUND,
                               "Cannot read UIO map0 size");
                return false;
            }
            // map1 may not exist if control_r is a separate UIO device
            LOG_INFO("PLInterface: map1 not found, control_r may be separate");
            break;
        }
        unsigned long sz = 0;
        fscanf(fp, "0x%lx", &sz);
        fclose(fp);
        map_sizes[i] = sz;
    }
    _ctrl_size = map_sizes[0];
    _addr_size = map_sizes[1];

    // Open /dev/uioN
    char dev_path[64];
    snprintf(dev_path, sizeof(dev_path), "/dev/uio%d", uio_num);
    _ctrl_fd = open(dev_path, O_RDWR);
    if (_ctrl_fd < 0) {
        _err->setError(ErrorCode::UIO_OPEN_FAILED,
                       std::string(dev_path) + ": " + strerror(errno));
        return false;
    }

    // mmap map0 — the 'control' slave interface
    void *m0 = mmap(nullptr, _ctrl_size, PROT_READ | PROT_WRITE, MAP_SHARED,
                    _ctrl_fd, 0);
    if (m0 == MAP_FAILED) {
        _err->setError(ErrorCode::MMAP_FAILED,
                       "UIO mmap map0: " + std::string(strerror(errno)));
        close(_ctrl_fd);
        _ctrl_fd = -1;
        return false;
    }
    _ctrl_regs = static_cast<volatile uint32_t *>(m0);

    // mmap map1 — the 'control_r' slave interface (m_axi base addresses)
    if (_addr_size > 0) {
        void *m1 = mmap(nullptr, _addr_size, PROT_READ | PROT_WRITE, MAP_SHARED,
                        _ctrl_fd, getpagesize());
        if (m1 == MAP_FAILED) {
            _err->setError(ErrorCode::MMAP_FAILED,
                           "UIO mmap map1: " + std::string(strerror(errno)));
            _addr_regs = nullptr;
        } else {
            _addr_regs = static_cast<volatile uint32_t *>(m1);
        }
    }

    LOG_INFO("PLInterface: Found " + device_name + " at " +
             std::string(dev_path) + " (map0=0x" + std::to_string(_ctrl_size) +
             ", map1=0x" + std::to_string(_addr_size) + ")");
    return true;
}

bool PLInterface::mapStreamRegs(uint64_t phys_addr) {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND,
                       "/dev/mem: " + std::string(strerror(errno)));
        return false;
    }
    void *m = mmap(nullptr, StreamReg::STREAM_REGS_PAGE, PROT_READ | PROT_WRITE,
                   MAP_SHARED, fd, phys_addr);
    close(fd);
    if (m == MAP_FAILED) {
        _err->setError(ErrorCode::MMAP_FAILED,
                       "DMA regs: " + std::string(strerror(errno)));
        return false;
    }
    _stream_regs = static_cast<volatile uint32_t *>(m);
    return true;
}

void PLInterface::unmapAll() {
    if (_ctrl_regs) {
        munmap((void *)_ctrl_regs, _ctrl_size);
        _ctrl_regs = nullptr;
    }
    if (_addr_regs) {
        munmap((void *)_addr_regs, _addr_size);
        _addr_regs = nullptr;
    }
    if (_stream_regs) {
        munmap((void *)_stream_regs, StreamReg::STREAM_REGS_PAGE);
        _stream_regs = nullptr;
    }
}

// Bus pointer dispatch
volatile uint32_t *PLInterface::busPtr(RegBus bus) const {
    switch (bus) {
    case RegBus::CTRL:
        return _ctrl_regs;
    case RegBus::ADDR:
        return _addr_regs;
    case RegBus::STREAM:
        return _stream_regs;
    }
    return nullptr;
}

// Register access — bus-explicit
uint32_t PLInterface::readReg(RegBus bus, uint32_t offset) const {
    if (_mock_mode)
        return _mock_regs[offset / 4];
    volatile uint32_t *regs = busPtr(bus);
    return regs ? regs[offset / 4] : 0;
}

void PLInterface::writeReg(RegBus bus, uint32_t offset, uint32_t value) {
    if (_mock_mode) {
        _mock_regs[offset / 4] = value;
        return;
    }
    volatile uint32_t *regs = busPtr(bus);
    if (regs)
        regs[offset / 4] = value;
}

uint64_t PLInterface::readReg64(RegBus bus, uint32_t offset_lo) const {
    return (static_cast<uint64_t>(readReg(bus, offset_lo + 4)) << 32) |
           readReg(bus, offset_lo);
}

void PLInterface::writeReg64(RegBus bus, uint32_t offset_lo, uint64_t value) {
    writeReg(bus, offset_lo, static_cast<uint32_t>(value & 0xFFFFFFFFu));
    writeReg(bus, offset_lo + 4, static_cast<uint32_t>(value >> 32));
}

// Control operations
bool PLInterface::reset() {
    writeReg(PLReg::CONTROL, 0); // Assert reset
    usleep(1000);
    writeReg(PLReg::CONTROL, CTRL_RESETN_BIT); // Release reset

    // irq_clear = !irq_enable_mask: disable IRQs, set clear high
    clearIRQ();

    // Reset (Stream DMA IP)
    resetStream();
    return true;
}

void PLInterface::beginConfig() {
    // irq_clear = !irq_enable_mask during config writes
    // Disable interrupts AND set clear high for defense-in-depth
    writeReg(PLReg::IRQ_MASK, 0); // Disable IRQs
    writeReg(PLReg::IRQ_CLEAR,
             IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT); // Set clear high
}

void PLInterface::endConfig() {
    // irq_clear = !irq_enable_mask after config
    // Enable interrupts AND clear the clear bit
    writeReg(PLReg::IRQ_CLEAR, 0); // Clear low
    usleep(100);
    writeReg(PLReg::IRQ_MASK,
             IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT); // Enable IRQs
    usleep(100);

    if (testRegBits(PLReg::IRQ_STATUS, IRQ_ERROR_BIT)) {
        std::string msg =
            getErrorCodeString(ERR_DMA_ALIGNMENT | ERR_DMA_ZERO_STRIDE);
        LOG_ERROR("Config error: " + msg);
        _err->setError(ErrorCode::CONFIG_ERROR, msg);
    }
}

bool PLInterface::start() {
    if (!_initialized || isError())
        return false;
    setRegBits(PLReg::CONTROL, CTRL_START_BIT);
    return true;
}

bool PLInterface::waitDone(uint32_t timeout_ms) {
    if (_mock_mode) {
        usleep(100000);
        _mock_regs[PLReg::IRQ_STATUS / 4] |= IRQ_INFER_DONE_BIT;
        return true;
    }

    if (!waitIRQ(timeout_ms)) {
        _err->setError(ErrorCode::HARDWARE_TIMEOUT, "waitDone: IRQ timeout");
        return false;
    }

    if (testRegBits(PLReg::IRQ_STATUS, IRQ_ERROR_BIT)) {
        _err->setError(ErrorCode::HARDWARE_FAULT, "HW error");
        return false;
    }
    if (testRegBits(PLReg::IRQ_STATUS, IRQ_INFER_DONE_BIT))
        return true;

    LOG_WARN("waitDone: spurious IRQ wakeup");
    return false;
}

std::string PLInterface::getRegStats(bool compact) {
    uint32_t status = readReg(PLReg::STATUS);
    uint32_t irq_status = readReg(PLReg::IRQ_STATUS);
    uint32_t error_code = readReg(PLReg::ERROR_CODE);
    uint32_t layer_idx = readReg(PLReg::LAYER_INDEX);
    uint32_t head_idx = readReg(PLReg::HEAD_INDEX);
    uint32_t token_idx = readReg(PLReg::TOKEN_INDEX);

    char buf[512];
    if (compact) {
        snprintf(buf, sizeof(buf),
                 "status=0x%08X irq=0x%08X error=0x%08X "
                 "layer=%u head=%u token=%u | %s | stream: %s",
                 status, irq_status, error_code, layer_idx, head_idx,
                 token_idx, getErrorCodeString(error_code).c_str(),
                 streamStatusString().c_str());
    } else {
        snprintf(buf, sizeof(buf),
                 "  Status:     0x%08X\n"
                 "  IRQ Status: 0x%08X\n"
                 "  Error Code: 0x%08X  %s\n"
                 "  Layer:      %u\n"
                 "  Head:       %u\n"
                 "  Token:      %u\n"
                 "  Stream:     %s",
                 status, irq_status, error_code,
                 getErrorCodeString(error_code).c_str(),
                 layer_idx, head_idx, token_idx,
                 streamStatusString().c_str());
    }
    return std::string(buf);
}

// DDR access
bool PLInterface::writeDDR(uint32_t offset, const void *data, size_t size,
                           bool sync_to_pl) {
    if (!_dma_buf.isAllocated() || offset + size > _dma_buf.size())
        return false;
    memcpy((uint8_t *)_dma_buf.virt() + offset, data, size);
    if (sync_to_pl) {
        _dma_buf.sync_pl();
    }
    return true;
}

bool PLInterface::readDDR(uint32_t offset, void *data, size_t size,
                          bool sync_from_pl) {
    if (!_dma_buf.isAllocated() || offset + size > _dma_buf.size())
        return false;
    if (sync_from_pl) {
        _dma_buf.sync_cpu();
    }
    memcpy(data, (uint8_t *)_dma_buf.virt() + offset, size);
    return true;
}

void PLInterface::syncDDRToPL() {
    if (_dma_buf.isAllocated()) {
        _dma_buf.sync_pl();
    }
}

void PLInterface::syncDDRToCPU() {
    if (_dma_buf.isAllocated()) {
        _dma_buf.sync_cpu();
    }
}

// Stream API
bool PLInterface::streamTransfer(uint32_t cr_off, uint32_t sr_off,
                                 uint32_t addr_off, uint32_t addr_msb_off,
                                 uint32_t len_off, uint64_t phys_addr,
                                 uint32_t length) {
    // PG021 programming sequence:
    // 1. Clear & enable interrupts
    writeReg(RegBus::STREAM, sr_off, StreamReg::SR_ALL_IRQ_BITS);
    uint32_t cr = readReg(RegBus::STREAM, cr_off);
    writeReg(RegBus::STREAM, cr_off,
             cr | StreamReg::CR_IOC_EN_BIT | StreamReg::CR_ERR_EN_BIT);

    // 2. Set address
    writeReg(RegBus::STREAM, addr_off,
             static_cast<uint32_t>(phys_addr & 0xFFFFFFFF));
    writeReg(RegBus::STREAM, addr_msb_off,
             static_cast<uint32_t>(phys_addr >> 32));

    // 3. Start channel (RS=1)
    cr = readReg(RegBus::STREAM, cr_off);
    writeReg(RegBus::STREAM, cr_off, cr | StreamReg::CR_RS_BIT);

    // 4. Set length — triggers transfer
    writeReg(RegBus::STREAM, len_off, length);
    return true;
}

bool PLInterface::streamWait(uint32_t sr_off, uint32_t timeout_ms) {
    for (uint32_t t = 0; t < timeout_ms; t++) {
        uint32_t sr = readReg(RegBus::STREAM, sr_off);
        if (sr & StreamReg::SR_IOC_IRQ_BIT) {
            writeReg(RegBus::STREAM, sr_off,
                     StreamReg::SR_ALL_IRQ_BITS); // clear
            return true;
        }
        if (sr & StreamReg::SR_ALL_ERR_BITS) {
            LOG_ERROR("DMA error: " + streamStatusString());
            writeReg(RegBus::STREAM, sr_off, StreamReg::SR_ALL_IRQ_BITS);
            return false;
        }
        usleep(1000);
    }
    LOG_ERROR("DMA timeout: " + streamStatusString());
    return false;
}

bool PLInterface::resetStream() {
    bool ok = true;
    writeReg(RegBus::STREAM, StreamReg::MM2S_CR, StreamReg::CR_RESET_BIT);
    for (uint32_t t = 0; t < 10; t++) {
        usleep(100);
        ok &= (readReg(RegBus::STREAM, StreamReg::MM2S_CR) &
               StreamReg::CR_RESET_BIT) == 0;
    }
    writeReg(RegBus::STREAM, StreamReg::S2MM_CR, StreamReg::CR_RESET_BIT);
    for (uint32_t t = 0; t < 10; t++) {
        usleep(100);
        ok &= (readReg(RegBus::STREAM, StreamReg::S2MM_CR) &
               StreamReg::CR_RESET_BIT) == 0;
    }
    return ok;
}

bool PLInterface::streamInitSend(uint32_t dma_offset, const void *data,
                                 size_t size) {
    if (!_stream_regs || !_dma_buf.isAllocated())
        return false;
    writeDDR(dma_offset, data, size);
    return streamTransfer(StreamReg::MM2S_CR, StreamReg::MM2S_SR,
                          StreamReg::MM2S_SA, StreamReg::MM2S_SA_MSB,
                          StreamReg::MM2S_LEN, _dma_buf.phys() + dma_offset,
                          size);
}

bool PLInterface::streamInitRecv(uint32_t dma_offset, size_t size) {
    if (!_stream_regs || !_dma_buf.isAllocated())
        return false;
    if (dma_offset + size > _dma_buf.size())
        return false; // Bounds check

    return streamTransfer(StreamReg::S2MM_CR, StreamReg::S2MM_SR,
                          StreamReg::S2MM_DA, StreamReg::S2MM_DA_MSB,
                          StreamReg::S2MM_LEN, _dma_buf.phys() + dma_offset,
                          size);
}

bool PLInterface::streamWaitSend(uint32_t timeout_ms) {
    return streamWait(StreamReg::MM2S_SR, timeout_ms);
}

bool PLInterface::streamWaitRecv(uint32_t dma_offset, void *data, size_t size,
                                 uint32_t timeout_ms) {
    if (!streamWait(StreamReg::S2MM_SR, timeout_ms))
        return false;
    readDDR(dma_offset, data, size);
    return true;
}

std::string PLInterface::streamStatusString() const {
    if (!_stream_regs)
        return "Stream not initialized";

    uint32_t mm2s_sr = readReg(RegBus::STREAM, StreamReg::MM2S_SR);
    uint32_t s2mm_sr = readReg(RegBus::STREAM, StreamReg::S2MM_SR);
    char buf[256];
    snprintf(buf, sizeof(buf),
             "MM2S[SR=0x%08X halt=%d idle=%d err=%d] "
             "S2MM[SR=0x%08X halt=%d idle=%d err=%d]",
             mm2s_sr, (mm2s_sr & StreamReg::SR_HALTED_BIT) ? 1 : 0,
             (mm2s_sr & StreamReg::SR_IDLE_BIT) ? 1 : 0,
             (mm2s_sr & StreamReg::SR_ALL_ERR_BITS) ? 1 : 0, s2mm_sr,
             (s2mm_sr & StreamReg::SR_HALTED_BIT) ? 1 : 0,
             (s2mm_sr & StreamReg::SR_IDLE_BIT) ? 1 : 0,
             (s2mm_sr & StreamReg::SR_ALL_ERR_BITS) ? 1 : 0);
    return std::string(buf);
}

bool PLInterface::clearIRQ() {
    writeReg(PLReg::IRQ_CLEAR, IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT);
    usleep(10);
    writeReg(PLReg::IRQ_CLEAR, 0);
    return true;
}

// UIO interrupt wait: unmask -> poll -> acknowledge
bool PLInterface::waitIRQ(uint32_t timeout_ms) {
    if (_mock_mode) {
        usleep(100000);
        return true;
    }

    // Unmask UIO interrupt (required before each wait)
    uint32_t unmask = 1;
    if (write(_ctrl_fd, &unmask, sizeof(unmask)) != sizeof(unmask))
        return false;

    struct pollfd pfd = {_ctrl_fd, POLLIN, 0};
    int r = poll(&pfd, 1, timeout_ms);
    if (r <= 0)
        return false;

    // Acknowledge interrupt
    uint32_t irq_count = 0;
    read(_ctrl_fd, &irq_count, sizeof(irq_count));
    return true;
}

std::string PLInterface::getErrorCodeString(const uint32_t error_mask) {
    uint32_t code = getErrorCode() & error_mask;
    if (code == ERR_NONE)
        return "No error";

    std::string msg;
    auto append = [&msg](const char *text) {
        if (!msg.empty())
            msg += " | ";
        msg += text;
    };

    if (code & ERR_DMA_ALIGNMENT)
        append("DMA alignment error");
    if (code & ERR_DMA_ZERO_LEN)
        append("DMA zero-length transfer");
    if (code & ERR_DMA_ZERO_STRIDE)
        append("DMA zero stride");
    if (code & ERR_SCHEDULER_ERROR)
        append("Scheduler error");
    if (code & ERR_COMPUTE_ERROR)
        append("Compute error");
    if (code & ERR_MMU_INVALID)
        append("MMU invalid state");
    if (code & ERR_MMU_OVERFLOW)
        append("MMU overflow");
    if (code & ERR_MMU_UNSUPPORTED_REQ_DMA)
        append("MMU unsupported DMA request");
    if (code & ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED)
        append("MMU unsupported headed compute request");
    if (code & ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED)
        append("MMU unsupported non-headed compute request");
    if (code & ERR_MMU_BAD_DMA_PLAN)
        append("MMU bad DMA plan");
    if (code & ERR_MMU_BAD_DMA_ADDR)
        append("MMU bad DMA address");
    if (code & ERR_MMU_REGION_ACCESS)
        append("MMU invalid region access");
    if (code & ERR_MMU_CONCAT_SOURCE)
        append("MMU invalid concat source");
    if (code & ERR_MMU_WRITEBACK_SRC)
        append("MMU invalid writeback source");
    if (code & ERR_MMU_QUEUE_OVERFLOW)
        append("MMU queue overflow");
    if (code & ERR_MMU_REGION_OVERFLOW)
        append("MMU region overflow");
    if (code & ERR_MMU_STREAM_OUTPUT_MISSING)
        append("MMU missing stream output region");
    if (code & ERR_MMU_MISSING_REGION_FULL_READ)
        append("MMU missing full-read region");
    if (code & ERR_MMU_MISSING_REGION_PARTIAL_READ)
        append("MMU missing partial-read region");
    if (code & ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP)
        append("MMU missing compute read-prep region");
    if (code & ERR_MMU_REGION_OVERFLOW_STREAM_IN)
        append("MMU stream-in region overflow");
    if (code & ERR_MMU_REGION_OVERFLOW_DMA_CONCAT)
        append("MMU DMA concat region overflow");
    if (code & ERR_MMU_REGION_OVERFLOW_DMA_STORE)
        append("MMU DMA store region overflow");
    if (code & ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE)
        append("MMU compute write region overflow");
    if (code & ERR_MMU_REGION_TABLE_FULL)
        append("MMU region table full");
    if (code & ERR_MMU_URAM_CHUNK_ALLOC_FAIL)
        append("MMU URAM chunk allocation failure");
    if (code & ERR_MMU_REGION_TOO_LARGE)
        append("MMU region too large");

    if (msg.empty())
        append("Unknown error code");

    return msg;
}
