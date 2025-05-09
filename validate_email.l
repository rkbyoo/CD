%{
#include<stdio.h>
%}


%%
[a-z_]+[@][a-z0-9]+\.[a-z]{2,3}$ {printf("this is a valid email\n"); return 0;}
[\n\t] {/*ignore*/}
. {printf("this is not valid email"); return 0;}

%%

int main(){
	printf("enter the email:\n");
	yylex();
	return 0;
}


int yywrap(){
	return 1;
}	
