
#include <sys/types.h>
#include <sys/mman.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>

/* Does not work on OS X, as you can't mmap over /dev/zero */
int main(void)
{
	const int MMAP_BUF = 4096;
	const char str1[] = "string 1";
        const char str2[] = "string 2";
        int parent_pid = getpid(), childpid;
        int fd = -1;
	const char *filename = "/Users/agoyal3/temp/clang_tests/map.txt";
        char *anon, *fmapped;

	// open file
        if ((fd = open(filename, O_RDWR, 0)) == -1) {
                err(1, "open");
	} else {
		printf("fd: %d\n", fd);
	}

	// mmap file
	fmapped = (char*)mmap(NULL, MMAP_BUF, PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED, fd, 0);
	if (MAP_FAILED == fmapped) {
		printf("mmap failed: %s\n", filename);
	} else {
		printf("fmapped: %p\n", fmapped); // %p
	}

	// http://www.lemoda.net/c/mmap-example/
	// try to print out 10 chars, assuming data is char
	for (int i = 0; i < 10; i++) {
	        char c;
		c = fmapped[i];
	        if (isalpha (c)) {
			putchar (c);
        	}
		// insert carriage return after 80 chars
        	if (i % 80 == 79) { putchar ('\n'); }
	}
	putchar ('\n'); // insert last carriage return

	// cleanup
	munmap(fmapped, MMAP_BUF);
        close(fd);
	printf("Exit\n");
	return EXIT_SUCCESS;
}

