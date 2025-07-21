. ./tools/vars
. ./tools/objs.sh

set -e

build_kernel_bin() {
  build_objs

  echo "Linking kernel"
  $LD -Ttext 0x1000 -o target/kernel.bin $OBJ_FILES --oformat binary
}