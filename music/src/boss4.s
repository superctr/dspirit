	.include "song.inc"
	.segment "BANK0"
	.export boss4
.proc boss4
song010_start:
	INIT        %11111111
	TEMPO       001
	TVOL        250
	SPEED       012
	PIT         019,015,017,011,015,015,___,004
	PITDEP      100,100,100,120,120,120,___,160
	PITRAT      150,150,150,145,145,145,___,100
	PAN         ___,___,___,___,___,___,___,___
	INS         086,086,086,011,011,007,005,001
	VOL         220,220,220,248,248,245,255,255
	LFO         ___,___,___,___,___,___,___,___
	VOL         155,155,155,___,___,___,205,205
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         160,160,160,___,___,___,215,215
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         165,165,165,___,___,___,225,225
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         170,170,170,___,___,___,230,230
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         175,175,175,___,___,___,230,230
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         180,180,180,___,___,___,235,235
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         185,185,185,___,___,___,235,235
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         190,190,190,___,___,___,245,240
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         195,195,195,___,___,___,245,240
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         200,200,200,___,___,___,250,245
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         205,205,205,___,___,___,250,245
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         210,210,210,___,___,___,250,250
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         215,215,215,___,___,___,255,250
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	VOL         220,220,220,___,___,___,255,255
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn2 ;
	VOL         225,225,225,___,___,___,255,255
	SPEED       003
	FRQ         An3,Bn3,En4,___,___,___,An2,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       012
	VOL         230,230,230,___,___,___,255,255
	FRQ         An3,Bn3,En4,___,___,___,An2,___ ;
