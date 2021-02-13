; first part: 	FM1,FM2,FM3,FM4,___,___,FM5,FM6
; third part	FM1,PS1,FM3,PS3,FM4,FM2,FM5,FM6
; second part	FM1,FM2,FM3,PS3,FM4,PS1,FM5,FM6
; third part	FM1,PS1,FM3,PS3,FM4,FM2,FM5,FM6
;  use ch3 mode for the weird noise thing
; (we will use CHANNEL commands to temporarily assign Ch3)

	.include "song.inc"
	.segment "BANK0"
	.export area6
.proc area6
song009_start:
	CHANNEL		001,002,003,004,___,___,005,006
;	CHANNEL		___,002,003,004,___,___,___,___
	TEMPO       001
	TVOL        250
	SPEED       006
	PIT         019,015,017,___,015,015,___,004
	PITDEP      100,100,100,___,120,120,___,180
	PITRAT      140,140,140,___,145,145,___,100
	INS         086,086,086,007,086,086,005,001
	VOL         220,220,226,235,230,220,255,255
	PAN         L__,__R,_C_,___,___,___,___,___
	DTN         018,000,032,___,006,022,___,___
	LFO         ___,___,___,___,___,001,___,___
	FRQ         An3,Cn4,En4,___,___,___,An2,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         An3,Cn4,En4,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         An3,Cn4,En4,___,___,___,An2,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         An3,Cn4,En4,___,___,___,An2,Gn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         Gn3,Bn3,Dn4,___,___,___,Bn2,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         Gn3,Bn3,Dn4,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Bn2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Gn3,Bn3,Dn4,___,___,___,Bn2,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         Gn3,Bn3,Dn4,___,___,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Bn2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Gn3,Cn4,En4,___,___,___,Cn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         Gn3,Cn4,En4,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         Gn3,Cn4,En4,___,___,___,Cn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,Cn2 ;
	FRQ         Gn3,Cn4,En4,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         An3,Cn4,Fn4,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         An3,Cn4,Fn4,___,___,___,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         An3,Cn4,Fn4,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         An3,Cn4,Fn4,An4,___,___,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,En5,___,___,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn3 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
song009_jmp000:
	CHANNEL		___,007,___,009,004,002,___,___
	TRS			___,___,___,___,___,___,___,___
	ENV			___,012,___,008,___,019,___,___
	LINK		___,003,___,___,___,___,___,___
	LINKVOL		___,000,___,___,___,___,___,___
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,240,220,245,___,___,___,___
	PAN			L__,___,__R,___,___,___,___,___
	FRQ         An3,Cn4,En4,___,An5,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,En5,___,An5,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En5,___,An2,Gn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         An3,Cn4,En4,___,An5,En5,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         Gn3,Bn3,Dn4,___,Gn5,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,An5,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,En5,___,Gn5,Bn2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En5,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Bn2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         Gn3,Bn3,Dn4,___,Dn5,En5,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Gn3,Cn4,En4,___,En5,___,Cn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,Dn5,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,En5,___,En5,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn2 ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         Q__,Q__,Q__,En5,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         Gn3,Cn4,En4,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         An3,Cn4,Fn4,___,Fn5,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En5,___,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,___,___,En5,Dn5,Fn5,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn2 ;
	FRQ         Q__,Q__,Q__,___,Cn5,En5,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         An3,Dn4,Gn4,___,___,Dn5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         Q__,Q__,Q__,An4,Bn4,Cn5,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         An3,Dn4,Fn4,En5,Gn4,___,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn3 ;
	FRQ         Q__,Q__,Q__,___,En4,Bn4,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         An3,Cn4,En4,___,An4,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,En4,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,En5,___,An4,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En4,___,An2,Gn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,En5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,An4,En4,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         Gn3,Bn3,Dn4,___,Gn4,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,An4,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,En5,___,Gn4,Bn2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En4,___,Bn2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         ___,___,___,En5,___,___,Bn2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,Dn4,En4,Bn2,___ ;
	FRQ         ___,___,___,___,___,___,Bn2,___ ;
	FRQ         Gn3,Cn4,En4,___,En4,___,Cn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,Dn4,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,En5,___,En4,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn2 ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,En5,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,Cn3,___ ;
	LOOP        $01, song009_loop000
	FRQ         An3,Cn4,Fn4,___,Fn4,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En4,___,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,___,___,En5,Dn4,Fn4,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn2 ;
	FRQ         ___,___,___,___,Cn4,En4,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,Dn4,Gn4,___,___,Dn4,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,An4,Bn3,Cn4,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,Fn4,En5,Cn4,___,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Cn3 ;
	FRQ         ___,___,___,An5,En4,Bn3,Dn3,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	JUMP        song009_jmp000
