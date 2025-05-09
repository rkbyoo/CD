%{
#include<stdio.h>
%}

%%

[a-z] {printf("lowercase");}
[A-Z] {printf("uppercase");}
[a-zA-Z]+ {printf("word");}
[0-9]+ {printf("number");}
[0-9]+\.[0-9]+ {printf("float");}
";" {printf("semicolon");}
"(" {printf("open parenthesis");}
")" {printf("cloe parenthesis");}
[ \t\n]  { /* ignore whitespace */ }

%%

int yywrap(){
return 1;
}

int main(){
	yylex();
	return 0;
}
