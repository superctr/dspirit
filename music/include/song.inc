;==============================================================================
;
;  Song data defines and macros
;
;==============================================================================

	.list	-

.scope	Q
	RESTCNT		.set	0
	
	; register operation (this means 'rXX' will be treated as immediate)
	regop		.set	0
	
	; these are all filled in by __parse_arg or __parse_args macros
	arg0		.set	0
	arg1		.set	0
	arg2		.set	0
	arg3		.set	0
	arg4		.set	0
	arg5		.set	0
	arg6		.set	0
	arg7		.set	0
	arg8		.set	0
	arg9		.set	0
	arg10		.set	0
	arg11		.set	0
	arg12		.set	0
	arg13		.set	0
	arg14		.set	0
	
	imm_mask	.set	0	; bitmask of immediate type operands
	reg_mask	.set	0	; bitmask of register type operands
	nul_mask	.set	0	; bitmask of unused operands
	
	imm_equal	.set	0	; set if all immediate operands were equal
	imm_data	.set	0	; data of first immediate operand
	imm_word	.set	0	; set if at least one immediate operand is 16-bit
	
	reg_equal	.set	0	; set if all register operands were equal
	reg_data	.set	0	; data of first register operand
	
.endscope

.include	"regdef.inc"

	.define L__ %10000000 ; swapped for MD
	.define __R %01000000 ; swapped for MD
	.define _C_ %11000000

.macro POS addr
	.byt	>addr
	.byt	<addr
.endmacro

;==============================================================================
;
; Macro helpers for sequence commands
;
;==============================================================================


.macro __cbyt __arg, __mask
	.if ((__arg < ___) && (Q::imm_mask & __mask)>0)
		.byt	<__arg
	.endif
.endmacro

.macro __byte
	__cbyt Q::arg0, %10000000
	__cbyt Q::arg1, %01000000
	__cbyt Q::arg2, %00100000
	__cbyt Q::arg3, %00010000
	__cbyt Q::arg4, %00001000
	__cbyt Q::arg5, %00000100
	__cbyt Q::arg6, %00000010
	__cbyt Q::arg7, %00000001
.endmacro



.macro  __parse_arg  __in, __out, __mask

	__out	.set	___
	.ifnblank __in
		__out	.set	__in
	.endif
	
	.if (__out<___)	; immediate
		.if(Q::imm_data = ___)
			Q::imm_data .set __out
		.elseif(__out <> Q::imm_data)
			Q::imm_equal .set 0
		.endif
		Q::imm_mask .set Q::imm_mask | __mask
		.if(__out>$ff)
			Q::imm_word .set Q::imm_word | __mask
		.endif
	.else				; neither
		Q::nul_mask .set Q::nul_mask | __mask
	.endif
	
.endmacro

.macro	__parse_args	p0,p1,p2,p3,p4,p5,p6,p7
	Q::imm_equal	.set	1
	Q::imm_data		.set	___
	Q::reg_equal	.set	1
	Q::reg_data		.set	___
	Q::imm_mask		.set	0
	Q::reg_mask		.set	0
	Q::nul_mask		.set	0
	Q::imm_word		.set	0

	__parse_arg		p0,Q::arg0,%10000000
	__parse_arg		p1,Q::arg1,%01000000
	__parse_arg		p2,Q::arg2,%00100000
	__parse_arg		p3,Q::arg3,%00010000
	__parse_arg		p4,Q::arg4,%00001000
	__parse_arg		p5,Q::arg5,%00000100
	__parse_arg		p6,Q::arg6,%00000010
	__parse_arg		p7,Q::arg7,%00000001
.endmacro

.macro	__parse_args_mult	p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14
	Q::imm_equal	.set	1
	Q::imm_data		.set	___
	Q::reg_equal	.set	1
	Q::reg_data		.set	___
	Q::imm_mask		.set	0
	Q::reg_mask		.set	0
	Q::nul_mask		.set	0
	Q::imm_word		.set	0

	__parse_arg		p0,Q::arg0, %1000000000000000
	__parse_arg		p1,Q::arg1, %0100000000000000
	__parse_arg		p2,Q::arg2, %0010000000000000
	__parse_arg		p3,Q::arg3, %0001000000000000
	__parse_arg		p4,Q::arg4, %0000100000000000
	__parse_arg		p5,Q::arg5, %0000010000000000
	__parse_arg		p6,Q::arg6, %0000001000000000
	__parse_arg		p7,Q::arg7, %0000000100000000
	__parse_arg		p8,Q::arg8, %0000000010000000
	__parse_arg		p9,Q::arg9, %0000000001000000
	__parse_arg		p10,Q::arg10,%0000000000100000
	__parse_arg		p11,Q::arg11,%0000000000010000
	__parse_arg		p12,Q::arg12,%0000000000001000
	__parse_arg		p13,Q::arg13,%0000000000000100
	__parse_arg		p14,Q::arg14,%0000000000000010
	
	Q::imm_mask		.set	Q::imm_mask | Q::reg_mask
.endmacro

;==============================================================================
;
; Parser macros
;
;==============================================================================

; key-on
;------------------------------------------------------------------------------
; type .... opcode
; p0-p7	... operands
.macro __keyon type, p0,p1,p2,p3,p4,p5,p6,p7

	__parse_args p0,p1,p2,p3,p4,p5,p6,p7

	.if (Q::nul_mask = $ff)	
		.byte	$1f
		.exitmacro
	.endif

	.if (Q::imm_equal = 1)
		.byte	type+64
		.byte	Q::imm_mask
		.byte	<Q::imm_data
	.else
		.byte	type
		.byte	Q::imm_mask
		__byte
	.endif

.endmacro

; set channel variable
;------------------------------------------------------------------------------
; btype	... opcode for byte commands
; wtype ... opcode for word commands
; rtype ... opcode for reg. commands
; subtype . channel variable ID
; p0-p7 ... operands
; rop ..... indicates register operation
.macro __chvar btype, p0,p1,p2,p3,p4,p5,p6,p7,rop

	.local _bt,_wt,_rt

	__parse_args p0,p1,p2,p3,p4,p5,p6,p7
	
	.if (Q::nul_mask = $ff)	
		.exitmacro
	.endif

	.if (Q::imm_mask > 0)
		.if (Q::imm_equal = 1)
			.byte	btype+64
			.byte	Q::imm_mask
			.byte	<Q::imm_data
		.else
			.byte	btype
			.byte	Q::imm_mask
			__byte
		.endif
	.endif

	Q::regop .set 0

.endmacro

	.include "_songcmd.inc"

	.list +
