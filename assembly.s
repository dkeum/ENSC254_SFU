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
;@ Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__none
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
LoopFnc	
	
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
	STRH 	R1, [R12, #GPIO_PC0_OFS]	


	;@LDRH 	R1, [R12, #GPIO_PC1_OFS]
	;@ORR 	R1, R1, r11
	;@STRH 	R1, [R12, #GPIO_PC1_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC2_OFS]
	ORR 	R1, R1, r11
	;@MVN	R1, #0
	STRH 	R1, [R12, #GPIO_PC2_OFS]

	;@ ^^^ modify the above lines ^^^
	

;@ -----------------------------------------------------------------------------------------------------------
;@--------------------------------------------------------------------------------------------------------------
;@ Setup Enhanced Interrupt Controller
	push 	{r0-r12}
	
	LDR 	R12, =EIC_BASE
	;@ (1) enable FIQ globally
	LDRH	R11, [R12, #EIC_ICR]	;@ ENABLE FIQ using ICR
	ORR	R11,R11,#EIC_FIQEnable_Mask
	STRH 	R11, [R12,#EIC_ICR]	
	
	;@ (2) Channel 1 ---> TURNS ON ENABLE FOR TIMER0
	LDRH	R11, [R12, #EIC_FIR]	;@ ENABLE FIPR using ICR
	ORR	R11,R11, #TIM0_FIQChannel 
	STRH 	R11, [R12, #EIC_FIR]
	
	
	;@ globally set up & FIQ channel 0 is enabled 
	;@ now we wait for the pending bit

	pop	{r0-r12}



;@ -----------------------------------------------------------------------------------------------------------
;@--------------------------------------------------------------------------------------------------------------
;@  Setup Timer0 with PWM

	push 	{r0-r12}

	;@ (1) load the TIM0_BASE Address
	
	LDR 	R12, =TIM0_BASE 
	
	;@ in cr1 set olvlb bit to 1
	LDR	R11, [R12, #TIMn_CR1]	;@ CR1
	ORR 	r11,r11,#TIM_OLVLB_Set_Mask
	STRH	r11,[r12,#TIMn_CR1]

	;@Set OCAE bit:
	LDR	R11, [R12, #TIMn_CR1]	;@ CR1
	ORR 	r11,r11,#TIM_OCA_ENABLE_Mask
	STRH	r11,[r12,#TIMn_CR1]

	;@ set pwm bit
	LDR	R11, [R12, #TIMn_CR1]	;@ CR1
	ORR 	r11,r11,#TIM_PWM_Mask
	STRH	r11,[r12,#TIMn_CR1]

	;@ Select the timer clock (ECKGEN) and the prescaler division factor (CC7-CC0)

	;@ set ecken in cr1 to zero which is already done:

	;@ prescaler in cr2 
	LDR	R11, [R12, #TIMn_CR2]	;@ CR2
	ORR 	r11,r11,#64
	STRH	r11,[r12,#TIMn_CR2]


	;@ activate the clock
	LDR	R11, [R12, #TIMn_CR1]	;@ CR1
	ORR 	r11,r11,#TIM_ENABLE_Mask
	STRH	r11,[r12,#TIMn_CR1]

	;@ Activate OCBIE so that if Counter == OCBR, then OCFB bit will be set and generate interrupt
	LDR	R11, [R12, #TIMn_CR2]	;@ CR1
	ORR 	r11,r11,#TIM_IT_OCB
	STRH	r11,[r12,#TIMn_CR2]
	

	;@ no need to initialize OCAR and OCBR
	pop 	{r0-r12}
	MOV	PC, LR




;@---------------------------------------------------------------------------------------------------
;@---------------------------------------------------------------------------------------------------	
	// Below needed for HW7 and HW8
	// void* FIQ_Init (void* IRQ_Top);
	// make sure that FIQ_Init returns IRQ_Top in R0
	// FIQ_Init() will initialize R8 through R12 as desired,
	//     so is a non-conforming subroutine in this regard.
FIQ_Init
	// You can put your FIQ_Init here.
	
	;@r9 contains the value of counter pin number -1 
	;@r8 tells 0 is left direction and 1 is right direction

	TEQ 	R8,#0
	ADDEQ	R9,R9,#1
	CMP 	R9,#17
	SUBEQ	R9,R9,#1
	MOVEQ	r8,#1
	

	TEQ	R8,#1
	SUBEQ	R9,R9,#1
	TEQ	R9,#1
	MOVEQ	R8,#0
	

	LDR 	R12, =GPIO0_BASE	
	MOV	PC, LR
	


;@---------------------------------------------------------------------------------------------------
;@---------------------------------------------------------------------------------------------------	

FIQ_Handler
	// You can put your FIQ_Handler here.
	// At that point, you can remove some code from LoopFnc above at top.
	;@FIQ handler has the job of “moving” a simulated LED to give a strobing
	;@effect.


	;@ move led by one 
	;@ exit


	;@ using code template from lecture 
	STMIA SP!,{r0-r12,LR} ;@ Saving Workspace
	MRS r0,SPSR ;@ Saving SPSR to stack …
	STMIA SP!,{r0} ;@ … in case of further (nested) interruptions
	

	;@ initialize all PC1 back to checked
	;@LDR	R10, =GPIO_PIN_ALL
	;@STRH 	R10, [R12, #GPIO_PC1_OFS]

	;@ use FIQ to generate interrupt then strobe LED
	
	MOV 	R11,#1
	SUB	R9,R9,#1
	LSL	R11,R9

	;@ turn off GPI0-PC1 for current bit 
	;@LDRH 	R10, [R12, #GPIO_PC1_OFS]	
	;@SUB 	R10,R10,R11
	;@STRH 	R10, [R12, #GPIO_PC1_OFS]
	
	;@turn on PD bit for current but
	LDRH	R10, [R12, #GPIO_PD_OFS]
	ORR 	R10, R11, R11
	STRH 	R10, [R12, #GPIO_PD_OFS]
	


	;@clear the Output Compare Flag B (OCFB) in TIM0

	LDR 	R12, =TIM0_BASE
	LDR	R11, [R12, #TIMn_SR]	;@ CR1
	SUB 	r11,r11,#TIM_IT_OCB
	STRH	r11,[r12,#TIMn_SR]
	
	
	;@CLEAR FIQ Pending Bit in the EIC
	LDR 	R12, =EIC_BASE

	LDRH	R11, [R12, #EIC_FIPR]	
	;@ADD	R11,R11, #2 ;@ remember that setting 1 will reset this bit 
	STRH 	R11, [R12, #EIC_FIPR]
	

	

	LDMDB sp!,{r0} ;@ Retrieving SPSR from stack
	MSR SPSR_cxsf, r0 ;@ Restoring SPSR
	LDMDB SP!,{r0-r12,PC}^ ;@ Retrieving Workspace, PC,
	;@ and loading SPSR into CPSR
	MOV	PC, LR

		
C_str   DCB  "C_string\n",0
	ALIGN	4

	END
