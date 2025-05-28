%{
#include <iostream>
#include <string>
using namespace std;

int yylex();
void yyerror(const char* s);
%}

%token INT FLOAT DOUBLE STRING CONST CONSTEXPR STAR ASSIGN SEMICOLON IDENTIFIER NUMBER NEWLINE INVALID
%token PLUS MINUS DIV LPAREN RPAREN

%%

input:
    /* empty */
  | input line
;

line:
    declaration SEMICOLON NEWLINE    { cout << "OK" << endl; }
  | error NEWLINE                    { cout << "ERROR" << endl; yyerrok; }
  | NEWLINE                          { /* pusta linia */ }
;

declaration:
    modifiers type pointer_opt IDENTIFIER initializer_opt
;

modifiers:
      /* empty */
    | modifier modifiers
;

modifier:
      CONST
    | CONSTEXPR
;

type:
      INT
    | FLOAT
    | DOUBLE
    | STRING
;

pointer_opt:
      /* empty */
    | pointer_opt STAR
;

initializer_opt:
      /* empty */
    | ASSIGN expression
;

expression:
      NUMBER
    | IDENTIFIER
    | expression PLUS expression
    | expression MINUS expression
    | expression DIV expression
    | LPAREN expression RPAREN
;

%%

void yyerror(const char* s) {
}
