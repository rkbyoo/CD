%{
#include <stdio.h>
int count = 0;
int invalid = 0;
%}

%%

"("     { count++; }
")"     {
            count--;
            if (count < 0) {
                invalid = 1;
            }
        }
.       { /* ignore other characters */ }
\n      { return 0; }  // stop on newline

%%

int main() {
    printf("Enter a string:\n");
    yylex();

    if (count == 0 && invalid == 0)
        printf("The parentheses are well-formed.\n");
    else
        printf("The parentheses are not well-formed.\n");

    return 0;
}

