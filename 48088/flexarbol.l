%{

#include <stdio.h>
#include <string.h>
#include "Sintactica.tab.h"
extern char *Lexema[100], *Token[100];
int ntok=0, numterms=0, npc=0, ndp=0, nbool=0, nide=0, ncom=0;
extern int SubIndice, SubIndiceMax, NumLineas;
%}

%option noyywrap
separador ([ \t])+
digito [0-9]
num {digito}({digito})*
letra [a-zA-Z]
ident {letra}({digito}|{letra})*
%%

";"          {npc++; CargarSubCadenas("PCOMA"); return PCOMA;}
":"          {ndp++; CargarSubCadenas("DP"); return DP;}
"booleano"      {nbool++;  CargarSubCadenas("BOOLEANO"); return (BOOLEANO);}
"comentario"    {ncom++; CargarSubCadenas("COMENTARIO"); return (COMENTARIO);}
"id"    {nide++; CargarSubCadenas("IDE"); return IDE;}
"\n"  {return (NL);}
{num}	    {
		CargarSubCadenas("NUM");
		return (NUM);}
{ident}	    {
		CargarSubCadenas("IDENT");
		return (IDENT);}


%%


int CargarSubCadenas(char* NomToken){
	Lexema[SubIndice]=(char*)malloc((strlen(yytext)+1)*sizeof(char));
	strcpy(Lexema[SubIndice],yytext);
	Token[SubIndice]=(char*)malloc((strlen(NomToken)+1)*sizeof(char));
	strcpy(Token[SubIndice],NomToken);
	SubIndice++;
	return 0;
}

int tablahelp() {
printf("\n===============================TABLA DE SIMBOLOS===============================\n");
	printf("|                LEXEMAS               |                 TOKENS               |\n");
	printf("---------------------------------------+---------------------------------------\n");
	if (nide>0) printf("|                   id                 |               IDE                    |\n");
	if (ndp>0) printf("|                   :                  |               PCOMA                  |\n");
	if (npc>0) printf("|                   ;                  |               PCOMA                  |\n");
	if (nbool>0) printf("|                booleano              |               BOOLEANO               |\n");
	if (ncom>0) printf("|               comentario             |              COMENTARIO              |\n");
	printf("===============================================================================\n\n\n");
} 

