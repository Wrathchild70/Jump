; Jump2 native support routines

; native method support for callbacks

;; native-method palmos/FormEventHandler.<init>()V
;; uses-method palmos/FormEventHandler.dispatch(Lpalmos/Event;)Z as __Dispatch
;; needs-exact-layout palmos/FormEventHandler
    ; event callback support
    move.l  4(a7),a0            ; this
    lea     frmcallbackvector(pc),a1
    move.l  #$487AFFFE,(a0)+    ; pea *+(pc)
    move.w  #$4EF9,(a0)+        ; jump op-code
    move.l  a1,(a0)             ; jump address
    rts
frmcallbackvector
    ; first parameter pushed by code in the object (pea)
    move.l  8(a7),-(a7)         ; second parameter (Event)
    mem.reserve
    bsr.far __Dispatch
    addq.l  #8,a7
    mem.release.savereg
    rts

;; native-method palmos/WakeupHandler.<init>()V
;; uses-method palmos/WakeupHandler.dispatch(I)V as __Dispatch
;; needs-exact-layout palmos/WakeupHandler
    ; event callback support
    move.l  4(a7),a0            ; this
    lea     wakecallbackvector(pc),a1
    move.l  #$487AFFFE,(a0)+    ; pea *+(pc)
    move.w  #$4EF9,(a0)+        ; jump op-code
    move.l  a1,(a0)             ; jump address
    rts
wakecallbackvector
    ; first parameter pushed by code in the object (pea)
    move.l  8(a7),-(a7)         ; second parameter (int)
    mem.reserve
    bsr.far __Dispatch
    addq.l  #8,a7
    mem.release.savereg
    rts

;; native-method palmos/TableDrawItemHandler.<init>()V
;; uses-method palmos/TableDrawItemHandler.dispatch(IIILpalmos/Rectangle;)V as __Dispatch
;; needs-exact-layout palmos/TableDrawItemHandler
    ; event callback support
    move.l  4(a7),a0            ; this
    lea     tbldrawcallbackvector(pc),a1
    move.l  #$487AFFFE,(a0)+    ; pea *+(pc)
    move.w  #$4EF9,(a0)+        ; jump op-code
    move.l  a1,(a0)             ; jump address
    rts
tbldrawcallbackvector
    ; first parameter pushed by code in the object (pea)
    move.l  8(a7),-(a7)         ; second parameter (int table)
    clr.l   d0
    move.w  16(a7),d0
    move.l  d0,-(a7)            ; third parameter  (int row)
    move.w  22(a7),d0
    move.l  d0,-(a7)            ; forth parameter  (int column)
    move.l  28(a7),-(a7)        ; fifth parameter  (Rectangle)
    mem.reserve
    bsr.far __Dispatch
    lea.l  20(a7),a7
    mem.release.savereg
    rts

;; native-method palmos/TableLoadDataHandler.<init>()V
;; uses-method palmos/TableLoadDataHandler.dispatch(IIIZLpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;I)I as __Dispatch
;; needs-exact-layout palmos/TableLoadDataHandler
    ; event callback support
    move.l  4(a7),a0            ; this
    lea     tblloadcallbackvector(pc),a1
    move.l  #$487AFFFE,(a0)+    ; pea *+(pc)
    move.w  #$4EF9,(a0)+        ; jump op-code
    move.l  a1,(a0)             ; jump address
    rts
tblloadcallbackvector
    ; first parameter pushed by code in the object (pea)
    move.l  8(a7),-(a7)         ; second parameter (int table)
    clr.l   d0
    move.w  16(a7),d0
    move.l  d0,-(a7)            ; third parameter  (int row)
    move.w  22(a7),d0
    move.l  d0,-(a7)            ; forth parameter  (int column)
    clr.w   d0
    move.b  28(a7),d0
    move.l  d0,-(a7)            ; fifth parameter  (boolean editable)
    move.l  34(a7),-(a7)        ; sixth parameter  (IntHolder dataHandle)
    move.l  42(a7),-(a7)        ; seventh parameter(ShortHolder dataOffset)
    move.l  50(a7),-(a7)        ; eigth parameter  (ShortHolder dataSize)
    move.l  58(a7),-(a7)        ; ninth parameter  (int fld)
    mem.reserve
    bsr.far __Dispatch
    lea.l  36(a7),a7
    mem.release.savereg
    rts

;; native-method palmos/TableSaveDataHandler.<init>()V
;; uses-method palmos/TableSaveDataHandler.dispatch(III)Z as __Dispatch
;; needs-exact-layout palmos/TableSaveDataHandler
    ; event callback support
    move.l  4(a7),a0            ; this
    lea     tblsavecallbackvector(pc),a1
    move.l  #$487AFFFE,(a0)+    ; pea *+(pc)
    move.w  #$4EF9,(a0)+        ; jump op-code
    move.l  a1,(a0)             ; jump address
    rts
tblsavecallbackvector
    ; first parameter pushed by code in the object (pea)
    move.l  8(a7),-(a7)         ; second parameter (int table)
    clr.l   d0
    move.w  16(a7),d0
    move.l  d0,-(a7)            ; third parameter  (int row)
    move.w  22(a7),d0
    move.l  d0,-(a7)            ; forth parameter  (int column)
    mem.reserve
    bsr.far __Dispatch
    lea.l  16(a7),a7
    mem.release.savereg
    rts

;; native-method palmos/JumpLog.reporter(Ljava/lang/String;)V
;; uses-field palmos/JumpLog.traceInitialized as _JL_flag
#ifdef REPORTER
    move.b  _JL_flag(a5),d0
    bne.s   jl_repinit
    addq.b  #1,_JL_flag(a5)
	move.w	#hostSelectorTraceInit,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	addq.l  #2,a7
jl_repinit
    move.l  4(a7),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
    pea     percent_ess(pc)
    move.w  #$8000,-(a7)
	mem.release
	move.w	#hostSelectorTraceOutputTL,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
    lea     12(a7),a7
	mem.reserve.savereg
    rts
percent_ess dc.b  '%s',0
    align   2
#else
    rts
#endif

