;@============================================================================
;@
;@ Student Name 1: student1
;@ Student 1 #: 301335490
;@ dkeum@sfu.ca
;@
;@ Student Name 2: student2
;@ Student 2 #: 123456782
;@ Student 2 userid (email): stu2 (stu2@sfu.ca)
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
;@ Name        : assembly.s
;@ Description : bigAdd subroutine for Assignment.
;@ Copyright (C) 2021 Craig Scratchley    wcs (at) sfu (dot) ca  
;@============================================================================

;@ Tabs set for 8 characters in Edit > Configuration

#include "asm_include.h"
#include "73x_tim_l.h"
#include "73x_eic_l.h"

	IMPORT	printf
		
	PRESERVE8

	GLOBAL	FIQ_Init
	GLOBAL	FIQ_Handler
	GLOBAL	InitHwAssembly
	GLOBAL	LoopFnc
	AREA	||.text||, CODE, READONLY


	;@ *** modify the below lines for this assignment  ***
	;@ *** make pins of I/O port 0 strobe back and forth between
	;@     all the Bits in the range Bit 0 to Bit 15 ***
	;@  Turn on GPIO0 pin 0     
LoopFnc	LDR 	R12, =GPIO0_BASE
	
	LDR	R11, =GPIO_PIN_0
	bl	SubRt
	
	LDR	R11, =GPIO_PIN_1
	bl	SubRt

	LDR	R11, =GPIO_PIN_2
	bl	SubRt
	
	LDR	R11, =GPIO_PIN_3
	bl	SubRt
	
	LDR	R11, =GPIO_PIN_4
	bl	SubRt

	LDR	R11, =GPIO_PIN_5
	bl	SubRt

	LDR	R11, =GPIO_PIN_6
	bl	SubRt

	LDR	R11, =GPIO_PIN_7
	bl	SubRt
	
	LDR	R11, =GPIO_PIN_8
	bl	SubRt

	LDR	R11, =GPIO_PIN_9
	bl	SubRt

	LDR	R11, =GPIO_PIN_10
	bl	SubRt

	LDR	R11, =GPIO_PIN_11
	bl	SubRt
	
	LDR	R11, =GPIO_PIN_12
	bl	SubRt

	LDR	R11, =GPIO_PIN_13
	bl	SubRt

	LDR	R11, =GPIO_PIN_14
	bl	SubRt

	LDR	R11, =GPIO_PIN_15
	bl	SubRt

	LDR	R11, =GPIO_PIN_14
	bl	SubRt

	LDR	R11, =GPIO_PIN_13
	bl	SubRt

	LDR	R11, =GPIO_PIN_12
	bl	SubRt

	LDR	R11, =GPIO_PIN_11
	bl	SubRt

	LDR	R11, =GPIO_PIN_10
	bl	SubRt

	LDR	R11, =GPIO_PIN_9
	bl	SubRt

	LDR	R11, =GPIO_PIN_8
	bl	SubRt

	LDR	R11, =GPIO_PIN_7
	bl	SubRt

	LDR	R11, =GPIO_PIN_6
	bl	SubRt

	LDR	R11, =GPIO_PIN_5
	bl	SubRt

	LDR	R11, =GPIO_PIN_4
	bl	SubRt

	LDR	R11, =GPIO_PIN_3
	bl	SubRt

	LDR	R11, =GPIO_PIN_2
	bl	SubRt
	
	LDR	R11, =GPIO_PIN_1
	bl	SubRt

	LDR	R11, =GPIO_PIN_0
	bl	SubRt




	
	;@ ^^^ modify the above lines ^^^
	B 	LoopFnc
	;@ MV 	PC, LR

;@--------------------------------------------------------------------------------------------
InitHwAssembly
	;@  Setup GPIO6 - UART0 Tx pin setup (P6.9)     
	LDR 	R12, =GPIO6_BASE
	;@ GPIO_Mode_AF_PP
	LDRH	R1, [R12, #GPIO_PC0_OFS]
	ORR 	R1, R1, #GPIO_PIN_9
	STRH 	R1, [R12, #GPIO_PC0_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC1_OFS]
	ORR 	R1, R1, #GPIO_PIN_9
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC2_OFS]
	ORR 	R1, R1, #GPIO_PIN_9
	STRH 	R1, [R12, #GPIO_PC2_OFS]

	;@ *** modify the below lines for this assignment  ***
	

	;@  Setup GPIO0 pin ALL THE PINS  
	LDR 	R12, =GPIO0_BASE
	LDR	R11, =GPIO_PIN_ALL 

	;@ GPIO_Mode_OUT_PP
	LDRH	R1, [R12, #GPIO_PC0_OFS]
	;@ORR 	R1, R1, #GPIO_PIN_0
	ORR 	R1, R1, r11 
	;@MVN	R1, #0
	STRH 	R1, [R12, #GPIO_PC0_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC1_OFS]
	ORR 	R1, R1, r11
	;@ fill in an instruction to clear bit 0
	;@MVN	R1, #0
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC2_OFS]
	ORR 	R1, R1, r11
	;@MVN	R1, #0
	STRH 	R1, [R12, #GPIO_PC2_OFS]

	;@ ^^^ modify the above lines ^^^
	
	MOV	PC, LR



;@-----------------------------------------------------------------------------------------------------------------------
;@ Delay function
Delayy	push	{r4-r12}
	mov	r4,#255
	mov 	r5,#255
	mov 	r6,#255
	mov 	r7,#5
dlayFnc nop
	sub	r4,r4,#1
	cmp	r4,#0
	sub	r5,r5,#1
	cmp	r5,#0
	bge	dlayFnc	
	
	cmp 	r6,#0
	sub 	r6,r6,#1
	mov	r4,#255
	mov 	r5,#255
	bge	dlayFnc
	mov 	r6,#255
	mov	r4,#255
	mov 	r5,#255
	cmp 	r7,#0
	sub 	r7,r7,#1
	bge	dlayFnc	
	pop	{r4-r12}
	mov 	pc,lr

;@Subroutine for forward strobe
	;@turn off PC1 bit of r11
SubRt	mov	r4,lr
	LDRH 	R1, [R12, #GPIO_PC1_OFS]	
	SUB 	r1,r1,r11
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	
	;@turn on PD bit 0
	LDRH	R1, [R12, #GPIO_PD_OFS]
	ORR 	R1, R1, r11
	STRH 	R1, [R12, #GPIO_PD_OFS]


	bl	Delayy

	;@turn on PC1 bit 0
	LDRH 	R1, [R12, #GPIO_PC1_OFS]	
	ADD 	r1,r1,r11
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	mov pc, r4 




	
	// Below needed for HW7 and HW8
	// void* FIQ_Init (void* IRQ_Top);
	// make sure that FIQ_Init returns IRQ_Top in R0
	// FIQ_Init() will initialize R8 through R12 as desired,
	//     so is a non-conforming subroutine in this regard.
FIQ_Init
	// You can put your FIQ_Init here.
	MOV	PC, LR
	
FIQ_Handler
	// You can put your FIQ_Handler here.
	// At that point, you can remove some code from LoopFnc above at top.
	MOV	PC, LR

		
C_str   DCB  "C_string\n",0
	ALIGN	4

	END
