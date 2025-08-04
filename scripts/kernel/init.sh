#!/bin/bash
source scrips/utils.sh
set -e

step "Init Linux Kernel"
cd linux
make tidyconfig
cp .config ../configs/kernel.config
cd ..
