;==============================================================================
;
;  Quattro Creation Kit
;
;  Main header file.
;
;==============================================================================


	.import 	tab_song,tab_psgpatch,tab_pitenv,tab_lfo,tab_fmpatch
	.include "songtab.inc"

.segment "HEADER"

	ADDR		tab_song
	ADDR		tab_psgpatch
	ADDR		tab_lfo				; lfo
	ADDR		tab_pitenv			; pitch
	ADDR		tab_fmpatch

