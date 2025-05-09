%{
#include <stdio.h>
#include <stdlib.h>

int token; // Current token

int yylex();
void yyerror(const char *msg);
void match(int expected);
void S();
void Sp();  // S'
void E();
%}

%option noyywrap

%%

"i"     { return 'i'; }
"e"     { return 'e'; }
"t"     { return 't'; }
"a"     { return 'a'; }
"b"     { return 'b'; }
[ \t\n] ;    // Ignore whitespace
.       { return yytext[0]; }

%%

void match(int expected) {
    if (token == expected)
        token = yylex();
    else
        yyerror("Syntax Error");
}

void E() {
    if (token == 'b') {
        match('b');
    } else {
        yyerror("Expected 'b' in E");
    }
}

void Sp() {
    if (token == 'e') {
        match('e');
        S();
    }
    // else epsilon → do nothing
}

void S() {
    if (token == 'i') {
        match('i');
        E();
        match('t');
        S();
        Sp();
    } else if (token == 'a') {
        match('a');
    } else {
        yyerror("Syntax Error in S");
    }
}

void yyerror(const char *msg) {
    printf("%s\n", msg);
    exit(1);
}

int main() {
    printf("Enter input string/press ctrl+D:\n");
    token = yylex();  // Get first token
    S();              // Start parsing
    if (token == 0)
        printf("Input accepted.\n");
    else
        printf("Unexpected symbols after valid input.\n");
    return 0;
}


/*
S  → iEtSS' | a  
S' → eS | ε  
E  → b 
accepted->ibtaea
rejected->iba
  */

