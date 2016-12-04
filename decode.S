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

  ; One character codes
  displayE:
    ldi r27, DISP_CHAR_E
    rjmp 1f

  displayT:
    ldi r27, DISP_CHAR_T
    rjmp 1f

  ; Two character codes
  displayA:
    ldi r27, DISP_CHAR_A
    rjmp 1f

  displayN:
    ldi r27, DISP_CHAR_N
    rjmp 1f

  displayI:
    ldi r27, DISP_CHAR_I
    rjmp 1f

  displayM:
    ldi r27, DISP_CHAR_M
    rjmp 1f

  1:
    out PORTD, r27
    jmp endOverflowInterrupt
