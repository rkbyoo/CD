%{
#include <stdio.h>
#include <stdlib.h>

// Define states
#define q0 0  // Initial state
#define q1 1  // State after reading '1'
#define q2 2  // State after reading '10'
#define q3 3  // State after reading '11'
#define q4 4  // Accepting state (found '101' or '110')

// Current state of the automaton
int state = q0;  

// Function to reset the state machine
void reset_state() {
    state = q0;
}

// Function to check if we are in an accepting state
void check_acceptance() {
    if (state == q4) {
        printf("String contains '101' or '110'.\n");
    } else {
        printf("String does not contain '101' or '110'.\n");
    }
}
%}

%%

"1"   {
        if (state == q0) state = q1;   // From q0 -> q1 (start of "101" or "110")
        else if (state == q1) state = q3;  // From q1 -> q3 (start of "11")
        else if (state == q2) state = q4;  // From q2 -> q4 (found "101")
        else if (state == q3) state = q3;  // From q3 -> q3 (stay in q3, "110" is still in progress)
      }

"0"   {
        if (state == q0) state = q0;   // Stay in q0 if we haven't found "101" or "110"
        else if (state == q1) state = q2; // From q1 -> q2 (start of "10")
        else if (state == q2) state = q2; // Stay in q2, still looking for the last "1" of "101"
        else if (state == q3) state = q4; // From q3 -> q4 (found "110")
      }

[ \t\n\r]+ { /* Ignore spaces, tabs, and newlines */ }

. { /* Ignore any invalid characters */ }

%%

int main() {
    printf("Enter a binary string: ");
    
    // Read the input string
    char input_string[100];
    fgets(input_string, sizeof(input_string), stdin);
    
    // Remove the newline character if present
    input_string[strcspn(input_string, "\n")] = 0;
    
    // Process the input using Lex
    yy_scan_string(input_string);
    yylex();  // Start Lex scanning
    
    // Check if the final state is accepting
    check_acceptance();

    return 0;
}
