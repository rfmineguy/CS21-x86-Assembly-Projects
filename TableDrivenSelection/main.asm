;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions.inc"

SECTION .data
	openPrompt	db	"Welcome to my Program", 0h
	closePrompt	db	"Program ending, have a nice day", 0h

	APrompt			db	"We found A", 0h
	BPrompt			db	"We found B", 0h
	CPrompt			db	"We found C", 0h
	DPrompt			db	"We found D", 0h
	defPrompt		db	"We didn't find the value", 0h
	
	CaseTable		db	'A'
							dd	ProcessA									;get the address of ProcessA and store it here
					.entrySize equ ($-CaseTable)
							db  'B'
							dd  ProcessB
							db  'C'
							dd  ProcessC
							db  'D'
							dd  ProcessD
					.numEntries equ ($-CaseTable)/CaseTable.entrySize
; switch (x) {
; case 'A': ProcessA(); break;
; case 'B': ProcessB(); break;
; case 'C': ProcessC(); break;
; case 'D': ProcessD(); break;	
SECTION .bss
	

SECTION     .text
	global      _start

_start:
	nop
	
    push	openPrompt
    call	PrintString
    call	Printendl
    ;
		; SWITCH BEGIN
		; 
		mov esi, CaseTable
		mov ecx, CaseTable.numEntries
		mov al, 'e'										;value to look for in switch

		L1: cmp al, [esi
				jne L2
				call NEAR [esi + 1]		;NEAR means function is within this code segment
				jmp L3										;jump out of the switch
		L2:
				add esi, CaseTable.entrySize
				loop L1		
				call DefaultFunction					;default condition

		;
		; SWITCH END
		;
		L3:
    
    push	closePrompt			;The prompt address - argument #1
    call  	PrintString
    call  	Printendl
    
    nop
;
;Setup the registers for exit and poke the kernel
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel



ProcessA:
	nop
	push APrompt
	call PrintString
	call Printendl
	ret

ProcessB:
	nop
	push BPrompt
	call PrintString
	call Printendl
	ret

ProcessC:
	nop
	push CPrompt
	call PrintString
	call Printendl
	ret

ProcessD:
	nop
	push DPrompt
	call PrintString
	call Printendl
	ret

DefaultFunction:
	nop
	push defPrompt
	call PrintString
	call Printendl
	ret
