; Assembler 32bit template

bits 32
section .data
;variables with values go here
msg: db "HelloWorld", 10, 0
msg_len: equ $-msg

section .bss
;reserved memory goes here
section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here
    mov eax, 4     ; System call for write
    mov ebx, 1     ; File Descriptor (stdout)
    mov ecx, msg
    mov edx, msg_len
    int 80h

	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
