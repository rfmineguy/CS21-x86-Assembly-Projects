all: main

main: main.o functions.o myFunc.o
	ld -melf_i386 -o main main.o ./functions.o ./myFunc.o

main.o: main.asm functions.inc
	nasm -g -f elf32 -F dwarf main.asm -l main.lst

myFunc.o: myFunc.asm
	nasm -g -f elf32 -F dwarf myFunc.asm -l myFunc.lst

clean:
	rm -f ./main.o || true
	rm -f ./main.lst || true
	rm -f ./myFunc.o || true
	rm -f ./myFunc.lst || true
	rm -f ./main || true
