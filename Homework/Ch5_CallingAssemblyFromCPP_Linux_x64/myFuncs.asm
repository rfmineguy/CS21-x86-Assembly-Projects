;Make these functions available to other files
global addTwo
global addArray
global swapArrays

;Description :addTwo -> Adds two values together
;
;	rdi :: the first parameter
;	rsi :: the second parameter
;	rax :: return register
addTwo:      
	nop
	mov rax, rdi	;move first parameter to rax		
	add rax, rsi	;add second parameter to rax
	ret
;addTwo END

;Description :addArray -> Adds all the elements of an array of qwords
;
;	rdi :: first param (pointer to an array of qwords, 8 byte elements)
;	rsi :: second param (number of items in array)
;	rax :: return register
addArray:
	push rcx		;save rcx
	mov rcx, rsi		;loop counter
	mov rax, 0		;zero out rax for accurate sum
	L1:
		add rax, [rdi]	;add 8 byte value at address rdi to rax
		add rdi, 8	;add 8 bytes to rdi, so we point to the next element
	loop L1
	pop rcx			;restore rcx
	ret
;addArray END


;Description :swapArrays -> Switches the contents of two same length arrays with each other
;
;Precondition : arrays must be same length
;
;	rdi :: first param (pointer to qword array, 8 byte elements)
;	rsi :: second param (pointer to qword array, 8 byte elements)
;	rdx :: third param (length of the arrays)
;	rax :: "void function" (no specific return type)
swapArrays:
	push rcx		;Save loop counter register
	push rax		;I figured that this was ok, because for a "void function" a programmer might assume that it doesn't change rax
	mov rcx, rdx		;move third param (length) to loop counter
	L2:
		mov rax, [rdi]	; Swap code
		mov rdx, [rsi]	;
		mov [rdi], rdx	;
		mov [rsi], rax	;

		add rdi, 8	; Increase array pointers by 8 bytes (quadword) since we expect long long sized elements
		add rsi, 8	;
	loop L2
	pop rax
	pop rcx
	ret
;swapArrays END
