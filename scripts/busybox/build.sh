#!/bin/bash
source scripts/utils.sh
set -e

BUILD_PROC=2

step "Build BusyBox 1.36.1"
cd busybox-1.36.1
cp ../configs/busybox.config .config
make oldconfig   

make -j$BUILD_PROC
cp ./busybox ../build/busybox

cd ..

echo "[✓] Build BusyBox completed successfully!"