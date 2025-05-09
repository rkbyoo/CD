%{
#include <stdio.h>
int is_palindrome(char *s, int len);
%}

%%

[a-z]+    { if (is_palindrome(yytext, yyleng))
		 {printf("this is plaindrome");} 
	    else{
		printf("this is not palindrome");
}		
 }
[ \t\n]+  ;  /* ignore whitespace */
.         ;  /* ignore other characters */

%%

int is_palindrome(char *s, int len) {
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - 1 - i]) {
            return 0;
        }
    }
    return 1;
}

int main() {
    yylex();
    return 0;
}
