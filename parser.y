%{
#include <iostream>
#include <string>

using namespace std;

void yyerror(const char* s);
int yylex();
int line_num = 1;
%}

%token INT DOUBLE CONST CONSTEXPR REF RVALREF STAR LPAREN RPAREN COMMA SEMICOLON ARRAY IDENTIFIER INVALID NEWLINE

%%

input:
    /* empty */
  | input line
;

line:
    function_header SEMICOLON NEWLINE { cout << "line " << line_num++ << ": OK" << endl; }
  | error NEWLINE                     { cout << "line " << line_num++ << ": ERROR" << endl; yyerrok; }
  | NEWLINE                           { line_num++; /* pusta linia */ }
;

function_header:
    type pointer_opt ref_opt IDENTIFIER LPAREN parameter_list_opt RPAREN
;

type:
    modifiers base_type modifiers
;

modifiers:
      /* empty */
    | modifier modifiers
;

modifier:
      CONST
    | CONSTEXPR
;

base_type:
      INT
    | DOUBLE
    | IDENTIFIER     // np. "constexp"
;

pointer_opt:
    /* empty */
  | pointer_opt STAR
;

ref_opt:
    /* empty */
  | REF
  | RVALREF
;

parameter_list_opt:
    /* empty */
  | parameter_list
;

parameter_list:
    parameter
  | parameter_list COMMA parameter
;

parameter:
    type pointer_opt ref_opt IDENTIFIER_opt array_opt
;

IDENTIFIER_opt:
    /* empty */
  | IDENTIFIER
;

array_opt:
    /* empty */
  | ARRAY
;

%%

void yyerror(const char* s) {
    //cerr << "Syntax error in line " << line_num << ": " << s << endl;
}
