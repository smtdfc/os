#!/bin/sh
set -e

qemu-system-x86_64 \
  -m 1G \
  -kernel  build/bzImage \
  -initrd build/init.cpio \
  -nographic \
  -net nic -net user \
  -append "console=ttyS0 loglevel=7  init=/init"
  -drive file=disk.img,format=raw,if=virtio \