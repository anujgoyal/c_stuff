// https://carld.github.io/2017/06/20/lisp-in-less-than-200-lines-of-c.html
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define debug(m,e) printf("%s:%d: %s:", __FILE__, __LINE__, m); print_obj(e,1); puts(""):

typedef struct List { struct List *next; void *data;} List;
List *symbols = 0;
static int look;       /* look ahead character */
static char token[32]; /* token */

#define is_space(x) (x==' ' || x=='\n')
#define is_parens(x) (x=='(' || x==')')


static void gettoken() {
    int index = 0;
    while (is_space(look)) {
        look = getchar();
    }
    if (is_parens(look)) {
        token[index++] = look;
        look = getchar();
    } else {
        while(look != EOF && !is_space(look) && !is_parens(look)) {
            token[index++] = look;
            look = getchar();
        }
    }
    token[index] = '\0'; // NULL terminate
}

#define is_pair(x) (((long)x & 0x1) == 0x1) /* tag pointer to pair with 0x1 (alignment dependent) */ 
#define un_tag(x)  ((long) x & ~0x1)
#define tag(x)     ((long) x | 0x1)
#define car(x)     (((List*)untag(x))->data)
#define cdr(x)     (((List*)untag(x))->next)

#define e_true     cons( intern("quote"), cons( intern("t"), 0))
#define e_false    0

List *cons(void *_car, void *_cdr) {
    List *_pair = calloc(1, sizeof(List));
    _pair->data = _car; // head
    _pair->next = _cdr; // tail
    return (List*) tag(_pair);
}


