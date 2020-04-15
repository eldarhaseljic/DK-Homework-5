%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char *);
int no_error = 1;
int s_code;
char * status;
%}

%union
{
	int ival;
	char * sval;
}

%token  '\n'  
%token FIELD_NAME
%token<ival> T_CODE
%token STRING
%token WORD
%token NUMBER_INT
%token<sval> T_STATUS
%token T_HTTPV
%token TYPE
%%

START : OBJECT ;

OBJECT : LINE STUFF ;

STUFF :   '\n' STUFF_NEXT | ;

STUFF_NEXT : HEADER | ;

HEADER :  PAIRS HEADER_NEXT | '\n' ;

HEADER_NEXT : '\n' | ;

PAIRS : PAIR '\n' PAIR_NEXT ;

PAIR_NEXT : PAIRS | ;

PAIR : FIELD_NAME FIELD_VALUE;

FIELD_VALUE : T_STATUS | STRING | WORD | NUMBER_INT | T_CODE | TYPE;
 
LINE : T_HTTPV T_CODE T_STATUS { s_code = $2; status = $3;};

%%

int main ()
{
	do{
	yyparse();
	}
	while(!feof(yyin));
	if(no_error) 
		printf("%d %s\n",s_code,status); 	
	return 0;
}
int yywrap()
{
	return 1;
}

void yyerror(const char* s)
{
	no_error = 0;
	printf("Poruka nije tacna\n");
	return;
}
