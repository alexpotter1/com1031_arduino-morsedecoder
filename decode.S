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
    ; 0x02 = one dash
    cpi r28, 0x02 
    breq displayT
    
    ; 0x08 = one dot
    cpi r28, 0x08
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

