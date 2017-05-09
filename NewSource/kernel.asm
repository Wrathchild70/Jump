;; kernel-routines

;; 
;; Kernel Routines for Jump2
;; always included into	asm	output
;;

;;;	heap database definition
HeapDbType	equ	'Ohep'

#ifndef	OLD_HEAP
;;;	The	is a new implementation	of the heap	and	garbage
;;;	collector. See NewJumpGarbage.htm for details.

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

; default block	size is	16K	but	can	be 4K, 8K, 32K or MAX
; by setting size options with -DALLOCxxx
#ifdef ALLOCMAX
blockMinSize	equ	blockMaxSize
#else
#ifdef ALLOC32K
blockMinSize	equ	32768-ObjectHeader_extra
#else
#ifdef ALLOC8K
blockMinSize	equ	8192-ObjectHeader_extra
#else
#ifdef ALLOC4K
blockMinSize	equ	4096-ObjectHeader_extra
#else
blockMinSize	equ	16384-ObjectHeader_extra
#endif
#endif
#endif
#endif

proxyBlockHeaderSize	equ	10
proxyMinBlockSize		equ	2000

chunkMarkEmpty			equ	3
chunkMarkedBit			equ	0
chunkPendingBit			equ	1
chunkHasFinalizerBit	equ	2

chunkSizeSmall	equ	192

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

#ifdef DM_HEAP
proxyStackBlock	dc.l	0
proxyStackPtr	dc.l	0
proxyStackSpace	dc.w	0
#endif

#else

;;;	heap structure
heapFirst	equ	0	; pointer to first heap	block
heapCurBlock	equ	4	; pointer to current heap block
heapCurOffset	equ	8	; current offset in	current	heap block
heapMinAddress	equ	10	; min object address in	this heap
heapMaxAddress	equ	14	; max object address in	this heap
heapSpace	equ	18	; word 0=dynSpace, 1=dataSpace
	
;;;	block structure
;;;	********* blockNext	MUST BE	ZERO! ************
;;;	***	blockBitsSize MUST BE A	MULTIPLE OF	16!	***
blockDbExtra	equ	8	; extra	size for database-allocated	blocks
blockDbUniqueID	equ	-8	; only for database-allocated blocks
blockDbHandle	equ	-4	; only for database-allocated blocks
blockNext	equ	0
blockBits	equ	4
blockBitsSize	equ	64
blockBegin	equ	70	; blockBits	+ blockBitsSize	+ abs(chunkStep)
blockUsable	equ	4096
blockSize	equ	blockBegin+blockUsable

bigBlockStep	equ	blockSize+32

;;;	maximum	size for a big block (PalmOS limitation)
bigBlockMaxSize	equ	$ff00

;;;	maximum	size for a chunk
maxChunkSize	equ	$fe80

;;;	chunk structure
chunkStep	equ	-2

newMark		dc.w	0

objectHeap	dc.w	0,0, 0,0, 0, 0,0, 0,0, 1
rawDataHeap	dc.w	0,0, 0,0, 0, 0,0, 0,0, 1

;;;	dynamic-space allocated	heap for proxy-objects
#ifdef DM_HEAP
proxyHeap	dc.w	0,0, 0,0, 0, 0,0, 0,0, 0
#endif
	
#endif	

#ifdef MULTI_SEGMENT
string_data    dc.l    0
#endif

#ifdef DM_HEAP
dbOpenRef	dc.l	0
dbRecNo		dc.w	0
dbRecHandle	dc.l	0
dbRecUID	dc.l	0
#endif

#ifdef CHECK_HEAP
#defmacro	check.heap.start
	bsr		checkHeapStart
#endmacro
#defmacro	check.heap.status
	bsr		checkHeapStatus
#endmacro

	data
traceFlag	dc.w	0
tracePasses	dc.l	0
traceFinalizes  dc.l    0

	code

#ifdef CHECK_USING_HOST_CONTROL
	; open a new window	in Reporter
traceInit
	tst.w	traceFlag(a5)
	bne.s	traceInit_rts
	move.w	#hostSelectorTraceInit,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	addq.l	#2,a7
	addq.w	#1,traceFlag(a5)
traceInit_rts
	rts
	
	; open a new window	in Reporter
traceClose
	tst.w	traceFlag(a5)
	beq.s	traceClose_rts
	move.w	#hostSelectorTraceClose,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	addq.l	#2,a7
	subq.w	#1,traceFlag(a5)
traceClose_rts
	rts
	
	; output C fmt string pointed at by	A0
	; max 2	parms in D0	and	D1 with	new	line
traceOutputL
	move.l	d1,-(a7)
	move.w	#hostSelectorTraceOutputTL,d1
	bra.s	traceOutput_1

	; output C fmt string pointed at by	A0
	; max 2	parms in D0	and	D1
traceOutput
	move.l	d1,-(a7)
	move.w	#hostSelectorTraceOutputT,d1
traceOutput_1
	move.l	d0,-(a7)
	move.l	a0,-(a7)
	move.w	#appErrorClass,-(a7)
	move.w	d1,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	adda.w	#16,a7
	rts
#else
    data
MEMO_TYPE   equ 'DATA'
MEMO_CID    equ 'memo'
traceDbId   dc.l    0
traceDbRecH dc.l    0
traceDbRec  dc.w    0
traceDbLen  dc.l    0
traceBufLen dc.l    0
traceBuffer ds.b    100
    code
