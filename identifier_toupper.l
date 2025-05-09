%{
#include<stdio.h>
#include<ctype.h>
int i;
%}

keyword main|int|scanf|printf|if|else

%option noyywrap

%%

{keyword}    { for(i=0;i<yyleng;i++) printf("%c",toupper(yytext[i])); }

%%

int main()
{
    yyin=fopen("numl.c","r");
    yylex();
    return 0;
}
