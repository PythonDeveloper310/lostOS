# lostOS
My first real operating system using C and Assembly. I use github cfenollosa/os-tutorial to make this.
I added other commands like ECHO, VER, CLEAR, WHOAMI.

## The things you need to install to run lostOS. </br>

### For Windows user:
1) MSYS2 \ UCRT64 (Windows).  <a href="https://msys2.org">Download link here</a>
2) QEMU System. Type `pacman -S mingw-w64-ucrt-x86_64-qemu` in the ucrt64 terminal to download.
3) i386-elf Toolchain for UCRT64 (Windows). <a href="https://github.com/nativeos/i386-elf-toolchain/releases">Download link here</a>

### For Linux user:
1) QEMU System.
2) i386-elf Toolchain for Linux. <a href="https://github.com/nativeos/i386-elf-toolchain/releases">Download link here</a>

### For Mac user:
I don't know.

Challenge: Try to run it without errors like `bash: qemu-system-i386: command not found`, `bash: i386-elf-gcc: command not found` and so on.
