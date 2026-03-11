# Project Configuration
FIRMWARE_DIR = $(CURDIR)

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
LINUX_BOOT_DIR ?= $(FIRMWARE_DIR)/linux_boot_files

# Flags
CXXFLAGS = -std=c++11 -Wall -O2
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
DRIVER_DIR     = $(FIRMWARE_DIR)/../hardware_overlay/drivers/transformer_top_v1_0/src
UDMABUF_DIR    = $(FIRMWARE_DIR)/udmabuf
HLS_DIR        = $(FIRMWARE_DIR)/../HLS-Verilog
TESTING_DIR = $(FIRMWARE_DIR)/interface_testing
INFERENCE_DIR = $(FIRMWARE_DIR)/inference_engine

INCLUDES = -I$(DRIVER_DIR) \
           -I$(UDMABUF_DIR) \
           -I$(HLS_DIR) \
           -I$(INFERENCE_DIR)/include \
           -I$(SYSROOT)/usr/include \
           -I$(SYSROOT)/usr/include/aarch64-linux-gnu

# Sources
INTERFACE_SRC = $(INFERENCE_DIR)/src/pl_interface.cpp 
INFERENCE_SRCS = $(INTERFACE_SRC) $(INFERENCE_DIR)/src/inference_engine.cpp

# Targets
TARGETS = $(BUILD_DIR)/inference_engine

.PHONY: all clean package help

all: $(TARGETS)

$(BUILD_DIR)/inference_engine: $(INFERENCE_SRCS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $^ $(LDFLAGS)

PACKAGE_NAME = firmware

define INSTALL_KMODULE
#!/bin/bash
set -e

echo "=== Setting up DMA Buffer (u-dma-buf) ==="

echo "[1/4] Building udmabuf kernel module..."
cd udmabuf && make -s clean all && cd ..

echo "[2/4] Installing kernel module..."
# Using cp instead of mv so you keep a local copy if needed
sudo cp udmabuf/u-dma-buf.ko /lib/modules/$$(uname -r)/kernel/drivers/

echo "[3/4] Configuring safe auto-load on boot..."
# Safely create a dedicated config file instead of modifying /etc/modules
echo "u-dma-buf" | sudo tee /etc/modules-load.d/u-dma-buf.conf > /dev/null

echo "Updating module dependencies (Please wait, this might take a minute)..."
sudo depmod -a

echo "[4/4] Configuring journald volatile storage (prevents CMA fragmentation)..."
sudo mkdir -p /etc/systemd/journald.conf.d/
echo -e "[Journal]\nStorage=volatile" | sudo tee /etc/systemd/journald.conf.d/volatile.conf > /dev/null
sudo systemctl restart systemd-journald

echo "[boot] Building boot files..."
dtc -I dts -O dtb -o linux_boot_files/user-override.dtb linux_boot_files/system.dts
mkimage -c none -A arm -T script -d linux_boot_files/boot.cmd linux_boot_files/boot.scr.uimg

echo "[boot] Installing device tree overlay..."
sudo cp linux_boot_files/user-override.dtb /boot/firmware/user-override.dtb
sudo cp linux_boot_files/boot.scr.uimg /boot/firmware/boot.scr.uimg

echo ""
echo "=== Buffer Setup Complete! ==="
echo "Please REBOOT your board now to finalize the memory configuration."
endef
export INSTALL_KMODULE

package: all
	@echo "Creating deployment package..."
	@mkdir -p $(PACKAGE_DIR)
	@rm -rf $(PACKAGE_DIR)/$(PACKAGE_NAME) $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz
	@mkdir -p $(PACKAGE_DIR)/$(PACKAGE_NAME)/bin
	@mkdir -p $(PACKAGE_DIR)/$(PACKAGE_NAME)/udmabuf
	@mkdir -p $(PACKAGE_DIR)/$(PACKAGE_NAME)/linux_boot_files
	
	@# Copy compiled binaries
	@cp $(TARGETS) $(PACKAGE_DIR)/$(PACKAGE_NAME)/bin/
	
	@# Copy udmabuf source (for on-target compilation)
	@cp -r ${UDMABUF_DIR}/* $(PACKAGE_DIR)/$(PACKAGE_NAME)/udmabuf/

	@# Copy boot file sources (built on target)
	@cp $(LINUX_BOOT_DIR)/system.dts $(PACKAGE_DIR)/$(PACKAGE_NAME)/linux_boot_files/
	@cp $(LINUX_BOOT_DIR)/boot.cmd $(PACKAGE_DIR)/$(PACKAGE_NAME)/linux_boot_files/
	
	@# Create run script
	@echo "$$INSTALL_KMODULE" > $(PACKAGE_DIR)/$(PACKAGE_NAME)/setup_kria_boot.sh
	@chmod +x $(PACKAGE_DIR)/$(PACKAGE_NAME)/setup_kria_boot.sh
	
	@tar -czvf $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz -C $(PACKAGE_DIR) $(PACKAGE_NAME)
	@rm -rf $(PACKAGE_DIR)/$(PACKAGE_NAME)
	@echo "Package created: $(PACKAGE_DIR)/$(PACKAGE_NAME).tar.gz"

clean:
	rm -rf $(BUILD_DIR) $(PACKAGE_DIR)

help:
	@echo "Targets:"
	@echo "  all      : Build userspace tests (cross-compiled)"
	@echo "  package  : Create tarball with binaries + udmabuf source + boot file sources"
	@echo "  clean    : Clean artifacts"
