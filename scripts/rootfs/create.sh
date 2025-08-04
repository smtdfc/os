#!/bin/bash

source scripts/utils.sh
set -e

step "Creating Root Filesystem"
mkdir -p rootfs/{bin,sbin,etc,proc,sys,usr/bin,usr/sbin,dev}

# Copy BusyBox
cp build/busybox rootfs/bin/
chmod +x rootfs/bin/busybox

pushd rootfs/bin > /dev/null
for cmd in $(./busybox --list); do
  ln -sf busybox "$cmd"
done
popd > /dev/null


chmod +x rootfs/init

# Build cpio
cd rootfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../build/rootfs.cpio.gz
cd ..
