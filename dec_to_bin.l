%{
#include <stdio.h>
#include <stdlib.h>

void print_binary(int n) {
    if (n == 0) {
        printf("0");
        return;
    }
    char bin[32];
    int i = 0;
    while (n > 0) {
        bin[i++] = (n % 2) + '0';
        n /= 2;
    }
    for (int j = i - 1; j >= 0; j--)
        putchar(bin[j]);
    printf("\n");
}
%}

%%
[0-9]+    { print_binary(atoi(yytext)); }
.|\n      { /* ignore other input */ }
%%

int main() {
    yylex();
    return 0;
}

