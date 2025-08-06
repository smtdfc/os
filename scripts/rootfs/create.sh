#!/bin/bash

source scripts/utils.sh
set -e

step "Creating Root Filesystem"
mkdir -p rootfs/{bin,sbin,etc,proc,sys,usr/bin,usr/sbin,dev}

cd busybox-1.36.1 
make -j2 install 
cd ..
cp -av ./busybox-1.36.1/_install/* ./rootfs

chmod +x rootfs/linuxrc

# Build cpio
cd rootfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../build/rootfs.cpio.gz
cd ..
