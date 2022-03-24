;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
	
	bVal				db	23h
	sVal				db  -10			;stored as ah with 2's compliment applied (f6)
	
SECTION .bss
	

SECTION     .text
	global      _start

_start:
	nop
	
    ;push	openPrompt
    ;call	PrintString
    ;call	Printendl
     
		movzx	eax, BYTE [bVal]	
		movzx eax, WORD [bVal]	;Will grab memory from the code segment because bVal is one byte		
   
		movzx eax, BYTE [sVal]	;mov zero extend
		movsx eax, BYTE [sVal]	;mov signed extend
	 
    ;push	closePrompt			;The prompt address - argument #1
    ;call  	PrintString
    ;call  	Printendl
    
    nop
;
;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
