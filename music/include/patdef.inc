;==============================================================================
;
;  Patch data
;
;==============================================================================

;PSG patch format
;00  Patch type
;	bit 0 : Tone
;	bit 1 : Noise
;	bit 2 : Ch3 noise
;	bit 3 : Fixed freq noise
;01  Noise freq / transpose
;02-03 Attack rate: add to volume accumulator during attack phase
;04-05 Decay rate:  subtract from volume during decay phase
;06-07 Sustain level: level where decay stops
;08-09 Release rate: subtract from volume during release phase

.macro PSGPAT type,freq,ar,dr,sl,rr
	.byt type,freq
	.byt >ar,<ar,>dr,<dr,>sl,<sl,>rr,<rr
.endmacro

.macro TABLE a1,a2,a3,a4,a5,a6,a7,a8,a9,a10
	.if	.paramcount > 0
		.byt		>a1,<a1
	.endif
	.if	.paramcount > 1
		.byt		>a2,<a2
	.endif
	.if	.paramcount > 2
		.byt		>a3,<a3
	.endif
	.if	.paramcount > 3
		.byt		>a4,<a4
	.endif
	.if	.paramcount > 4
		.byt		>a5,<a5
	.endif
	.if	.paramcount > 5
		.byt		>a6,<a6
	.endif
	.if	.paramcount > 6
		.byt		>a7,<a7
	.endif
	.if	.paramcount > 7
		.byt		>a8,<a8
	.endif
	.if	.paramcount > 8
		.byt		>a9,<a9
	.endif
	.if	.paramcount > 9
		.byt		>a10,<a10
	.endif
.endmacro
