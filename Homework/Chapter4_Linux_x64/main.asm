;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions64.inc"

SECTION .data
	welcomePrompt			db	"Welcome to my Program", 0h
	ourDataPrompt 		db	"Array Data", 0h
	dashPrompt				db	"-------", 0h
	space							db	" ", 0h

	row1Prefix				db	"  Row 1: ", 0h
	row2Prefix				db  "  Row 2: ", 0h
	row3Prefix				db	"  Row 3: ", 0h
	row4Prefix				db  "  Row 4: ", 0h

	closePrompt				db	"Program ending, have a nice day", 0h
	resultsPromptHex	db	"Printing the contents of 'results' in hex: ", 0h
	resultsPromptDec	db	"Printing the contents of 'results' in dec: ", 0h

	row1					db	11h, 22h, 33h, 44h					;define 4 bytes				 (1 byte each)
		.sizeof				equ	$-row1
		.lengthof			equ row1.sizeof / 1
	row2					dw	1111h, 2222h, 3333h, 4444h  ;define 4 words				 (2 bytes each)
		.sizeof				equ	$-row2
		.lengthof			equ row2.sizeof / 2
	row3					dd  1111h, 2222h, 3333h, 4444h	;define 4 double words (4 bytes each)
		.sizeof				equ	$-row3
		.lengthof			equ row3.sizeof / 4
	row4					dq  2222h, 4444h, 6666h, 8888h  ;define 4 quad words   (8 bytes each)
		.sizeof				equ	$-row4
		.lengthof			equ row4.sizeof / 8	

SECTION .bss
	results				resq	row1.lengthof
		.sizeof				equ $-results
		.lengthof			equ results.sizeof / 8

SECTION     .text
	global      _start

_start:
	nop
 	
    push	welcomePrompt
    call	PrintString
    call	Printendl

		push	ourDataPrompt
		call	PrintString
		call	Printendl
    
    push	dashPrompt
    call	PrintString
    call	Printendl
 
		push  row1Prefix
		call  PrintString

		mov		rcx, row1.lengthof			; use rcx as counter, row1 length
		mov		r8,	 row1								; use r8 as indirect address pointer
		Lr1:													;
			mov rax, 0									; clear out rax for reliable math
			mov al, [r8]								; move byte at r8 into al (array value)
			push rax										; push the value of rax for Print64bitNumHex
			call Print64bitNumHex				;
			push space									;	push a space character for PrintString
			call PrintString						;
			add r8, 1										; increment our indirect address pointer
		loop Lr1											;
		call Printendl								;

		push	row2Prefix
		call	PrintString

		mov		rcx, row2.lengthof			; use rcx as counter, row1 length
		mov		r8,	 row2								; use r8 as indirect address pointer
		Lr2:													;
			mov rax, 0									; clear out rax for reliable math
			mov al, [r8]								; move byte at r8 into al (array value)
			push rax										; push the value of rax for Print64bitNumHex
			call Print64bitNumHex				;
			push space									;	push a space character for PrintString
			call PrintString						;
			add r8, 2										; increment our indirect address pointer
		loop Lr2											;
		call Printendl								;
 
		push	row3Prefix
		call	PrintString

		mov		rcx, row3.lengthof			; use rcx as counter, row1 length
		mov		r8,	 row3								; use r8 as indirect address pointer
		Lr3:													;
			mov rax, 0									; clear out rax for reliable math
			mov al, [r8]								; move byte at r8 into al (array value)
			push rax										; push the value of rax for Print64bitNumHex
			call Print64bitNumHex				;
			push space									;	push a space character for PrintString
			call PrintString						;
			add r8, 4										; increment our indirect address pointer
		loop Lr3											;
		call Printendl								;
 
		push	row3Prefix
		call	PrintString

		mov		rcx, row4.lengthof			; use rcx as counter, row1 length
		mov		r8,	 row4								; use r8 as indirect address pointer
		Lr4:													;
			mov rax, 0									; clear out rax for reliable math
			mov al, [r8]								; move byte at r8 into al (array value)
			push rax										; push the value of rax for Print64bitNumHex
			call Print64bitNumHex				;
			push space									;	push a space character for PrintString
			call PrintString						;
			add r8, 8										; increment our indirect address pointer
		loop Lr4											;
		call Printendl								;
 
 		
		mov		rcx, row1.lengthof			; initialize loop counter to our row1 length
		mov		r8, 0										; row1 offset, bytes
		mov		r9, 0										; row2 offset, words
		mov		r10, 0									; row3 offset, dwords
		mov		r11, 0									; row4 offset, qwords
		mov		r12, 0									; results offset, qwords
		
		L1:														; Begin calculation loop
			mov rax, 0									;   Clear rax so we can do predictible math with it
			mov al,  [row1 + r8]				;		Add the byte at offset r8 in row1 to al reg			(byte)
			add ax,  [row2 + r9]				;		Add the word at offset r9 in row2 to ax reg			(word)
			add eax, [row3 + r10]				;		Add the dword at offset r10 in row3 to eax reg	(dword)
			add rax, [row4 + r11]				;		Add the qword at offset r11 in row4 to rax reg	(qword)
			mov [results + r12], rax		;		Save the final value in rax back into memory, using r12 as our offset into the 'results' array

			add r8,  1									; Move the row1 offset counter forward by 1 byte      (next spot)
			add r9,  2									; Move the row2 offset counter forward by 2 bytes			(next spot)
			add r10, 4									; Move the row3 offset counter forward by 4 bytes			(next spot)
			add r11, 8									; Move the row4 offset counter forward by 8 bytes     (next spot)
			add r12, 8									; Move the results offset counter forward by 8 bytes  (next spot)
		loop L1												; Loop back to L1 if ecx isn't 0

		push resultsPromptHex					;Print 
		call PrintString
		call Printendl
		
		mov rcx, 0
		mov rcx, row1.lengthof
		mov r12, 0										; Using r12 to keep consistency with the above (use for 'results' offset)

		L2:
			mov rax, [results + r12]
			push rax			
			call Print64bitNumHex
			call Printendl
			add  r12, 8
		loop L2		

		call Printendl
		
		push resultsPromptDec
		call PrintString
		call Printendl
	
		mov rcx, 0
		mov rcx, row1.lengthof
		mov r12, results		

		L3:
			mov rax, [r12]
			push rax
			call Print64bitNumDecimal
			call Printendl
			add r12, 8
			loop L3

    push	closePrompt			;The prompt address - argument #1
    call  	PrintString
    call  	Printendl
    
    nop
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
