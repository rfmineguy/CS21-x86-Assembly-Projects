;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions64.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
	errorPrompt	db	"Some error occurred with your arguments", 0h

SECTION .bss
	numArgs		resq	1
	arg1		resq    1		;acts as "fromFile"
	arg2		resq	1		;acts as "toFile"

SECTION     .text
	global      _start

_start:
	nop

    mov edx, [rsp + 8]
    mov [numArgs], edx

    mov edx, [rsp + 16]
    mov [arg1], edx

    push arg1
    call PrintString
    call Printendl

    push	openPrompt
    call	PrintString
    call	Printendl
    	

    push	closePrompt			;The prompt address - argument #1
    call  	PrintString
    call  	Printendl
    	
	call	Exit
    	nop

ArgError:
	push errorPrompt
	call PrintString

;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
