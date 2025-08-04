#!/bin/bash
source scripts/utils.sh
set -e

step "Init Linux Kernel"
cd linux
make tinyconfig
cp .config ../configs/kernel.config
cd ..
