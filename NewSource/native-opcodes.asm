;;
;; the routines for Jump2 that implement JVM opcodes
;;
;;; Routines begin with a special comment declaring the
;;; opcode being implemented. This is translated to a
;;; label "op_" + opcode-name.
;;; The routine ends at the next blank line.

;; jvm-opcode newarray
	;;    d0 = class index, 
	;;    d1 = element size, 
	;; 4(a7) = length
	;; OUT   4(a7) = new array (zero-filled)
	movem.l	d3-d4/a3,-(a7)
	move.w	d1,d3
	move.w	d0,d4
	move.l	16(a7),d1	; get length from stack
	bmi.s	op_newarray_badSize
	bsr	getclassinfo
	clr.l	d0
     	move.w	ClassInfo.ObjectSizePlusHeader(a0),d0
	bsr	allocMem
	beq.s	op_newarray_noMem
	move.l	a0,a3
     	move.w	d4,ObjectHeader_ClassIndex(a3)
	move.l	16(a7),d0	; get length from stack
	move.w	d0,Array.length(a3)
	move.w	d3,Array.elsize(a3)
	move.l	a3,16(a7)	; insert result into stack
	mulu.w	d3,d0
	addq.l	#1,d0		; get extra byte for a '\0'
	bsr	allocRawMem
	beq.s	op_newarray_noMem
	move.l	a0,Array.data(a3)
	movem.l	(a7)+,d3-d4/a3
	rts
op_newarray_noMem
	movem.l	(a7)+,d3-d4/a3
	bra	throw_OutOfMemoryError
op_newarray_badSize
	movem.l	(a7)+,d3-d4/a3
	bra	throw_NegativeArraySizeException

;; jvm-opcode anewarray
; d0 = class index, 4(a7) = length
	movem.l	d4/a3,-(a7)
	move.w	d0,d4
	move.l	12(a7),d1	; get length from stack
	cmp.l	#$10000,d1
	bcc	op_anewarray_badSize
	clr.l	d0
	move.l	#ObjectHeader_sizeof+Array_sizeof,d0
	bsr	allocMem
	beq.s	op_anewarray_noMem
	move.l	a0,a3
     	move.w	d4,ObjectHeader_ClassIndex(a3)
	move.l	12(a7),d0	; get length from stack
	move.w	d0,Array.length(a3)
	move.w	#4,Array.elsize(a3)
	move.l	a3,12(a7)
	asl.l	#2,d0
	bsr	allocRawMem
	beq.s	op_anewarray_noMem
	move.l	a0,Array.data(a3)
	movem.l	(a7)+,d4/a3
	rts
op_anewarray_noMem
	movem.l	(a7)+,d4/a3
	bra	throw_OutOfMemoryError
op_anewarray_badSize
	movem.l	(a7)+,d4/a3
	bra	throw_NegativeArraySizeException

;; jvm-opcode imul
	; must not touch a0
	move.l	4(a7),d0	; d0 = factor1
	move.l	8(a7),d1	; d1 = factor2
	movem.l	d3,-(a7)
	move.w	d0,d2
	mulu.w	d1,d2		; d2 = LL
	move.l	d0,d3
	swap.w	d3		; d3 = swap(factor1)
	mulu.w	d1,d3		; d3 = HL
	swap.w	d3
	clr.w	d3
	add.l	d3,d2		; d2 = LL + HL<<16
	move.l	d1,d3
	swap.w	d3		; d3 = swap(factor2)
	mulu.w	d0,d3		; d3 = LH
	swap.w	d3
	clr.w	d3
	add.l	d3,d2		; d2 = LL + HL<<16 + LH<<16
	movem.l	(a7)+,d3
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d2,(a7)
     	jmp	(a1)

;; jvm-opcode idiv
;; uses-class java/lang/ArithmeticException as class_AE
;; uses-instance java/lang/ArithmeticException
;; uses-method java/lang/ArithmeticException.<init>()V as method_AE_init
	; must not touch a0 in non-exception path
	moveq.l	#1,d2		; sign flag
	move.l	4(a7),d0	; denominator
	beq	op_idiv_throw	; (a7) = initiating address
	bpl.s	op_idiv_a
	neg.l	d0
	neg.b	d2
op_idiv_a:			; d0 = abs(den)
	move.l	8(a7),d1	; numerator
	bpl.s	op_idiv_b
	neg.l	d1
	neg.b	d2
op_idiv_b:			; d1 = abs(num)
	cmp.l	#$10000,d0
	bcc.s	op_idiv_32	; divide 32 by 32 bit
	cmp.l	#$10000,d1
	bcc.s	op_idiv_32_16	; divide 32 by 16 bit
	; --- divide 16 by 16 bit ---
	divu.w	d0,d1		; using 16-bit division
	clr.l	d0
	move.w	d1,d0		; d0 = abs(result)
	tst.b	d2
	bpl.s	op_idiv_c
	neg.l	d0
