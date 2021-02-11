;==============================================================================
;
;  Song 000 (initialization)
;
;==============================================================================

	.export emptysong
	
	.include "song.inc"
	
	.segment "BANK0"
	
.proc emptysong
	TVOL	255
	RET
.endproc


