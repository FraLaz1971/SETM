TARGET1=stprog
CC=cc -g

SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
CFLAGS = -I. -ansi -Wall -pedantic
LDFLAGS = -L. -lm

TARGETS = $(TARGET1) 

$(TARGET1): $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

all: $(TARGETS)
	echo "done all targets"

.PHONY: install

install:
	chmod +x bin/*
install_dha: install
	cp lib/* ../../lib
	cp bin/* ../../bin
.PHONY: clean
clean:
	rm -f $(OBJ) $(TARGETS)


