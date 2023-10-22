CC = gcc
SRC = src/
CFLAGS = -pg -O3 -march=native -ftree-vectorize -Wall

.DEFAULT_GOAL = MD.exe

MD.exe: $(SRC)/MD.cpp
	$(CC) $(CFLAGS) $(SRC)MD.cpp -lm -o MD.exe

clean:
	rm ./MD.exe cp_* main.gprof gmon.out

callgraph:
	gprof ./MD.exe > main.gprof

run:
	./MD.exe < inputdata.txt
