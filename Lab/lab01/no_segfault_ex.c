#include <stdio.h>
int main() {
    int a[5] = {1, 2, 3, 4, 5};
    int total = 0;
    for (int j = 0; j < sizeof(a)/sizeof(int); j++) {
        total += a[j];
    }
    printf("sum of array is %d\n", total);
}
//sizeof()里面是计算字节的多少的，这里里面数组为40个字节，没有发生段错误也仅仅是侥幸