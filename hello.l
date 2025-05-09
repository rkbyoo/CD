%{
 #include<stdio.h>
%}

%%


begin {printf("started");}
hello {printf("hello rohit");}
thanks {printf("you are welcome");}
morning {printf("good morning");}
end {printf("stopped");}

%%

int yywrap(){
	return 1;
}
int main(){
	yylex();
	return 0;
}
