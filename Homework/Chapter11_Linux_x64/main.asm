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
	arg1		resb	255		;acts as "fromFile"
	arg2		resb	255		;acts as "toFile"

SECTION     .text
	global      _start

_start:
	nop
	
	pop	rax
	pop	rbx
	pop	rcx

	push	QWORD [rbx]
	call	PrintString
	call	Printendl

	push	openPrompt
    	call	PrintString
    	call	Printendl
    	

    	push	closePrompt			;The prompt address - argument #1
    	call  	PrintString
    	call  	Printendl
    	
	call	Exit
    	nop

RetrieveCmdLineArgs:
	pop 	rax				; pop the first argument off the stack
	mov	[numArgs], rax			; save the number of arguments to data
	
	cmp 	rax, 3				; required number of args (program name, arg1, arg2)
	jne	ArgError
	
	pop	rax				; pop the second arg off the stack (file1)
	mov	[arg1], rax			; save it

	pop 	rax				; pop the third arg off the stack (file2)
	mov	[arg2], rax			; save it
	ret


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
