
section .data
;variables with values go here
	A: dq 12.875
	B: dq 87.421
	C: dq 5.645
	D: dq 2.53
	E: dq 9.56
	
section .bss
;reserved memory goes here
	Z: resq 1
	temp1: resq 1
	temp2: resq 1

section .text
;Your program code goes here
	global  _start 
	_start:

	nop	
	;Your program code should go here
	;(A+B)/C
	finit
	fld	[A]
	fld	[B]
	fadd
	fld	[C]
	fdiv

	;(D-A)+E
	


	nop
	;Do not remove/change the lines below
	;These exit out of the application and back
	;to linux in an orderly fashion
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
