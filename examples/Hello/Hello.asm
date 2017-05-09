	appl	"Hello World",'JShw'
JumpAppID	equ	'JShw'
	include	"jump.inc"
	include	"startup.inc"
	
kidrTVER	equ	1
breakpoint	equ	$4afc
struct ClassInfo
	ClassClass.w		; ObjectHeader_ClassIndex
	SuperClass.w
	ObjectSizePlusHeader.w
	GCFlags.b
	Flags.b
	DefaultCtor.w       ; default constructor *.<init>()V
	Name.w
	Vtable.l
	AastoreCheck.8		; aastore validity check routine
	Itable.b		; placeholder for var-length Itable
endstruct
ClassInfo_basesize	equ	ClassInfo.Itable
ClassInfo_array		equ	$0001
ClassInfo_arrayofobjects	equ	$0002
ClassInfo_primitive	equ	$0004
ClassInfo_interface	equ	$0008
ClassInfo_finalize  equ $0080
ClassInfo_arrayBit	equ	0
ClassInfo_aooBit	equ	1
ClassInfo_primitiveBit	equ	2
ClassInfo_interfaceBit  equ	3
ClassInfo_finalizeBit   equ 7
ObjectHeader_ChunkSize	equ	-4
ObjectHeader_sizeof		equ	0	; included in requested size
ObjectHeader_extra		equ	4	; hidden overhead
ObjectHeader_ClassIndex	equ	-2
ClassHeader_sizeof		equ	2
struct Array
	length.w
	elsize.w
	data.l
endstruct
Array_sizeof	equ	8
struct ExceptionTableHeader
	method_offset.l
	local_space.w
	table_length.w
endstruct
struct ExceptionTableEntry
	start_pc_offset.w
	end_pc_offset.w
	handler_pc_offset.w
	catch_type_index.w
endstruct
	
F_EXCESS	equ	126
F_SIGNBIT	equ	$80000000
F_HIDDEN	equ	$00800000
F_MANT		equ	$007fffff
F_CONST_1	equ	$3f800000
F_CONST_2	equ	$40000000
D_CONST_1L	equ	$00000000
D_CONST_1H	equ	$3ff00000
flpVersion	equ	$02008000
flpToNearest	equ	0	; used by _fp_round
flpTowardZero	equ	1
flpUpward	equ	3
flpDownward	equ	2
flpModeMask	equ	$00000030
flpModeShift	equ	4
flpInvalid	equ	$00008000	; used by _fp_get_fpscr, _fp_set_fpscr
flpOverflow	equ	$00004000
flpUnderflow	equ	$00002000
flpDivByZero	equ	$00001000
flpInexact	equ	$00000800
flpEqual	equ	0	; ret by _d_cmp, _d_cmpe, _f_cmp, _f_cmpe
flpLess		equ	1
flpGreater	equ	2
flpUnordered	equ	3
struct FlpFloat
	value.l
endstruct
	
struct FlpDouble
	high.l
	low.l
endstruct
	
flpErrorClass		equ	$0680              ; new fp mgr error
flpErrOutOfRange	equ	flpErrorClass | 1
sysFloatBase10Info	equ	0	; sysFloatSelector
sysFloatFToA		equ	1
sysFloatAToF		equ	2
sysFloatCorrectedAdd	equ	3
sysFloatCorrectedSub	equ	4
sysFloatVersion		equ	5
	
sysFloatEm_fp_round	equ	0	; sysFloatEmSelector
sysFloatEm_fp_get_fpscr	equ	1
sysFloatEm_fp_set_fpscr	equ	2
sysFloatEm_f_utof	equ	3
sysFloatEm_f_itof	equ	4
sysFloatEm_f_ulltof	equ	5
sysFloatEm_f_lltof	equ	6
sysFloatEm_d_utod	equ	7
sysFloatEm_d_itod	equ	8
sysFloatEm_d_ulltod	equ	9
sysFloatEm_d_lltod	equ	10
sysFloatEm_f_ftod	equ	11
sysFloatEm_d_dtof	equ	12
sysFloatEm_f_ftoq	equ	13
sysFloatEm_f_qtof	equ	14
sysFloatEm_d_dtoq	equ	15
sysFloatEm_d_qtod	equ	16
sysFloatEm_f_ftou	equ	17
sysFloatEm_f_ftoi	equ	18
sysFloatEm_f_ftoull	equ	19
sysFloatEm_f_ftoll	equ	20
sysFloatEm_d_dtou	equ	21
sysFloatEm_d_dtoi	equ	22
sysFloatEm_d_dtoull	equ	23
sysFloatEm_d_dtoll	equ	24
sysFloatEm_f_cmp	equ	25
sysFloatEm_f_cmpe	equ	26
sysFloatEm_f_feq	equ	27
sysFloatEm_f_fne	equ	28
sysFloatEm_f_flt	equ	29
sysFloatEm_f_fle	equ	30
sysFloatEm_f_fgt	equ	31
sysFloatEm_f_fge	equ	32
sysFloatEm_f_fun	equ	33
sysFloatEm_f_for	equ	34
sysFloatEm_d_cmp	equ	35
sysFloatEm_d_cmpe	equ	36
sysFloatEm_d_feq	equ	37
sysFloatEm_d_fne	equ	38
sysFloatEm_d_flt	equ	39
sysFloatEm_d_fle	equ	40
sysFloatEm_d_fgt	equ	41
sysFloatEm_d_fge	equ	42
sysFloatEm_d_fun	equ	43
sysFloatEm_d_for	equ	44
sysFloatEm_f_neg	equ	45
sysFloatEm_f_add	equ	46
sysFloatEm_f_mul	equ	47
sysFloatEm_f_sub	equ	48
sysFloatEm_f_div	equ	49
sysFloatEm_d_neg	equ	50
sysFloatEm_d_add	equ	51
sysFloatEm_d_mul	equ	52
sysFloatEm_d_sub	equ	53
sysFloatEm_d_div	equ	54
	
sysTrapFlpDispatch	equ	41733	; flp traps
sysTrapFlpEmDispatch	equ	41734
	code
op_imul:
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
op_idiv:
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
op_idiv_32:
	movem.l	d3-d5,-(a7)
	clr.l	d4
	move.l	#$8000,d5	; add-value for quotient (first iteration)
	move.l	d1,d3
	clr.w	d3
	swap.w	d3		; d3 = high(num)
op_idiv_loop:
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
	move.l	#29,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0	; exception instance
	move.l	(a7)+,a1	; initiator address
	bra	do_athrow
op_newarray:
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
op_athrow:
	move.l  (a7)+,a1	; initiating address
	move.l  (a7)+,a0	; exception object
	cmp.w	#0,a0
	bne	do_athrow
	move.l	a1,-(a7)
	bra	throw_NullPointerException
	
HeapDbType	equ	'Ohep'
blockNext		equ	-4
blockLeft		equ	-8
blockRight		equ	-12
blockBitmap		equ	-16
blockTop		equ	blockBitmap
blockHeaderSize	equ	-blockBitmap
blockDbExtra	equ	8	; extra	size for database-allocated	blocks
blockDbUniqueID	equ	-8	; only for database-allocated blocks
blockDbHandle	equ	-4	; only for database-allocated blocks
blockMaxSize	equ	$FB00-ObjectHeader_extra
blockMinSize	equ	16384-ObjectHeader_extra
proxyBlockHeaderSize	equ	10
proxyMinBlockSize		equ	2000
chunkMarkEmpty			equ	3
chunkMarkedBit			equ	0
chunkPendingBit			equ	1
chunkHasFinalizerBit	equ	2
chunkSizeSmall	equ	192
	code
garbage:
	bsr		garbageCollect
	move.l	a2,-(a7)
	bsr		recombine
	bsr		freeBlocksToOS
	move.l	(a7)+,a2
	rts
garbageCollect
	movem.l	d0-d7/a0-a4,-(a7)
	clr.b	heapNeedsScan(a5)
	move.l	StackLimit(a5),a0
	lea		32(a0),a0
	move.l	a0,heapStackMargin(a5)
	cmp.l	a0,a7
	bcs		garbageCollect_out
	move.l	a7,a0
	moveq.l	#2,d7
	move.l	StackEnd(a5),d6
	sub.l	a0,d6
	bsr		markInterior
	lea.l	StaticObjects(a5),a0
	moveq.l	#4,d7
	move.w	#StaticObjectCount*4,d6
	bsr		markInterior
	bra.s	garbageCollect_scan_entry
garbageCollect_scan_loop
	clr.b	heapNeedsScan(a5)
	move.l	heapBlocks(a5),a1
	bra.s	garbageCollect_scan_bentry
garbageCollect_scan_bloop
	move.l	a1,a0
	moveq.l	#0,d0
	bra.s	garbageCollect_scan_centry
garbageCollect_scan_cloop
	move.w	(a0),d0
	btst	#chunkPendingBit,d0
	beq.s	garbageCollect_scan_cdone
	btst	#chunkMarkedBit,d0
	bne.s	garbageCollect_scan_cdone
	move.l	a1,-(a7)
	move.l	a0,d0
	addq.l	#ObjectHeader_extra,d0
	bsr		markObject
	move.l	(a7)+,a1
	moveq.l	#0,d0
	move.w	(a0),d0
garbageCollect_scan_cdone
	and.w	#$FFF8,d0
	add.l	d0,a0					; to is	always 0
garbageCollect_scan_centry
	cmp.l	blockTop(a1),a0		; reached top of block?
	bcs.s	garbageCollect_scan_cloop
	move.l	blockNext(a1),a1	; next block
garbageCollect_scan_bentry
	cmp.w	#0,a1
	bne.s	garbageCollect_scan_bloop
garbageCollect_scan_entry
	tst.b	heapNeedsScan(a5)
	bne.s	garbageCollect_scan_loop
garbageCollect_sweep
	move.l	heapBlocks(a5),a1	; first	block
	bra.s	garbageCollect_bentry
garbageCollect_bloop
	move.l	blockTop(a1),d4
	move.l	a1,a0
	moveq.l	#0,d0
	bra.s	garbageCollect_centry
garbageCollect_cloop
	move.w	(a0),d0
	btst	#chunkPendingBit,d0		; can only be empty
	bne.s	garbageCollect_cdone
	bclr	#chunkMarkedBit,1(a0)	; clear	mark as	we go
	bne.s	garbageCollect_cdone
	lea.l	ObjectHeader_extra(a0),a0
	bsr		addChunkToFreeList
	lea.l	-ObjectHeader_extra(a0),a0
	move.w	(a0),d0					; recover size
garbageCollect_cdone
	and.w	#$FFF8,d0
	add.l	d0,a0					; to is	always 0
garbageCollect_centry
	cmp.l	d4,a0		; reached top of block?
	bcs.s	garbageCollect_cloop
	move.l	blockNext(a1),a1	; next block
garbageCollect_bentry
	cmp.w	#0,a1
	bne.s	garbageCollect_bloop
garbageCollect_out
	systrap	TimGetTicks()
	move.w	d0,lastGCTime(a5)
	movem.l	(a7)+,d0-d7/a0-a4
	rts
recombine
	move.l	a3,-(a7)
	lea.l	freeList8(a5),a0
	moveq.l	#9,d0
recombine_floop
	clr.l	(a0)+	; clear	all	free lists
	dbra	d0,recombine_floop
	move.l	heapBlocks(a5),a1
	bra.s	recombine_bentry
recombine_bloop
	move.l	a1,a0
	move.l	blockTop(a1),a2
	moveq.l	#0,d0
	bra.s	recombine_centry
recombine_cloop
	move.w	(a0),d0
	btst	#chunkMarkedBit,d0
	bne.s	recombine_awhile
	bclr	#chunkHasFinalizerBit,d0
	add.l	d0,a0			; top is always	0
	cmp.l	a2,a0			; reached top of block?
	bcs.s	recombine_cloop
	bra.s	recombine_bnext
recombine_awhile
	move.l	a0,a3
recombine_aloop
	lea		-3(a3,d0.l),a3	; next block
	cmp.l	a2,a3			; top
	bcc.s	recombine_aloop_end
	move.w	(a3),d0
	btst	#chunkMarkedBit,d0
	bne.s	recombine_aloop
recombine_aloop_end
	move.l	a3,d0
	sub.l	a0,d0
	lea		ObjectHeader_extra(a0),a0
	bsr		addChunkToFreeList
	lea		-ObjectHeader_extra(a0),a0
	move.l	a3,a0
recombine_centry
	cmp.l	a2,a0		; reached top of block?
	bcs.s	recombine_cloop
recombine_bnext
	move.l	blockNext(a1),a1	; next block
recombine_bentry
	cmp.w	#0,a1
	bne.s	recombine_bloop
	move.l	(a7)+,a3
	rts
	
freeBlocksToOS
	move.w	heapBlockCount(a5),-(a7)	; save to compare later
	lea		heapBlocks(a5),a2
	bra.s	freeBlocksToOS_enter
freeBlocksToOS_cloop
	move.l	(a0),a0
freeBlocksToOS_center
	cmp.l	(a0),a1
	bne.s	freeBlocksToOS_cloop
	move.l	(a1),(a0)
	lea		-ObjectHeader_extra-blockHeaderSize(a1),a0
	systrap	MemPtrFree(a0.l)
	subq.w	#1,heapBlockCount(a5)
	bra.s	freeBlocksToOS_enter
