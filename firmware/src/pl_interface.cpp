// pl_interface.cpp - Corrected implementation
#include "pl_interface.hpp"
#include "logger.hpp"
#include "error_handler.hpp"
#include <iostream>

PLInterface::PLInterface(Logger* log, ErrorHandler* error)
    : uio_fd(-1), stream_in_fd(-1), stream_out_fd(-1), ctrl_regs(nullptr),
      ddr_base(nullptr), ctrl_phys(0), ctrl_size(0), ddr_phys(0), ddr_size(0),
      initialized(false), mock_mode(false), logger(log), err(error) {
    memset(mock_regs, 0, sizeof(mock_regs));
}

PLInterface::~PLInterface() { cleanup(); }

bool PLInterface::init(const std::string& uio, uint64_t addr, size_t size, bool mock) {
    mock_mode = mock;
    uio_dev = uio;
    ctrl_phys = addr;
    ctrl_size = size;
    
    if (mock_mode) {
        LOG_INFO("PLInterface: Mock mode");
        mock_regs[PLReg::CONTROL / 4] = CTRL_RESETN_BIT;
        mock_regs[PLReg::STATUS / 4] = STATUS_IDLE_BIT;
        initialized = true;
        return true;
    }
    
    if (!openUIO(uio) || !mapCtrlRegs()) return false;
    if (!reset()) return false;
    
    initialized = true;
    LOG_INFO("PLInterface: Initialized");
    return true;
}

bool PLInterface::initDDR(uint64_t addr, size_t size) {
    if (mock_mode) return true;
    ddr_phys = addr;
    ddr_size = size;
    return mapDDR();
}

bool PLInterface::initAXIStream(const std::string& in_dev, const std::string& out_dev) {
    if (mock_mode) return true;
    
    stream_in_fd = open(in_dev.c_str(), O_WRONLY);
    if (stream_in_fd < 0) {
        err->setError(ErrorCode::DEVICE_NOT_FOUND, "AXI stream in: " + std::string(strerror(errno)));
        return false;
    }
    
    stream_out_fd = open(out_dev.c_str(), O_RDONLY | O_NONBLOCK);
    if (stream_out_fd < 0) {
        err->setError(ErrorCode::DEVICE_NOT_FOUND, "AXI stream out: " + std::string(strerror(errno)));
        return false;
    }
    return true;
}

void PLInterface::cleanup() {
    if (uio_fd >= 0) { close(uio_fd); uio_fd = -1; }
    if (stream_in_fd >= 0) { close(stream_in_fd); stream_in_fd = -1; }
    if (stream_out_fd >= 0) { close(stream_out_fd); stream_out_fd = -1; }
    unmapAll();
    initialized = false;
}

bool PLInterface::openUIO(const std::string& dev) {
    uio_fd = open(dev.c_str(), O_RDWR | O_SYNC);
    if (uio_fd < 0) {
        err->setError(ErrorCode::UIO_OPEN_FAILED, dev + ": " + strerror(errno));
        return false;
    }
    return true;
}

bool PLInterface::mapCtrlRegs() {
    void* m = mmap(nullptr, ctrl_size, PROT_READ | PROT_WRITE, MAP_SHARED, uio_fd, 0);
    if (m == MAP_FAILED) {
        err->setError(ErrorCode::MMAP_FAILED, "ctrl regs: " + std::string(strerror(errno)));
        return false;
    }
    ctrl_regs = static_cast<volatile uint32_t*>(m);
    return true;
}

bool PLInterface::mapDDR() {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        err->setError(ErrorCode::DEVICE_NOT_FOUND, "/dev/mem: " + std::string(strerror(errno)));
        return false;
    }
    ddr_base = mmap(nullptr, ddr_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, ddr_phys);
    close(fd);
    if (ddr_base == MAP_FAILED) {
        err->setError(ErrorCode::MMAP_FAILED, "DDR: " + std::string(strerror(errno)));
        return false;
    }
    return true;
}

void PLInterface::unmapAll() {
    if (ctrl_regs) { munmap((void*)ctrl_regs, ctrl_size); ctrl_regs = nullptr; }
    if (ddr_base) { munmap(ddr_base, ddr_size); ddr_base = nullptr; }
}

// Register access
uint32_t PLInterface::readReg(uint32_t offset) {
    if (mock_mode) return mock_regs[offset / 4];
    return ctrl_regs ? ctrl_regs[offset / 4] : 0;
}

void PLInterface::writeReg(uint32_t offset, uint32_t value) {
    if (mock_mode) { mock_regs[offset / 4] = value; return; }
    if (ctrl_regs) ctrl_regs[offset / 4] = value;
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
    writeReg(PLReg::CONTROL, CTRL_RESETN_BIT);  // Release reset
    
    // irq_clear = !irq_enable_mask: disable IRQs, set clear high
    writeReg(PLReg::IRQ_ENABLE_MASK, 0);
    writeReg(PLReg::IRQ_CLEAR, IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT);
    usleep(1000);
    return true;
}

