#!/bin/bash
set -e
source scripts/utils.sh

KERNEL="build/kernel"
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
  -m 2G \
  -nographic \
  -serial mon:stdio \
  -append "console=ttyS0 earlyprintk=serial init=/linuxrc"
 
 
echo "[✓] Shutdown complete!"
