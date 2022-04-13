all: main

main: main.o myFuncs.o
	g++ main.o myFuncs.o -m64 -o main

main.o: main.cpp
	g++ main.cpp -c -m64 -o main.o

myFuncs.o: myFuncs.asm
	nasm -g -f elf64 -F dwarf myFuncs.asm -l myFuncs.lst

#clean:
#	rm -f ./main.o || true 
# 	rm -f ./main || true 
# 	rm -f ./myFuncs.o || true 
# 	rm -f ./myFuncs.lst || true 
