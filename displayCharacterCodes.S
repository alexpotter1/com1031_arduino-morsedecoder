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

	DISP_CHAR_0 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F))
	DISP_CHAR_1 = ~(_BV(DISP_B) | _BV(DISP_C))
	DISP_CHAR_2 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_3 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_G))
	DISP_CHAR_4 = ~(_BV(DISP_B) | _BV(DISP_C) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_5 = ~(_BV(DISP_A) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_6 = ~(_BV(DISP_A) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_7 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C))
	DISP_CHAR_8 = ~(DISP_ALL)
	DISP_CHAR_9 = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_A = ~(_BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_B = ~(_BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_C = ~(_BV(DISP_A) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F))
	DISP_CHAR_D = ~(_BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_E = ~(_BV(DISP_A) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_F = ~(_BV(DISP_A) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP-CHAR_G = ~(_BV(DISP_A) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
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
	DISP_CHAR_V = ~( _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_E))
	DISP_CHAR_W = ~( _BV(DISP_A) | _BV(DISP_D) | _BV(DISP_E) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_X = ~( _BV(DISP_B) | _BV(DISP_E) | _BV(DISP_G))
	DISP_CHAR_Y = ~( _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_D) | _BV(DISP_F) | _BV(DISP_G))
	DISP_CHAR_Z = ~( _BV(DISP_A) | _BV(DISP_B) | _BV(DISP_C) | _BV(DISP_E) | _BV(DISP_G))
