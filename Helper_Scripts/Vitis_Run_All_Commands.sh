#!/bin/bash

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
