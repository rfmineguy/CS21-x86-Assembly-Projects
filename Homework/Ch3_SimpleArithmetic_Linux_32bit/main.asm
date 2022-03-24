;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data
	openPrompt		db	"Welcome to my Program", 0h
	closePrompt		db	"Program ending, have a nice day", 0h
	equation1prompt	db	"byteVar + (wordVar + dWordVar) : ", 0h
	equation2prompt	db  "(byteVar + dWordVar) - wordVar : ", 0h
	
	byteVar			db  0ffh	
	wordVar			dw	2000h
	dWordVar		dd	30000h
	dWordVar2		dd	444h
	array1			TIMES 5000 db 0ffh

SECTION .bss
	array2			TIMES 1000 resw 1

SECTION     .text
	global      _start

_start:
	nop

  push	openPrompt
  call	PrintString
  call	Printendl
														;Perform the first arithmetic sequence = byteVar + (wordVar + dWordVar)    
	mov eax,		0							;	zero out eax so we don't get undef behavior
	add ax,			[wordVar]			;	Add 2 byte value to ax (2 byte reg)
	add eax,		[dWordVar]		;	Add 4 byte value to eax (4 byte reg)
	add al,			[byteVar]			;	Move value of 'byteVar' into al(1 byte)
	mov [dWordVar2], eax			;	Move eax into our result variable
	
	push equation1prompt			;Print out the first prompt string
	call PrintString					;

	push eax									;Print out the result of the first expression
	call Print32bitNumHex			;
	call Printendl						;

														;Perform the second arithmetic sequence
	mov eax,		0							;	zero out eax
	add al,			[byteVar]
	add eax,		[dWordVar]
	sub eax,		DWORD [wordVar]
	mov [dWordVar2], eax
	
	push equation2prompt
	call PrintString

	push eax
	call Print32bitNumHex
	call Printendl
	
 
  push	closePrompt			;The prompt address - argument #1
  call  PrintString
  call  Printendl
    
  nop
;
;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
