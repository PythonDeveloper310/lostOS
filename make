#!/usr/bin/env sh
set -e

. ./tools/run.sh
. ./tools/os_img.sh
. ./tools/kernel.sh
. ./tools/clean.sh

case "$1" in
  "")
    run
    ;;
  kernel)
    build_kernel_bin
    ;;
  os_image)
    build_os_image
    ;;
  run)
    run
    ;;
  clean)
    clean
    ;;
  *)
    echo "Usage: $0 [run|clean|kernel|os_image]"
    exit 1
    ;;
esac