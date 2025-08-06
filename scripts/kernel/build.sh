cd linux

echo "Loading config "
cp ../config/linux/.config ./.config

make oldconfig

echo "Building Kernel"
make -j$(nproc)

