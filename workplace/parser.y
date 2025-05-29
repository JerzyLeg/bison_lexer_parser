%{
#include <iostream>
#include <string>
using namespace std;

void yyerror(const char* s);
int yylex();
int line_num = 1;
%}

%token INT CHAR DOUBLE STAR LPAREN RPAREN COMMA SEMICOLON IDENTIFIER INVALID NEWLINE

%%

input:
    /* empty */
  | input line
;

line:
    declaration SEMICOLON NEWLINE   { cout << "line " << line_num++ << ": OK" << endl; }
  | error NEWLINE                   { cout << "line " << line_num++ << ": ERROR" << endl; yyerrok; }
  | NEWLINE                         { line_num++; }
;

declaration:
    type pointer_opt IDENTIFIER                 // variable declaration
  | type pointer_opt IDENTIFIER LPAREN parameter_list_opt RPAREN // function prototype
;

type:
      INT
    | CHAR
    | DOUBLE
;

pointer_opt:
    /* empty */
  | STAR pointer_opt
;

parameter_list_opt:
    /* empty */              // () allowed
  | parameter_list
;

parameter_list:
    parameter
  | parameter_list COMMA parameter
;

parameter:
    type pointer_opt IDENTIFIER // parameter must have type and name
;

%%

void yyerror(const char* s) {
    // Custom error handler (if needed)
}
