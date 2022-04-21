;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions64.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h
	menuString	db	"Menu: ", 0h,				;menu data
	.line1		db	"1) Enter a String", 0h,		;
	.line2		db	"2) Enter an Encryption Key", 0h,	;
	.line3		db	"3) Print the input String", 0h,	;
	.line4		db	"4) Print the input Key", 0h,		;
	.line5		db	"5) Encrypt/Display the String", 0h,	;
	.line6		db	"6) Decrypt/Display the String", 0h,	;
	.line7		db	"x) Exit the Programe", 0h		;
	inputPrompt	db	"Please enter one : ", 0h		;
	
	caseTable:							;switch outline
		db	'1'						;
		dq	FuncA						;enter input string
	.entrySize	equ $-caseTable					;
		db	'2'						;
		dq	FuncB						;enter encrypt key
		db	'3'						;
		dq	FuncC						;print input string
		db	'4'						;
		dq	FuncD						;print encrypt key
		db	'5'						;
		dq	FuncE						;encrypt/display string
		db	'6'						;
		dq	FuncF						;decrypt/display string
		db	'x'						;
		dq	FuncExit					;
	.numEntries	equ ($-caseTable)/caseTable.entrySize		;	

	inputStringP	db	"Please enter a string: ",0h
	encryptKeyP	db	"Please enter an encryption key: ",0h
	testP		db	"Test", 0h
	defP		db	"Default", 0h

SECTION .bss
	menuInputBuffer		resb	255
	.lengthof		equ 	$-menuInputBuffer

	plainTextInput		resb	255
	.lengthof		equ 	$-plainTextInput

	plainTextEncryptionKey 	resb	255
	.lengthof		equ	$-plainTextEncryptionKey

SECTION     .text
	global      _start

_start:
	nop
	
    	push	openPrompt			; Display opening message
    	call	PrintString			;
    	call	Printendl			;
    	    
	do_while:
    	call	PrintMenu			; Print the menu

	mov 	rax, 0
	push 	menuInputBuffer			; Get ready to read user input
	push	menuInputBuffer.lengthof	;  - length of input string stored in rax
	call	ReadText			;

	;push	menuInputBuffer			; Display the user's choice
	;call	PrintString			;
	;call	Printendl			;

	mov 	rsi, caseTable			;  	Move address of caseTable to esi
	mov 	rcx, caseTable.numEntries	;
	;mov	rax, 0
	;mov 	al, '1'				; THIS IS TEMPORARY, FIX THIS
	mov 	al, [menuInputBuffer]
	L1:	
		cmp al, [rsi]
		jne L2
		call NEAR [rsi + 1]		; Call a "near"by function
		jmp L3
	L2:
		add rsi, caseTable.entrySize
		loop L1
		call DefaultFunc
	L3:
	jmp do_while		

    	push	closePrompt			;The prompt address - argument #1
    	call  	PrintString
    	call  	Printendl

    	jmp Exit
    	nop

; Print the menu 
;	possible optimizations available
;	
;	Prints the options available
;	Prints an input prompt
PrintMenu:
	push 	menuString
	call	PrintString
	call	Printendl

	push 	menuString.line1
	call	PrintString
	call	Printendl

	push 	menuString.line2
	call	PrintString
	call	Printendl

	push 	menuString.line3
	call	PrintString
	call	Printendl

	push 	menuString.line4
	call	PrintString
	call	Printendl

	push 	menuString.line5
	call	PrintString
	call	Printendl

	push 	menuString.line6
	call	PrintString
	call	Printendl

	push 	menuString.line7
	call	PrintString
	call	Printendl

	push	inputPrompt
	call	PrintString
	ret

FuncA:
	push inputStringP			;Prompt user for input string
	call PrintString			;
	mov rax, 0				;
	push plainTextInput			;Get input string from user
	push plainTextInput.lengthof		;
	call ReadText				;==============================

	ret
FuncB:
	push encryptKeyP			;Prompt user for encrypt key
	call PrintString                        ;
	mov rax, 0                              ;
	push plainTextEncryptionKey		;Get encrypt key from user
	push plainTextEncryptionKey.lengthof    ;
	call ReadText                           ;=============================
	
	push plainTextEncryptionKey		;testing only
	call PrintString			;
	call Printendl				;

	ret
FuncC:
	push plainTextInput
	call PrintString
	call Printendl
	ret

;FuncD
;Stack - the encryption key string pointer
;Returns - nothing
FuncD:
	push plainTextEncryptionKey
	call PrintString
	call Printendl
	ret

FuncE:
	ret
FuncF:
	ret

DefaultFunc:
	push defP
	call PrintString
	call Printendl
	ret
FuncExit:
	push closePrompt
	call PrintString
	call Printendl
	call Exit
	ret					;unnecessary return as we exit, but for completion sake

PrintTest:
	push testP
	call PrintString
	call Printendl
	ret

;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
