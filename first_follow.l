%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX_PROD 50
char productions[MAX_PROD][20];
int count = 0;
%}

%%

[A-Z]->.*   { strcpy(productions[count++], yytext); }
\n          { /* ignore */ }
.           { /* ignore */ }

%%

int yywrap() { return 1; }

char first[26][20], follow[26][20];
int is_nt[26] = {0};

void add(char set[], char c) {
    if (!strchr(set, c)) {
        int len = strlen(set);
        set[len] = c;
        set[len + 1] = '\0';
    }
}

int main() {
    printf("Enter grammar (e.g., E->E+T). One per line. Ctrl+D to end:\n");
    yylex();

    // Mark non-terminals
    for (int i = 0; i < count; i++)
        is_nt[productions[i][0] - 'A'] = 1;

    // Compute FIRST
    int changed;
    do {
        changed = 0;
        for (int i = 0; i < count; i++) {
            char nt = productions[i][0] - 'A';
            char* rhs = productions[i] + 3;
            if (!rhs[0]) { // Epsilon
                if (!strchr(first[nt], '#')) add(first[nt], '#'), changed = 1;
                continue;
            }
            char sym = rhs[0];
            if (!isupper(sym)) { // Terminal
                if (!strchr(first[nt], sym)) add(first[nt], sym), changed = 1;
            } else { // Non-terminal
                int sym_nt = sym - 'A';
                for (int j = 0; first[sym_nt][j]; j++)
                    if (first[sym_nt][j] != '#' && !strchr(first[nt], first[sym_nt][j]))
                        add(first[nt], first[sym_nt][j]), changed = 1;
            }
        }
    } while (changed);

    // Compute FOLLOW
    add(follow[productions[0][0] - 'A'], '$'); // Start symbol gets $
    do {
        changed = 0;
        for (int i = 0; i < count; i++) {
            char nt = productions[i][0] - 'A';
            char* rhs = productions[i] + 3;
            for (int j = 0; rhs[j]; j++) {
                if (isupper(rhs[j])) {
                    int curr_nt = rhs[j] - 'A';
                    char next = rhs[j + 1];
                    if (next && !isupper(next)) { // Terminal follows
                        if (!strchr(follow[curr_nt], next)) add(follow[curr_nt], next), changed = 1;
                    } else if (!next) { // End of production
                        for (int k = 0; follow[nt][k]; k++)
                            if (!strchr(follow[curr_nt], follow[nt][k]))
                                add(follow[curr_nt], follow[nt][k]), changed = 1;
                    }
                }
            }
        }
    } while (changed);

    // Print FIRST
    printf("\nFIRST sets:\n");
    for (int i = 0; i < 26; i++)
        if (is_nt[i]) {
            printf("FIRST(%c) = { ", 'A' + i);
            for (int j = 0; first[i][j]; j++) {
                if (first[i][j] == '#') {
                    printf("ε");
                } else {
                    printf("%c", first[i][j]);
                }
                if (first[i][j + 1]) printf(", ");
            }
            printf(" }\n");
        }

    // Print FOLLOW
    printf("\nFOLLOW sets:\n");
    for (int i = 0; i < 26; i++)
        if (is_nt[i]) {
            printf("FOLLOW(%c) = { ", 'A' + i);
            for (int j = 0; follow[i][j]; j++) {
                printf("%c", follow[i][j]);
                if (follow[i][j + 1]) printf(", ");
            }
            printf(" }\n");
        }

    return 0;
}





















/*
E->E+T
E->T
T->T*F
T->F
F->(E)
F->a
FIRST sets:
FIRST(E) = { (, a }
FIRST(F) = { (, a }
FIRST(T) = { (, a }

FOLLOW sets:
FOLLOW(E) = { $, +, ) }
FOLLOW(F) = { $, +, *, ) }
FOLLOW(T) = { $, +, *, ) }
*/
