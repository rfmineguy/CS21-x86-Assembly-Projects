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
		dq	InputStrFunc					;enter input string
	.entrySize	equ $-caseTable					;
		db	'2'						;
		dq	InputEncryptStrFunc				;enter encrypt key
		db	'3'						;
		dq	PrintInputStrFunc				;print input string
		db	'4'						;
		dq	PrintEncryptStrFunc				;print encrypt key
		db	'5'						;
		dq	EncryptFunc					;encrypt/display string
		db	'6'						;
		dq	DecryptFunc					;decrypt/display string
		db	'x'						;
		dq	FuncExit					;
	.numEntries	equ ($-caseTable)/caseTable.entrySize		;	

	inputStringP	db	"Please enter a string: ",0h
	encryptKeyP	db	"Please enter an encryption key: ",0h
	testP		db	"Tes", 02h, "t", 0h
	.length		equ 	$-testP
	defP		db	"Default", 0h

SECTION .bss
	menuInputBuffer		resb	255
	.lengthof		equ 	$-menuInputBuffer

	plainTextInput		resb	255
	.lengthof		equ 	$-plainTextInput

	plainTextEncryptionKey 	resb	255
	.lengthof		equ	$-plainTextEncryptionKey

	encryptedString		resb	255
	.lengthof		equ	$-encryptedString

	decryptedString		resb	255
	.lengthof		equ	$-decryptedString

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

InputStrFunc:
	push inputStringP			;Prompt user for input string
	call PrintString			;
	mov rax, 0				;
	push plainTextInput			;Get input string from user
	push plainTextInput.lengthof		;
	call ReadText				;==============================
	mov BYTE [plainTextInput + rax], 0

	push plainTextInput			;testing only
	call PrintString			;
	call Printendl				;
	
	ret

InputEncryptStrFunc:
	push encryptKeyP			;Prompt user for encrypt key
	call PrintString                        ;
	mov rax, 0                              ;
	push plainTextEncryptionKey		;Get encrypt key from user
	push plainTextEncryptionKey.lengthof    ;
	call ReadText                           ;=============================
	mov BYTE [plainTextEncryptionKey + rax], 0

	push plainTextEncryptionKey		;testing only
	call PrintString			;
	call Printendl				;

	ret

PrintInputStrFunc:
	push plainTextInput
	call PrintString
	call Printendl
	ret

;FuncD - prints the encryption key in plain text
;	 used via the table driven selection
PrintEncryptStrFunc:
	push plainTextEncryptionKey
	call PrintString
	call Printendl
	ret

;FuncE - encrypt the input string using the encryption key
;	would this be easier with indexed addressing
;	store encrypted string in 'encryptedString'
;	finally print the resulting string
EncryptFunc:
	mov rsi, plainTextInput			; keep track of current position in our inputString	(mem addr)
	mov rdi, plainTextEncryptionKey		; keep track of current position in our	encryptKey	(mem addr)
	mov rdx, encryptedString		; keep track of current position in our encryptedString (mem addr)
	
	
	; *(ecryptString + rdx) = *(plainTextInput + rsi) ^ *(plainTextEncryptionKey + rdx)
	EncryptLoop:
		mov rax, 0				; clear rax for accurate calculation
		mov rbx, 0
		mov bl, BYTE [rsi]
		cmp bl, 0h			; 0ah is 'NL' (newline)
		je Break			; we found the newline, break out of the loop
		mov al, BYTE [rsi]			; perform xor encryption on this character
		xor al, BYTE [rdi]			;  - xor is destructive (using ah instead of direct address)
		mov [rdx], BYTE al			;  - store the encrypted character back into the encrypted string
		inc rsi				; move forward in memory to the next bytes
		inc rdi				;  -
		inc rdx				;  -

						; loop rdi back to the start of the encryption key if we are at the end of it
		cmp BYTE [rdi], 0h		; - the encryptKey has \n too, lets use it to denote the end of the key
		jne SkipRDIwrap			;
		mov rdi, plainTextEncryptionKey ; - put the encryption key's address back into rdi and do another loop iteration
		SkipRDIwrap:

	jmp EncryptLoop				; break out within the loop when done, this wont do it for me

	Break:					; we go here when we encountre the newline in the inputString
	push encryptedString
	push 255				; max length of encrypted string
	call PrintText
	call Printendl

	ret


DecryptFunc:
	mov rsi, encryptedString		; keep track of current position in the encrypted string (mem addr)
	mov rdi, plainTextEncryptionKey		; keep track of current position in the encryption key (mem addr)
	mov rdx, decryptedString		; keep track of current position in the decrypted string (mem addr)
	
	DecryptLoop:
		mov rax, 0
		mov rbx, 0
		mov bl, BYTE [rsi]
		cmp bl, 0h
		je BreakDecrypt
		mov al, BYTE [rsi]
		xor al, BYTE [rdi]
		mov [rdx], BYTE al
		inc rsi
		inc rdi
		inc rdx

		cmp BYTE [rdi], 0h
		jne SkipRDIwrapDecrypt
		mov rdi, plainTextEncryptionKey
		SkipRDIwrapDecrypt:

	jmp DecryptLoop
	
	BreakDecrypt:
	push decryptedString
	push 255
	call PrintText
	call Printendl
	ret

DefaultFunc:
	push testP
	push testP.length
	call PrintText
	call Printendl
	ret
FuncExit:
	push closePrompt
	call PrintString
	call Printendl
	call Exit
	ret					;unnecessary return as we exit, but for completion sake

PrintTest:
	;push testP
	;push testP.length
	;call PrintText
	
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
