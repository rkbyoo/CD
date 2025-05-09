%{
#include <stdio.h>
int vowel=0;
%}

%%

[aAeEiIoOuU]+   { printf("The word contains vowels: %s\n", yytext); vowel++; }  // Action when a vowel is found
[^aAeEiIoOuU\n]+   { printf("The word does not contain vowels: %s\n", yytext); }  // Action when a word has no vowels
[.\n] {/*ignore*/}
%%

int yywrap(){
return 1;
}

int main() {

    yylex();  // Calls the lexer to process the input
    printf("The number of vowels are:%d",vowel);
    return 0;
}

