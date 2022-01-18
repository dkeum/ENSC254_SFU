;@============================================================================
;@
;@ Student Name 1 Jun Woo Keum
;@ Student 1 # 301335490
;@ Student 1 userid (email) dkeum (dkeum@sfu.ca)
;@
;@ Student Name 2 Amirali Farzaneh
;@ Student 2 # 301292829
;@ Student 2 userid (email) afarzane (afarzane@sfu.ca)
;@
;@ Below, edit to list any people who helped you with the code in this file,
;@      or put ‘none’ if nobody helped (the two of) you.
;@
;@ Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__
;@
;@ Also, reference resources beyond the course textbooks and the course pages on Canvas
;@ that you used in making your submission.
;@
;@ Resources:  ___________
;@
;@% Instructions:
;@ * Put your name(s), student number(s), userid(s) in the above section.
;@ * Edit the "Helpers" line and "Resources" line.
;@ * Your group name should be "<userid1>_<userid2>" (eg. stu1_stu2)
;@ * Form groups as described at:  https://courses.cs.sfu.ca/docs/students
;@ * Submit your file to courses.cs.sfu.ca
;@
;@ Name        : bigAdd.s
;@ Description : bigAdd subroutine for Assignment.
;@ 2021   
;@============================================================================

;@ Tabs set for 8 characters in Edit > Configuration

		GLOBAL	bigAdd
		AREA	||.text||, CODE, READONLY

;@ calculate the Nth Fibonacci number for large values of N

