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

;;; One Signal length letter
one_press:
	cpi r28, BIT_PATT_T	; r28 stores bit pattern of morse signal
	breq displayT		; 0x00 = one dash	
				
	; 0x01 = one dot
	cpi r28, 0x01       
	breq displayE
    
	; If neither...
  	jmp checkSequenceNotMatched
    
;;; One character codes
displayE:
	ldi r27, DISP_CHAR_E
	rjmp cleanupDisplayLetter

displayT:
	ldi r27, DISP_CHAR_T
	rjmp cleanupDisplayLetter

;;; Two Signal length letter
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

  ;;; Two character codes
displayA:
	ldi r27, DISP_CHAR_A
	rjmp cleanupDisplayLetter

displayN:
	ldi r27, DISP_CHAR_N
	rjmp cleanupDisplayLetter

displayI:
	ldi r27, DISP_CHAR_I
	rjmp cleanupDisplayLetter

displayM:
	ldi r27, DISP_CHAR_M
	rjmp cleanupDisplayLetter
	
;;; Three Signal length letter
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
  
	jmp checkSequenceNotMatched

;;; Three Character codes
displayO:
	ldi r27, DISP_CHAR_O
	rjmp cleanupDisplayLetter
displayG:
	ldi r27, DISP_CHAR_G
	rjmp cleanupDisplayLetter

displayK:
	ldi r27, DISP_CHAR_K
	rjmp cleanupDisplayLetter

displayD:
	ldi r27, DISP_CHAR_D
	rjmp cleanupDisplayLetter

displayW:
	ldi r27, DISP_CHAR_W
	rjmp cleanupDisplayLetter

displayR:
	ldi r27, DISP_CHAR_R
	rjmp cleanupDisplayLetter

displayU:
	ldi r27, DISP_CHAR_U
	rjmp cleanupDisplayLetter

displayS:
	ldi r27, DISP_CHAR_S
	rjmp cleanupDisplayLetter

;;; Three Signal length letter

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
    
  	cpi r28, BIT_PATT_H
    	breq displayH
      
	jmp checkSequenceNotMatched

;;; Four Signal length letters
displayQ:
	ldi r27, DISP_CHAR_Q
	rjmp cleanupDisplayLetter

displayZ:
	ldi r27, DISP_CHAR_Z
	rjmp cleanupDisplayLetter

displayY:
	ldi r27, DISP_CHAR_Y
	rjmp cleanupDisplayLetter

displayC:
	ldi r27, DISP_CHAR_C
	rjmp cleanupDisplayLetter

displayX:
	ldi r27, DISP_CHAR_X
	rjmp cleanupDisplayLetter

displayB:
	ldi r27, DISP_CHAR_B
	rjmp cleanupDisplayLetter

displayJ:
	ldi r27, DISP_CHAR_J
	rjmp cleanupDisplayLetter

displayP:
	ldi r27, DISP_CHAR_P
	rjmp cleanupDisplayLetter

displayL:
	ldi r27, DISP_CHAR_L
	rjmp cleanupDisplayLetter
	
displayF:
	ldi r27, DISP_CHAR_F
	rjmp cleanupDisplayLetter

displayV:
	ldi r27, DISP_CHAR_V
	rjmp cleanupDisplayLetter

displayH:
	ldi r27, DISP_CHAR_H
	rjmp cleanupDisplayLetter

;;; Five Signal length character

five_press:
	cpi r28, BIT_PATT_0
	breq display0

	cpi r28, BIT_PATT_1
	breq display1

	cpi r28, BIT_PATT_2
	breq display2

	cpi r28, BIT_PATT_3
	breq display3

	cpi r28, BIT_PATT_4
	breq display4

	cpi r28, BIT_PATT_5
	breq display5

	cpi r28, BIT_PATT_6
	breq display6

	cpi r28, BIT_PATT_7
	breq display7

	cpi r28, BIT_PATT_8
	breq display8

	cpi r28, BIT_PATT_9
	breq display9
	
;;; Five Signal length Numbers

display0:
	ldi r27, DISP_CHAR_0
	rjmp cleanupDisplayNumber	
	
display1:
	ldi r27, DISP_CHAR_1
	rjmp cleanupDisplayNumber

display2:
	ldi r27, DISP_CHAR_2
	rjmp cleanupDisplayNumber	

display3:
	ldi r27, DISP_CHAR_3
	rjmp cleanupDisplayNumber

display4:
	ldi r27, DISP_CHAR_4
	rjmp cleanupDisplayNumber

display5:
	ldi r27, DISP_CHAR_5
	rjmp cleanupDisplayNumber

display6:
	ldi r27, DISP_CHAR_6
	rjmp cleanupDisplayNumber

display7:
	ldi r27, DISP_CHAR_7
	rjmp cleanupDisplayNumber

display8:
	ldi r27, DISP_CHAR_8
	rjmp cleanupDisplayNumber

display9:
	ldi r27, DISP_CHAR_9
	rjmp cleanupDisplayNumber
	
;;; Resets Display
cleanupDisplayLetter:
	out PORTD, r27
	ldi r27, DISP_DOT
	out PORTC, r27
	jmp endOverflowInterruptStartNewLetter

cleanupDisplayNumber:
	out PORTD, r27
	ldi r27, ~(DISP_DOT)
	out PORTC, r27
	jmp endOverflowInterruptStartNewLetter
