#!/bin/bash
source scripts/utils.sh
set -e


step "Init BusyBox 1.36.1"
cd busybox-1.36.1
make defconfig
cd ..

mkdir -p configs
cp busybox-1.36.1/.config configs/busybox.config
echo "[✓] Saved BusyBox config to configs/busybox.config"
