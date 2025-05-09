%{
#include <stdio.h>
%}

%option noyywrap

%%
"<"[a-zA-Z]+">"         { printf("This is a valid HTML tag: %s\n", yytext); }
"<"[^a-zA-Z]+">"        { printf("This is not a valid HTML tag: %s\n", yytext); }
"<>"                    { printf("This is not a valid HTML tag: %s\n", yytext); }
"<"[^\n>]*">"           { printf("This is not a valid HTML tag: %s\n", yytext); }
[ \t\n]                 { /* Ignore whitespace */ }
[^<\n]+                 { printf("Invalid input, not a tag: %s\n", yytext); }

%%

int main() {
    printf("Enter HTML tags:\n");
    yylex();
    return 0;
}