song009_loop000:
	FRQ         An3,Cn4,Fn4,___,Fn4,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,En4,___,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,___,___,En5,An4,Fn4,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,Gn4,En4,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,Dn4,Gn4,___,Bn4,An4,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Gn2 ;
	FRQ         ___,___,___,An4,An4,Gn4,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	FRQ         ___,___,Fn4,En5,Cn5,Bn4,Dn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,Gn2 ;
	FRQ         ___,___,___,An5,Bn4,An4,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	CHANNEL		___,002,___,___,___,007,___,___
	TRS			___,___,___,___,___,012,___,___
	INS         033,033,033,___,011,011,___,___
	VOL         235,235,235,___,245,218,___,___
song009_jmp001:
	FRQ         Dn4,Fn4,An4,___,Q__,Q__,As2,Cn2 ;
	FRQ         ___,___,___,___,___,___,As2,___ ;
	FRQ         ___,___,___,___,An5,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,As2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,Dn5,An5,As2,___ ;
	FRQ         ___,___,___,___,___,___,As2,___ ;
	FRQ         ___,___,___,___,___,___,As2,Cn2 ;
	FRQ         ___,___,___,___,___,___,As2,Cn2 ;
	FRQ         ___,___,___,___,An5,Dn5,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,Gn5,___,As2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,An5,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn5,As2,Cn2 ;
	FRQ         ___,___,___,___,___,___,As2,___ ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,As2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,As2,___ ;
	FRQ         ___,___,___,___,___,___,As2,___ ;
	FRQ         ___,___,___,___,___,___,As2,Cn2 ;
	FRQ         ___,___,___,___,___,___,As2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn4,___,___,As2,Cn3 ;
	FRQ         ___,___,___,Cn5,___,___,Q__,___ ;
	FRQ         ___,___,___,Dn5,Cn6,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	LOOP        $01, song009_loop001
	FRQ         Cn4,En4,Gn4,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,Cn6,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Q__,Q__,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Cn4,Cn2 ;
	FRQ         ___,___,___,Dn5,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Cn4,Cn3 ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	JUMP        song009_jmp001
song009_loop001:
	FRQ         Cn4,En4,Gn4,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,As5,Cn6,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,An5,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,Gn5,As5,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,As5,An5,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,An5,Gn5,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,Fn5,As5,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,Dn5,An5,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	LOOP        $01, song009_loop002
	FRQ         ___,___,___,___,___,Fn5,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,Dn5,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,Dn6,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,Cn4,Cn2 ;
	FRQ         ___,___,___,Dn5,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,Dn6,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Cn4,___ ;
	FRQ         ___,___,___,Dn5,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	JUMP        song009_jmp001
