%{
#include "bin_to_dec.tab.c"
#include <string.h>
%}

%%

[01]+      { yylval.str = strdup(yytext); return BINARY; }
[\t\n ]+   ;  // Ignore whitespace
.          ;  // Ignore invalid characters

%%

int yywrap(void) {
    return 1;
}


