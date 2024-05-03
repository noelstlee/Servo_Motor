; An empty ASM program ...

ORG 0
; for the two most significant bits : switch 8 and 9, these two bits can act as indicators for which servo motor to move
; 00 : HSPG1
; 01 : HSPG2
; 10 : HSPG3
; 11 : HSPG4

;checking which most siginificant bit is up
CHECK:
	IN	  Switches
	
	SHIFT -8		;transform into a two-bit value
	STORE	servoNum
	JZERO LOOP1		;if 0 jump to (HSPG1)
	SUB		One
	JZERO  LOOP2		;if 1 (POS) jump to(HSPG2)
	SUB		One
	JZERO  LOOP3
	SUB		One
	JZERO  LOOP4
	
START1:
	IN	  Switches
	AND	  Mask
	OUT   LEDs
	OUT   HSPG1
	JUMP  CHECK
LOOP1:	
	JUMP  START1


START2:
	IN	  Switches
	AND	  Mask
	OUT   LEDs
	OUT   HSPG2
	JUMP  CHECK
LOOP2:
	JUMP  START2
	
START3:
	IN	  Switches
	AND	  Mask
	OUT   LEDs
	OUT   HSPG3
	JUMP  CHECK
LOOP3:	
	JUMP  START3

START4:
	IN	  Switches
	AND	  Mask
	OUT   LEDs
	OUT   HSPG4
	JUMP  CHECK
LOOP4:	
	JUMP  START4
	
; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
HSPG1:     EQU &H50
HSPG2:     EQU &H51
HSPG3:     EQU &H52
HSPG4:     EQU &H53
servoNum:	DW 0
One: 	   DW 1
Mask:		DW &H00FF