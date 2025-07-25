#ifndef MEM_H
#define MEM_H

#include <stdint.h>
#include <stddef.h>

void memcopy(uint8_t *src, uint8_t *dest, int nbytes);
void memset(uint8_t *dest, uint8_t val, uint32_t len);

uint32_t kmalloc(size_t size, int align, uint32_t *phys_addr);

#endif