; Assembler 32bit template

bits 32
section .data

	openGreet  db "Welcome to my program", 0
	closeGreet db "Program ending, have a nice day", 0

	value1 	db 0ffh
	aword  	dw 999h
	adword 	dd 3256h
	aqword 	dq 995h
	arr	dw 94, 59, 53, 90h
		dw 43, 54, 53
	str1	db 'String', 0	;null terminated char array	

	mainMenu db "Main men", 0dh, 0ah, 0dh, 0ah,
		 db "<1> Do something", 0dh, 0ah
		 db "<2> Do something", 0dh, 0ah, 0
 
section .bss
	undefByte  resb 1	;reserve a single byte of memory (1 byte)
	undefWord  resw 1	;reserver a single word of memory (2 bytes)
	undefDword resd 1	;reserve a single double word of memory (4 bytes)
	undefQword resq 1	;reserve a single quad word of memory (8 bytes)

section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here
	mov eax, [value1]	;derefference value1 and store the value	

	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
