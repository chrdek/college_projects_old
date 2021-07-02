%{    
 #include "y.tab.h"
 #include <stdlib.h>
 #include <stdio.h>
 void yyerror(char *);
%}

DIGIT  [0-9]
OP  [-+*<>/\n]
ASSIGN_VARS [A-Za-z]
SPACE [ \t]

%%
{DIGIT}+			{ yylval = atoi(yytext); return INTEGER; }

{OP}				{ return *yytext; }

{ASSIGN_VARS}			{ yylval = *yytext - 'a'; return VAR; }

":"|"!"|"="|"("|")"|"^"		{ return *yytext; }

sqrt				{ return *yytext; }

{SPACE}+		        ;/* skip whitespace */

.				{ yyerror("Error in character!"); }
%%

int yywrap(void) {    return 1;}
