/**
 * @file dma_buffer.hpp
 * @brief Contiguous DMA buffer allocation using u-dma-buf kernel module
 *
 * Requires: u-dma-buf kernel module loaded (insmod u-dma-buf.ko udmabuf0=SIZE)
 */

#ifndef DMA_BUFFER_HPP
#define DMA_BUFFER_HPP

#include "u-dma-buf-ioctl.h"
#include <cstdio>
#include <fcntl.h>
#include <stdint.h>
#include <string>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

class DmaBuffer {
private:
    size_t _size;
    int _fd;
    bool _mock;
    void *_virt;
    uint64_t _phys;

public:
    DmaBuffer() : _size(0), _fd(-1), _mock(false), _virt(nullptr), _phys(0) {}

    bool allocate(const std::string &device_name, size_t size,
                  bool mock = false) {
        _mock = mock;
        _size = size;

        if (mock) {
            _virt = malloc(size);
            _phys = 0x10000000; // Fake physical address for mock
            return _virt != nullptr;
        }
        if (device_name.empty()) {
            perror("DmaBuffer: device_name is empty");
            return false;
        }

        // 1. Read physical address from sysfs
        std::string sysfs_path =
            "/sys/class/u-dma-buf/" + device_name + "/phys_addr";
        FILE *fp = fopen(sysfs_path.c_str(), "r");
        if (!fp) {
            perror(("DmaBuffer: cannot open " + sysfs_path +
                    " (is module loaded?)")
                       .c_str());
            return false;
        }
        char hex_str[32];
        if (fgets(hex_str, sizeof(hex_str), fp)) {
            _phys = strtoull(hex_str, nullptr, 16);
        }
        fclose(fp);

        // 2. Open device file
        std::string dev_path = "/dev/" + device_name;
        _fd = open(dev_path.c_str(), O_RDWR);
        if (_fd < 0) {
            perror(("DmaBuffer: cannot open " + dev_path).c_str());
            return false;
        }

        // 3. mmap to userspace
        _virt = mmap(nullptr, size, PROT_READ | PROT_WRITE, MAP_SHARED, _fd, 0);
        if (_virt == MAP_FAILED) {
            perror("DmaBuffer: mmap failed");
            _virt = nullptr;
            close(_fd);
            _fd = -1;
            return false;
        }

        return true;
    }

    void release() {
        if (_virt) {
            if (_mock) {
                free(_virt);
            } else {
                munmap(_virt, _size);
                if (_fd >= 0) {
                    close(_fd);
                    _fd = -1;
                }
            }
            _virt = nullptr;
        }
    }

    size_t size() const { return _size; }
    bool isAllocated() const { return _virt != nullptr; }
    void *virt() const { return _virt; }
    uint64_t phys() const { return _phys; }
    void sync_for_device(uint64_t offset = 0, uint64_t size = 0) {
        if (_mock || _fd < 0)
            return;
        u_dma_buf_ioctl_sync_args args = {};
        args.size = (size == 0) ? _size : size;
        args.offset = offset;
        SET_U_DMA_BUF_IOCTL_FLAGS_SYNC_CMD(
            &args, U_DMA_BUF_IOCTL_FLAGS_SYNC_CMD_FOR_DEVICE);
        SET_U_DMA_BUF_IOCTL_FLAGS_SYNC_DIR(&args, 3); // bidirectional
        if (ioctl(_fd, U_DMA_BUF_IOCTL_SET_SYNC, &args) < 0)
            perror("DmaBuffer: sync_for_device failed");
    }

    void sync_for_cpu(uint64_t offset = 0, uint64_t size = 0) {
        if (_mock || _fd < 0)
            return;
        u_dma_buf_ioctl_sync_args args = {};
        args.size = (size == 0) ? _size : size;
        args.offset = offset;
        SET_U_DMA_BUF_IOCTL_FLAGS_SYNC_CMD(
            &args, U_DMA_BUF_IOCTL_FLAGS_SYNC_CMD_FOR_CPU);
        SET_U_DMA_BUF_IOCTL_FLAGS_SYNC_DIR(&args, 3); // bidirectional
        if (ioctl(_fd, U_DMA_BUF_IOCTL_SET_SYNC, &args) < 0)
            perror("DmaBuffer: sync_for_cpu failed");
    }

    ~DmaBuffer() { release(); }

    DmaBuffer(const DmaBuffer &) = delete;
    DmaBuffer &operator=(const DmaBuffer &) = delete;
};

#endif // DMA_BUFFER_HPP
