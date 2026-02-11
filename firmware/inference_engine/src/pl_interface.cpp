// .pl_interface.cpp - AXI-Lite control + inline DMA stream transport
#include "pl_interface.hpp"
#include "logger.hpp"
#include "error_handler.hpp"
#include <cstdio>
#include <cstdlib>

PLInterface::PLInterface(Logger* log, ErrorHandler* error)
    : _ctrl_fd(-1), _ctrl_regs(nullptr), _ctrl_size(0),
      _ddr_base(nullptr), _ddr_phys(0), _ddr_size(0),
      _dma_regs(nullptr), _initialized(false), 
      _mock_mode(false), _logger(log), _err(error) {

    memset(_mock_regs, 0, sizeof(_mock_regs));
}

PLInterface::~PLInterface() { cleanup(); }

// Init / Cleanup
bool PLInterface::init(const std::string& device_name, bool mock) {
    _mock_mode = mock;
    
    if (_mock_mode) {
        LOG_INFO("PLInterface: Mock mode");
        _mock_regs[PLReg::CONTROL / 4] = PLReg::CTRL_RESETN_BIT;
        _mock_regs[PLReg::STATUS / 4] = PLReg::STATUS_IDLE_BIT;
        _initialized = true;
        return true;
    }
    
    if (!findAndOpenUIO(device_name)) return false;
    // Assert Start signal (from Vitis HLS UG1399)
    uint32_t data = readReg(PLReg::AXIL_AP_CTRL) & PLReg::AP_AUTO_RESTART;
    writeReg(PLReg::AXIL_AP_CTRL, data | PLReg::AP_START);

    reset();
    
    _initialized = true;
    LOG_INFO("PLInterface: Initialized");
    return true;
}

bool PLInterface::initDDR(uint64_t addr, size_t size) {
    if (_mock_mode) return true;
    _ddr_phys = addr;
    _ddr_size = size;
    return mapDDR();
}

bool PLInterface::initDMA(uint64_t dma_base_addr, size_t buf_size) {
    if (_mock_mode) return true;

    if (!mapDmaRegs(dma_base_addr)) return false;

    if (!_stream_buf.allocate(buf_size)) {
        _err->setError(ErrorCode::MMAP_FAILED, "DMA buffer alloc failed");
        return false;
    }

    // Reset both channels
    if (!resetDMA()) {
        LOG_ERROR("PLInterface: DMA reset failed during init");
        return false;
    }

    LOG_INFO("PLInterface: DMA initialized");
    return true;
}

void PLInterface::cleanup() {
    if (_ctrl_fd >= 0) { close(_ctrl_fd); _ctrl_fd = -1; }
    _stream_buf.release();
    unmapAll();
    _initialized = false;
}

// UIO Device Discovery
bool PLInterface::findAndOpenUIO(const std::string& device_name) {
    struct dirent** namelist;
    int n = scandir("/sys/class/uio", &namelist, nullptr, alphasort);
    if (n < 0) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND, "Cannot scan /sys/class/uio");
        return false;
    }

    int uio_num = -1;
    for (int i = 0; i < n; i++) {
        if (uio_num < 0) {
            char path[256], name[64] = {0};
            snprintf(path, sizeof(path), "/sys/class/uio/%s/name", namelist[i]->d_name);
            FILE* fp = fopen(path, "r");
            if (fp) {
                if (fgets(name, sizeof(name), fp)) {
                    // Strip trailing newline
                    char* nl = strchr(name, '\n');
                    if (nl) *nl = '\0';
                }
                fclose(fp);
                if (device_name == name) {
                    uio_num = atoi(namelist[i]->d_name + 3);  // skip "uio"
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

    // Read map0 size from sysfs
    char path[256];
    snprintf(path, sizeof(path), "/sys/class/uio/uio%d/maps/map0/size", uio_num);
    FILE* fp = fopen(path, "r");
    if (!fp) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND, "Cannot read UIO map0 size");
        return false;
    }
    unsigned long map_size = 0;
    fscanf(fp, "0x%lx", &map_size);
    fclose(fp);
    _ctrl_size = map_size;

    // Open /dev/uioN
    char dev_path[64];
    snprintf(dev_path, sizeof(dev_path), "/dev/uio%d", uio_num);
    _ctrl_fd = open(dev_path, O_RDWR);
    if (_ctrl_fd < 0) {
        _err->setError(ErrorCode::UIO_OPEN_FAILED,
                       std::string(dev_path) + ": " + strerror(errno));
        return false;
    }

    // mmap map0 (the 'Control' slave interface)
    void* m = mmap(nullptr, _ctrl_size, PROT_READ | PROT_WRITE,
                   MAP_SHARED, _ctrl_fd, 0);
    if (m == MAP_FAILED) {
        _err->setError(ErrorCode::MMAP_FAILED,
                       "UIO mmap: " + std::string(strerror(errno)));
        close(_ctrl_fd);
        _ctrl_fd = -1;
        return false;
    }
    _ctrl_regs = static_cast<volatile uint32_t*>(m);

    LOG_INFO("PLInterface: Found " + device_name + " at " + std::string(dev_path) +
             " (map0 size=0x" + std::to_string(_ctrl_size) + ")");
    return true;
}

bool PLInterface::mapDDR() {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND, "/dev/mem: " + std::string(strerror(errno)));
        return false;
    }
    _ddr_base = mmap(nullptr, _ddr_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, _ddr_phys);
    close(fd);
    if (_ddr_base == MAP_FAILED) {
        _err->setError(ErrorCode::MMAP_FAILED, "DDR: " + std::string(strerror(errno)));
        return false;
    }
    return true;
}


