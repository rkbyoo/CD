%{

#include<stdio.h>
%}


digit [0-9#@%&*]
letter [_a-zA-Z]


%%
{letter}({letter}|{digit})* {printf("this is identifier");}
{digit}{letter}* {printf("this is not identifier");}

[.\n] {/*ignore*/}

%%


int yywrap(){
return 1;
}


int main(){
	printf("enter the identifier:\n");
	yylex();
	return 0;
}
