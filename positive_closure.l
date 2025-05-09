%{

#include<stdio.h>
%}


%%

a+ {printf("pattern Matched:%s\n",yytext);}
. {/*ignore the other things */}
\n { return 0;}

%%

int yywrap(){
 return 1;
}


int main(){
	printf("Enter the input:");
	yylex();

	return 0;
}
