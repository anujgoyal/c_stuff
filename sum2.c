#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>
#include <time.h>
#ifndef __cplusplus
#include <stdalign.h>   // C11 defines _Alignas().  This header defines alignas()
#endif
#define CYCLE_COUNT  10000

// add vector and return resulting value on stack
__attribute__((noinline)) __m128i add_iv(__m128i *a, __m128i *b) {
    return _mm_add_epi32(*a,*b);
}

// add int vectors via sse
__attribute__((noinline)) void add_iv_sse(__m128i *a, __m128i *b, __m128i *out, int N) {
    for(int i=0; i<N/sizeof(int); i++) { 
        //out[i]= _mm_add_epi32(a[i], b[i]); // this also works
        _mm_storeu_si128(&out[i], _mm_add_epi32(a[i], b[i]));
    } 
}

// add int vectors without sse
__attribute__((noinline)) void add_iv_nosse(int *a, int *b, int *out, int N) {
    for(int i=0; i<N; i++) { 
        out[i] = a[i] + b[i];
    } 
}

__attribute__((noinline)) void p128_as_int(__m128i in) {
    alignas(16) uint32_t v[4];
    _mm_store_si128((__m128i*)v, in);
    printf("int: %i %i %i %i\n", v[0], v[1], v[2], v[3]);
}

// print first 4 and last 4 elements of int array
__attribute__((noinline)) void debug_print(int *h) {
    printf("vector+vector:begin ");
    p128_as_int(* (__m128i*) &h[0] );
    printf("vector+vector:end ");
    p128_as_int(* (__m128i*) &h[32764] );
}

int main(int argc, char *argv[]) {
    int n = atoi (argv[1]);
    printf("n: %d\n", n);
    // sum: vector + vector, of equal length
    int f[32768] __attribute__((aligned(16))) = {0,2,4};
    int g[32768] __attribute__((aligned(16))) = {1,3,n};
    int h[32768] __attribute__((aligned(16))); 
    f[32765] = 33; f[32766] = 34; f[32767] = 35;
    g[32765] = 31; g[32766] = 32; g[32767] = 33;

    // https://stackoverflow.com/questions/459691/best-timing-method-in-c
    clock_t start = clock();
        for(int i=0; i<CYCLE_COUNT; ++i) {
            add_iv_sse((__m128i*)f, (__m128i*)g, (__m128i*)h, 32768);
        }
    int msec = (clock()-start) * 1000 / CLOCKS_PER_SEC;
    printf("  SSE Time taken: %d seconds %d milliseconds\n", msec/1000, msec%1000);
    debug_print(h);

    // process intense function again
    start = clock();
        for(int i=0; i<CYCLE_COUNT; ++i) {
            add_iv_nosse(f, g, h, 32768);
        }
    msec = (clock()-start) * 1000 / CLOCKS_PER_SEC;
    printf("NOSSE Time taken: %d seconds %d milliseconds\n", msec/1000, msec%1000);
    debug_print(h);

    return EXIT_SUCCESS;
}

