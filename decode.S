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

;;; One Signal length letter - compares r28 to find corresponding letter
one_press:
	; r28 stores bit pattern of morse signal
	
	cpi r28, BIT_PATT_T	; 0x00 = one dash
	breq displayT			
				
	cpi r28, 0x01       	; 0x01 = one dot
	breq displayE
    
	; If neither...
  	jmp checkSequenceNotMatched ; Invalid Signal Sequence (Error Message) - isn't possible
    
;;; One character codes - 
displayE:
	ldi r27, DISP_CHAR_E	
	rjmp cleanupDisplayLetter

displayT:
	ldi r27, DISP_CHAR_T
	rjmp cleanupDisplayLetter

;;; Two Signal length letter - compares r28 to find corresponding letter
two_press:
	; r28 stores bit pattern of morse signal

  	cpi r28, BIT_PATT_M	;0x00
  	breq displayM
  
  	cpi r28, BIT_PATT_N	;0x01
  	breq displayN
	
    	cpi r28, BIT_PATT_A	;0x02
  	breq displayA
	  
  	cpi r28, BIT_PATT_I 	;0x03
  	breq displayI
  
  	jmp checkSequenceNotMatched ; Invalid Signal Sequence (Error Message) - isn't possible

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
	
;;; Three Signal length letter - compares r28 to find corresponding letter
three_press:
	; r28 stores bit pattern of morse signal
	
  	cpi r28, BIT_PATT_O 	;0x00
    	breq displayO
    	
  	cpi r28, BIT_PATT_G	;0x01
    	breq displayG
    
  	cpi r28, BIT_PATT_K	;0x02
    	breq displayK
    
  	cpi r28, BIT_PATT_D	;0x03
    	breq displayD

  	cpi r28, BIT_PATT_W	;0x04
    	breq displayW
    
  	cpi r28, BIT_PATT_R	;0x05
    	breq displayR
    
  	cpi r28, BIT_PATT_U	;0x06
    	breq displayU
    
  	cpi r28, BIT_PATT_S	;0x07
    	breq displayS
  
	jmp checkSequenceNotMatched ;Invalid signal sequence (Error message) - shouldn't be possible

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

;;; Three Signal length letter - compares r28 to find corresponding letter

four_press:
	; r28 stores bit pattern of morse signal
	
  	cpi r28, BIT_PATT_Q	;0x02
    	breq displayQ
    	
  	cpi r28, BIT_PATT_Z	;0x03
    	breq displayZ
    
  	cpi r28, BIT_PATT_Y	;0x04
    	breq displayY
    
  	cpi r28, BIT_PATT_C	;0x05
    	breq displayC
    
  	cpi r28, BIT_PATT_X	;0x06
    	breq displayX
    
  	cpi r28, BIT_PATT_B	;0x07
    	breq displayB
    
  	cpi r28, BIT_PATT_J	;0x08
    	breq displayJ
    
  	cpi r28, BIT_PATT_P	;0x09
    	breq displayP

  	cpi r28, BIT_PATT_L	;0x0B
    	breq displayL
    
  	cpi r28, BIT_PATT_F	;0x0D
    	breq displayF
    
  	cpi r28, BIT_PATT_V	;0X0E
    	breq displayV
    
  	cpi r28, BIT_PATT_H	;0x0F
    	breq displayH
      
	jmp checkSequenceNotMatched ; Invalid Signal Sequence (Error Message)

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

;;; Five Signal length character - compares r28 to find corresponding number

five_press:
	; r28 stores bit pattern of morse signal
	
	cpi r28, BIT_PATT_0	;0x00
	breq display0

	cpi r28, BIT_PATT_1	;0x10
	breq display1

	cpi r28, BIT_PATT_2	;0x18
	breq display2

	cpi r28, BIT_PATT_3	;0x1C
	breq display3
	
	cpi r28, BIT_PATT_4	;0x1E
	breq display4

	cpi r28, BIT_PATT_5	;0x1F
	breq display5

	cpi r28, BIT_PATT_6	;0x0F
	breq display6

	cpi r28, BIT_PATT_7	;0x07
	breq display7

	cpi r28, BIT_PATT_8	;0x03
	breq display8

	cpi r28, BIT_PATT_9	;0x01
	breq display9

	jmp checkSequenceNotMatched ; Invalid Signal Sequence (Error Message)
	
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
	;; If the signals create a letter
	out PORTD, r27
	ldi r27, DISP_DOT
	out PORTC, r27
	jmp endOverflowInterruptStartNewLetter

cleanupDisplayNumber:
	;; If the signals create a number
	out PORTD, r27
	ldi r27, ~(DISP_DOT)
	out PORTC, r27
	jmp endOverflowInterruptStartNewLetter