freeBlocksToOS_loop
	lea		blockNext(a1),a2
freeBlocksToOS_enter
	move.l	(a2),a1
	cmp.w	#0,a1
	beq.s	freeBlocksToOS_out
	moveq.l	#0,d0
	move.w	(a1),d0
	lea		-chunkMarkEmpty(a1,d0.l),a0
	cmp.l	blockTop(a1),a0		; first	chunk is block size
	bne.s	freeBlocksToOS_loop
	move.l	blockNext(a1),(a2)
	lea		ObjectHeader_extra(a1),a1
	lea		freeListLarge(a5),a0
	bra.s	freeBlocksToOS_center
freeBlocksToOS_out
	move.w	heapBlockCount(a5),d0
	cmp.w	(a7)+,d0
	beq.s	freeBlocksToOS_rts
	move.l	heapBlocks(a5),a0
	bsr		buildBlockSubtree
	move.l	a1,heapRoot(a5)
	bsr		setHeapMaxMin
freeBlocksToOS_rts
	rts
markInterior
	move.l	a0,-(a7)
	move.w	d7,-(a7)
	move.w	d6,-(a7)
	subq.w	#4,d6	; remove size of pointer
	move.l	heapMaxAddress(a5),d5
	move.l	heapMinAddress(a5),d4
	bra		markObject_enter
	
markObject
	bsr		findBlockFromAddress
	bcc.s	markObject_rts
	move.l	d0,d1
	sub.l	a1,d1
	and.w	#7,d1
	cmp.w	#ObjectHeader_extra,d1
	bne.s 	markObject_rts
	move.l	d0,a2
	sub.w	a1,d0
	lsr.w	#3,d0	; byte per bitmap bit
	move.w	d0,d1
	lsr.w	#3,d1
	move.l	blockBitmap(a1),a1
	btst	d0,0(a1,d1.w)
	beq.s   markObject_rts
	bset.b	#chunkMarkedBit,ObjectHeader_ChunkSize+1(a2)
	bne.s	markObject_rts	; already marked
	bclr.b	#chunkPendingBit,ObjectHeader_ChunkSize+1(a2)
	cmp.l	heapStackMargin(a5),a7
	bcc.s	markObject_stackok
	move.b	#1,heapNeedsScan(a5)
	subq.l	#-ObjectHeader_ChunkSize-1,a2
	bclr.b	#chunkMarkedBit,(a2)
	bset.b	#chunkPendingBit,(a2)
	bra.s	markObject_rts	; already marked
markObject_stackok
	move.l	a0,-(a7)
	move.l	a2,a0
	bsr		getclassinfo_a0
	move.b	ClassInfo.Flags(a0),d0
	btst.l	#ClassInfo_arrayBit,d0
	beq.s	markObject_objarray
	move.l	Array.data(a2),a0
	cmp.w	#0,a0
	beq.s	markObject_out
	bset.b	#chunkMarkedBit,ObjectHeader_ChunkSize+1(a0)
	bra.s	markObject_out
makeObject_popping_out
	move.w	(a7)+,d6
	move.w	(a7)+,d7
markObject_out
	move.l	(a7)+,a0
markObject_rts
	rts
	align	2
markObject_objarray
	btst.l	#ClassInfo_aooBit,d0
	beq.s	markObject_object
	move.l	Array.data(a2),a0
	cmp.w	#0,a0
	beq.s	markObject_out
	bset.b	#chunkMarkedBit,ObjectHeader_ChunkSize+1(a0)
	move.w	d7,-(a7)
	move.w	d6,-(a7)
	moveq.l	#4,d7
	bra.s	markObject_interior
markObject_object
	move.l	a2,a0
	move.w	d7,-(a7)
	move.w	d6,-(a7)
	moveq.l	#2,d7
markObject_interior
	move.w	ObjectHeader_ChunkSize(a0),d6
	and.w	#$FFF8,d6					; remove flag bits
	subq.w	#ObjectHeader_extra+4,d6	; remove size of pointer and header
	move.l	heapMaxAddress(a5),d5
	move.l	heapMinAddress(a5),d4
	bra.s	markObject_enter
markObject_loop
	add.w	d7,a0
	sub.w	d7,d6
markObject_enter
	bcs.s	makeObject_popping_out
	move.l	(a0),d0
	cmp.l	d4,d0
	bcs.s	markObject_loop
	cmp.l	d5,d0
	bcc.s	markObject_loop
	btst	#0,d0
	bne.s	markObject_loop
	bsr		markObject
	bra.s	markObject_loop
	
findBlockFromAddress
	move.l	heapRoot(a5),a1
	bra.s	findBlockFromAddress_while
findBlockFromAddress_loop
	cmp.l	a1,d0
	bcc.s	findBlockFromAddress_right
	move.l	blockLeft(a1),a1
	bra.s	findBlockFromAddress_while
findBlockFromAddress_right
	cmp.l	blockTop(a1),d0
	bcs.s	findBlockFromAddress_out
	move.l	blockRight(a1),a1
findBlockFromAddress_while
	cmp.w	#0,a1
	bne.s	findBlockFromAddress_loop
findBlockFromAddress_out
	rts
allocMem
	bsr.s	allocRawMem
	beq.s	allocMem_rts
	move.l	a0,-(a7)
	moveq.l	#0,d0
	move.w	ObjectHeader_ClassIndex(a0),d0
	suba.l	d0,a0		; address of block
	move.l	blockBitmap(a0),a0
	lsr.w	#3,d0
	move.w	d0,d1		; bitmap bit offset
	lsr.w	#3,d0		; bitmap byte offset
	bset	d1,0(a0,d0.w)
	move.l	(a7)+,a0
	addq.w	#1,d1		; clear	Z bit
allocMem_rts
	rts
allocRawMem:
	move.l	a2,-(a7)
	move.l	d0,-(a7)
	bsr		heapAlloc
	bne.s	allocRawMem_out
	systrap	TimGetTicks()
	sub.w	lastGCTime(a5),d0
	add.w	d0,lastGCTime(a5)
	cmp.w	#100,d0		; within 1.0 second?
	bcc.s	allocRawMem_gc
	move.l	(a7),d0
	bsr		addBlock
	move.l	(a7),d0
	bsr		heapAlloc
	bne.s	allocRawMem_out
allocRawMem_gc
	bsr		garbageCollect
	move.l	(a7),d0
	bsr		heapAlloc
	bne.s	allocRawMem_out
	bsr		recombine
	move.l	(a7),d0
	bsr		heapAlloc
	bne.s	allocRawMem_out
	bsr		freeBlocksToOS
	move.l	(a7),d0
	bsr		addBlock
	move.l	(a7),d0
	bsr		heapAlloc
allocRawMem_out
	lea.l	4(a7),a7	; don't	change flags
	move.l	(a7)+,a2
	rts
heapAlloc
	move.l	a2,-(a7)
	bsr		freeListFromPayloadSize
heapAlloc_ploop		; loop per list	pointer
	move.l	a2,a1
	bra.s	heapAlloc_centry
heapAlloc_cloop		; loop per chunk in	list
	cmp.w	ObjectHeader_ChunkSize(a0),d0
	bcs.s	heapAlloc_found
	move.l	a0,a1
heapAlloc_centry
	move.l	(a1),a0
	cmpa.w	#0,a0
	bne.s	heapAlloc_cloop
	addq.l	#4,a2
	lea.l	freeListLarge+4(a5),a1
	cmpa.l	a1,a2
	bne.s	heapAlloc_ploop
	move.l	(a7)+,a2
	cmp.w	d0,d0	; set Z
	rts
heapAlloc_found
	move.l	(a0),(a1)
	move.w	ObjectHeader_ChunkSize(a0),d1
	and.w	#$FFF8,d1
	cmp.w	d0,d1
	beq.s	heapAlloc_notSplit
	move.l	a0,-(a7)
	moveq.l	#0,d2
	move.w	ObjectHeader_ClassIndex(a0),d2
	move.l	a0,a1
	sub.l	d2,a1	; block	of both	sub-chunks
	sub.w	d0,d1	; d1 = free	size
	move.w	d0,d2	; zero extend
	add.l	d2,a0	; sub-chunk	to be freed
	move.w	d1,d0
	bsr		addChunkToFreeList
	move.w	d2,d0	; allocated	sub-chunk size
	move.w	d2,d1	; allocated	sub-chunk size
	move.l	(a7)+,a0
heapAlloc_notSplit
	move.w	d1,ObjectHeader_ChunkSize(a0)
	subq.w	#ObjectHeader_extra,d1
	move.l	a0,a1
	lsr.w	#3,d1
	bcc.s	heapAlloc_fill
	clr.l	(a1)+
	bra.s	heapAlloc_fill
heapAlloc_zero8
	clr.l	(a1)+
	clr.l	(a1)+
heapAlloc_fill
	dbra	d1,heapAlloc_zero8
heapAlloc_out
	move.l	(a7)+,a2
	or.w	d0,d0	; clear	Z
	rts
	
addChunkToFreeList
	or.w	#chunkMarkEmpty,d0	; mark empty
	move.w	d0,ObjectHeader_ChunkSize(a0)
	bsr		freeListFromChunkSize
	move.l	(a2),(a0)
	move.l	a0,(a2)
	move.w	a0,d0
	sub.w	a1,d0
	move.w	d0,ObjectHeader_ClassIndex(a0)
	move.l	blockBitmap(a1),a2
	lsr.w	#3,d0
	move.w	d0,d1
	lsr.w	#3,d0
	bclr.b	d1,0(a2,d0.w)
	rts
	
freeListFromPayloadSize
	add.l	#ObjectHeader_extra+7,d0
freeListFromChunkSize
	lsr.w	#3,d0
	cmp.w	#8+1,d0
	bcc.s	freeListFromChunkSize_bigger
	lea.l	freeList8-4(a5),a2
	asl.w	#2,d0	; strip	lower bits
	add.w	d0,a2
	add.w	d0,d0	; restore size
	rts
freeListFromChunkSize_bigger
	asl.w	#3,d0
	lea.l	freeListSmall(a5),a2
	cmp.w	#chunkSizeSmall+1,d0
	bcs.s	freeListFromChunkSize_rts
	lea.l	freeListLarge(a5),a2
freeListFromChunkSize_rts
	rts
	
addBlock
	cmp.l	#blockMaxSize,d0
	bcc		addBlock_rts
	cmp.w	#blockMinSize,d0
	bcc.s	addBlock_sized
	move.w	#blockMinSize,d0
addBlock_sized
	add.l	#63+ObjectHeader_extra,d0
	and.w	#$FFC0,d0	; round	up to *64
	move.l	d0,-(a7)	; save payload size
	lsr.l	#6,d0		; size of bitmap
	add.l	(a7),d0
	add.w	#blockHeaderSize,d0
	systrap	MemPtrNew(d0.l)
	cmp.w	#0,a0
	beq		addBlock_fail
	lea.l	blockHeaderSize(a0),a1	; a1 = block
	move.l	(a7),d0
	lea.l	0(a1,d0.l),a0	; top of payload ==	bitmap
	move.l	a0,blockBitmap(a1)
	lea.l	ObjectHeader_extra(a1),a0
	bsr		addChunkToFreeList
	move.l	(a7),d0
	lsr.w	#6,d0	; bitmap is	payload/64
	move.l	a2,a0	; bitmap ptr
	bsr		memclear
	lea.l	heapBlocks(a5),a2
	bra.s	addBlock_sentry
addBlock_sloop
	lea.l	blockNext(a0),a2
addBlock_sentry
	move.l	(a2),a0
	cmp.w	#0,a0
	beq.s	addBlock_send
	cmp.l	a0,a1
	bcc.s	addBlock_sloop
addBlock_send
	move.l	a0,blockNext(a1)
	move.l	a1,(a2)
	addq.w	#1,heapBlockCount(a5)
	move.l	heapBlocks(a5),a0
	move.w	heapBlockCount(a5),d0
	bsr.s	buildBlockSubtree
	move.l	a1,heapRoot(a5)
	bsr		setHeapMaxMin
addBlock_fail
	move.l	(a7)+,d0
addBlock_rts
	rts
setHeapMaxMin
	move.l	heapRoot(a5),a1
setHeapMaxMin_loop
	move.l	a1,a0
	move.l	blockRight(a0),a1
	cmp.w	#0,a1
	bne.s	setHeapMaxMin_loop
	move.l	blockTop(a0),heapMaxAddress(a5)
	rts
	
buildBlockSubtree
	tst.w	d0		; subtree is empty?
	beq.s		buildBlock_null
	move.w	d0,d1	; n/2 blocks to	the	left
	lsr.w	#1,d0
	sub.w	d0,d1
	subq.w	#1,d1
	move.w	d1,-(a7)	; n-(n/2)-1	to the right
	bsr.s	buildBlockSubtree
	move.w	(a7)+,d0
	move.l	a0,-(a7)	; save subroot
	move.l	a1,blockLeft(a0)
	move.l	blockNext(a0),a0	; follow chain
	bsr.s	buildBlockSubtree
	move.l	a1,a2
	move.l	(a7)+,a1
	move.l	a2,blockRight(a1)
	rts