bool PLInterface::mapDmaRegs(uint64_t phys_addr) {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        _err->setError(ErrorCode::DEVICE_NOT_FOUND, "/dev/mem: " + std::string(strerror(errno)));
        return false;
    }
    void* m = mmap(nullptr, DmaReg::DMA_REGS_PAGE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, phys_addr);
    close(fd);
    if (m == MAP_FAILED) {
        _err->setError(ErrorCode::MMAP_FAILED, "DMA regs: " + std::string(strerror(errno)));
        return false;
    }
    _dma_regs = static_cast<volatile uint32_t*>(m);
    return true;
}

void PLInterface::unmapAll() {
    if (_ctrl_regs) { munmap((void*)_ctrl_regs, _ctrl_size); _ctrl_regs = nullptr; }
    if (_ddr_base)  { munmap(_ddr_base, _ddr_size); _ddr_base = nullptr; }
    if (_dma_regs)  { munmap((void*)_dma_regs, DmaReg::DMA_REGS_PAGE); _dma_regs = nullptr; }
}

// Register access
uint32_t PLInterface::readReg(uint32_t offset) {
    if (_mock_mode) return _mock_regs[offset / 4];
    return _ctrl_regs ? _ctrl_regs[offset / 4] : 0;
}

void PLInterface::writeReg(uint32_t offset, uint32_t value) {
    if (_mock_mode) { _mock_regs[offset / 4] = value; return; }
    if (_ctrl_regs) _ctrl_regs[offset / 4] = value;
}

void PLInterface::writeReg64(uint32_t offset_lo, uint64_t value) {
    writeReg(offset_lo, static_cast<uint32_t>(value & 0xFFFFFFFFu));
    writeReg(offset_lo + 4, static_cast<uint32_t>(value >> 32));
}

uint64_t PLInterface::readReg64(uint32_t offset_lo) {
    return (static_cast<uint64_t>(readReg(offset_lo + 4)) << 32) | readReg(offset_lo);
}

void PLInterface::setRegBits(uint32_t offset, uint32_t mask) {
    writeReg(offset, readReg(offset) | mask);
}

void PLInterface::clearRegBits(uint32_t offset, uint32_t mask) {
    writeReg(offset, readReg(offset) & ~mask);
}

bool PLInterface::testRegBits(uint32_t offset, uint32_t mask) {
    return (readReg(offset) & mask) != 0;
}

// Control operations
bool PLInterface::reset() {
    writeReg(PLReg::CONTROL, 0);  // Assert reset
    usleep(1000);
    writeReg(PLReg::CONTROL, PLReg::CTRL_RESETN_BIT);  // Release reset
    
    // irq_clear = !irq_enable_mask: disable IRQs, set clear high
    writeReg(PLReg::IRQ_ENABLE_MASK, 0);
    writeReg(PLReg::IRQ_CLEAR, PLReg::IRQ_ERROR_BIT | PLReg::IRQ_INFER_DONE_BIT);
    usleep(1000);
    return true;
}

void PLInterface::beginConfig() {
    // irq_clear = !irq_enable_mask during config writes
    // Disable interrupts AND set clear high for defense-in-depth
    writeReg(PLReg::IRQ_ENABLE_MASK, 0);                              // Disable IRQs
    writeReg(PLReg::IRQ_CLEAR, PLReg::IRQ_ERROR_BIT | PLReg::IRQ_INFER_DONE_BIT);   // Set clear high
}

