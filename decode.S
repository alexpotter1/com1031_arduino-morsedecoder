;;; Morse signal decoder
;;; Group 12 COM1031 Coursework
;;; Alex Potter, Adrien Royer, Nick Sweeting, Alfin Jose

#include "displayCharacterCodes.S"

  ;;; Atmel ATmega328p runs @ 16MHz for Arduino Uno
  CPU_FREQUENCY = 16000000

  ;;; Time prescaler set to 1024, so 1 timer tick == 1024 CPU ticks
  ;;; Hence timer ticks per second = frequency / (size of timer (size of high byte for timer1) * 1024)
  TICK_COUNT = CPU_FREQUENCY / (256*1024)

  ;;; 200ms is equal to 12.21 timer ticks (0.2 seconds worth of ticks)
  ;;; Anything longer is a dash, anything shorter is a dot
  MORSE_SIGNAL_BOUNDARY = 2 * TICK_COUNT / 10
  INTER_SIGNAL_BOUNDARY = 2 * MORSE_SIGNAL_BOUNDARY
  
  one_press:
    ; r28 stores bit pattern of morse signal
    ; 0x00 = one dash
    cpi r28, BIT_PATT_T
    breq displayT
    
    ; 0x01 = one dot
    cpi r28, 0x01       
    breq displayE
    
    
    ; If neither...
  	jmp checkSequenceNotMatched
  
  two_press:
  	cpi r28, BIT_PATT_A
  	breq displayA
  
  	cpi r28, BIT_PATT_N
  	breq displayN
  
  	cpi r28, BIT_PATT_M
  	breq displayM
  
  	cpi r28, BIT_PATT_I
  	breq displayI
  
  	jmp checkSequenceNotMatched

  three_press:
	cpi r28, BIT_PATT_O
  	breq displayO
  	
	cpi r28, BIT_PATT_G
  	breq displayG
  
	cpi r28, BIT_PATT_K
  	breq displayK
  
	cpi r28, BIT_PATT_D
  	breq displayD
  
	cpi r28, BIT_PATT_W
  	breq displayW
  
	cpi r28, BIT_PATT_R
  	breq displayR
  
	cpi r28, BIT_PATT_U
  	breq displayU
  
	cpi r28, BIT_PATT_S
  	breq displayS
  
    	rjmp checkSequenceNotMatched

  four_press:

	cpi r28, BIT_PATT_Q
  	breq displayQ
  	
	cpi r28, BIT_PATT_Z
  	breq displayZ
  
	cpi r28, BIT_PATT_Y
  	breq displayY
  
	cpi r28, BIT_PATT_C
  	breq displayC
  
	cpi r28, BIT_PATT_X
  	breq displayX
  
	cpi r28, BIT_PATT_B
  	breq displayB
  
	cpi r28, BIT_PATT_J
  	breq displayJ
  
	cpi r28, BIT_PATT_P
  	breq displayP

	cpi r28, BIT_PATT_L
  	breq displayL
  
	cpi r28, BIT_PATT_F
  	breq displayF
  
	cpi r28, BIT_PATT_V
  	breq displayV
  
	cpi r28, BIT_PATT_P
  	breq displayP



        rjmp checkSequenceNotMatched

  ;;; One character codes
  displayE:
    ldi r27, DISP_CHAR_E
    out PORTD, r27
    rjmp cleanupDisplayLetter
    
  cleanupDisplayLetter:
    ldi r27, DISP_DOT
    out PORTC, r27
    jmp endOverflowInterruptStartNewLetter

  displayT:
    ldi r27, DISP_CHAR_T
    out PORTD, r27
    rjmp cleanupDisplayLetter

  ;;; Two character codes
  displayA:
    ldi r27, DISP_CHAR_A
    out PORTD, r27
    rjmp cleanupDisplayLetter

  displayN:
    ldi r27, DISP_CHAR_N
    out PORTD, r27
    rjmp cleanupDisplayLetter

  displayI:
    ldi r27, DISP_CHAR_I
    out PORTD, r27
    rjmp cleanupDisplayLetter

  displayM:
    ldi r27, DISP_CHAR_M
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayO:
    ldi r27, DISP_CHAR_O
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayG:
    ldi r27, DISP_CHAR_G
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayK:
    ldi r27, DISP_CHAR_K
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayD:
    ldi r27, DISP_CHAR_D
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayW:
    ldi r27, DISP_CHAR_W
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayR:
    ldi r27, DISP_CHAR_R
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayU:
    ldi r27, DISP_CHAR_U
    out PORTD, r27
    rjmp cleanupDisplayLetter

 displayS:
    ldi r27, DISP_CHAR_S
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayQ:
    ldi r27, DISP_CHAR_Q
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayZ:
    ldi r27, DISP_CHAR_Z
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayY:
    ldi r27, DISP_CHAR_Y
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayC:
    ldi r27, DISP_CHAR_C
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayX:
    ldi r27, DISP_CHAR_X
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayB:
    ldi r27, DISP_CHAR_B
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayJ:
    ldi r27, DISP_CHAR_J
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayP:
    ldi r27, DISP_CHAR_P
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayL:
    ldi r27, DISP_CHAR_L
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayF:
    ldi r27, DISP_CHAR_F
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayV:
    ldi r27, DISP_CHAR_V
    out PORTD, r27
    rjmp cleanupDisplayLetter

displayH:
    ldi r27, DISP_CHAR_H
    out PORTD, r27
    rjmp cleanupDisplayLetter
