	.include "song.inc"
	.segment "BANK0"
	.export omake
.proc omake
song042_start:
	INIT        %11111111 ; missing from original data
	TVOL        250
	TEMPO       001
song042_jmp000:
	SPEED       016
	INS         011,011,011,005,037,022,022,009
	VOL         230,230,230,255,255,255,255,245
	PAN         ___,___,___,___,___,L__,__R,___
	LFO         ___,___,___,___,___,___,___,___
	PIT         ___,___,___,___,___,___,___,011
	PITRAT      ___,___,___,___,___,___,___,210
	PITDEP      ___,___,___,___,___,___,___,150
	TRS         ___,___,___,___,___,___,___,___
	FRQ         Cn4,___,___,Cn3,___,Gn4,Cn5,En5 ;
	FRQ         Gn4,___,___,___,___,___,___,___ ;
	FRQ         ___,Cn5,En5,___,Cn2,___,___,___ ;
	FRQ         Gn4,___,___,Cn3,___,___,___,___ ;
	FRQ         Bn3,Dn5,Gn5,Bn2,___,Bn4,Dn5,Gn5 ;
	FRQ         Bn4,___,___,___,___,___,___,___ ;
	FRQ         Bn3,Dn5,An5,___,Cn2,___,___,An5 ;
	FRQ         Bn4,___,___,Bn2,___,___,___,___ ;
	FRQ         An3,Cn5,En5,An2,___,An4,Cn5,En5 ;
	FRQ         An4,___,___,___,___,___,___,___ ;
	FRQ         ___,Cn5,En5,___,Cn2,___,___,___ ;
	FRQ         Gn3,Bn4,Dn5,Gn2,___,Gn4,Bn4,Dn5 ;
	FRQ         Fn3,An4,Cn5,Fn2,___,Fn4,An4,Cn5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Fn3,Cn5,En5,Fn2,___,Fn4,An4,En5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,Dn5,___,Cn2,___,___,Dn5 ;
	FRQ         ___,An4,Cn5,Fn2,___,___,___,Cn5 ;
	SPEED       008
	FRQ         Gn3,Gn4,Bn4,Gn2,___,Gn4,Bn4,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,An4,Cn5,___,___,___,___,Cn5 ;
	FRQ         ___,Gn4,Bn4,___,___,___,___,Bn4 ;
	FRQ         ___,Fn4,An4,___,Cn2,___,___,An4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,Bn4,Gn2,___,___,___,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       016
	FRQ         Cn4,Gn4,Cn5,Cn3,___,Cn4,En4,Cn5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn3,___,___,Gn2,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn3,___,___,Cn2,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn4,___,___,Cn3,___,Gn4,Cn5,En5 ;
	FRQ         Gn4,___,___,___,___,___,___,___ ;
	FRQ         ___,Cn5,En5,___,Cn2,___,___,___ ;
	FRQ         Gn4,___,___,Cn3,___,___,___,___ ;
	FRQ         Bn3,Dn5,Gn5,Bn2,___,Bn4,Dn5,Gn5 ;
	FRQ         Bn4,___,___,___,___,___,___,___ ;
	FRQ         Bn3,Dn5,An5,___,Cn2,___,___,An5 ;
	FRQ         Bn4,___,___,Bn2,___,___,___,___ ;
	FRQ         An3,Cn5,En5,An2,___,An4,Cn5,En5 ;
	FRQ         An4,___,___,___,___,___,___,___ ;
	FRQ         ___,Cn5,En5,___,Cn2,___,___,___ ;
	FRQ         Gn3,Bn4,Dn5,Gn2,___,Gn4,Bn4,Dn5 ;
	FRQ         Fn3,An4,Cn5,Fn2,___,Fn4,An4,Cn5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Fn3,Cn5,En5,Fn2,___,Fn4,An4,En5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,Dn5,___,Cn2,___,___,Dn5 ;
	FRQ         ___,An4,Cn5,Fn2,___,___,___,Cn5 ;
	SPEED       008
	FRQ         Gn3,Gn4,Bn4,Gn2,___,Gn4,Bn4,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,An4,Cn5,___,___,___,___,Cn5 ;
	FRQ         ___,Gn4,Bn4,___,___,___,___,Bn4 ;
	FRQ         ___,Fn4,An4,___,Cn2,___,___,An4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,Bn4,Gn2,___,___,___,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       016
	FRQ         Cn4,Gn4,Cn5,Cn3,___,Cn4,En4,Cn5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn3,___,___,Gn2,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn3,___,___,Cn2,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         An3,Cn5,En5,An2,Cn2,Cn5,En5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Cn5,En5,___,Cn2,Cn5,En5,___ ;
	FRQ         ___,___,___,An2,___,___,___,___ ;
	FRQ         Gn3,Bn4,En5,Gn2,Cn2,Bn4,En5,Q__ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,En5,___,Cn2,Bn4,En5,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,___ ;
	FRQ         Fn3,An4,En5,Fn2,Cn2,An4,En5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,An4,En5,___,Cn2,An4,En5,___ ;
	FRQ         ___,___,___,Fn2,___,___,___,___ ;
	FRQ         Gn3,Bn4,En5,Gn2,Cn2,Bn4,En5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,En5,___,Cn2,Bn4,En5,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,___ ;
	FRQ         An3,Cn5,En5,An2,Cn2,Cn5,En5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn5,Dn5,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,An2,___,___,___,___ ;
	FRQ         Gn3,An4,Cn5,Gn2,Cn2,___,___,Q__ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,Dn5,___,Cn2,___,___,___ ;
	FRQ         ___,Cn5,En5,Gn2,___,___,___,___ ;
	FRQ         Fn3,An4,Dn5,Fn2,Cn2,An4,Dn5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,An4,Cn5,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,Fn2,___,___,___,___ ;
	FRQ         Gn3,Gn4,Bn4,Gn2,Cn2,Bn4,En5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Cn4,En5,___,Cn2,___,___,___ ;
	FRQ         ___,Dn4,Dn5,Gn2,___,___,___,___ ;
	FRQ         An3,Cn5,En5,An2,Cn2,Cn5,En5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,An2,___,___,___,___ ;
	FRQ         An3,Bn4,Dn5,Gn2,Cn2,Bn4,Dn5,Q__ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Dn5,Gn5,___,Cn2,Bn4,Gn5,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,___ ;
	FRQ         Gn3,An5,Cn6,Fn2,Cn2,An5,Cn6,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn5,Bn5,___,Cn2,Gn5,Bn5,___ ;
	FRQ         ___,___,___,Fn2,___,___,___,___ ;
	FRQ         Gn3,Fn5,An5,Gn2,Cn2,Fn5,An5,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Fn3,Cn5,En5,Fn2,___,Fn4,An4,En5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,Dn5,___,Cn2,___,___,Dn5 ;
	FRQ         ___,An4,Cn5,Fn2,___,___,___,Cn5 ;
	SPEED       008
	FRQ         Gn3,Gn4,Bn4,Gn2,___,Gn4,Bn4,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,An4,Cn5,___,___,___,___,Cn5 ;
	FRQ         ___,Gn4,Bn4,___,___,___,___,Bn4 ;
	FRQ         ___,Fn4,An4,___,Cn2,___,___,An4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,Bn4,Gn2,___,___,___,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       016
	FRQ         Cn4,Gn4,Cn5,Cn3,___,Cn4,En4,Cn5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn3,___,___,Gn2,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn3,___,___,Cn2,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn2,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       018
	FRQ         Fn3,Cn5,En5,Fn2,___,Fn4,An4,En5 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Bn4,Dn5,___,Cn2,___,___,Dn5 ;
	FRQ         ___,An4,Cn5,Fn2,___,___,___,Cn5 ;
	SPEED       009
	FRQ         Gn3,Gn4,Bn4,Gn2,___,Gn4,Bn4,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,An4,Cn5,___,___,___,___,Cn5 ;
	FRQ         ___,Gn4,Bn4,___,___,___,___,Bn4 ;
	FRQ         ___,Fn4,An4,___,Cn2,___,___,An4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,Gn4,Bn4,Gn2,___,___,___,Bn4 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       018
	INS         ___,___,___,___,011,___,___,011
	VOL         ___,___,___,___,252,___,___,220
	SPEED       006
	FRQ         Gs4,___,___,As3,As2,___,___,Gn5 ;
	FRQ         ___,Cn5,___,___,___,___,Cn5,___ ;
	FRQ         ___,___,Gn5,___,___,Gs4,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       016
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	JUMP        song042_jmp000
.endproc
