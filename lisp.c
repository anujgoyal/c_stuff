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
// get data/head
#define car(x)     (((List*)untag(x))->data) 
// get next/tail
#define cdr(x)     (((List*)untag(x))->next)

#define e_true     cons( intern("quote"), cons( intern("t"), 0))
#define e_false    0

// contruct pair of pointers
List *cons(void *_car, void *_cdr) {
    List *_pair = calloc(1, sizeof(List));
    _pair->data = _car; // head
    _pair->next = _cdr; // tail
    return (List*) tag(_pair);
}

// intern string
void *intern(char *sym) {
    List *_pair = symbols;
    // search for string in existing symbol list
    for (; _pair ; _pair = cdr(_pair)) {
            if (strncmp(sym, (char*)car(_pair), 32)==0) {
                return car(_pair);
            }
    }
    // didn't find symbol, add to head of list
    symbols = cons(strdup(sym), symbols);
    return car(symbols);
}

// getlist() and getobj() assume looping over characters

List *getlist(); // forward decl

void *getobj() {
    if (token[0] == '(') return getlist();
    return intern(token);
}

// read token and 
List *getlist() {
    List *tmp;
    gettoken();
    if(token[0] == ')') return 0;
    tmp = getobj();
    return cons(tmp, getlist());
}

// print either a symbol, or an entire list, to stdout
void print_obj(List *ob, int head_of_list) {
    if (!is_pair(ob) ) {
        // not a pair, just a symbol so printf
        printf("%s", ob ? (char*) ob : "null");
    } else {
        // is a pair (list) 
        if (head_of_list) {
            printf("("); // beginning of list
        }
        printf_obj(car(ob), 1);
        if (cdr(ob) != 0) {
            if (is_pair(cdr(ob))) {
                printf(" ");
                print_obj(cdr(ob),0);
            }
        } else {
            printf(")"); // end of list
        }
    }
}

List *fcons(List *a)     { return cons(car(a), car(cdr(a))); }
List *fcar(List *a)      { return car(car(a)); }
List *fcdr(List *a)      { return cdr(cdr(a)); }
List *feq(List *a)       { return car(a) == car(cdr(a)) ? e_true : e_false; }
List *fpair(List *a)     { return is_pair(car(a))       ? e_true : e_false; } 
List *fsym(List *a)      { return !is_pair(car(a))      ? e_true : e_false; }
List *fnull(List *a)     { return car(a) == 0           ? e_true : e_false; }
List *freadobj(List *a)  { look = getchar(); getttoken(); return getobj();  } 
List *fwriteobj(List *a) { print_obj(car(a), 1); puts(""); return e_true;   }

List *eval(List *exp, List *env);

// evaluate list
List *evlist(List *list, List *env) {
    List *head = 0, **args = &head;
    // loop through list
    for ( ; list ; list = cdr(list) ) {
        *args = cons( eval(car(list), env), 0);
        args = &( (List *) untag(*args) )-> next;
    }
    return head;
}

List *apply_primitive(void *primfn, List *args) {
    return ((List *(*) (List *) primfn) (args);
}

List *eval(List *exp, List *env) {
    if (!is_pair(exp)) {
        for ( ; env !=0; env=cdr(env) ) 
            if (exp == car(car(env))) return car(cdr(car(env)));
        return 0
    } else {
        if (!is_pair( car(exp))) { /* special forms */
            return car(cdr(exp));
        } else if (car(exp) == intern("if")) {


    }
}




