; Assembler 32bit template

bits 32
section .data
;variables with values go here
	anArray   db 10h, 20h, 30h, 40h, 50h
	.LENGTHOF equ ($-anArray)
	.SIZEOF   equ ($-anArray)/1

	arrArray2 dw 20h, 40h, 60h, 80h, 100h
	.LENGTHOF equ ($-arrArray2)
	.SIZEOF   equ ($-arrArray2)/2

section .bss
;reserved memory goes here
section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here

	mov eax, anArray.LENGTHOF 	;put the number of bytes of 'anArray' into eax
	mov eax, anArray.SIZEOF		;put the number of entries of 'anArray' into eax
	
	mov eax, arrArray2.LENGTHOF 	;put the number of bytes of 'anArray' into eax
	mov eax, arrArray2.SIZEOF	;put the number of entries of 'anArray' into eax
	
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
