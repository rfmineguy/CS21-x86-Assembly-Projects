all: main

main: main.o
	ld -melf_i386 -o main main.o

main.o: main.asm
	nasm -g -f elf32 -F dwarf main.asm -l main.lst

clean:
	rm -f ./main.o || true
	rm -f ./main.lst || true
	rm -f ./main || true
