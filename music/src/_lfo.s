;==============================================================================
;
;  Add LFO presets here
;
;==============================================================================

	.export tab_lfo
	.segment "BANK0"
	.include "lfo.inc"

tab_lfo:
	.byt        2,000,000,0,0
lfo001:
	.byt        2,190,009,0,0
lfo002:
	.byt        2,205,011,0,0
lfo003:
	.byt        3,245,250,1,0
lfo004:
	.byt        1,255,240,0,0
