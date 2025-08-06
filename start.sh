
echo "Booting smtdfc OS"
qemu-system-x86_64 \
  -kernel build/bzImage \
  -initrd build/init.cpio \
  -nographic \
  -append "console=ttyS0 init=/init"


