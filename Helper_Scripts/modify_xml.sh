#!/bin/bash
# Converts the irq_ps busInterface from data to interrupt bus type.
# Usage: ./modify_xml.sh <input_xml> [output_xml]

# Example path (varies by MODEL_ARCH):
# Model-architectures/<arch>/vitis_simulations/<proj>/<proj>/hls/impl/ip/xgui

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <input_xml> [output_xml]" >&2
    exit 1
fi

INPUT="$1"
OUTPUT="${2:-$1}"

if [ ! -f "$INPUT" ]; then
    echo "ERROR: File not found: $INPUT" >&2
    exit 1
fi

OUTPUT_DIR=$(dirname "$OUTPUT")

if [ ! -d "$OUTPUT_DIR" ]; then
    echo "ERROR: Output directory not found: $OUTPUT_DIR" >&2
    exit 1
fi

# Write beside the target so replacing the output also works when editing in place.
TMPFILE=$(mktemp "$OUTPUT_DIR/modify_xml.XXXXXX")

cleanup() {
    if [ -n "${TMPFILE:-}" ] && [ -f "$TMPFILE" ]; then
        rm -f "$TMPFILE"
    fi
}

trap cleanup EXIT

cp "$INPUT" "$TMPFILE"

BLOCK_START=$(grep -n '<spirit:name>irq_ps</spirit:name>' "$TMPFILE" | head -1 | cut -d: -f1)

if [ -z "$BLOCK_START" ]; then
    echo "WARNING: Could not find irq_ps busInterface block." >&2
    exit 1
fi

BLOCK_END=$(tail -n +"$BLOCK_START" "$TMPFILE" | grep -n '</spirit:busInterface>' | head -1 | cut -d: -f1)
BLOCK_END=$((BLOCK_START + BLOCK_END - 1))

sed -i "${BLOCK_START},${BLOCK_END}s/spirit:name=\"data\"/spirit:name=\"interrupt\"/g" "$TMPFILE"
sed -i "${BLOCK_START},${BLOCK_END}s/spirit:name=\"data_rtl\"/spirit:name=\"interrupt_rtl\"/g" "$TMPFILE"
sed -i "${BLOCK_START},${BLOCK_END}s/<spirit:name>DATA<\/spirit:name>/<spirit:name>INTERRUPT<\/spirit:name>/g" "$TMPFILE"

SENSITIVITY_BLOCK="\
      <spirit:parameters>\n\
        <spirit:parameter>\n\
          <spirit:name>SENSITIVITY</spirit:name>\n\
          <spirit:value spirit:id=\"BUSIFPARAM_VALUE.IRQ_PS.SENSITIVITY\">LEVEL_HIGH</spirit:value>\n\
        </spirit:parameter>\n\
      </spirit:parameters>"

sed -i "${BLOCK_END}i\\${SENSITIVITY_BLOCK}" "$TMPFILE"

mv "$TMPFILE" "$OUTPUT"
trap - EXIT

echo "Done. Output written to: $OUTPUT"
