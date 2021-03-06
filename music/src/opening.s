	.include "song.inc"
	.segment "BANK0"
	.export opening
.proc opening
song011_start:
	INIT        %11111111
	TEMPO       001
	TVOL        250
	SPEED       009
	PIT         014,016,018,011,015,015,040,042
	PITDEP      100,115,100,120,120,120,065,065
	PITRAT      146,140,133,135,145,145,040,040
	INS         086,086,086,006,006,006,087,087
	VOL         250,255,250,213,235,220,255,255
	LFO         ___,002,001,___,___,001,___,001
	PAN         L__,___,__R,___,___,___,L__,__R
	DTN         000,032,064,054,038,000,066,000
	FRQ         Fn2,Fn1,Fn2,___,___,___,Fn4,___ ;
	FRQ         ___,___,___,___,___,___,___,Fn4 ;
song011_jmp000:
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn6,Cn6,___,___ ;
	FRQ         ___,___,___,___,Gn6,Gn6,___,___ ;
	FRQ         ___,___,___,Cn6,Dn6,Dn6,___,___ ;
	FRQ         ___,___,___,Gn6,___,___,___,___ ;
	FRQ         ___,___,___,Dn6,Cn6,Cn6,___,___ ;
	FRQ         ___,___,___,___,Gn6,Gn6,___,___ ;
	FRQ         ___,___,___,Cn6,Dn6,Dn6,___,___ ;
	FRQ         ___,___,___,Gn6,___,___,___,___ ;
	FRQ         ___,___,___,Dn6,___,___,___,___ ;
	FRQ         ___,___,___,___,___,___,___,___ ;
	FRQ         ___,___,___,___,Cn6,Cn6,___,___ ;
	FRQ         ___,___,___,___,Gn6,Gn6,___,___ ;
	FRQ         ___,___,___,Cn6,En6,En6,___,___ ;
	FRQ         ___,___,___,Gn6,___,___,___,___ ;
	FRQ         ___,___,___,En6,___,___,___,___ ;
	VOL         ___,___,___,192,___,___,___,___
	FRQ         ___,___,___,Cn6,___,___,___,___ ;
	FRQ         ___,___,___,Gn6,___,___,___,___ ;
	FRQ         ___,___,___,En6,___,___,___,___ ;
	VOL         ___,___,___,191,___,___,___,___
	FRQ         ___,___,___,Cn6,___,___,___,___ ;
	FRQ         ___,___,___,Gn6,___,___,___,___ ;
	VOL         ___,___,___,211,___,___,___,___
	JUMP        song011_jmp000
.endproc
