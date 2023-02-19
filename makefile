all: runner.o
	$(MAKE) -C lexico
	$(MAKE) -C sintatico

runner.o: runner.c
	gcc runner.c -o runner.o
