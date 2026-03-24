#!/bin/bash
# Description:
#   Run the full Vitis HLS flow (C simulation, synthesis, packaging) for the
#   selected MODEL_ARCH, then patch the generated component.xml.
# Usage:
#   MODEL_ARCH=<arch-name> ./Vitis_Run_All_Commands.sh
#   (defaults to MODEL_ARCH=phi3-mini-int4-HARDWARE)
# Requirements:
#   - v++ / vitis-run on PATH (after sourcing Xilinx settings)
#   - modify_xml.sh in the same directory

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

MODEL_ARCH="${MODEL_ARCH:-phi3-mini-int4-HARDWARE}"
WORK_DIR="$REPO_ROOT/Model-architectures/$MODEL_ARCH/vitis_simulations/Top_module_Non_Debug_Multiple_Token"
CONFIG_FILE="$WORK_DIR/hls_config.cfg"
COMPONENT_XML="$WORK_DIR/Top_module_Non_Debug_Multiple_Token/hls/impl/ip/component.xml"

echo "Running C simulation..."
vitis-run --mode hls --csim --config "$CONFIG_FILE" --work_dir "$WORK_DIR"

echo "Running Synthesis..."
v++ -c --mode hls --config "$CONFIG_FILE" --work_dir "$WORK_DIR"

echo "Running Package..."
vitis-run --mode hls --package --config "$CONFIG_FILE" --work_dir "$WORK_DIR"

echo "Modifying component.xml..."
"$SCRIPT_DIR/modify_xml.sh" "$COMPONENT_XML"
