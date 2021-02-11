	.include "song.inc"
	.segment "BANK0"
	.export area93
.proc area93
song00e_start:
	INIT        %11111111
	TEMPO       001
	TVOL        253
	PIT         ___,___,___,011,013,015,___,004
	PITRAT      ___,___,___,140,145,135,___,100
	TRS         ___,___,___,___,___,___,___,___
	PITDEP      ___,___,___,120,120,120,___,180
	ENV         ___,___,___,___,___,___,___,___
	GTM         ___,___,___,___,___,___,___,255
	INS         028,028,028,020,020,020,005,001
	VOL         236,236,236,245,245,245,255,255
	LFO         ___,___,___,___,___,___,___,___
	DTN         ___,006,018,022,004,008,___,___
	PAN         ___,___,___,L__,__R,_C_,___,___
	INS         ___,___,___,___,___,___,___,___
	VOL         ___,___,___,___,___,___,___,___
	LFO         ___,___,___,___,___,___,___,___
	PAN         __R,_C_,L__,___,___,___,___,___
	SPEED       018
	GTM         ___,___,___,___,___,___,___,003
song00e_rept000:
	FRQ         Cn5,___,___,Q__,Q__,Q__,___,___ ;
	FRQ         ___,Fn4,___,___,___,___,___,___ ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
	REPT        $03, song00e_rept000
	FRQ         Cn5,___,___,Fn3,Gs3,Cn4,___,___ ;
	FRQ         ___,Fn4,___,___,___,___,___,___ ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
song00e_rept001:
	FRQ         Cn5,___,___,___,___,___,___,___ ;
	FRQ         ___,Fn4,___,___,___,___,___,___ ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
	REPT        $01, song00e_rept001
	FRQ         Cn5,___,___,Gn3,As3,Cn4,___,___ ;
	FRQ         ___,Fn4,___,___,___,___,___,___ ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
song00e_rept002:
	FRQ         Cn5,___,___,___,___,___,___,___ ;
	FRQ         ___,Fn4,___,___,___,___,___,___ ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
	REPT        $01, song00e_rept002
	FRQ         Q__,Q__,Q__,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,Ds2,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
song00e_jmp000:
	FRQ         Cn5,___,___,Fn3,Gs3,Cn4,Fn2,Cn2 ;
	FRQ         ___,Fn4,___,___,___,___,Fn2,Cn2 ;
	FRQ         ___,___,As4,___,___,___,Q__,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
song00e_rept003:
	FRQ         Cn5,___,___,___,___,___,___,Cn2 ;
	FRQ         ___,Fn4,___,___,___,___,___,Cn2 ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	GTM         ___,___,___,___,___,___,___,255
	FRQ         Ds4,___,___,___,___,___,___,Cn3 ;
	GTM         ___,___,___,___,___,___,___,003
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
	REPT        $01, song00e_rept003
	FRQ         Cn5,___,___,Gn3,As3,Cn4,Ds2,Cn2 ;
	FRQ         ___,Fn4,___,___,___,___,Ds2,Cn2 ;
	FRQ         ___,___,As4,___,___,___,Q__,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
	FRQ         Cn5,___,___,___,___,___,___,Cn2 ;
	FRQ         ___,Fn4,___,___,___,___,___,Cn2 ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	FRQ         Ds4,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,___,___,___,___,___,___ ;
	LOOP        $01, song00e_loop000
	FRQ         Cn5,___,___,___,___,___,___,Cn2 ;
	FRQ         ___,Fn4,___,___,___,___,___,Cn2 ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	GTM         ___,___,___,___,___,___,___,255
	FRQ         Ds4,___,___,___,___,___,___,Cn3 ;
	FRQ         ___,Gn4,___,___,___,___,___,Gn2 ;
	GTM         ___,___,___,___,___,___,___,003
	JUMP        song00e_jmp000
song00e_loop000:
	FRQ         Cn5,___,___,___,___,___,___,Cn2 ;
	FRQ         ___,Fn4,___,___,___,___,___,Cn2 ;
	FRQ         ___,___,As4,___,___,___,___,___ ;
	SPEED       009
	GTM         ___,___,___,___,___,___,___,255
	FRQ         Ds4,___,___,___,___,___,___,Gn2 ;
	FRQ         ___,___,___,___,___,___,___,Gn2 ;
	FRQ         ___,Gn4,___,___,___,___,As3,Cn3 ;
	FRQ         ___,___,___,___,___,___,Cn4,Gn2 ;
	GTM         ___,___,___,___,___,___,___,003
	SPEED       018
	JUMP        song00e_jmp000
.endproc