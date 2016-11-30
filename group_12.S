;;;  YOUR CODE SHOULD GO INTO THIS FILE.
;;;	PLEASE ADD YOUR OWN COMMENTED HEADER

;;; just including the standard symbol definitions of all ports:
#define __SFR_OFFSET 0
#include <avr/io.h>

#include "displayCharacterCodes.S"


;;; user code starts from here, as init.S ends with jmp main:

BUTTON = 0		; Button on Arduino pin 8 (PORTB pin 0)

.global main 		; declaring main global, so it can be used in other files

main:

	call test_display

	;;; Switch on button as input (not pressed = 1, pressed = 0)
	cbi DDRB, BUTTON
	sbi PORTB, BUTTON

	;;; Set output of 7 segment
	ldi r16, DISP_ALL
	out DDRD, r16

	ldi r16, DISP_DOT
	out DDRC, r16

	;;; Initialise timer1 control register
	;;; Also enable input capture, overflow interrupts for timer1
	clr r18
	sts TCCR1A, r18
	ldi r18, _BV(OCIE1A) | _BV(ICIE1)
	sts TIMSK1, r18

	call setup_timer1	;setting the timer reset limit, and resetting
	call reset_timer1	;it back to 0

	;;; Enable noise-cancelling and set prescaler properly
	ldi r18, _BV(ICNC1) | _BV(CS12) | _BV(WGM12) | _BV(CS10)
	sts TCCR1B, r18

	sei

;;; Wait for interrupts
interrupt_loop: rjmp interrupt_loop

.global timer1_compa_isr

;;; Trying to keep this as short as possible
timer1_compa_isr:
	rjmp ready_display
	reti

;;; Call this when a morse signal is received, to reset the timeout
setup_timer1:
	push r19

	;;; Set the timer1 high byte to the inter-signal timeout (400ms)
	;;; So load it with 400/16 ~= 25 (in hex)
	ldi r19, 0x19
	sts OCR1AH, r19

	;;; Store zero in timer1 low byte
	clr r19
	sts OCR1AL, r19

	pop r19
	ret

test_display:
	push r21

	ldi r21, ~(DISP_ALL)
	out PORTD, r21
	ldi r21, ~(DISP_DOT)
	out PORTC, r21

	pop r21
	ret

ready_display:
	push r21

	;;; Inverse logic
	;;; Turn everything off except dot
	ldi r21, DISP_ALL
	out PORTD, r21
	ldi r21, ~(DISP_DOT)
	out PORTC, r21

	pop r21
	ret

reset_timer1:

	push r17

	clr r17			;setting timer back to 0
	sts TCNT1H r17		;high bit
	sts TCNT1L r17		;low bit

	pop r17

	ret
