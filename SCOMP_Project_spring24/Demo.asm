; An empty ASM program ...

ORG 0
;speed (two bit input)
; 00 : faster * 2
; 01 : default
; 10 : slower * 1.5
; 11 : slower * 2

;checking which most siginificant bit is up
	
LOADI &B11
OUT SPEED

ADDING:
	LOAD Count	; 0
;	OR &H0200 	;  0000 0010 0000 0000
	OUT   HSPG1
	OUT Hex0
;	LOAD Count
;	AND &HFDFF		; 1111 1101 1111 1111
	ADDI 1
	STORE Count
	JUMP  CHECK
	
CHECK:
	LOAD Count
	SUB Num
	JNEG ADDING
	JUMP SUBTRACTING

	
SUBTRACTING:
	LOAD Count
;	OR &H0200
	OUT  HSPG1
	OUT Hex0
;	LOAD Count
;	AND &HFDFF
	ADDI -1
	STORE Count
	JPOS  SUBTRACTING
	JZERO ADDING

;Delay:
;	OUT    Timer
;WaitingLoop:
;	IN     Timer
;	ADDI   -1
;	JNEG   WaitingLoop
;	RETURN
	
	
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
SPEED:		EQU &H54
Num:	DW 180
Count: 	   DW 0
One:		DW 1
Up: DW 0