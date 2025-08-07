echo "Setting up environment "
mkdir -p build


echo "Setting up tools"
sudo apt update
sudo apt-get install bzip2 git vim make gcc libncurses-dev flex bison bc cpio libelf-dev libssl-dev syslinux dosfstools nano git
sudo apt install grub-pc-bin grub-common grub2-common xorriso
sudo apt install qemu-system-x86 -y
sudo apt install e2fsprogs

echo "Cloning Linux Kernel source "
git clone --depth 1 https://github.com/torvalds/linux.git

echo "Cloning Busybox source"
git clone --depth 1 https://git.busybox.net/busybox

echo "Setting up rootfs"
mkdir -p rootfs/{sbin,lib,x86_64-linux-gnu,lib64}

cp /lib/x86_64-linux-gnu/libext2fs.so.2 rootfs/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libcom_err.so.2 rootfs/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libblkid.so.1 rootfs/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libuuid.so.1 rootfs/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libe2p.so.2 rootfs/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libc.so.6 rootfs/lib/x86_64-linux-gnu/
cp /lib64/ld-linux-x86-64.so.2 rootfs/lib64/