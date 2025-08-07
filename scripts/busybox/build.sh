cd busybox

echo "Loading config "
cp ../config/busybox/.config ./.config

make oldconfig

echo "Building BusyBox"
make -j$(nproc)
make install