int arbolacion() {
	printf("\n===========================ARBOL DE DERIVACION===========================\n");


/*booleano*/

	if(nide==0&&ndp==0&&npc==0&&nbool==1&&ncom==0) {printf("                    Assertion\n");
							   printf("                        ||\n");
							   printf("                 Assertion_clause\n");
							   printf("                        ||\n");
						  	   printf("           Unlabeled_assertion_clause\n");
							   printf("                        ||\n");
							   printf("                Boolean_expresion\n");
							   printf("                        ||\n");
							   printf("                    'booleano'\n");
	}


/*comentario*/

	if(nide==0&&ndp==0&&npc==0&&nbool==0&&ncom==1) {printf("                    Assertion\n");
							   printf("                        ||\n");
							   printf("                 Assertion_clause\n");
							   printf("                        ||\n");
						  	   printf("           Unlabeled_assertion_clause\n");
							   printf("                        ||\n");
							   printf("                    Comment\n");
							   printf("                        ||\n");
							   printf("                   'comentario'\n");
	}


/*booleano;comentario*/

	if(nide==0&&ndp==0&&npc==1&&nbool==1&&ncom==1) {printf("                              Assertion\n");
							   printf("                                  ||\n");
							   printf("                      ---------------------------\n");
							   printf("                     ||           ||            ||\n");
							   printf("            Assertion_clause      ';'    Assertion_clause\n");
							   printf("                     ||                         ||\n");
						  	   printf("        Unlabeled_assertion_clause  Unlabeled_assertion_clause\n");
							   printf("                     ||                         ||\n");
							   printf("             Boolean_expresion               Comment\n");
							   printf("                     ||                         ||\n");
							   printf("                 'booleano'                 'comentario'\n");
	}


/*booleano;booleano*/

	if(nide==0&&ndp==0&&npc==1&&nbool==2&&ncom==0) {printf("                              Assertion\n");
							   printf("                                  ||\n");
							   printf("                      ---------------------------\n");
							   printf("                     ||           ||            ||\n");
							   printf("            Assertion_clause      ';'    Assertion_clause\n");
							   printf("                     ||                         ||\n");
						  	   printf("        Unlabeled_assertion_clause  Unlabeled_assertion_clause\n");
							   printf("                     ||                         ||\n");
							   printf("             Boolean_expresion          Boolean_expresion\n");
							   printf("                     ||                         ||\n");
							   printf("                 'booleano'                 'booleano'\n");
	}


/*comentario;comentario*/

	if(nide==0&&ndp==0&&npc==1&&nbool==0&&ncom==2) {printf("                              Assertion\n");
							   printf("                                  ||\n");
							   printf("                      ---------------------------\n");
							   printf("                     ||           ||            ||\n");
							   printf("            Assertion_clause      ';'    Assertion_clause\n");
							   printf("                     ||                         ||\n");
						  	   printf("        Unlabeled_assertion_clause  Unlabeled_assertion_clause\n");
							   printf("                     ||                         ||\n");
							   printf("                  Comment                     Comment\n");
							   printf("                     ||                         ||\n");
							   printf("                'comentario'               'comentario'\n");
	}


/*comentario;comentario;comentario*/

	if(nide==0&&ndp==0&&npc==2&&nbool==0&&ncom==3) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      -----------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                   Comment                       Comment                            Comment\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                'comentario'                   'comentario'                      'comentario'\n");
	}


/*comentario;comentario;booleano*/

	if(nide==0&&ndp==0&&npc==2&&nbool==1&&ncom==2) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      -----------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                   Comment                       Comment                      Boolean_expresion\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                'comentario'                   'comentario'                       'booleano'\n");
	}


/*comentario;booleano;booleano*/

	if(nide==0&&ndp==0&&npc==2&&nbool==2&&ncom==1) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      -----------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                   Comment                   Boolean_expresion                 Boolean_expresion\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                'comentario'                    'booleano'                        'booleano'\n");
	}


/*booleano;booleano;booleano*/

	if(nide==0&&ndp==0&&npc==2&&nbool==3&&ncom==0) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      -----------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("             Boolean_expresion               Boolean_expresion                Boolean_expresion\n");
							   printf("                     ||                             ||                                ||\n");
							   printf("                 'booleano'                     'booleano'                        'booleano'\n");
	}


/*booleano;booleano;booleano;booleano*/

	if(nide==0&&ndp==0&&npc==3&&nbool==4&&ncom==0) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      ----------------------------------------------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("             Boolean_expresion               Boolean_expresion                Boolean_expresion                Boolean_expresion\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("                 'booleano'                     'booleano'                        'booleano'                        'booleano'\n");
	}



/*booleano;booleano;booleano;comentario*/

	if(nide==0&&ndp==0&&npc==3&&nbool==3&&ncom==1) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      ----------------------------------------------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("             Boolean_expresion               Boolean_expresion                Boolean_expresion                      Comment\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("                 'booleano'                     'booleano'                        'booleano'                       'comentario''\n");
	}



/*booleano;booleano;comentario;comentario*/

	if(nide==0&&ndp==0&&npc==3&&nbool==2&&ncom==2) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      ----------------------------------------------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("             Boolean_expresion               Boolean_expresion                     Comment                           Comment\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("                 'booleano'                     'booleano'                       'comentario'                      'comentario''\n");
	}





/*booleano;comentario;comentario;comentario*/

	if(nide==0&&ndp==0&&npc==3&&nbool==1&&ncom==3) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      ----------------------------------------------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("             Boolean_expresion                   Comment                           Comment                           Comment\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("                 'booleano'                    'comentario'                      'comentario'                      'comentario''\n");
	}



