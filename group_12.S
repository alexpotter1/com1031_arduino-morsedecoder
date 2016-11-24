;;;  YOUR CODE SHOULD GO INTO THIS FILE.
;;;	PLEASE ADD YOUR OWN COMMENTED HEADER

;;; just including the standard symbol definitions of all ports:
#define __SFR_OFFSET 0
#include <avr/io.h>

#include "displayCharacterCodes.S"

	
;;; user code starts from here, as init.S ends with jmp main:

	.global main 		; declaring main global, so it can be used in other files
main:
	call test_display


test_display:
	push r21

	ldi r21, DISP_ALL
	out DDRD, r21

	pop r21
	ret
