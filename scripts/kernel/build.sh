#!/bin/sh
set -e

source ./config/config.conf

cd linux

MAKEFILE_PATH="./Makefile"

echo "[*] Loading kernel config"
cp ../config/linux/.config .config

make ARCH="$ARCH" CROSS_COMPILE="$CROSS_COMPILE" oldconfig

if [ ! -f "$MAKEFILE_PATH" ]; then
  echo "[!] Makefile not found"
  exit 1
fi

if grep -q '^EXTRAVERSION' "$MAKEFILE_PATH"; then
  sed -i 's/^EXTRAVERSION.*/EXTRAVERSION = -smtdfcOS/' "$MAKEFILE_PATH"
else
  sed -i '/^SUBLEVEL.*/a EXTRAVERSION = -smtdfcOS' "$MAKEFILE_PATH"
fi

grep EXTRAVERSION "$MAKEFILE_PATH"

echo "[*] Building Kernel: ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE"
make ARCH="$ARCH" CROSS_COMPILE="$CROSS_COMPILE" -j"$(nproc)"

BZIMAGE_PATH="./arch/$ARCH/boot/bzImage"
if [ ! -f "$BZIMAGE_PATH" ]; then
  echo "[!] bzImage not found at $BZIMAGE_PATH"
  exit 1
fi

cp "$BZIMAGE_PATH" ../build/bzImage
echo "Kernel build completed: build/bzImage"