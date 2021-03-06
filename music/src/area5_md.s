	.include "song.inc"
	.segment "BANK0"
	.export area5
.proc area5
song008_start:
	CHANNEL		001,002,003,004,005,007,009,006
	TVOL        250
	TEMPO       001
	SPEED       008
	PIT         011,013,015,___,009,009,___,004
	PITRAT      145,140,142,___,230,230,___,150
	PITDEP      120,120,120,___,100,100,___,150
	GTM         ___,___,___,___,___,___,002,003
	INS         020,020,020,005,009,009,038,001
	VOL         250,250,253,255,235,230,240,255
	PAN         L__,__R,_C_,___,___,___,___,___
	LFO         ___,___,___,___,___,001,___,___
	PAN         ___,___,___,___,___,___,___,___
	DTN         000,004,008,018,022,006,___,___
	FRQ         Bn3,Cn4,En4,An2,___,___,Cn7,Cn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,An2,___,___,Cn7,Cn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,An2,___,___,Cn7,Cn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         ___,___,___,An2,___,___,___,Cn2 ;
	FRQ         ___,___,___,An2,___,___,___,Cn2 ;
	FRQ         ___,___,___,An2,___,___,Cn7,Cn4 ;
	FRQ         ___,___,___,An2,___,___,___,Cn4 ;
	FRQ         ___,___,___,An3,___,___,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
song008_jmp000:
	CHANNEL		___,___,___,___,___,007,009,___
	ENV			___,___,___,___,___,017,009,___
	LINKVOL		___,___,___,___,___,001,___,___
	TRS			___,___,___,___,___,000,040,___
	PIT         ___,___,___,___,009,009,000,___
	PITRAT      ___,___,___,___,230,230,___,___
	PITDEP      ___,___,___,___,100,100,___,___
	INS         ___,___,___,___,009,009,___,___
	VOL         ___,___,___,___,235,235,240,___
	LFO         ___,___,___,___,___,001,___,___
	GTM         ___,___,___,___,___,___,002,___
