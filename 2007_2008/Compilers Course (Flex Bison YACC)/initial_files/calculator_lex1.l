%{    
 #include "y.tab.h"
 #include <stdlib.h>
 #include <stdio.h>
 void yyerror(char *);
%}

DIGIT  [0-9]
OP  [-+*<>/]
ASSIGN_VARS [A-Za-z]
SPACE [ \t]

%%
{DIGIT}+				{ yylval = atoi(yytext); return INTEGER; }

[-+*\n]					{return *yytext;}

.					{yyerror("Error in character!");}
%%

int yywrap(void) {    return 1;}

