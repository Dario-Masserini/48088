%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int Dibujar=0, Recursion=0,MaxRecursion;
char *Lexema[100], *Token[100];
int SubIndice=0, SubIndiceMax, NumLineas=1, EstadoScanner=0;
%}

%token COMENTARIO BOOLEANO IDE NL BOOLEANEXPRESION PCOMA DP IDENT NUM EXIT
%%

Assertion : HELP NL     {printf("*** LA CADENA ES VALIDA ***"); tablahelp(); arbolacion(); yyparse();}
            | EXIT NL        {yywrap();}
;

HELP : HELP PCOMA ASSERTIONCLAUSE  
     | ASSERTIONCLAUSE
     ;

ASSERTIONCLAUSE : UNLABELEDASSERTIONCLAUSE               
                | TANGMARK UNLABELEDASSERTIONCLAUSE       
                ;

UNLABELEDASSERTIONCLAUSE: BOOLEANO 
                        | COMENTARIO 
                        ;

TANGMARK : TAG DP      
          ;

TAG : IDE         
    ;

%%
int yyerror(char *msg) {
   erroruno();
 system("pause");
     return;
}

int main() {
     printf("\nIngrese la cadena:\n");
     yyparse();
     system("pause");
}



void erroruno(){
	int x=0;
	
	if(!strcmp(Lexema[x], "booleano") || !strcmp (Lexema[x], "comentario" ) ){
		x++;
		if(!strcmp(Lexema[x], ";")){printf("ERROR: LA CADENA DEBE TERMINAR EN 'booleano' o 'comentario'\n"); }
		
			x++;
			if(Lexema[x]=='\0'){ 
			if(!strcmp(Lexema[x], "booleano") || !strcmp(Lexema[x], "comentario")){
				
			} else{ 
				printf("ERROR: LA CADENA DEBE TERMINAR EN 'booleano' o 'comentario'\n"); 
			}
		} else{ 
			printf("ERROR: DESPUES DE 'booleano' O 'comentario' DEBE ESCRIBIRSE ';'\n");
		}
	} else {
		
	}
	if(!strcmp(Lexema[x], "id")){
		x++;
		if(!strcmp(Lexema[x], ":")){
			x++;
			if(Lexema[x]=='\0'){printf("ERROR: LA CADENA DEBE TERMINAR EN 'booleano' o 'comentario'"); }
			if(!strcmp(Lexema[x], "booleano") || !strcmp(Lexema[x], "comentario")){
				x++;
			} else{printf ("ERROR: DESPUES DE ':' SE ESCRIBE 'booleano' O 'comentario'\n");}
		}else{printf ("ERROR: DESPUES DE 'id' SE ESCRIBE ':'\n");}
	}
	if(!strcmp(Lexema[x], "booleano") || !strcmp (Lexema[x], "comentario" ) || !strcmp (Lexema[x], "comentario" ) ){
		
	}else {printf("ERROR: LA CADENA DEBE EMPEZAR EN 'id', 'booleano' o 'comentario'\n"); }
}


int yywrap() {
	printf("El analisis ha concluido\n");
	return 0;
}
