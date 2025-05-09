%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
}

%token <str> BINARY

%%

input:
    BINARY {
        int result = 0;
        for (int i = 0; $1[i]; i++) {
            result = result * 2 + ($1[i] - '0');
        }
        printf("Decimal: %d\n", result);
        free($1);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}


