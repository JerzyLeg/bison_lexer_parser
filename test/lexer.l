%option noyywrap

%{
#include "parser.tab.h"
#include <cmath>
#include <cstring>
%}

DIGIT      [0-9]
ID         [a-zA-Z_][a-zA-Z0-9_]*
WS         [ \t]+

%%

"pi"                { yylval.num = M_PI; return NUMBER; }


"sqrt"              return SQRT;
"log"               return LOG;
"pow"               return POW;
"sin"               return SIN;
"cos"               return COS;
"tan"               return TAN;



{DIGIT}+("."{DIGIT}+)?   { yylval.num = atof(yytext); return NUMBER; }

"+"                 return PLUS;
"-"                 return MINUS;
"*"                 return MULT;
"/"                 return DIV;
"="                 return EQUALS;
"("                 return LPAREN;
")"                 return RPAREN;
","                 return COMMA;
\n                  return NEWLINE;

{WS}                ;   // ignoruj białe znaki

.                   return INVALID;

%%
