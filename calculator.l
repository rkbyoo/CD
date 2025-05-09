%{
#include <stdio.h>
#include <stdlib.h>

int num1 = 0, num2 = 0;
char op = 0;
%}

%%

[0-9]+      {
                if (num1 == 0)
                    num1 = atoi(yytext);
                else
                    num2 = atoi(yytext);
            }

[+\-*/]     { op = yytext[0]; }

\n          {
                int result = 0;
                switch(op) {
                    case '+': result = num1 + num2; break;
                    case '-': result = num1 - num2; break;
                    case '*': result = num1 * num2; break;
                    case '/': result = num1 / num2; break;
                    default: printf("Invalid operator\n"); return 1;
                }
                printf("Result: %d\n", result);
                return 0;
            }

.           { /* Ignore other characters */ }

%%

int main() {
    printf("Enter a simple expression (e.g., 3+4) and press Enter:\n");
    yylex();
    return 0;
}

