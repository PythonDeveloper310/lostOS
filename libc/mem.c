#include "mem.h"

void memcopy(uint8_t *src, uint8_t *dest, int nbytes) {
    for (int i = 0; i < nbytes; i++) {
        *(dest + i) = *(src + i);
    }
}

void memset(uint8_t *dest, uint8_t val, uint32_t len) {
    uint8_t *temp = (uint8_t *)dest;
    for ( ; len != 0; len--) *temp++ = val;
}

uint32_t free_mem_addr = 0x10000;
uint32_t kmalloc(size_t size, int align, uint32_t *phys_addr) {
    if (align == 1 && (free_mem_addr & 0xfffff000)) {
        free_mem_addr &= 0xfffff000;
        free_mem_addr += 0x1000;
    }

    if (phys_addr) *phys_addr = free_mem_addr;

    uint32_t ret = free_mem_addr;
    free_mem_addr += size;
    return ret;
}