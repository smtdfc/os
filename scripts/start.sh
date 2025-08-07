#!/bin/sh
set -e

echo "Booting smtdfc OS"
qemu-system-x86_64 \
  -M q35 \
  -m 1G \
  -kernel  build/bzImage \
  -initrd build/init.cpio \
  -nographic \
  -net nic -net user \
  -append "console=ttyS0 loglevel=7  init=/init"
