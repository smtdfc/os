#!/bin/bash
source scrips/utils.sh
set -e

BUILD_PROC=2

step "Build Linux Kernel"

cd linux

cp ../configs/kernel.config .config
make olddefconfig   

make -j$BUILD_PROC


cp arch/x86/boot/bzImage ../build/kernel

cd ..

echo "[✓] Kernel Build completed successfully!"