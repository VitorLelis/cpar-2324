CC = gcc
SRC = src/
CFLAGS = -pg -O3 -ftree-vectorize -Wall

.DEFAULT_GOAL = all

all: MDseq.exe MDpar.exe

MDseq.exe: $(SRC)/MDseq.cpp
	$(CC) $(CFLAGS) $(SRC)MDseq.cpp -lm -o MDseq.exe

MDpar.exe: $(SRC)/MDpar.cpp
	$(CC) $(CFLAGS) $(SRC)MDpar.cpp -lm -fopenmp -o MDpar.exe

callgraph:
	gprof ./MDseq.exe > seq.gprof
	gprof ./MDpar.exe > par.gprof

clean:
	rm ./MD*.exe cp_* *.gprof gmon.out

run: runseq runpar

runseq:
	./MDseq.exe < inputdata.txt

runpar:
	./MDpar.exe < inputdata.txt