/*comentario;comentario;comentario;comentario*/

	if(nide==0&&ndp==0&&npc==3&&nbool==1&&ncom==3) {printf("                                                Assertion\n");
							   printf("                                                    ||\n");
							   printf("                      ----------------------------------------------------------------------------------------------------\n");
							   printf("                     ||             ||              ||               ||               ||               ||               ||\n");
							   printf("            Assertion_clause        ';'     Assertion_clause         ';'      Assertion_clause         ';'      Assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
						  	   printf("        Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause       Unlabeled_assertion_clause\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("                  Comment                        Comment                           Comment                           Comment\n");
							   printf("                     ||                             ||                                ||                                ||\n");
							   printf("                 'Comentario'                    'comentario'                      'comentario'                      'comentario''\n");
	}




/*id:comentario*/

	if(nide==1&&ndp==1&&npc==0&&nbool==0&&ncom==1) {printf("                    Assertion\n");
							   printf("                        ||\n");
							   printf("                 Assertion_clause\n");
							   printf("                        ||\n");
							   printf("            ---------------------------\n");
							   printf("            ||                        ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause\n");
							   printf("            ||                        ||\n");
							   printf("        ----------                 Comment\n");
							   printf("       ||        ||                   ||\n");
							   printf("      Tag        ':'             'comentario'\n");
							   printf("       ||\n");
							   printf("      'id'\n");
	}


/*id:booleano*/

	if(nide==1&&ndp==1&&npc==0&&nbool==1&&ncom==0) {printf("                    Assertion\n");
							   printf("                        ||\n");
							   printf("                 Assertion_clause\n");
							   printf("                        ||\n");
							   printf("            ---------------------------\n");
							   printf("            ||                        ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause\n");
							   printf("            ||                        ||\n");
							   printf("        ----------            Boolean_expresion\n");
							   printf("       ||        ||                   ||\n");
							   printf("      Tag        ':'             'booleano'\n");
							   printf("       ||\n");
							   printf("      'id'\n");
	}



/*id:booleano;id:booleano*/

	if(nide==2&&ndp==2&&npc==1&&nbool==2&&ncom==0) {printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                            ------------------------------\n");
							   printf("            ||                        ||                            ||                           ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause           Tang_mark          Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                            ||                           ||\n");
							   printf("        ----------            Boolean_expresion                 -----------             Boolean_expresion\n");
							   printf("       ||        ||                   ||                        ||        ||                     ||\n");
							   printf("      Tag        ':'             'booleano'                    Tag        ':'                'booleano'\n");
							   printf("       ||                                                       ||\n");
							   printf("      'id'                                                     'id'\n");
	}




/*id:booleano;id:comentario*/

	if(nide==2&&ndp==2&&npc==1&&nbool==1&&ncom==1) {printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                             ||                            ||\n");
							   printf("                 Assertion_clause                     ';'                     Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                            ------------------------------\n");
							   printf("            ||                        ||                            ||                           ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause           Tang_mark          Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                            ||                           ||\n");
							   printf("        ----------                 Comment                      -----------             Boolean_expresion\n");
							   printf("       ||        ||                   ||                        ||        ||                     ||\n");
							   printf("      Tag        ':'             'comentario'                  Tag        ':'                'booleano'\n");
							   printf("       ||                                                       ||\n");
							   printf("      'id'                                                     'id'\n");
	}




/*id:comentario;id:comentario*/

	if(nide==2&&ndp==2&&npc==1&&nbool==0&&ncom==2) {printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                 Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                            ------------------------------\n");
							   printf("            ||                        ||                            ||                           ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause           Tang_mark          Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                            ||                           ||\n");
							   printf("        ----------                 Comment                      -----------                   Comment\n");
							   printf("       ||        ||                   ||                        ||        ||                     ||\n");
							   printf("      Tag        ':'             'comentario'                  Tag        ':'               'comentario'\n");
							   printf("       ||                                                       ||\n");
							   printf("      'id'                                                     'id'\n");
	}




/*comentario;id:comentario*/

	if(nide==1&&ndp==1&&npc==1&&nbool==0&&ncom==2) {printf("PARA 'comentario;id:comentario' SE OBSERVA QUE EL ARBOL ES EL MISMO QUE PARA 'id:comentario;comentario' CAMBIANDO EL ORDEN DE LAS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("                        ||                                            ------------------------------\n");
							   printf("                        ||                                            ||                           ||\n");
						  	   printf("             Unlabeled_assertion_clause                            Tang_mark          Unlabeled_assertion_clause\n");
							   printf("                        ||                                            ||                           ||\n");
							   printf("                      Comment                                    -----------                    Comment\n");
							   printf("                        ||                                       ||        ||                      ||\n");
							   printf("                   'comentario'                                 Tag        ':'                'comentario'\n");
							   printf("                                                                 ||\n");
							   printf("                                                                'id'\n");
printf("\n");
	}




/*comentario;id:booleano*/

	if(nide==1&&ndp==1&&npc==1&&nbool==1&&ncom==1) {printf("PARA: 'comentario;id:booleano', PODEMOS OBSERVAR QUE ES LO MISMO QUE 'booleano;id:comentario', 'id:comentario;booleano' Y 'id:booleano;comentario' CAMBIANDO EL ORDEN DE UNA O DOS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("                        ||                                            ------------------------------\n");
							   printf("                        ||                                            ||                           ||\n");
						  	   printf("             Unlabeled_assertion_clause                            Tang_mark          Unlabeled_assertion_clause\n");
							   printf("                        ||                                            ||                           ||\n");
							   printf("                      Comment                                    -----------               Boolean_expresion\n");
							   printf("                        ||                                       ||        ||                      ||\n");
							   printf("                   'comentario'                                 Tag        ':'                 'booleano'\n");
							   printf("                                                                 ||\n");
							   printf("                                                                'id'\n");
printf("\n");
	}




/*booleano;id:booleano*/

	if(nide==1&&ndp==1&&npc==1&&nbool==2&&ncom==0) {printf("PARA 'booleano;id:booleano' SE OBSERVA QUE EL ARBOL ES EL MISMO QUE PARA 'id:booleano;booleano' CAMBIANDO EL ORDEN DE LAS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("                        ||                                            ------------------------------\n");
							   printf("                        ||                                            ||                           ||\n");
						  	   printf("             Unlabeled_assertion_clause                            Tang_mark          Unlabeled_assertion_clause\n");
							   printf("                        ||                                            ||                           ||\n");
							   printf("                 Boolean_expresion                               -----------               Boolean_expresion\n");
							   printf("                        ||                                       ||        ||                      ||\n");
							   printf("                     'booleano'                                 Tag        ':'                 'booleano'\n");
							   printf("                                                                 ||\n");
							   printf("                                                                'id'\n");
printf("\n");
	}



/*booleano;id:comentario*/

	if(nide==1&&ndp==1&&npc==1&&nbool==1&&ncom==1) {printf("PARA: 'booleano;id:comentario', PODEMOS OBSERVAR QUE ES LO MISMO QUE 'comentario;id:booleano', 'id:comentario;booleano' Y 'id:booleano;comentario' CAMBIANDO EL ORDEN DE UNA O DOS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("                        ||                                            ------------------------------\n");
							   printf("                        ||                                            ||                           ||\n");
						  	   printf("             Unlabeled_assertion_clause                            Tang_mark          Unlabeled_assertion_clause\n");
							   printf("                        ||                                            ||                           ||\n");
							   printf("                 Boolean_expresion                               -----------                    Comment\n");
							   printf("                        ||                                       ||        ||                      ||\n");
							   printf("                   'booleano'                                 Tag        ':'                'comentario'\n");
							   printf("                                                                 ||\n");
							   printf("                                                                'id'\n");
printf("\n");
	}



/*id:comentario;comentario*/

	if(nide==1&&ndp==1&&npc==1&&nbool==0&&ncom==2) {printf("PARA 'id:comentario;comentario' SE OBSERVA QUE EL ARBOL ES EL MISMO QUE PARA 'comentario;id:comentario' CAMBIANDO EL ORDEN DE LAS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                                             ||\n");
							   printf("            ||                        ||                                             ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause                  Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                                             ||\n");
							   printf("        ----------                 Comment                                        Comment\n");
							   printf("       ||        ||                   ||                                             ||\n");
							   printf("      Tag        ':'             'comentario'                                   'comentario'\n");
							   printf("       ||                                                       \n");
							   printf("      'id'                                                     \n");
printf("\n");
	}



/*id:comentario;booleano*/

	if(nide==1&&ndp==1&&npc==1&&nbool==1&&ncom==1) {printf("PARA: 'id:comentario;booleano', PODEMOS OBSERVAR QUE ES LO MISMO QUE 'booleano;id:comentario', 'comentario;id:booleano' Y 'id:booleano;comentario' CAMBIANDO EL ORDEN DE UNA O DOS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                                             ||\n");
							   printf("            ||                        ||                                             ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause                  Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                                             ||\n");
							   printf("        ----------                 Comment                                   Boolean_expresion\n");
							   printf("       ||        ||                   ||                                             ||\n");
							   printf("      Tag        ':'             'comentario'                                    'booleano'\n");
							   printf("       ||                                                       \n");
							   printf("      'id'                                                     \n");
printf("\n");
	}



/*id:booleano;comentario*/

	if(nide==1&&ndp==1&&npc==1&&nbool==1&&ncom==1) {printf("PARA: 'id:comentario;booleano', PODEMOS OBSERVAR QUE ES LO MISMO QUE 'id:booleano;comentario', 'comentario;id:booleano' Y 'id:comentario;booleano' CAMBIANDO EL ORDEN DE UNA O DOS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                                             ||\n");
							   printf("            ||                        ||                                             ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause                  Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                                             ||\n");
							   printf("        ----------             Boolean_expresion                                  Comment\n");
							   printf("       ||        ||                   ||                                             ||\n");
							   printf("      Tag        ':'              'booleano'                                    'comentario'\n");
							   printf("       ||                                                       \n");
							   printf("      'id'                                                     \n");
printf("\n");
	}




/*id:booleano;booleano*/

	if(nide==1&&ndp==1&&npc==1&&nbool==2&&ncom==0) {printf("PARA 'booleano;id:booleano' SE OBSERVA QUE EL ARBOL ES EL MISMO QUE PARA 'id:booleano;booleano' CAMBIANDO EL ORDEN DE LAS RAMAS");
printf("\n");
printf("                                                    Assertion\n");
							   printf("                                                        ||\n");
							   printf("                        ---------------------------------------------------------------\n");
							   printf("                        ||                              ||                           ||\n");
							   printf("                 Assertion_clause                       ';'                  Assertion_clause\n");
							   printf("                        ||                                                           ||\n");
							   printf("            ----------------------------                                             ||\n");
							   printf("            ||                        ||                                             ||\n");
						  	   printf("         Tang_mark          Unlabeled_assertion_clause                  Unlabeled_assertion_clause\n");
							   printf("            ||                        ||                                             ||\n");
							   printf("        ----------             Boolean_expresion                             Boolean_expresion\n");
							   printf("       ||        ||                   ||                                             ||\n");
							   printf("      Tag        ':'              'booleano'                                     'booleano'\n");
							   printf("       ||                                                       \n");
							   printf("      'id'                                                     \n");
printf("\n");
	}





}


