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
    jmp endOverflowInterrupt

  displayT:
    ldi r27, DISP_CHAR_T
    jmp endOverflowInterrupt

  ; Two character codes
  displayA:
    ldi r27, DISP_CHAR_A
    jmp endOverflowInterrupt

  displayN:
    ldi r27, DISP_CHAR_N
    jmp endOverflowInterrupt

  displayI:
    ldi r27, DISP_CHAR_I
    jmp endOverflowInterrupt

  displayM:
    ldi r27, DISP_CHAR_M
    jmp endOverflowInterrupt
