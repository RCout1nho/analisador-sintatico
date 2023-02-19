# Compiladores
CPPC=g++
YACC=bison

# Dependências
all: sintatico

sintatico: sintatico.tab.c
	$(CPPC) sintatico.tab.c -std=c++17 -o sintatico

sintatico.tab.c: sintatico.y
	$(YACC) sintatico.y

clean: sintatico.tab.c
	rm sintatico.tab.c
