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
    
     | Input Line
;

Line:
     END
     | Expression END { printf("Result: %f\n", $1); }
;

Expression:
     NUMBER { $$=$1; }
| Expression PLUS Expression { $1 $3 $2; }
| Expression MINUS Expression { $1 $3 $2; }
| Expression TIMES Expression { $1 $3 $2; }
| Expression DIVIDE Expression { $1 $3 $2; }
| MINUS Expression %prec NEG { $2 $1; }
| SQRT Expression { $2 $1; }
| Expression POWER Expression { $1 $3 $2; }
| SIN Expression { $2 $1; }
| COS Expression { $2 $1; }
| TAN Expression { $2 $1; }
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
