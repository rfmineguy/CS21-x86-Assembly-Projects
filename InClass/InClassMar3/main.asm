;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
	byteVar1		db	22h
	byteVar2		db	35h
	wordVar1		dw	7432h
	wordVar2		dw	3298h
	dWordVar1		dd	7412a743h
	dWordVar2		dd	32b864ach

	byteArray		db	11h, 22h, 33h, 44h, 55h
	wordArray		dw	1111h, 2222h, 3333h, 4444h, 5555h

SECTION .bss
	

SECTION     .text
	global      _start

_start:
	nop
	
    push	openPrompt
    call	PrintString
    call	Printendl
    
		mov	 al, [byteVar1]		;put byteVar1 into al
		xchg al, [byteVar2]		;exchange al with byteVar2
		mov  [byteVar1], al   ;put al back into byteVar1
													;latency 4 + 4 + 1 = 9, use the instruction latency table
		mov		al, [byteVar1]	;4
		mov		ah, [byteVar2]  ;4
		xchg	al, ah					;1
		mov		[byteVar1], al  ;4
		mov		[byteVar2], ah  ;4

													;swap wordVar1 and wordVar2
		mov		ax, [wordVar1]  ;4
		mov		bx, [wordVar2]  ;4
		xchg  ax, bx					;1
		mov		[wordVar2], ax	;4
		mov		[wordVar1], bx	;4

    push	closePrompt			;The prompt address - argument #1
    call  	PrintString
    call  	Printendl
   
		xor eax, eax
		mov al, [byteArray]
		mov al, [byteArray+1]
		mov al, [byteArray+2]
		mov al, [byteArray+3]
		mov al, [byteArray+4]
	
		xor eax, eax
		mov ax, [wordArray]
		mov ax, [wordArray+2]
		mov ax, [wordArray+4]
		mov ax, [wordArray+6]
		mov ax, [wordArray+8]
		
 
    nop
;
;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
