;;; Group 12 COM1031 coursework
;;; Alex Potter, Adrien Royer, Nick Sweeting, Alfin Jose

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

	ldi r30, lo8(characterBitpatterns)
	ldi r31, hi8(characterBitpatterns)

	add r30, r23
	brcc loadBitPatternTableToMemory
	inc r31

	add r30, r21 	; Go to the offset contained in r21
	brcc loadTableToMemory	; if no overflow, load table from Z pointer
	inc r31		; else add overflow to Z high


loadTableToMemory:
	lpm r21, Z	; load r21 with contents of Z pointer

	pop r31
	pop r30
	ret

loadBitPatternTableToMemory:
	lpm r23, Z	; Load r23 with contents of Z
	
	ret

characterCodes:
        .byte DISP_CHAR_0, DISP_CHAR_1, DISP_CHAR_2, DISP_CHAR_3, DISP_CHAR_4, DISP_CHAR_5, DISP_CHAR_6, DISP_CHAR_7, DISP_CHAR_8, DISP_CHAR_9, DISP_CHAR_A, DISP_CHAR_B, DISP_CHAR_C, DISP_CHAR_D, DISP_CHAR_E, DISP_CHAR_F, DISP_CHAR_G, DISP_CHAR_H, DISP_CHAR_I, DISP_CHAR_J, DISP_CHAR_K, DISP_CHAR_L, DISP_CHAR_M, DISP_CHAR_N, DISP_CHAR_O, DISP_CHAR_P, DISP_CHAR_Q, DISP_CHAR_R, DISP_CHAR_S, DISP_CHAR_T, DISP_CHAR_U, DISP_CHAR_W, DISP_CHAR_X, DISP_CHAR_Y, DISP_CHAR_Z

characterBitpatterns:
				.byte BIT_PATT_A, BIT_PATT_N, BIT_PATT_I, BIT_PATT_M
