#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>

void p128_as_char(__m128i in) {
    uint8_t *v = (uint8_t*) &in;
    printf("char: %u %u %u %u, %u %u %u %u, %u %u %u %u, %u %u %u %u\n",
    v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9], v[10], v[11], v[12], v[13], v[14], v[15]);
}
void p128_as_short(__m128i in) {
    uint16_t *v = (uint16_t*) &in;
    printf("short: %i %i %i %i, %i %i %i %i\n", v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7]);
}
void p128_as_int(__m128i in) {
    uint32_t *v = (uint32_t*) &in;
    printf("int: %i %i %i %i\n", v[0], v[1], v[2], v[3]);
}


int main() {
    // init to zero, https://stackoverflow.com/questions/201101
    //int ar[4] = {0};
    //int br[4] = {0};
    //__mm128i *pa = (__m128i*)ar;
    //__mm128i *pb = (__m128i*)br;
    //result = _mm_add_epi32(*a, *b);
    //__m128i a = _mm_set_epi32(1,2,3,4);
    //__m128i b = _mm_set_epi32(1,2,3,4);

    __m128i src = _mm_set_epi32(1,2,3,4);
    __m128i ops = _mm_set_epi32(5,6,7,8);
    // add using SSE intrinsic
    __m128i res = _mm_add_epi32(src, ops);
    // print out values
    p128_as_char(res);
    p128_as_short(res);
    p128_as_int(res);

    //printf("sum: %d\n", result);
    return EXIT_SUCCESS;
}
