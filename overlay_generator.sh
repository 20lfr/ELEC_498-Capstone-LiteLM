#!/bin/bash

# Kria KV260 Overlay Generator & Loader Builder
# Automated script to generate .dtbo, .bin, shell.json, and a custom load script

# Project & tool paths
ROOT_DIR="$(pwd)"
XILINX_SETTINGS="/media/tristan/external-drive/tools/Xilinx/2025.1/Vitis/settings64.sh"
TARGET_DIR="$ROOT_DIR/hardware_overlay"
DTG_BRANCH="xlnx_rel_v2025.1"
VIVADO_DIR="$ROOT_DIR/vivado_simulations/AxiTop"
HW_WRAPPER="axi_top_bd_01_wrapper"

XSA_FILE="$VIVADO_DIR/$HW_WRAPPER.xsa"

# RTL CONFIGURATION
APP_NAME="axi_top_0"
COMPAT_ID="xlnx,axi-top-1.0" # Found in dtsi file
# Replace this with your actual DMA register base address
DMA_REG_BASE_ADDR="a0000000"

set -e # Exit immediately if a command exits with a non-zero status

echo ">>> Sourcing Xilinx Environment..."
if [ -f "$XILINX_SETTINGS" ]; then
    source "$XILINX_SETTINGS"
else
    echo "ERROR: Xilinx settings not found at $XILINX_SETTINGS"
    exit 1
fi

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

echo ">>> Step 1: Preparing Device Tree Repository..."
if [ ! -d "device-tree-xlnx" ]; then
    git clone https://github.com/Xilinx/device-tree-xlnx.git
    cd device-tree-xlnx
    git checkout $DTG_BRANCH
    cd ..
else
    echo "    Repo already exists, skipping clone."
fi

echo ">>> Step 2: Generating Device Tree Source (DTSI) via XSCT..."

# Copy XSA locally so HSI extracts artifacts here, not in the original location
LOCAL_XSA="$TARGET_DIR/$(basename "$XSA_FILE")"
cp "$XSA_FILE" "$LOCAL_XSA"

cat <<EOT >generate_dts.tcl
setws .
hsi open_hw_design "$LOCAL_XSA"
hsi set_repo_path ./device-tree-xlnx
hsi create_sw_design device-tree -os device_tree -proc psu_cortexa53_0
hsi set_property CONFIG.dt_overlay true [hsi::get_os]
hsi set_property CONFIG.dt_zocl true [hsi::get_os]
hsi generate_target -dir ./dts_output
hsi close_hw_design [hsi current_hw_design]
exit
EOT

xsct generate_dts.tcl

if [ ! -f "$HW_WRAPPER.bit" ]; then
    echo "ERROR: No .bit file found inside the XSA!"
    exit 1
fi

echo ">>> Step 4: Compiling DTBO and Extracting Compatible ID..."
DTS_FILE="./dts_output/pl.dtsi"
INCLUDE_PATH="./device-tree-xlnx/include"

if [ ! -f "$DTS_FILE" ]; then
    echo "ERROR: XSCT failed to generate pl.dtsi"
    exit 1
fi

# 4b. Pre-process and compile
gcc -E -nostdinc -undef -D__DTS__ -x assembler-with-cpp -I "$INCLUDE_PATH" "$DTS_FILE" -o pl.preprocessed.dtsi

echo ">>> Patching missing commas in interrupts arrays..."
sed -i 's/<0 105 4 0 106 4>/<0 105 4>, <0 106 4>/g' pl.preprocessed.dtsi

dtc -@ -O dtb -o pl.dtbo pl.preprocessed.dtsi

echo ">>> Step 5: Converting Bitstream to Bin..."
echo "all: { [destination_device = pl] $HW_WRAPPER.bit }" >bitstream.bif
bootgen -image bitstream.bif -arch zynqmp -o "$APP_NAME.bit.bin" -w

echo ">>> Step 6: Creating shell.json..."
cat <<EOT >shell.json
{
    "shell_type": "XRT_FLAT",
    "num_slots": "1",
    "dtbo": "pl.dtbo",
    "bitstream": "$APP_NAME.bit.bin"
}
EOT

echo ">>> Step 7: Packaging Output..."

# cleanup outputs and specify output dir
OUTPUT_DIR="$TARGET_DIR/output"
rm -rf $OUTPUT_DIR
mkdir $OUTPUT_DIR
mkdir $OUTPUT_DIR/$APP_NAME

mv pl.dtbo "$APP_NAME.bit.bin" shell.json "$OUTPUT_DIR/$APP_NAME"

echo ">>> Step 8: Generating custom load_hw.sh..."
LOAD_SCRIPT="$OUTPUT_DIR/load_hw.sh"

cat <<EOF >"$LOAD_SCRIPT"
#!/bin/bash
# Auto-generated loader for $APP_NAME

APP_NAME="$APP_NAME"
COMPAT_ID="$COMPAT_ID"
DMA_ADDR="$DMA_REG_BASE_ADDR"
TARGET_DIR=/lib/firmware/xilinx

sudo rm -r /\$TARGET_DIR/\$APP_NAME
sudo cp -r ./\$APP_NAME /\$TARGET_DIR

echo ">>> Unloading current firmware..."
sudo xmutil unloadapp > /dev/null 2>&1

echo ">>> Registering UIO driver for ID: \$COMPAT_ID..."
sudo modprobe -r uio_pdrv_genirq
sudo modprobe uio_pdrv_genirq of_id="\$COMPAT_ID"

echo ">>> Loading app: \$APP_NAME..."
sudo xmutil loadapp \$APP_NAME
if [ \$? -ne 0 ]; then
    echo "Error: Failed to load app \$APP_NAME."
    exit 1
fi

if [ -e "/sys/bus/platform/drivers/xilinx-vdma/\${DMA_ADDR}.dma" ]; then
    echo ">>> Unbinding DMA from xilinx-vdma driver..."
    echo "\${DMA_ADDR}.dma" | sudo tee /sys/bus/platform/drivers/xilinx-vdma/unbind >/dev/null
    echo "Unbind successful."
else
    echo "DMA driver is already unbound or not attached to xilinx-vdma."
fi

echo ">>> checking /sys/class/uio for device name..."
sleep 1
echo "--------------------------------------------------"
echo "Available UIO Devices:"
cat /sys/class/uio/uio*/name
echo "--------------------------------------------------"
EOF

chmod +x "$LOAD_SCRIPT"

echo ">>> Step 9: Deploy to Kria..."
echo "1. scp -r $OUTPUT_DIR/* ubuntu@<KRIA_IP>:~/"
echo "2. SSH into Board:  ssh ubuntu@<KRIA_IP>"
echo "3. Load Hardware:   sudo ./load_hw.sh"