void PLInterface::beginConfig() {
    // irq_clear = !irq_enable_mask during config writes
    // Disable interrupts AND set clear high for defense-in-depth
    writeReg(PLReg::IRQ_ENABLE_MASK, 0);                              // Disable IRQs
    writeReg(PLReg::IRQ_CLEAR, IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT);   // Set clear high
}

void PLInterface::endConfig() {
    // irq_clear = !irq_enable_mask after config
    // Enable interrupts AND clear the clear bit
    writeReg(PLReg::IRQ_CLEAR, 0);                                    // Clear low
    usleep(100);
    writeReg(PLReg::IRQ_ENABLE_MASK, IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT);  // Enable IRQs
    usleep(100);
    
    if (testRegBits(PLReg::IRQ_STATUS, IRQ_ERROR_BIT)) {
        uint32_t code = getErrorCode();
        std::string msg = (code == ERR_DMA_ALIGNMENT) ? "DMA alignment" :
                          (code == ERR_DMA_ZERO_LEN) ? "DMA/stride zero" : "unknown";
        LOG_ERROR("Config error: " + msg);
        err->setError(ErrorCode::CONFIG_ERROR, msg);
    }
}

bool PLInterface::start() {
    if (!initialized || isError()) return false;
    setRegBits(PLReg::CONTROL, CTRL_START_BIT);
    return true;
}

bool PLInterface::waitDone(uint32_t timeout_ms) {
    if (mock_mode) {
        usleep(100000);
        mock_regs[PLReg::IRQ_STATUS / 4] |= IRQ_INFER_DONE_BIT;
        return true;
    }
    
    for (uint32_t t = 0; t < timeout_ms; t += 10) {
        if (testRegBits(PLReg::IRQ_STATUS, IRQ_INFER_DONE_BIT)) return true;
        if (testRegBits(PLReg::IRQ_STATUS, IRQ_ERROR_BIT)) {
            err->setError(ErrorCode::HARDWARE_FAULT, "HW error");
            return false;
        }
        usleep(10000);
    }
    err->setError(ErrorCode::HARDWARE_TIMEOUT, "Timeout");
    return false;
}

bool PLInterface::isBusy() { return testRegBits(PLReg::STATUS, STATUS_BUSY_BIT); }
bool PLInterface::isError() { return testRegBits(PLReg::STATUS, STATUS_ERROR_BIT); }
uint32_t PLInterface::getErrorCode() { return readReg(PLReg::ERROR_CODE); }
uint32_t PLInterface::getIRQStatus() { return readReg(PLReg::IRQ_STATUS); }

bool PLInterface::clearIRQ() {
    writeReg(PLReg::IRQ_CLEAR, IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT);
    usleep(10);
    writeReg(PLReg::IRQ_CLEAR, 0);
    return true;
}

// DDR access
bool PLInterface::writeDDR(uint64_t offset, const void* data, size_t size) {
    if (mock_mode) return true;
    if (!ddr_base || offset + size > ddr_size) return false;
    memcpy((uint8_t*)ddr_base + offset, data, size);
    return true;
}

bool PLInterface::readDDR(uint64_t offset, void* data, size_t size) {
    if (mock_mode) { memset(data, 0, size); return true; }
    if (!ddr_base || offset + size > ddr_size) return false;
    memcpy(data, (uint8_t*)ddr_base + offset, size);
    return true;
}

void* PLInterface::getDDRPtr(uint64_t offset) {
    return (mock_mode || !ddr_base) ? nullptr : (uint8_t*)ddr_base + offset;
}

// Stream access
ssize_t PLInterface::writeStream(const void* data, size_t size) {
    if (mock_mode) return size;
    return (stream_in_fd >= 0) ? write(stream_in_fd, data, size) : -1;
}

ssize_t PLInterface::readStream(void* data, size_t size) {
    if (mock_mode) { memset(data, 0, size); return size; }
    if (stream_out_fd < 0) return -1;
    ssize_t n = read(stream_out_fd, data, size);
    return (n < 0 && errno == EAGAIN) ? 0 : n;
}

bool PLInterface::drainStream() {
    if (mock_mode) return true;
    uint8_t buf[1024];
    while (read(stream_out_fd, buf, sizeof(buf)) > 0);
    return true;
}

bool PLInterface::waitIRQ(uint32_t timeout_ms) {
    if (mock_mode) { usleep(100000); return true; }
    struct pollfd pfd = {uio_fd, POLLIN, 0};
    int r = poll(&pfd, 1, timeout_ms);
    if (r <= 0) return false;
    uint32_t info = 1;
    read(uio_fd, &info, sizeof(info));
    return true;
}
