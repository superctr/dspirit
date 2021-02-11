;==============================================================================
;
;  Patch data
;
;==============================================================================

;PSG patch format
;00  Patch type
;	bit 7 : Tone enable
;   bit 6 : Ch3 enable
;   bit 5 : Ch3 tone enable
;	bit 4 : Ch3 coarse/fine tune
;   bit 3 : Noise enable
;   bit 2-0 : Noise mode  (11 = use Ch3)
;01    Ch3/Noise coarse/fine tune
;02    Attack level: Volume at beginning of envelope
;03    Attack rate: add to volume accumulator during attack phase
;04    Decay rate:  subtract from volume during decay phase
;05    Sustain level: level where decay stops
;06    Sustain rate: subtract from volume during sustain phase
;07    Release rate: subtract from volume during release phase

.macro PSGENV type,freq,al,ar,dr,sl,sr,rr
	.byt type,<freq
	.byt al,ar,dr,sl,sr,rr
.endmacro

