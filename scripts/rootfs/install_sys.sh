#!/bin/sh
set -e

cp -av ./busybox/_install/* ./rootfs
cd rootfs
chmod +x bin/*
chmod +x sbin/*
chmod +x usr/bin/*
chmod +x usr/sbin/*
