#include <stdio.h>

#include "init.h"
#include "module1_com.h"
#include "module2_com.h"
#include "module3_com.h"
#include "module4_com.h"

int main(void) {
    init();
    m1_com();
    m2_com();
    m3_com();
    m4_com();
    return 0;
}
