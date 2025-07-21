. ./tools/vars

set -e

build_objs() {
  INCLUDE_FLAGS="-I$KERNEL -I$DRIVERS -I$CPU"
  CFLAGS="-ffreestanding -Wall -Wextra -fno-exceptions -m32 -w"

  echo "Compiling C files"
  for src in $C_SOURCES; do
    obj="$OBJ_DIR/$(basename "$src" .c).o"
    $CC $CFLAGS $INCLUDE_FLAGS -c "$src" -o "$obj"
    OBJ_FILES="$OBJ_FILES $obj"
  done

  echo "Assembling ASM files"
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