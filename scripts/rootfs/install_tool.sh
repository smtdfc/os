#!/bin/sh
set -e

source ./config/config.conf

TOOLS_DIR="./tools"
DEST_DIR="./rootfs/usr/bin"

mkdir -p "$DEST_DIR"

for name in $TOOLS; do
  binary="$TOOLS_DIR/$name/dist/$name"
  if [ -f "$binary" ]; then
    cp "$binary" "$DEST_DIR/$name"
    chmod +x "$DEST_DIR/$name"
  else
    echo "Tool '$name' not found at $binary" >&2
  fi
done