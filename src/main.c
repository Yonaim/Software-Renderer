#include "platform.h"
#include <stdio.h>

int main(int argc, const char * argv[]) {
    platform_initialize(); // blocking
	printf("test\n");
    return 0;
}
