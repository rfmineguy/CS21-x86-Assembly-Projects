global func1

;func1 is global
;	usable from other files if linked
func1:
	nop
	mov eax, 1
	mov ebx, 2
	call func2
	nop
ret

;func2 is not global
;	not usable from other files when linked
;	only usable from this file
func2:
	nop
ret
