#!/bin/bash
# Converts the irq_ps busInterface from data to interrupt bus type.
# Usage: ./fix_irq_bus.sh <input_xml> [output_xml]

# /home/luka/Scripting/vitis_simulations/Top_Module_No_Debug/Top_Module_No_Debug/hls/impl/ip/xgui

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

TMPFILE=$(mktemp)
cp "$INPUT" "$TMPFILE"

BLOCK_START=$(grep -n '<spirit:name>irq_ps</spirit:name>' "$TMPFILE" | head -1 | cut -d: -f1)

if [ -z "$BLOCK_START" ]; then
    echo "WARNING: Could not find irq_ps busInterface block." >&2
    rm "$TMPFILE"
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

cp "$TMPFILE" "$OUTPUT"
rm "$TMPFILE"

echo "Done. Output written to: $OUTPUT"