op_idiv_c:
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d0,(a7)
     	jmp	(a1)
	;
	; --- divide 32 by 16 bit ---
op_idiv_32_16:
	movem.l	d3-d4,-(a7)
	move.l	d1,d3
	clr.w	d3
	swap.w	d3		; d3.w = high(num)
	divu.w	d0,d3
	clr.l	d4
	move.w	d3,d4
	swap.w	d4		; d4 = high(num/den)
	move.w	d1,d3		; d3 = high-remainder<<16 + low(num)
	divu.w	d0,d3
	move.w	d3,d4		; d4 = abs(num/den)
	tst.b	d2
	bpl.s	op_idiv_d
	neg.l	d4
op_idiv_d:
	move.l	d4,d0
	movem.l	(a7)+,d3-d4
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d0,(a7)
     	jmp	(a1)
	;
	; --- divide 32 by 32 bit: d1/d0 ---
	; we know that the denominator is greater than $FFFF.
op_idiv_32:
	movem.l	d3-d5,-(a7)
	clr.l	d4
	move.l	#$8000,d5	; add-value for quotient (first iteration)
	move.l	d1,d3
	clr.w	d3
	swap.w	d3		; d3 = high(num)
op_idiv_loop:
	;; d5 = result bit mask
	;; d4 = result
	;; d3 = shifted numerator
	lsl.w	#1,d1
	roxl.l	#1,d3
	cmp.l	d0,d3
	bcs.s	op_idiv_e
	add.l	d5,d4		; set quotient bit
	sub.l	d0,d3		; adjust numerator
op_idiv_e:
	lsr.l	#1,d5
	bne.s	op_idiv_loop	; repeat if add-value > 0
	tst.b	d2
	bpl.s	op_idiv_f
	neg.l	d4
op_idiv_f:
	move.l	d4,d0
	movem.l	(a7)+,d3-d5
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d0,(a7)
     	jmp	(a1)
op_idiv_throw:
	move.l	#class_AE,d0
	bsr	op_new
	bsr.far	method_AE_init
	move.l	(a7)+,a0	; exception instance
	move.l	(a7)+,a1	; initiator address
	bra	do_athrow

;; jvm-opcode irem
;; uses-class java/lang/ArithmeticException as class_AE
;; uses-instance java/lang/ArithmeticException
;; uses-method java/lang/ArithmeticException.<init>()V as method_AE_init
	moveq.l	#1,d2		; sign (default = +1)
	move.l	4(a7),d0	; denominator
	beq	op_irem_throw
	bpl.s	op_irem_a
	neg.l	d0
op_irem_a:			; d0 = abs(den)
	move.l	8(a7),d1	; numerator
	bpl.s	op_irem_b
	neg.l	d1
	neg.b	d2		; sign = -1 when numerator negative
op_irem_b:			; d1 = abs(num)
	cmp.l	#$10000,d0
	bcc.s	op_irem_32	; divide 32 by 32 bit
	cmp.l	#$10000,d1
	bcc.s	op_irem_32_16	; divide 32 by 16 bit
	; --- divide 16 by 16 bit ---
	divu.w	d0,d1		; using 16-bit division
	clr.l	d0
	swap.w	d1
	move.w	d1,d0		; d0 = abs(result)
	tst.b	d2
	bpl.s	op_irem_c
	neg.l	d0
op_irem_c:
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d0,(a7)
     	jmp	(a1)
	;
	; --- divide 32 by 16 bit ---
op_irem_32_16:
	movem.l	d3-d4,-(a7)
	move.l	d1,d3
	clr.w	d3
	swap.w	d3		; d3.w = high(num)
	divu.w	d0,d3
	move.w	d1,d3		; d3 = high-remainder<<16 + low(num)
	divu.w	d0,d3
	clr.l	d4
	swap.w	d3
	move.w	d3,d4		; d4 = abs(num/den)
	tst.b	d2
	bpl.s	op_irem_d
	neg.l	d4
op_irem_d:
	move.l	d4,d0
	movem.l	(a7)+,d3-d4
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d0,(a7)
     	jmp	(a1)
	;
	; --- divide 32 by 32 bit ---
	; we know that the denominator is greater than $FFFF.
op_irem_32:
	movem.l	d3-d5,-(a7)
	clr.l	d4
	move.l	#$8000,d5	; add-value for quotient (first iteration)
	move.l	d1,d3
	clr.w	d3
	swap.w	d3		; d3 = high(num)
