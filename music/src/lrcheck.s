	.include "song.inc"
	.segment "BANK0"
	.export lrcheck
.proc lrcheck
song040_start:
	INIT        %11111111
	TEMPO       001
	TVOL        250
	SPEED       012
	PIT         ___,___,___,___,___,___,___,004
	PITRAT      ___,___,___,___,___,___,___,100
	TRS         -24,___,___,___,___,___,___,___
	PITDEP      ___,___,___,___,___,___,___,180
	ENV         ___,___,___,___,___,___,___,___
	GTM         ___,___,___,___,___,___,___,255
	INS         004,006,007,034,009,010,062,001
	VOL         245,245,245,240,250,240,255,255
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	SPEED       007
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,___,Cn2 ;
	FRQ         An4,An4,An4,An4,An4,An4,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn4,Gn4,Gn4,Gn4,Gn4,Gn4,___,Cn3 ;
	FRQ         An4,An4,An4,An4,An4,An4,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn4,Gn4,Gn4,Gn4,Gn4,Gn4,___,Gn3 ;
	FRQ         En4,En4,En4,En4,En4,En4,___,En3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Dn4,Dn4,Dn4,Dn4,Dn4,Dn4,___,Cn3 ;
	FRQ         Cn4,Cn4,Cn4,Cn4,Cn4,Cn4,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn6,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn6,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Q__,Q__,Q__,Q__,Q__,Q__,Q__,Q__ ;
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
	COMM        001
	PAN         L__,L__,L__,L__,L__,L__,L__,L__
	SPEED       007
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,___,Cn2 ;
	FRQ         An4,An4,An4,An4,An4,An4,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn4,Gn4,Gn4,Gn4,Gn4,Gn4,___,Cn3 ;
	FRQ         An4,An4,An4,An4,An4,An4,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Gn4,Gn4,Gn4,Gn4,Gn4,Gn4,___,Gn3 ;
	FRQ         En4,En4,En4,En4,En4,En4,___,En3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Dn4,Dn4,Dn4,Dn4,Dn4,Dn4,___,Cn3 ;
	FRQ         Cn4,Cn4,Cn4,Cn4,Cn4,Cn4,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn6,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn6,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         L__,L__,L__,L__,L__,L__,L__,L__
	COMM        001
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,___,Cn2 ;
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	FRQ         An4,An4,An4,An4,An4,An4,___,Cn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         L__,L__,L__,L__,L__,L__,L__,L__
	COMM        001
	FRQ         Gn4,Gn4,Gn4,Gn4,Gn4,Gn4,___,Cn3 ;
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	FRQ         An4,An4,An4,An4,An4,An4,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         L__,L__,L__,L__,L__,L__,L__,L__
	COMM        001
	FRQ         Gn4,Gn4,Gn4,Gn4,Gn4,Gn4,___,Gn3 ;
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	FRQ         En4,En4,En4,En4,En4,En4,___,En3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         L__,L__,L__,L__,L__,L__,L__,L__
	COMM        001
	FRQ         Dn4,Dn4,Dn4,Dn4,Dn4,Dn4,___,Cn3 ;
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	FRQ         Cn4,Cn4,Cn4,Cn4,Cn4,Cn4,___,Cn2 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         L__,L__,L__,L__,L__,L__,L__,L__
	COMM        001
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn6,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	PAN         __R,__R,__R,__R,__R,__R,__R,__R
	COMM        000
	FRQ         Cn5,Cn5,Cn5,Cn5,Cn5,Cn5,Cn6,Gn3 ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	RET
.endproc
