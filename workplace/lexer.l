%option noyywrap

%{
#include "parser.tab.h"
#include <string>
#include <cstring>

using namespace std;
%}

digit       [0-9]
id          [a-zA-Z_][a-zA-Z0-9_]*
ws          [ \t\r]+
newline     \n
%%

"//".*                            ; // skip single-line comments
"/*"([^*]|\*+[^/])*\*+"/"        ; // skip multi-line comments

"int"           return INT;
"char"          return CHAR;
"double"        return DOUBLE;
"*"             return STAR;
"("             return LPAREN;
")"             return RPAREN;
","             return COMMA;
";"             return SEMICOLON;
{id}            return IDENTIFIER;
{ws}            ;
{newline}       return NEWLINE;
.               return INVALID;

%%