song008_rept000:
	FRQ         Bn4,Cn5,En5,An2,An4,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,An2,Cn5,An4,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En5,Q__,Bn5,Cn5,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,___,___,Bn5,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,Cn6,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,Q__,___,Cn6,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,___,___,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En5,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,An3,En6,___,___,Cn2 ;
	FRQ         Bn3,Cn4,En4,___,___,En6,Cn7,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,An5,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,An2,___,An5,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En5,Q__,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En4,An2,___,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En4,An2,Cn6,___,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En4,An2,An5,Cn6,___,___ ;
	FRQ         Cn4,Dn4,Fn4,Fn3,En5,An5,___,Cn2 ;
	FRQ         ___,___,___,___,___,En5,Cn7,___ ;
	FRQ         ___,___,___,___,___,___,Cn7,___ ;
	FRQ         ___,___,___,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,Bn5,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,An2,___,Bn5,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En5,Q__,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,En5,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,En5,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,___,___,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En5,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,An3,___,___,___,Cn2 ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,An2,An5,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,An2,___,An5,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En5,Q__,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En5,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,___,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Bn3,Cn4,En4,___,___,___,Cn7,___ ;
	FRQ         Bn4,Cn5,En4,An2,Cn5,___,Cn7,Cn2 ;
	FRQ         Q__,Q__,Q__,___,___,Cn5,Cn7,___ ;
	FRQ         Bn4,Cn5,En4,An2,___,___,Cn7,Cn2 ;
	FRQ         Bn4,Cn5,En4,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,___,___,___,Cn7,___ ;
	FRQ         Cn4,Dn4,Fn4,Fn3,___,___,Cn7,Cn2 ;
	FRQ         ___,___,___,___,___,___,Cn7,___ ;
	FRQ         ___,___,___,___,___,___,Cn7,___ ;
	REPT        $01, song008_rept000
	CHANNEL		___,___,___,___,___,___,008,___
	LINKVOL		___,___,___,___,___,___,002,___
	ENV			___,___,___,___,___,011,018,___
	TRS			___,___,___,___,___,012,012,___
	PIT         ___,___,___,___,000,000,011,___
	PITRAT      ___,___,___,___,___,___,140,___
	PITDEP      ___,___,___,___,000,000,150,___
	INS         ___,___,___,___,011,011,081,___
	VOL         ___,___,___,___,230,237,227,___
	GTM			___,___,___,___,___,___,000,___
	LFO         ___,___,___,___,___,001,___,___
	FRQ         An3,Cn4,En4,Fn2,An4,___,An3,Cn2 ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         ___,___,___,___,En5,Cn5,___,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,En5,Fn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         ___,___,___,___,En5,Cn5,En4,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,En5,Fn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,___ ;
	FRQ         ___,___,___,___,En5,An4,___,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,An5,Fn5,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Gn4,An5,Bn3,Cn2 ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,Bn4,___,___ ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Dn5,En5,___,___ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,Bn4,Gn4,___ ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Dn5,En5,___,___ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,Bn4,___,___ ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         An3,Cn4,En4,Fn2,An4,En5,En4,Cn2 ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         An3,Cn4,En4,Fn2,En5,Cn5,___,Cn2 ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,Q__,En5,Fn5,___,Q__ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         ___,___,___,___,En5,Cn5,Cn4,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,En5,Fn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,En4,___ ;
	FRQ         ___,___,___,___,En5,An4,___,___ ;
	FRQ         ___,___,___,Fn2,Fn5,En5,___,Cn2 ;
	FRQ         ___,___,___,___,An5,Fn5,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Gn4,An5,Dn4,Cn2 ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Dn5,Bn4,___,Cn2 ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,Q__,Dn5,En5,___,Q__ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,Bn4,Gn3,___ ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Dn5,En5,___,___ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,Bn4,An3,___ ;
	FRQ         ___,___,___,___,En5,Dn5,Bn3,___ ;
	FRQ         An3,Cn4,En4,Fn2,An4,En5,Cn4,Cn2 ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         An3,Cn4,En4,Fn2,En5,Cn5,___,Cn2 ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	GTM         ___,___,___,___,___,___,___,255
	FRQ         ___,___,___,Fn3,En5,Fn5,___,Cn3 ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         ___,___,___,___,En5,Cn5,___,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,En5,Fn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,En3 ;
	FRQ         ___,___,___,___,En5,An4,___,Cn3 ;
	FRQ         ___,___,___,___,Fn5,En5,___,Gn2 ;
	GTM         ___,___,___,___,___,___,___,003
	FRQ         ___,___,___,___,An5,Fn5,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Gn4,An5,___,Cn2 ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Dn5,Bn4,___,Cn2 ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,Q__,Dn5,En5,___,Q__ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	SPEED       002
	GTM         ___,___,___,___,___,___,___,255
	FRQ         ___,___,___,___,Dn5,Bn4,Bn3,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       008
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Dn5,En5,___,___ ;
	SPEED       002
	FRQ         ___,___,___,___,Bn4,Dn5,Cn4,En3 ;
	FRQ         ___,___,___,___,___,___,___,En3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       008
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	SPEED       002
	FRQ         ___,___,___,___,Dn5,Bn4,Dn4,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	SPEED       008
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	GTM         ___,___,___,___,___,___,___,003
	FRQ         An3,Cn4,En4,Fn2,An4,En5,En4,Cn2 ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         An3,Cn4,En4,Fn2,En5,Cn5,___,Cn2 ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,Q__,En5,Fn5,___,Q__ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,An4,___,___ ;
	FRQ         ___,___,___,___,En5,Cn5,___,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,En5,Fn5,___,___ ;
	FRQ         ___,___,___,___,Cn5,En5,___,___ ;
	FRQ         ___,___,___,___,An4,Cn5,___,___ ;
	FRQ         ___,___,___,___,En5,An4,___,___ ;
	FRQ         ___,___,___,___,Fn5,En5,___,___ ;
	FRQ         ___,___,___,___,An5,Fn5,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Gn4,An5,___,Cn2 ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         Bn3,Dn4,En4,Gn2,Dn5,Bn4,___,Cn2 ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Dn5,En5,___,___ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	FRQ         ___,___,___,___,Gn4,Bn4,___,___ ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,___ ;
	FRQ         ___,___,___,___,Dn5,Bn4,___,___ ;
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	FRQ         ___,___,___,___,Dn5,En5,___,___ ;
	FRQ         ___,___,___,___,Bn4,Dn5,___,___ ;
	GTM         ___,___,___,___,___,___,___,255
	FRQ         ___,___,___,___,Gn4,Bn4,___,Cn3 ;
	FRQ         ___,___,___,___,Bn4,Gn4,___,Gn2 ;
	FRQ         ___,___,___,___,Dn5,Bn4,___,Cn2 ;
	GTM         ___,___,___,___,___,___,___,003
	FRQ         ___,___,___,___,En5,Dn5,___,___ ;
	JUMP        song008_jmp000
.endproc
