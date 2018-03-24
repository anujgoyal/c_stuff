CC=clang
CFLAGS=-Wall -I.
LIBS=-lm
DEBUG=-g

fastadd: add_sse.c
	$(CC) $(CCFLAGS) -o fastadd add_sse.c

all: fastadd

clean:
	rm -f fastadd
#	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 

it:
	make clean; make all
	./fastadd

sum: sum.c
	clang -O3 -fno-tree-vectorize -msse -msse2 -msse3 -msse4.1 sum.c ; ./a.out
sum2: sum2.c
	clang -O3 -fno-tree-vectorize -msse -msse2 -msse3 -msse4.1 sum2.c ; ./a.out 123
avx: avx.c
	clang -O3 -fno-tree-vectorize -msse -msse2 -msse3 -msse4.1 -mavx -mavx2 avx.c ; ./a.out 123

sumass: sum.c
	clang -S -O3 -msse -msse2 -msse3 -msse4.1 sum.c
sum2ass: sum2.c
	clang -S -O3 -msse -msse2 -msse3 -msse4.1 sum2.c
avxass: avx.c
	clang -S -O3 -msse -msse2 -msse3 -msse4.1 -mavx -mavx2 avx.c