traceInit
    moveq.l #-1,d0      ; dmMaxRecordIndex
    move.w  d0,traceDbRec(a5)
    moveq.l #5,d0
    move.l  d0,traceDbLen(a5)
	systrap DmOpenDatabaseByTypeCreator(#MEMO_TYPE.l,#MEMO_CID.l,#dmModeReadWrite.w)
    move.l  a0,traceDbId(a5)
    beq     traceInit_out
    systrap DmNumRecords(a0.l)
    bra.s   traceInit_enter
traceInit_loop
    move.w  d0,-(a7)
    systrap DmQueryRecord(traceDbId(a5).l,d0.w);
    move.l  a0,traceDbRecH(a5)
    beq.s   traceInit_notrec
    systrap MemHandleLock(traceDbRecH(a5).l)
    cmp.l   #'Jump',(a0)
    bne.s   traceInit_notmatch
    cmp.b   #10,4(a0)
    bne.s   traceInit_notmatch
    ; found candidate
    move.w  (a7),traceDbRec(a5)
    clr.w   (a7)   ; force end
traceInit_notmatch
    systrap MemHandleUnlock(traceDbRecH(a5).l)
traceInit_notrec
    move.w  (a7)+,d0
traceInit_enter
    dbra    d0,traceInit_loop
    tst.w   traceDbRec(a5)
    bpl.s   traceInit_close
    systrap DmNewRecord(traceDbId(a5).l,&traceDbRec(a5).l,#6.l)
    move.l  a0,d0
    beq.s   traceInit_close
    move.l  a0,-(a7)
    systrap MemHandleLock(a0.l)
    systrap DmWrite(a0.l,#0.l,&traceJumpTitle(pc).l,#6.l)
    move.l  (a7)+,a0
    systrap MemHandleUnlock(a0.l)
    systrap DmReleaseRecord(traceDbId(a5).l,traceDbRec(a5).w,#1.b);
traceInit_close
	systrap	DmCloseDatabase(traceDbId(a5).l)
traceInit_out
    rts

traceClose
    rts

traceOutputL
    moveq.l #1,d2
    bra.s   traceOutput_common
traceOutput
    clr.l   d2
traceOutput_common
    tst.w   traceDbRec(a5)
    bmi     traceOutput_out
    move.w  d2,-(a7)
    systrap StrPrintF(&traceBuffer(a5).l,a0.l,d0.l,d1.l);
    ext.l   d0
    tst.w   (a7)+
    beq.s   traceOutput_nolf
    lea.l   traceBuffer(a5,d0.w),a0
    move.b  #10,(a0)+
    clr.b   (a0)
    addq.l  #1,d0
traceOutput_nolf
    addq.l  #1,d0   ; nul char
    move.l  d0,traceBufLen(a5)
	systrap DmOpenDatabaseByTypeCreator(#MEMO_TYPE.l,#MEMO_CID.l,#dmModeReadWrite.w)
    move.l  a0,traceDbId(a5)
    beq     traceOutput_out
    move.l  traceDbLen(a5),d0
    cmp.l   #7900,d0
    ble.s   traceOutput_short
    moveq.l #5,d0   ; length too long, cut back to header
    move.l  d0,traceDbLen(a5)
traceOutput_short
    add.l   traceBufLen(a5),d0
    systrap DmResizeRecord(traceDbId(a5).l,traceDbRec(a5).w,d0.l);
    systrap DmGetRecord(traceDbId(a5).l,traceDbRec(a5).w)
    move.l  a0,traceDbRecH(a5)
    beq.s   traceOutput_close
    systrap MemHandleLock(a0.l)
    systrap DmWrite(a0.l,traceDbLen(a5).l,&traceBuffer(a5).l,traceBufLen(a5).l)
    systrap MemHandleUnlock(traceDbRecH(a5).l)
    systrap DmReleaseRecord(traceDbId(a5).l,traceDbRec(a5).w,#1.b);
    move.l  traceBufLen(a5),d0
    subq.l  #1,d0
    add.l   d0,traceDbLen(a5)
traceOutput_close
	systrap	DmCloseDatabase(traceDbId(a5).l)
traceOutput_out
    rts

traceJumpTitle  dc.b    'Jump',10,0
    align   2
#endif

#ifndef	OLD_HEAP
;;;	countFreeList
;;;	OUT
;;;	a1	= pointer to next freelist
;;;	d0	= total	so far
;;;	DOES
;;;	counts free	chunks by following	each
;;;	of the free	list
countFreeList
	clr.l	d0
	moveq.l	#10-1,d1
	lea		freeList8(a5),a1
countFreeList_lloop	
	move.l	a1,a0
	subq.l	#1,d0
countFreeList_cloop
	addq.l	#1,d0
	move.l	(a0),a0
	cmp.w	#0,a0
	bne.s	countFreeList_cloop
	lea		4(a1),a1
	dbra	d1,countFreeList_lloop
	rts
	
;;;	countHeap
;;;	OUT
;;;	d0	= heap blocks
;;;	d1	= normal chunks
;;;	d2	= empty	chunks
;;;	d3	= pending chunks
;;;	d4	= marked chunks
countHeap
	clr.l	d0
	clr.l	d1
	clr.l	d2
	clr.l	d3
	clr.l	d4
	move.l	heapBlocks(a5),a1
	bra.s	countHeap_bentry
countHeap_bloop
	move.l	a1,a0
	moveq.l	#0,d5
	addq.l	#1,d0
	bra.s	countHeap_centry
countHeap_cloop
	move.w	(a0),d5
	btst	#chunkPendingBit,d5
	beq.s	countHeap_nopending
	addq.l	#1,d3	; pending
	btst	#chunkMarkedBit,d5
	beq.s	countHeap_cdone
	subq.l	#1,d3	; un pending
	addq.l	#1,d2	; empty
	bra.s	countHeap_cdone
countHeap_nopending
	addq.l	#1,d1	; normal
	btst	#chunkMarkedBit,d5
	beq.s	countHeap_cdone
	subq.l	#1,d1	; un normal
	addq.l	#1,d2	; marked
countHeap_cdone
	and.w	#$FFF8,d5
	add.l	d5,a0					; to is	always 0
countHeap_centry
	cmp.l	blockTop(a1),a0		; reached top of block?
	bcs.s	countHeap_cloop
	move.l	blockNext(a1),a1	; next block
countHeap_bentry
	cmp.w	#0,a1
	bne.s	countHeap_bloop
	rts
	
; list all the heap blocks in next chain order
showHeapBlocks
    move.l  heapMinAddress(a5),d0
    move.l  heapMaxAddress(a5),d1
    lea.l   showHeapBlocksMsg(pc),a0
    bsr     traceOutputL
    move.l  heapRoot(a5),d0
    lea.l   showHeapRMsg(pc),a0
    bsr     traceOutputL
    move.l  heapBlocks(a5),a1
    bra.s   showHeapBlocks_enter
showHeapBlocks_loop
    move.l  a1,-(a7)
    move.l  a1,d0
    move.l  blockTop(a1),d1
    lea     showHeapBTMsg(pc),a0
    bsr     traceOutput
    move.l  (a7),a1
    move.l  blockLeft(a1),d0
    move.l  blockRight(a1),d1
    lea.l   showHeapLRMsg(pc),a0
    bsr     traceOutputL
    move.l  (a7)+,a1
    move.l  blockNext(a1),a1
showHeapBlocks_enter
    move.l  a1,d0
    bne.s   showHeapBlocks_loop
#ifdef EXTENDED_HEAP_CHECK
    ;
    ; display the inards of the heap
    ;
    lea     showHeapChunkHdr(pc),a0
    bsr     traceOutputL
    move.l  heapRoot(a5),a0
    lea     ObjectHeader_extra(a0),a1
showHeapBlocks_cloop
    clr.l   d0
    move.w  ObjectHeader_ChunkSize(a1),d0
    movem.l d0/a0-a1,-(a7)
    swap    d0
    move.w  ObjectHeader_ClassIndex(a1),d0
    move.l  a1,d1
    sub.l   a0,d1
    lsr.w   #3,d1   ; 1 bit for 8 bytes
    move.w  d1,d2
    lsr.w   #3,d2
    move.l  blockBitmap(a0),a1
    btst    d1,0(a1,d2.w)
    beq.s   showHeapBlocks_notobj
    move.l  #'-*--',d1
    bra.s   showHeapBlocks_show
showHeapBlocks_notobj
    clr.l   d1
showHeapBlocks_show
    lea     showHeapChunk(pc),a0
    bsr     traceOutputL
    movem.l (a7)+,d0/a0-a1
    and.w   #$FFF8,d0
    add.l   d0,a1
    cmp.l   blockTop(a0),a1
    bcs.s   showHeapBlocks_cloop
    ;
    ; dump bitmap
    lea     showHeapBmpHdr(pc),a0
    bsr     traceOutputL
    moveq.l #32-1,d2
    move.l  heapRoot(a5),a0
    move.l  blockTop(a0),a0
showHeapBlock_bloop
    move.l  (a0)+,d0
    move.l  (a0)+,d1
    movem.l d2/a0,-(a7)
    lea     showHeapBmp(pc),a0
    bsr     traceOutputL
    movem.l (a7)+,d2/a0
    dbra    d2,showHeapBlock_bloop
#endif
    rts
	
; check	that the heap is consistent
checkHeapStart
	systrap	TimGetTicks()
	lea		checkHeapStartMsg(pc),a0
	bsr		traceOutputL
	rts

checkHeapStatus
	movem.l	d0-d7/a0-a6,-(a7)
	systrap	TimGetTicks()
	move.l	tracePasses(a5),d1
	lea		checkHeapStopMsg(pc),a0
	bsr		traceOutputL
	move.l  traceFinalizes(a5),d0
	beq.s   checkHeapStatus_nofinalizes
	lea     checkHeapFinalizes(pc),a0
	bsr     traceOutputL
checkHeapStatus_nofinalizes
	bsr		countHeap
	move.l	d4,-(a7)
	move.l	d3,-(a7)
	move.l	d2,-(a7)
	lea		checkHeapBlkMsg(pc),a0
	bsr		traceOutput
	move.l	(a7),d0
	lea		checkHeapEmptyMsg(pc),a0
	bsr		traceOutputL
	; count	items on free list chains
	bsr		countFreeList
	cmp.l	(a7)+,d0		; count	by scanning
	beq.s	checkHeapEnd_freeok
	lea		checkHeapBadFreeMsg(pc),a0
checkHeapEnd_freeok
	; check	there are no pending or	marked chunks
	move.l	(a7)+,d0
	move.l	(a7)+,d1
	move.l	d0,d2
	or.l	d1,d2
	beq.s	checkHeapEnd_rts
	lea		checkHeapPendMsg(pc),a0
	bsr		traceOutputL
checkHeapEnd_rts
	movem.l	(a7)+,d0-d7/a0-a6
	rts

checkHeapStartMsg	dc.b	'GC Start %lu',0
checkHeapStopMsg	dc.b	'Heap status at %lu, %lu scans',0
checkHeapFinalizes  dc.b    'Objects finalized %lu', 0
checkHeapBlkMsg		dc.b	'Blocks %lu, Used chunks %lu, ',0
checkHeapEmptyMsg	dc.b	'Free chunks %lu',0
checkHeapBadFreeMsg	dc.b	'*** Counted free chunks %lu ***',0
checkHeapPendMsg	dc.b	'*** Pending chunks	%lu, Marked	chunks %lu ***',0
	align	2
	
#else	
; count	blocks in heap.	A0 points to heap
countHeapBlocks
	moveq.l	#0,d0
	move.l	heapFirst(a0),a1
	bra.s	countHeapBlocks_2
countHeapBlocks_1
	addq.l	#1,d0
	move.l	blockNext(a1),a1
countHeapBlocks_2
	cmp.w	#0,a1
	bne.s	countHeapBlocks_1
	rts
	
; count	object in heap.	a0 points to heap
; a1 is	current	block, a2 is current chunk
; d0 count of chunks, d1 count of objects
countHeapObjects
	moveq.l	#0,d0
	moveq.l	#0,d1
	move.l	heapFirst(a0),a1
	bra.s	countHeapObjects_2
countHeapObjects_1
	moveq.l	#0,d3		; offset into data
	lea.l	blockBegin(a1),a2
	bra.s	countHeapObjects_1_2
countHeapObjects_1_1
	move.l	d3,d4
	lsr.l	#3,d4		; bit number 1 bit for 8 bytes
	move.l	d4,d5
	lsr.l	#3,d5		; byte offset in bit array
	btst.b	d4,blockBits(a1,d5.l)
	beq.s	countHeapObjects_1_1_1
	addq.l	#1,d1		; valid	object
countHeapObjects_1_1_1
	addq.l	#1,d0		; chunks
	add.l	d2,a2		; next chunk
	add.l	d2,d3		; byte offset
countHeapObjects_1_2
	moveq.l	#0,d2
	move.w	chunkStep(a2),d2
	bne.s	countHeapObjects_1_1
	move.l	blockNext(a1),a1
countHeapObjects_2
	cmp.w	#0,a1
	bne.s	countHeapObjects_1
	rts
	
; count	and	report the number of blocks	in each	heap
countHeaps
	lea.l	objectHeap(a5),a0
	bsr		countHeapBlocks
	lea.l	countHeapsMsgObject(pc),a0
	bsr		traceOutput
	lea.l	objectHeap(a5),a0
	bsr		countHeapObjects
	lea.l	countHeapsMsgObjCount(pc),a0
	bsr		traceOutputL
#ifdef DM_HEAP
	lea.l	proxyHeap(a5),a0
	bsr		countHeapBlocks
	lea.l	countHeapsMsgProxy(pc),a0
	bsr		traceOutput
	lea.l	proxyHeap(a5),a0
	bsr		countHeapObjects
	lea.l	countHeapsMsgObjCount(pc),a0
	bsr		traceOutputL
#endif
	lea.l	rawDataHeap(a5),a0
	bsr		countHeapBlocks
	lea.l	countHeapsMsgRaw(pc),a0
	bsr		traceOutput
	lea.l	rawDataHeap(a5),a0
	bsr		countHeapObjects
	lea.l	countHeapsMsgObjCount(pc),a0
	bsr		traceOutputL
	rts
	
; check	that the heap is consistent
checkHeapStart
	systrap	TimGetTicks()
	lea		checkHeapStartMsg(pc),a0
	bsr		traceOutput
	; bsr		countHeaps
	lea.l	rawDataHeap(a5),a0
	bsr		countHeapBlocks
	lea.l	countHeapsMsgRaw(pc),a0
	bsr		traceOutputL
	rts

checkHeapStatus
	movem.l	d0-d7/a0-a6,-(a7)
	systrap	TimGetTicks()
	move.l	tracePasses(a5),d1
	lea		checkHeapStopMsg(pc),a0
	bsr		traceOutputL
	bsr		countHeaps
	movem.l	(a7)+,d0-d7/a0-a6
	rts

checkHeapStartMsg	dc.b	'GC	Start at %lu, ',0
checkHeapStopMsg	dc.b	'Heap status at	%lu, %lu scans',0
countHeapsMsgObject	dc.b	'%lu Object	blocks',0
countHeapsMsgObjCount	dc.b	', %lu Chunks, %lu Objects', 0
#ifdef DM_HEAP
countHeapsMsgProxy	dc.b	'%lu Proxy blocks',0
#endif
countHeapsMsgRaw	dc.b	'%lu Raw blocks',0
checkHeapBlockMsg   dc.b    'Heap root 0x%lX',0
	align	2
#endif
checkHeapFinalizeOnExit dc.b    'FinalizeOnExit: ',0
checkHeapMarkStack      dc.b    'Mark stack %lX - %lX ',0
checkHeapStackMargin    dc.b    'margin %lX:', 0
checkHeapMarkStatics    dc.b    10,'Mark statics %lX - %lX: ',0
checkHeapScan           dc.b    10,'Scan:',0
checkHeapSweep          dc.b    'Sweep: ',0
checkHeapRecombine      dc.b    'Recombine:',0
checkHeapFreeBlocksToOS dc.b    'FreeBlocksToOS:',0
checkHeapAddBlock       dc.b    'AddBlock %lu',0
checkHeapExit           dc.b    '==== End ====',0
checkHeapOpen           dc.b    '%d',0
checkHeapClose          dc.b    '>',0
checkHeapObj1           dc.b    '<%lX,',0
checkHeapObj2           dc.b    '%d',0
checkHeapDot            dc.b    '.',0
checkHeapOpenParen      dc.b    '(%lX,%d,%d',0
checkHeapCloseParen     dc.b    '%lX,%d,%d)',0
showHeapBlocksMsg       dc.b    'Heap %lX - %lX', 0
showHeapRMsg            dc.b    'root=%lX',0
showHeapBTMsg           dc.b    'B=%lX T=%lX ', 0
showHeapLRMsg           dc.b    'L=%lX R=%lX', 0
showHeapChunkHdr        dc.b    'Root dump',0
showHeapChunk           dc.b    '%x %d%c',0
showHeapBmpHdr          dc.b    'Root bmp',0
showHeapBmp             dc.b    '%lX %lX',0
blockFreedMsg		dc.b	'Block freed (%lu bytes	at %lX)',0
	align	2
#else
;;;	not	CHECK_HEAP
#defmacro	check.heap.status
#endmacro
#defmacro	check.heap.start
#endmacro

#endif

	code
#ifndef	OLD_HEAP

garbage:
	bsr		garbageCollect
	move.l	a2,-(a7)
	bsr		recombine
	bsr		freeBlocksToOS
	move.l	(a7)+,a2
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,7,'garbage',0
	align	2
#endif

#ifdef FINALIZERS	
#ifndef NO_FINALIZE_ON_EXIT
;;;	garbageFinalizeOnExit
;;;	IN nothing
;;;	OUT	nothing
;;;	DOES
;;; treats all objects as unmarked, calls finalizers
;;; for those that need it. I.e. sweep without mark.
garbageFinalizeOnExit
	movem.l	d0-d7/a0-a4,-(a7)
#ifdef CHECK_HEAP
    lea checkHeapFinalizeOnExit(pc),a0
    bsr traceOutput
#endif
    ; PMD 2.1.7
    ; clear all static object pointers so that they look
    ; null from the GC just before exit
	lea.l	StaticObjects(a5),a0
	move.w	#StaticObjectCount-1,d0
garbageFOEloop
	clr.l   (a0)+
	dbra    d0,garbageFOEloop
	bra     garbageCollect_sweep
#endif
#endif

;;;	garbageCollect
;;;	IN
;;;	nothing
;;;	OUT
;;;	nothing
;;;	DOES
;;;	marks all accessible chunks	as used
garbageCollect
	;; 
	;; save	all	registers onto stack
	;; 
	movem.l	d0-d7/a0-a4,-(a7)
	check.heap.start
	;;
#ifdef GC_BEEP
    ; beep when there is a garbage collection
    systrap SndPlaySystemSound(#1.b)
#endif
	;;
	;; cleared here, possibly set by markInterior
	;;
	clr.b	heapNeedsScan(a5)
	;;
	;; compute stack limit and check there is enough
	;; for gc to work
	move.l	StackLimit(a5),a0
	lea		32(a0),a0
	move.l	a0,heapStackMargin(a5)
	cmp.l	a0,a7
	bcs		garbageCollect_out
	;;
	;; mark	object reference on	stack
	;;
#ifdef CHECK_HEAP
    ; show range of stack
    move.l  a7,d0
    move.l  StackEnd(a5),d1
    lea checkHeapMarkStack(pc),a0
    bsr traceOutput
    move.l  heapStackMargin(a5),d0
    lea checkHeapStackMargin(pc),a0
    bsr traceOutputL
    bsr showHeapBlocks
#endif
	move.l	a7,a0
	moveq.l	#2,d7
	move.l	StackEnd(a5),d6
	sub.l	a0,d6
	bsr		markInterior
	;;
	;; mark	objects	referenced by statics
	;;
#ifdef CHECK_HEAP
    ; show range of statics
	lea.l	StaticObjects(a5),a0
	move.l  a0,d0
	lea.l	StaticObjectCount*4(a0),a0
	move.l  a0,d1
    lea.l   checkHeapMarkStatics(pc),a0
    bsr traceOutputL
#endif
	lea.l	StaticObjects(a5),a0
	moveq.l	#4,d7
	move.w	#StaticObjectCount*4,d6
	bsr		markInterior
	;;
	;; repeatedly scan heap	if recursive
	;; marking could not complete
	;;
#ifdef CHECK_HEAP
	clr.l	tracePasses(a5)
	clr.l   traceFinalizes(a5)
	lea     checkHeapScan(pc),a0
	bsr     traceOutputL
#endif
	bra.s	garbageCollect_scan_entry
garbageCollect_scan_loop
	;
	; scan blocks looking for chunks which are pending
	; (chunkPendingBit set,	chunkMarkedBit clear) and
	; mark them.
	;
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
	;
	; found	one	so mark	it
	move.l	a1,-(a7)
	move.l	a0,d0
	addq.l	#ObjectHeader_extra,d0
	;
	bsr		markObject
	;
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
#ifdef CHECK_HEAP
	addq.l	#1,tracePasses(a5)
#endif
garbageCollect_scan_entry
	tst.b	heapNeedsScan(a5)
	bne.s	garbageCollect_scan_loop
	;;
	;; sweep heap recovering any unmarked chunks
	;;
garbageCollect_sweep
#ifdef CHECK_HEAP
    lea checkHeapSweep(pc),a0
    bsr traceOutput
#endif
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
	; we have an unmarked block	that is	not	on a free list
	; so lets put it there
	lea.l	ObjectHeader_extra(a0),a0
#ifdef FINALIZERS
	;; added 2.0.3
	bclr	#chunkHasFinalizerBit,d0
	beq.s	garbageCollect_free
#ifdef CHECK_HEAP
	addq.l  #1,traceFinalizes(a5)
#endif
	addq.b	#1,heapLocked(a5)
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	bsr		getclassinfo_a0
	clr.l	d0	; may be more than 32K
	move.w	ClassInfo_size-2(a0),d0
#ifdef MULTI_SEGMENT
	jsr		0(a5,d0.l)
#else
	lea		0(pc),a0
	jsr		0(a0,d0.l)
#endif
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	move.l	(a7)+,d0
	clr.b	heapLocked(a5)
garbageCollect_free
#endif
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
	;;
	;;
	;; restore all registers from stack
	;;
garbageCollect_out
	check.heap.status
	systrap	TimGetTicks()
	move.w	d0,lastGCTime(a5)
	movem.l	(a7)+,d0-d7/a0-a4
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14,'garbageCollect',0
	align	2
#endif

;;;	recombine
;;;	IN
;;;	nothing
;;;	OUT
;;;	nothing
;;;	DOES
;;;	finds adjacent chunks in blocks	and	combines
;;;	them to	form larger	chunks
;;;	a0	= base of current chunk
;;;	a1	= current block
;;;	a2	= current bitmap
;;;	a3	= next chunk
recombine
#ifdef CHECK_HEAP
    lea checkHeapRecombine(pc),a0
    bsr traceOutputL
#endif
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
	;
	; there	are	only two types of blocks
	; used (b1,b0 == 00) or
	; unused (b1,b0	== 11 )
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,9,'recombine',0
	align	2
#endif
	
;;;	freeBlocksToOS
;;;	return any blocks that are completely empty
;;;	to the operating system
freeBlocksToOS
#ifdef CHECK_HEAP
    lea checkHeapFreeBlocksToOS(pc),a0
    bsr traceOutputL
#endif
	; a2	= block	pointer	pointer
	; a1	= block	pointer
	move.w	heapBlockCount(a5),-(a7)	; save to compare later
	lea		heapBlocks(a5),a2
	bra.s	freeBlocksToOS_enter
freeBlocksToOS_cloop
	move.l	(a0),a0
freeBlocksToOS_center
	cmp.l	(a0),a1
	bne.s	freeBlocksToOS_cloop
	move.l	(a1),(a0)
	;
	; turn chunk pointer back into OS ptr for freeing
	lea		-ObjectHeader_extra-blockHeaderSize(a1),a0
	;
#ifdef CHECK_HEAP
	move.l	a0,d1		; address
	and.l	#$FFFF,d0	; size
	movem.l	d0-d7/a0-a4,-(a7)
	lea.l	blockFreedMsg(pc),a0
	bsr		traceOutputL
	movem.l	(a7)+,d0-d7/a0-a4
#endif
	;
	; release block	back to	the	OS and decrement block count
#ifdef DM_HEAP
	bsr	releaseDmBlock
#else
	systrap	MemPtrFree(a0.l)
#endif
	subq.w	#1,heapBlockCount(a5)
	;
	; a2 has been hooked up	ready for the next iteration
	bra.s	freeBlocksToOS_enter
freeBlocksToOS_loop
	lea		blockNext(a1),a2
freeBlocksToOS_enter
	; scan through blocks looking for ones that
	; are completely empty
	move.l	(a2),a1
	cmp.w	#0,a1
	beq.s	freeBlocksToOS_out
	moveq.l	#0,d0
	move.w	(a1),d0
	lea		-chunkMarkEmpty(a1,d0.l),a0
	cmp.l	blockTop(a1),a0		; first	chunk is block size
	bne.s	freeBlocksToOS_loop
	;
	; unhook a1	from list
	move.l	blockNext(a1),(a2)
	;
	; Remove a1	from free list,	only freeListLarge is
	; needed. Chunk	*must be here.
	; convert a1 into chunk	pointer
	lea		ObjectHeader_extra(a1),a1
	lea		freeListLarge(a5),a0
	bra.s	freeBlocksToOS_center
	;
freeBlocksToOS_out
	; compare new count	against	old
	; dont reconstruct tree	is no change
	; rebuild the block	binary tree	using the ordered
	; block	list. Time taken is	proportional to	the
	; number of	blocks.	Stack 8*log2(blocks).
	move.w	heapBlockCount(a5),d0
	cmp.w	(a7)+,d0
	beq.s	freeBlocksToOS_rts
	move.l	heapBlocks(a5),a0
	bsr		buildBlockSubtree
	move.l	a1,heapRoot(a5)
	bsr		setHeapMaxMin
freeBlocksToOS_rts
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14,'freeBlocksToOS',0
	align	2
#endif

;;;	markInterior
;;;	IN
;;;	a0	 = start of	region to scan
;;;	d6.w = size	of region
;;;	d7.w = step	size (2	or 4)
;;;	OUT
;;;	nothing
markInterior
	move.l	a0,-(a7)
	move.w	d7,-(a7)
	move.w	d6,-(a7)
	subq.w	#4,d6	; remove size of pointer
	move.l	heapMaxAddress(a5),d5
	move.l	heapMinAddress(a5),d4
	bra		markObject_enter
	
;;;	markObject
;;;	IN
;;;	d0	 = prospective address
markObject
	; translate	address
	bsr		findBlockFromAddress
	bcc.s	markObject_rts
	;
	; check	pointer	offset is ObjectHeader_extra otherwise
	; it can't be a	bone fide object
	;
	move.l	d0,d1
	sub.l	a1,d1
	and.w	#7,d1
	cmp.w	#ObjectHeader_extra,d1
	bne.s 	markObject_rts
	;
	; check	that the object	bit	is set in bitmap
	;
	move.l	d0,a2
	sub.w	a1,d0
	lsr.w	#3,d0	; byte per bitmap bit
	move.w	d0,d1
	lsr.w	#3,d1
	move.l	blockBitmap(a1),a1
	btst	d0,0(a1,d1.w)
	beq.s   markObject_rts
	;
	; mark the object data
	;
	bset.b	#chunkMarkedBit,ObjectHeader_ChunkSize+1(a2)
	bne.s	markObject_rts	; already marked
	;
	; might	have been pending
	bclr.b	#chunkPendingBit,ObjectHeader_ChunkSize+1(a2)
	;
	; check	recursion depth
	;
	cmp.l	heapStackMargin(a5),a7
	bcc.s	markObject_stackok
	;
	; mark block as	incomplete and indicate	that a scan	is
	; necessary
	move.b	#1,heapNeedsScan(a5)
	subq.l	#-ObjectHeader_ChunkSize-1,a2
	bclr.b	#chunkMarkedBit,(a2)
	bset.b	#chunkPendingBit,(a2)
	bra.s	markObject_rts	; already marked
	;
markObject_stackok
	;
	; classify the class
	;
	move.l	a0,-(a7)
	move.l	a2,a0
	bsr		getclassinfo_a0
	move.b	ClassInfo.Flags(a0),d0
	;
	; scalar array?
	;
	btst.l	#ClassInfo_arrayBit,d0
	beq.s	markObject_objarray
	; TBD assume scalar	always in heap (String?).
	; do we	need to	check it is	in a heap block?
	move.l	Array.data(a2),a0
	; can be null if gc	called after creation of array object
	; but array	data not yet allocated
	cmp.w	#0,a0
	beq.s	markObject_out
	bset.b	#chunkMarkedBit,ObjectHeader_ChunkSize+1(a0)
	bra.s	markObject_out
	;
makeObject_popping_out
	; apparently Palm TungstenT has problem with movem.w
	; so lets do then seperately
	move.w	(a7)+,d6
	move.w	(a7)+,d7
markObject_out
	move.l	(a7)+,a0
markObject_rts
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,10,'markObject',0
#endif
	align	2
	;
markObject_objarray
	;
	; object array?
	;
	btst.l	#ClassInfo_aooBit,d0
	beq.s	markObject_object
	;
	; object array data	is always in the heap. we don't	need
	; to check that	it is in a heap	block
	;
	move.l	Array.data(a2),a0
	; can be null if gc	called after creation of array object
	; but array	data not yet allocated
	cmp.w	#0,a0
	beq.s	markObject_out
	bset.b	#chunkMarkedBit,ObjectHeader_ChunkSize+1(a0)
	;
	; now we must mark the contents
	;
	; apparently Palm TungstenT has problem with movem.w
	; so lets do then seperately
	move.w	d7,-(a7)
	move.w	d6,-(a7)
	moveq.l	#4,d7
	bra.s	markObject_interior
	;
markObject_object
	;
	; now we must mark the contents
	;
	move.l	a2,a0
	; apparently Palm TungstenT has problem with movem.w
	; so lets do then seperately
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
	;
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
	;
	bsr		markObject
	;
	bra.s	markObject_loop
	
;;;	findBlockFromAddress
;;;	IN
;;;	d0	= pointer that might point into	a block
;;;	OUT
;;;	a1	= block	(or	null)
;;;	C	= set if found
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20,'findBlockFromAddress',0
	align	2
#endif

;;;	allocate object	memory
;;;	IN
;;;	d0.l = sizeWanted including	header (in bytes)
;;;	OUT
;;;	a0	 = object address (= memory	address	+ 2) or	0
;;;	Z	 = out of memory (when a0 == 0)
;;;	chunk is marked	as an Object in	the	bitmap
allocMem
	bsr.s	allocRawMem
	beq.s	allocMem_rts
	move.l	a0,-(a7)
	; mark bit in bitmap to	indicate an	Object
	; ObjectHeader_ClassIndex contains offset from block
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,8,'allocMem',0
	align	2
#endif

;;;	allocate raw data memory
;;;	IN
;;;	d0.l = sizeWanted (raw,	in bytes)
;;;	OUT
;;;	a0	 = data	address	or 0
;;;	Z	 = out of memory (when a0 == 0)
;;;	chunk is not marked	as an object in	the	bitmap
;;;	flags indicate unmarked.
allocRawMem:
	move.l	a2,-(a7)
	; find a suitable chunk
	move.l	d0,-(a7)
#ifndef NO_FINALIZER_CHECKS
#ifdef FINALIZERS
    ; no re-entrancy allowed
	tst.b	heapLocked(a5)
	bne.s	allocRawMem_locked
#endif
#endif
	;
	bsr		heapAlloc
	bne.s	allocRawMem_out
	;
	; if we	run	out	of heap	quickly
	; then just	add	a block	without	doing a
	; garbage collection.
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
	; garbage collect and try again
	bsr		garbageCollect	
	move.l	(a7),d0
	bsr		heapAlloc
	bne.s	allocRawMem_out
	; merge	chunks and try again
	bsr		recombine
	check.heap.status
	move.l	(a7),d0
	bsr		heapAlloc
	bne.s	allocRawMem_out
	; allocate a new block and try again
	bsr		freeBlocksToOS
	move.l	(a7),d0
	bsr		addBlock
	check.heap.status
	move.l	(a7),d0
	bsr		heapAlloc
allocRawMem_out
	lea.l	4(a7),a7	; don't	change flags
	move.l	(a7)+,a2
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11,'allocRawMem',0
	align	2
#endif
#ifndef NO_FINALIZER_CHECKS
#ifdef FINALIZERS
allocRawMem_locked
	moveq.l	#0,d0	; Z	flag set
	move.l	d0,a0
	bra.s	allocRawMem_out
#endif
#endif

#ifdef DM_HEAP
;;;	allocate proxy memory
;;;	IN
;;;	d0.w = sizeWanted (raw,	in bytes)
;;;	OUT
;;;	a0	 = data	address	or 0
;;;	Z	 = out of memory (when a0 == 0)
allocProxyMem
	addq.w	#2+1,d0		; size + rounding
	and.w	#$FFFE,d0	; even
	cmp.w	proxyStackSpace(a5),d0
	bcc.s	allocProxyMem_new_block
allocProxyMem_again
	move.l	proxyStackPtr(a5),a0
	sub.w	d0,proxyStackSpace(a5)
	add.l	d0,proxyStackPtr(a5)
	move.w	d0,-2(a0,d0.l)	; save size	at top if block
	rts
allocProxyMem_new_block
	move.l	d0,-(a7)
	cmp.w	#proxyMinBlockSize,d0
	bcc.s	allocProxyMem_sized
	move.w	#proxyMinBlockSize,d0
allocProxyMem_sized
	move.w	d0,-(a7)
	add.w	#proxyBlockHeaderSize,d0
	systrap	MemPtrNew(d0.l)
#ifdef CHECK_PROXY
	bne.s	allocProxyMem_passed
	trap	#8
allocProxyMem_passed
#endif
	move.w	proxyStackSpace(a5),(a0)+
	move.l	proxyStackPtr(a5),(a0)+
	move.l	proxyStackBlock(a5),(a0)+
	move.l	a0,proxyStackBlock(a5)
	move.l	a0,proxyStackPtr(a5)
	move.w	(a7)+,proxyStackSpace(a5)
	move.l	(a7)+,d0
	bra.s	allocProxyMem_again
#endif

;;;	allocate memory	from the heap
;;;	do not garbage collect or add new blocks
;;;	IN
;;;	d0.l = sizeWanted (in bytes, need not be even)
;;;	OUT
;;;	a0	 = data	block address or 0
;;;	Z	 = out of memory (when a0 == 0)
heapAlloc
	move.l	a2,-(a7)
	bsr		freeListFromPayloadSize
	; search this list
	;  a2 points to	current	free list pointer
	;  a1 points to	previous pointer
	;  a0 is current pointer
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
	; check	for	last freeList pointer
	addq.l	#4,a2
	lea.l	freeListLarge+4(a5),a1
	cmpa.l	a1,a2
	bne.s	heapAlloc_ploop
	move.l	(a7)+,a2
	cmp.w	d0,d0	; set Z
	rts
heapAlloc_found
	; unlink from list
	move.l	(a0),(a1)
	; clear	mark bits
	move.w	ObjectHeader_ChunkSize(a0),d1
	and.w	#$FFF8,d1
	; split	block if necessary
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
	; zero object
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,9,'heapAlloc',0
	align	2
#endif
	
;;;	addChunkToFreeList
;;;	IN
;;;	d0.w = size	(multiple of 8)
;;;	a0	 = chunk
;;;	a1	 = block
;;;	OUT
;;;	a2	 = bitmap
addChunkToFreeList
#ifdef CHECK_HEAP
	; there	should never be	a finalizer	bit	here
	bclr	#chunkHasFinalizerBit,d0
	beq.s	addChunkToFreeList_finalize_bit_ok
	trap #8
addChunkToFreeList_finalize_bit_ok
#endif
#ifdef ERASE_GARBAGE
    ; fill dead memory with DDDDDDDD
    movem.l d0-d1/a0,-(a7)
    lsr.w   #2,d0
    subq.w  #2,d0
    move.l  #$DDDDDDDD,d1
addChunkToFreeList_dead
	move.l	d1,(a0)+
	dbra	d0,addChunkToFreeList_dead
    movem.l (a7)+,d0-d1/a0
#endif
	or.w	#chunkMarkEmpty,d0	; mark empty
	move.w	d0,ObjectHeader_ChunkSize(a0)
	bsr		freeListFromChunkSize
	; link into	list
	move.l	(a2),(a0)
	move.l	a0,(a2)
	; class	index contain offset back to chunk
	move.w	a0,d0
	sub.w	a1,d0
	move.w	d0,ObjectHeader_ClassIndex(a0)
	; clear	bitmap bit in case it was an object
	move.l	blockBitmap(a1),a2
	lsr.w	#3,d0
	move.w	d0,d1
	lsr.w	#3,d0
	bclr.b	d1,0(a2,d0.w)
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18,'addChunkToFreeList',0
	align	2
#endif
	
;;;	freeListFromPayloadSize
;;;	determine which	free list pointer to use based
;;;	on size	of data	required.
;;;	freeListFromChunkSize
;;;	determine which	free list pointer to use based
;;;	on size	of chunk require.
;;;	IN
;;;	d0.w = size
;;;	OUT
;;;	d0.w = chunk size rounded to multiple of 8
;;;	a2	 = address of appropriate list
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23,'freeListFromPayloadSize',0
	align	2
#endif
	
;;;	allocate memory	from OS	as a block and add it
;;;	to the heap	tree. Blocks have a	minimum	size.
;;;	IN
;;;	d0.l = sizeWanted (in bytes, need not be even)
;;;	OUT
;;;	nothing, heapRoot updated with added block if OK
addBlock
	; compute total	block size needed
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
#ifdef CHECK_HEAP
    movem.l d0-d2/a0-a1,-(a7)
    lea     checkHeapAddBlock(pc),a0
    bsr     traceOutputL
    movem.l (a7)+,d0-d2/a0-a1
#endif
	; allocate block from OS
#ifdef DM_HEAP
	bsr	allocDmBlock
#else 
	systrap	MemPtrNew(d0.l)
#endif
	cmp.w	#0,a0
	beq		addBlock_fail
	; setup	header and make	block contain one chunk
	lea.l	blockHeaderSize(a0),a1	; a1 = block
	move.l	(a7),d0
	lea.l	0(a1,d0.l),a0	; top of payload ==	bitmap
	move.l	a0,blockBitmap(a1)
	lea.l	ObjectHeader_extra(a1),a0
	bsr		addChunkToFreeList
	; clear	bitmap
	move.l	(a7),d0
	lsr.w	#6,d0	; bitmap is	payload/64
	move.l	a2,a0	; bitmap ptr
	bsr		memclear
	; find insert point	in heapBlocks list
	; TBD use the tree.	here we	scan and insert
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
	; link into	list
	move.l	a0,blockNext(a1)
	move.l	a1,(a2)
	addq.w	#1,heapBlockCount(a5)
	; rebuild the block	binary tree	using the ordered
	; block	list. Time taken is	proportional to	the
	; number of	blocks.	Stack 8*log2(blocks).
	move.l	heapBlocks(a5),a0
	move.w	heapBlockCount(a5),d0
	bsr.s	buildBlockSubtree
	move.l	a1,heapRoot(a5)
	bsr		setHeapMaxMin
addBlock_fail
	move.l	(a7)+,d0
addBlock_rts
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,8,'addBlock',0
	align	2
#endif

	; set the heapMinAddress and heapMaxAddress
	; using	the	heap tree (follow right	for	max)
	; note that	heapMinAddress is same as first	on heap
	; blocks list.
setHeapMaxMin
	move.l	heapRoot(a5),a1
setHeapMaxMin_loop
	move.l	a1,a0
	move.l	blockRight(a0),a1
	cmp.w	#0,a1
	bne.s	setHeapMaxMin_loop
	move.l	blockTop(a0),heapMaxAddress(a5)
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'setHeapMaxMin',0
	align	2
#endif
		
	; Follow the block list	(a0) while *recursively*
	; constructing the tree. No	address	compares
	; are needed since block list is in	order.
	; d0.w contains	the	size of	the	subtree	to build.
	; a2 is	temporary.
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17,'buildBlockSubtree',0
	align	2
#endif

#else

;;;	garbage
;;;	IN
;;;	nothing
;;;	OUT
;;;	nothing
;;;	DOES
;;;	removes	marks from all chunks,
;;;	marks all accessible chunks	as used
;;;	resets the "current" pointers of the heaps
garbage
	;; 
	;; if (objectHeap.first	== null) return
	;;
	tst.l	objectHeap+heapFirst(a5)
	bne.s	garbage_doit
	rts
	;;
garbage_doit
	;; 
	;; save	all	registers onto stack
	;; 
	movem.l	d0-d7/a0-a4,-(a7)
	check.heap.start
	;;
	;; unmarkAll(objectHeap)
	;; unmarkAll(rawDataHeap)
	;;
	lea.l	objectHeap(a5),a0
	bsr	heapUnmarkAll
	lea.l	rawDataHeap(a5),a0
	bsr	heapUnmarkAll
#ifdef DM_HEAP
	;;
	;; unmarkAll(proxyHeap)
	;;
	lea.l	proxyHeap(a5),a0
	bsr	heapUnmarkAll
#endif
	;;
	;; ***** mark the stack	(expecting objects,	raw	data or	proxies) *****
	;;
	;; for (ptr=sp;	ptr<stackEnd; ptr+=2)
	;; // a2=ptr
	;; 
	move.l	a7,a2
garbage_sloop
	;;
	;;	markObject(*ptr)
	;;	markRawData(*ptr)
	;;
	move.l	(a2),a0
	bsr	markObject
	move.l	(a2),a0
	bsr	markRawData
#ifdef DM_HEAP
	;;
	;;	markProxy(*ptr)
	;;	
	move.l	(a2),a0
	bsr	markProxy
#endif
	;;
	;; [ for (...; ptr<stackEnd; ptr+=2) ]
	;;
	addq.l	#2,a2
	cmp.l	StackEnd(a5),a2
	blo.s	garbage_sloop
	;;
	;; ***** mark the static objects (expecting	Objects) *****
	;;
	;; for (ptr=&staticObjects,	i=staticObjectCount; i>0; ptr+=4, i--)
	;; // a2=ptr, d3.w=i
	;;
	lea.l	StaticObjects(a5),a2
	move.w	#StaticObjectCount,d3
	bra.s	garbage_soloopEnd
garbage_soloop
	;;
	;;	   markObject(*ptr)
	;;
	move.l	(a2),a0
	bsr	markObject
	;;
	;; [ for (...; i>0;	ptr+=4,	i--) ]
	;;
	addq.l	#4,a2
garbage_soloopEnd
	dbra	d3,garbage_soloop
#ifdef CHECK_HEAP
	clr.l	tracePasses(a5)
#endif
	;;
	;; ***** expand	the	marked objects,	traversing breadth-first *****
	;; 
	;; while (newMark) {
	;;
	bra.s	garbage_mloopEnd
garbage_mloop
	;;
	;; newMark = false
	;; 
	clr.b	newMark(a5)
	;;
	;; for (block=objectHeap.first;	block!=null; block=block.next)
	;; // a3=block
	;; 
	move.l	objectHeap+heapFirst(a5),a3
	bra	garbage_bloopEnd
garbage_bloop
	;; 
	;; for (chunk=block.begin, offset=0; 
	;;		chunk.step!=0; 
	;;		chunk+=chunk.step, offset+=chunk.step)
	;; // a2=chunk,	d3=offset
	;; 
	lea.l	blockBegin(a3),a2
	clr.w	d3
	bra.s	garbage_cloopEnd
garbage_cloop
	;; 
	;; // LOOP BODY: a3=block, a2=chunk, d3=offset
	;; 
	;; if (block.bits[offset/8]	== 1)
	;; 
	move.w	d3,d2
	asr.w	#6,d2
	lea.l	blockBits(a3,d2.w),a0
	move.w	d3,d2
	asr.w	#3,d2
	btst.b	d2,(a0)
	beq.s	garbage_cloopNext
	;;
	;; // FOUND	A MARKED CHUNK
	;;
	;; if ((*chunk & 0x80) == 0)
	;;	   expandObject(chunk+2)
	;;
	btst.b	#7,(a2)
	bne.s	garbage_cloopNext
	lea.l	2(a2),a0
	bsr	expandObject
	;;
garbage_cloopNext
	;; 
	;;	// for (...	chunk+=chunk.step, offset+=chunk.step)
	;; 
	move.w	chunkStep(a2),d2
	add.w	d2,d3
	add.w	d2,a2
garbage_cloopEnd
	;; 
	;;	// for (...	chunk.step!=0 ...)
	;; 
	tst.w	chunkStep(a2)
	bne.s	garbage_cloop
	;; 
	;;	// for (...	block=block.next)
	;; 
	move.l	blockNext(a3),a3
garbage_bloopEnd
	;; 
	;;	// for (...	block!=null	...)
	;; 
	cmp.w	#0,a3
	bne.s	garbage_bloop
	;;
garbage_mloopEnd
	;;
	;; [ while (newMark) ]
	;;
#ifdef CHECK_HEAP
	addq.l	#1,tracePasses(a5)
#endif
	tst.b	newMark(a5)
	bne.s	garbage_mloop
	;;
	;; ***** remove	the	'expanded' bit from	objects	*****
	;;
	;; for (block=objectHeap.first;	block!=null; block=block.next)
	;; // a3=block
	;; 
	move.l	objectHeap+heapFirst(a5),a3
	bra	garbage_b2loopEnd
garbage_b2loop
	;; 
	;; for (chunk=block.begin; 
	;;		chunk.step!=0; 
	;;		chunk+=chunk.step)
	;; // a2=chunk
	;; 
	lea.l	blockBegin(a3),a2
	bra.s	garbage_c2loopEnd
garbage_c2loop
	;; 
	;; // LOOP BODY: a3=block, a2=chunk
	;;
	;; chunk[0]	&= 0x7f;
	;;
	bclr.b	#7,(a2)
	;;
	;;	// for (...	chunk+=chunk.step)
	;; 
	add.w	chunkStep(a2),a2
garbage_c2loopEnd
	;; 
	;;	// for (...	chunk.step!=0 ...)
	;; 
	tst.w	chunkStep(a2)
	bne.s	garbage_c2loop
	;; 
	;;	// for (...	block=block.next)
	;; 
	move.l	blockNext(a3),a3
garbage_b2loopEnd
	;; 
	;;	// for (...	block!=null	...)
	;; 
	cmp.w	#0,a3
	bne.s	garbage_b2loop
	;;
	;; ***** reclaim blocks	no longer in use *****
	;;
	lea.l	objectHeap(a5),a0
	bsr	heapReclaim
	;;
	lea.l	rawDataHeap(a5),a0
	bsr	heapReclaim
	;;
	;; restore all registers from stack
	;; 
	check.heap.status
	movem.l	(a7)+,d0-d7/a0-a4
	rts

;;;	mark an	object pointer (if it really points	to an existing object)
;;;	IN
;;;	a0 = candidate chunk pointer
;;;	OUT
;;;	nothing
;;;	DOES (only if really an	object)
;;;	sets the mark bit for this object
;;;	sets the 'newMark' flag	if object wasn't marked	before
markObject
	subq.l	#ObjectHeader_sizeof,a0
	lea.l	objectHeap(a5),a1
	bsr	markChunk
markObject_out
	rts

;;;	mark a potential raw data chunk
;;;	IN
;;;	a0 = candidate raw-data	pointer
;;;	OUT
;;;	nothing
;;;	DOES (only if really is	a raw-data chunk)
;;;	sets the mark bit for this chunk
;;;	sets the 'newMark' flag	if chunk wasn't	marked before
markRawData
	lea.l	rawDataHeap(a5),a1
	bsr	markChunk
	rts

#ifdef DM_HEAP
;;;	mark a potential proxy pointer
;;;	IN
;;;	a0 = candidate proxy pointer
;;;	OUT
;;;	nothing
;;;	DOES (only if really a proxy chunk)
;;;	sets the mark bit for this chunk
;;;	sets the 'newMark' flag	if chunk wasn't	marked before
markProxy
	lea.l	proxyHeap(a5),a1
	bsr	markChunk
	rts
#endif

;;;	mark a chunk pointer (if it	really points to an	existing chunk)
;;;	IN
;;;	a0 = candidate chunk pointer
;;;	a1 = candidate heap
;;;	OUT
;;;	nothing
;;;	DOES (only if really an	object)
;;;	sets the mark bit for this object
;;;	sets the 'newMark' flag	if object wasn't marked	before
markChunk
	;;
	;; if ((ptr	== null) ||	((ptr &	1) != 0)) return
	;;
	move.l	a0,d0
	beq.s	markChunk_rts
	btst.l	#0,d0
	bne.s	markChunk_rts
	;;
	;; if ((ptr	< heap.minAddress) ||
	;;	   (ptr	> heap.maxAddress))
	;;	  return
	;;
	move.l	heapMinAddress(a1),d0
	cmp.l	a0,d0
	bhi.s	markChunk_rts
	move.l	heapMaxAddress(a1),d0
	cmp.l	a0,d0
	blo.s	markChunk_rts
	;;
markChunk_search
	;; 
	;; for (block=heap.first; block!=null; block=block.next)
	;; // a1=block
	;;
	movem.l	a2,-(a7)
	move.l	heapFirst(a1),a1
	bra.s	markChunk_bloopEnd
	;;
markChunk_bloop
	;;
	;; if ((ptr	>= block.begin)	&&
	;;	   (ptr	< block.size)) {
	;;
	lea.l	blockBegin(a1),a2
	cmp.l	a2,a0
	blo.s	markChunk_nextBlock
	lea.l	blockSize(a1),a2
	cmp.l	a2,a0
	bhs.s	markChunk_nextBlock
	;;
	;; offset =	ptr	- block.begin
	;; // d1=offset
	;;
	moveq.l	#-blockBegin,d1
	add.l	a0,d1
	sub.l	a1,d1
	;;
	;; if (block.bits[offset/8]	== 0)
	;;	   block.bits[offset/8]	= 1;
	;;	   newMark = true;
	;;
	move.w	d1,d0
	asr.w	#6,d0
#ifdef CHECK_HEAP
	;;;	check bits are in range
	cmp.w	#blockBitsSize,d0
	bcs.s	markChunk_inRange
	trap	#8
markChunk_inRange
#endif
	lea.l	blockBits(a1,d0.w),a2
	move.w	d1,d0
	asr.w	#3,d0
	bset.b	d0,(a2)
	bne.s	markChunk_out
	move.b	#1,newMark(a5)
	bra.s	markChunk_out
	;;
markChunk_nextBlock
	;;
	;; [ for (...; block!=null;	block=block.next) ]
	;;
	move.l	blockNext(a1),a1
markChunk_bloopEnd
	cmp.w	#0,a1
	bne.s	markChunk_bloop
	;;
markChunk_out
	movem.l	(a7)+,a2
markChunk_rts
	rts

;;;	expand an object (mark everything the object points	to)
;;;	IN
;;;	a0 = object
;;;	OUT
;;;	nothing
;;;	DOES
;;;	mark everything	that's referenced by the object
;;;	set	the	'expanded' bit in the classindex prefix	word
expandObject
	move.w	ObjectHeader_ClassIndex(a0),d0
	bclr.l	#15,d0
	bne.s	expandObject_rts
	bset.b	#7,ObjectHeader_ClassIndex(a0)
	movem.l	a2-a3/d3,-(a7)
	move.l	a0,a2
	bsr	getclassinfo	; d0 still contains	the	classindex
	move.b	ClassInfo.Flags(a0),d0
	;;
	;; if (object instanceof ScalarArray)
	;;	markRawData(array.data)
	;;
	btst.l	#ClassInfo_arrayBit,d0
	beq.s	expandObject_1
	;;
	move.l	Array.data(a2),a0
	bsr	markRawData
	bra.s	expandObject_out
	;;
expandObject_1
	;;
	;; if ((object instanceof ObjectArray) && (array.data != null))
	;;	markRawData(array.data)
	;;
	btst.l	#ClassInfo_aooBit,d0
	beq.s	expandObject_Object
	;; 
	move.l	Array.data(a2),a3
	move.w	Array.length(a2),d3
	cmp.w	#0,a3
	beq.s	expandObject_out
	;; 
	move.l	a3,a0
	bsr	markRawData
	;;
	;;	for	(i=0; i<array.length; i++)
	;;		markObject (array[i])
	;; 
	bra.s	expandObject_eloopEnd
expandObject_eloop
	move.l	(a3)+,a0
	bsr	markObject
expandObject_eloopEnd
	dbra	d3,expandObject_eloop
	bra.s	expandObject_out
	;;
expandObject_Object
	;;
	;; for (ptr=object;	ptr<=object_end-4; ptr+=2) {
	;;	markObject(*ptr);
	;;	markRawData(*ptr); }
	;; 
	move.w	ClassInfo.ObjectSizePlusHeader(a0),d3
	subq.w	#ObjectHeader_sizeof+4,d3
	bcs.s	expandObject_out
	asr.w	#1,d3
expandObject_floop
	move.l	(a2),a0
	bsr	markObject
	move.l	(a2),a0
	bsr	markRawData
	addq.l	#2,a2
	dbra	d3,expandObject_floop
expandObject_out
	movem.l	(a7)+,a2-a3/d3
expandObject_rts
	rts
	; (OLD_HEAP)
#endif

#ifdef DM_HEAP
;;;	allocate a block of	memory from	the	PalmOS DataManager
;;;	IN
;;;	d0.l = memory size (must be	<= 64K)
;;;	OUT
;;;	a0	 = memory block	address
allocDmBlock
	mem.release.savereg
	movem.l	d3/a2,-(a7)
	;;
	;; if (dbOpenRef ==	null) {
	;;
	tst.l	dbOpenRef(a5)
	bne.s	allocDmBlock_haveDb
	;; 
	;;	DmCreateDatabase(0,	"ObjHeap", appid, 'Ohep', false)
	;; 
	move.l	d0,d3
	clr.b	-(a7)
	move.l	#HeapDbType,-(a7)
	move.l	#JumpAppID,-(a7)
	lea.l	allocDmBlock_dbName(pc),a0
	move.l	a0,-(a7)
	clr.w	-(a7)
	trap	#15
	dc.w	sysTrapDmCreateDatabase
	lea.l	16(a7),a7
	;; 
	;;	dbOpenRef =	
	;;		DmOpenDatabaseByTypeCreator('Ohep',	appid, dmModeReadWrite);
	;;	if (dbOpenRef == null)
	;;		goto _nomem;
	;; 
	move.w	#dmModeReadWrite,-(a7)
	move.l	#JumpAppID,-(a7)
	move.l	#HeapDbType,-(a7)
	trap	#15
	dc.w	sysTrapDmOpenDatabaseByTypeCreator
	lea.l	10(a7),a7
	cmp.w	#0,a0
	beq.s	allocDmBlock_nomem
	move.l	a0,dbOpenRef(a5)
	move.l	d3,d0
	;;
	;; end of 'if (dbOpenRef ==	null)'
	;; 
allocDmBlock_haveDb
	;;
	;; handle =	DmNewRecord(dbOpenRef, &dbRecNo, size+blockDbExtra);
	;; if (handle == null)
	;;	goto _nomem;
	;; 
	addq.l	#blockDbExtra,d0
	move.w	#dmMaxRecordIndex,dbRecNo(a5)
	systrap	DmNewRecord(dbOpenRef(a5).l,&dbRecNo(a5).l,d0.l)
	cmp.w	#0,a0
	beq.s	allocDmBlock_nomem
	move.l	a0,dbRecHandle(a5)
	;;
	;; block = MemHandleLock(handle) + blockDbExtra;
	;; 
	systrap	MemHandleLock(a0.l)
	addq.l	#blockDbExtra,a0
	move.l	a0,a2
	;;
	;; DmRecordInfo(dbOpenRef, dbRecNo,	null, &dbRecUID, null);
	;; 
	systrap	DmRecordInfo(dbOpenRef(a5).l,dbRecNo(a5).w,#0.l,&dbRecUID(a5).l,#0.l)
	mem.reserve
	;;
	;; block.blockDbUniqueID = dbRecUID;
	;; block.blockDbHandle	 = dbRecHandle;
	;;
	move.l	a2,a0
	move.l	dbRecUID(a5),blockDbUniqueID(a0)
	move.l	dbRecHandle(a5),blockDbHandle(a0)
	;; 
	movem.l	(a7)+,d3/a2
	rts
	;;
allocDmBlock_nomem
	mem.reserve
	;;;; bra	throw_OutOfMemoryError
	movem.l	(a7)+,d3/a2
	sub.l	a0,a0	; mem reserve killed pointer
	rts
	;; 
allocDmBlock_dbName	dc.b	'objHeap',0
	align 2

;;;	releases a database-allocated block	to the Data	Manager
;;;	IN
;;;	a0 = block address
;;;	OUT
;;;	nothing
releaseDmBlock
	movem.l	d3/a2,-(a7)
	mem.release.savereg
	move.l	blockDbHandle(a0),a2
	systrap	DmFindRecordByID(dbOpenRef(a5).l,blockDbUniqueID(a0).l,&dbRecNo(a5).l)
	move.w	dbRecNo(a5),d3
	systrap	MemHandleUnlock(a2.l)
	systrap	DmReleaseRecord(dbOpenRef(a5).l,d3.w,#0.b)
	systrap	DmRemoveRecord(dbOpenRef(a5).l,d3.w)
	mem.reserve
	movem.l	(a7)+,d3/a2
	rts
#endif

;;;	releases all heap blocks to	the	Data Manager
;;;	IN
;;;	a0 = heap (used	in OLD_HEAP	case)
;;;	OUT
;;;	nothing
releaseDmHeap
	movem.l	a2,-(a7)
#ifndef	OLD_HEAP
	move.l	heapBlocks(a5),a2
	clr.l	heapBlocks(a5)
	clr.w	heapBlockCount(a5)
#else
	move.l	heapFirst(a0),a2
	clr.l	heapFirst(a0)
#endif
	bra.s	releaseDmHeap_loopEnd
releaseDmHeap_loop
#ifndef	OLD_HEAP
	; new heap has control data	before the pointer
	; old heap had it after
	lea.l	-blockHeaderSize(a2),a0	; correct for data before block
#else
	move.l	a2,a0
#endif
	move.l	blockNext(a2),a2
#ifdef DM_HEAP
	bsr	releaseDmBlock
#else
	systrap	MemPtrFree(a0.l)
#endif
releaseDmHeap_loopEnd
	cmp.w	#0,a2
	bne.s	releaseDmHeap_loop
	movem.l	(a7)+,a2
	rts

;;;	deletes	all	entries	from the 'objHeap' database
;;;	IN
;;;	nothing
;;;	OUT
;;;	nothing
clearDmHeap
	link	a6,#-38
#ifndef	OLD_HEAP
	; new heap has only	one	heap
	; so no	pointer	is required
#else
	; proxy	heap is	not	constructed	on
	; database records so it doesn't need
	; to be	freed here
	lea.l	objectHeap(a5),a0
	bsr	releaseDmHeap
	lea.l	rawDataHeap(a5),a0
#endif
	bsr	releaseDmHeap
#ifdef DM_HEAP
#ifndef	OLD_HEAP
	; free the one and only
	; proxy	heap block if it exists
	move.l	proxyStackBlock(a5),a0
	move.l	a0,d0
	beq.s	clearDmHeap_noProxy
	lea.l	-proxyBlockHeaderSize(a0),a0	; correct for data before block
	systrap	MemPtrFree(a0.l)
	clr.l	proxyStackBlock(a5)
clearDmHeap_noProxy
#endif
	mem.release
	tst.l	dbOpenRef(a5)
	beq.s	clearDmHeap_notOpen
	systrap	DmCloseDatabase(dbOpenRef(a5).l)
clearDmHeap_notOpen
	systrap	DmGetNextDatabaseByTypeCreator(#1.b,&-38(a6),#HeapDbType.l,#JumpAppID.l,#0.b,&-6(a6),&-4(a6))
	lea.l	32(a7),a7	; unwind DmSearchState
	tst.w	d0
	bne.s	clearDmHeap_out
	trap	#15		; CardNo and LocalID already on	stack
	dc.w	sysTrapDmDeleteDatabase
clearDmHeap_out
	mem.reserve
#endif
	unlk	a6
	rts

#ifdef OLD_HEAP
;;;	allocate object	memory
;;;	IN
;;;	d0.l = sizeWanted including	header (in bytes)
;;;	OUT
;;;	a0	 = object address (= memory	address	+ 2) or	0
;;;	Z	 = out of memory (when a0 == 0)
allocMem
	lea.l	objectHeap(a5),a0
	bsr.s	heapMalloc
	cmp.w	#0,a0
	beq.s	allocMem_out
	addq.l	#2,a0
allocMem_out
	rts

;;;	allocate raw data memory
;;;	IN
;;;	d0.l = sizeWanted (raw,	in bytes)
;;;	OUT
;;;	a0	 = data	address	or 0
;;;	Z	 = out of memory (when a0 == 0)
allocRawMem
	lea.l	rawDataHeap(a5),a0
	bsr.s	heapMalloc
	rts

	
#ifdef DM_HEAP
	
;;;	allocate proxy memory
;;;	IN
;;;	d0.w = sizeWanted (raw,	in bytes)
;;;	OUT
;;;	a0	 = data	address	or 0
;;;	Z	 = out of memory (when a0 == 0)
allocProxyMem
	lea.l	proxyHeap(a5),a0
	bsr.s	heapMalloc
	rts

#endif

;;;	allocate memory	from given heap, garbage collecting	or
;;;	adding new blocks as necessary
;;;	IN
;;;	d0.l = sizeWanted (in bytes, need not be even)
;;;	a0	 = pointer to heap structure
;;;	OUT
;;;	a0	 = data	block address or 0
;;;	Z	 = out of memory (when a0 == 0)
heapMalloc
	movem.l	d3/a2,-(a7)
	move.l	d0,d3
	move.l	a0,a2
	;;
	;; if (sizeWanted >	blockUsable) {
	cmp.l	#blockUsable,d0
	blo.s	heapMalloc_small
	;; 
	;;	   // big-block	case (4..64	KB)
	;;	   if (sizeWanted >	maxChunkSize) return null;
	;;
	cmp.l	#maxChunkSize,d0
	bls.s	heapMalloc_big
	clr.l	d0
	move.l	d0,a0
	bra.s	heapMalloc_out
heapMalloc_big
	;; 
	;;	   if (heap.addBig(sizeWanted) != null)	return address;
	;; 
	bsr	heapAddBig
	bne.s	heapMalloc_out
	;;
	;;	   garbage();
	;;	   return heap.addBig(sizeWanted);
	;; }
	;; 
	bsr	garbage
	move.l	a2,a0
	move.l	d3,d0
	bsr	heapAddBig
	bra.s	heapMalloc_out
	;; 
heapMalloc_small
	;;
	;; if (heap.find(sizeWanted)) return address
	;; 
	bsr	heapFind
	bne.s	heapMalloc_out
	;;
	;; garbage()
	;;
	bsr	garbage
	;;
	;; if (heap.find(sizeWanted)) return address
	;; 
	move.l	a2,a0
	move.l	d3,d0
	bsr	heapFind
	bne.s	heapMalloc_out
	;;
	;; if (!heap.add())	return null
	;; 
	move.l	a2,a0
	bsr	heapAdd
	beq.s	heapMalloc_out
	;;
	;; if (heap.find(sizeWanted)) return address
	;;
	move.l	d3,d0
	move.l	a2,a0
	bsr	heapFind
	;;
heapMalloc_out
	movem.l	(a7)+,d3/a2
	rts

	
;;;	find free space	in heap
;;;	IN
;;;	d0.l = sizeWanted (in bytes)
;;;		a0	 = address of heap structure
;;;	OUT
;;;	a0	 = start-address of	memory chunk or	0
;;;	Z	 = free	space not found
heapFind
	movem.l	d3-d4/a2-a4,-(a7)
	move.l	a0,a3
	;; 
	;; stepWanted =	sizeWanted + 2	// extra size for 1	word: chunk.step
	;; 
	addq.l	#2,d0
	;; 
	;; adjust stepWanted to	next multiple of 8
	;; 
	addq.l	#7,d0
	and.l	#$fffffff8,d0
	;;
	;; if (heap.curBlock !=	null)
	;;
	tst.l	heapCurBlock(a3)
	beq.s	heapFind_from0
	;;
	;; block = heap.curBlock
	;; offset =	heap.curOffset
	;; chunk = block.begin + heap.curOffset
	;; spacePassed = 0
	;; goto	loopBody
	;;
	move.l	heapCurBlock(a3),a0
	move.w	heapCurOffset(a3),d1
	lea.l	blockBegin(a0,d1.w),a1
	clr.l	d3
	bra.s	heapFind_cloop
	;; 
heapFind_from0
	;; 
	;; for (a0/block=heap.first; block!=null; block=block.next)
	;; 
	move.l	heapFirst(a3),a0
	bra	heapFind_bloop_end
heapFind_bloop
	;; 
	;; for (a1/chunk=block.begin, d1/offset=0, d3/spacePassed=0; 
	;;		chunk.step!=0; 
	;;		chunk+=chunk.step, offset+=chunk.step)
	;; 
	lea.l	blockBegin(a0),a1
	clr.l	d1
	clr.l	d3
	bra	heapFind_cloop_end
heapFind_cloop
	;; 
	;; // LOOP BODY: a0=block, a1=chunk, a2=bitAddress,	a3=heap, a4=temp
	;; // d0=stepWanted, d1=offset,	d2=bitNo, d3=spacePassed, d4=temp
	;; 
	;; if (block.bits[offset/8]	!= 0) {
	;;	spacePassed	= 0; 
	;;	continue; }
	;; 
	move.w	d1,d2
	asr.w	#6,d2
	lea.l	blockBits(a0,d2.w),a2
	move.w	d1,d2
	asr.w	#3,d2
	btst.b	d2,(a2)
	beq.s	heapFind_cloop2
	clr.l	d3
	bra.s	heapFind_cloop_next
heapFind_cloop2
	;;
	;; if (spacePassed != 0) {
	;;	offset -= spacePassed;
	;;	chunk[-spacePassed].step = chunk.step +	spacePassed;
	;;	chunk -= spacePassed;
	;;	spacePassed	= 0;
	;;	goto heapFind_cloop; }
	;;
	tst.w	d3
	beq.s	heapFind_cloop3
	sub.w	d3,d1
	move.w	chunkStep(a1),d4
	sub.w	d3,a1
	add.w	d3,d4
	move.w	d4,chunkStep(a1)
	clr.l	d3
	bra.s	heapFind_cloop
heapFind_cloop3
	;;
	;; if (stepWanted >	chunk.step)	{
	;;	spacePassed	= chunk.step;
	;;	continue; }
	;;
	cmp.w	chunkStep(a1),d0
	bls.s	heapFind_cloop4
	move.w	chunkStep(a1),d3
	bra.s	heapFind_cloop_next
heapFind_cloop4
#ifdef CHECK_HEAP
	;;;	check bits are in range
	move.l	a2,-(a7)
	suba.l	a0,a2
	suba.w	#blockBits,a2
	cmpa.w	#blockBitsSize,a2
	bcs.s	heapFind_inRange
	trap	#8
heapFind_inRange
	move.l	(a7)+,a2
#endif
	;;
	;; // FOUND	A FREE CHUNK BIG ENOUGH	FOR	THE	REQUEST
	;; 
	;; block.bits[offset/8]	= 1;
	;; 
	bset.b	d2,(a2)
	;;
	;; // worth	splitting if at	least 16 bytes remain
	;; if (stepWanted <	chunk.step-8) {	 //	worth splitting?
	;; 
	move.w	chunkStep(a1),d4
	subq.w	#8,d4
	cmp.w	d4,d0
	bhi.s	heapFind_nosplit
	;; 
	;;		   a4/newChunk = chunk + stepWanted;
	;; 
	lea.l	0(a1,d0.w),a4
	;; 
	;;		   newChunk.step = chunk.step -	stepWanted;
	;;	   newChunk.word0 =	0
	;; 
	move.w	chunkStep(a1),d4
	sub.w	d0,d4
	move.w	d4,chunkStep(a4)
	clr.w	(a4)
	;; 
	;;		   chunk.step =	stepWanted;	 }
	;; 
	move.w	d0,chunkStep(a1)
heapFind_nosplit
	;;
	;;	   heap.curBlock = block
	;;	   heap.curOffset =	offset
	;;
	move.l	a0,heapCurBlock(a3)
	move.w	d1,heapCurOffset(a3)
	;;
	;;	   fill(chunk,0)
	;;	   return chunk
	;;
	move.l	a1,a0		; prepare return register
	move.w	chunkStep(a1),d0
	lsr.w	#2,d0
	subq.l	#2,d0		; first	4 bytes	cleared	before loop, -1	for	DBRA 
	clr.w	(a1)+
heapFind_fill
	clr.l	(a1)+		; clear	in 4-byte steps
	dbra	d0,heapFind_fill
	moveq.l	#1,d1		; clear	Z bit
	bra	heapFind_out
	;;
heapFind_cloop_next
	;; 
	;;	// for (...	chunk+=chunk.step, offset+=chunk.step)
	;;
	clr.l	d2
	move.w	chunkStep(a1),d2
	add.w	d2,d1
	add.l	d2,a1
heapFind_cloop_end
	;; 
	;;	// for (...	chunk.step!=0 ...)
	;; 
	tst.w	chunkStep(a1)
	bne	heapFind_cloop
	;; 
	;;	// for (...	block=block.next)
	;; 
	move.l	blockNext(a0),a0
heapFind_bloop_end
	;; 
	;;	// for (...	block!=null	...)
	;; 
	cmp.w	#0,a0
	bne	heapFind_bloop
	;;
	;; // NO CHUNK AVAILABLE
	;; heap.curBlock = 0
	;; heap.curOffset =	0
	;; 
	clr.l	heapCurBlock(a3)
	clr.w	heapCurOffset(a3)
	;;
	;; a0 is 0,	Z is set ->	ready to leave
	;; 
heapFind_out
	movem.l	(a7)+,d3-d4/a2-a4
	rts

	
;;;	add	a new block	to heap
;;;	IN
;;;	a0 = address of	heap structure
;;;	OUT
;;;	a0 = block address or 0
;;;	Z  = no	block available
heapAdd
	movem.l	a2-a3,-(a7)
	move.l	a0,a3
	;; 
	;; a0/block	= new Block()
	;;
#ifdef DM_HEAP
	;; Heap	in data	space (1) or in	dynamic	space (0)?
	tst.w	heapSpace(a3)
	bne.s	heapAdd_dmBlock
	mem.release
	systrap	MemPtrNew(#blockSize.l)
	mem.reserve.savereg
	bra.s	heapAdd_1
heapAdd_dmBlock
	move.l	#blockSize,d0
	bsr	allocDmBlock
heapAdd_1
#else 
	systrap	MemPtrNew(#blockSize.l)
#endif
	;;
	;; if (block==null)	return 0
	;; 
	cmp.w	#0,a0
	beq	heapAdd_out
	;;
	;; fill(block,0)
	;; 
	move.l	a0,a2
	move.w	#blockSize,d0
	bsr	memclear
	;; 
	;; ((chunk)	block.begin).step =	blockUsable
	;; 
	move.w	#blockUsable,blockBegin+chunkStep(a2)
	;;
	;; block.next =	heap.first
	;; heap.first =	block
	;; heap.curOffset =	0
	;; heap.curBlock = block
	;;
	move.l	heapFirst(a3),blockNext(a2)
	move.l	a2,heapFirst(a3)
	clr.w	heapCurOffset(a3)
	move.l	a2,heapCurBlock(a3)
	;;
	;; if (heap.minAddress == null)
	;;	   heap.MinAddress = &block.begin
	;;	   heap.MaxAddress = &block.size
	;;
	move.l	heapMinAddress(a3),d0
	bne.s	heapAdd_minmax
	lea.l	blockBegin(a2),a0
	move.l	a0,heapMinAddress(a3)
	lea.l	blockSize(a2),a0
	move.l	a0,heapMaxAddress(a3)
	bra.s	heapAdd_outA2
	;; 
heapAdd_minmax
	;;
	;; if (heap.minAddress > &block.begin) heap.minAddress = &block.begin
	;;
	lea.l	blockBegin(a2),a0
	cmp.l	a0,d0
	bls.s	heapAdd_minmax2
	move.l	a0,heapMinAddress(a3)
	;;
	;; if (heap.maxAddress < &block.size) heap.maxAddress =	&block.size
	;;
heapAdd_minmax2
	move.l	heapMaxAddress(a3),d0
	lea.l	blockSize(a2),a0
	cmp.l	a0,d0
	bhs.s	heapAdd_outA2
	move.l	a0,heapMaxAddress(a3)
	;; 
heapAdd_outA2	
	move.l	a2,a0
	;;
	;; a0 points to	new	block, Z is	not	set	-> ready to	leave
	;; 
heapAdd_out
	movem.l	(a7)+,a2-a3
	rts

	
;;;	add	to heap	a new big block	for	single-element allocation
;;;	IN
;;;	a0	 = address of heap structure
;;;	d0.l = sizeWanted
;;;	OUT
;;;	a0 = data address or 0
;;;	Z  = no	block available
heapAddBig
	movem.l	d3/a2-a3,-(a7)
	move.l	a0,a3
	;;
	;; // carefully	select size	
	;; nBigBlocks =	(sizeWanted	+ (bigBlockStep-blockUsable)) /	bigBlockStep + 1
	;; block = new Block (nBigBlocks * bigBlockStep)
	;; // a0=block
	;;
	add.l	#bigBlockStep-blockUsable,d0
	divu.w	#bigBlockStep,d0
	addq.w	#1,d0
	mulu.w	#bigBlockStep,d0
	cmp.l	#bigBlockMaxSize,d0
	blo.s	heapAddBig_below64k
	move.l	#bigBlockMaxSize,d0
heapAddBig_below64k
	move.l	d0,d3
#ifdef DM_HEAP
	;; Heap	in data	space (1) or in	dynamic	space (0)?
	tst.w	heapSpace(a3)
	bne.s	heapAddBig_dmBlock
	mem.release.savereg
	systrap	MemPtrNew(d0.l)
	mem.reserve.savereg
	bra.s	heapAddBig_1
heapAddBig_dmBlock
	bsr	allocDmBlock
heapAddBig_1
#else 
	systrap	MemPtrNew(d0.l)
#endif
	;;
	;; if (block==null)	return 0
	;; 
	cmp.w	#0,a0
	beq	heapAddBig_out
	;;
	;; fill(block,0)
	;; 
	move.l	a0,a2
	move.w	d3,d0
	bsr	memclear
	;; 
	;; ((chunk)	block.begin).step =	blockUsable
	;;
	move.w	d3,d0
	sub.w	#blockBegin,d0
	move.w	d0,blockBegin+chunkStep(a2)
	;;
	;; block.next =	heap.first
	;; heap.first =	block
	;;
	move.l	heapFirst(a3),blockNext(a2)
	move.l	a2,heapFirst(a3)
	;;
	;; if (heap.minAddress == null)
	;;	   heap.minAddress = &block.begin
	;;	   heap.maxAddress = &block.begin
	;;
	move.l	heapMinAddress(a3),d0
	bne.s	heapAddBig_minmax
	lea.l	blockBegin(a2),a0
	move.l	a0,heapMinAddress(a3)
	lea.l	blockBegin(a2),a0
	move.l	a0,heapMaxAddress(a3)
	bra.s	heapAddBig_outA2
	;; 
heapAddBig_minmax
	;;
	;; if (heap.minAddress > &block.begin) heap.minAddress = &block.begin
	;;
	lea.l	blockBegin(a2),a0
	cmp.l	a0,d0
	bls.s	heapAddBig_minmax2
	move.l	a0,heapMinAddress(a3)
	;;
	;; if (heap.maxAddress < &block.begin) heap.maxAddress = &block.size
	;;
heapAddBig_minmax2
	move.l	heapMaxAddress(a3),d0
	lea.l	blockBegin(a2),a0
	cmp.l	a0,d0
	bhs.s	heapAddBig_outA2
	move.l	a0,heapMaxAddress(a3)
	;; 
heapAddBig_outA2
	;;
	;; block.bits[0] = 1
	;; return &block.begin
	;;
	move.b	#1,blockBits(a2)
	lea.l	blockBegin(a2),a0
	;;
	;; a0 points to	new	block, Z is	not	set	-> ready to	leave
	;; 
heapAddBig_out
	movem.l	(a7)+,d3/a2-a3
	rts

;;;	clear all marks	in heap
;;;	IN
;;;	a0 = heap
;;;	OUT
;;;	nothing
;;;	DOES
;;;	clear mark bits	in all blocks of heap
heapUnmarkAll
	;;
	;; for (block=heap.first; block!=null; block=block.next)
	;; // a0=block
	;;
	move.l	heapFirst(a0),a0
	bra.s	heapUnmarkAll_loopEnd
heapUnmarkAll_loop
	;;
	;; fill(block.bits,	0)
	;; 
	lea.l	blockBits(a0),a1
	move.w	#blockBitsSize/16-1,d0
heapUnmarkAll_cloop
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	dbra	d0,heapUnmarkAll_cloop
	;;
	;; [ for (...; block!=null;	block=block.next) ]
	;;
	move.l	blockNext(a0),a0
heapUnmarkAll_loopEnd
	cmp.w	#0,a0
	bne.s	heapUnmarkAll_loop
	rts

;;;	reclaims free blocks from heap
;;;	IN
;;;	a0 = heap
;;;	OUT
;;;	nothing
;;;	DOES
;;;	gives unused blocks	back to	OS 
heapReclaim
	;;
	;; for (block=heap.first, chainPtr=&(heap.first); 
	;;		block!=null; 
	;;		)
	;; // a0=block,	a1=chainPtr
	;;
	move.l	a3,-(a7)
	move.l	a0,a3
	lea.l	heapFirst(a0),a1
	move.l	(a1),a0
	bra.s	heapReclaim_loopEnd
heapReclaim_loop
	;;
	;; if ((block.bits[0] == 0)	&&
	;;	   (((chunk) block.begin).step >= block.size - block.begin))
	;;
	tst.w	blockBits(a0)
	bne.s	heapReclaim_no
	move.w	blockBegin+chunkStep(a0),d0
	cmp.w	#blockUsable,d0
	blo.s	heapReclaim_no
#ifdef CHECK_HEAP
	move.l	a0,d1		; address
	and.l	#$FFFF,d0	; size
	movem.l	d0-d7/a0-a4,-(a7)
	lea.l	blockFreedMsg(pc),a0
	bsr		traceOutputL
	movem.l	(a7)+,d0-d7/a0-a4
#endif
	;;
	;;	   *chainPtr = block.next;
	;;	   free(block)
	;;	   block = *chainPtr;
	;;
	move.l	blockNext(a0),(a1)
	move.l	a1,-(a7)
#ifdef DM_HEAP
	bsr	releaseDmBlock
#else
	systrap	MemPtrFree(a0.l)
#endif
	move.l	(a7)+,a1
	move.l	(a1),a0
	; make sure	the	block we have freed
	; isn't	the	current	block for allocation
	clr.l	heapCurBlock(a3)
	clr.w	heapCurOffset(a3)
	bra.s	heapReclaim_loopEnd
	;;
	;; else
	;;	   chainPtr	= &(block.next)
	;;	   block=block.next
	;;
heapReclaim_no
	lea.l	blockNext(a0),a1
	move.l	blockNext(a0),a0
heapReclaim_loopEnd
	cmp.w	#0,a0
	bne.s	heapReclaim_loop
	;
	move.l	(a7)+,a3
	rts
	; (OLD_HEAP)
#endif

;;;	clone a	proxy-object from void pointer and size
;;;	IN:
;;;	a0	 = void	pointer
;;;	d0.l = size
;;;	OUT:
;;;	a0	 = proxy pointer
makeproxy:	
#ifdef DM_HEAP
	cmp.w	#0,a0
	beq.s	makeproxy_out
	movem.l	d3/a2,-(a7)
	move.l	d0,d3		; d3 = size
	addq.l	#6,d0		; d0 = total size (incl. ref-pointer)
	move.l	a0,a2		; a2 = source voidptr 
	bsr	allocProxyMem
	move.l	a2,(a0)+	; save ref-pointer at -6(proxy)
	move.w	d3,(a0)+	; save size	at -2(proxy)
	move.l	a2,a1
	move.l	a0,a2		; a2 = proxy ptr (return-value)
	move.l	d3,d0
	bsr	memcopy
	move.l	a2,a0
	movem.l	(a7)+,d3/a2
makeproxy_out
#endif
	rts

;;;	copy proxy-contents	back into object
;;;	IN:
;;;	a0 = proxy 
;;;	[ -6(a0).l = orig-pointer ]
;;;	[ -2(a0).w = size		  ]
;;;	OUT:
;;;	- nothing -
unproxy:
#ifdef DM_HEAP
	cmp.w	#0,a0
	beq.s	unproxy_out
#ifndef	OLD_HEAP
	move.l	a0,a1
	move.w	-2(a1),d0
	move.l	-6(a1),a0
	move.l	a1,-(a7)	; save proxy
	bsr	memcopy
	move.l	(a7)+,a1
	; restore offset from linked stack
	moveq.l	#0,d0
	move.l	proxyStackPtr(a5),a0
	move.w	-2(a0),d0
	sub.l	d0,a0	; new stack	pointer
#ifdef CHECK_PROXY
	;
	; check	that we	are	popping	what was pushed
	lea		-6(a1),a1
	cmp.l	a0,a1
	beq.s	unproxy_ok
	trap	#8
unproxy_ok
#endif
	add.w	d0,proxyStackSpace(a5)
	move.l	a0,proxyStackPtr(a5)
	cmp.l	proxyStackBlock(a5),a0
	bne.s	unproxy_out
	move.l	-(a0),d0
	beq.s	unproxy_out	; don't	free last block
	move.l	d0,proxyStackBlock(a5)
	move.l	-(a0),proxyStackPtr(a5)
	move.w	-(a0),proxyStackSpace(a5)
	systrap	MemPtrFree(a0.l)
#else
	move.l	a0,a1
	move.l	-6(a1),a0
	move.w	-2(a1),d0
	bsr	memcopy
#endif
unproxy_out
#endif
	rts
	
;;;	creates	a OutOfMemoryError object because we may not have the
;;;	memory later
;; uses-class java/lang/OutOfMemoryError as	_OOME_class
;; uses-instance java/lang/OutOfMemoryError
initHeap
#ifdef CHECK_HEAP
	bsr		traceInit
#endif
#ifdef DEBUG_HEAP
    systrap MemSetDebugMode(#memDebugModeScrambleOnChange.w)
#endif
#ifndef	OLD_HEAP
	clr.b	heapLocked(a5)
	; init timer for GC
	systrap	TimGetTicks()
	move.w	d0,lastGCTime(a5)
#endif
#ifdef DM_HEAP
	bsr		clearDmHeap
#endif
	move.l	#_OOME_class,d0
	bsr	op_new
	move.l	(a7)+,OutOfMemoryError_obj(a5)
	rts
	
clearHeap
#ifdef FINALIZERS
#ifndef OLD_HEAP
#ifndef NO_FINALIZE_ON_EXIT
	bsr		garbageCollect  ; PMD 2.1.7
	bsr		garbageFinalizeOnExit
#endif
#endif
#endif
	clr.l	OutOfMemoryError_obj(a5)
	bsr		clearDmHeap
#ifdef CHECK_HEAP
    lea checkHeapExit(pc),a0
    bsr traceOutputL
#endif
#ifdef MULTI_SEGMENT
    move.l  string_data(a5),-(a7)
    beq.s   clearHeap_no_strings
    trap    #15
    dc.w    sysTrapMemPtrFree
clearHeap_no_strings
    add     #4,a7
#endif
#ifdef DEBUG_HEAP
    systrap MemSetDebugMode(#0.w)
#endif
	rts

;;;	copy memory
;;;	IN:
;;;	a0 = destination
;;;	a1 = source
;;;	d0.w = bytecount
;;;	OUT:
;;;	- nothing -
memcopy:
	bra.s	memcopy_end
memcopy_loop
	move.b	(a1)+,(a0)+
memcopy_end
	dbra	d0,memcopy_loop
	rts
	
;;;	clear memory
;;;	IN:
;;;	a0 = destination
;;;	d0.w = bytecount
;;;	OUT:
;;;	- nothing -
;;;	KEEPS:
;;;	d1,d2,a1
memclear:
	;; zero	bytecount?
	tst.w	d0
	beq.s	memclear_out
	;; address even?
	exg 	d0,a0
	btst.l	#0,d0
	exg 	d0,a0
	; swap.w	d0		
	; move.w	a0,d0
	; swap.w	d0
	; btst.l	#16,d0
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
	;; rest	0 ... 7	bytes:	  d0 = -8 ... -1
	not.w	d0		; d0 =	7 ... 0
	asl.w	#1,d0		; d0 = 14 ... 0
	jmp	memclear_rest(pc,d0.w)
	;; 
	;; DO NOT CHANGE THE FOLLOWING 8 LINES !!!
memclear_rest
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)+
	;; DO NOT CHANGE THE 8 LINES ABOVE !!!
	;;
memclear_out
	rts

;;;	Default	exception catcher, displays	an error dialog
;;;	IN:
;;;	currentException(a5) = Throwable instance
;;;		 exceptionPC(a5) = initiating address
;;;					  a0 = classtable entry	for	Throwable instance
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
#ifndef OLD_HEAP
#ifdef FINALIZERS
	tst.b   heapLocked(a5)
	bne.s   catch_Any_heaped
#endif
#endif
#ifndef NO_STACKTRACE
	move.l  currentException(a5),-(a7)
;; uses-method java/lang/Throwable.printStackTrace()V as _T_printStackTrace
	bsr.far _T_printStackTrace
	add.l   #4,a7
#endif
	bsr		clearHeap	; make sure	heap is	clean on exit
catch_Any_heaped
	trap	#15
	dc.w	sysTrapErrDisplayFileLineMsg
	unlk    a6
	rts

;;;	get	method name	as char*
;;;	IN
;;;	a0 = pc-address
;;;	OUT
;;;	a0 = (char *) method name or 'unknown'
;;;	KEEPS
;;;	d2,	a1
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
	
;; dummy for unneeded methods. can be called virtually for
;; methods that	are	known to be	empty
M_none:
	rts

;; JVM opcode 'new'
;; d0 =	class index	for	new	instance
;; returns new instance	in (a7)
op_new:
	move.w	d0,-(a7)
	bsr	getclassinfo
	clr.l	d0
	move.w	ClassInfo.ObjectSizePlusHeader(a0),d0
#ifdef OLD_HEAP
	; old heap doesn't support finalizers
	bsr	allocMem
	beq.s	op_new_fail
#else
#ifdef FINALIZERS
	; need to set finalizer	bit	in header if Class needs it
	move.b	 ClassInfo.Flags(a0),-(a7)   ; finalizer flag	from Class
	bsr	allocMem
	beq.s	op_new_fail
	move.b	(a7)+,d0	; check	for	finalizer flag in msb
	bpl.s	op_new_done_finalize
	bset.b	#chunkHasFinalizerBit,ObjectHeader_ChunkSize+1(a0)
op_new_done_finalize
#else
	; no support for finalizers
	bsr	allocMem
	beq.s	op_new_fail
#endif
#endif
	move.w	(a7)+,ObjectHeader_ClassIndex(a0)
	move.l	(a7),a4
	move.l	a0,(a7)
	jmp	(a4)
op_new_fail
#ifdef FINALIZERS
	addq.l	#4,a7
#else
	addq.l	#2,a7
#endif
	bra.s	throw_OutOfMemoryError

;;;	throw a	newly-initialized NullPointerException
;;;	(a7) = initiator address
;; uses-class java/lang/NullPointerException as	_NPE_class
;; uses-instance java/lang/NullPointerException	
;; uses-method java/lang/NullPointerException.<init>()V	as _NPE_init
throw_NullPointerException:
	move.l	#_NPE_class,d0
	bsr	op_new
	bsr.far	_NPE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow

;;;	throw a	newly-initialized ClassCastException
;;;	(a7) = initiator address
;; uses-class java/lang/ClassCastException as _CCE_class
;; uses-instance java/lang/ClassCastException 
;; uses-method java/lang/ClassCastException.<init>()V as _CCE_init
throw_ClassCastException:
	move.l	#_CCE_class,d0
	bsr	op_new
	bsr.far	_CCE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow

;;;	throw a	newly-initialized OutOfMemoryError
;;;	(a7) = initiator address
;; uses-class java/lang/OutOfMemoryError as	_OOME_class
;; uses-instance java/lang/OutOfMemoryError
;; uses-method java/lang/OutOfMemoryError.<init>()V	as _OOME_init
throw_OutOfMemoryError:
	move.l	OutOfMemoryError_obj(a5),-(a7)
	bsr.far	_OOME_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
	
;;;	throw a	newly-initialized StackOverflowError
;;;	(a7) = initiator address
;; uses-class java/lang/StackOverflowError as _SOE_class
;; uses-instance java/lang/StackOverflowError
;; uses-method java/lang/StackOverflowError.<init>()V as _SOE_init
throw_StackOverflowError:
	move.l	#_SOE_class,d0
	bsr	op_new
	; bsr.far	_SOE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow

;;;	throw a	newly-initialized ArrayIndexOutOfBoundsException
;;;	(a7) = initiator address
;; uses-class java/lang/ArrayIndexOutOfBoundsException as _AIOOBE_class
;; uses-instance java/lang/ArrayIndexOutOfBoundsException 
;; uses-method java/lang/ArrayIndexOutOfBoundsException.<init>()V as _AIOOBE_init
throw_ArrayIndexOutOfBoundsException:
	move.l	#_AIOOBE_class,d0
	bsr	op_new
	bsr.far	_AIOOBE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
	
;;;	throw a	newly-initialized ArrayStoreException
;;;	(a7) = initiator address
;; uses-class java/lang/ArrayStoreException	as _ASE_class
;; uses-instance java/lang/ArrayStoreException 
;; uses-method java/lang/ArrayStoreException.<init>()V as _ASE_init
throw_ArrayStoreException:
	move.l	#_ASE_class,d0
	bsr	op_new
	bsr.far	_ASE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow

;;;	throw a	newly-initialized ArithmeticException
;;;	(a7) = initiator address
;; uses-class java/lang/ArithmeticException	as _AE_class
;; uses-instance java/lang/ArithmeticException 
;; uses-method java/lang/ArithmeticException.<init>()V as _AE_init
throw_ArithmeticException:
	move.l	#_AE_class,d0
	bsr	op_new
	bsr.far	_AE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow

;;;	throw a	newly-initialized NegativeArraySizeException
;;;	(a7) = initiator address
;; uses-class java/lang/NegativeArraySizeException as _NASE_class
;; uses-instance java/lang/NegativeArraySizeException 
;; uses-method java/lang/NegativeArraySizeException.<init>()V as _NASE_init
throw_NegativeArraySizeException:
	move.l	#_NASE_class,d0
	bsr	op_new
	bsr.far	_NASE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra	do_athrow
	
;;;	throw an exception
;;;	IN:	
;;;	a0 = exception instance
;;;	a1 = initiating	address
;;;	a6 = frame pointer of last full-featured stack frame
;;;	OUT	(to	most recent	method's exception-handler):
;;;	a0 = exception's ClassInfo structure
;;;	d2 = pc	in method's	code
;;;	DOES:
;;;	saves exception	instance in	  currentException(a5)
;;;	saves original initiator address in	  exceptionPC(a5)
;; needs-exact-layout java/lang/Throwable
;; uses-field  java/lang/Throwable.current_pc as _PC0
do_athrow:
#ifdef EXCEPTION_BREAK
    trap    #8  ; break to debugger when any exception is thrown
#endif
	move.l	a0,currentException(a5)
	move.l	a1,exceptionPC(a5)
#ifndef NO_STACKTRACE
	lea     _PC0(a0),a0
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
#endif
	bsr	getclassinfo_a0
	; unwind stackframe
    move.l	-4(a6),a1	; address of Mxx__exceptions handler
	jmp	(a1)
#ifdef DEBUG_SYMBOLS
    rts
	dc.b	$80,9,'do_athrow',0
	align	2
#endif

	data
currentException	dc.l	0
exceptionPC		dc.l	0
	enddata

;; uses-method java/lang/String.<init>([C)V	as String_init_$C_V
;; uses-class [C as	class_$C
;; uses-class java/lang/String as class_String
;; uses-instance java/lang/String
;; uses-field java/lang/String.value as	String_value
;; uses-field java/lang/String.count as	String_count
;; uses-field java/lang/String.offset as String_offset
;; uses-method java/lang/String.toCharArray()[C	as String_toCharArray
	
;;;	-------- Pascal-style (length +	chars) -> String
CharsToString:
	lea.l	DummyCharArray(a5),a1
	move.w	#class_$C,ObjectHeader_ClassIndex(a1)
	move.w	#1,Array.elsize(a1)
	move.w	(a0)+,Array.length(a1)
	move.l	a0,Array.data(a1)
	move.l	#class_String,d0
	bsr	op_new
	move.l	(a7),-(a7)
	lea.l	DummyCharArray(a5),a0
	move.l	a0,-(a7)
	bsr.far	String_init_$C_V
	lea.l	8(a7),a7
	move.l	(a7)+,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'CharsToString',0
	align	2
#endif

;;;	-------- C-style (chars	+ '\0')	-> String
;;;	IN:
;;;	a0 = C-style string	(char*)
;;;	OUT:
;;;	a0 = String	object
CharPtr_to_String:
	lea.l	DummyCharArray(a5),a1
	move.w	#class_$C,ObjectHeader_ClassIndex(a1)
	move.w	#1,Array.elsize(a1)
	move.l	a0,Array.data(a1)
	bsr	findNextNull
	move.l	a0,d0
	sub.l	Array.data(a1),d0
	move.w	d0,Array.length(a1)
	;; 
	;; return new String(dummyCharArray)
	move.l	#class_String,d0	; Class	java/lang/String
	bsr	op_new
	move.l	(a7),-(a7)
	lea.l	DummyCharArray(a5),a0
	move.l	a0,-(a7)
	bsr.far	String_init_$C_V	; Method java/lang/String.<init>([C)V
	lea.l	8(a7),a7
	move.l	(a7)+,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17,'CharPtr_to_String',0
	align	2
#endif

;;;	-------- String	-> C-style (chars +	'\0')
;;;	IN	
;;;	a0	 = Java	String instance
;;;	OUT
;;;	a0	 = (char *)	C-string
;;;	d0.l = length+1	(so	that it	includes the trailing zero)
StringToChars:
	move.l	String_value(a0),a1
	move.l	Array.data(a1),a1
	adda.l	String_offset(a0),a1
	move.l	String_count(a0),d0
	tst.b	0(a1,d0.l)
	bne.s	StringToChars_xxl
	addq.l	#1,d0
	move.l	a1,a0
	rts
StringToChars_xxl
	move.l	a0,-(a7)
	bsr.far	String_toCharArray
	addq.l	#4,a7
	clr.l	d0
	move.w	Array.length(a0),d0
	addq.l	#1,d0
	move.l	Array.data(a0),a0
	rts

;;;	find the next null byte	in memory
;;;	IN:
;;;	a0 = start address
;;;	OUT:
;;;	a0 = address of	next null byte
;;;	KEEPS:
;;;	a1,d0,d1,d2
findNextNull:
	tst.b	(a0)+
	bne.s	findNextNull
	subq.l	#1,a0
	rts
	
;;;	Mark string buffer length to match null byte
;;;	IN:
;;;	a1 = string buffer address
;;;	OUT:
;;;	StringBuffer.length set to null pos
;;;	
;; uses-field java/lang/StringBuffer.value as StringBuffer_value
;; uses-field java/lang/StringBuffer.count as StringBuffer_count
StringBuffer_setLength:
    move.l  a1,d0   ; check for null
    beq.s   StringBuffer_setLength_out
    move.l  StringBuffer_value(a1),a0
    move.l  Array.data(a0),a0
    move.l  a0,d0
    bsr.s   findNextNull
    sub.l   d0,a0
    move.l  a0,StringBuffer_count(a1)
StringBuffer_setLength_out
	rts
	
;; skeleton	character array, used in different places
	data
	ds.w	1   ; class index
DummyCharArray
	ds.w	1   ; length
	ds.w	1   ; elsize
	ds.l	1   ; data array
	code

;;;	check instance for possible	NullPointerException
;;;	a0 = instance
nonnull_check:
	cmp.w	#0,a0
	beq	throw_NullPointerException
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'nonnull_check',0
	align	2
#endif

;;;	check array	access for possible	NullPointerException
;;;	or ArrayIndexOutOfBoundsException
;;;	IN:	
;;;	a0 = array instance
;;;	d0 = index
;;;	OUT:
;;;	nothing	(throws	an exception in	case of	failure)
;;;	KEEPS:
;;;	a0,a1,d0,d2
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11,'array_check',0
	align	2
#endif

;;;	check aastore for possible NullPointerException
;;;	or ArrayIndexOutOfBoundsException
;;;	or ArrayStoreException
;;;	IN:	
;;;	12(a7) = array instance
;;;	 8(a7) = index
;;;	 4(a7) = value
;;;	OUT:
;;;	nothing	(throws	an exception in	case of	failure)
;;;	KEEPS:
;;;	d2
aastore_check:
	move.l	12(a7),a0
	move.l	8(a7),d0
	cmp.w	#0,a0
	beq	throw_NullPointerException
	clr.l	d1
	move.w	Array.length(a0),d1
	cmp.l	d1,d0
	bcc	throw_ArrayIndexOutOfBoundsException
#ifdef NO_AASTORE_CHECK
	; don't	do the time	consuming class	tests
#else
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
	;; check by	doing	btst #xxx,ClassInfo.yyy(a1)
	jsr	ClassInfo.AastoreCheck(a0)
	beq	throw_ArrayStoreException
aastore_check_ok
#endif
	rts	
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'aastore_check',0
	align	2
#endif

PilotMain1
	bra	PilotMain

;;;	returns	a pointer to the ClassInfo structure
;;;	for	an object -	Object.getClass()
;;;	IN	(getclassinfo_a0)
;;;	a0 = &object
;;;	IN	(getclassinfo)
;;;	d0 = classindex
;;;	OUT	  
;;;	a0 = &ClassInfo
;;;	KEEPS d1, d2, a1
getclassinfo_a0:
	move.w	ObjectHeader_ClassIndex(a0),d0
getclassinfo:
	mulu.w	#ClassInfo_size,d0
	lea	ClassTable(pc),a0
	add.l	d0,a0
	rts

;;;	converts a Jump	Object to a	void pointer for PalmOS.
;;;	Special	handling for String, StringBuffer and array.
;;;	In DM_HEAP mode, allocates a proxy as necessary.
;;;	IN
;;;	ToS	 = address of Jump object
;;;	OUT
;;;	a0	 = void	pointer
;;;	d0.l = size
;; uses-class java/lang/String as String_class
;; uses-class java/lang/StringBuffer as	StringBuffer_class
;; uses-field java/lang/StringBuffer.value as StringBuffer_value
getvoidptr:
	move.l	4(a7),a0
	cmp.w	#0,a0
	beq.s	getvoidptr_out
	cmp.w	#String_class,ObjectHeader_ClassIndex(a0)
	beq.s	getvoidptr_String
	cmp.w	#StringBuffer_class,ObjectHeader_ClassIndex(a0)
	beq.s	getvoidptr_StringBuffer
	bsr.s	getclassinfo_a0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_array,d0
	bne.s	getvoidptr_array
getvoidptr_object
	clr.l	d0
	move.w	ClassInfo.ObjectSizePlusHeader(a0),d0
#ifdef OLD_HEAP
	subq.w	#ObjectHeader_sizeof,d0
#endif
	move.l	4(a7),a0
	bra.s	getvoidptr_out
getvoidptr_array
	move.l	4(a7),a0
	move.w	Array.length(a0),d0
	mulu.w	Array.elsize(a0),d0
	move.l	Array.data(a0),a0
	bra.s	getvoidptr_out
getvoidptr_StringBuffer
	move.l	StringBuffer_value(a0),a0
	clr.l	d0
	move.w	Array.length(a0),d0
	move.l	Array.data(a0),a0
	bra.s	getvoidptr_out
getvoidptr_String
	bsr	StringToChars
getvoidptr_out
	rts

