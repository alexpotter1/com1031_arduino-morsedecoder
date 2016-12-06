;;;  YOUR CODE SHOULD GO INTO THIS FILE.
;;;	PLEASE ADD YOUR OWN COMMENTED HEADER

;;; just including the standard symbol definitions of all ports:
#define __SFR_OFFSET 0
#include <avr/io.h>

#include "decode.S"
#include "displayCharacterCodes.S"


;;; user code starts from here, as init.S ends with jmp main:

BUTTON = 0		; Button on Arduino pin 8 (PORTB pin 0)

.global main 		; declaring main global, so it can be used in other files

main:

	call test_display

	;;; Switch on button as input (not pressed = 1, pressed = 0)
	cbi DDRB, BUTTON
	sbi PORTB, BUTTON
	sbi DDRB, 1

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

	;;; Enable noise-cancelling and set prescaler properly
	ldi r18, _BV(ICNC1) | _BV(CS12) | _BV(WGM12) | _BV(CS10)
	sts TCCR1B, r18

	; Clear timer1 overflow register, just in case
	clr r22

	clr r27
	clr r28
	clr r29

	; Global Interrupt Enable
	sei

;;; Wait for interrupts
interrupt_loop: rjmp interrupt_loop

.global timer1_compa_isr

;;; Timer1 has reached OCR1AH
timer1_compa_isr:

	sbi PORTB, 1
	push r16
	in r16, SREG
	push r16


	lds r16, TCCR1B
	; Is the sequence length = 0?
	cpi r29, 0x00
	brne checkSequence

	rcall readyDisplay

	;;; Button is being held down, so set timer overflow register (r22)
	ser r22
	
	clr r29

	;;; Cleanup and end timer1_compa_isr
	rjmp endOverflowInterrupt

checkSequence:
	cbi PORTB, 1
	cpi r29, 0x01
	breq onePress

	cpi r29, 0x02
	breq twoPress

	rcall test_display

readyDisplay:
	jmp ready_display

.global endOverflowInterrupt
endOverflowInterrupt:
	pop r16
	out SREG, r16
	pop r16
	reti
	
onePress:
	jmp one_press 
	
twoPress:
	jmp two_press

.global timer1_cpt_isr
; Handle button input event
timer1_cpt_isr:
	; Save SREG
	push r8
	in r8, SREG
	push r8

	cbi PORTD, 3

	; Save input capture timer to r8
	lds r8, ICR1L
	lds r8, ICR1H

	;; Debounce Button

	push r17

	mov r17, r23
	or r17, r8

	breq debounce

	pop r17

	; Check for rising or falling edge
	push r17
	lds r17, TCCR1B
	; skip next if rising edge (ICES=1 for rising, ICES=0 for falling)
	sbrs r17, ICES1
	; skip pressed if button is released
	rjmp pressed
	rcall released


	andi r17, ~(_BV(ICES1))

	rjmp invertEdgeDetection

pressed:

	ori r17, _BV(ICES1)	; expects next button change to be rising edge

invertEdgeDetection:
	sts TCCR1B, r17

end_timer1_cpt_isr:
	pop r17
	pop r8
	out SREG, r8
	pop r8
	reti

debounce:

	pop r17
	pop r8
	out SREG, r8
	pop r8

	reti

released:

	push r16
	push r27

	inc r29			; increment the button press counter

	ldi r16, MORSE_SIGNAL_BOUNDARY ; testing whether dot or dash
	cp r8,r16
	brcs short_press		; if dot (short press) jump to short_press
	brcc long_press

long_press:

	;; here store that the press was a dash
	rol r28
	inc r28

	; display T for now
	;ldi r27, DISP_CHAR_T
	; Set pins, reset the timer and return to ISR
	rcall reset_timer1
	rjmp returnFromPressed


short_press:
	;; here store that the press was a dot
	rol r28
	clr r27

	rcall reset_timer1
	rjmp returnFromPressed

returnFromPressed:
	pop r27
	pop r16
	; reset timer overflow, set timer to zero
	clr r22
	; Going back to ISR
	ret

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

	clr r17			; setting timer back to 0
	sts TCNT1H, r17		; high bit
	sts TCNT1L, r17		; low bit

	pop r17
	ret
