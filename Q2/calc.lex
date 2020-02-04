%{
#define YYSTYPE double
#include "calc.tab.h"
#include <stdlib.h>
%}

white [ \t]+
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer})?{exponent}?

%%

{white} { }
{real} { yylval=atof(yytext); 
 return NUMBER;
}

"+" return PLUS;
"-" return MINUS;
"*" return TIMES;
"/" return DIVIDE;
"sin" return SIN;
"cos" return COS;
"tan" return TAN;
"sqrt" return SQRT;
"^" return POWER;
"(" return LEFT;
")" return RIGHT;
"\n" return END;
