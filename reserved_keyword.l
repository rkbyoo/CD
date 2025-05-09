/* Lex program to recognise and display keywords, numbers and words in a given sentence */

%{
#include <stdio.h>
%}

%% 

if|else|printf        { printf("%s is a keyword\n", yytext); }
[0-9]+                { printf("%s is a number\n", yytext); }
[a-zA-Z][a-zA-Z0-9]*  { printf("Identifier: %s\n", yytext); }
[ \t\n]+              { /* skip whitespace */ }
.                     { /* ignore other characters */ }

%%

int yywrap(){
	return 1;
}

int main() {
    yylex();
    return 0;
}

