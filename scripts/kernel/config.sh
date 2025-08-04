#!/bin/bash
source scripts/utils.sh
set -e

step "Config Linux Kernel"
cd linux
cp ../configs/kernel.config .config
make olddefconfig   
make menuconfig
cp .config ../configs/kernel.config
cd ..

echo "[✓] Saved Linux Kernel config to configs/kernel.config"
