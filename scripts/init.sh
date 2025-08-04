#!/bin/bash
set -e
source scrips/utils.sh

bash scripts/kernel/init.sh
bash scripts/busybox/init.sh