op_irem_loop:
	lsl.w	#1,d1
	roxl.l	#1,d3
	cmp.l	d0,d3
	bcs.s	op_irem_e
	sub.l	d0,d3		; adjust numerator
op_irem_e:
	lsr.l	#1,d5
	bne.s	op_irem_loop	; repeat if add-value > 0
	tst.b	d2
	bpl.s	op_irem_f
	neg.l	d3
op_irem_f:
	move.l	d3,d0
	movem.l	(a7)+,d3-d5
	move.l	(a7),a1
	addq	#8,a7
     	move.l	d0,(a7)
     	jmp	(a1)
op_irem_throw:
	move.l	#class_AE,d0
	bsr	op_new
	bsr.far	method_AE_init
	move.l	(a7)+,a0	; exception instance
	move.l	(a7)+,a1	; initiator address
	bra	do_athrow

;; jvm-opcode lshl
	move.l	8(a7),d0
	move.l	12(a7),d1
	move.l	4(a7),d2
	beq.s	op_lshl_out
	btst.l	#5,d2		; shift 32 or more?
	bne.s	op_lshl_32
	; shift by less than 32 bits: use both registers
	movem.l	d3,-(a7)
	moveq.l	#-1,d3
	asl.l	d2,d3		; bit mask
	asl.l	d2,d0
	rol.l	d2,d1
	move.l	d1,d2
	and.l	d3,d1		; make low bits = 0
	not.l	d3
	and.l	d3,d2		; isolate carry bits
	add.l	d2,d0		; add carry bits
	movem.l	(a7)+,d3
	bra.s	op_lshl_out
	; shift more than 32 bits: single-register case
op_lshl_32:
	move.l	d1,d0
	clr.l	d1
	andi.w	#$001f,d2
	asl.l	d2,d0
op_lshl_out:
	move.l	(a7)+,a1
	addq.l	#4,a7
	move.l	d0,(a7)
	move.l	d1,4(a7)
	jmp	(a1)

;; jvm-opcode lushr
	move.l	8(a7),d0
	move.l	12(a7),d1
	move.l	4(a7),d2
	beq.s	op_lushr_out
	btst.l	#5,d2		; shift 32 or more?
	bne.s	op_lushr_32
	; shift by less than 32 bits: use both registers
	movem.l	d3,-(a7)
	moveq.l	#-1,d3
	lsr.l	d2,d3		; bit mask
	ror.l	d2,d0
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	d3,d0		; make high bits = 0
	not.l	d3
	and.l	d3,d2		; isolate carry bits
	add.l	d2,d1		; add carry bits
	movem.l	(a7)+,d3
	bra.s	op_lushr_out
	; shift more than 32 bits: single-register case
op_lushr_32:
	move.l	d0,d1
	clr.l	d0
	andi.w	#$001f,d2
	lsr.l	d2,d1
op_lushr_out:
	move.l	(a7)+,a1
	addq.l	#4,a7
	move.l	d0,(a7)
	move.l	d1,4(a7)
	jmp	(a1)

;; jvm-opcode lshr
	movem.l	d3,-(a7)
	move.l	12(a7),d0
	move.l	16(a7),d1
	move.l	8(a7),d2
	beq.s	op_lshr_out
	btst.l	#5,d2		; shift 32 or more?
	bne.s	op_lshr_32
	; shift by less than 32 bits: use both registers
	moveq.l	#-1,d3
	lsr.l	d2,d3		; bit mask
	ror.l	d2,d0
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	d3,d0		; make high bits = 0
	not.l	d3
	and.l	d3,d2		; isolate carry bits
	add.l	d2,d1		; add carry bits
	tst.w	12(a7)		; check operand sign
	bpl.s	op_lshr_out
	add.l	d3,d0		; add sign-extend bits
	bra.s	op_lshr_out
	; shift more than 32 bits: single-register case
op_lshr_32:
	move.l	d0,d1
	smi.b	d0
	ext.w	d0
	ext.l	d0
	andi.w	#$001f,d2
	asr.l	d2,d1
op_lshr_out:
	movem.l	(a7)+,d3
	move.l	(a7)+,a1
	addq.l	#4,a7
	move.l	d0,(a7)
	move.l	d1,4(a7)
	jmp	(a1)

