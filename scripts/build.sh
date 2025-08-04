#!/bin/bash
set -e

sh scripts/kernel/build.sh
sh scripts/busybox/build.sh

echo "[✓] Build completed successfully!"