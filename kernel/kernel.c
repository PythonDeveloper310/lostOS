#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../libc/string.h"
#include "../libc/mem.h"
#include "kernel.h"
#include <stdint.h>

void kernel_main() {
    isr_install();
    irq_install();
    clear_screen();

    kprint("\nlostOS Shell\n"
        "Type HELP for list of commands.\n\n> ");
}

void user_input(char *input) {
    if (strcmp(input, "HLT") == 0) {
        kprint("Halting the CPU.\n");
        kprint("Ctrl+Alt+F to exit fullscreen, close QEMU.\n");
        asm volatile("hlt");
    } else if (strcmp(input, "PAGE") == 0) {
        uint32_t phys_addr;
        uint32_t page = kmalloc(1000, 1, &phys_addr);
        char page_str[16] = "";
        char phys_str[16] = "";
        hex_to_ascii(page, page_str);
        hex_to_ascii(phys_addr, phys_str);
        kprint("Page: ");
        kprint(page_str);
        kprint(", Physical Address: ");
        kprint(phys_str);
        kprint("\n");
    } else if (strcmp(input, "CLEAR") == 0) {
        clear_screen();
    } else if (strcmp(input, "VER") == 0) {
        kprint("OS Version: 1.0\n");
    } else if (strcmp(input, "WHOAMI") == 0) {
        kprint("user\n");
    } else if (stwh(input, "ECHO ") == 1) {
        kprint(input + 5);
        kprint("\n");
    } else if (strcmp(input, "HELP") == 0) {
        kprint("Help Interface:\n"
            "   PAGE - First page: 0x10000, this command will produce a new address.\n"
            "   CLEAR - Clear the screeen.\n"
            "   ECHO [text] - Prints the text.\n"
            "   VER - Show OS version.\n"
            "   WHOAMI - Show user name.\n"
            "   HLT - Halt the CPU.\n");
    } else {
        kprint("No command: ");
        kprint(input);
    }

    kprint("\n> ");
}