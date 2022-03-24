;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
		

SECTION .bss
	myArray				resd	1000
		.sizeof			equ $-myArray													;# of bytes in array
		.lengthof		equ myArray.sizeof / 4								;# of elements in array
		.type				equ myArray.sizeof / myArray.lengthof	;Size of each item in the array

SECTION     .text
	global      _start

_start:
	nop
	
    push	openPrompt
    call	PrintString
    call	Printendl

		label:
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
			mov ecx, 0
			mov ebx, 1
			mov eax, 9
		loop label
		mov eax, 0
		mov ebx, 0
		dec eax
		dec ebx    
														;Linux Only 
		mov   eax, openPrompt		;move address into eax
		mov   eax, [openPrompt] ;move data into eax
	
		;loop that sets all values in array to all 9s	
		mov		ecx, myArray.lengthof	;move # of items into ecx (counter)
		mov		esi, myArray					;move address of array into esi		
		Loop1:
			mov dword [esi], 99999999h			;move into the current address' value all 9s
			add esi, myArray.type			;move to the next element by adding 4 bytes (double word)
		loop Loop1									;automatically dec ecx
			
		
														;Windows
		; 
    push	closePrompt			;The prompt address - argument #1
    call  	PrintString
    call  	Printendl
    
    nop
;
;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
