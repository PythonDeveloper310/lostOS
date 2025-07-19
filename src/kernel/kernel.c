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

    kprint("\nmyOS Shell [kernel]\n"
        "Type END to halt the CPU\n\n> ");
}

void user_input(char *input) {
    if (strcmp(input, "END") == 0) {
        kprint("Stopping the CPU.\n");
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
    } else if (strcmp(input, "HELP") == 0) {
        kprint("Help Interface:\n"
            "   PAGE - First page: 0x10000, this command will produce a new address.\n"
            "   CLEAR - Clears the screeen.\n"
            "   VER - Shows OS version.\n"
            "   WHOAMI - Shows user name.\n"
            "   END - Halts the CPU.\n");
    } else {
        kprint("No command: ");
        kprint(input);
    }

    kprint("\n>");
}