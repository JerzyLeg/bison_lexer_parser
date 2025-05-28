%option noyywrap

%{
#include "parser.tab.h"
#include <string>
#include <cstring>
%}

digit       [0-9]
id          [a-zA-Z_][a-zA-Z0-9_]*
ws          [ \t\r]+
newline     \n

%%

"int"           return INT;
"float"         return FLOAT;
"double"        return DOUBLE;
"string"        return STRING;
"const"         return CONST;
"constexpr"     return CONSTEXPR;
"="             return ASSIGN;
";"             return SEMICOLON;
"*"             return STAR;
"+"             return PLUS;
"-"             return MINUS;
"/"             return DIV;
"("             return LPAREN;
")"             return RPAREN;

{digit}+        return NUMBER;
[0-9]+(\.[0-9]+)?    return NUMBER;
{id}            return IDENTIFIER;

{ws}            ; // ignore whitespace
{newline}       return NEWLINE;

.               return INVALID;

%%