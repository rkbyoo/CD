%{
#include<stdio.h>
%}

%%
[0-9]+ ECHO;      //matches the number and print them
[a-zA-Z]+ ECHO;   //matches the words and prints them
[\t\n]+ ;        //ignores the tab and newlines
. ;              //ignores everything else
%%

int yywrap(){
	return 1;
}


int main(){
 	yylex();
	return 0;
}
