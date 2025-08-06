cd initramfs
find . | cpio -o -H newc > ../build/init.cpio
