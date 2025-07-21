. ./tools/vars

set -e

clean() {
  echo "Cleaning"

  CLEAN_DIR=( target/*.bin target/*.o "$OBJ_DIR" "target/$OUT" target/*.elf target/*.dis )
  rm -rf $CLEAN_TARGET
}