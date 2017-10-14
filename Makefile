CC=clang
CFLAGS=-Wall -I.
LIBS=-lm

fastadd: add_sse.c
	$(CC) -o fastadd  add_sse.c $(CFLAGS)

all: fastadd

clean:
	rm -f fastadd
#	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 

it:
	make clean; make all
	./fastadd

