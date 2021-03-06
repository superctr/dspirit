	.include "song.inc"
	.segment "BANK0"
	.export area8
.proc area8
song00b_start:
	INIT        %11111111 ; missing from original data
	TEMPO       001
	SPEED       012
	PIT         ___,___,___,___,___,___,___,004
	TVOL        255
	PITRAT      ___,___,___,___,___,___,___,100
	PITDEP      ___,___,___,___,___,___,___,180
	ENV         ___,___,___,___,___,___,___,___
	GTM         ___,___,___,___,___,___,___,003
song00b_jmp000:
	INS         020,020,020,005,020,020,020,001
	VOL         ___,___,___,255,___,___,___,250
	LFO         ___,___,___,___,001,001,001,___
song00b_rept000:
	PAN         L__,L__,L__,_C_,__R,__R,__R,___
	DTN         000,004,008,000,018,022,032,000
	VOL         160,160,160,___,160,160,160,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         170,170,170,___,170,170,170,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         180,180,180,___,180,180,180,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         190,190,190,___,190,190,190,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         200,200,200,___,200,200,200,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         210,210,210,___,210,210,210,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         220,220,220,___,220,220,220,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         230,230,230,___,230,230,230,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs3,Dn4,___ ;
	VOL         255,255,255,___,255,255,255,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Gn3,Cs4,Dn4,Gn2 ;
	VOL         220,220,220,___,220,220,220,___
	FRQ         Gn3,Cs4,Dn4,Q__,Gn3,Cs4,Dn4,___ ;
	VOL         210,210,210,___,210,210,210,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs4,Dn4,___ ;
	VOL         255,255,255,___,255,255,255,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Gn3,Cs4,Dn4,Gn2 ;
	VOL         220,220,220,___,220,220,220,___
	FRQ         Gn3,Cs4,Dn4,Q__,Gn3,Cs4,Dn4,___ ;
	VOL         210,210,210,___,210,210,210,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs4,Dn4,___ ;
	VOL         200,200,200,___,200,200,200,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs4,Dn4,___ ;
	VOL         190,190,190,___,190,190,190,___
	FRQ         Gn3,Cs4,Dn4,___,Gn3,Cs4,Dn4,___ ;
	REPT        $01, song00b_rept000
	PIT         ___,___,___,___,004,004,004,___
	PITRAT      ___,___,___,___,010,010,010,___
	PITDEP      ___,___,___,___,030,030,030,___
	INS         ___,___,___,___,031,031,031,___
	LFO         ___,___,___,___,001,255,255,___
	VOL         255,255,255,___,245,___,___,___
	PAN         _C_,L__,__R,___,___,___,___,___
	DTN         000,000,000,000,000,000,000,000
	FRQ         Gn3,Cs4,Dn4,Gn2,Gn3,___,___,Gn2 ;
	VOL         240,240,240,___,___,225,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn3,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         220,220,220,___,___,___,245,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,Cn4,___ ;
	VOL         210,210,210,___,225,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cn4,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         160,160,160,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         170,170,170,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         240,240,240,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         250,250,250,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         240,240,240,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	PIT         ___,___,___,___,000,000,000,___
	INS         ___,___,___,___,037,028,028,___
	LFO         ___,___,___,___,255,255,255,___
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,En3,Dn5,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,Bn3,___,Dn5,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Bn3,Cs5,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,En3,___,Cs5,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Bn3,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,Gn4,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Bn3,___,___,___ ;
	PIT         ___,___,___,___,___,___,004,___
	PITRAT      ___,___,___,___,___,___,010,___
	PITDEP      ___,___,___,___,___,___,030,___
	VOL         255,255,255,___,220,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,En3,___,Gn4,Gn2 ;
	VOL         220,220,220,___,210,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,Bn3,___,___,___ ;
	VOL         210,210,210,___,200,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
	VOL         255,255,255,___,190,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Bn3,___,___,Gn2 ;
	VOL         220,220,220,___,180,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,En3,___,___,___ ;
	VOL         210,210,210,___,170,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Bn3,___,___,___ ;
	VOL         200,200,200,___,160,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
	VOL         190,190,190,___,150,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Bn3,___,___,___ ;
	INS         ___,___,___,___,011,011,011,___
	VOL         ___,___,___,___,200,200,220,___
	LFO         ___,___,___,___,255,255,255,___
	PIT         ___,___,___,001,001,001,001,___
	VOL         160,160,160,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,An5,___ ;
	VOL         170,170,170,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,Cs5,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,Gn4,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Gn4,___,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,Cs5,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Gn4,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Gn4,___,___,___ ;
	VOL         160,160,160,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,Gn5,___ ;
	VOL         170,170,170,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,Cs5,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,Fn4,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Fn4,___,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,Cs5,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
	VOL         160,160,160,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,An5,___ ;
	VOL         170,170,170,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Gn4,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,Cs5,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,Gn4,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Gn4,___,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,Cs5,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Gn4,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,Fn5,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Gn4,___,___,___ ;
	VOL         160,160,160,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,Gn5,___ ;
	VOL         170,170,170,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Cs5,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn5,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn4,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,Cs5,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,Fn4,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,Fn4,___,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,Cs5,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,Fn5,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,Fn4,___,___,___ ;