buildBlock_null
	suba.l	a1,a1
	rts
releaseDmHeap
	movem.l	a2,-(a7)
	move.l	heapBlocks(a5),a2
	clr.l	heapBlocks(a5)
	clr.w	heapBlockCount(a5)
	bra.s	releaseDmHeap_loopEnd
releaseDmHeap_loop
	lea.l	-blockHeaderSize(a2),a0	; correct for data before block
	move.l	blockNext(a2),a2
	systrap	MemPtrFree(a0.l)
releaseDmHeap_loopEnd
	cmp.w	#0,a2
	bne.s	releaseDmHeap_loop
	movem.l	(a7)+,a2
	rts
clearDmHeap
	link	a6,#-38
	bsr	releaseDmHeap
	unlk	a6
	rts
makeproxy:
	rts
unproxy:
	rts
	
initHeap
	clr.b	heapLocked(a5)
	systrap	TimGetTicks()
	move.w	d0,lastGCTime(a5)
	move.l	#3,d0
	bsr	op_new
	move.l	(a7)+,OutOfMemoryError_obj(a5)
	rts
	
clearHeap
	clr.l	OutOfMemoryError_obj(a5)
	bsr		clearDmHeap
	rts
memcopy:
	bra.s	memcopy_end
memcopy_loop
	move.b	(a1)+,(a0)+
memcopy_end
	dbra	d0,memcopy_loop
	rts
	
memclear:
	tst.w	d0
	beq.s	memclear_out
	exg 	d0,a0
	btst.l	#0,d0
	exg 	d0,a0
	beq.s	memclear_8end
	clr.b	(a0)+
	subq.w	#1,d0
	bra.s	memclear_8end
memclear_8loop
	clr.l	(a0)+
	clr.l	(a0)+
memclear_8end
	subq.w	#8,d0
	bhs.s	memclear_8loop
	not.w	d0		; d0 =	7 ... 0
	asl.w	#1,d0		; d0 = 14 ... 0
	jmp	memclear_rest(pc,d0.w)
memclear_rest
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
memclear_out
	rts
catch_Any:
	clr.l   d0  ; not sign extend
	move.w	ClassInfo.Name(a0),d0
	move.l	SegStart1(a5),a0
	add.l   d0,a0
	move.l	a0,-(a7)
	clr.w	-(a7)
	move.l	exceptionPC(a5),a0
	bsr	getMethodName
	move.l	a0,-(a7)
	move.l  currentException(a5),-(a7)
	bsr     M14
	add.l   #4,a7
	bsr		clearHeap	; make sure	heap is	clean on exit
catch_Any_heaped
	trap	#15
	dc.w	sysTrapErrDisplayFileLineMsg
	unlk    a6
	rts
getMethodName:
	move.w	#2000,d1	; search within	next 4000 bytes
getMethodName_loop
	move.w	(a0)+,d0
	cmp.w	#$4e75,d0
	bne.s	getMethodName_next
	move.b	(a0),d0
	cmp.b	#$80,d0
	bne.s	getMethodName_next
	clr.l	d0
	move.b	1(a0),d0
	tst.b	2(a0,d0.w)
	beq.s	getMethodName_found
getMethodName_next
	dbra	d1,getMethodName_loop
getMethodName_somewhere
	lea.l	getMethodName_somewhereString(pc),a0
	rts
getMethodName_found
	addq.l	#2,a0
	rts
getMethodName_somewhereString
	dc.b	'???',0
	align 2
	
M_none:
	rts
op_new:
	move.w	d0,-(a7)
	bsr	getclassinfo
	clr.l	d0
	move.w	ClassInfo.ObjectSizePlusHeader(a0),d0
	bsr	allocMem
	beq.s	op_new_fail
	move.w	(a7)+,ObjectHeader_ClassIndex(a0)
	move.l	(a7),a4
	move.l	a0,(a7)
	jmp	(a4)
op_new_fail
	addq.l	#2,a7
	bra.s	throw_OutOfMemoryError
throw_NullPointerException:
	move.l	#21,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
throw_ClassCastException:
	move.l	#35,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
throw_OutOfMemoryError:
	move.l	OutOfMemoryError_obj(a5),-(a7)
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
	
throw_StackOverflowError:
	move.l	#36,d0
	bsr	op_new
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
throw_ArrayIndexOutOfBoundsException:
	move.l	#30,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
	
throw_ArrayStoreException:
	move.l	#34,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
throw_ArithmeticException:
	move.l	#29,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
throw_NegativeArraySizeException:
	move.l	#27,d0
	bsr	op_new
	bsr     M_none
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
	
do_athrow:
	move.l	a0,currentException(a5)
	move.l	a1,exceptionPC(a5)
	lea     4(a0),a0
	move.l  a1,(a0)+
	move.l	a1,d2       ; PC for unwinding stackframe
	move.l  a6,a1       ; link reg
	moveq   #6,d1       ; we only keep a small part of stack
fillSTloop
	move.l  a1,d0       ; set flags
	beq.s   fillSTnone
	move.l  4(a1),d0
	move.l  (a1),a1     ; next frame
fillSTnone
	move.l  d0,(a0)+ ; return address
	dbra    d1,fillSTloop
	move.l	currentException(a5),a0
	bsr	getclassinfo_a0
	move.l	-4(a6),a1	; address of Mxx__exceptions handler
	jmp	(a1)
	
CharsToString:
	lea.l	DummyCharArray(a5),a1
	move.w	#26,ObjectHeader_ClassIndex(a1)
	move.w	#1,Array.elsize(a1)
	move.w	(a0)+,Array.length(a1)
	move.l	a0,Array.data(a1)
	move.l	#23,d0
	bsr	op_new
	move.l	(a7),-(a7)
	lea.l	DummyCharArray(a5),a0
	move.l	a0,-(a7)
	bsr     M73
	lea.l	8(a7),a7
	move.l	(a7)+,a0
	rts
CharPtr_to_String:
	lea.l	DummyCharArray(a5),a1
	move.w	#26,ObjectHeader_ClassIndex(a1)
	move.w	#1,Array.elsize(a1)
	move.l	a0,Array.data(a1)
	bsr	findNextNull
	move.l	a0,d0
	sub.l	Array.data(a1),d0
	move.w	d0,Array.length(a1)
	move.l	#23,d0	; Class	java/lang/String
	bsr	op_new
	move.l	(a7),-(a7)
	lea.l	DummyCharArray(a5),a0
	move.l	a0,-(a7)
	bsr     M73
	lea.l	8(a7),a7
	move.l	(a7)+,a0
	rts
StringToChars:
	move.l	0(a0),a1
	move.l	Array.data(a1),a1
	adda.l	8(a0),a1
	move.l	4(a0),d0
	tst.b	0(a1,d0.l)
	bne.s	StringToChars_xxl
	addq.l	#1,d0
	move.l	a1,a0
	rts
StringToChars_xxl
	move.l	a0,-(a7)
	bsr     M77
	addq.l	#4,a7
	clr.l	d0
	move.w	Array.length(a0),d0
	addq.l	#1,d0
	move.l	Array.data(a0),a0
	rts
findNextNull:
	tst.b	(a0)+
	bne.s	findNextNull
	subq.l	#1,a0
	rts
	
StringBuffer_setLength:
	move.l  a1,d0   ; check for null
	beq.s   StringBuffer_setLength_out
	move.l  0(a1),a0
	move.l  Array.data(a0),a0
	move.l  a0,d0
	bsr.s   findNextNull
	sub.l   d0,a0
	move.l  a0,4(a1)
StringBuffer_setLength_out
	rts
	
	code
nonnull_check:
	cmp.w	#0,a0
	beq	throw_NullPointerException
	rts
array_check:
	cmp.w	#0,a0
	beq	throw_NullPointerException
array_check_safe:
	clr.l	d1
	move.w	Array.length(a0),d1
	cmp.l	d1,d0
	bcc	throw_ArrayIndexOutOfBoundsException
	move.l	Array.data(a0),a1	; get data
	rts
aastore_check:
	move.l	12(a7),a0
	move.l	8(a7),d0
	cmp.w	#0,a0
	beq	throw_NullPointerException
	clr.l	d1
	move.w	Array.length(a0),d1
	cmp.l	d1,d0
	bcc	throw_ArrayIndexOutOfBoundsException
	move.l	4(a7),a1
	cmp.w	#0,a1
	beq.s	aastore_check_ok
	move.w	ObjectHeader_ClassIndex(a0),d1
	mulu.w	#ClassInfo_size,d1
	lea	ClassTable(pc),a0
	add.l	d1,a0		; a0 = array's classinfo
	move.w	ObjectHeader_ClassIndex(a1),d1
	mulu.w	#ClassInfo_size,d1
	lea	ClassTable(pc),a1
	add.l	d1,a1		; a1 = value's classinfo
	jsr	ClassInfo.AastoreCheck(a0)
	beq	throw_ArrayStoreException
aastore_check_ok
	rts
PilotMain1
	bra	PilotMain
getclassinfo_a0:
	move.w	ObjectHeader_ClassIndex(a0),d0
getclassinfo:
	mulu.w	#ClassInfo_size,d0
	lea	ClassTable(pc),a0
	add.l	d0,a0
	rts
getvoidptr:
	move.l	4(a7),a0
	cmp.w	#0,a0
	beq.s	getvoidptr_out
	cmp.w	#23,ObjectHeader_ClassIndex(a0)
	beq.s	getvoidptr_String
	cmp.w	#14,ObjectHeader_ClassIndex(a0)
	beq.s	getvoidptr_StringBuffer
	bsr.s	getclassinfo_a0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_array,d0
	bne.s	getvoidptr_array
getvoidptr_object
	clr.l	d0
	move.w	ClassInfo.ObjectSizePlusHeader(a0),d0
	move.l	4(a7),a0
	bra.s	getvoidptr_out
getvoidptr_array
	move.l	4(a7),a0
	move.w	Array.length(a0),d0
	mulu.w	Array.elsize(a0),d0
	move.l	Array.data(a0),a0
	bra.s	getvoidptr_out
getvoidptr_StringBuffer
	move.l	0(a0),a0
	clr.l	d0
	move.w	Array.length(a0),d0
	move.l	Array.data(a0),a0
	bra.s	getvoidptr_out
getvoidptr_String
	bsr	StringToChars
getvoidptr_out
	rts
	code
