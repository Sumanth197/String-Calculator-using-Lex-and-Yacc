%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
%}


%token VAL 
  
         
%left   '*' '%' '&' '~' '@' '#' '=' '!'
%right  '?' '^'
%left   '(' ')'
%union {

char* strval;
int intval;
}

%start final
%type <strval>A
%type <strval>final
%type <strval>VAL


%%


final     :     A {$$=$1;printf("%s\n",$$);}
	  ;
 	
A     : VAL {$$=$1;}
	
	
	| '(' A ')'{
			$$=$2;
			
		}

	
	| '?' A {
			char* s1=malloc(sizeof(char)*(strlen($2)));
			int i;
			strcpy(s1,$2);
			char* s2=malloc(sizeof(char)*(strlen($2)));
			sprintf(s2,"%d",strlen($2));
			$$=s2;
			//printf("%s\n",$$);
			
		  }


	| A '^' A {
			int num=atoi($3);
			char* s=malloc(sizeof(char)*(strlen($1)*(num)));
			int i;
			strcpy(s,$1);
			for(i=1;i<num;i++)
			{
				strcat(s,$1);
			}
			$$=s;
			//printf("%s\n",$$);
			}

	|A '*' A {
		
			  char* s=malloc(sizeof(char)*(strlen($1)+strlen($3)+1));
                          strcpy(s,$1);
			  strcat(s,$3);
                          $$=s;
			//printf("%s\n",$$);
		}


	| A '~' A { 
			
			char result[]="true"; 
			char* s1=malloc(sizeof(char)*(strlen($1)));
			strcpy(s1,$1);
			char* s2=malloc(sizeof(char)*(strlen($3)));
			strcpy(s2,$3);
			int len=strlen($1);
			int i;		
			for(i=0;i<len;i++)
			{
				if(s1[i]!=s2[i])
				{
					strcpy(result,"false");
					break;
				}
			}
			$$=result;
			//printf("%s\n",$$);
			 }


	| A '@' A  {
			
			char* s1=malloc(sizeof(char)*(strlen($1)));
			strcpy(s1,$1);
			char* s2=malloc(sizeof(char)*(strlen($3)));
			strcpy(s2,$3);
			int len1=strlen($1);
			int len2=strlen($3);
			int i,j;
			char result[]="true";
			for(i=len2-1,j=len1-1;j>=0;i--,j--)
			{
				if(s1[j]!=s2[i])
				{
					strcpy(result,"false");
					break;
				}
			}
			$$=result;
			//printf("%s\n",$$);
			}
	| A '#' A {
			
			char* s1=malloc(sizeof(char)*(strlen($1)));
			strcpy(s1,$1);
			char* s2=malloc(sizeof(char)*(strlen($3)));
			strcpy(s2,$3);
			int i,j,k,h;
			int count=0;
			char temp[100];
			int len1=strlen($1);
			int len2=strlen($3);
			char result[]="false";	
			for(i=0;s2[i]!='\0';i++)
			{
				for(j=i;s2[j]!='\0';j++)
				{
					for(k=i,h=0;k<=j;k++,h++)
					{
						temp[h]=s2[k];
					}
					temp[h]='\0';
					if(strcmp(temp,s1)==0)
					{
						strcpy(result,"true");
						count=1;
						break;
					}			
				}
				if(count==1)
					break;
			}
			$$=result;
			//printf("%s\n",$$);			
			}
	| A '=' A {
			char result[]="false";
			char* s1=malloc(sizeof(char)*(strlen($1)));
			strcpy(s1,$1);
			char* s2=malloc(sizeof(char)*(strlen($3)));
			strcpy(s2,$3);
			if(strcmp(s1,s2)==0)
			{
			     strcpy(result,"true");
			}
			$$=result;
			//printf("%s\n",$$);
			}
	| A '!' A {
			char result[]="true";
			char* s1=malloc(sizeof(char)*(strlen($1)));
			strcpy(s1,$1);
			char* s2=malloc(sizeof(char)*(strlen($3)));
			strcpy(s2,$3);
			if(strcmp(s1,s2)==0)
			{
			     strcpy(result,"false");
			}
			$$=result;
			//printf("%s\n",$$);
			}
	
	
	 | A '&' A {
			int num=atoi($3);
			char* s=malloc(sizeof(char)*(num));
			char* s1=malloc(sizeof(char)*(strlen($1)));
			int i,j;
			int len=strlen($1);
			strcpy(s1,$1);
			for(i=len-num,j=0;i<len;i++,j++)
			{
				s[j]=s1[i];
			}
			$$=s;
			//printf("%s\n",$$);
			}
	
	| A '%' A {
			int num=atoi($3);
			char* s=malloc(sizeof(char)*(num));
			char* s1=malloc(sizeof(char)*(strlen($1)));
			int i;
			strcpy(s1,$1);
			for(i=0;i<num;i++)
			{
				s[i]=s1[i];
			}
			$$=s;
			//printf("%s\n",$$);	
			}
	
	
	
	
	
	;


%%
main()
{
	printf("Give Expression\n");	
	yyparse();	
}    

yywrap()
{

}
yyerror()
{
	printf("Error Raised\n");
}
