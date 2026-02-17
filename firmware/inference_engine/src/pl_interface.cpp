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
        _mock_regs[PLReg::CONTROL / 4] = PLRegBits::CTRL_RESETN_BIT;
        _mock_regs[PLReg::STATUS / 4] = PLRegBits::STAT_IDLE_BIT;
        _initialized = true;
        return true;
    }

    if (!findAndOpenUIO(device_name))
        return false;
    if (!mapStreamRegs(stream_reg_base_addr))
        return false;

    // Enable auto_restart so HLS loops; PS controls via ctrl_mem (UG1399)
    writeReg(PLReg::AXIL_AP_CTRL,
             PLRegBits::AP_AUTO_RESTART_BIT | PLRegBits::AP_START_BIT);
    // Reset (Ctrl and Stream)
    reset();

    _initialized = true;
    LOG_INFO("PLInterface: Initialized");
    return true;
}

// Unified DMA init
bool PLInterface::initDMA(const std::string &dmabuf0_name, size_t dmabuf0_size,
                          const std::string &dmabuf1_name,
                          size_t dmabuf1_size) {
    if (_mock_mode) {
        if (!_dma_buf0.allocate(dmabuf0_name, dmabuf0_size, true))
            return false;
        if (!_dma_buf1.allocate(dmabuf1_name, dmabuf1_size, true))
            return false;
        // Mock registers for DMA
        _stream_regs =
            _mock_regs + (0x1000 / 4); // Just an offset in mock array
        return true;
    }

    if (!_dma_buf0.allocate(dmabuf0_name, dmabuf0_size)) {
        _err->setError(ErrorCode::MMAP_FAILED, "DMA buffer alloc failed");
        return false;
    }
    if (!_dma_buf1.allocate(dmabuf1_name, dmabuf1_size)) {
        _err->setError(ErrorCode::MMAP_FAILED, "DMA buffer alloc failed");
        return false;
    }

    // Clear buffer
    memset(_dma_buf0.virt(), 0, dmabuf0_size);
    memset(_dma_buf1.virt(), 0, dmabuf1_size);

    std::string phys0_str = std::to_string(_dma_buf0.phys());
    std::string phys1_str = std::to_string(_dma_buf1.phys());
    std::string size0_str = std::to_string(dmabuf0_size / 1024 / 1024);
    std::string size1_str = std::to_string(dmabuf1_size / 1024 / 1024);
    _logger->info("DMA initialized: buf=0x" + phys0_str + " (" + size0_str +
                  " MB)");
    _logger->info("DMA initialized: buf=0x" + phys1_str + " (" + size1_str +
                  " MB)");
    return true;
}

void PLInterface::cleanup() {
    if (_ctrl_fd >= 0) {
        close(_ctrl_fd);
        _ctrl_fd = -1;
    }
    _dma_buf0.release();
    _dma_buf1.release();
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
    writeReg(PLReg::CONTROL, PLRegBits::CTRL_RESETN_BIT); // Release reset

    // irq_clear = !irq_enable_mask: disable IRQs, set clear high
    writeReg(PLReg::IRQ_MASK, 0);
    writeReg(PLReg::IRQ_CLEAR,
             PLRegBits::IRQ_ERROR_BIT | PLRegBits::IRQ_INFER_DONE_BIT);
    usleep(1000);

    // Reset (Stream DMA IP)
    resetStream();
    return true;
}

void PLInterface::beginConfig() {
    // irq_clear = !irq_enable_mask during config writes
    // Disable interrupts AND set clear high for defense-in-depth
    writeReg(PLReg::IRQ_MASK, 0); // Disable IRQs
    writeReg(PLReg::IRQ_CLEAR,
             PLRegBits::IRQ_ERROR_BIT |
                 PLRegBits::IRQ_INFER_DONE_BIT); // Set clear high
}

void PLInterface::endConfig() {
    // irq_clear = !irq_enable_mask after config
    // Enable interrupts AND clear the clear bit
    writeReg(PLReg::IRQ_CLEAR, 0); // Clear low
    usleep(100);
    writeReg(PLReg::IRQ_MASK,
             PLRegBits::IRQ_ERROR_BIT |
                 PLRegBits::IRQ_INFER_DONE_BIT); // Enable IRQs
    usleep(100);

    if (testRegBits(PLReg::IRQ_STATUS, PLRegBits::IRQ_ERROR_BIT)) {
        std::string msg =
            getErrorCodeString(PLRegBits::ERR_DMA_ALIGNMENT_BIT |
                               PLRegBits::ERR_DMA_ZERO_STRIDE_BIT);
        LOG_ERROR("Config error: " + msg);
        _err->setError(ErrorCode::CONFIG_ERROR, msg);
    }
}

bool PLInterface::start() {
    if (!_initialized || isError())
        return false;
    setRegBits(PLReg::CONTROL, PLRegBits::CTRL_START_BIT);
    return true;
}

