#!/bin/sh
set -e

cd rootfs
find . | cpio -o -H newc > ../build/init.cpio
