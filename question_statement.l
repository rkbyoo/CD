%{
#include <stdio.h>
%}

%%

[a-zA-Z0-9 ]+\.    { printf("Statement\n"); }
[a-zA-Z0-9 ]+\?    { printf("Question\n"); }
[a-zA-Z0-9 ]+      { printf("Invalid\n"); }
.                  { printf("Invalid\n"); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter a sentence (ending with . or ?): ");
    yylex();
    return 0;
}
