;;; Group 12 COM1031 coursework
;;; Alex Potter, Adrien Royer, Matt Sweeting, Alfin Jose

#define __SFR_OFFSET 0 
#include <avr/io.h>

#include "displayCharacterCodes.S"

displayDigit:
	;;; Save Z register (16-bit) to stack
	push r30
	push r31

	;;; r21 contains a reference (between 0 and 15) of the digit we want to display
	andi r21, 0xF 	; make sure we cannot display anything outside of the defined range

	ldi r30, lo8(characterCodes)	; put table address into the Z pointer
	ldi r31, hi8(characterCodes)

	add r30, r21 	; Go to the offset contained in r21
	brcc loadTableToMemory	; if no overflow, load table from Z pointer
	inc r31		; else add overflow to Z high

loadTableToMemory:
	lpm r21, Z	; load r21 with contents of Z pointer

	pop r31
	pop r30
	ret

characterCodes:
        .byte DISP_CHAR_0, DISP_CHAR_1, DISP_CHAR_2, DISP_CHAR_3, DISP_CHAR_4, DISP_CHAR_5, DISP_CHAR_6, DISP_CHAR_7, DISP_CHAR_8, DISP_CHAR_9, DISP_CHAR_A, DISP_CHAR_B, DISP_CHAR_C, DISP_CHAR_D, DISP_CHAR_E, DISP_CHAR_F
