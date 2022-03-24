; Assembler 32bit template

bits 32				;32 bit program
section .data
section .bss

section .text
global _start
_start:
    	nop
	
	;Your program code should go here
	mov eax, 5	; Moves constant 5 into eax
	add eax, 6	; Adds constant 6 to eax

	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	ent 80h        ; Call the kernel
