. ./tools/vars
. ./tools/kernel.sh

set -e

build_os_image() {
  build_kernel_bin

  echo "Creating OS image ($OUT)"
  cat target/boot.bin target/kernel.bin > target/$OUT
}