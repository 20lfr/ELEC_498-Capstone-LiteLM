#!/bin/bash

# Download toolchain & sysroot
wget https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--glibc--stable-2022.08-1.tar.bz2
wget https://people.canonical.com/~platform/images/xilinx/kria-ubuntu-22.04/iot-limerick-kria-classic-desktop-2204-classic-22.04-kr10-20240304-165-sysroot.tar.xz

# Extract toolchain & sysroot
mkdir -p ./dependencies
# Fail if directories already exist
mkdir ./dependencies/aarch64--glibc--stable-2022.08-1
mkdir ./dependencies/iot-limerick-kria-classic-desktop-2204-classic-22.04-kr10-20240304-165-sysroot

tar -xvf aarch64--glibc--stable-2022.08-1.tar.bz2 -C ./dependencies/aarch64--glibc--stable-2022.08-1
tar -xvf iot-limerick-kria-classic-desktop-2204-classic-22.04-kr10-20240304-165-sysroot.tar.xz -C ./dependencies/iot-limerick-kria-classic-desktop-2204-classic-22.04-kr10-20240304-165-sysroot

rm aarch64--glibc--stable-2022.08-1.tar.bz2
rm iot-limerick-kria-classic-desktop-2204-classic-22.04-kr10-20240304-165-sysroot.tar.xz

