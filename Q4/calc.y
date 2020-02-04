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
     NUMBER { printf("%d", $1); }
| Expression PLUS Expression { printf("%d %d %s",$1, $3, $2); }
| Expression MINUS Expression { printf("%d %d %s",$1, $3, $2); }
| Expression TIMES Expression { printf("%d %d %s",$1, $3, $2); }
| Expression DIVIDE Expression { printf("%d %d %s",$1, $3, $2); }
| MINUS Expression %prec NEG { printf("%d %s", $2, $1); }
| SQRT Expression { printf("%s %d", $2, $1); }
| Expression POWER Expression { printf("%d %d %s",$1, $3, $2); }
| SIN Expression { printf("%s %d", $2, $1); }
| COS Expression { printf("%s %d", $2, $1); }
| TAN Expression { printf("%s %d", $2, $1); }
| LEFT Expression RIGHT { printf("(%d)", $2); }
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
