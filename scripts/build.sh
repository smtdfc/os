#!/bin/bash
set -e
source scripts/utils.sh

bash scripts/kernel/build.sh
bash scripts/busybox/build.sh

echo "[✓] Build completed successfully!"