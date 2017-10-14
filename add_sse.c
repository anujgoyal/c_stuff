#include <stdlib.h>
#include <stdio.h>
//#include <math.h>

#define N 32768

int main()
{
    // init to zero, https://stackoverflow.com/questions/201101
    int a[N] = {};
    int sum=0;

    for (int i=0; i<N; ++i) {
       sum += a[i]; 
    }

    printf("sum: %d\n", sum);
    return EXIT_SUCCESS;
}
