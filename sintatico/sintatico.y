%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyparse(void);
void yyerror(const char *);

%}

%token INT VOID FLOAT ID NUM DO LE GE EQ NE
%token WHILE IF ELSE RETURN SP_PT_VIRG
%token BOOL BREAK CHAR CONTINUE FALSE FOR GOTO TRUE
%token OP_EXCL OP_DIF OP_MOD OP_MENOR OP_MAIOR OP_MENOR_IGUAL OP_MAIOR_IGUAL
%token OP_PIPE OP_AMP OP_IGUAL OP_MAIS OP_MENOS OP_MULT OP_DIV
%token LIT OP_ATRIB_MOD OP_ATRIB_DIV OP_ATRIB_MULT OP_ATRIB_MENOS OP_ATRIB_MAIS OP_ATRIB
%token OP_E OP_OU OP_XOR OP_NEGACAO OP_BITWISE OP_AND OP_OR OP_NOT OP_INC OP_DEC
%token OP_AD OP_ATRIB_AD OP_SUB OP_FLECHA_D OP_FLECHA_E OP_PT OP_ATRIB_SUB OP_DIVISAO OP_2PT OP_COMP OP_QUEST
%token SP_PRT_A SP_PRT_F SP_VIRG SP_CHT_A SP_CHT_F SP_CHV_A SP_CHV_F

%left '+' '-'
%left '*' '/' '%'
%nonassoc LOWER_THAN_ELSE

%%
programa: lista-decl
        ;

lista-decl: lista-decl decl
          | decl
          ;

decl: decl-var
    | decl-func
    ;

decl-var: espec-tipo var SP_PT_VIRG { printf("Declaração de variável\n"); }
        ;

espec-tipo: INT
          | VOID
          | FLOAT
          ;

decl-func: espec-tipo ID SP_PRT_A params SP_PRT_F com-comp
         ;

params: lista-param
      | VOID
      | /* vazio */
      ;

lista-param: lista-param ',' param
            | param
            ;

param: espec-tipo var
     ;

decl-locais: decl-locais decl-var
           | /* vazio */
           ;

comando: com-expr SP_PT_VIRG
       | com-atrib SP_PT_VIRG
       | com-comp
       | com-selecao
       | com-repeticao
       | com-retorno SP_PT_VIRG
       ;

com-expr: exp
        ;

com-atrib: var OP_ATRIB exp
         ;

com-comp: SP_CHV_A decl-locais lista-com SP_CHV_F
        ;

com-selecao: IF SP_PRT_A exp SP_PRT_F comando %prec LOWER_THAN_ELSE
           | IF SP_PRT_A exp SP_PRT_F comando ELSE comando
           ;

com-repeticao: WHILE SP_PRT_A exp SP_PRT_F comando
             | DO comando WHILE SP_PRT_A exp SP_PRT_F SP_PT_VIRG
             ;

com-retorno: RETURN SP_PT_VIRG
           | RETURN exp SP_PT_VIRG
           ;

lista-com: lista-com comando
         | /* vazio */
         ;

exp: exp-soma
   | exp-soma op-relac exp-soma
   ;

op-relac: OP_MENOR
        | LE
        | OP_MAIOR
        | GE
        | EQ
        | NE
        ;

exp-soma: exp-soma op-soma exp-mult
        | exp-mult
        ;

op-soma: OP_AD
       | OP_SUB
       ;

exp-mult: exp-mult op-mult exp-simples
        | exp-simples
        ;

op-mult: OP_MULT
       | OP_DIV
       | OP_MOD
       ;

exp-simples: SP_PRT_A exp SP_PRT_F
           | var
           | cham-func
           | LIT
           ;

cham-func: ID SP_PRT_A args SP_PRT_F
         ;

var: ID
   | ID SP_CHT_A exp SP_CHT_F
   ;

args: lista-arg
    | /* vazio */
    ;

lista-arg: lista-arg SP_VIRG exp
         | exp
         ;
%%


