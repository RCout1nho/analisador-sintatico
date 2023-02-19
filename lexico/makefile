# List all source files
SRCDIR := .
SOURCES := $(shell find $(SRCDIR) -name '*.c')
OBJECTS := $(SOURCES:%.c=%.o)

# Compiler settings
CC := gcc
CFLAGS := -Wall -Werror

# Targets
all: lexico

lexico: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o lexico

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(OBJECTS) lexico
