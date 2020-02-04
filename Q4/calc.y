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
     | Expression END { printf("Result: %s\n", $1); }
;

Expression:
     NUMBER { printf("%d", $1); }
| Expression PLUS Expression { printf("%d %d +",$1, $3); }
| Expression MINUS Expression { printf("%d %d -",$1, $3); }
| Expression TIMES Expression { printf("%d %d *",$1, $3); }
| Expression DIVIDE Expression { printf("%d %d /",$1, $3); }
| MINUS Expression %prec NEG { printf("%d -", $2); }
| SQRT Expression { printf("%d sqrt", $2); }
| Expression POWER Expression { printf("%d %d ^",$1, $3); }
| SIN Expression { printf("%d sin", $2); }
| COS Expression { printf("%d cos", $2); }
| TAN Expression { printf("%d tan", $2); }
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
