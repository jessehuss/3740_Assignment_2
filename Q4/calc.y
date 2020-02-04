%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
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
     NUMBER { $$=std::to_string($1); }
| Expression PLUS Expression { $$=std::to_string($1) + " " + std::to_string($3) + " +"; }
| Expression MINUS Expression { $$=std::to_string($1) + " " +  std::to_string($3) + " -"; }
| Expression TIMES Expression { $$=std::to_string($1) + " " +  std::to_string($3) + " *"; }
| Expression DIVIDE Expression { $$=std::to_string($1) + " " +  std::to_string($3) + " /"; }
| MINUS Expression %prec NEG { $$=std::to_string($2) + " -"; }
| SQRT Expression { $$=std::to_string($2) + " sqrt"; }
| Expression POWER Expression { $$=std::to_string($1) + " " + std::to_string($3) + " ^"; }
| SIN Expression { $$=std::to_string($2) + " sin"; }
| COS Expression { $$=std::to_string($2) + " cos"; }
| TAN Expression { $$=std::to_string($2) + " tan"; }
| LEFT Expression RIGHT { $$="(" + std::to_string($2) + ")"; }
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
