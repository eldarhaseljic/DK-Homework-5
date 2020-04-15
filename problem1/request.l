%{
#include <stdio.h>
#include "request.tab.h"
%}

ws		[ \t]
ID     	 	[A-Z][a-zA-Z]+([-][A-Z][a-zA-Z]+)?[:]
string 		[a-zA-Z0-9.]+
url 		((\/[a-zA-Z]+(\/[a-zA-Z]+)+.[a-zA-Z]+)|(\/[a-zA-Z]+(\/[a-zA-Z]+)+)|(\/([a-zA-Z]+\/)+)|(\/[a-zA-Z]*))
num_int 	[0-9]+
num_float 	[0-9]+.[0-9]+
version 	(HTTP|HTTPS)\/[0-9]+.[0-9]+

%%

{ws}+	;
{num_float}  {yylval.fval = atof(yytext); return T_FLOAT;}
{num_int}     {yylval.ival = atoi(yytext); return T_INT;}
("GET"|"HEAD"|"POST"|"PUT"|"DELETE"|"OPTIONS")	{ yylval.sval = strdup(yytext);
							return T_METHOD; }
{version}	{ return T_HTTP; }
{ID}		{ return FIELD_NAME; }
{url}		{ yylval.sval = strdup(yytext);	return URL;}
{string}	{ return STRING;}
[\n]		{ return *yytext;  }

%%