;; jvm-opcode lmul
	movem.l	d3-d7,-(a7)
	move.l	24(a7),d4	; d4 = factor1H = d.c
	move.l	28(a7),d5	; d5 = factor1L = b.a
	move.l	32(a7),d6	; d6 = factor2H = D.C
	move.l	36(a7),d7	; d7 = factor2L = B.A
	;
	move.w	d4,d0
	mulu.w	d7,d0		; (1) d0 = c * A (in 32-63)
	;
	move.w	d5,d1
	mulu.w	d7,d1		; (2) d1 = a * A (in 00-31)
	;
	swap.w	d5		; d5 = inverse = a.b
	move.w	d5,d2
	mulu.w	d7,d2		; (3) d2 = b * A
	swap.w	d2
	clr.l	d3
	move.w	d2,d3
	clr.w	d2
	add.l	d2,d1
	addx.l	d3,d0		; added to d0/d1 (16-47)
	;
	swap.w	d7		; d7 = inverse = A.B
	move.w	d7,d2
	mulu.w	d5,d2		; (4) d2 = b * B
	add.l	d2,d0		; added to d0/d1 (32-63)
	;
	swap.w	d5		; d5 = normal = b.a
	move.w	d5,d2
	mulu.w	d7,d2		; (5) d2 = a * B
	swap.w	d2
	clr.l	d3
	move.w	d2,d3
	clr.w	d2
	add.l	d2,d1
	addx.l	d3,d0		; added to d0/d1 (16-47)
	;
	move.w	d4,d2
	mulu.w	d7,d2		; (6) d2 = c * B
	swap.w	d2
	clr.w	d2
	add.l	d2,d0		; added to d0/d1 (48-63)
	;
	move.w	d5,d2
	mulu.w	d6,d2		; (7) d2 = a * C
	add.l	d2,d0		; added to d0/d1 (32-63)
	;
	swap.w	d4		; d4 = inverse = c.d
	swap.w	d7		; d7 = normal = B.A
	move.w	d4,d2
	mulu.w	d7,d2		; (8) d2 = d * A
	swap.w	d2
	clr.w	d2
	add.l	d2,d0		; added to d0/d1 (48-63)
	;
	swap.w	d5		; d5 = invers = a.b
	move.w	d5,d2
	mulu.w	d6,d2		; (9) d2 = b * C
	swap.w	d2
	clr.w	d2
	add.l	d2,d0		; added to d0/d1 (48-63)
	;
	swap.w	d5		; d5 = normal = b.a
	swap.w	d6		; d6 = invers = C.D
	move.w	d5,d2
	mulu.w	d6,d2		; (10) d2 = a * D
	swap.w	d2
	clr.w	d2
	add.l	d2,d0		; added to d0/d1 (48-63)
	;
	movem.l	(a7)+,d3-d7
	move.l	(a7)+,a1
	addq	#8,a7		; one long popped from stack
     	move.l	d0,(a7)
	move.l	d1,4(a7)
     	jmp	(a1)

;; jvm-opcode ldiv
;; uses-class java/lang/ArithmeticException as class_AE
;; uses-instance java/lang/ArithmeticException
;; uses-method java/lang/ArithmeticException.<init>()V as method_AE_init
	movem.l	d3-d7,-(a7)
	move.l	24(a7),d4
	move.l	28(a7),d5	; d4,d5 = denominator
	move.l	32(a7),d6
	move.l	36(a7),d7	; d6,d7 = numerator
	tst.l	d4
	bne.s	op_ldiv_nz
	tst.l	d5
	bne.s	op_ldiv_nz
	;
	; division by zero: throw exception
	;
	movem.l	(a7)+,d3-d7	; now (a7) is exception-initiating PC
	move.l	#class_AE,d0
	bsr	op_new
	bsr.far	method_AE_init
	move.l	(a7)+,a0	; exception instance
	move.l	(a7)+,a1	; initiator address
	bra	do_athrow
op_ldiv_nz:
	tst.l	d4
	bpl.s	op_ldiv_a
	neg.l	d5
	negx.l	d4
op_ldiv_a:			; d4,d5 = abs(den)
	tst.l	d6
	bpl.s	op_ldiv_b
	neg.l	d7
	negx.l	d6
op_ldiv_b:			; d6,d7 = abs(num)
	tst.l	d4
	bne	op_ldiv_64
	;
	; divide 64 by 32: compute high lword
	; numerator = #0,d3 . d6,d7 ('.' is decimal point)
	; denominator = #0,d5
	; result bit mask = d2
	; result = d0,d1 (first filling d0)
	clr.l	d3
	clr.l	d0
	clr.l	d1
	moveq.l	#1,d2
op_ldiv_c:
	ror.l	#1,d2
	move.w	#0,ccr
	roxl.l	#1,d7
	roxl.l	#1,d6
	roxl.l	#1,d3
	cmp.l	d5,d3
	bcs.s	op_ldiv_d
	; found a 1 bit for the result
	sub.l	d5,d3
	add.l	d2,d0
op_ldiv_d:
	cmp.l	#1,d2
	bne.s	op_ldiv_c
	;
	; continue to divide 64 by 32: compute low lword
	; numerator = C-flag,d3 . d6 ('.' is decimal point)
	; denominator = #0,d5
	; result bit mask = d2
	; result = d0,d1 (now filling d1)
	clr.l	d7
