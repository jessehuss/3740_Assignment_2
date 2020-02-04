%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE SQRT POWER SIN COS TAN
%token LEFT RIGHT
%token END

%left PLUS MINUS
%left TIMES DIVIDE
%left NEG
%left SQRT
%right POWER
%left SIN COS TAN
%start Input
%%

Input:
    %empty
| Input Line
;

Line:
     END
     | Expression END { printf("Result: %f\n", $1); }
;

Expression:
     NUMBER { $$=$1; }
| Expression Expression PLUS  { $$=$1+$2; }
| Expression Expression MINUS { $$=$1-$2; }
| Expression Expression TIMES { $$=$1*$2; }
| Expression Expression DIVIDE { $$=$1/$2; }
| Expression %prec MINUS NEG { $$=-$1; }
| Expression SQRT { $$=sqrt($1); }
| Expression Expression POWER { $$=pow($1,$2); }
| Expression SIN { $$=sin($1); }
| Expression COS { $$=cos($1); }
| Expression TAN { $$=tan($1); }
| LEFT Expression RIGHT { $$=$2; }
;

%%

int yyerror(char *s) {
  printf("%s\n", s);
}

int main() {
  if (yyparse())
     fprintf(stderr, "Successful parsing.\n");
  else
     fprintf(stderr, "error found.\n");
}