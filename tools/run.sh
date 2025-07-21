. ./tools/vars
. ./tools/os_img.sh
. ./tools/kernel.sh
. ./tools/clean.sh

set -e

run() {
  build_os_image
  echo "Booting in QEMU ($VM)"
  $VM -drive if=floppy,format=raw,file=target/$OUT -full-screen
}