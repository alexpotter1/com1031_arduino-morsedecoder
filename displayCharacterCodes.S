;;; Group 12 COM1031 Coursework
;;; Alex Potter, Adrien Royer, Nick Sweeting and Alfin Jose

#define __SFR_OFFSET 0
#include <avr/io.h>

	;;; Which segments of the display are connected to which pins?
	DISP_A = 7
	DISP_B = 1
	DISP_C = 2
	DISP_D = 3
	DISP_E = 4
	DISP_F = 5
	DISP_G = 6
	DISP_H = 0		; there isn't really a segment H but this is the DP2 dot (on Arduino pin A0)


	;;; Turn on all parts of display
	DISP_ALL = _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G)
	DISP_DOT = _BV(DISP_H)

	;;; Hex digits 0-F
	;;; logical 0 = segment is on

	DISP_CHAR_0 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | DISP_DOT)
	DISP_CHAR_1 = ~(_BV(DISP_B) | _BV(DISP_C) | DISP_DOT)
	DISP_CHAR_2 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_G) | DISP_DOT)
	DISP_CHAR_3 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_G) | DISP_DOT)
	DISP_CHAR_4 = ~(_BV(DISP_B) | _BV(DISP_C) | _BV(DISP_F) | _BV(DISP_G) | DISP_DOT)
	DISP_CHAR_5 = ~(_BV(DISP_A) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_F) | _BV(DISP_G) | DISP_DOT)
	DISP_CHAR_6 = ~(_BV(DISP_A) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_G) | DISP_DOT)
	DISP_CHAR_7 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | DISP_DOT)
	DISP_CHAR_8 = ~(DISP_ALL | DISP_DOT)
	DISP_CHAR_9 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_F) | _BV(DISP_G) | DISP_DOT)
	DISP_CHAR_A = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_B = ~(_BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_C = ~(_BV(DISP_A) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F))
	DISP_CHAR_D = ~(_BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_E = ~(_BV(DISP_A) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_F = ~(_BV(DISP_A) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_G = ~(_BV(DISP_A) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_H = ~(_BV(DISP_C) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_I = ~(_BV(DISP_B) | _BV(DISP_C))
	DISP_CHAR_J = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_F))
	DISP_CHAR_K = ~(_BV(DISP_B) | _BV(DISP_C) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_L = ~(_BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F))
	DISP_CHAR_M = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_G))
	DISP_CHAR_N = ~( _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E))
	DISP_CHAR_O = ~( _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F))
	DISP_CHAR_P = ~( _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_Q = ~( _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_R = ~( _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_S = ~( _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_T = ~( _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_U = ~( _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F))
	DISP_CHAR_V = ~( _BV(DISP_C) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_W = ~( _BV(DISP_A) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_X = ~( _BV(DISP_B) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_Y = ~( _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_Z = ~( _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_E) | _BV(DISP_G))

;;; Bit Patterns for Each character to button press pattern
	;;; Dot: Increment then logical shift right (wraparound)
	;;; Dash: Increment then logical shift left (wraparound)

	;;one press

	BIT_PATT_T = 0x00
  BIT_PATT_E = 0x01
	
	;;two press
	BIT_PATT_M = 0x00
	BIT_PATT_N = 0x01
	BIT_PATT_A = 0x02
	BIT_PATT_I = 0x03

	;; Three presses long
	BIT_PATT_O = 0x00
	BIT_PATT_G = 0x01
	BIT_PATT_K = 0x02
	BIT_PATT_D = 0x03   
	BIT_PATT_W = 0x04
	BIT_PATT_R = 0x05
	BIT_PATT_U = 0x06
	BIT_PATT_S = 0x07

	;; Four presses long
	BIT_PATT_Q = 0x02
	BIT_PATT_Z = 0x03
	BIT_PATT_Y = 0x04
	BIT_PATT_C = 0x05
	BIT_PATT_X = 0x06
	BIT_PATT_B = 0x07
	BIT_PATT_J = 0x08
	BIT_PATT_P = 0x09
	BIT_PATT_L = 0x0B
	BIT_PATT_F = 0x0D
	BIT_PATT_V = 0x0E	
	BIT_PATT_H = 0x0F

	;; Five presses long
