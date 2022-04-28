;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions64.inc"

;
; NOTE: This was tested using population based variance calculation
;	via https://www.calculatorsoup.com/calculators/statistics/variance-calculator.php
;
;

SECTION .data
	openPrompt		db	"Welcome to my Program", 0h
	closePrompt		db	"Program ending, have a nice day", 0h
	SampleArray		dq	-875, -632, -592, -580, -99, 1, 89, 231, 312, 760, 776, 878, 983, 3421
		.sizeof 	equ	$-SampleArray
		.lengthof 	equ 	SampleArray.sizeof/8
		.type		equ	SampleArray.sizeof/SampleArray.lengthof
	originalNotification    db	"This is the original data set", 0h
	valueNotification 	db    	"These are (SampleArray[i] - mean)^2", 0h
	varianceNotification 	db 	"This the variance of the set", 0h
	
SECTION .bss
	mean:			resq	1	;reserve 1 quadword of space for the mean (needs to be used multiple times)
	variance:		resq	1	;reserve 1 quadword of space for the variance

SECTION .text
	global      _start

_start:
	nop
	
    	push	openPrompt
    	call	PrintString
    	call	Printendl

							; Print out the original data set
	push originalNotification			;   - arg #1
	call PrintString				;   - function call to print NUL terminated string
	call Printendl					;   - function call to print newline
	mov rcx, SampleArray.lengthof			;   - loop counter
	mov rdi, SampleArray				;   - store array address
	PrintLoop:					; BeginLoop
		push QWORD [rdi]			;   - arg #1
		call Print64bitSNumDecimal		;   - function call to print 64bit signed decimal
		call PrintComma				;   - function call to print newline
		call PrintSpace
		add rdi, SampleArray.type		;   - move rdi to the next array element
	loop PrintLoop					; EndLoop
	call Printendl					;   - function call to print newline
	call Printendl					;   - function call to print newline
	

							; Sum up all of the elements within SampleArray
	mov rcx, SampleArray.lengthof			;  - loop counter
	mov rdi, SampleArray				;  - store array address
	mov rax, 0					;  - zero rax for accurate calculation
	L1:						; 
		add rax, QWORD [rdi]			;  - add the quad word at rdi to rax
							;
		add rdi, SampleArray.type		;  - move rdi to the next array element
	loop L1						; EndLoop

	mov rcx, SampleArray.lengthof			; Calculate the mean value of the array
	mov rdx, 0					;  - zero out rdx (make sure division properly happens)
	idiv rcx					;  - divide the value calculated above in rax by the length of the array
	mov [mean], rax					;  - save the result to the 'mean' var (quadword)
	

							; Calculate mean difference
	mov rcx, SampleArray.lengthof			;  - loop counter
	mov rdi, SampleArray				;  - store array address
	L2:						; BeginLoop
		mov rax, [mean]				;  - save the mean to rax
		sub [rdi], rax				;  - find the difference between the mean and the current array element
		mov rax, [rdi]				;  - save the difference back into the same array element (i feel like this shouldn't be)
							;
		add rdi, SampleArray.type		;  - move rdi to the next array element
	loop L2						; EndLoop
	

							; Calculate squared mean difference (which is in the array)
	mov rcx, SampleArray.lengthof			;  - loop counter
	mov rdi, SampleArray				;  - store array address
	mov rax, 0					;  - zero rax for accurate calculations
	L3:						; BeginLoop
		mov rax, [rdi]				;  - square current index
		mul rax					;  - 
		mov [rdi], rax				;  - save the squared number back into the current index
							;
		add rdi, SampleArray.type		;  - move rdi to the next array element
	loop L3						; EndLoop


							; Calculate variance of the array
	mov rcx, SampleArray.lengthof			;   - loop counter
	mov rdi, SampleArray				;   - store array addres
	mov rax, 0					;   - zero rax for accurate calculation
	L4:						; BeginLoop
		add rax, [rdi]				;   - add value at rdi to rax
		add rdi, SampleArray.type		;   - move rdi to the next array element
	loop L4						; EndLoop
	mov rcx, SampleArray.lengthof			;   - store the length of the array
	mov rdx, 0					;  - zero out rdx (make sure division properly happens)
	idiv rcx					;   - calculate the average by dividing by the length
	mov [variance], rax				;   - save this value into the variance
							

							; Print the final variance value
	push varianceNotification			;   - arg #1
	call PrintString				;   - function call to print NUl terminated string
	call Printendl					;   - function call to print newline
	
							; Print the variance of the set
	push QWORD [variance]				;   - arg #1
	call Print64bitSNumDecimal			;   - function call to print 64bit signed decimal
    	call Printendl					;   - function call to print newline
	call Printendl					;   - function call to print newline

	push	closePrompt				;The prompt address - argument #1
    	call  	PrintString
    	call  	Printendl
    	
    	nop

;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60				;60 = system exit
	mov		rdi, 0				;0 = return code
	syscall						;Poke the kernel
