CC=clang
CFLAGS=-Wall -I.

fastadd: add_sse.c
	$(CC) $(CFLAGS) -o fastadd  add_sse.c

all: fastadd

clean:
	rm -f fastadd
#	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
