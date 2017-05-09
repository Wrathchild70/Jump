
;; Macro definitions etc.
	
;;; 
;;; ============================================================
;;;     macros supporting multi-segmented code (LARGE model)
;;; ============================================================
;;; 
#ifdef MULTI_SEGMENT
	
; defining the multi-segment bsr.far and bra.far macros
#defmacro bsr.far label
        jsr     to_label(a5)
#endmacro

#defmacro bra.far label
        jmp     to_label(a5)
#endmacro

#else

; defining the single-segment bsr.far and bra.far macros
#defmacro bsr.far label
        bsr     label
#endmacro

#defmacro bra.far label
        bra     label
#endmacro

#endif


;;; 
;;; ============================================================
;;;  macros supporting the data-manager based heap (HUGE model)
;;; ============================================================
;;; 
#ifdef	DM_HEAP

; MemSemaphoreReserve macro (active version)
#defmacro mem.reserve
	systrap	MemSemaphoreReserve(#1.b)
#endmacro
#defmacro mem.reserve.savereg
	movem.l	d0-d2/a0-a1,-(a7)
	systrap	MemSemaphoreReserve(#1.b)
	movem.l	(a7)+,d0-d2/a0-a1
#endmacro

; MemSemaphoreRelease macro (active version)
#defmacro mem.release
	systrap	MemSemaphoreRelease(#1.b)
#endmacro
#defmacro mem.release.savereg
	movem.l	d0-d2/a0-a1,-(a7)
	systrap	MemSemaphoreRelease(#1.b)
	movem.l	(a7)+,d0-d2/a0-a1
#endmacro

; make-proxy macro (active version)
#defmacro proxy.get
	bsr.far	makeproxy
#endmacro

; unproxy macro (active version)
#defmacro proxy.release
	bsr.far	unproxy
#endmacro

#else

; MemSemaphoreReserve macro (dummy version)
#defmacro mem.reserve
#endmacro
#defmacro mem.reserve.savereg
#endmacro

; MemSemaphoreRelease macro (dummy version)
#defmacro mem.release
#endmacro
#defmacro mem.release.savereg
#endmacro

; make-proxy macro (dummy version)
#defmacro proxy.get
#endmacro

; unproxy macro (dummy version)
#defmacro proxy.release
#endmacro

#endif


;;; 
;;; ============================================================
;;;      general-purpose definitions, applying to all modes
;;; ============================================================
;;; 

kidrTVER	equ	1

breakpoint	equ	$4afc

;; used with an offset of 2, this struct can serve as a Class object
;;
;;  --- AastoreCheck ---
;; Check for validity of 'aastore' into this array class.
;; a1 = value's ClassInfo table
;; returns NZ condition if O.K.
;; contains: btst #x,y(a1) / rts
;;
;;  --- Itable ---
;; Variable length packed bit array having '1' bits
;; for all types that this value can be converted to.
;;
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

;;; Flag constants - must fit into low byte!
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

#ifndef OLD_HEAP
ObjectHeader_ChunkSize	equ	-4
ObjectHeader_sizeof		equ	0	; included in requested size
ObjectHeader_extra		equ	4	; hidden overhead
#else
ObjectHeader_sizeof		equ	2	; included in requested size
#endif
ObjectHeader_ClassIndex	equ	-2
ClassHeader_sizeof		equ	2

; keep in sync with Jump's Java source files
; see Klass.java, constructor Klass(String)
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


;;; 
;;; ============================================================
;;; floating-point definitions, mainly from System\NewFloatMgr.h
;;; ============================================================
;;;
	
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