song009_loop002:
	FRQ         ___,___,___,___,___,Fn5,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,Dn5,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,Dn6,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Cn4,Cn3 ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	FRQ         ___,___,___,___,___,Dn6,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,Cn4,Cn3 ;
	FRQ         ___,___,___,Dn5,___,___,An2,Cn2 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	CHANNEL		___,007,___,___,___,002,___,___
	LINK		___,003,___,___,___,___,___,___
	LINKVOL		___,000,___,___,___,___,___,___
	TRS			___,___,___,___,___,000,___,___
	INS         086,086,086,___,086,086,___,___
	VOL         220,230,220,___,230,220,___,___
	PIT         ___,___,___,___,038,038,___,___
	PITDEP      ___,___,___,___,255,255,___,___
	PITRAT      ___,___,___,___,015,015,___,___
	PAN         L__,_C_,__R,___,___,___,___,___
	DTN         008,000,032,___,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,Dn4,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,Dn4,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PIT         ___,___,___,___,011,017,___,___
	PITDEP      ___,___,___,___,125,125,___,___
	PITRAT      ___,___,___,___,145,140,___,___
	FRQ         Dn4,Fn4,An4,___,Fn5,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,Dn5,En5,Gn5,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         ___,___,___,___,___,___,___,L__
	FRQ         As3,Dn4,Fn4,___,Dn5,Fn5,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,An2,En3 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	PAN         ___,___,___,___,___,___,___,__R
	FRQ         Cn4,En4,Gn4,___,En5,An5,Cn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Cn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	PAN         ___,___,___,___,___,___,___,_C_
song009_rept000:
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,Dn4,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,En4,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,Fn4,___,Q__,___ ;
	FRQ         ___,___,___,___,Dn4,___,___,___ ;
	FRQ         ___,___,___,Dn5,An4,Dn4,Dn4,Cn3 ;
	FRQ         ___,___,___,___,Q__,En4,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,___,Dn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,An4,Dn3,Cn2 ;
	FRQ         ___,___,___,___,En5,Q__,Dn3,Cn2 ;
	FRQ         ___,___,___,___,Fn5,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,Dn5,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,An5,Dn5,___,Cn3 ;
	FRQ         ___,___,___,Q__,Q__,En5,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,Fn5,Cn3,___ ;
	FRQ         ___,___,___,___,___,Dn5,___,___ ;
	VOL         ___,___,___,___,210,___,___,___
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,235,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,Dn5,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,En5,Q__,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,Fn5,___,Q__,___ ;
	FRQ         ___,___,___,___,Dn5,___,___,___ ;
	VOL         ___,___,___,___,___,200,___,___
	FRQ         ___,___,___,Dn5,An5,Dn5,Dn4,Cn3 ;
	FRQ         ___,___,___,___,Q__,En5,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,Fn5,___,___ ;
	FRQ         ___,___,___,___,___,Dn5,___,___ ;
	VOL         ___,___,___,___,210,___,___,___
	FRQ         ___,___,___,___,Dn5,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,En5,Q__,Dn3,Cn2 ;
	FRQ         ___,___,___,___,Fn5,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,Dn5,___,Q__,___ ;
	VOL         ___,___,___,___,___,220,___,___
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,An5,Dn5,___,Cn3 ;
	FRQ         ___,___,___,Q__,Q__,En5,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,Fn5,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,Dn5,___,___ ;
	VOL         ___,___,___,___,230,___,___,___
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,Dn5,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,En5,Q__,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,Fn5,___,Q__,___ ;
	FRQ         ___,___,___,___,Dn5,___,___,___ ;
	FRQ         ___,___,___,Dn5,An5,Dn5,Dn4,Cn3 ;
	FRQ         ___,___,___,___,Gn5,En5,___,___ ;
	FRQ         Cn4,En4,Gn4,___,Fn5,Fn5,___,___ ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Fn5,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,Gn5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,Fn5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,En5,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,Fn5,___,Cn3 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,Dn5,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,Dn5,En5,Dn5,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         ___,___,___,___,___,___,___,L__
	FRQ         As3,Dn4,Fn4,___,Fn5,En5,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,An2,En3 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	PAN         ___,___,___,___,___,___,___,__R
	FRQ         Cn4,En4,Gn4,Cn3,Gn5,Fn5,Cn3,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,Cn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	PAN         ___,___,___,___,___,___,___,_C_
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	REPT        $01, song009_rept000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,240,230,___,___
	PIT         ___,___,___,___,035,035,___,___
	PITDEP      ___,___,___,___,255,255,___,___
	PITRAT      ___,___,___,___,004,004,___,___
	FRQ         Dn4,Fn4,An4,___,Dn3,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,Dn3,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,235,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         ___,___,___,___,___,___,___,L__
	FRQ         As3,Dn4,Fn4,___,___,___,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,An2,En3 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	PAN         ___,___,___,___,___,___,___,__R
	FRQ         Cn4,En4,Gn4,Cn3,___,___,Cn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Cn3,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,Dn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	PIT         ___,___,___,___,011,017,___,___
	PITDEP      ___,___,___,___,125,125,___,___
	PITRAT      ___,___,___,___,145,140,___,___
	PAN         ___,___,___,___,___,___,___,_C_
	FRQ         Dn4,Fn4,An4,___,Dn5,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,Fn5,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,Dn5,Dn5,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,An5,Fn5,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,Dn5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,235,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,Cn6,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,An5,___,Q__,___ ;
	FRQ         ___,___,___,___,Gn5,___,___,___ ;
	FRQ         ___,___,___,Dn5,An5,Cn6,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,An5,___,___ ;
	FRQ         ___,___,___,___,___,Gn5,___,___ ;
	FRQ         ___,___,___,___,___,An5,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,___,___,Cn3,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	FRQ         ___,___,___,Cn3,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,___,___,Cn3,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	LOOP        $01, song009_loop003
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,255,___,___,___,___
	FRQ         Dn4,Fn4,An4,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,Cn2 ;
	FRQ         ___,___,___,___,___,___,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,En4,Gn4,Dn5,___,___,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         ___,___,___,___,___,___,___,L__
	FRQ         As3,Dn4,Fn4,___,___,___,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,Dn3,En3 ;
	FRQ         ___,___,___,___,___,___,An2,En3 ;
	FRQ         ___,___,___,___,___,___,An2,___ ;
	CHANNEL		___,___,000,003,___,___,___,___
	CH3			$40,Cn3,000,000,003
	INS         ___,___,___,085,___,___,___,___
	VOL         ___,___,___,245,___,___,___,___
	PAN         ___,___,___,___,___,___,___,__R
	FRQ         Cn4,En4,Gn4,Cn3,___,___,Cn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Cn3,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,Dn3,Gn2 ;
	FRQ         ___,___,___,___,___,___,Dn3,___ ;
	PAN         ___,___,___,___,___,___,___,_C_
	CHANNEL		___,___,003,009,___,___,___,___
	CH3			$00,Cn3,000,000,000
	JUMP        song009_rept000
