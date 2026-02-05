#!/bin/bash

# ==============================================================================
# Kria KV260 Overlay Generator & Loader Builder
# Automated script to generate .dtbo, .bin, shell.json, and a custom load script
# ==============================================================================

# --- USER CONFIGURATION (EDIT THESE) ---
# 1. Path to your Xilinx settings (Check your version)
XILINX_SETTINGS="/media/tristan/external-drive/tools/Xilinx/2025.1/Vitis/settings64.sh"

# 2. Your Input XSA File
INPUT_XSA="/home/tristan/development/edge_gpt/ELEC_498-Capstone-LiteLM/vivado_simulations/ControlMemInterface/ControlMemInterface/test_design_1_wrapper.xsa"

# 3. Output Directory
OUTPUT_DIR="./kria_output"

# 4. Your App Name (for folder naming on the board)
APP_NAME="ControlMemInterface"

# 5. Target Branch for Device Tree (Must match your Vivado version roughly)
DTG_BRANCH="xlnx_rel_v2025.1"
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status

echo ">>> Sourcing Xilinx Environment..."
if [ -f "$XILINX_SETTINGS" ]; then
  source "$XILINX_SETTINGS"
else
  echo "ERROR: Xilinx settings not found at $XILINX_SETTINGS"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo ">>> Step 1: Preparing Device Tree Repository..."
if [ ! -d "device-tree-xlnx" ]; then
  git clone https://github.com/Xilinx/device-tree-xlnx.git
  cd device-tree-xlnx
  git checkout $DTG_BRANCH
  cd ..
else
  echo "    Repo already exists, skipping clone."
fi

echo ">>> Step 2: Extracting Bitstream from XSA..."
unzip -o -j "$INPUT_XSA" "*.bit" -d .
BIT_FILE=$(find . -maxdepth 1 -name "*.bit" | head -n 1)
if [ -z "$BIT_FILE" ]; then
  echo "ERROR: No .bit file found inside the XSA!"
  exit 1
fi
echo "    Found bitstream: $BIT_FILE"

echo ">>> Step 3: Generating Device Tree Source (DTSI) via XSCT..."
cat <<EOT >generate_dts.tcl
hsi open_hw_design "$INPUT_XSA"
hsi set_repo_path ./device-tree-xlnx
hsi create_sw_design device-tree -os device_tree -proc psu_cortexa53_0
hsi set_property CONFIG.dt_overlay true [hsi::get_os]
hsi set_property CONFIG.dt_zocl true [hsi::get_os]
hsi generate_target -dir ./dts_output
hsi close_hw_design [hsi current_hw_design]
exit
EOT

xsct generate_dts.tcl

echo ">>> Step 4: Compiling DTBO and Extracting Compatible ID..."
DTS_FILE="./dts_output/pl.dtsi"
INCLUDE_PATH="./device-tree-xlnx/include"

if [ ! -f "$DTS_FILE" ]; then
  echo "ERROR: XSCT failed to generate pl.dtsi"
  exit 1
fi

# 4a. Extract the 'compatible' string
# We use 'grep -v' to ignore lines
COMPAT_ID=$(grep "compatible" "$DTS_FILE" | grep -v "xlnx,fclk" | grep -v "xlnx,afi-fpga" | grep -v "xlnx,zocl" | head -n 1 | cut -d '"' -f 2)
echo "    Found Hardware ID: $COMPAT_ID"

# 4b. Pre-process and compile
gcc -E -nostdinc -undef -D__DTS__ -x assembler-with-cpp -I "$INCLUDE_PATH" "$DTS_FILE" -o pl.preprocessed.dtsi
dtc -@ -O dtb -o pl.dtbo pl.preprocessed.dtsi

echo ">>> Step 5: Converting Bitstream to Bin..."
echo "all: { [destination_device = pl] $BIT_FILE }" >bitstream.bif
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
# Create the specific output folder structure you requested
TARGET_DIR="outputs/$APP_NAME"
mkdir -p "$TARGET_DIR"

mv pl.dtbo "$APP_NAME.bit.bin" shell.json "$TARGET_DIR/"

echo ">>> Step 8: Generating custom load_hw.sh..."
LOAD_SCRIPT="outputs/load_hw.sh"

cat <<EOF >"$LOAD_SCRIPT"
#!/bin/bash
# Auto-generated loader for $APP_NAME

APP_NAME="$APP_NAME"
COMPAT_ID="$COMPAT_ID"

# 1. Unload any existing app
echo ">>> Unloading current firmware..."
sudo xmutil unloadapp > /dev/null 2>&1

# 2. Load this app
echo ">>> Loading app: \$APP_NAME..."
sudo xmutil loadapp \$APP_NAME
if [ \$? -ne 0 ]; then
    echo "Error: Failed to load app \$APP_NAME."
    exit 1
fi

# 3. Register Driver
echo ">>> Registering UIO driver for ID: \$COMPAT_ID..."
sudo modprobe -r uio_pdrv_genirq
sudo modprobe uio_pdrv_genirq of_id="\$COMPAT_ID"

# 4. Find and print the UIO Instance Name
echo ">>> checking /sys/class/uio for device name..."
# We sleep briefly to let the kernel settle
sleep 1
# Find the UIO device that matches the compatible name (often partially matched in name file)
# OR simply list all to help the user.
echo "--------------------------------------------------"
echo "Available UIO Devices:"
cat /sys/class/uio/uio*/name
echo "--------------------------------------------------"
echo "Success! Your hardware is ready."
EOF

chmod +x "$LOAD_SCRIPT"

echo "============================================================"
echo "SUCCESS! Build complete."
echo "Output located in: $OUTPUT_DIR/outputs/"
echo "1. Copy to Kria: scp -r $OUTPUT_DIR/outputs/* ubuntu@<kria-ip>:~/"
echo "2. Move App:     sudo mv ~/$APP_NAME /lib/firmware/xilinx/"
echo "3. Run Loader:   ./load_hw.sh"
echo "============================================================"
