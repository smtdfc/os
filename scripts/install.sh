#!/bin/bash
source scripts/utils.sh
set -e

BUSYBOX_VER="1.36.1"
BUSYBOX_ARCHIVE="busybox-${BUSYBOX_VER}.tar.bz2"
BUSYBOX_URL="https://busybox.net/downloads/${BUSYBOX_ARCHIVE}"
BUSYBOX_DIR="busybox-${BUSYBOX_VER}"

function clone_kernel() {
    local KERNEL_VERSION="6.9.5"
    local KERNEL_REPO="https://github.com/torvalds/linux.git"
    local KERNEL_DIR="linux"

    step "Cloning Linux kernel v$KERNEL_VERSION..."

    if [ -d "$KERNEL_DIR" ]; then
        echo "[-] Folder '$KERNEL_DIR' already exists. Skipping clone."
        return
    fi

    git clone --depth=1 --branch "v$KERNEL_VERSION" "$KERNEL_REPO" "$KERNEL_DIR"

    echo "[✓] Linux kernel v$KERNEL_VERSION cloned successfully!"
}


function install_deps() {
    step "Installing required build tools (Debian/Ubuntu)"
    sudo apt update
    sudo apt install -y \
        build-essential \
        bison \
        flex \
        libncurses-dev \
        libssl-dev \
        libelf-dev \
        bc \
        cpio \
        wget \
        clang \
        lld \
        git \
        make \
        gcc || fail_exit "Failed to install dependencies"
    echo "[✓] Dependencies installed"
}

function download_busybox() {
    step "Checking if BusyBox archive already exists"
    if [ ! -f "$BUSYBOX_ARCHIVE" ]; then
        step "Downloading BusyBox $BUSYBOX_VER"
        wget "$BUSYBOX_URL" || fail_exit "Failed to download BusyBox"
    else
        echo "[✓] Already downloaded: $BUSYBOX_ARCHIVE"
    fi

    step "Extracting BusyBox archive"
    if [ -d "$BUSYBOX_DIR" ]; then
        echo "[✓] Already extracted: $BUSYBOX_DIR"
    else
        tar -xf "$BUSYBOX_ARCHIVE" || fail_exit "Failed to extract archive"
    fi
}

######## MAIN ########

install_deps
clone_kernel
download_busybox