song00b_rept001:
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,___,___,Gn2 ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,___,___,Gn2 ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,___,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn2,___,___,___,Gn2 ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Gn3,___,___,___,Gn2 ;
	REPT        $01, song00b_rept001
	VOL         160,160,160,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,Q__,___,___,___,___ ;
	VOL         170,170,170,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         180,180,180,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         190,190,190,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         200,200,200,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         210,210,210,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         220,220,220,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         230,230,230,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         240,240,240,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         250,250,250,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         255,255,255,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	VOL         ___,___,___,___,___,___,___,___
	FRQ         Gn3,Cs4,Dn4,___,___,___,___,___ ;
	SPEED       008
	VOL         ___,___,___,255,___,___,___,245
	FRQ         Gn3,Cs4,Dn4,Gn2,___,___,___,Gn3 ;
	VOL         ___,___,___,___,___,___,___,255
	FRQ         Q__,Q__,Q__,Gn3,___,___,___,Gn3 ;
	VOL         ___,___,___,___,___,___,___,245
	FRQ         Gn3,Cs4,Dn4,Gn2,___,___,___,En3 ;
	VOL         ___,___,___,___,___,___,___,255
	FRQ         Q__,Q__,Q__,Gn3,___,___,___,En3 ;
	VOL         ___,___,___,___,___,___,___,245
	FRQ         Gn4,Cs5,Dn5,Gn2,___,___,___,Cn3 ;
	VOL         ___,___,___,___,___,___,___,255
	FRQ         ___,___,___,Gn3,___,___,___,Cn3 ;
	SPEED       012
	INS         011,011,011,___,011,011,011,___
	VOL         ___,___,___,___,200,200,220,___
	LFO         001,001,001,___,255,255,255,___
	VOL         130,130,200,255,___,___,___,255
	FRQ         ___,___,___,Gn2,Cs5,___,An5,Gn2 ;
	VOL         140,140,___,___,___,___,___,___
	FRQ         Cs5,___,An5,Q__,___,Gn4,___,___ ;
	VOL         150,150,___,___,___,___,___,___
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	VOL         160,160,___,___,___,___,___,___
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	VOL         170,170,___,___,___,___,___,___
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	VOL         175,175,___,___,___,___,___,___
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	VOL         180,180,___,___,___,___,___,___
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	VOL         200,200,___,___,___,___,___,___
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,Gn5,___ ;
	FRQ         Cs5,___,Gn5,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,An5,___ ;
	FRQ         Cs5,___,Gn5,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,Gn5,___ ;
	FRQ         Cs5,___,Gn5,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	VOL         130,130,200,___,___,___,___,___
	FRQ         ___,___,___,___,Cs5,___,An5,___ ;
	VOL         140,140,___,___,___,___,___,___
	FRQ         Cs5,___,An5,___,___,Gn4,___,___ ;
	VOL         150,150,___,___,___,___,___,___
	FRQ         ___,Gn4,___,Gn2,Fn5,___,___,Gn2 ;
	VOL         160,160,___,___,___,___,___,___
	FRQ         Fn5,___,___,Q__,___,Gn4,___,___ ;
	VOL         170,170,___,___,___,___,___,___
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	VOL         175,175,___,___,___,___,___,___
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	VOL         180,180,___,___,___,___,___,___
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	VOL         200,200,___,___,___,___,___,___
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,Gn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Q__,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,Gn5,___ ;
	FRQ         Cs5,___,Gn5,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,Gn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Q__,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,Gn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Gn2,___,Gn4,___,Gn2 ;
	FRQ         ___,Gn4,___,Q__,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,Gn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,An5,___ ;
	FRQ         Cs5,___,Gn5,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,Fn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Q__,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,Fn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Q__,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,Gn5,___ ;
	FRQ         Cs5,___,Gn5,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,Fn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Q__,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,Fn2,Fn5,___,___,Gn2 ;
	FRQ         Fn5,___,___,Q__,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Cs5,___,___,___ ;
	FRQ         Cs5,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,Fn4,___,___,Fn5,___,___,___ ;
	FRQ         Fn5,___,___,___,___,Fn4,___,___ ;
	INS         033,033,033,___,___,___,___,___
	VOL         220,220,220,___,___,___,___,___
	LFO         255,255,255,___,___,___,___,___
	PAN         L__,___,__R,___,___,___,___,___
	FRQ         Fs3,Bn3,Fn4,Gn2,Cs5,___,An5,An2 ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,Gn2,Cs5,___,Gn5,Gn2 ;
	FRQ         ___,___,___,Gn2,___,Gn4,___,Gn2 ;
	FRQ         ___,___,___,Q__,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Gn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         Fs3,Bn3,Ds4,Gn2,Cs5,___,An5,Gn2 ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,Gn2,Cs5,___,Gn5,Gn2 ;
	FRQ         ___,___,___,Gn2,___,Fn4,___,Gn2 ;
	FRQ         ___,___,___,Q__,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Cs5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,___,Fn5,___,___,___ ;
	FRQ         ___,___,___,___,___,Fn4,___,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,___,Q__ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,Gn2 ;
	FRQ         ___,___,___,Gn2,___,___,___,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	FRQ         ___,___,___,Gn2,___,___,___,Gn2 ;
	FRQ         ___,___,___,Q__,___,___,___,___ ;
	JUMP        song00b_jmp000
.endproc
