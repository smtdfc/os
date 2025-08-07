#!/bin/sh
set -e

source ./config/config.conf

cd busybox

echo "[*] Loading BusyBox config"
cp ../config/busybox/.config .config

make ARCH="$ARCH" CROSS_COMPILE="$CROSS_COMPILE" oldconfig

echo "[*] Building BusyBox"
make ARCH="$ARCH" CROSS_COMPILE="$CROSS_COMPILE" -j"$(nproc)"

echo "[*] Installing BusyBox to _install/"
make ARCH="$ARCH" CROSS_COMPILE="$CROSS_COMPILE" install

echo "BusyBox built and installed to busybox/_install/"