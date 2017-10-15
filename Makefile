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
	clang -O3 -msse -msse2 -msse3 -msse4.1 sum.c ; ./a.out

sumass: sum.c
	clang -S -O3 -msse -msse2 -msse3 -msse4.1 sum.c
