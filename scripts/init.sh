#!/bin/bash
set -e
source scripts/utils.sh

mkdir -p build
mkdir -p configs
bash scripts/kernel/init.sh
bash scripts/busybox/init.sh
