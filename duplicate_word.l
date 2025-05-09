

%{
#include<stdio.h>
#include<string.h>
char prev_word[100]="";
%}

%%
[a-zA-Z0-9]+ {if(strcmp(prev_word,yytext)==0){
		printf("duplicate word detected:%s \n",prev_word);
		}
		strcpy(prev_word,yytext);
	}

[.\n\t] {/*ignore it*/}

%%



int main(){
	printf("enter the sentence to check for duplicate words:\n");
	yylex();
	return 0;
}


int yywrap(){
	return 1;
}

