#include <stdio.h>
#include "module1_com.h"
#include "module2_com.h"

int main(void)
{
    printf("main!!!\r\n");
    printf("test");
    m1_com()
    m2_com();
    return 0;
}

