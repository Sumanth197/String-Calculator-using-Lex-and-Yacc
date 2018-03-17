%{
#include<stdio.h>
#include "y.tab.h"
#include<math.h>
#include<string.h>

%}

%%

[ ]+ {}
[&] {return '&';}
[=] {return '=';}
[?] {return '?';}
[#] {return '#';}
[~] {return '~';}
[%] {return '%';}
[*] {return '*';}
"<>" {return '!';}
"^" {return '^';}
[@] {return '@';}



[0-9]+  	{yylval.intval=strdup(yytext);
			return VAL;}

[a-zA-Z]+  	{yylval.strval=strdup(yytext); 
			return VAL;}

[\n] 		{return 0;}
. 		{return yytext[0];}


%%


