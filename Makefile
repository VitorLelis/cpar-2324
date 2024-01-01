CC = gcc
MPICC = mpicc
SRC = src/
CFLAGS = -pg -O3 -ftree-vectorize -Wall

.DEFAULT_GOAL = all

all: MDseq.exe MDpar.exe

MDseq.exe: $(SRC)/MDseq.cpp
	$(CC) $(CFLAGS) $(SRC)MDseq.cpp -lm -o MDseq.exe

#Change it in cluster
MDpar.exe: $(SRC)/MDpar.cpp
	$(MPICC) $(CFLAGS) $(SRC)MDpar.cpp -lm -o MDpar.exe -I/usr/bin -lmpi


callgraph:
	gprof ./MDseq.exe > seq.gprof
	gprof ./MDpar.exe > par.gprof

clean:
	rm ./MD*.exe cp_* *.gprof gmon.out seq_*

seqres:
	cp cp_average.txt seq_average.txt
	cp cp_output.txt seq_output.txt

runseq:
	./MDseq.exe < inputdata.txt

runpar:
	./MDpar.exe < inputdata.txt