song010_jmp000:
	INS         ___,___,___,011,011,007,___,___
	VOL         ___,___,___,248,248,245,___,___
	LFO         ___,___,___,___,001,___,___,___
	FRQ         An1,Bn3,En4,Cn4,En4,En4,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,An3,___,An3,An2,___ ;
	FRQ         ___,Q__,Q__,Cn4,En4,En4,An2,Cn3 ;
	FRQ         Bn1,Dn4,En4,Bn3,Dn4,Dn4,An2,___ ;
	FRQ         ___,Dn4,En4,An3,___,An3,An2,___ ;
	FRQ         ___,Q__,Q__,Bn3,Dn4,Dn4,An2,Cn2 ;
	FRQ         Cn2,Cn4,En4,An3,Cn4,Cn4,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,An2,___ ;
	FRQ         An1,Q__,Q__,___,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,___,___,An2,___ ;
	FRQ         ___,Bn3,En4,___,___,An3,An2,Cn3 ;
	FRQ         Bn1,Q__,Q__,___,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,An2,An2,Cn2 ;
	FRQ         Dn2,Cn4,En4,___,___,An3,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,An2,Cn3 ;
	FRQ         Cn2,Bn3,En4,An3,En4,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,Bn3,Dn4,___,An2,___ ;
	FRQ         ___,Q__,Q__,An3,Cn4,An3,An2,Cn3 ;
	FRQ         Bn1,Dn4,En4,Cn4,Dn4,___,An2,___ ;
	FRQ         ___,Dn4,En4,An3,Cn4,___,An2,___ ;
	FRQ         ___,Q__,Q__,Dn4,Bn3,An2,An2,Cn2 ;
	FRQ         Cn2,Cn4,En4,En4,An3,An3,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,An2,___ ;
	FRQ         Dn2,Q__,Q__,___,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,___,___,An2,___ ;
	FRQ         ___,Bn3,En4,___,___,An3,An3,Cn3 ;
	FRQ         Cn2,Q__,Q__,___,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,Cn2 ;
	FRQ         ___,Dn4,En4,___,___,An2,An3,Cn2 ;
	FRQ         Bn1,Cn4,En4,___,___,An3,___,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,___,___ ;
	FRQ         An3,Bn3,En4,An3,Cn4,Cn4,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,En4,Fn2,Cn3 ;
	FRQ         An3,Dn4,En4,Gn3,Bn3,Bn3,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,En4,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,Cn3,En3,En3,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,Cn3 ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Bn3,En4,An3,Cn4,Cn4,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,En4,Fn2,Cn3 ;
	FRQ         An3,Dn4,En4,Gn3,Bn3,Bn3,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,En4,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,Bn3,Dn4,Dn4,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,Cn3 ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	INS         ___,___,___,086,086,011,___,___
	VOL         ___,___,___,235,225,255,___,___
	LFO         ___,___,___,___,001,___,___,___
	FRQ         An1,Bn3,En4,An5,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,An5,___,An2,___ ;
	FRQ         ___,Q__,Q__,___,___,An5,An2,Cn3 ;
	FRQ         Bn1,Dn4,En4,___,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,___ ;
	FRQ         ___,Q__,Q__,___,___,___,An2,Cn2 ;
	FRQ         Cn2,Cn4,En4,___,___,___,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,An2,___ ;
	FRQ         An1,Q__,Q__,___,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,___,___,An2,___ ;
	FRQ         ___,Bn3,En4,___,___,An5,An2,Cn3 ;
	FRQ         Bn1,Q__,Q__,___,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,Cn2 ;
	FRQ         Dn2,Cn4,En4,___,___,___,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,An2,Cn3 ;
	FRQ         Cn2,Bn3,En4,En5,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,Dn5,___,___,An2,___ ;
	FRQ         ___,Q__,Q__,Cn5,En5,An5,An2,Cn3 ;
	FRQ         Bn1,Dn4,En4,Dn5,Dn5,___,An2,___ ;
	FRQ         ___,Dn4,En4,Cn5,Cn5,___,An2,___ ;
	FRQ         ___,Q__,Q__,Bn5,Dn5,___,An2,Cn2 ;
	FRQ         Cn2,Cn4,En4,An5,Cn5,___,An2,Cn3 ;
	FRQ         ___,Cn4,En4,Q__,Bn5,___,An2,___ ;
	FRQ         Dn2,Q__,Q__,___,An5,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,Q__,___,An2,___ ;
	FRQ         ___,Bn3,En4,___,___,An5,An3,Cn3 ;
	FRQ         Cn2,Q__,Q__,___,___,___,Q__,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,Cn2 ;
	FRQ         ___,Dn4,En4,___,___,___,An3,Cn2 ;
	FRQ         Bn1,Cn4,En4,___,___,___,___,Cn3 ;
	FRQ         ___,Cn4,En4,___,___,___,___,___ ;
	FRQ         An3,Bn3,En4,En4,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,En4,An5,Fn2,Cn3 ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Bn3,En4,___,___,An5,Fn2,Cn3 ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Bn3,En4,An3,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,Bn3,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,Cn4,An3,An5,Fn2,Cn3 ;
	FRQ         An3,Dn4,En4,Bn3,Bn4,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,Cn4,Cn4,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,Dn4,Bn3,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,En4,Cn4,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,Dn4,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,Q__,En4,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Bn3,En4,___,Q__,An5,Fn2,Cn3 ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An1,Bn3,En4,An3,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,An3,___,An2,___ ;
	FRQ         ___,Q__,Q__,___,___,An5,An2,Cn3 ;
	FRQ         Bn1,Dn4,En4,Bn3,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,Bn3,___,An2,___ ;
	FRQ         ___,Q__,Q__,___,___,___,An2,Cn2 ;
	FRQ         Cn2,Cn4,En4,Cn4,___,___,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,Cn4,___,An2,___ ;
	FRQ         An2,Q__,Q__,An3,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,An3,___,An2,___ ;
	FRQ         ___,Bn3,En4,___,___,An5,An2,Cn3 ;
	FRQ         Bn2,Q__,Q__,Bn3,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,Bn3,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,___,___,An2,Cn2 ;
	FRQ         Dn3,Cn4,En4,Dn4,___,___,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,Dn4,___,An2,Cn3 ;
	FRQ         Cn3,Bn3,En4,Cn4,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,Cn4,___,An2,___ ;
	FRQ         ___,Q__,Q__,___,___,An5,An2,Cn3 ;
	FRQ         Bn2,Dn4,En4,Bn3,___,___,An2,___ ;
	FRQ         ___,Dn4,En4,___,Bn3,___,An2,___ ;
	FRQ         ___,Q__,Q__,___,___,___,An2,Cn2 ;
	FRQ         Cn3,Cn4,En4,Cn4,___,___,An2,Cn3 ;
	FRQ         ___,Cn4,En4,___,Cn4,___,An2,___ ;
	FRQ         Dn3,Q__,Q__,Dn4,___,___,Gn2,Cn2 ;
	FRQ         ___,Bn3,En4,___,Dn4,___,An2,___ ;
	FRQ         ___,Bn3,En4,___,___,An5,An3,Cn3 ;
	FRQ         Cn3,Q__,Q__,Cn4,___,___,Q__,___ ;
	FRQ         ___,Dn4,En4,___,Cn4,___,An2,Cn2 ;
	FRQ         ___,Dn4,En4,___,___,___,An3,Cn2 ;
	FRQ         Bn2,Cn4,En4,Bn3,___,___,___,Cn3 ;
	FRQ         ___,Cn4,En4,___,Bn3,___,___,___ ;
	FRQ         An3,Bn3,En4,En3,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,En3,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,Cn3 ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Bn3,En4,Fn3,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,Fn3,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,En2,Cn2 ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,___ ;
	FRQ         An3,Bn3,En4,___,___,___,Fn2,Cn3 ;
	FRQ         Q__,Q__,Q__,___,___,___,Fn2,___ ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn2 ;
	FRQ         An3,Dn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	FRQ         An3,Cn4,En4,___,___,___,Fn2,Cn3 ;
	JUMP        song010_jmp000
.endproc
