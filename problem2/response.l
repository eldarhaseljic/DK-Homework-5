%{

#include "response.tab.h"
#include <stdio.h>
%}

digit 		[0-9]
letter		[a-zA-Z]
code 		[1-5]{digit}{2}
status 		OK|([A-Z]{letter}+)
ID		[A-Z][a-zA-Z]+([-][A-Z][a-zA-Z]+)?[:]
string 		\"[a-zA-Z0-9\,\: \-]*\"
word		[a-z]{letter}+
type		word\/word
version 	(HTTP|HTTPS)\/[0-9]+.[0-9]+

%%

[ \t]			;
{version}	 	{return T_HTTPV;}
{code} 			{yylval.ival = atoi(yytext); return T_CODE;}
{status}		{yylval.sval = strdup(yytext); return T_STATUS;}
{ID}			{return FIELD_NAME;}
{string}		{return STRING;} 	
{word}			{return WORD;}	
[\n]			{return *yytext;}
{digit}+		{return NUMBER_INT;} 
{type}			{return TYPE;}
%%
