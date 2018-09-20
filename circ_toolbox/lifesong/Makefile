CC = gcc
CFLAGS = -Wall

LIB = /usr/lib32

ALL = lscollect

all: $(ALL)

lscollect: lscollect.o
	$(CC) $(CFLAGS) -o lscollect lscollect.c -L$(LIB) -lX11 -ldmedia

clean:
	rm $(ALL) *.o *~

backup:
	cp *.c bak
	cp *.m bak
	cp Makefile bak

restore:
	cp bak/*.c .
	cp bak/*.m .
	cp bak/Makefile .

release:
	cp *.m public
	cp lscollect public
	cp ../soundcommands/sfrecord public