PilotMain:
cmd     set     8
cmdPBP  set     10
launchFlags     set     14
	link    a6,#-4
	lea     catch_Any(pc),a0
	move.l  a0,-4(a6)
	move.l  a5,-(a7)
	tst.w   cmd(a6)
	bne     PilotMain_leave
	move.w  launchFlags(a6),d0
	and.w   #sysAppLaunchFlagNewGlobals,d0
	bne.s   PilotMain_have_globals
	systrap MemPtrNew(#DataSize.l)
	move.l  a0,a5
PilotMain_have_globals:
	move.l  a7,StackEnd(a5)
	lea.l   -2000(a7),a0
	move.l  a0,StackLimit(a5)
	bsr     init_jumptable
	bsr     initHeap
	bsr     init_constant_strings
	bsr	all_clinit
	clr.l   d0
	move.w  cmd(a6),d0
	move.l  d0,-(a7)
	move.l  cmdPBP(a6),-(a7)
	clr.l   d0
	move.w  launchFlags(a6),d0
	move.l  d0,-(a7)
	bsr     M0
	lea     12(a7),a7
	bsr     clearHeap
	bsr     cleanup_jumptable
	move.w  launchFlags(a6),d0
	and.w   #sysAppLaunchFlagNewGlobals,d0
	bne.s   PilotMain_had_globals
	systrap MemChunkFree(a5.l)
PilotMain_had_globals:
PilotMain_leave:
	move.l  (a7)+,a5
	unlk    a6
	rts
	dc.b    $80,9,'PilotMain',0,0,0
	align   2
	code
all_clinit:
	bsr     M2
	bsr     M18
	bsr     M28
	bsr     M80
	bsr     M81
	bsr     M83
	rts
	code
init_jumptable:
	lea.l	__Startup__(pc),a0
	move.l	a0,SegStart1(a5)
	rts
cleanup_jumptable:
	rts
StaticObjectCount	equ	2
	code
; Method Hello.PilotMain(III)I
M0:
	link	a6,#0
	pea	M0__exceptions(pc)
	move.l	d7,-(a7)
	clr.l	d7	; local 3
	clr.l	-(a7)
	cmp.l	StackLimit(a5),a7
	bcc.s	M0__stackOK
	bsr     throw_StackOverflowError
M0__stackOK
	tst.l	16(a6)
	beq	M0__6
	clr.l	d0
	move.l	-8(a6),d7
	unlk	a6
	rts
M0__6:
	pea	1000
	bsr	M56	; (direct)Method palmos/Palm.FrmGotoForm(I)V
	addq.l	#4,a7
	move.l	#18,d0	; Class palmos/Event
	bsr     op_new
	move.l	(a7)+,d7
	move.l	#16,d0	; Class palmos/ShortHolder
	bsr     op_new
	move.l	(a7),-(a7)
	clr.l	-(a7)
	bsr	M66	; (direct)Method palmos/ShortHolder.<init>(S)V
	addq.l	#8,a7
	move.l	(a7)+,-12(a6)
M0__30:
	move.l	d7,a0
	move.w	(a0),d0
	ext.l	d0
	cmp.l	#22,d0
	beq	M0__79
	move.l	a0,-(a7)
	move.l	#-1,d0
	move.l	d0,-(a7)
	bsr	M52	; (direct)Method palmos/Palm.EvtGetEvent(Lpalmos/Event;I)V
	addq.l	#8,a7
	move.l	d7,-(a7)
	bsr	M64	; (direct)Method palmos/Palm.SysHandleEvent(Lpalmos/Event;)Z
	addq.l	#4,a7
	tst.l	d0
	bne	M0__30
	clr.l	-(a7)
	move.l	d7,-(a7)
	move.l	-12(a6),-(a7)
	bsr	M63	; (direct)Method palmos/Palm.MenuHandleEvent(ILpalmos/Event;Lpalmos/ShortHolder;)Z
	lea	12(a7),a7
	tst.l	d0
	bne	M0__30
	move.l	d7,-(a7)
	bsr	M1	; (direct)Method Hello.appHandleEvent(Lpalmos/Event;)Z
	addq.l	#4,a7
	tst.l	d0
	bne	M0__30
	bsr	M55	; (direct)Method palmos/Palm.FrmGetActiveForm()I
	move.l	d0,-(a7)
	move.l	d7,-(a7)
	bsr	M57	; (direct)Method palmos/Palm.FrmHandleEvent(ILpalmos/Event;)Z
	addq.l	#8,a7
	bra	M0__30
M0__79:
	bsr	M53	; (direct)Method palmos/Palm.FrmCloseAllForms()V
	clr.l	d0
	move.l	-8(a6),d7
	unlk	a6
	rts
M0__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method Hello.appHandleEvent(Lpalmos/Event;)Z
M1:
	link	a6,#0
	pea	M1__exceptions(pc)
	clr.l	-(a7)
	cmp.l	StackLimit(a5),a7
	bcc.s	M1__stackOK
	bsr     throw_StackOverflowError
M1__stackOK
	move.l	8(a6),a0
	bsr     nonnull_check
	move.w	(a0),d0
	ext.l	d0
	cmp.l	#23,d0
	bne	M1__23
	move.w	8(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	bsr	M58	; (direct)Method palmos/Palm.FrmInitForm(I)I
	addq.l	#4,a7
	move.l	d0,-8(a6)
	move.l	-8(a6),-(a7)
	bsr	M59	; (direct)Method palmos/Palm.FrmSetActiveForm(I)V
	move.l	#1,d0
	unlk	a6
	rts
M1__23:
	move.l	8(a6),a0
	bsr     nonnull_check
	move.w	(a0),d0
	ext.l	d0
	cmp.l	#24,d0
	bne	M1__40
	bsr	M55	; (direct)Method palmos/Palm.FrmGetActiveForm()I
	move.l	d0,-(a7)
	bsr	M54	; (direct)Method palmos/Palm.FrmDrawForm(I)V
	move.l	#1,d0
	unlk	a6
	rts
M1__40:
	clr.l	d0
	unlk	a6
	rts
M1__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Object.<clinit>()V
M2:
	link	a6,#0
	pea	M2__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M2__stackOK
	bsr     throw_StackOverflowError
M2__stackOK
	unlk	a6
	rts
M2__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method java/lang/Object.getClass()Ljava/lang/Class;
M4:
	move.l	4(a7),a0
	bsr     getclassinfo_a0
	addq.l	#ClassHeader_sizeof,a0
	rts
; native Method java/lang/Object.toString()Ljava/lang/String;
M6:
	link	a6,#0
	move.l	#14,d0	; Class java/lang/StringBuffer
	bsr     op_new
	move.l	(a7),-(a7)
	bsr     M29
	move.l	8(a6),(a7)
	bsr     M4
	move.l	a0,(a7)
	bsr     M19
	move.l	a0,(a7)
	bsr     M34
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	#'@',d0
	move.l	d0,-(a7)
	move.l	4(a7),a0
	bsr     M32
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	8(a6),-(a7)
	bsr     M26
	move.l	a0,(a7)
	move.l	4(a7),a0
	bsr     M34
	addq.l	#8,a7
	move.l	a0,-(a7)
	bsr     M40
	unlk	a6
	rts
; Method java/lang/Throwable.<init>(Ljava/lang/String;)V
M11:
	link	a6,#0
	pea	M11__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M11__stackOK
	bsr     throw_StackOverflowError
M11__stackOK
	move.l	12(a6),a0
	move.l	8(a6),(a0)
	unlk	a6
	rts
M11__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Throwable.toString()Ljava/lang/String;
M12:
	link	a6,#0
	pea	M12__exceptions(pc)
	move.l	d7,-(a7)
	clr.l	d7	; local 1
	cmp.l	StackLimit(a5),a7
	bcc.s	M12__stackOK
	bsr     throw_StackOverflowError
M12__stackOK
	move.l	8(a6),-(a7)
	bsr	M4	; (direct)Method java/lang/Object.getClass()Ljava/lang/Class;
	move.l	a0,(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr	M19	; (direct)Method java/lang/Class.getName()Ljava/lang/String;
	addq.l	#4,a7
	move.l	a0,d7	; direct from A0
	move.l	8(a6),a0
	tst.l	(a0)
	bne	M12__17
	move.l	d7,a0	; return in a0
	move.l	-8(a6),d7
	unlk	a6
	rts
M12__17:
	move.l	#14,d0	; Class java/lang/StringBuffer
	bsr     op_new
	move.l	(a7),-(a7)
	bsr	M29	; (direct)Method java/lang/StringBuffer.<init>()V
	move.l	d7,(a7)
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	pea	CS0(a5)	; ": "
	move.l	4(a7),a0
	bsr     nonnull_check
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	8(a6),a0
	move.l	(a0),-(a7)
	move.l	4(a7),a0
	bsr     nonnull_check
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr	M40	; (direct)Method java/lang/StringBuffer.toString()Ljava/lang/String;
	move.l	-8(a6),d7
	unlk	a6
	rts
M12__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Throwable.printMethod(I)V
M13:
	link	a6,#0
	pea	M13__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M13__stackOK
	bsr     throw_StackOverflowError
M13__stackOK
	tst.l	8(a6)
	beq	M13__11
	move.l	8(a6),-(a7)
	bsr	M15	; (direct)Method java/lang/Throwable.getMethodName(I)Ljava/lang/String;
	move.l	a0,(a7)
	bsr	M95	; (direct)Method palmos/JumpLog.println(Ljava/lang/String;)V
	addq.l	#4,a7
M13__11:
	unlk	a6
	rts
M13__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Throwable.printStackTrace()V
M14:
	link	a6,#0
	pea	M14__exceptions(pc)
	move.l	d7,-(a7)
	move.l	8(a6),d7	; arg 0
	cmp.l	StackLimit(a5),a7
	bcc.s	M14__stackOK
	bsr     throw_StackOverflowError
M14__stackOK
	move.l	#14,d0	; Class java/lang/StringBuffer
	bsr     op_new
	move.l	(a7),-(a7)
	bsr	M29	; (direct)Method java/lang/StringBuffer.<init>()V
	addq.l	#4,a7
	pea	CS1(a5)	; "*** Exception *** "
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	bsr	M12	; (direct)Method java/lang/Throwable.toString()Ljava/lang/String;
	move.l	a0,(a7)
	move.l	4(a7),a0
	bsr     nonnull_check
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr	M40	; (direct)Method java/lang/StringBuffer.toString()Ljava/lang/String;
	move.l	a0,(a7)
	bsr	M95	; (direct)Method palmos/JumpLog.println(Ljava/lang/String;)V
	addq.l	#4,a7
	pea	CS2(a5)	; "stack trace:"
	bsr	M95	; (direct)Method palmos/JumpLog.println(Ljava/lang/String;)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	4(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	8(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	12(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	16(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	20(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	24(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	28(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	addq.l	#4,a7
	move.l	d7,a0
	move.l	32(a0),-(a7)
	bsr	M13	; (direct)Method java/lang/Throwable.printMethod(I)V
	move.l	-8(a6),d7
	unlk	a6
	rts
M14__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method java/lang/Throwable.getMethodName(I)Ljava/lang/String;
M15:
	move.l  4(a7),a0
	bsr     getMethodName
	bsr     CharPtr_to_String
	rts
; Method java/lang/Exception.<init>(Ljava/lang/String;)V
M17:
	link	a6,#0
	pea	M17__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M17__stackOK
	bsr     throw_StackOverflowError
M17__stackOK
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	bsr	M11	; (direct)Method java/lang/Throwable.<init>(Ljava/lang/String;)V
	unlk	a6
	rts
M17__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Class.<clinit>()V
M18:
	link	a6,#0
	pea	M18__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M18__stackOK
	bsr     throw_StackOverflowError
M18__stackOK
	unlk	a6
	rts
M18__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method java/lang/Class.getName()Ljava/lang/String;
M19:
	move.l  4(a7),a0
	clr.l   d0      ; not sign extend
	move.w  ClassInfo.Name-ClassHeader_sizeof(a0),d0
	move.l	SegStart1(a5),a0
	add.l   d0,a0
	bsr     CharPtr_to_String
	rts
; native Method java/lang/Class.getPrimitiveClass(Ljava/lang/String;)Ljava/lang/Class;
M20:
	clr.l   d0
	move.l	d0,a0
	rts
; native Method java/lang/Class.isInterface()Z
M21:
	move.l	4(a7),a0
	clr.l   d0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_interface,d0
	sne.b	d0
	neg.b	d0
	rts
; native Method java/lang/Class.isPrimitive()Z
M22:
	move.l	4(a7),a0
	clr.l   d0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_primitive,d0
	sne.b	d0
	neg.b	d0
	rts
; Method java/lang/Class.toString()Ljava/lang/String;
M24:
	link	a6,#0
	pea	M24__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M24__stackOK
	bsr     throw_StackOverflowError
M24__stackOK
	move.l	#14,d0	; Class java/lang/StringBuffer
	bsr     op_new
	move.l	(a7),-(a7)
	move.l	8(a6),-(a7)
	bsr	M21	; (direct)Method java/lang/Class.isInterface()Z
	addq.l	#4,a7
	tst.l	d0
	beq	M24__16
	pea	CS3(a5)	; "interface "
	bra	M24__30
M24__16:
	move.l	8(a6),-(a7)
	bsr	M22	; (direct)Method java/lang/Class.isPrimitive()Z
	addq.l	#4,a7
	tst.l	d0
	beq	M24__28
	pea	CS4(a5)	; ""
	bra	M24__30
M24__28:
	pea	CS5(a5)	; "class "
M24__30:
	bsr	M78	; (direct)Method java/lang/String.valueOf(Ljava/lang/Object;)Ljava/lang/String;
	move.l	a0,(a7)
	bsr	M31	; (direct)Method java/lang/StringBuffer.<init>(Ljava/lang/String;)V
	addq.l	#8,a7
	move.l	8(a6),-(a7)
	bsr	M19	; (direct)Method java/lang/Class.getName()Ljava/lang/String;
	move.l	a0,(a7)
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr	M40	; (direct)Method java/lang/StringBuffer.toString()Ljava/lang/String;
	unlk	a6
	rts
M24__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Integer.toUnsignedString(II)Ljava/lang/String;
M25:
	link	a6,#0
	pea	M25__exceptions(pc)
	movem.l	d7-d6,-(a7)
	move.l	12(a6),d6	; arg 0
	clr.l	d7	; local 2
	cmp.l	StackLimit(a5),a7
	bcc.s	M25__stackOK
	bsr     throw_StackOverflowError
M25__stackOK
	move.l	#14,d0	; Class java/lang/StringBuffer
	bsr     op_new
	move.l	(a7),-(a7)
	pea	32
	move.l	8(a6),-(a7)
	bsr     op_idiv
	bsr	M30	; (direct)Method java/lang/StringBuffer.<init>(I)V
	addq.l	#8,a7
	move.l	(a7)+,d7
M25__12:
	move.l	d7,-(a7)
	move.l	SOF0(a5),-(a7)
	move.l	d6,-(a7)
	pea	1
	move.l	8(a6),d0
	move.l	(a7),d1
	and.w	#$1F,d0  ; require by VM spec
	lsl.l	d0,d1
	move.l	d1,(a7)
	move.l	#1,d0
	sub.l	d0,(a7)
	move.l	(a7)+,d0
	and.l	(a7)+,d0
	move.l	(a7)+,a0
	bsr     array_check
	adda.l	d0,a1
	clr.l	d0
	move.b	(a1),d0
	move.l	d0,-(a7)
	bsr	M32	; (direct)Method java/lang/StringBuffer.append(C)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,d0
	move.l	d6,d0
	move.l	8(a6),d1
	and.w	#$1F,d1  ; require by VM spec
	lsr.l	d1,d0
	move.l	d0,d6
	; avoided 	tst.l	d6
	bne	M25__12
	move.l	d7,-(a7)
	bsr	M39	; (direct)Method java/lang/StringBuffer.reverse()Ljava/lang/StringBuffer;
	move.l	a0,(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr	M40	; (direct)Method java/lang/StringBuffer.toString()Ljava/lang/String;
	movem.l	-12(a6),d7-d6
	unlk	a6
	rts
M25__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Integer.toHexString(I)Ljava/lang/String;
M26:
	link	a6,#0
	pea	M26__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M26__stackOK
	bsr     throw_StackOverflowError
M26__stackOK
	move.l	8(a6),-(a7)
	pea	4
	bsr	M25	; (direct)Method java/lang/Integer.toUnsignedString(II)Ljava/lang/String;
	unlk	a6
	rts
M26__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method java/lang/Integer.toString(I)Ljava/lang/String;
M27:
	move.l	4(a7),d0
	cmp.l	#$80000000,d0
	beq.s	integer_toString_0
	move.l	d0,-(a7)
	pea	integer_toString_buffer(a5)
	trap	#15
	dc.w	sysTrapStrIToA
	addq.l	#8,a7
	lea.l	integer_toString_buffer(a5),a0
	bra.s	integer_toString_1
integer_toString_0
	lea	integer_toString_minbuf(pc),a0
integer_toString_1
	bsr     CharPtr_to_String
	rts
integer_toString_minbuf
	dc.b	'-2147483648',0
	align	2
; Method java/lang/Integer.<clinit>()V
M28:
	link	a6,#0
	pea	M28__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M28__stackOK
	bsr     throw_StackOverflowError
M28__stackOK
	move.l #36,-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7),a1
	move.l	Array.data(a1),a1
	move.b	#$30,(a1)+
	move.b	#$31,(a1)+
	move.b	#$32,(a1)+
	move.b	#$33,(a1)+
	move.b	#$34,(a1)+
	move.b	#$35,(a1)+
	move.b	#$36,(a1)+
	move.b	#$37,(a1)+
	move.b	#$38,(a1)+
	move.b	#$39,(a1)+
	move.b	#$61,(a1)+
	move.b	#$62,(a1)+
	move.b	#$63,(a1)+
	move.b	#$64,(a1)+
	move.b	#$65,(a1)+
	move.b	#$66,(a1)+
	move.b	#$67,(a1)+
	move.b	#$68,(a1)+
	move.b	#$69,(a1)+
	move.b	#$6a,(a1)+
	move.b	#$6b,(a1)+
	move.b	#$6c,(a1)+
	move.b	#$6d,(a1)+
	move.b	#$6e,(a1)+
	move.b	#$6f,(a1)+
	move.b	#$70,(a1)+
	move.b	#$71,(a1)+
	move.b	#$72,(a1)+
	move.b	#$73,(a1)+
	move.b	#$74,(a1)+
	move.b	#$75,(a1)+
	move.b	#$76,(a1)+
	move.b	#$77,(a1)+
	move.b	#$78,(a1)+
	move.b	#$79,(a1)+
	move.b	#$7a,(a1)+
	move.l	(a7)+,SOF0(a5)
	unlk	a6
	rts
M28__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.<init>()V
M29:
	link	a6,#0
	pea	M29__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M29__stackOK
	bsr     throw_StackOverflowError
M29__stackOK
	move.l	8(a6),-(a7)
	pea	16
	bsr	M30	; (direct)Method java/lang/StringBuffer.<init>(I)V
	unlk	a6
	rts
M29__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.<init>(I)V
M30:
	link	a6,#0
	pea	M30__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M30__stackOK
	bsr     throw_StackOverflowError
M30__stackOK
	move.l	8(a6),-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7)+,d0
	move.l	12(a6),a0
	move.l	d0,(a0)
	clr.l	d0
	move.b	d0,8(a0)
	unlk	a6
	rts
M30__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.<init>(Ljava/lang/String;)V
M31:
	link	a6,#0
	pea	M31__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M31__stackOK
	bsr     throw_StackOverflowError
M31__stackOK
	move.l	12(a6),-(a7)
	move.l	8(a6),a0
	bsr     nonnull_check
	move.l	4(a0),d0
	add.l	#16,d0
	move.l	d0,-(a7)
	bsr	M30	; (direct)Method java/lang/StringBuffer.<init>(I)V
	addq.l	#8,a7
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	move.l	a0,d0
	unlk	a6
	rts
M31__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.append(C)Ljava/lang/StringBuffer;
M32:
	link	a6,#0
	pea	M32__exceptions(pc)
	movem.l	d7-d6,-(a7)
	move.l	12(a6),d7	; arg 0
	clr.l	d6	; local 2
	cmp.l	StackLimit(a5),a7
	bcc.s	M32__stackOK
	bsr     throw_StackOverflowError
M32__stackOK
	move.l	d7,a0
	move.l	4(a0),d0
	add.l	#1,d0
	move.l	d0,d6
	move.l	d6,-(a7)
	move.l	(a0),a0
	bsr     nonnull_check
	clr.l	d0
	move.w	Array.length(a0),d0
	cmp.l	(a7)+,d0
	bge	M32__21
	move.l	d7,-(a7)
	move.l	d6,-(a7)
	bsr	M36	; (direct)Method java/lang/StringBuffer.expandCapacity(I)V
	addq.l	#8,a7
M32__21:
	move.l	d7,a0
	move.l	(a0),-(a7)
	move.l	a0,-(a7)
	move.l	4(a0),d0
	move.l	(a7),-(a7)
	move.l	d0,4(a7)
	move.l	d0,-(a7)
	move.l	#1,d0
	add.l	(a7)+,d0
	move.l	(a7)+,a0
	bsr     nonnull_check
	move.l	d0,4(a0)
	move.l	8(a6),d2
	move.l	(a7)+,d0
	move.l	(a7)+,a0
	bsr     array_check
	move.b	d2,0(a1,d0.l)
	move.l	d7,a0	; return in a0
	movem.l	-12(a6),d7-d6
	unlk	a6
	rts
M32__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.append(I)Ljava/lang/StringBuffer;
M33:
	link	a6,#0
	pea	M33__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M33__stackOK
	bsr     throw_StackOverflowError
M33__stackOK
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	bsr	M79	; (direct)Method java/lang/String.valueOf(I)Ljava/lang/String;
	move.l	a0,(a7)
	bsr	M34	; (direct)Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
	unlk	a6
	rts
M33__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer;
M34:
	link	a6,#0
	pea	M34__exceptions(pc)
	movem.l	d7-d4,-(a7)
	move.l	12(a6),d7	; arg 0
	move.l	8(a6),d5	; arg 1
	clr.l	d4	; local 2
	clr.l	d6	; local 3
	cmp.l	StackLimit(a5),a7
	bcc.s	M34__stackOK
	bsr     throw_StackOverflowError
M34__stackOK
	tst.l	d5
	bne	M34__9
	move.l	d5,-(a7)
	bsr	M78	; (direct)Method java/lang/String.valueOf(Ljava/lang/Object;)Ljava/lang/String;
	addq.l	#4,a7
	move.l	a0,d5	; direct from A0
M34__9:
	move.l	d5,a0
	bsr     nonnull_check
	move.l	4(a0),d4
	move.l	d7,a0
	move.l	4(a0),d0
	add.l	d4,d0
	move.l	d0,d6
	move.l	d6,-(a7)
	move.l	(a0),a0
	bsr     nonnull_check
	clr.l	d0
	move.w	Array.length(a0),d0
	cmp.l	(a7)+,d0
	bge	M34__35
	move.l	d7,-(a7)
	move.l	d6,-(a7)
	bsr	M36	; (direct)Method java/lang/StringBuffer.expandCapacity(I)V
	addq.l	#8,a7
M34__35:
	move.l	d5,-(a7)
	clr.l	-(a7)
	move.l	d4,-(a7)
	move.l	d7,a0
	move.l	(a0),-(a7)
	move.l	4(a0),-(a7)
	bsr	M76	; (direct)Method java/lang/String.getChars(II[CI)V
	move.l	d7,a0
	move.l	d6,4(a0)
	movem.l	-20(a6),d7-d4
	unlk	a6
	rts
M34__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.copy()V
M35:
	link	a6,#0
	pea	M35__exceptions(pc)
	movem.l	d7-d6,-(a7)
	move.l	8(a6),d7	; arg 0
	clr.l	d6	; local 1
	cmp.l	StackLimit(a5),a7
	bcc.s	M35__stackOK
	bsr     throw_StackOverflowError
M35__stackOK
	move.l	d7,a0
	move.l	(a0),a0
	bsr     nonnull_check
	move.w	Array.length(a0),-(a7)
	clr.w	-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7)+,d6
	move.l	d7,a0
	move.l	(a0),-(a7)
	clr.l	-(a7)
	move.l	d6,-(a7)
	clr.l	-(a7)
	move.l	4(a0),-(a7)
	bsr	M84	; (direct)Method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
	lea	20(a7),a7
	move.l	d6,d0
	move.l	d7,a0
	move.l	d0,(a0)
	clr.l	d0
	move.b	d0,8(a0)
	movem.l	-12(a6),d7-d6
	unlk	a6
	rts
M35__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.expandCapacity(I)V
M36:
	link	a6,#0
	pea	M36__exceptions(pc)
	movem.l	d7-d5,-(a7)
	move.l	12(a6),d6	; arg 0
	clr.l	d7	; local 2
	clr.l	d5	; local 3
	cmp.l	StackLimit(a5),a7
	bcc.s	M36__stackOK
	bsr     throw_StackOverflowError
M36__stackOK
	move.l	d6,a0
	move.l	(a0),a0
	bsr     nonnull_check
	move.w	Array.length(a0),-(a7)
	clr.w	-(a7)
	move.l	#1,d0
	add.l	d0,(a7)
	move.l	(a7)+,d0
	add.l	d0,d0	; multiply by 2
	move.l	d0,d7
	move.l	8(a6),d0
	cmp.l	d7,d0
	ble	M36__17
	move.l	8(a6),d7
M36__17:
	move.l	d7,-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7)+,d5
	move.l	d6,a0
	move.l	(a0),-(a7)
	clr.l	-(a7)
	move.l	d5,-(a7)
	clr.l	-(a7)
	move.l	4(a0),-(a7)
	bsr	M84	; (direct)Method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
	lea	20(a7),a7
	move.l	d5,d0
	move.l	d6,a0
	move.l	d0,(a0)
	clr.l	d0
	move.b	d0,8(a0)
	movem.l	-16(a6),d7-d5
	unlk	a6
	rts
M36__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.getChars(II[CI)V
M37:
	link	a6,#0
	pea	M37__exceptions(pc)
	movem.l	d7-d6,-(a7)
	move.l	20(a6),d7	; arg 1
	move.l	16(a6),d6	; arg 2
	cmp.l	StackLimit(a5),a7
	bcc.s	M37__stackOK
	bsr     throw_StackOverflowError
M37__stackOK
	tst.l	d7
	blt	M37__12
	move.l	d7,d0
	move.l	24(a6),a0
	cmp.l	4(a0),d0
	blt	M37__21
M37__12:
	move.l	#32,d0	; Class java/lang/StringIndexOutOfBoundsException
	bsr     op_new
	move.l	(a7),-(a7)
	move.l	d7,-(a7)
	bsr	M91	; (direct)Method java/lang/StringIndexOutOfBoundsException.<init>(I)V
	addq.l	#8,a7
	bsr     op_athrow
M37__21:
	tst.l	d6
	blt	M37__33
	move.l	d6,d0
	move.l	24(a6),a0
	cmp.l	4(a0),d0
	ble	M37__42
M37__33:
	move.l	#32,d0	; Class java/lang/StringIndexOutOfBoundsException
	bsr     op_new
	move.l	(a7),-(a7)
	move.l	d6,-(a7)
	bsr	M91	; (direct)Method java/lang/StringIndexOutOfBoundsException.<init>(I)V
	addq.l	#8,a7
	bsr     op_athrow
M37__42:
	move.l	d7,d0
	cmp.l	d6,d0
	bge	M37__64
	move.l	24(a6),a0
	move.l	(a0),-(a7)
	move.l	d7,-(a7)
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	move.l	d6,d0
	sub.l	d7,d0
	move.l	d0,-(a7)
	bsr	M84	; (direct)Method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
	lea	20(a7),a7
	bra	M37__79
M37__64:
	move.l	d7,d0
	cmp.l	d6,d0
	ble	M37__79
	move.l	#32,d0	; Class java/lang/StringIndexOutOfBoundsException
	bsr     op_new
	move.l	(a7),-(a7)
	pea	CS6(a5)	; "StringBuffer.getChars(): begin"
	bsr	M92	; (direct)Method java/lang/StringIndexOutOfBoundsException.<init>(Ljava/lang/String;)V
	addq.l	#8,a7
	bsr     op_athrow
M37__79:
	movem.l	-12(a6),d7-d6
	unlk	a6
	rts
M37__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.length()I
M38:
	link	a6,#0
	pea	M38__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M38__stackOK
	bsr     throw_StackOverflowError
M38__stackOK
	move.l	8(a6),a0
	move.l	4(a0),d0
	unlk	a6
	rts
M38__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.reverse()Ljava/lang/StringBuffer;
M39:
	link	a6,#0
	pea	M39__exceptions(pc)
	movem.l	d7-d4,-(a7)
	move.l	8(a6),d6	; arg 0
	clr.l	d5	; local 1
	clr.l	d7	; local 2
	clr.l	d4	; local 3
	cmp.l	StackLimit(a5),a7
	bcc.s	M39__stackOK
	bsr     throw_StackOverflowError
M39__stackOK
	move.l	d6,a0
	tst.b	8(a0)
	beq	M39__11
	move.l	a0,-(a7)
	bsr	M35	; (direct)Method java/lang/StringBuffer.copy()V
	addq.l	#4,a7
M39__11:
	move.l	d6,a0
	move.l	4(a0),d0
	sub.l	#1,d0
	move.l	d0,d5
	move.l	d5,d0
	sub.l	#1,d0
	asr.l	#1,d0
	move.l	d0,d7
	bra	M39__60
M39__27:
	move.l	d6,a0
; removed
	move.l	d7,d0
	move.l	(a0),a0
	bsr     array_check
	adda.l	d0,a1
	clr.l	d0
	move.b	(a1),d0
	move.l	d0,d4
	move.l	d6,a0
	move.l	(a0),-(a7)
	move.l	d7,-(a7)
	move.l	(a0),-(a7)
	move.l	d5,d0
	sub.l	d7,d0
	move.l	(a7)+,a0
	bsr     array_check
	adda.l	d0,a1
	clr.l	d0
	move.b	(a1),d0
	move.l	d0,d2
	move.l	(a7)+,d0
	move.l	(a7)+,a0
	bsr     array_check
	move.b	d2,0(a1,d0.l)
	move.l	d6,a0
	move.l	(a0),-(a7)
	move.l	d5,d0
	sub.l	d7,d0
; removed
	move.l	d4,d2
; removed
	move.l	(a7)+,a0
	bsr     array_check
	move.b	d2,0(a1,d0.l)
	sub.l	#1,d7
M39__60:
	tst.l	d7
	bge	M39__27
	move.l	d6,a0	; return in a0
	movem.l	-20(a6),d7-d4
	unlk	a6
	rts
M39__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringBuffer.toString()Ljava/lang/String;
M40:
	link	a6,#0
	pea	M40__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M40__stackOK
	bsr     throw_StackOverflowError
M40__stackOK
	move.l	#23,d0	; Class java/lang/String
	bsr     op_new
	move.l	(a7),-(a7)
	move.l	8(a6),-(a7)
	bsr	M72	; (direct)Method java/lang/String.<init>(Ljava/lang/StringBuffer;)V
	addq.l	#8,a7
	move.l	(a7)+,a0
	unlk	a6
	rts
M40__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method palmos/Palm.nativeGetInt(I)I
M41:
	link	a6,#0
	move.l	8(a6),a0
	move.l	(a0),d0
	unlk	a6
	rts
; native Method palmos/Palm.nativeGetByte(I)I
M42:
	link	a6,#0
	move.l	8(a6),a0
	move.b	(a0),d0
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
; native Method palmos/Palm.DmCloseDatabase(I)I
M43:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmCloseDatabase
	ext.l	d0
	unlk	a6
	rts
; native Method palmos/Palm.DmGetRecord(II)I
M44:
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmGetRecord
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.DmNewRecord(ILpalmos/ShortHolder;I)I
M45:
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmNewRecord
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.DmNumRecords(I)I
M46:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmNumRecords
	and.l	#$ffff,d0
	unlk	a6
	rts
; native Method palmos/Palm.DmOpenDatabaseByTypeCreator(III)I
M47:
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmOpenDatabaseByTypeCreator
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.DmQueryRecord(II)I
M48:
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmQueryRecord
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.DmReleaseRecord(IIZ)I
M49:
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmReleaseRecord
	ext.l	d0
	unlk	a6
	rts
; native Method palmos/Palm.DmResizeRecord(III)I
M50:
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmResizeRecord
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.DmWrite(IILjava/lang/Object;I)I
M51:
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr     getvoidptr
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	trap	#15
	dc.w	sysTrapDmWrite
	ext.l	d0
	unlk	a6
	rts
; native Method palmos/Palm.EvtGetEvent(Lpalmos/Event;I)V
M52:
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapEvtGetEvent
	unlk	a6
	rts
; native Method palmos/Palm.FrmCloseAllForms()V
M53:
	link	a6,#0
	trap	#15
	dc.w	sysTrapFrmCloseAllForms
	unlk	a6
	rts
; native Method palmos/Palm.FrmDrawForm(I)V
M54:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFrmDrawForm
	unlk	a6
	rts
; native Method palmos/Palm.FrmGetActiveForm()I
M55:
	link	a6,#0
	trap	#15
	dc.w	sysTrapFrmGetActiveForm
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.FrmGotoForm(I)V
M56:
	link	a6,#0
	move.w	10(a6),-(a7)
	trap	#15
	dc.w	sysTrapFrmGotoForm
	unlk	a6
	rts
; native Method palmos/Palm.FrmHandleEvent(ILpalmos/Event;)Z
M57:
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	trap	#15
	dc.w	sysTrapFrmHandleEvent
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
; native Method palmos/Palm.FrmInitForm(I)I
M58:
	link	a6,#0
	move.w	10(a6),-(a7)
	trap	#15
	dc.w	sysTrapFrmInitForm
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.FrmSetActiveForm(I)V
M59:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapFrmSetActiveForm
	unlk	a6
	rts
; native Method palmos/Palm.MemHandleLock(I)I
M60:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapMemHandleLock
	move.l	a0,d0
	unlk	a6
	rts
; native Method palmos/Palm.MemHandleSize(I)I
M61:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapMemHandleSize
	unlk	a6
	rts
; native Method palmos/Palm.MemHandleUnlock(I)I
M62:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapMemHandleUnlock
	ext.l	d0
	unlk	a6
	rts
; native Method palmos/Palm.MenuHandleEvent(ILpalmos/Event;Lpalmos/ShortHolder;)Z
M63:
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	trap	#15
	dc.w	sysTrapMenuHandleEvent
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
; native Method palmos/Palm.SysHandleEvent(Lpalmos/Event;)Z
M64:
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapSysHandleEvent
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
; Method palmos/ShortHolder.<init>()V
M65:
	link	a6,#0
	pea	M65__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M65__stackOK
	bsr     throw_StackOverflowError
M65__stackOK
	clr.l	d0
	move.l	8(a6),a0
	move.w	d0,(a0)
	unlk	a6
	rts
M65__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method palmos/ShortHolder.<init>(S)V
M66:
	link	a6,#0
	pea	M66__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M66__stackOK
	bsr     throw_StackOverflowError
M66__stackOK
	move.l	8(a6),d0
	move.l	12(a6),a0
	move.w	d0,(a0)
	unlk	a6
	rts
M66__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method palmos/Event.formID()S
M68:
	link	a6,#0
	pea	M68__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M68__stackOK
	bsr     throw_StackOverflowError
M68__stackOK
	move.l	8(a6),a0
	move.w	8(a0),d0
	ext.l	d0
	unlk	a6
	rts
M68__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/RuntimeException.<init>(Ljava/lang/String;)V
M71:
	link	a6,#0
	pea	M71__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M71__stackOK
	bsr     throw_StackOverflowError
M71__stackOK
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	bsr	M17	; (direct)Method java/lang/Exception.<init>(Ljava/lang/String;)V
	unlk	a6
	rts
M71__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.<init>(Ljava/lang/StringBuffer;)V
M72:
	link	a6,#0
	pea	M72__exceptions(pc)
	move.l	d7,-(a7)
	move.l	12(a6),d7	; arg 0
	cmp.l	StackLimit(a5),a7
	bcc.s	M72__stackOK
	bsr     throw_StackOverflowError
M72__stackOK
	move.l	8(a6),a0
	bsr     nonnull_check
	move.l	4(a0),d0
	move.l	d7,a0
	move.l	d0,4(a0)
	move.l	4(a0),-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7)+,d0
	move.l	d7,a0
	move.l	d0,(a0)
	tst.l	4(a0)
	ble	M72__43
	move.l	8(a6),-(a7)
	clr.l	-(a7)
	move.l	8(a6),a0
	move.l	4(a0),-(a7)
	move.l	d7,a0
	move.l	(a0),-(a7)
	clr.l	-(a7)
	bsr	M37	; (direct)Method java/lang/StringBuffer.getChars(II[CI)V
	lea	20(a7),a7
M72__43:
	move.l	-8(a6),d7
	unlk	a6
	rts
M72__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.<init>([C)V
M73:
	link	a6,#0
	pea	M73__exceptions(pc)
	move.l	d7,-(a7)
	move.l	12(a6),d7	; arg 0
	cmp.l	StackLimit(a5),a7
	bcc.s	M73__stackOK
	bsr     throw_StackOverflowError
M73__stackOK
	move.l	8(a6),a0
	bsr     nonnull_check
	clr.l	d0
	move.w	Array.length(a0),d0
	move.l	d7,a0
	move.l	d0,4(a0)
	move.l	4(a0),-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7)+,d0
	move.l	d7,a0
	move.l	d0,(a0)
	move.l	8(a6),-(a7)
	clr.l	-(a7)
	move.l	(a0),-(a7)
	clr.l	-(a7)
	move.l	8(a6),a0
	move.w	Array.length(a0),-(a7)
	clr.w	-(a7)
	bsr	M84	; (direct)Method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
	move.l	-8(a6),d7
	unlk	a6
	rts
M73__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.toString()Ljava/lang/String;
M74:
	link	a6,#0
	pea	M74__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M74__stackOK
	bsr     throw_StackOverflowError
M74__stackOK
	move.l	8(a6),a0	; return in a0
	unlk	a6
	rts
M74__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.length()I
M75:
	link	a6,#0
	pea	M75__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M75__stackOK
	bsr     throw_StackOverflowError
M75__stackOK
	move.l	8(a6),a0
	move.l	4(a0),d0
	unlk	a6
	rts
M75__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.getChars(II[CI)V
M76:
	link	a6,#0
	pea	M76__exceptions(pc)
	movem.l	d7-d3,-(a7)
	move.l	20(a6),d4	; arg 1
	move.l	16(a6),d3	; arg 2
	clr.l	d7	; local 6
	clr.l	d6	; local 7
	clr.l	d5	; local 8
	clr.l	-(a7)
	cmp.l	StackLimit(a5),a7
	bcc.s	M76__stackOK
	bsr     throw_StackOverflowError
M76__stackOK
	tst.l	d4
	blt	M76__33
	move.l	d4,d0
	cmp.l	d3,d0
	bgt	M76__33
	move.l	d3,d0
	move.l	24(a6),a0
	cmp.l	4(a0),d0
	bgt	M76__33
	tst.l	8(a6)
	blt	M76__33
	move.l	8(a6),-(a7)
	move.l	d3,d0
	sub.l	d4,d0
	add.l	d0,(a7)
	move.l	12(a6),a0
	bsr     nonnull_check
	clr.l	d0
	move.w	Array.length(a0),d0
	cmp.l	(a7)+,d0
	bge	M76__41
M76__33:
	move.l	#32,d0	; Class java/lang/StringIndexOutOfBoundsException
	bsr     op_new
	bsr     op_athrow
M76__41:
	move.l	d3,d0
	sub.l	d4,d0
	move.l	d0,-28(a6)
	clr.l	d7
	move.l	d4,d0
	move.l	24(a6),a0
	add.l	8(a0),d0
	move.l	d0,d6
	move.l	8(a6),d5
M76__61:
	move.l	d7,d0
	cmp.l	-28(a6),d0
	bge	M76__91
	move.l	d5,-(a7)
	move.l	24(a6),a0
; removed
	move.l	d6,d0
	move.l	(a0),a0
	bsr     array_check
	adda.l	d0,a1
	clr.l	d0
	move.b	(a1),d0
	move.l	d0,d2
	move.l	(a7)+,d0
	move.l	12(a6),a0
	bsr     array_check
	move.b	d2,0(a1,d0.l)
	add.l	#1,d7
	add.l	#1,d6
	add.l	#1,d5
	bra	M76__61
M76__91:
	movem.l	-24(a6),d7-d3
	unlk	a6
	rts
M76__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.toCharArray()[C
M77:
	link	a6,#0
	pea	M77__exceptions(pc)
	movem.l	d7-d6,-(a7)
	move.l	8(a6),d6	; arg 0
	clr.l	d7	; local 1
	cmp.l	StackLimit(a5),a7
	bcc.s	M77__stackOK
	bsr     throw_StackOverflowError
M77__stackOK
	move.l	d6,a0
	move.l	4(a0),-(a7)
	move.l	#26,d0
	move.l	#1,d1
	bsr     op_newarray
	move.l	(a7)+,d7
	move.l	d6,a0
	move.l	(a0),-(a7)
	move.l	8(a0),-(a7)
	move.l	d7,-(a7)
	clr.l	-(a7)
	move.l	4(a0),-(a7)
	bsr	M84	; (direct)Method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
	move.l	d7,a0	; return in a0
	movem.l	-12(a6),d7-d6
	unlk	a6
	rts
M77__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/String.valueOf(Ljava/lang/Object;)Ljava/lang/String;
M78:
	link	a6,#0
	pea	M78__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M78__stackOK
	bsr     throw_StackOverflowError
M78__stackOK
	tst.l	8(a6)
	bne	M78__9
	pea	CS7(a5)	; "null"
	bra	M78__13
M78__9:
	move.l	8(a6),-(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr     getclassinfo_a0
	move.l	ClassInfo.Vtable(a0),a0
	lea	__Startup__(pc),a1
	add.l	a1,a0
	clr.l	d0
	move.w	0(a0),d0
	jsr	0(a1,d0.l)	; ...Method java/lang/Object.toString()Ljava/lang/String;
	move.l	a0,(a7)
M78__13:
	move.l	(a7)+,a0
	unlk	a6
	rts
M78__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method java/lang/String.valueOf(I)Ljava/lang/String;
M79:
	bra     M27
; Method java/lang/Float.<clinit>()V
M80:
	link	a6,#0
	pea	M80__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M80__stackOK
	bsr     throw_StackOverflowError
M80__stackOK
	pea	CS8(a5)	; "float"
	bsr	M20	; (direct)Method java/lang/Class.getPrimitiveClass(Ljava/lang/String;)Ljava/lang/Class;
	addq.l	#4,a7
	move.l	a0,d0
	unlk	a6
	rts
M80__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/Double.<clinit>()V
M81:
	link	a6,#0
	pea	M81__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M81__stackOK
	bsr     throw_StackOverflowError
M81__stackOK
	pea	CS9(a5)	; "double"
	bsr	M20	; (direct)Method java/lang/Class.getPrimitiveClass(Ljava/lang/String;)Ljava/lang/Class;
	addq.l	#4,a7
	move.l	a0,d0
	unlk	a6
	rts
M81__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/System.<clinit>()V
M83:
	link	a6,#0
	pea	M83__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M83__stackOK
	bsr     throw_StackOverflowError
M83__stackOK
	unlk	a6
	rts
M83__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
M84:
	move.l  4(a7),d2
	move.l  8(a7),d1
	move.l  12(a7),a1
	move.l  16(a7),d0
	move.l  20(a7),a0
	move.l	d3,-(a7)
	tst.l   d2
	beq.s   arraycopy_out
	cmp.w   Array.length(a0),d0
	bcc     arraycopy_out
	move.l  d0,d3
	add.l   d2,d3
	cmp.w   Array.length(a0),d3
	bhi.s   arraycopy_out
	cmp.w   Array.length(a1),d1
	bcc.s   arraycopy_out
	move.l  d1,d3
	add.l   d2,d3
	cmp.w   Array.length(a1),d3
	bhi.s   arraycopy_out
	mulu    Array.elsize(a0),d2
	mulu    Array.elsize(a0),d0
	mulu    Array.elsize(a0),d1
	move.l  Array.data(a0),a0
	add.l   d0,a0
	move.l  Array.data(a1),a1
	add.l   d1,a1
	cmpa.l	a0,a1
	bcs.s	arraycopy_4	; upward
	add.l	d2,a0		; add length
	add.l	d2,a1
	bra.s	arraycopy_2	; downward
arraycopy_1
	move.b	-(a0),-(a1)
arraycopy_2
	dbra	d2,arraycopy_1
	bra.s	arraycopy_out
arraycopy_3
	move.b	(a0)+,(a1)+
arraycopy_4
	dbra	d2,arraycopy_3
arraycopy_out:
	move.l (a7)+,d3
	rts
; Method java/lang/IndexOutOfBoundsException.<init>(Ljava/lang/String;)V
M89:
	link	a6,#0
	pea	M89__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M89__stackOK
	bsr     throw_StackOverflowError
M89__stackOK
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	bsr	M71	; (direct)Method java/lang/RuntimeException.<init>(Ljava/lang/String;)V
	unlk	a6
	rts
M89__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringIndexOutOfBoundsException.<init>(I)V
M91:
	link	a6,#0
	pea	M91__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M91__stackOK
	bsr     throw_StackOverflowError
M91__stackOK
	move.l	12(a6),-(a7)
	move.l	#14,d0	; Class java/lang/StringBuffer
	bsr     op_new
	move.l	(a7),-(a7)
	pea	CS10(a5)	; "String index out of range: "
	bsr	M31	; (direct)Method java/lang/StringBuffer.<init>(Ljava/lang/String;)V
	addq.l	#8,a7
	move.l	8(a6),-(a7)
	bsr	M33	; (direct)Method java/lang/StringBuffer.append(I)Ljava/lang/StringBuffer;
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	(a7),a0
	bsr     nonnull_check
	bsr	M40	; (direct)Method java/lang/StringBuffer.toString()Ljava/lang/String;
	move.l	a0,(a7)
	bsr	M89	; (direct)Method java/lang/IndexOutOfBoundsException.<init>(Ljava/lang/String;)V
	unlk	a6
	rts
M91__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method java/lang/StringIndexOutOfBoundsException.<init>(Ljava/lang/String;)V
M92:
	link	a6,#0
	pea	M92__exceptions(pc)
	cmp.l	StackLimit(a5),a7
	bcc.s	M92__stackOK
	bsr     throw_StackOverflowError
M92__stackOK
	move.l	12(a6),-(a7)
	move.l	8(a6),-(a7)
	bsr	M89	; (direct)Method java/lang/IndexOutOfBoundsException.<init>(Ljava/lang/String;)V
	unlk	a6
	rts
M92__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; Method palmos/JumpLog.writeRecord(IILjava/lang/String;)Z
M93:
	link	a6,#0
	pea	M93__exceptions(pc)
	movem.l	d7-d3,-(a7)
	move.l	12(a6),d3	; arg 1
	clr.l	d4	; local 3
	clr.l	d7	; local 4
	clr.l	d6	; local 5
	clr.l	d5	; local 6
	clr.l	-(a7)
	clr.l	-(a7)
	cmp.l	StackLimit(a5),a7
	bcc.s	M93__stackOK
	bsr     throw_StackOverflowError
M93__stackOK
	move.l	8(a6),a0
	bsr     nonnull_check
	move.l	4(a0),d4
	move.l	16(a6),-(a7)
	move.l	d3,-(a7)
	bsr	M48	; (direct)Method palmos/Palm.DmQueryRecord(II)I
	addq.l	#8,a7
	move.l	d0,d7
	; avoided 	tst.l	d7
	beq	M93__183
	move.l	d7,-(a7)
	bsr	M60	; (direct)Method palmos/Palm.MemHandleLock(I)I
	addq.l	#4,a7
	move.l	d0,d6
	move.l	d6,-(a7)
	bsr	M41	; (direct)Method palmos/Palm.nativeGetInt(I)I
	addq.l	#4,a7
	cmp.l	#1249209712,d0
	bne	M93__177
	move.l	d6,d0
	add.l	#4,d0
	move.l	d0,-(a7)
	bsr	M41	; (direct)Method palmos/Palm.nativeGetInt(I)I
	addq.l	#4,a7
	cmp.l	#543977319,d0
	bne	M93__177
	move.l	d6,d0
	add.l	#8,d0
	move.l	d0,-(a7)
	bsr	M42	; (direct)Method palmos/Palm.nativeGetByte(I)I
	addq.l	#4,a7
	cmp.l	#10,d0
	bne	M93__177
	move.l	d7,-(a7)
	bsr	M61	; (direct)Method palmos/Palm.MemHandleSize(I)I
	addq.l	#4,a7
	sub.l	#1,d0
	move.l	d0,d5
	move.b	SF2(a5),d0
	beq	M93__84
	move.l	d5,d0
	add.l	d4,d0
	cmp.l	#8000,d0
	blt	M93__88
M93__84:
	move.l	#9,d0
	move.l	d0,d5
M93__88:
	move.l	d5,d0
	add.l	d4,d0
	add.l	#2,d0
	move.l	d0,-28(a6)
	move.l	d7,-(a7)
	bsr	M62	; (direct)Method palmos/Palm.MemHandleUnlock(I)I
	move.l	16(a6),(a7)
	move.l	d3,-(a7)
	move.l	-28(a6),-(a7)
	bsr	M50	; (direct)Method palmos/Palm.DmResizeRecord(III)I
	lea	12(a7),a7
	move.l	d0,-32(a6)
	move.l	16(a6),-(a7)
	move.l	d3,-(a7)
	bsr	M44	; (direct)Method palmos/Palm.DmGetRecord(II)I
	addq.l	#8,a7
	move.l	d0,d7
	move.l	d7,-(a7)
	bsr	M60	; (direct)Method palmos/Palm.MemHandleLock(I)I
	addq.l	#4,a7
	move.l	d0,d6
	move.l	d6,-(a7)
	move.l	d5,-(a7)
	move.l	8(a6),-(a7)
	move.l	d4,-(a7)
	bsr	M51	; (direct)Method palmos/Palm.DmWrite(IILjava/lang/Object;I)I
	lea	16(a7),a7
	move.l	d6,-(a7)
	move.l	d5,d0
	add.l	d4,d0
	move.l	d0,-(a7)
	pea	CS11(a5)	; " "
	pea	2
	bsr	M51	; (direct)Method palmos/Palm.DmWrite(IILjava/lang/Object;I)I
	lea	16(a7),a7
	move.l	d7,-(a7)
	bsr	M62	; (direct)Method palmos/Palm.MemHandleUnlock(I)I
	move.l	16(a6),(a7)
	move.l	d3,-(a7)
	pea	1
	bsr	M49	; (direct)Method palmos/Palm.DmReleaseRecord(IIZ)I
	lea	12(a7),a7
	move.l	-28(a6),d0
	sub.l	#1,d0
	move.l	d0,d5
	move.l	d3,d0
	move.l	d0,SF0(a5)
	move.l	#1,d0
	move.b	d0,SF2(a5)
	move.l	#1,d0
	movem.l	-24(a6),d7-d3
	unlk	a6
	rts
M93__177:
	move.l	d7,-(a7)
	bsr	M62	; (direct)Method palmos/Palm.MemHandleUnlock(I)I
	addq.l	#4,a7
M93__183:
	clr.l	d0
	movem.l	-24(a6),d7-d3
	unlk	a6
	rts
M93__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
; native Method palmos/JumpLog.reporter(Ljava/lang/String;)V
M94:
	rts
; Method palmos/JumpLog.println(Ljava/lang/String;)V
M95:
	link	a6,#0
	pea	M95__exceptions(pc)
	movem.l	d7-d3,-(a7)
	move.l	8(a6),d3	; arg 0
	clr.l	d7	; local 1
	clr.l	d6	; local 2
	clr.l	d4	; local 4
	clr.l	d5	; local 5
	clr.l	-(a7)
	clr.l	-(a7)
	cmp.l	StackLimit(a5),a7
	bcc.s	M95__stackOK
	bsr     throw_StackOverflowError
M95__stackOK
	move.l	SF1(a5),d7
	; avoided 	tst.l	SF1(a5)
	bne	M95__19
	move.l	#1145132097,-(a7)
	move.l	#1835363695,-(a7)
	pea	3
	bsr	M47	; (direct)Method palmos/Palm.DmOpenDatabaseByTypeCreator(III)I
	lea	12(a7),a7
	move.l	d0,d7
M95__19:
	tst.l	d7
	beq	M95__143
	move.l	d7,-(a7)
	move.l	SF0(a5),-(a7)
	move.l	d3,-(a7)
	bsr	M93	; (direct)Method palmos/JumpLog.writeRecord(IILjava/lang/String;)Z
	lea	12(a7),a7
	tst.l	d0
	bne	M95__132
	move.l	d7,-(a7)
	bsr	M46	; (direct)Method palmos/Palm.DmNumRecords(I)I
	addq.l	#4,a7
	move.l	d0,-28(a6)
	move.l	-28(a6),d6
M95__41:
	sub.l	#1,d6
	tst.l	d6
	blt	M95__60
	move.l	d7,-(a7)
	move.l	d6,-(a7)
	move.l	d3,-(a7)
	bsr	M93	; (direct)Method palmos/JumpLog.writeRecord(IILjava/lang/String;)Z
	lea	12(a7),a7
	tst.l	d0
	bne	M95__60
	bra	M95__41
M95__60:
	tst.l	d6
	bge	M95__132
	move.l	#16,d0	; Class palmos/ShortHolder
	bsr     op_new
	move.l	(a7),-(a7)
	bsr	M65	; (direct)Method palmos/ShortHolder.<init>()V
	addq.l	#4,a7
	move.l	(a7)+,d4
	move.l	d7,-(a7)
	move.l	d4,-(a7)
	pea	10
	bsr	M45	; (direct)Method palmos/Palm.DmNewRecord(ILpalmos/ShortHolder;I)I
	lea	12(a7),a7
	move.l	d0,d5
	; avoided 	tst.l	d5
	beq	M95__132
	move.l	d5,-(a7)
	bsr	M60	; (direct)Method palmos/Palm.MemHandleLock(I)I
	addq.l	#4,a7
	move.l	d0,-32(a6)
	move.l	-32(a6),-(a7)
	clr.l	-(a7)
	pea	CS12(a5)	; "Jump log "
	pea	10
	bsr	M51	; (direct)Method palmos/Palm.DmWrite(IILjava/lang/Object;I)I
	lea	16(a7),a7
	move.l	d5,-(a7)
	bsr	M62	; (direct)Method palmos/Palm.MemHandleUnlock(I)I
	addq.l	#4,a7
	move.l	d4,a0
	move.w	(a0),d0
	ext.l	d0
	move.l	d0,d6
	move.l	d7,-(a7)
	move.l	d6,-(a7)
	pea	1
	bsr	M49	; (direct)Method palmos/Palm.DmReleaseRecord(IIZ)I
	lea	12(a7),a7
	move.l	d7,-(a7)
	move.l	d6,-(a7)
	move.l	d3,-(a7)
	bsr	M93	; (direct)Method palmos/JumpLog.writeRecord(IILjava/lang/String;)Z
	lea	12(a7),a7
M95__132:
	tst.l	SF1(a5)
	bne	M95__143
	move.l	d7,-(a7)
	bsr	M43	; (direct)Method palmos/Palm.DmCloseDatabase(I)I
	addq.l	#4,a7
M95__143:
	move.l	d3,-(a7)
	bsr	M94	; (direct)Method palmos/JumpLog.reporter(Ljava/lang/String;)V
	movem.l	-24(a6),d7-d3
	unlk	a6
	rts
M95__exceptions:
	move.l	4(a6),d2
	unlk	a6
	move.l	-4(a6),a1
	jmp	(a1)	; previous exception handler
	code
ClassCount	equ	37
ClassInfo_size	equ	ClassInfo_basesize+0
	align	2
ClassTable:
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	-1	; (no superclass)
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class0__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class1__name
	dc.l	class1__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class2__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	4	; java/lang/VirtualMachineError
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class3__name
	dc.l	class3__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	5	; java/lang/Error
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class4__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	6	; java/lang/Throwable
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class5__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class6__name
	dc.l	class6__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	6	; java/lang/Throwable
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class7__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_interface
	dc.w	0	; no def constructor
	dc.w	class8__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_interface
	dc.w	0	; no def constructor
	dc.w	class9__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	11	; java/lang/Number
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class10__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class11__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_interface
	dc.w	0	; no def constructor
	dc.w	class12__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	-1	; (no superclass)
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_primitive
	dc.w	0	; no def constructor
	dc.w	class13__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+10
	dc.b	0,0
	dc.w	M29	; def constructor
	dc.w	class14__name
	dc.l	class14__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class15__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+2
	dc.b	0,0
	dc.w	M65	; def constructor
	dc.w	class16__name
	dc.l	class16__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	-1	; (no superclass)
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_primitive
	dc.w	0	; no def constructor
	dc.w	class17__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+24
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class18__name
	dc.l	class18__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	-1	; (no superclass)
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_primitive
	dc.w	0	; no def constructor
	dc.w	class19__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	-1	; (no superclass)
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,ClassInfo_primitive
	dc.w	0	; no def constructor
	dc.w	class20__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	22	; java/lang/RuntimeException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class21__name
	dc.l	class21__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	7	; java/lang/Exception
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class22__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+12
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class23__name
	dc.l	class23__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	11	; java/lang/Number
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class24__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	11	; java/lang/Number
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class25__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+8
	dc.b	0,ClassInfo_array
	dc.w	M_none	; def constructor
	dc.w	class26__name
	dc.l	class26__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	22	; java/lang/RuntimeException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class27__name
	dc.l	class27__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class28__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	22	; java/lang/RuntimeException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class29__name
	dc.l	class29__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	31	; java/lang/IndexOutOfBoundsException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class30__name
	dc.l	class30__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	22	; java/lang/RuntimeException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class31__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	31	; java/lang/IndexOutOfBoundsException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class32__name
	dc.l	class32__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	0	; java/lang/Object
	dc.w	ObjectHeader_sizeof+0
	dc.b	0,0
	dc.w	0	; no def constructor
	dc.w	class33__name
	dc.l	0		; no vtable
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	22	; java/lang/RuntimeException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class34__name
	dc.l	class34__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	22	; java/lang/RuntimeException
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class35__name
	dc.l	class35__vtable-0
	dc.w	0,0,0,0		; no itable index
	dc.w	1		; ObjectHeader_ClassIndex: java/lang/Class
	dc.w	4	; java/lang/VirtualMachineError
	dc.w	ObjectHeader_sizeof+36
	dc.b	0,0
	dc.w	M_none	; def constructor
	dc.w	class36__name
	dc.l	class36__vtable-0
	dc.w	0,0,0,0		; no itable index
	code
class0__name	dc.b	'java.lang.Object',0
	align	2
class1__name	dc.b	'java.lang.Class',0
	align	2
class1__vtable:
	dc.w	M24	; Method java/lang/Class.toString()Ljava/lang/String;
class2__name	dc.b	'Hello',0
	align	2
class3__name	dc.b	'java.lang.OutOfMemoryError',0
	align	2
class3__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class4__name	dc.b	'java.lang.VirtualMachineError',0
	align	2
class5__name	dc.b	'java.lang.Error',0
	align	2
class6__name	dc.b	'java.lang.Throwable',0
	align	2
class6__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class7__name	dc.b	'java.lang.Exception',0
	align	2
class8__name	dc.b	'java.lang.Cloneable',0
	align	2
class9__name	dc.b	'java.io.Serializable',0
	align	2
class10__name	dc.b	'java.lang.Integer',0
	align	2
class11__name	dc.b	'java.lang.Number',0
	align	2
class12__name	dc.b	'java.lang.Comparable',0
	align	2
class13__name	dc.b	'-I-',0
	align	2
class14__name	dc.b	'java.lang.StringBuffer',0
	align	2
class14__vtable:
	dc.w	M40	; Method java/lang/StringBuffer.toString()Ljava/lang/String;
class15__name	dc.b	'palmos.Palm',0
	align	2
class16__name	dc.b	'palmos.ShortHolder',0
	align	2
class16__vtable:
	dc.w	M6	; Method java/lang/Object.toString()Ljava/lang/String;
class17__name	dc.b	'-S-',0
	align	2
class18__name	dc.b	'palmos.Event',0
	align	2
class18__vtable:
	dc.w	M6	; Method java/lang/Object.toString()Ljava/lang/String;
class19__name	dc.b	'-B-',0
	align	2
class20__name	dc.b	'-Z-',0
	align	2
class21__name	dc.b	'java.lang.NullPointerException',0
	align	2
class21__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class22__name	dc.b	'java.lang.RuntimeException',0
	align	2
class23__name	dc.b	'java.lang.String',0
	align	2
class23__vtable:
	dc.w	M74	; Method java/lang/String.toString()Ljava/lang/String;
class24__name	dc.b	'java.lang.Float',0
	align	2
class25__name	dc.b	'java.lang.Double',0
	align	2
class26__name	dc.b	'[C',0
	align	2
class26__vtable:
	dc.w	M6	; Method java/lang/Object.toString()Ljava/lang/String;
class27__name	dc.b	'java.lang.NegativeArraySizeException',0
	align	2
class27__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class28__name	dc.b	'java.lang.System',0
	align	2
class29__name	dc.b	'java.lang.ArithmeticException',0
	align	2
class29__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class30__name	dc.b	'java.lang.ArrayIndexOutOfBoundsException',0
	align	2
class30__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class31__name	dc.b	'java.lang.IndexOutOfBoundsException',0
	align	2
class32__name	dc.b	'java.lang.StringIndexOutOfBoundsException',0
	align	2
class32__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class33__name	dc.b	'palmos.JumpLog',0
	align	2
class34__name	dc.b	'java.lang.ArrayStoreException',0
	align	2
class34__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class35__name	dc.b	'java.lang.ClassCastException',0
	align	2
class35__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
class36__name	dc.b	'java.lang.StackOverflowError',0
	align	2
class36__vtable:
	dc.w	M12	; Method java/lang/Throwable.toString()Ljava/lang/String;
	code
init_constant_strings:
	lea.l	cstring_block(pc),a0
	move.l	a0,cstring_array_data(a5)
	lea.l	cstring_array(a5),a0
	lea.l	CS0_value(a5),a1
	move.w	#12,d0
init_constant_strings_loop
	move.l	a0,(a1)
	lea.l	CS_SIZE(a1),a1
	dbra	d0,init_constant_strings_loop
	rts
cstring_block
	dc.b	$3a,$20, 0
	dc.b	$2a,$2a,$2a,$20,$45,$78,$63,$65,$70,$74,$69,$6f,$6e,$20,$2a,$2a
	dc.b	$2a,$20, 0
	dc.b	$73,$74,$61,$63,$6b,$20,$74,$72,$61,$63,$65,$3a, 0
	dc.b	$69,$6e,$74,$65,$72,$66,$61,$63,$65,$20, 0
	dc.b	0
	dc.b	$63,$6c,$61,$73,$73,$20, 0
	dc.b	$53,$74,$72,$69,$6e,$67,$42,$75,$66,$66,$65,$72,$2e,$67,$65,$74
	dc.b	$43,$68,$61,$72,$73,$28,$29,$3a,$20,$62,$65,$67,$69,$6e,$20,$3e
	dc.b	$20,$65,$6e,$64, 0
	dc.b	$6e,$75,$6c,$6c, 0
	dc.b	$66,$6c,$6f,$61,$74, 0
	dc.b	$64,$6f,$75,$62,$6c,$65, 0
	dc.b	$53,$74,$72,$69,$6e,$67,$20,$69,$6e,$64,$65,$78,$20,$6f,$75,$74
	dc.b	$20,$6f,$66,$20,$72,$61,$6e,$67,$65,$3a,$20, 0
	dc.b	$a, 0
	dc.b	$4a,$75,$6d,$70,$20,$6c,$6f,$67,$a, 0
	align	2
	res 'tver', 1, "tver0001.bin"
	res 'tAIB', 1000, "tAIB03e8.bin"
	res 'tFRM', 1000, "tFRM03e8.bin"
	data
	
lastGCTime		dc.w	0
heapRoot		dc.l	0	; root of binary tree
heapBlocks		dc.l	0	; first	block in address order
heapMinAddress	equ		heapBlocks	; lowest address
heapMaxAddress	dc.l	0
heapBlockCount	dc.w	0	; number of	blocks allocated
heapStackMargin	dc.l	0	; stack	limit with safety margin
heapNeedsScan	dc.b	0	; != 0 means a GC heap scan	is required
heapLocked		dc.b	0	; != 0 means can't allocate	(eg	in finalize)
	align	2
freeList8		dc.l	0
freeList16		dc.l	0
freeList24		dc.l	0
freeList32		dc.l	0
freeList40		dc.l	0
freeList48		dc.l	0
freeList56		dc.l	0
freeList64		dc.l	0
freeListSmall	dc.l	0
freeListLarge	dc.l	0
currentException	dc.l	0
exceptionPC		dc.l	0
	ds.w	1   ; class index
DummyCharArray
	ds.w	1   ; length
	ds.w	1   ; elsize
	ds.l	1   ; data array
StackEnd	ds.l	1
StackLimit	ds.l	1
StaticObjects:
OutOfMemoryError_obj	ds.l	1	; for exception handling
SOF0	ds.l	1	; java/lang/Integer.digits
SF2	ds.b	1	; palmos/JumpLog.appendNext
SF3	ds.b	1	; palmos/JumpLog.traceInitialized
	align	2
SF0	ds.l	1	; palmos/JumpLog.recNum
SF1	ds.l	1	; palmos/JumpLog.memoHandle
integer_toString_buffer:
	ds.b	20
nSegments:	dc.w	1
SegStart1:	dc.l	0
SegHandle1:	dc.l	0
	dc.w	26
cstring_array:
	dc.w	149	; length
	dc.w	1	; elsize
cstring_array_data:
	dc.l	0	; data
	dc.w	23
CS0:
CS0_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	2	; 'count' String length
	dc.l	0	; 'offset' within cstring_array
	dc.w	23
CS1:
CS1_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	18	; 'count' String length
	dc.l	3	; 'offset' within cstring_array
	dc.w	23
CS2:
CS2_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	12	; 'count' String length
	dc.l	22	; 'offset' within cstring_array
	dc.w	23
CS3:
CS3_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	10	; 'count' String length
	dc.l	35	; 'offset' within cstring_array
	dc.w	23
CS4:
CS4_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	0	; 'count' String length
	dc.l	46	; 'offset' within cstring_array
	dc.w	23
CS5:
CS5_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	6	; 'count' String length
	dc.l	47	; 'offset' within cstring_array
	dc.w	23
CS6:
CS6_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	36	; 'count' String length
	dc.l	54	; 'offset' within cstring_array
	dc.w	23
CS7:
CS7_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	4	; 'count' String length
	dc.l	91	; 'offset' within cstring_array
	dc.w	23
CS8:
CS8_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	5	; 'count' String length
	dc.l	96	; 'offset' within cstring_array
	dc.w	23
CS9:
CS9_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	6	; 'count' String length
	dc.l	102	; 'offset' within cstring_array
	dc.w	23
CS10:
CS10_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	27	; 'count' String length
	dc.l	109	; 'offset' within cstring_array
	dc.w	23
CS11:
CS11_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	1	; 'count' String length
	dc.l	137	; 'offset' within cstring_array
	dc.w	23
CS12:
CS12_value:
	dc.l	0	; 'value' points to cstring_array
	dc.l	9	; 'count' String length
	dc.l	139	; 'offset' within cstring_array
CS_NUM	equ	13
CS_SIZE	equ	ClassHeader_sizeof+12
DataSize	ds.w	0
	end
