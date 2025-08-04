#!/bin/bash
source scripts/utils.sh
set -e


step "Init BusyBox 1.36.1"
cd busybox-1.36.1
make defconfig
cp .config ../configs/busybox.config
cd ..

echo "[✓] Saved BusyBox config to configs/busybox.config"
