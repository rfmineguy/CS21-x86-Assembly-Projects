section .data
	source db "This is the source string", 0
		.len equ $-source
	
section .bss
	target resb 0ffh

section .text
	global _start
	_start:
	nop
	mov rsi, source
	mov rdi, target
	mov rcx, source.len
	l1:
		mov rax, 0
		mov al, [rsi]
		mov [rdi], al
		inc rsi
		inc rdi
		loop l1

	nop
	mov rax, 60
	mov rdi, 0
	syscall
