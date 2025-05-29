

%{
#include <iostream>
#include <cmath>
#include <cstdlib>
#include <stdio.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif


using namespace std;

void yyerror(const char* s);
int yylex();
int line_num = 1;
extern FILE* outfile;
%}

%union {
    double num;
    struct { double base; double exp; } pair;
}

%token <num> NUMBER
%token PLUS MINUS MULT DIV LPAREN RPAREN COMMA EQUALS NEWLINE
%token SQRT LOG POW SIN COS TAN
%token INVALID

%type <num> expr
%type <pair> args

%start input

%%

input:
    /* empty */
  | input line
;

line:
    expr EQUALS NEWLINE  { fprintf(outfile, "line %d: %g\n", line_num++, $1); }
  | expr EQUALS          { fprintf(outfile, "line %d: %g\n", line_num++, $1); }
  | error EQUALS NEWLINE { fprintf(outfile, "line %d: ERROR\n", line_num++); yyerrok; }
  | error NEWLINE        { fprintf(outfile, "line %d: ERROR\n", line_num++); yyerrok; }
;



expr:
      expr PLUS expr     { $$ = $1 + $3; }
    | expr MINUS expr    { $$ = $1 - $3; }
    | expr MULT expr     { $$ = $1 * $3; }
    | expr DIV expr      {
                            if ($3 == 0) {
                                yyerror("division by zero");
                                YYERROR;
                            } else {
                                $$ = $1 / $3;
                            }
                         }
    | MINUS expr         { $$ = -$2; }
    | LPAREN expr RPAREN { $$ = $2; }
    | NUMBER             { $$ = $1; }

    | SQRT LPAREN expr RPAREN { 
                                if ($3 < 0) {
                                    yyerror("sqrt of negative");
                                    YYERROR;
                                }
                                $$ = sqrt($3); 
                              }
    | LOG LPAREN expr RPAREN  { 
                                if ($3 <= 0) {
                                    yyerror("log of non-positive");
                                    YYERROR;
                                }
                                $$ = log($3); 
                              }
    | SIN LPAREN expr RPAREN  { $$ = sin($3 * M_PI / 180); }
    | COS LPAREN expr RPAREN  { $$ = cos($3 * M_PI / 180); }
    | TAN LPAREN expr RPAREN  { $$ = tan($3 * M_PI / 180); }

    | POW LPAREN args RPAREN  { $$ = pow($3.base, $3.exp); }

;

args: expr COMMA expr { $$.base = $1; $$.exp = $3; }

%%

void yyerror(const char* s) {
    cerr << "Syntax error in line " << line_num << ": " << s << endl;
}
