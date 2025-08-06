
echo "Booting smtdfc OS"
qemu-system-x86_64 \
  -kernel build/bzImage \
  -initrd build/init.cpio \
  -nographic \
  -net nic -net user \
  -append "console=ttyS0 init=/init"
