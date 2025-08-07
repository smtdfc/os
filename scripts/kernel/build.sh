cd linux
MAKEFILE_PATH=./Makefile

echo "Loading config "
cp ../config/linux/.config ./.config

make oldconfig


if [ ! -f "$MAKEFILE_PATH" ]; then
  echo "Makefile not found"
  exit 1
fi

if grep -q '^EXTRAVERSION' "$MAKEFILE_PATH"; then
  sed -i 's/^EXTRAVERSION.*/EXTRAVERSION = -smtdfcOS/' "$MAKEFILE_PATH"
else
  sed -i '/^SUBLEVEL.*/a EXTRAVERSION = -smtdfcOS' "$MAKEFILE_PATH"
fi

grep EXTRAVERSION "$MAKEFILE_PATH"

echo "Building Kernel"
make -j$(nproc)