int yylex() 
{
    char line[30];
    scanf("%50[^\n]%*c", line);


    if(strcmp(line, "INT") == 0){
        return INT;
    }

    if(strcmp(line, "FLOAT") == 0){
        return FLOAT;
    }

    if(strcmp(line, "ID") == 0){
        return ID;
    }

    if(strcmp(line, "SP_PT_VIRG") == 0){
        return SP_PT_VIRG;
    };
    if(strcmp(line, "BOOL") == 0){
    /* yylval = 1; */
    return BOOL;
    }

    if(strcmp(line, "BREAK") == 0){
        /* yylval = 1; */
        return BREAK;
    }

    if(strcmp(line, "CHAR") == 0){
        /* yylval = 1; */
        return CHAR;
    }

    if(strcmp(line, "CONTINUE") == 0){
        /* yylval = 1; */
        return CONTINUE;
    }

    if(strcmp(line, "DO") == 0){
        /* yylval = 1; */
        return DO;
    }

    if(strcmp(line, "ELSE") == 0){
        /* yylval = 1; */
        return ELSE;
    }

    if(strcmp(line, "FALSE") == 0){
        /* yylval = 1; */
        return FALSE;
    }

    if(strcmp(line, "FLOAT") == 0){
        /* yylval = 1; */
        return FLOAT;
    }

    if(strcmp(line, "FOR") == 0){
        /* yylval = 1; */
        return FOR;
    }

    if(strcmp(line, "GOTO") == 0){
        /* yylval = 1; */
        return GOTO;
    }

    if(strcmp(line, "IF") == 0){
        /* yylval = 1; */
        return IF;
    }

    if(strcmp(line, "INT") == 0){
        /* yylval = 1; */
        return INT;
    }

    if(strcmp(line, "RETURN") == 0){
        /* yylval = 1; */
        return RETURN;
    }

    if(strcmp(line, "TRUE") == 0){
        /* yylval = 1; */
        return TRUE;
    }

    if(strcmp(line, "VOID") == 0){
        /* yylval = 1; */
        return VOID;
    }

    if(strcmp(line, "WHILE") == 0){
        /* yylval = 1; */
        return WHILE;
    }

    if(strcmp(line, "OP_EXCL") == 0){
    return OP_EXCL;
    }
    if(strcmp(line, "OP_DIF") == 0){
        return OP_DIF;
    }
    if(strcmp(line, "OP_MOD") == 0){
        return OP_MOD;
    }
    if(strcmp(line, "OP_ATRIB_MOD") == 0){
        return OP_ATRIB_MOD;
    }
    if(strcmp(line, "OP_E") == 0){
        return OP_E;
    }
    if(strcmp(line, "OP_AND") == 0){
        return OP_AND;
    }
    if(strcmp(line, "OP_MULT") == 0){
        return OP_MULT;
    }
    if(strcmp(line, "OP_ATRIB_MULT") == 0){
        return OP_ATRIB_MULT;
    }
    if(strcmp(line, "OP_AD") == 0){
        return OP_AD;
    }
    if(strcmp(line, "OP_INC") == 0){
        return OP_INC;
    }
    if(strcmp(line, "OP_ATRIB_AD") == 0){
        return OP_ATRIB_AD;
    }
    if(strcmp(line, "OP_SUB") == 0){
        return OP_SUB;
    }
    if(strcmp(line, "OP_DEC") == 0){
        return OP_DEC;
    }
    if(strcmp(line, "OP_ATRIB_SUB") == 0){
        return OP_ATRIB_SUB;
    }
    if(strcmp(line, "L_D") == 0){
        return OP_FLECHA_D;
    }
    if(strcmp(line, "OP_PT") == 0){
        return OP_PT;
    }
    if(strcmp(line, "OP_DIV") == 0){
        return OP_DIV;
    }
    if(strcmp(line, "OP_ATRIB_DIV") == 0){
        return OP_ATRIB_DIV;
    }
    if(strcmp(line, "OP_2PT") == 0){
        return OP_2PT;
    }
    if(strcmp(line, "OP_MENOR") == 0){
        return OP_MENOR;
    }
    if(strcmp(line, "OP_FLECHA_E") == 0){
        return OP_FLECHA_E;
    }
    if(strcmp(line, "OP_MENOR_IGUAL") == 0){
        return OP_MENOR_IGUAL;
    }
    if(strcmp(line, "OP_ATRIB") == 0){
        return OP_ATRIB;
    }
    if(strcmp(line, "OP_COMP") == 0){
        return OP_COMP;
    }
    if(strcmp(line, "OP_MAIOR") == 0){
        return OP_MAIOR;
    }
    if(strcmp(line, "OP_MAIOR_IGUAL") == 0){
        return OP_MAIOR_IGUAL;
    }
    if(strcmp(line, "OP_QUEST") == 0){
        return OP_QUEST;
    }
    if(strcmp(line, "OP_PIPE") == 0){
        return OP_PIPE;
    }
    if(strcmp(line, "OP_OR") == 0){
        return OP_OR;
    }

    if(strcmp(line, "OP_EXCL") == 0){
    return OP_EXCL;
    }
    else if(strcmp(line, "OP_MOD") == 0){
        return OP_MOD;
    }
    else if(strcmp(line, "OP_E") == 0){
        return OP_E;
    }
    else if(strcmp(line, "OP_MULT") == 0){
        return OP_MULT;
    }
    else if(strcmp(line, "OP_AD") == 0){
        return OP_AD;
    }
    else if(strcmp(line, "OP_SUB") == 0){
        return OP_SUB;
    }
    else if(strcmp(line, "OP_PT") == 0){
        return OP_PT;
    }
    else if(strcmp(line, "OP_DIV") == 0){
        return OP_DIV;
    }
    else if(strcmp(line, "OP_2PT") == 0){
        return OP_2PT;
    }
    else if(strcmp(line, "OP_MENOR") == 0){
        return OP_MENOR;
    }
    else if(strcmp(line, "OP_ATRIB") == 0){
        return OP_ATRIB;
    }
    else if(strcmp(line, "OP_MAIOR") == 0){
        return OP_MAIOR;
    }
    else if(strcmp(line, "OP_QUEST") == 0){
        return OP_QUEST;
    }
    else if(strcmp(line, "OP_PIPE") == 0){
        return OP_PIPE;
    }
    else if(strcmp(line, "SP_PRT_A") == 0){
        return SP_PRT_A;
    }
    else if(strcmp(line, "SP_PRT_F") == 0){
        return SP_PRT_F;
    }
    else if(strcmp(line, "SP_VIRG") == 0){
        return SP_VIRG;
    }
    else if(strcmp(line, "SP_PT_VIRG") == 0){
        return SP_PT_VIRG;
    }
    else if(strcmp(line, "SP_CHT_A") == 0){
        return SP_CHT_A;
    }
    else if(strcmp(line, "SP_CHT_F") == 0){
        return SP_CHT_F;
    }
    else if(strcmp(line, "SP_CHV_A") == 0){
        return SP_CHV_A;
    }
    else if(strcmp(line, "SP_CHV_F") == 0){
        return SP_CHV_F;
    }



    return -1;
}

void yyerror(const char * s)
{
    printf("ERRO: %s\n", s);
}

int main()
{
	yyparse();
}