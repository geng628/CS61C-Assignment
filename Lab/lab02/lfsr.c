#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"
uint16_t get_bit(uint16_t x,unsigned n){
    uint16_t result = (x >> n) & 0b1;
    return result;
}
void set_bit(uint16_t *x,
             unsigned n,
             unsigned v)
{
    // YOUR CODE HERE
    if (v == 1)
    {
        (*x) |= (0b1 << n);
    }
    else
    {
        (*x) &= ~(0b1 << n);
    }
}
    void lfsr_calculate(uint16_t *reg)
{ // 16bit
    /* YOUR CODE HERE */
    // 取出0，2，3,5处的bit位的数值进行异或
    unsigned a, b, c, d;
    a = get_bit(*reg, 0);
    b = get_bit(*reg, 2);
    c = get_bit(*reg, 3);
    d = get_bit(*reg, 5);
    unsigned num = a ^ b ^ c ^ d;

    (*reg) = (*reg) >> 1;
    set_bit(reg, 15, num);
}
