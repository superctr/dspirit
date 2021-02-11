;==============================================================================
;
;  Song commands
;
;  (Do not include this file directly, use "song.inc" instead)
;
;==============================================================================

; RR - Reset wait counter
;    Invoke this before a label to make sure jumps/repeats/etc end up in the
;    correct position. Only needed if the previous pattern ends with a
;	 row advancing command (i.e. key on).

;.macro RR (this is defined in songdef.inc)
;.endmacro

.macro _NOP
	.byt	$00
.endmacro

; JUMP to location
;------------------------------------------------------------------------------
; addr .... destination address
.macro JUMP addr
	.byte	$09
	POS	addr
.endmacro

; CALL subroutine
;------------------------------------------------------------------------------
; addr .... destination address
.macro CALL addr
	.byte	$04
	POS	addr
.endmacro

; RETurn from subroutine or end song
;------------------------------------------------------------------------------
.macro RET
	.byt	$05
.endmacro

; END song
;------------------------------------------------------------------------------
.macro END
	.byt	$0a
.endmacro

; REPEAT section
;------------------------------------------------------------------------------
;  put this at the end of the repeating section. When the section has been
;  repeated the specified number of times, the song continues from after this
;  instruction.
; count ... times to repeat
; addr .... starting point
.macro REPT count, addr
	.byte	$0b
	.byt	count
	POS	addr
.endmacro

; begin LOOP
;------------------------------------------------------------------------------
;  put this at the beginning of the loop, then JUMP back at the end
;  When the count reaches zero. the track position changes to the specified
;  address.
; count ... times to loop
; addr .... exit address
.macro LOOP count, addr
	.byte	$0c
	.byt	count
	POS	addr
.endmacro

; play subsong on track
;------------------------------------------------------------------------------
.macro TRACK slot, id
	.byte $1d,<slot,<id
.endmacro

; track variables
;------------------------------------------------------------------------------
; tempo (BPM=9600/tempo with a speed value of 12)
.macro TEMPO p0
	.byte $02,<p0
.endmacro
; speed  (tempo units per row)
.macro SPEED p0
	.byte $03,<p0
.endmacro
; track volume
.macro TVOL p0
	.byte $01,<p0
.endmacro

; request PCM sample
.macro PCM p0
	.byte $21,<p0
.endmacro
; communication byte
.macro COMM p0
	.byte $1b,<p0
.endmacro

; channel variables (initialization)
;------------------------------------------------------------------------------
; Set channel number
; p0-p7 : Voice number
.macro INIT p0
	.byte $20,<p0
.endmacro

; channel variables
;------------------------------------------------------------------------------
; Waveform Select
.macro INS p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $07,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Volume
.macro VOL p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $08,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Pan (fixed)
.macro PAN p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $19,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Detune (frequency low)
.macro DTN p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $0e,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Pitch Envelope (0=disable)
.macro PIT p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $0f,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Envelope rate
.macro PITRAT p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $10,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Envelope depth
.macro PITDEP p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $13,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Note Delay (in 60hz ticks)
.macro DEL p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $15,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Gate Time
.macro GTM p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $12,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Transpose
.macro TRS p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $0d,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; LFO (255=disable)
.macro LFO p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $18,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Legato (the following <n> notes will be tied)
.macro LEG p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $11,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Reassign channel
.macro CHANNEL p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $22,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; Volume envelope (might reuse for PSG env)
.macro ENV p0,p1,p2,p3,p4,p5,p6,p7
	__chvar $14,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
; key on
;------------------------------------------------------------------------------
; Note  (frequency high)
.macro FRQ p0,p1,p2,p3,p4,p5,p6,p7
	__keyon $06,p0,p1,p2,p3,p4,p5,p6,p7
.endmacro
