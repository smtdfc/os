cd busybox

echo "Loading config "
cp ../config/linux/.config ./.config

make oldconfig

echo "Building BusyBox"
make -j$(nproc)
make install