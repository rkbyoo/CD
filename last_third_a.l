%{
#include<stdio.h>
%}

%%
[ab]*([a][ab][ab])$ {printf("yea this expression is having 3rd last a \n");}
[\n\t] {/*ignore this*/}
.* {printf("this is not the desired expresssion\n");}
%%

int main(){
	printf("enter the input :\n");
	yylex();
	return 0;
}


int yywrap(){
	return 1;
}