op_ldiv_e:
	ror.l	#1,d2
	move.w	#0,ccr
	roxl.l	#1,d6
	roxl.l	#1,d3
	bcs.s	op_ldiv_e1	; C-flag set: number > denominator
	cmp.l	d5,d3
	bcs.s	op_ldiv_f
op_ldiv_e1:
	; found a 1 bit for the result
	sub.l	d5,d3
	add.l	d2,d1
op_ldiv_f:
	cmp.l	#1,d2
	bne.s	op_ldiv_e
	bra	op_ldiv_out
	;
	; divide 64 by 64: result only has low lword
	; numerator = d3,d6 . d7 ('.' is decimal point)
	; denominator = d4,d5
	; result bit mask = d2
	; result = #0,d1
op_ldiv_64:
	clr.l	d3
	clr.l	d0
	clr.l	d1
	moveq.l	#1,d2
op_ldiv_j:
	ror.l	#1,d2
	move.w	#0,ccr
	roxl.l	#1,d7
	roxl.l	#1,d6
	roxl.l	#1,d3
	cmp.l	d4,d3
	bcs.s	op_ldiv_k	; definitely too small
	bne.s	op_ldiv_l	; definitely bigger
	cmp.l	d5,d6		; high lwords equal: compare low lwords
	bcs.s	op_ldiv_k
op_ldiv_l:
	; found a 1 bit for the result
	sub.l	d5,d6
	subx.l	d4,d3
	add.l	d2,d1
op_ldiv_k:
	cmp.l	#1,d2
	bne.s	op_ldiv_j
	;
op_ldiv_out:
	; give the correct sign to the result
	tst.w	24(a7)
	bpl.s	op_ldiv_g
	tst.w	32(a7)
	bmi.s	op_ldiv_h
	bra.s	op_ldiv_i
op_ldiv_g:
	tst.w	32(a7)
	bpl.s	op_ldiv_h
op_ldiv_i:
	neg.l	d1
	negx.l	d0
op_ldiv_h:			; result sign O.K. now
	move.l	d0,32(a7)
	move.l	d1,36(a7)
	movem.l	(a7)+,d3-d7
	move.l	(a7)+,a1
	addq.l	#8,a7
	jmp	(a1)

;; jvm-opcode lrem
;; uses-class java/lang/ArithmeticException as class_AE
;; uses-instance java/lang/ArithmeticException
;; uses-method java/lang/ArithmeticException.<init>()V as method_AE_init
	movem.l	d3-d7,-(a7)
	move.l	24(a7),d4
	move.l	28(a7),d5	; d4,d5 = denominator
	move.l	32(a7),d6
	move.l	36(a7),d7	; d6,d7 = numerator
	tst.l	d4
	bne.s	op_lrem_nz
	tst.l	d5
	bne.s	op_lrem_nz
	;
	; division by zero: throw exception
	;
	movem.l	(a7)+,d3-d7	; now (a7) is exception-initiating PC
	move.l	#class_AE,d0
	bsr	op_new
	bsr.far	method_AE_init
	move.l	(a7)+,a0	; exception instance
	move.l	(a7)+,a1	; initiator address
	bra	do_athrow
op_lrem_nz:
	tst.l	d4
	bpl.s	op_lrem_a
	neg.l	d5
	negx.l	d4
op_lrem_a:			; d4,d5 = abs(den)
	tst.l	d6
	bpl.s	op_lrem_b
	neg.l	d7
	negx.l	d6
op_lrem_b:			; d6,d7 = abs(num)
	tst.l	d4
	bne	op_lrem_64
	;
	; divide 64 by 32: compute high lword
	; numerator = #0,d3 . d6,d7 ('.' is decimal point)
	; denominator = #0,d5
	; result bit mask = d2
	clr.l	d3
	clr.l	d0
	clr.l	d1
	moveq.l	#1,d2
op_lrem_c:
	ror.l	#1,d2
	move.w	#0,ccr
	roxl.l	#1,d7
	roxl.l	#1,d6
	roxl.l	#1,d3
	cmp.l	d5,d3
	bcs.s	op_lrem_d
	; found a 1 bit for the result
	sub.l	d5,d3
op_lrem_d:
	cmp.l	#1,d2
	bne.s	op_lrem_c
	;
	; continue to divide 64 by 32: compute low lword
	; numerator = C-flag,d3 . d6 ('.' is decimal point)
	; denominator = #0,d5
	; result bit mask = d2
	clr.l	d7
op_lrem_e:
	ror.l	#1,d2
	move.w	#0,ccr
	roxl.l	#1,d6
	roxl.l	#1,d3
	bcs.s	op_lrem_e1
	cmp.l	d5,d3
	bcs.s	op_lrem_f
