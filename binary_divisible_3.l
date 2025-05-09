%{
#include <stdio.h>
int state; // Represent the remainder (mod 3)
%}

%%

[01]+ {
    state = 0; // Reset the state for each new binary number
    for (int i = 0; yytext[i]; i++) {
        char bit = yytext[i];
        // Handle the DFA transitions for binary digits
        if (bit == '0') {
            if (state == 0) state = 0;
            else if (state == 1) state = 2;
            else if (state == 2) state = 1;
        } else if (bit == '1') {
            if (state == 0) state = 1;
            else if (state == 1) state = 0;
            else if (state == 2) state = 2;
        }
    }

    // If the state is 0, the binary number is divisible by 3
    if (state == 0)
        printf("Accepted: %s is divisible by 3\n", yytext);
    else
        printf("Rejected: %s is not divisible by 3\n", yytext);
}

.|\n ; // Ignore any non-binary input

%%

int main() {
    printf("Enter a binary number:\n");
    yylex();  // Read and process input
    return 0;
}

int yywrap() {
    return 1;
}