void PLInterface::endConfig() {
    // irq_clear = !irq_enable_mask after config
    // Enable interrupts AND clear the clear bit
    writeReg(PLReg::IRQ_CLEAR, 0);                                    // Clear low
    usleep(100);
    writeReg(PLReg::IRQ_ENABLE_MASK, PLReg::IRQ_ERROR_BIT | PLReg::IRQ_INFER_DONE_BIT);  // Enable IRQs
    usleep(100);
    
    if (testRegBits(PLReg::IRQ_STATUS, PLReg::IRQ_ERROR_BIT)) {
        uint32_t code = getErrorCode();
        std::string msg = (code == PLReg::ERR_DMA_ALIGNMENT) ? "DMA alignment" :
                          (code == PLReg::ERR_DMA_ZERO_LEN) ? "DMA/stride zero" : "unknown";
        LOG_ERROR("Config error: " + msg);
        _err->setError(ErrorCode::CONFIG_ERROR, msg);
    }
}

bool PLInterface::start() {
    if (!_initialized || isError()) return false;
    setRegBits(PLReg::CONTROL, PLReg::CTRL_START_BIT);
    return true;
}

bool PLInterface::waitDone(uint32_t timeout_ms) {
    if (_mock_mode) {
        usleep(100000);
        _mock_regs[PLReg::IRQ_STATUS / 4] |= PLReg::IRQ_INFER_DONE_BIT;
        return true;
    }
    
    for (uint32_t t = 0; t < timeout_ms; t += 10) {
        if (testRegBits(PLReg::IRQ_STATUS, PLReg::IRQ_INFER_DONE_BIT)) return true;
        if (testRegBits(PLReg::IRQ_STATUS, PLReg::IRQ_ERROR_BIT)) {
            _err->setError(ErrorCode::HARDWARE_FAULT, "HW error");
            return false;
        }
        usleep(10000);
    }
    _err->setError(ErrorCode::HARDWARE_TIMEOUT, "Timeout");
    return false;
}

bool PLInterface::isBusy() { return testRegBits(PLReg::STATUS, PLReg::STATUS_BUSY_BIT); }
bool PLInterface::isError() { return testRegBits(PLReg::STATUS, PLReg::STATUS_ERROR_BIT); }
uint32_t PLInterface::getErrorCode() { return readReg(PLReg::ERROR_CODE); }
uint32_t PLInterface::getIRQStatus() { return readReg(PLReg::IRQ_STATUS); }

bool PLInterface::clearIRQ() {
    writeReg(PLReg::IRQ_CLEAR, PLReg::IRQ_ERROR_BIT | PLReg::IRQ_INFER_DONE_BIT);
    usleep(10);
    writeReg(PLReg::IRQ_CLEAR, 0);
    return true;
}

// DDR access
bool PLInterface::writeDDR(uint64_t offset, const void* data, size_t size) {
    if (_mock_mode) return true;
    if (!_ddr_base || offset + size > _ddr_size) return false;
    memcpy((uint8_t*)_ddr_base + offset, data, size);
    return true;
}

bool PLInterface::readDDR(uint64_t offset, void* data, size_t size) {
    if (_mock_mode) { memset(data, 0, size); return true; }
    if (!_ddr_base || offset + size > _ddr_size) return false;
    memcpy(data, (uint8_t*)_ddr_base + offset, size);
    return true;
}

void* PLInterface::getDDRPtr(uint64_t offset) {
    return (_mock_mode || !_ddr_base) ? nullptr : (uint8_t*)_ddr_base + offset;
}

// DMA Register Helpers (inline — operate on dma_regs)
uint32_t PLInterface::dmaRead(uint32_t offset) const {
    return _dma_regs ? _dma_regs[offset / 4] : 0;
}

void PLInterface::dmaWrite(uint32_t offset, uint32_t val) {
    if (_dma_regs) _dma_regs[offset / 4] = val;
}

bool PLInterface::dmaResetChannel(uint32_t cr_off, uint32_t sr_off, uint32_t timeout_us) {
    dmaWrite(cr_off, DmaReg::CR_RESET);
    for (uint32_t t = 0; t < timeout_us; t += 100) {
        usleep(100);
        if ((dmaRead(cr_off) & DmaReg::CR_RESET) == 0) return true;
    }
    return false;
}

bool PLInterface::dmaTransfer(uint32_t cr_off, uint32_t sr_off,
                               uint32_t addr_off, uint32_t addr_msb_off,
                               uint32_t len_off,
                               uint64_t phys_addr, uint32_t length) {
    // PG021 programming sequence:
    // 1. Clear & enable interrupts
    dmaWrite(sr_off, DmaReg::SR_ALL_IRQ);
    uint32_t cr = dmaRead(cr_off);
    dmaWrite(cr_off, cr | DmaReg::CR_IOC_EN | DmaReg::CR_ERR_EN);

    // 2. Set address
    dmaWrite(addr_off,     static_cast<uint32_t>(phys_addr & 0xFFFFFFFF));
    dmaWrite(addr_msb_off, static_cast<uint32_t>(phys_addr >> 32));

    // 3. Start channel (RS=1)
    cr = dmaRead(cr_off);
    dmaWrite(cr_off, cr | DmaReg::CR_RS);

    // 4. Set length — triggers transfer
    dmaWrite(len_off, length);
    return true;
}

