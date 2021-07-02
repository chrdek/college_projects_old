%{
 #include <stdio.h>
 #include <math.h>
 int yylex(void); 
 void yyerror(char *);
 enum bool {false, true};
 int Boolvalue;
 int assigned;
 int sym[26];
%}


%token INTEGER
%token VAR
%left '+' '-'
%left '*' '/'

%%

input: input expr '\n'{printf("calc "); if (($2==true)&&(Boolvalue==100)) printf("true\n"); else if (($2==false)&&(Boolvalue==100)) printf("false\n"); else if (assigned==90) printf("\n"); else printf("%d\n",$2); Boolvalue=0; assigned=0;}
       |/* empty string */ ;

expr:	INTEGER

	|VAR { $$ = sym[$1]; }

	|expr '+' expr{ $$ = $1 + $3; }

	|expr '-' expr{ $$ = $1 - $3; }

	|expr '*' expr{ $$ = $1 * $3; }

	|expr '/' expr{if ($3) $$ = $1 / $3; else  { $$ = 1;
		fprintf (stderr, "Division by zero, Result set to 1\n");}}

	|'(' expr ')'{ $$ = $2; }

	|/* Square Root */
	'sqrt''(' expr ')'{ $$ = sqrt($3); }

	|expr '<' expr{ $$ = $1 < $3; Boolvalue= 100; }

	|expr '>' expr{ $$ = $1 > $3; Boolvalue= 100; }

	|expr '=''=' expr{ $$ = $1 == $4; Boolvalue= 100; }

	|expr '!''=' expr{ $$ = $1 != $4; Boolvalue= 100; }

	|/* Exponentiation */
	expr '^' expr{ $$ = pow($1, $3); }

	|/* Variable Assignment */
	VAR ':''=' expr{ sym[$1] = $4; assigned=90; }

	;
%%

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {printf("user "); yyparse();    return 0; }