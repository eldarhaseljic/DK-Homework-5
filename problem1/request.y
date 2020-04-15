%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE * yyin;
void yyerror(const char *);
int no_error = 1;
char * method;
char * url_line;
%}

%union 
{
	int ival;
	float fval;
	char * sval;
}

%token<sval> T_METHOD
%token FIELD_NAME
%token STRING;
%token<sval> URL
%token T_HTTP
%token<fval> T_FLOAT
%token<ival> T_INT
%token '\n'

%%

START : OBJECT  

OBJECT :  LINE STUFF;

STUFF : '\n' STUFF_NEXT	| ;

STUFF_NEXT : HEADER | ;

HEADER : PAIRS HEADER_NEXT | '\n';

HEADER_NEXT : '\n' | ;

PAIRS : PAIR '\n' PAIR_NEXT;

PAIR_NEXT : PAIRS | ;

PAIR : FIELD_NAME FIELD_VALUE ;

FIELD_VALUE : NUMBER | STRING;

LINE : T_METHOD  URL  T_HTTP { method = $1; url_line = $2;};

NUMBER : T_INT | T_FLOAT;

%%

int main ()
  {
          do{
          yyparse();
          }
          while(!feof(yyin));
          if(no_error)
                  printf("%s %s\n",method,url_line);
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

