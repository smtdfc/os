#!/bin/bash
set -e

KERNEL="build/kernel/bzImage"
INITRD="build/rootfs.cpio.gz"

if [ ! -f "$KERNEL" ]; then
    echo "[✗] Kernel image not found: $KERNEL"
    exit 1
fi

if [ ! -f "$INITRD" ]; then
    echo "[✗] Initramfs image not found: $INITRD"
    exit 1
fi

echo "[*] Booting your custom OS with QEMU..."
qemu-system-x86_64 \
    -kernel "$KERNEL" \
    -initrd "$INITRD" \
    -m 512M \
    -nographic \
    -append "console=ttyS0 quiet"


echo "[✓] Shutdown complete!"