song009_loop003:
	INS         ___,___,___,007,___,___,___,___
	VOL         ___,___,___,235,___,___,___,___
	FRQ         Fn4,As4,Dn5,As4,As5,Dn6,As2,Cn3 ;
	FRQ         Fn4,As4,Dn5,As4,___,___,As2,Cn3 ;
	FRQ         Fn4,As4,Dn5,As4,___,___,As2,Cn3 ;
	FRQ         Fn4,As4,Dn5,As4,___,___,As2,Cn3 ;
	FRQ         Fn4,As4,Dn5,As4,___,___,As2,Cn3 ;
	FRQ         Q__,Q__,Q__,Q__,Q__,Q__,Q__,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn4,Cn5,En5,Cn5,Cn6,En6,Cn3,Cn3 ;
	FRQ         Gn4,Cn5,En5,Cn5,___,___,Cn3,Cn3 ;
	FRQ         Gn4,Cn5,En5,Cn5,___,___,Cn3,Cn2 ;
	FRQ         Gn4,Cn5,En5,Cn5,___,___,Cn3,Gn2 ;
	FRQ         Gn4,Cn5,En5,Cn5,___,___,Cn3,Gn2 ;
	FRQ         Q__,Q__,Q__,Q__,Q__,Q__,Q__,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	JUMP        song009_jmp000
.endproc
