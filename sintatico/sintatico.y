%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyparse(void);
void yyerror(const char *);

%}

%token INT VOID FLOAT ID NUM_INT NUM_FLOAT DO LE GE EQ NE CARACTER STRING
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
        | lista-com
        | exp
        ;

lista-decl: lista-decl decl
          | decl
          ;

decl: decl-var
    | decl-func
    ;

decl-var: espec-tipo var SP_PT_VIRG { printf("Declaração de variável\n"); }
        | espec-tipo var OP_ATRIB num SP_PT_VIRG { printf("Declaração de variável com atribuição NUM\n"); }
        | espec-tipo var OP_ATRIB var SP_PT_VIRG { printf("Declaração de variável com atribuição\n"); }
        | espec-tipo var OP_ATRIB lit SP_PT_VIRG { printf("Declaração de variável com atribuição LIT\n"); }
        | espec-tipo var OP_ATRIB exp { printf("Declaração de variável com atribuição EXP\n");}
        | programa
        ;

num: NUM_INT
   | NUM_FLOAT
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

com-expr: exp {printf("Expressão\n");}
        ;

com-atrib: var OP_ATRIB exp {printf("Atribuição\n");}
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
         | comando
         ;

exp: exp-soma
   | exp-soma op-relac exp-soma
  // | ID
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
           | lit
           ;

lit: CARACTER
    | STRING
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