bool PLInterface::waitDone(uint32_t timeout_ms) {
    if (_mock_mode) {
        usleep(100000);
        _mock_regs[PLReg::IRQ_STATUS / 4] |= PLRegBits::IRQ_INFER_DONE_BIT;
        return true;
    }

    for (uint32_t t = 0; t < timeout_ms; t += 10) {
        if (testRegBits(PLReg::IRQ_STATUS, PLRegBits::IRQ_INFER_DONE_BIT))
            return true;
        if (testRegBits(PLReg::IRQ_STATUS, PLRegBits::IRQ_ERROR_BIT)) {
            LOG_ERROR("Inference error: " + getErrorCodeString());
            _err->setError(ErrorCode::HARDWARE_FAULT, "HW error");
            return false;
        }
        usleep(10000);
    }
    _err->setError(ErrorCode::HARDWARE_TIMEOUT, "Timeout");
    return false;
}

// DDR access
bool PLInterface::writeDDR(DmaBufType type, uint32_t offset, const void *data,
                           size_t size) {
    DmaBuffer *buf = (type == DmaBufType::WEIGHTS) ? &_dma_buf0 : &_dma_buf1;
    if (!buf->isAllocated() || offset + size > buf->size())
        return false;
    memcpy((uint8_t *)buf->virt() + offset, data, size);
    buf->sync_pl();
    return true;
}

bool PLInterface::readDDR(DmaBufType type, uint32_t offset, void *data,
                          size_t size) {
    DmaBuffer *buf = (type == DmaBufType::WEIGHTS) ? &_dma_buf0 : &_dma_buf1;
    if (!buf->isAllocated() || offset + size > buf->size())
        return false;
    buf->sync_cpu();
    memcpy(data, (uint8_t *)buf->virt() + offset, size);
    return true;
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
    if (!_stream_regs || !_dma_buf1.isAllocated())
        return false;
    writeDDR(DmaBufType::IO_STREAM, dma_offset, data, size);
    return streamTransfer(StreamReg::MM2S_CR, StreamReg::MM2S_SR,
                          StreamReg::MM2S_SA, StreamReg::MM2S_SA_MSB,
                          StreamReg::MM2S_LEN, _dma_buf1.phys() + dma_offset,
                          size);
}

bool PLInterface::streamInitRecv(uint32_t dma_offset, size_t size) {
    if (!_stream_regs || !_dma_buf1.isAllocated())
        return false;
    if (dma_offset + size > _dma_buf1.size())
        return false; // Bounds check

    return streamTransfer(StreamReg::S2MM_CR, StreamReg::S2MM_SR,
                          StreamReg::S2MM_DA, StreamReg::S2MM_DA_MSB,
                          StreamReg::S2MM_LEN, _dma_buf1.phys() + dma_offset,
                          size);
}

bool PLInterface::streamWaitSend(uint32_t timeout_ms) {
    return streamWait(StreamReg::MM2S_SR, timeout_ms);
}

bool PLInterface::streamWaitRecv(uint32_t dma_offset, void *data, size_t size,
                                 uint32_t timeout_ms) {
    if (!streamWait(StreamReg::S2MM_SR, timeout_ms))
        return false;
    readDDR(DmaBufType::IO_STREAM, dma_offset, data, size);
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
    writeReg(PLReg::IRQ_CLEAR,
             PLRegBits::IRQ_ERROR_BIT | PLRegBits::IRQ_INFER_DONE_BIT);
    usleep(10);
    writeReg(PLReg::IRQ_CLEAR, 0);
    return true;
}

// IRQ
bool PLInterface::waitIRQ(uint32_t timeout_ms) {
    if (_mock_mode) {
        usleep(100000);
        return true;
    }
    struct pollfd pfd = {_ctrl_fd, POLLIN, 0};
    int r = poll(&pfd, 1, timeout_ms);
    if (r <= 0)
        return false;
    uint32_t info = 1;
    read(_ctrl_fd, &info, sizeof(info));
    return true;
}

std::string PLInterface::getErrorCodeString(const uint32_t error_mask) {
    uint32_t code = getErrorCode() & error_mask;
    std::string msg;
    if (code & PLRegBits::ERR_DMA_ALIGNMENT_BIT)
        msg += "DMA alignment error ";
    if (code & PLRegBits::ERR_DMA_ZERO_STRIDE_BIT)
        msg += "DMA/stride zero error ";
    if (code & PLRegBits::ERR_SCHEDULER_ERROR_BIT)
        msg += "Scheduler error ";
    if (code & PLRegBits::ERR_COMPUTE_ERROR_BIT)
        msg += "Compute error ";
    if (code & PLRegBits::ERR_INPUT_STREAM_BIT)
        msg += "Input stream error ";
    if (code & PLRegBits::ERR_WEIGHTS_GET_BIT)
        msg += "Weights get error ";
    if (code & PLRegBits::ERR_KCACHE_GET_BIT)
        msg += "Kcache get error ";
    if (code & PLRegBits::ERR_KCACHE_SEND_BIT)
        msg += "Kcache send error ";
    if (code & PLRegBits::ERR_VCACHE_GET_BIT)
        msg += "Vcache get error ";
    if (code & PLRegBits::ERR_VCACHE_SEND_BIT)
        msg += "Vcache send error ";
    return msg;
}
