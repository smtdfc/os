#!/bin/bash
set -e
source scripts/utils.sh

bash scripts/kernel/init.sh
bash scripts/busybox/init.sh
