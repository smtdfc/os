echo "Copying artifacts"
cp ./build/bzImage ./iso/boot/
cp ./build/init.cpio ./iso/boot/

echo "Building ISO file"

grub-mkrescue -o build/smtdfc_os.iso iso/