int yylex() {
    char line[30];
    scanf("%50[^\n]%*c", line);

    if (strcmp(line, "INT") == 0) {
        return INT;
    } else

        if (strcmp(line, "FLOAT") == 0) {
        return FLOAT;
    } else

        if (strcmp(line, "ID") == 0) {
        return ID;
    } else

        if (strcmp(line, "SP_PT_VIRG") == 0) {
        return SP_PT_VIRG;
    } else
        ;
    if (strcmp(line, "BOOL") == 0) {
        return BOOL;
    } else

        if (strcmp(line, "BREAK") == 0) {
        return BREAK;
    } else

        if (strcmp(line, "CHAR") == 0) {
        return CHAR;
    } else

        if (strcmp(line, "CONTINUE") == 0) {
        return CONTINUE;
    } else

        if (strcmp(line, "DO") == 0) {
        return DO;
    } else

        if (strcmp(line, "ELSE") == 0) {
        return ELSE;
    } else

        if (strcmp(line, "FALSE") == 0) {
        return FALSE;
    } else

        if (strcmp(line, "FLOAT") == 0) {
        return FLOAT;
    } else

        if (strcmp(line, "FOR") == 0) {
        return FOR;
    } else

        if (strcmp(line, "GOTO") == 0) {
        return GOTO;
    } else

        if (strcmp(line, "IF") == 0) {
        return IF;
    } else

        if (strcmp(line, "INT") == 0) {
        return INT;
    } else

        if (strcmp(line, "RETURN") == 0) {
        return RETURN;
    } else

        if (strcmp(line, "TRUE") == 0) {
        return TRUE;
    } else

        if (strcmp(line, "VOID") == 0) {
        return VOID;
    } else

        if (strcmp(line, "WHILE") == 0) {
        return WHILE;
    } else

        if (strcmp(line, "OP_EXCL") == 0) {
        return OP_EXCL;
    } else if (strcmp(line, "OP_DIF") == 0) {
        return OP_DIF;
    } else if (strcmp(line, "OP_MOD") == 0) {
        return OP_MOD;
    } else if (strcmp(line, "OP_ATRIB_MOD") == 0) {
        return OP_ATRIB_MOD;
    } else if (strcmp(line, "OP_E") == 0) {
        return OP_E;
    } else if (strcmp(line, "OP_AND") == 0) {
        return OP_AND;
    } else if (strcmp(line, "OP_MULT") == 0) {
        return OP_MULT;
    } else if (strcmp(line, "OP_ATRIB_MULT") == 0) {
        return OP_ATRIB_MULT;
    } else if (strcmp(line, "OP_AD") == 0) {
        return OP_AD;
    } else if (strcmp(line, "OP_INC") == 0) {
        return OP_INC;
    } else if (strcmp(line, "OP_ATRIB_AD") == 0) {
        return OP_ATRIB_AD;
    } else if (strcmp(line, "OP_SUB") == 0) {
        return OP_SUB;
    } else if (strcmp(line, "OP_DEC") == 0) {
        return OP_DEC;
    } else if (strcmp(line, "OP_ATRIB_SUB") == 0) {
        return OP_ATRIB_SUB;
    } else if (strcmp(line, "L_D") == 0) {
        return OP_FLECHA_D;
    } else if (strcmp(line, "OP_PT") == 0) {
        return OP_PT;
    } else if (strcmp(line, "OP_DIV") == 0) {
        return OP_DIV;
    } else if (strcmp(line, "OP_ATRIB_DIV") == 0) {
        return OP_ATRIB_DIV;
    } else if (strcmp(line, "OP_2PT") == 0) {
        return OP_2PT;
    } else if (strcmp(line, "OP_MENOR") == 0) {
        return OP_MENOR;
    } else if (strcmp(line, "OP_FLECHA_E") == 0) {
        return OP_FLECHA_E;
    } else if (strcmp(line, "OP_MENOR_IGUAL") == 0) {
        return OP_MENOR_IGUAL;
    } else if (strcmp(line, "OP_ATRIB") == 0) {
        return OP_ATRIB;
    } else if (strcmp(line, "OP_COMP") == 0) {
        return OP_COMP;
    } else if (strcmp(line, "OP_MAIOR") == 0) {
        return OP_MAIOR;
    } else if (strcmp(line, "OP_MAIOR_IGUAL") == 0) {
        return OP_MAIOR_IGUAL;
    } else if (strcmp(line, "OP_QUEST") == 0) {
        return OP_QUEST;
    } else if (strcmp(line, "OP_PIPE") == 0) {
        return OP_PIPE;
    } else if (strcmp(line, "OP_OR") == 0) {
        return OP_OR;
    } else

        if (strcmp(line, "OP_EXCL") == 0) {
        return OP_EXCL;
    } else if (strcmp(line, "OP_MOD") == 0) {
        return OP_MOD;
    } else if (strcmp(line, "OP_E") == 0) {
        return OP_E;
    } else if (strcmp(line, "OP_MULT") == 0) {
        return OP_MULT;
    } else if (strcmp(line, "OP_AD") == 0) {
        return OP_AD;
    } else if (strcmp(line, "OP_SUB") == 0) {
        return OP_SUB;
    } else if (strcmp(line, "OP_PT") == 0) {
        return OP_PT;
    } else if (strcmp(line, "OP_DIV") == 0) {
        return OP_DIV;
    } else if (strcmp(line, "OP_2PT") == 0) {
        return OP_2PT;
    } else if (strcmp(line, "OP_MENOR") == 0) {
        return OP_MENOR;
    } else if (strcmp(line, "OP_ATRIB") == 0) {
        return OP_ATRIB;
    } else if (strcmp(line, "OP_MAIOR") == 0) {
        return OP_MAIOR;
    } else if (strcmp(line, "OP_QUEST") == 0) {
        return OP_QUEST;
    } else if (strcmp(line, "OP_PIPE") == 0) {
        return OP_PIPE;
    } else if (strcmp(line, "SP_PRT_A") == 0) {
        return SP_PRT_A;
    } else if (strcmp(line, "SP_PRT_F") == 0) {
        return SP_PRT_F;
    } else if (strcmp(line, "SP_VIRG") == 0) {
        return SP_VIRG;
    } else if (strcmp(line, "SP_PT_VIRG") == 0) {
        return SP_PT_VIRG;
    } else if (strcmp(line, "SP_CHT_A") == 0) {
        return SP_CHT_A;
    } else if (strcmp(line, "SP_CHT_F") == 0) {
        return SP_CHT_F;
    } else if (strcmp(line, "SP_CHV_A") == 0) {
        return SP_CHV_A;
    } else if (strcmp(line, "SP_CHV_F") == 0) {
        return SP_CHV_F;
    } else if (strcmp(line, "NUM_INT") == 0) {
        return NUM_INT;
    } else if (strcmp(line, "NUM_FLOAT") == 0) {
        return NUM_FLOAT;
    } else if (strcmp(line, "CARACTER") == 0) {
        return CARACTER;
    } else if (strcmp(line, "STRING") == 0) {
        return STRING;
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