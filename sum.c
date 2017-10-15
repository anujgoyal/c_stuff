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

__m128i add_vector(__m128i *a, __m128i *b) {
    __m128i r = _mm_add_epi32(*a,*b);
    return r;
}

int main() {

    // basic addition of two SSE vectors
    __m128i src __attribute__((aligned(16))) = _mm_set_epi32(1,2,3,4);
    __m128i ops __attribute__((aligned(16))) = _mm_set_epi32(5,6,7,8);
    // add using SSE intrinsic
    __m128i res __attribute__((aligned(16))) = _mm_add_epi32(src, ops);
    // print out values
    //p128_as_char(res);
    //p128_as_short(res); 
    p128_as_int(res);

    // try the reverse when using set
    //__m128i y = _mm_set_epi32(4,3,2,1), z = _mm_set_epi32(8,7,6,5);
    //res = add_vector(&y,&z); printf("\n"); p128_as_int(res);

    // Sum two SSE __m128i objects
    int a[4] __attribute__((aligned(16))) = {0,1,2,3}; // init to zero, https://stackoverflow.com/questions/201101
    int b[4] __attribute__((aligned(16))) = {1,1,1,1};
    __m128i *pa = (__m128i*)a;
    __m128i *pb = (__m128i*)b;
    res = _mm_add_epi32(*pa, *pb);
    p128_as_int(res);

    // try the reverse when using set, also call add_vector
    printf("\n");
    __m128i y = _mm_set_epi32(4,3,2,1);
    __m128i z = _mm_set_epi32(8,7,6,5);
    res = add_vector(&y,&z);
    p128_as_int(res);

    // sum up values for an array
    // option 1: atom + vector
    int c[4]     __attribute__((aligned(16))) = {5,5,5,5};
    int d[32768] __attribute__((aligned(16))) = {1};
    int e[32768] __attribute__((aligned(16))); // going to be overridden
    __m128i *pc = (__m128i*)c;
    for (int i=0; i<32768; i+=4) {
        __m128i *pd = (__m128i*)(&d[i]);
        __m128i *pe = (__m128i*)(&e[i]);
        *pe = _mm_add_epi32( *pc, *pd);
    }
    // print first elements of e
    pc = (__m128i*)&e[0];
    printf("atom+vector\n");
    p128_as_int(*pc);

    // option 2: vector + vector, both must be equal length

    //printf("sum: %d\n", result);
    return EXIT_SUCCESS;
}
