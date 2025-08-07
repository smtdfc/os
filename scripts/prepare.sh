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
