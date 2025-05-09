%%

^[ ]*\n
\n {ECHO; yylineno++;}
.* {printf("d\t%d\t%s\n", yylineno,yytext);}
%%

int yywrap()
{
return 1;
}


int main(){	
	yylineno=1;
	yylex();
	return 0;
}
