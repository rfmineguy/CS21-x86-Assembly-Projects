;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions64.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
		.lengthof equ	$-openPrompt
	closePrompt	db	"Program ending, have a nice day", 0h
	errorPrompt	db	"Not enough args were supplied to the program.", 0ah, "(./main file1.txt file2.txt)", 0h
	keyPrompt	db	"Please enter the key of which to encrypt your file : ", 0h

SECTION .bss
	numArgs		resq	1
	arg1		resq    1		;acts as "fromFile"
	arg2		resq	1		;acts as "toFile"
	kbuff		resb	255		;keyboard buffer used for inputKeyboard function
		.size	equ	$-kbuff

SECTION     .text
	global      _start

_start:
	nop
					;save program args
					; * get number of args
    mov 	rdx, [rsp]		;   - rsp + 0 is the address to the number of arguments supplied
    mov 	[numArgs], rdx		;   - save this address into memory
    cmp 	rdx, 3			;   - deal with argument errors
    jne 	ArgError		;
					; * get first filename
    mov 	rdx, [rsp + 16]		;   - rsp + 16 is the address of the first argument excluding the program name, in our case it is the first filename
    mov 	[arg1], rdx		;   - save this address into memory
    					;
    					; * get second filename
    mov 	rdx, [rsp + 24]		;   - rsp + 24 is the address of the second argument excluding the program name, the second filename 
    mov 	[arg2], rdx		;   - save this address into memory
					
					;these lines are NOT permanent. delete them when finished with program
    mov 	rax, [arg1]		;
    push 	rax			;
    call 	PrintString		;
    call 	Printendl		;
					;
    mov 	rax, [arg2]		;
    push 	rax			;
    call 	PrintString		;
    call 	Printendl		;

					;prompt user for encryption key
    push 	keyPrompt		; - arg1 for PrintString
    call 	PrintString		;
    push 	kbuff			; - arg1 for inputKeyboard (byte array pointer)
    push 	kbuff.size		; - arg2 for inputKeyboard (byte array maxsize)
    call 	inputKeyboard		;
  	 
    push	kbuff
    call	PrintString
    call	Printendl

    push	openPrompt
    push	openPrompt.lengthof
    call	printString
    	
   	
    call	Exit
    nop

;called when not arguments are supplied to the program
ArgError:
	push errorPrompt
	call PrintString
	call Printendl
	jmp Exit

;inputKeyboard
;  Description: 
;  Usage:
;   push buffer		[rsp + 16]
;   push buffer.size  	[rsp + 8]
;  Return:
;   rax contains number of bytes read from keyboard buffer (including \n and \0)
inputKeyboard:
	push rbp
	mov  rbp, rsp

	mov  rax, 0h
	mov  rdi, 0h
	mov  rsi, [rsp + 8]; + 24]	;pushed regs, need to go further passed rsp
	mov  rdx, [rsp + 16]; + 24]
	syscall

	mov rsp, rbp
	pop rbp
	ret 16		;pop off the 2 qwords pushed on

;   push string
;   push lengthof
;   call printString
printString:
	push rbp
	mov  rbp, rsp
	
	mov  rax, 1
	mov  rdi, 1
	mov  rsi, [rsp + 16]
	mov  rdx, [rsp + 8]
	syscall

	mov  rsp, rbp
	pop  rbp
	ret  16
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
