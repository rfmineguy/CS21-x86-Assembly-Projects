; Assembler 32bit template

bits 32
section .data
;variables with values go here
var2 TIMES 20 db "Hello"

list		db	10, 20, 30, 40, 50	;array of bytes
LIST_SIZE 	equ 	($-list)		;'$' references the current address

section .bss
;reserved memory goes here
varRes TIMES 20 resb 5

section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here
	
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
