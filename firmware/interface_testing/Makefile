# Project Configuration
FIRMWARE_DIR = $(CURDIR)/..

BUILD_DIR = build
PACKAGE_DIR = package

# Toolchain Configuration
TOOLCHAIN_PATH ?= $(FIRMWARE_DIR)/dependencies/aarch64--glibc--stable-2022.08-1/aarch64--glibc--stable-2022.08-1/bin
CROSS_COMPILE  ?= $(TOOLCHAIN_PATH)/aarch64-linux-
CXX            = $(CROSS_COMPILE)g++
CC             = $(CROSS_COMPILE)gcc

# Sysroot for cross-compilation linking
SYSROOT        ?= $(FIRMWARE_DIR)/dependencies/iot-limerick-kria-classic-desktop-2204-classic-22.04-kr10-20240304-165-sysroot/sysroots/aarch64-xilinx-linux
UDMABUF_DIR    ?= $(FIRMWARE_DIR)/udmabuf

# Base addresses (From Vivado Address Editor)
DMA_REG_BASE_ADDR  ?= 80000000

# Flags
CXXFLAGS = -std=c++11 -Wall -O2 -g
LDFLAGS  = -lpthread -lrt

ifdef SYSROOT
CFLAGS   += --sysroot=$(SYSROOT)
CXXFLAGS += --sysroot=$(SYSROOT)
LDFLAGS  += --sysroot=$(SYSROOT) \
            -L$(SYSROOT)/usr/lib/aarch64-linux-gnu \
            -Wl,-rpath-link,$(SYSROOT)/usr/lib/aarch64-linux-gnu \
			-B$(SYSROOT)/usr/lib/aarch64-linux-gnu
INCLUDES += -I$(SYSROOT)/usr/include \
            -I$(SYSROOT)/usr/include/aarch64-linux-gnu
endif

# Sources & Includes
DRIVER_DIR     = $(FIRMWARE_DIR)/../hardware_overlay/drivers/axi_top_v1_0/src
INFERENCE_DIR  = $(FIRMWARE_DIR)/inference_engine

INCLUDES = -I$(DRIVER_DIR) \
           -I$(INFERENCE_DIR)/include \
           -I$(SYSROOT)/usr/include \
           -I$(SYSROOT)/usr/include/aarch64-linux-gnu

# Sources
INFERENCE_SRCS = $(INFERENCE_DIR)/src/pl_interface.cpp
AXI_TEST_SRCS = axi_test.cpp
DRIVER_LEGACY_SRC = $(DRIVER_DIR)/xaxi_top.c $(DRIVER_DIR)/xaxi_top_linux.c
AXI_LEGACY_TEST_SRCS = axi_legacy_test.cpp

# Targets
TARGETS = $(BUILD_DIR)/axi_test $(BUILD_DIR)/axi_legacy_test

.PHONY: all clean package help

all: $(TARGETS)

$(BUILD_DIR)/axi_test: $(AXI_TEST_SRCS) $(INFERENCE_SRCS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $^ $(LDFLAGS)

$(BUILD_DIR)/axi_legacy_test: $(AXI_LEGACY_TEST_SRCS) $(DRIVER_LEGACY_SRC)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $^ $(LDFLAGS)

PACKAGE_NAME = interface_testing

define INSTALL_SCRIPT
#!/bin/bash
set -e

DMA_ADDR="$(DMA_REG_BASE_ADDR)"

setup() {
    echo "=== Setting up DMA testing environment ==="
    
    # Build and load udmabuf
    echo "[1/2] Building udmabuf kernel module..."
    cd udmabuf && make -s clean all && cd ..
    
    echo "[2/2] Loading udmabuf (1MB buffer)..."
    sudo rmmod u-dma-buf 2>/dev/null || true
    sudo insmod udmabuf/u-dma-buf.ko udmabuf0=1048576
    
    # Unbind DMA from kernel driver if bound
    if [ -e "/sys/bus/platform/drivers/xilinx-vdma/$${DMA_ADDR}.dma" ]; then
        echo "       Unbinding DMA from xilinx-vdma driver..."
        echo "$${DMA_ADDR}.dma" | sudo tee /sys/bus/platform/drivers/xilinx-vdma/unbind >/dev/null
    fi
    
    echo ""
    echo "=== Setup complete! ==="
    echo "Run: ./run.sh test		- AXI test"
}

case "$${1:-setup}" in
    setup) setup ;;
    test)  sudo ./bin/axi_test ;;
    *)     echo "Usage: ./run.sh [setup|test]" ;;
esac
endef
export INSTALL_SCRIPT

package: all
	@echo "Creating deployment package..."
	@mkdir -p $(PACKAGE_DIR)
	@rm -rf $(PACKAGE_DIR)/$(PACKAGE_NAME) $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz
	@mkdir -p $(PACKAGE_DIR)/$(PACKAGE_NAME)/bin
	@mkdir -p $(PACKAGE_DIR)/$(PACKAGE_NAME)/udmabuf
	
	@# Copy compiled binaries
	@cp $(TARGETS) $(PACKAGE_DIR)/$(PACKAGE_NAME)/bin/
	
	@# Copy udmabuf source (for on-target compilation)
	@cp -r ${UDMABUF_DIR}/* $(PACKAGE_DIR)/$(PACKAGE_NAME)/udmabuf/
	
	@# Create run script
	@echo "$$INSTALL_SCRIPT" > $(PACKAGE_DIR)/$(PACKAGE_NAME)/run.sh
	@chmod +x $(PACKAGE_DIR)/$(PACKAGE_NAME)/run.sh
	
	@tar -czvf $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz -C $(PACKAGE_DIR) $(PACKAGE_NAME)
	@rm -rf $(PACKAGE_DIR)/$(PACKAGE_NAME)
	@echo "Package created: $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz"

clean:
	rm -rf $(BUILD_DIR) $(PACKAGE_DIR)

help:
	@echo "Targets:"
	@echo "  all       : Build userspace tests (cross-compiled)"
	@echo "  package   : Create tarball with binaries + udmabuf source"
	@echo "  clean     : Clean artifacts"