bool PLInterface::dmaWait(uint32_t sr_off, uint32_t timeout_ms) {
    for (uint32_t t = 0; t < timeout_ms; t++) {
        uint32_t sr = dmaRead(sr_off);
        if (sr & DmaReg::SR_IOC_IRQ) {
            dmaWrite(sr_off, DmaReg::SR_ALL_IRQ);  // clear
            return true;
        }
        if (sr & DmaReg::SR_ALL_ERR) {
            LOG_ERROR("DMA error: " + dmaStatusString());
            dmaWrite(sr_off, DmaReg::SR_ALL_IRQ);
            return false;
        }
        usleep(1000);
    }
    LOG_ERROR("DMA timeout: " + dmaStatusString());
    return false;
}

// DMA Stream API
bool PLInterface::resetDMA() {
    if (!_dma_regs) return false;
    bool ok = dmaResetChannel(DmaReg::MM2S_CR, DmaReg::MM2S_SR);
    ok &= dmaResetChannel(DmaReg::S2MM_CR, DmaReg::S2MM_SR);
    return ok;
}

bool PLInterface::sendStream(const void* data, size_t size, uint32_t timeout_ms) {
    if (_mock_mode) return true;
    if (!_dma_regs || !_stream_buf.isAllocated()) return false;

    memcpy(_stream_buf.virt(), data, size);
    if (!dmaTransfer(DmaReg::MM2S_CR, DmaReg::MM2S_SR,
                     DmaReg::MM2S_SA, DmaReg::MM2S_SA_MSB, DmaReg::MM2S_LEN,
                     _stream_buf.phys(), size)) return false;
    return dmaWait(DmaReg::MM2S_SR, timeout_ms);
}

bool PLInterface::recvStream(void* data, size_t size, uint32_t timeout_ms) {
    if (_mock_mode) { memset(data, 0, size); return true; }
    if (!_dma_regs || !_stream_buf.isAllocated()) return false;

    // Use second half of buffer for receive
    size_t recv_offset = _stream_buf.size() / 2;
    uint64_t dst_phys = _stream_buf.phys() + recv_offset;

    if (!dmaTransfer(DmaReg::S2MM_CR, DmaReg::S2MM_SR,
                     DmaReg::S2MM_DA, DmaReg::S2MM_DA_MSB, DmaReg::S2MM_LEN,
                     dst_phys, size)) return false;
    if (!dmaWait(DmaReg::S2MM_SR, timeout_ms)) return false;

    memcpy(data, static_cast<uint8_t*>(_stream_buf.virt()) + recv_offset, size);
    return true;
}

std::string PLInterface::dmaStatusString() const {
    if (!_dma_regs) return "DMA not initialized";

    uint32_t mm2s_sr = dmaRead(DmaReg::MM2S_SR);
    uint32_t s2mm_sr = dmaRead(DmaReg::S2MM_SR);
    char buf[256];
    snprintf(buf, sizeof(buf),
        "MM2S[SR=0x%08X halt=%d idle=%d err=%d] "
        "S2MM[SR=0x%08X halt=%d idle=%d err=%d]",
        mm2s_sr,
        (mm2s_sr & DmaReg::SR_HALTED) ? 1 : 0,
        (mm2s_sr & DmaReg::SR_IDLE)   ? 1 : 0,
        (mm2s_sr & DmaReg::SR_ALL_ERR) ? 1 : 0,
        s2mm_sr,
        (s2mm_sr & DmaReg::SR_HALTED) ? 1 : 0,
        (s2mm_sr & DmaReg::SR_IDLE)   ? 1 : 0,
        (s2mm_sr & DmaReg::SR_ALL_ERR) ? 1 : 0);
    return std::string(buf);
}

// IRQ
bool PLInterface::waitIRQ(uint32_t timeout_ms) {
    if (_mock_mode) { usleep(100000); return true; }
    struct pollfd pfd = {_ctrl_fd, POLLIN, 0};
    int r = poll(&pfd, 1, timeout_ms);
    if (r <= 0) return false;
    uint32_t info = 1;
    read(_ctrl_fd, &info, sizeof(info));
    return true;
}