bigAdd	;@ add more lines of code...
	;@ ...
	;@ Modify the next line or remove it

	push	{r4-r12,lr}
	
	;@ Reset the last 32 bits in outputs
	mov 	r6, #0
	str 	r6, [r0, #16]
	
;@-----------Part 1 checking valid --------------
	;@ Check MSB for the number of valid word for both r0 and r1 
	ldr 	r11, [r0,#0]	;@ load the MSB of r0 
	ldr 	r12, [r1,#0]	;@ load the MSB of r1
	;@ check if both are valid
	cmp	r11,	r12
	mov	r6,	r11
	movmi 	r6,	r12
	cmp	r2,	r6
	
	bmi 	endofprogram_Fail 
	
	



;@-----------Part 2 check necessary bytes before for loop----------------------
	;@ if it is valid then go into adding 

	mov 	r9,#4 ;@ initialize max bytes and ;@ initialize counter for iterating through loop
	mul 	r10, r11,r9
	mul	r8 , r12,r9
	mov 	r9,r8
	mov 	r7,#0  ;@ initialize counter for counting num of part additions	
	
	mov	r4,#4
	mul	r5,r4,r2
	mov	r2,r5
	push	{r2}	

;@ finding the max between r10 and r9
	cmp 	r10,r9
	blls	findmax ;@ greater data will be in r10
	movls	r3,#1;@swapped
	movgt	r3,#0;@not swapped
	mov 	r8,r9
	mov	r12,r10

;@ before for loop, r10 = max(num_bytes_operand1, num_bytes_operand2), r7=0, r9= min(num_bytes_operand1, num_bytes_operand2)
 
;@ free registers r4,r5,r6,r11 before loop

;@-----------Part 3 For loop---------------------- 	
addingSubroutine nop

	adds 	r0,r0, #0 ;@clear carry bit
	MRS	r6, CPSR 
	cmp	r9,r7
	addgt 	r7,r7,#4
	MSREQ	CPSR_f,r6
	blgt	doPart 
	sub 	r9, r9,#4
	teq	r9,#0
	bgt	addingSubroutine+8 ;@ keeps looping until the number is not zero
	b	parttwo ;@ last iteration of the loop
		
;@ subroutine for adding the numbers then storing results in r0	
doPart  nop
			
	ldr 	r4,[r0,r7]
	ldr 	r5,[r1,r7]
	mov 	r11,lr
;@	Case when both numbers are just the same
	
	;@32-bit add
	MSR	CPSR_f,r6
	adcs 	r4, r4,r5	;@add
	str	r4, [r0,r7] 	;@store result
	mov 	lr,r11
	mov	pc, lr

	
;@ free registers after loop r4,r5,r11,r12

;@---------PART 4 STILL got more adding to do-----------
parttwo	nop;@MSR	CPSR_f,r6
	pop 	{r2}
	teq 	r10,r7
	beq 	doFirstPart
	b	doSecondPart
	
doFirstPart  nop
	;@str	r7,[r0,#0]
	b	LastPart
	
	


;@---------;@ if a number is still at 2 words but we've only done 1 iteration max_answer is 3 words ------
doSecondPart nop
	;@for loop again 
	MRS	r6, CPSR 
	sub	r10,r12,r7;@sub	r10,r10,r7
	cmp	r10,#0
	addgt 	r7,r7,#4
	blgt	doPart_oneoperand 
	;@MRS	r11, CPSR 
	sub 	r10, r10,#4
	teq	r10,#0
	bgt	doSecondPart+4 ;@ keeps looping until the number is not zero
	;@ if the carry bit is 1 still and and we have enough space to add then do more for loops 		
	bcs	Carryisone_and_StillhaveSpace


	;@ Last iteration 
	lsr 	r7,r7,#2
	str	r7,[r0,#0]
	bcs 	endofprogram_OverFlow ;@ if the carry bit is 1 after the last iteration, then return 1
	b 	endofprogram_Success  ;@ else return 0
	


;@ subroutine for adding the numbers then storing results in r0	
doPart_oneoperand  nop	
	teq 	r3,#1 ;@swapped
	ldreq	r4 ,  [r1,r7]  ;@ load data
	teq	r3,#0 ;@not swapped
	ldreq	r4 ,  [r0,r7]	;@load data
	;@32-bit add
	MSR	CPSR_f,r6
	adcs 	r4, r4,#0	;@add
	str	r4, [r0,r7] 	;@store result
	mov	pc, lr


;@---------LAST PART-----------------------
;@------------- pseudo code------------
;@ if r7 is less than max word count( usually 3) and carry bit is 1 
;@ perform addition until it goes over max word count 
LastPart nop

	;@ if the carry flag is 0 then just return 0
	MRS	r6, CPSR 
	lsrcc 	r7,r7,#2
	strcc	r7,[r0,#0]
	bcc	endofprogram_Success  ;@ else return 0

	;@ if the carry bit is 1 then check afterwards if r7 is less than r2
	
	cmpcs 	r7,r2 ;@
	bge	endofprogram_OverFlow ;@ if the carry bit is 1 after the last iteration, then return -1
	
	MSR	CPSR_f,r6
	movcs 	r2,#1
	addcs 	r10,r10,#4
	strcs	r2,[r0,r10]	
	addcs 	r7,r7,#4
	lsrcs 	r7,r7,#2
	strcs	r7,[r0,#0]
	b endofprogram_Success  ;@ else return 0
	;@bcs 	endofprogram_OverFlow ;@ if the carry bit is 1 after the last iteration, then return -1


Carryisone_and_StillhaveSpace	nop
	
	MRS	r6, CPSR 
	cmp	r7,r2
	lsrge 	r7,r7,#2
	strge	r7,[r0,#0]
	bge	endofprogram_OverFlow ;@ if the carry bit is 1 after the last iteration, then return -1
	MSR	CPSR_f,r6
	;@movcs 	r2,#1
	addcs 	r12,r12,#4
	
	cmp 	r12,r2
	addgt 	r7,r7,#4
	lsrgt 	r7,r7,#2
	strgt	r7,[r0,#0]
	bgt	endofprogram_OverFlow
	MSR	CPSR_f,r6	
	movcs 	r2,#1
	strcs	r2,[r0,r12]	
	addcs 	r7,r7,#4
	lsrcs 	r7,r7,#2
	strcs	r7,[r0,#0]
	b endofprogram_Success  ;@ else return 0
	
	





;@---------------HELPER FUNCTION---------------
;@-------Finds max and swaps rhe values--------
findmax	nop
	mov 	r8,r10
	mov	r10,r9
	mov 	r9,r8
	mov pc,lr






	


;@ ending condition
endofprogram_Success	mov r0, #0
			b endofprogram 

endofprogram_Fail 	str r6, [r0, #0]	;@ Largest size out of two numbers
			mov r6, #0		;@ Reset all values to 0 on stack when program fails
			str r6, [r0, #4]
			str r6, [r0, #8]
			str r6, [r0, #12]
			str r6, [r0, #16]
			mov r0, #-1 
			b endofprogram 

endofprogram_OverFlow	mov r0, #1
			b endofprogram 
		
endofprogram 	pop 	{r4-r12,lr}
		mov	pc, lr
		end
