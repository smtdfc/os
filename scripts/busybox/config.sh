#!/bin/bash
source scripts/utils.sh
set -e


step "Config BusyBox 1.36.1"
cd busybox-1.36.1
cp ../configs/busybox.config .config
make menuconfig
cp .config ../configs/busybox.config

cd ..

echo "[✓] Saved BusyBox config to configs/busybox.config"
