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
     | Expression END { printf("\n"); }
;

Expression:
     NUMBER { printf("%d", yyval) }
| Expression PLUS Expression { printf("+") }
| Expression MINUS Expression { printf("-") }
| Expression TIMES Expression { printf("*") }
| Expression DIVIDE Expression { printf("/") }
| MINUS Expression %prec NEG { printf("-") }
| SQRT Expression { printf("sqrt") }
| Expression POWER Expression { printf("^") }
| SIN Expression { printf("sin") }
| COS Expression { printf("cos") }
| TAN Expression { printf("tan") }
| LEFT Expression RIGHT
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