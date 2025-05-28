%option noyywrap

%{
#include "parser.tab.h"
#include <string>
#include <cstring>

using namespace std;
%}

digit           [0-9]
id              [a-zA-Z_][a-zA-Z0-9_]*
ws              [ \t\r]+
newline         \n

%%

"//".*                               
"/*"([^*]|\*+[^/])*"*"+"/"              
"int"           return INT;
"double"        return DOUBLE;
"const"         return CONST;
"constexpr"     return CONSTEXPR;
"&"             return REF;
"&&"            return RVALREF;
"*"             return STAR;
"("             return LPAREN;
")"             return RPAREN;
","             return COMMA;
";"             return SEMICOLON;
"["{digit}*"]"  return ARRAY;
{id}            return IDENTIFIER;
{ws}            ;           // ignoruj białe znaki
{newline}       return NEWLINE;
.               return INVALID;

%%