op_lrem_e1:
	; found a 1 bit for the result
	sub.l	d5,d3
op_lrem_f:
	cmp.l	#1,d2
	bne.s	op_lrem_e
	clr.l	d0
	move.l	d3,d1
	bra	op_lrem_out
	;
	; divide 64 by 64: result only has low lword
	; numerator = d3,d6 . d7 ('.' is decimal point)
	; denominator = d4,d5
	; result bit mask = d2
op_lrem_64:
	clr.l	d3
	clr.l	d0
	clr.l	d1
	moveq.l	#1,d2
op_lrem_j:
	ror.l	#1,d2
	move.w	#0,ccr
	roxl.l	#1,d7
	roxl.l	#1,d6
	roxl.l	#1,d3
	cmp.l	d4,d3
	bcs.s	op_lrem_k	; definitely too small
	bne.s	op_lrem_l	; definitely bigger
	cmp.l	d5,d6		; high lwords equal: compare low lwords
	bcs.s	op_lrem_k
op_lrem_l:
	; found a 1 bit for the result
	sub.l	d5,d6
	subx.l	d4,d3
	add.l	d2,d0
op_lrem_k:
	cmp.l	#1,d2
	bne.s	op_lrem_j
	move.l	d3,d0
	move.l	d6,d1
	;
op_lrem_out:
	; give the correct sign to the result
	tst.w	32(a7)
	bpl.s	op_lrem_h
	neg.l	d1
	negx.l	d0
op_lrem_h:			; result sign O.K. now
	move.l	d0,32(a7)
	move.l	d1,36(a7)
	movem.l	(a7)+,d3-d7
	move.l	(a7)+,a1
	addq.l	#8,a7
	jmp	(a1)

;; jvm-opcode monitorenter
	rts

;; jvm-opcode monitorexit
	rts

;; jvm-opcode athrow
        move.l  (a7)+,a1	; initiating address
        move.l  (a7)+,a0	; exception object
	cmp.w	#0,a0
	bne	do_athrow
	move.l	a1,-(a7)
	bra	throw_NullPointerException
	

; --- (geo) patch begin ---

	
;; jvm-opcode d2l
	moveq.l	#sysFloatEm_d_dtoll,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)	; pointer to tos
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	lea		12(a7),a7
	rts

;; jvm-opcode f2l
	moveq.l	#sysFloatEm_f_ftoll,d2
	move.l	(a7),-(a7)	; dup return
	move.l	8(a7),-(a7)
	pea		8(a7)		; long on stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	lea		8(a7),a7
	rts

;; jvm-opcode f2d
	moveq.l	#sysFloatEm_f_ftod,d2
	move.l	(a7),-(a7)	; dup return
	move.l	8(a7),-(a7)
	pea		8(a7)		; long on stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	lea		8(a7),a7
	rts

;; jvm-opcode f2i
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_ftoi,d2
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fneg
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_neg,d2
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fcmpg
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_cmp,d2
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7
	move.l  d0,d1	
	cmp.l	#flpEqual,d1
	beq	op_fcmpg_done
	move.l  #-1,d0
	cmp.l   #flpLess,d1
	beq	op_fcmpg_done
	move.l  #1,d0
op_fcmpg_done:	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fcmpl
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_cmp,d2
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7
	move.l  d0,d1	
	cmp.l	#flpEqual,d1
	beq	op_fcmpl_done
	move.l  #1,d0
	cmp.l   #flpGreater,d1
	beq	op_fcmpl_done
	move.l  #-1,d0
op_fcmpl_done:	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fadd
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_add,d2
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fsub
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_sub,d2
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fmul
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_mul,d2
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode fdiv
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_f_div,d2
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode d2f
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_d_dtof,d2
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode d2i
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_d_dtoi,d2
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode dneg
	moveq.l	#sysFloatEm_d_neg,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)	; pointer to tos
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	lea		12(a7),a7
	rts

