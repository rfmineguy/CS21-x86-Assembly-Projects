;
;This program will test out the functions library to show the user of number formatted output
;

;
;Include our external functions library functions
%include "./functions64.inc"

SECTION .data
	openPrompt		db	"Welcome to my Program", 0h
	closePrompt		db	"Program ending, have a nice day", 0h
	side1Prompt		db	"Enter the length of the first side of the right triangle (float) : ", 0h
	side2Prompt		db	"Enter the length of the second side of the right triangle (integer) : ", 0h

	floatingPointError 	db	"Error with value entered. Needs to be valid floating point.", 0h
	integerError		db	"Error with value entered. Needs to be valid integer.", 0h
	lessThanEq100Msg	db	"Hypotenuse is less than or equal to 100 units long", 0h
	greaterThan100Msg	db	"Hypotenuse is more than 100 units long", 0h

	zero			dq	0
	oneHundred		dq	100.00
SECTION .bss
	side1		resq	1
	side2		resq	1
	result		resq	1

SECTION     .text
	global      _start

_start:
	nop
	
    push	openPrompt
    call	PrintString
    call	Printendl 

    ;
    ;	RETRIEVE USER FLOATS [BEGIN]
    ;
			  			; Float 1 validation loop
    jmp 	ValidationSide1			;
    ValidationSide1Err:				;
    	push	floatingPointError		;  - print error message for invalid float
	call	PrintString			;  -
	call	Printendl			;  -
    ValidationSide1:				;
    	push 	side1Prompt			;  - print prompt
    	call	PrintString			;  - 
    	call	InputFloat			;  - 
	jc 	ValidationSide1Err		;  - if the entered value is not a float then restart
	fldz
	fcomi	st0, st1
	jae	ValidationSide1Err
	mov	[side1], rax

    jmp 	ValidationSide2			; Float 2 validation loop
    ValidationSide2Err:				;
    	push	integerError			;  - print error message for invalid integer
	call	PrintString			;  -
	call	Printendl			;  -
    ValidationSide2:				;
    	push	side2Prompt			;  - print prompt
	call	PrintString			;  - 
	call	InputUInt			;  - call function to retrieve float from stdin
	jc	ValidationSide2Err		;  - if the entered value is not a float then restart
	cmp	rax, 0
	jle	ValidationSide2Err
	mov 	[side2], rax
    ;
    ;	RETRIEVE USER FLOATS [END]
    ;

    ;
    ;	CALCULATE TRIANGLE HYPOTENUSE [BEGIN]
    ;		z : hypotenuse
    ;		x : side1
    ;		y : side2
    ;		z = sqrt ( (x*x) + (y*y) )
    ;

    finit
    fld		QWORD [side1]
    fld		QWORD [side1]
    fmul
    fild	QWORD [side2]
    fild	QWORD [side2]
    fmul
    fadd
    fsqrt
    fst		QWORD [result]
    
    ;
    ;	CALCULATE TRIANGLE HYPOTENUSE [END]
    ;

    ;
    ;	LESS THAN 100 BLOCK [BEGIN]
    ;

    finit
    fld		QWORD [oneHundred]
    fld		QWORD [result]
    fcom
    fnstsw	ax
    sahf
    ja		GreaterThan100
    jbe		LessThanEq100
   
    LessThanEq100:
    	push	lessThanEq100Msg		;  - print message for hypoteneus less than 100
	call	PrintString			;  -
	call	Printendl			;  -

    push	QWORD [result]
    push	4
    call 	PrintQWFloat
    call	Printendl
    jmp Exit
    GreaterThan100:
    	push	greaterThan100Msg		;  - print message for hypoteneus greater than 100
	call	PrintString			;  -
	call	Printendl			;  -
    
    push	QWORD [result]
    push	4
    call 	PrintQWFloat
    call	Printendl
    jmp	Exit

FloatingPointError:
	push floatingPointError
	call PrintString
	call Printendl
	ret
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
        push	closePrompt			;The prompt address - argument #1
        call  	PrintString
	call  	Printendl

	mov	rax, 60					;60 = system exit
	mov	rdi, 0					;0 = return code
	syscall						;Poke the kernel
