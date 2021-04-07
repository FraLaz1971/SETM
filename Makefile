TARGET1=stprog
CC=cc -g

SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)
#CFLAGS = -I. -ansi -Wall -pedantic
CFLAGS = -I.  -Wall -pedantic
LDFLAGS = -L. -lm

TARGETS = $(TARGET1) 

.PHONY: clean all install

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
clean:
	rm -f $(OBJ) $(TARGETS) srn_dha.conf
distclean: clean
	rm -f srn_dha.conf log/*.log
	