;; jvm-opcode dcmpg
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_d_cmp,d2
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	move.l	20(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	lea.l	 12(a7),a7
	move.l  d0,d1	
	cmp.l	#flpEqual,d1
	beq	op_dcmpg_done
	move.l  #-1,d0
	cmp.l   #flpLess,d1
	beq	op_dcmpg_done
	move.l  #1,d0
op_dcmpg_done:	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode dcmpl
	move.l	a6,-(a7)
	move.l  a7,a6
	moveq.l	#sysFloatEm_d_cmp,d2
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	move.l	20(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	lea.l	 12(a7),a7
	move.l  d0,d1	
	cmp.l	#flpEqual,d1
	beq	op_dcmpl_done
	move.l  #1,d0
	cmp.l   #flpGreater,d1
	beq	op_dcmpl_done
	move.l  #-1,d0
op_dcmpl_done:	
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode dadd
	moveq.l	#sysFloatEm_d_add,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	lea		12(a1),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)		; pointer to next-on-stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l	20(a7),a1
	lea		32(a7),a7
	jmp		(a1)

;; jvm-opcode dsub
	moveq.l	#sysFloatEm_d_sub,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	lea		12(a1),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)		; pointer to next-on-stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l	20(a7),a1
	lea		32(a7),a7
	jmp		(a1)

;; jvm-opcode dmul
	moveq.l	#sysFloatEm_d_mul,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	lea		12(a1),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)		; pointer to next-on-stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l	20(a7),a1
	lea		32(a7),a7
	jmp		(a1)


;; jvm-opcode ddiv
	moveq.l	#sysFloatEm_d_div,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	lea		12(a1),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)		; pointer to next-on-stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l	20(a7),a1
	lea		32(a7),a7
	jmp		(a1)

;; jvm-opcode frem
	link	a6,#0
	movem.l	d3-d4,-(a7)
	move.l	8(a6),d1	; divisor
	bclr.l	#31,d1		; abs(divisor)
	move.l	12(a6),d0	; dividend
	bclr.l	#31,d0		; abs(dividend)
	;; 
	;; NaN and Infinity cases
	cmp.l	#$7f800000,d0	; dividend = NaN or Infinity -> return NaN
	bcc.s	frem_NaN
	cmp.l	#$7f800000,d1	; NaN or Infinity?
	beq.s	frem_dividend	; divisor = infinity -> return dividend
	bcc.s	frem_NaN	; divisor = NaN -> return NaN
	;;
	;; divide by zero case
	tst.l	d1		; divide by zero?
	beq.s	frem_NaN
	;;
	;; |dividend| < |divisor| -> return dividend
	cmp.l	d1,d0		; int cmp is equivalent here
	bcs.s	frem_dividend
	;;
	;; |dividend| > 2**24 * |divisor| -> return 0
	move.l	d1,d2
	add.l	#$0c000000,d2	; 2**24 * |divisor|
	cmp.l	d2,d0
	bhi.s	frem_zero
	;;
	;; normal case -> compute
	moveq.l	#23,d4
	move.l	d0,d2
	lsr.l	d4,d2		; "lsr.l #23,d2"
	move.l	d1,d3
	lsr.l	d4,d3		; "lsr.l #23,d3"
	sub.l	d3,d2		; d2 = exp(dividend) - exp(divisor)
	and.l	#$007fffff,d0
	bset.l	#23,d0
	and.l	#$007fffff,d1
	bset.l	#23,d1
	;; 
	;; for (i=0; i<=delta_exp; i++) {
	;;     if (i>0) d0=d0<<1;
	;;     if (d0>=d1) d0=d0-d1;
	;; }
	bra.s	frem_loopEnter
frem_loop
	lsl.l	#1,d0
frem_loopEnter
	cmp.l	d1,d0
	blo.s	frem_nosub
	sub.l	d1,d0
	beq.s	frem_zero
frem_nosub
	dbra	d2,frem_loop
	;;
	;; for (exp=exp2; d0<0x00800000; exp--,d0=d0<<1);
	bra.s	frem_nloopEnd
frem_nloop
	subq.l	#1,d3
	ble.s	frem_zero	; underflow -> return zero
	lsl.l	#1,d0
frem_nloopEnd
	cmp.l	#$00800000,d0
	blo.s	frem_nloop
	;;
	;; return signBit + exp<<23 + d0&0x7fffff;
	and.l	#$007fffff,d0
	lsl.l	d4,d3		; "lsl.l #23,d3"
	add.l	d3,d0
	btst.b	#7,12(a6)	; sign(dividend) = ?
	beq.s	frem_out
	bset.l	#31,d0
	bra.s	frem_out
frem_NaN
	move.l	#$7fc00000,d0
	bra.s	frem_out
frem_dividend
	move.l	12(a6),d0
	bra.s	frem_out
frem_zero
	clr.l	d0
frem_out
	movem.l	(a7)+,d3-d4
	unlk	a6
	move.l  (a7)+,a1
	addq.l	#4,a7
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode drem
	link	a6,#0
	movem.l	d3-d6,-(a7)
	move.l	8(a6),d2
	move.l	12(a6),d3
	bclr.l	#31,d2		; d2/d3 = abs(divisor)
	move.l	16(a6),d0
	move.l	20(a6),d1
	bclr.l	#31,d0		; d0/d1 = abs(dividend)
	;; 
	;; NaN and Infinity cases
	cmp.l	#$7ff00000,d0
	bcc	drem_NaN	; dividend = NaN or Infinity -> return NaN
	cmp.l	#$7ff00000,d2
	beq	drem_dividend	; divisor = Infinity -> return dividend
	bcc	drem_NaN
	;; 
	;; divide by zero case
	tst.l	d2
	bne.s	drem_noDivZero
	tst.l	d3
	beq	drem_NaN
drem_noDivZero
	;; 
	;; |dividend| < |divisor| -> return dividend
	cmp.l	d2,d0
	blo	drem_dividend
	bne.s	drem_noSmallDividend
	cmp.l	d3,d1
	blo	drem_dividend
drem_noSmallDividend
	;; 
	;; |dividend| > 2**53 * |divisor| -> return 0
	move.l	d2,d4
	add.l	#$03500000,d4
	cmp.l	d4,d0
	bhi.s	drem_zero
	blo.s	drem_noLargeDividend
	cmp.l	d3,d1
	bhi.s	drem_zero
drem_noLargeDividend
	;;
	;; delta_exponent
	moveq.l	#20,d6
	move.l	d0,d4
	lsr.l	d6,d4		; d4 = exp(dividend)
	move.l	d2,d5
	lsr.l	d6,d5		; d5 = exp(divisor)
	sub.l	d5,d4		; d4 = delta_exponent
	;;
	;; d0/d1 = mantissa(dividend)
	;; d2/d3 = mantissa(divisor)
	and.l	#$000fffff,d0
	bset.l	#20,d0
	and.l	#$000fffff,d2
	bset.l	#20,d2
	;; 
	;; for (i=0; i<=delta_exp; i++) {
	;;     if (i > 0) d0/d1 = d0/d1 << 1; 
	;;     d0/d1 = d0/d1 - d2/d3;
	;;     if (d0/d1 < 0) d0/d1 = d0/d1 + d2/d3;
	;; }
	bra.s	drem_loopEnter
drem_loop
	lsl.l	#1,d1
	roxl.l	#1,d0
drem_loopEnter
	sub.l	d3,d1
	subx.l	d2,d0
	bhi.s	drem_loopNoAdd
	beq.s	drem_zero
	add.l	d3,d1
	addx.l	d2,d0
drem_loopNoAdd
	dbra	d4,drem_loop
	;;
	;; for (exp = exp2; d0 < 0x00100000; ) {
	;;     exp--;
	;;     d0/d1 = d0/d1 << 1;
	;; }
	bra.s	drem_nloopEnd
drem_nloop
	subq.l	#1,d5
	ble.s	drem_zero
	lsl.l	#1,d1
	roxl.l	#1,d0
drem_nloopEnd
	cmp.l	#$00100000,d0
	blo.s	drem_nloop
	;;
	;; return (signBit + exp<<20 + d0&0x000fffff)/d1
	and.l	#$000fffff,d0
	lsl.l	d6,d5
	add.l	d5,d0
	btst.b	#7,16(a6)
	beq.s	drem_out
	bset.l	#31,d0
	bra.s	drem_out
drem_NaN
	move.l	#$7ff80000,d0
	clr.l	d1
	bra.s	drem_out
drem_dividend
	move.l	16(a6),d0
	move.l	20(a6),d1
	bra.s	drem_out
drem_zero
	clr.l	d0
	clr.l	d1
drem_out
	movem.l	(a7)+,d3-d6
	unlk	a6
	move.l	(a7)+,a1
	addq.l	#8,a7
	move.l	d0,(a7)
	move.l	d1,4(a7)
	jmp	(a1)

;; jvm-opcode l2f
	move.l	a6,-(a7)
	move.l  a7,a6
	move.l	#sysFloatEm_f_lltof,d2
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	addq.l  #4,a7
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode l2d
	move.l	#sysFloatEm_d_lltod,d2
	lea		8(a7),a1
	move.l	(a1),-(a7)
	move.l	-(a1),-(a7)
	move.l	a1,-(a7)	; pointer to tos
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	lea		12(a7),a7
	rts

;; jvm-opcode i2f
	move.l	a6,-(a7)
	move.l  a7,a6
	move.l	#sysFloatEm_f_itof,d2
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	move.l  a6,a7
	move.l  (a7)+,a6
	move.l  (a7)+,a1
	move.l  d0,(a7)
	jmp	(a1)

;; jvm-opcode i2d
	move.l	#sysFloatEm_d_itod,d2
	move.l	(a7),-(a7)	; dup return
	move.l	8(a7),-(a7)
	pea		8(a7)		; long on stack
	trap	#15
	dc.w	sysTrapFlpEmDispatch
	lea		8(a7),a7
	rts

; --- (geo) patch end ---

