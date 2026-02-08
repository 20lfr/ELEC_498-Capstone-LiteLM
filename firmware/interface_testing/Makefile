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

INCLUDES = -I$(DRIVER_DIR) \
           -I$(SYSROOT)/usr/include \
           -I$(SYSROOT)/usr/include/aarch64-linux-gnu

# Sources
DRIVER_SRCS  = $(DRIVER_DIR)/xaxi_top.c $(DRIVER_DIR)/xaxi_top_linux.c
MAIN_SRC     = main.cpp

# Targets
TARGETS = $(BUILD_DIR)/axi_testing

.PHONY: all clean package help

all: $(TARGETS)

$(BUILD_DIR)/axi_testing: $(MAIN_SRC) $(DRIVER_SRCS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $^ $(LDFLAGS)

PACKAGE_NAME = interface_testing

define INSTALL_SCRIPT
#!/bin/bash
set -e
echo "Building the kernel module"
cd ${PACKAGE_NAME}/udmabuf && make clean all
echo "Installing the kernel module"
echo "cd ${PACKAGE_NAME}/udmabuf"
echo "sudo insmod u-dma-buf.ko udmabuf0=1048576"
echo "To run:"
echo "sudo ./${PACKAGE_NAME}/bin/axi_testing"
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
	
	@# Create install script
	@echo "$$INSTALL_SCRIPT" > $(PACKAGE_DIR)/$(PACKAGE_NAME)/install.sh
	@chmod +x $(PACKAGE_DIR)/$(PACKAGE_NAME)/install.sh
	
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
