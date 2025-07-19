#!/bin/sh

CC=/c/msys64/ucrt64/bin/i386-elf-gcc
LD=/c/msys64/ucrt64/bin/i386-elf-ld
ASM=nasm
VM=qemu-system-i386

BOOT=src/boot
CPU=src/cpu
KERNEL=src/kernel
DRIVERS=src/drivers
LIBC=src/libc
OUT=os-image.bin
OBJ_DIR=target/objs

C_SOURCES=$(find $KERNEL $DRIVERS $CPU $LIBC -name '*.c')
HEADERS=$(find $KERNEL $DRIVERS $CPU $LIBC -name '*.h')
ASM_SOURCES=$(find $BOOT $CPU -name '*.asm')
OBJ_FILES=""

set -e

mkdir -p $OBJ_DIR

build_objs() {
  INCLUDE_FLAGS="-I$KERNEL -I$DRIVERS -I$CPU"

  echo "[+] Compiling C files..."
  for src in $C_SOURCES; do
    obj="$OBJ_DIR/$(basename "$src" .c).o"
    $CC -g -w -ffreestanding $INCLUDE_FLAGS -c "$src" -o "$obj"
    OBJ_FILES="$OBJ_FILES $obj"
  done

  echo "[+] Assembling ASM files..."
  for src in $ASM_SOURCES; do
    filename=$(basename "$src" .asm)
    if grep -q "bits 16" "$src"; then
      $ASM "$src" -f bin -o "target/$filename.bin"
    else
      $ASM "$src" -f elf -o "$OBJ_DIR/$filename.o"
      OBJ_FILES="$OBJ_FILES $OBJ_DIR/$filename.o"
    fi
  done
}

build_kernel_bin() {
  build_objs

  echo "[+] Linking kernel..."
  $LD -Ttext 0x1000 -o target/kernel.bin $OBJ_FILES --oformat binary
}

build_os_image() {
  build_kernel_bin

  echo "[+] Creating OS image..."
  cat target/boot.bin target/kernel.bin > target/$OUT
}

run() {
  build_os_image
  echo "[+] Booting in QEMU..."
  $VM -drive if=floppy,format=raw,file=target/$OUT -full-screen
}

clean() {
  echo "[+] Cleaning..."
  rm -rf target/*.bin target/*.o $OBJ_DIR target/$OUT target/*.elf target/*.dis
}

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
