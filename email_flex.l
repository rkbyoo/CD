%{
#include<stdio.h>
%}

%%

[a-z0-9_.]+[@][a-z0-9]+[.][a-z]{2,4}$ {printf("This is a valid email id");}
. {/* ignore */}

%%


int yywrap(){
	return 1;
}

int main(){
	printf("enter the email:\n");
	yylex();
	return 0;
}
