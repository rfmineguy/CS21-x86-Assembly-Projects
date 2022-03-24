;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
	addressPrompt db "Addresses of dwordArray, byteArray, alphaArray, and wordArray", 0h
	valuePrompt db	"First value of dwordArray, byteArray, alphaArray, and wordArray", 0h
	dWarray			TIMES 300 dd 80h	
	bArray			db  01, 02, 03, 04, 05, 06, 07, 08, 09, 0ah
	charArray		db	'abcdefghijklmnopqrstuvwxyz'

SECTION .bss
	resWarray		TIMES 400 resw 1

SECTION     .text
	global      _start

_start:
	nop
	
    push	openPrompt
    call	PrintString
    call	Printendl
		call	Printendl
	
		push addressPrompt
		call PrintString
		call Printendl   
 
		push  dWarray						; Print address of first element of 'dWarray'
		call	Print32bitNumHex	;
		call  Printendl					;

		push	bArray						; Print address of first element of 'bArray'
		call	Print32bitNumHex	;
		call	Printendl					;

		push	charArray					; Print address of first element of 'charArray'
		call	Print32bitNumHex	;
		call	Printendl					;
		call	Printendl		
	
		push	valuePrompt
		call	PrintString
		call	Printendl
 
		mov eax, 0							; Print value of first element of 'dWarray' 
		mov eax, [dWarray]			;
		push eax								;
		call Print32bitNumHex		;
		call Printendl					;

		mov eax, 0							; Print value of first element of 'bArray'
		mov al, [bArray]				;
		push eax								;
		call Print32bitNumHex		;
		call Printendl					;
	
		mov eax, 0							; Print value of first element of 'charArray'
		mov al, [charArray]			;
		push eax								;
		call Print32bitNumHex		;
		call Printendl					;

		mov eax, 0							;	Print value of first element of 'resWarray'
		mov ax, [resWarray]			;
		push eax								;
		call Print32bitNumHex		;
		call Printendl					;
		call Printendl					;

		push	closePrompt				;The prompt address - argument #1
    call  	PrintString
    call  	Printendl
    
    nop
;
;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
