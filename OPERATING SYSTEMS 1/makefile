CFLAGS=-Wall -std=c99 -g -O -pthread
CC=gcc

EXECS=divisoriT divisoriP

all: $(EXECS)

divisoriT: divisoriT.o xerrors.o
	$(CC) $(CFLAGS) -o divisoriT divisoriT.o xerrors.o
divisoriT.o: divisoriT.c xerrors.h
	$(CC) $(CFLAGS) -o divisoriT.o -c divisoriT.c

divisoriP: divisoriP.o xerrors.o
	$(CC) $(CFLAGS) -o divisoriP divisoriP.o xerrors.o
divisoriP.o: divisoriP.c xerrors.h
	$(CC) $(CFLAGS) -o divisoriP.o -c divisoriP.c


xerrors.o: xerrors.c xerrors.h
	$(CC) $(CFLAGS) -o xerrors.o -c xerrors.c
clean:
	rm *.o $(EXECS)
	


