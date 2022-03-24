;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data					; preinitialized data (data segment)
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
	
	dWordArray	TIMES 	300 dd 80h
	dWordTest	dd 	90h
	
	bArray		db 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

SECTION .bss
	Array		resw 400		; unitialized data (stack segment)
	

SECTION     .text
	global      _start

_start:
	nop
	
	push	DWORD [dWordArray]	;print first element of 'dWordArray' as a 32bit Hex
	call	Print32bitNumHex	;
	call	Printendl		;
	
	mov 	eax, bArray		;print the array address of 'bArray' as 32bit Hex
	push	eax			;
	call 	Print32bitNumHex	;
	call	Printendl		;

    	push	openPrompt		;print the openPrompt char string
    	call	PrintString		;
    	call	Printendl		;
    	 
    	
    	push	closePrompt		;print the closing prompt char string
    	call  	PrintString		;
    	call  	Printendl		;
	
	push	eax
	call	PrintRegisters
	call	Printendl    
	
    	nop
	
	;
	;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0					;Return code
	int		80h					;Poke the kernel
