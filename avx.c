#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <time.h>
#ifndef __cplusplus
#include <stdalign.h>   // C11 defines _Alignas().  This header defines alignas()
#endif
#define REPS 1000000
#define AR 2048

// add int vectors via AVX
__attribute__((noinline)) 
void add_iv_avx(__m256i *restrict a, __m256i *restrict b, __m256i *restrict out, int N) {

    __m256i *x = __builtin_assume_aligned(a, 32);
    __m256i *y = __builtin_assume_aligned(b, 32);
    __m256i *z = __builtin_assume_aligned(out, 32);

    const int loops = N / 8; // 8 is number of int32 in __m256i
    for(int i=0; i < loops; i++) { 
        _mm256_store_si256(&z[i], _mm256_add_epi32(x[i], y[i]));
    }
    /* // try to do more compute per loop
     * for(int i=0; i < loops; i+=4) { 
        __m256i a = _mm256_add_epi32(x[i], y[i]);
        __m256i b = _mm256_add_epi32(x[i+1], y[i+1]);
        __m256i c = _mm256_add_epi32(x[i+2], y[i+2]);
        __m256i d = _mm256_add_epi32(x[i+3], y[i+3]);
        _mm256_store_si256(&z[i], a);
        _mm256_store_si256(&z[i+1], b);
        _mm256_store_si256(&z[i+2], c);
        _mm256_store_si256(&z[i+3], d);
    }*/

}

// add int vectors via SSE; https://en.wikipedia.org/wiki/Restrict
__attribute__((noinline)) 
void add_iv_sse(__m128i *restrict a, __m128i *restrict b, __m128i *restrict out, int N) {

    __m128i *x = __builtin_assume_aligned(a, 16);
    __m128i *y = __builtin_assume_aligned(b, 16);
    __m128i *z = __builtin_assume_aligned(out, 16);

    const int loops = N / sizeof(int);
    for(int i=0; i < loops; i++) { 
        //out[i]= _mm_add_epi32(a[i], b[i]); // this also works
        _mm_storeu_si128(&z[i], _mm_add_epi32(x[i], y[i]));
    } 
}

// printing
void p128_as_int(__m128i in) {
    alignas(16) uint32_t v[4];
    _mm_store_si128((__m128i*)v, in);
    printf("int: %i %i %i %i\n", v[0], v[1], v[2], v[3]);
}

__attribute__((noinline)) 
void debug_print(int *h) {
    printf("vector+vector:begin ");
    p128_as_int(* (__m128i*) &h[0] );
}

int main(int argc, char *argv[]) {
    int n = atoi (argv[1]);
    printf("n: %d\n", n);

    int *x,*y,*z;
    if (posix_memalign((void**)&x, 32, 16384*sizeof(int))) { free(x); return EXIT_FAILURE; }
    if (posix_memalign((void**)&y, 32, 16384*sizeof(int))) { free(y); return EXIT_FAILURE; }
    if (posix_memalign((void**)&z, 32, 16384*sizeof(int))) { free(z); return EXIT_FAILURE; }
    x[0]=0; x[1]=2; x[2]=4;
    y[0]=1; y[1]=3; y[2]=n;

    // touch each 4K page in x,y,z 
    for (int i=512; i<AR; i+= 512) { x[i]=1; y[i]=1; z[i]=1; }

    // warmup
    for(int i=0; i<REPS; ++i) { add_iv_avx((__m256i*)x, (__m256i*)y, (__m256i*)z, AR); }
    // AVX
    clock_t start = clock();
    for(int i=0; i<REPS; ++i) { add_iv_avx((__m256i*)x, (__m256i*)y, (__m256i*)z, AR); }
    int msec = (clock()-start) * 1000 / CLOCKS_PER_SEC;
    printf("  AVX Time taken: %d seconds %d milliseconds\n", msec/1000, msec%1000);
    debug_print(z);

    // warmup
    for(int i=0; i<REPS; ++i) { add_iv_sse((__m128i*)x, (__m128i*)y, (__m128i*)z, AR); }
    // SSE
    start = clock();
    for(int i=0; i<REPS; ++i) { add_iv_sse((__m128i*)x, (__m128i*)y, (__m128i*)z, AR); }
    msec = (clock()-start) * 1000 / CLOCKS_PER_SEC;
    printf("\n  SSE Time taken: %d seconds %d milliseconds\n", msec/1000, msec%1000);
    debug_print(z);

    return EXIT_SUCCESS;
}

