
all: sintatico

sintatico: sintatico.tab.c
	gcc sintatico.tab.c -o sintatico.o

sintatico.tab.c: sintatico.y
	bison sintatico.y

clean: sintatico.tab.c
	rm sintatico.tab.c
