// this code will curreonly only run on x86 systems
// https://software.intel.com/sites/default/files/m/a/9/b/7/b/1000-SSE.pdf
// SSE means 16 bytes, 4 32-bit integers, 2 64-bit integers, 8 16-bit shorts 
#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>

#define N 32768

int main()
{
    // init to zero, https://stackoverflow.com/questions/201101
    int a[N] = {};
    __m128i d = (__m128i)0;
    __m128i a = (__m128i)0;
    __m128i b = 1;
    int sum=0;

    // add by looping through each array element
    for (int i=0; i<N; ++i) {
       sum += a[i]; 
    }

    // add via SSE instructions
    for (int i=0; i<N; i+=4)
//       sum += _mm_add_ps((__m128i)a[i], d);
    }

_mm_hadd_epi32(__m128i a, __m128i b)


    printf("sum: %d\n", sum);
    return EXIT_SUCCESS;
}
