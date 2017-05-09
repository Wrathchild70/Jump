; Created by MkApi for Jump 2.2.2
;; native-method palmos/Palm.nativeGetInt(I)I
	link	a6,#0
	move.l	8(a6),a0
	move.l	(a0),d0
	unlk	a6
	rts

;; native-method palmos/Palm.nativeGetShort(I)I
	link	a6,#0
	move.l	8(a6),a0
	move.w	(a0),d0
	ext.l	d0
	unlk	a6
	rts

;; native-method palmos/Palm.nativeGetByte(I)I
	link	a6,#0
	move.l	8(a6),a0
	move.b	(a0),d0
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts

;; native-method palmos/Palm.nativeObjectLock(Ljava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,d0
	unlk	a6
	rts

;; native-method palmos/Palm.nativeObjectAddress(Ljava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,d0
	unlk	a6
	rts

;; native-method palmos/Palm.nativeObjectLock(Ljava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,d0
	unlk	a6
	rts

;; native-method palmos/Palm.nativeSetInt(II)V
	link	a6,#0
	move.l	12(a6),a0
	move.l	8(a6),(a0)
	unlk	a6
	rts

;; native-method palmos/Palm.nativeSetShort(IS)V
	link	a6,#0
	move.l	12(a6),a0
	move.w	10(a6),(a0)
	unlk	a6
	rts

;; native-method palmos/Palm.nativeSetByte(IB)V
	link	a6,#0
	move.l	12(a6),a0
	move.b	11(a6),(a0)
	unlk	a6
	rts

;; native-method palmos/Palm.nativeObjectUnlock(Ljava/lang/Object;)V
	link	a6,#0
#ifdef DM_HEAP
	move.l	8(a6),a0
	proxy.release
#endif
	unlk	a6
	rts

;; native-method palmos/Palm.AlmGetAlarm(IILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapAlmGetAlarm
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.AlmGetAlarm
	dc.b	80,97,108,109,46,65,108,109,71,101,116,65,108,97,114,109,0,0
#endif

;; native-method palmos/Palm.AlmGetAlarm(IILjava/lang/Integer;)I
;; uses-method palmos/Palm.AlmGetAlarm(IILpalmos/IntHolder;)I as new_AlmGetAlarm
;; needs-exact-layout java/lang/Integer
	bra.far	new_AlmGetAlarm

;; native-method palmos/Palm.AlmSetAlarm(IIIIZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapAlmSetAlarm
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.AlmSetAlarm
	dc.b	80,97,108,109,46,65,108,109,83,101,116,65,108,97,114,109,0,0
#endif

;; native-method palmos/Palm.BmpCreate(IIILjava/lang/Object;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.b	19(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpCreate
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.BmpCreate
	dc.b	80,97,108,109,46,66,109,112,67,114,101,97,116,101,0,0
#endif

;; native-method palmos/Palm.BmpCreate(IIILjava/lang/Object;Ljava/lang/Short;)I
;; uses-method palmos/Palm.BmpCreate(IIILjava/lang/Object;Lpalmos/ShortHolder;)I as new_BmpCreate
;; needs-exact-layout java/lang/Short
	bra.far	new_BmpCreate

;; native-method palmos/Palm.BmpDelete(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpDelete
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.BmpDelete
	dc.b	80,97,108,109,46,66,109,112,68,101,108,101,116,101,0,0
#endif

;; native-method palmos/Palm.BmpCompress(II)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpCompress
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.BmpCompress
	dc.b	80,97,108,109,46,66,109,112,67,111,109,112,114,101,115,115,0,0
#endif

;; native-method palmos/Palm.BmpGetBits(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpGetBits
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.BmpGetBits
	dc.b	80,97,108,109,46,66,109,112,71,101,116,66,105,116,115,0
#endif

;; native-method palmos/Palm.BmpGetColortable(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpGetColortable
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.BmpGetColortable
	dc.b	80,97,108,109,46,66,109,112,71,101,116,67,111,108,111,114,116,97,98,108,101,0
#endif

;; native-method palmos/Palm.BmpSize(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpSize
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.BmpSize
	dc.b	80,97,108,109,46,66,109,112,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.BmpBitsSize(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpBitsSize
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.BmpBitsSize
	dc.b	80,97,108,109,46,66,109,112,66,105,116,115,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.BmpColortableSize(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapBmpColortableSize
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.BmpColortableSize
	dc.b	80,97,108,109,46,66,109,112,67,111,108,111,114,116,97,98,108,101,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.BmpGetNextBitmapAnyDensity(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpGetNextBitmapAnyDensity,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,31	; Debug Symbol Palm.BmpGetNextBitmapAnyDensity
	dc.b	80,97,108,109,46,66,109,112,71,101,116,78,101,120,116,66,105,116,109,97,112,65,110,121,68,101,110,115,105,116,121,0
#endif

;; native-method palmos/Palm.BmpGetVersion(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpGetVersion,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.BmpGetVersion
	dc.b	80,97,108,109,46,66,109,112,71,101,116,86,101,114,115,105,111,110,0,0
#endif

;; native-method palmos/Palm.BmpGetCompressionType(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpGetCompressionType,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.BmpGetCompressionType
	dc.b	80,97,108,109,46,66,109,112,71,101,116,67,111,109,112,114,101,115,115,105,111,110,84,121,112,101,0,0
#endif

;; native-method palmos/Palm.BmpGetDensity(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpGetDensity,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.BmpGetDensity
	dc.b	80,97,108,109,46,66,109,112,71,101,116,68,101,110,115,105,116,121,0,0
#endif

;; native-method palmos/Palm.BmpSetDensity(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpSetDensity,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.BmpSetDensity
	dc.b	80,97,108,109,46,66,109,112,83,101,116,68,101,110,115,105,116,121,0,0
#endif

;; native-method palmos/Palm.BmpGetTransparentValue(ILpalmos/IntHolder;)Z
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpGetTransparentValue,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.BmpGetTransparentValue
	dc.b	80,97,108,109,46,66,109,112,71,101,116,84,114,97,110,115,112,97,114,101,110,116,86,97,108,117,101,0
#endif

;; native-method palmos/Palm.BmpGetTransparentValue(ILjava/lang/Integer;)Z
;; uses-method palmos/Palm.BmpGetTransparentValue(ILpalmos/IntHolder;)Z as new_BmpGetTransparentValue
;; needs-exact-layout java/lang/Integer
	bra.far	new_BmpGetTransparentValue

;; native-method palmos/Palm.BmpSetTransparentValue(II)V
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpSetTransparentValue,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.BmpSetTransparentValue
	dc.b	80,97,108,109,46,66,109,112,83,101,116,84,114,97,110,115,112,97,114,101,110,116,86,97,108,117,101,0
#endif

;; native-method palmos/Palm.BmpCreateBitmapV3(IIILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorBmpCreateBitmapV3,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.BmpCreateBitmapV3
	dc.b	80,97,108,109,46,66,109,112,67,114,101,97,116,101,66,105,116,109,97,112,86,51,0,0
#endif

;; native-method palmos/Palm.CategoryCreateList(IIIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryCreateListV10
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.CategoryCreateList
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,67,114,101,97,116,101,76,105,115,116,0
#endif

;; native-method palmos/Palm.CategoryEdit(ILpalmos/ShortHolder;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryEditV10
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.CategoryEdit
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,69,100,105,116,0
#endif

;; native-method palmos/Palm.CategoryEdit(ILjava/lang/Short;)Z
;; uses-method palmos/Palm.CategoryEdit(ILpalmos/ShortHolder;)Z as new_CategoryEdit
;; needs-exact-layout java/lang/Short
	bra.far	new_CategoryEdit

;; native-method palmos/Palm.CategoryFind(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryFind
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.CategoryFind
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,70,105,110,100,0
#endif

;; native-method palmos/Palm.CategoryFreeList(II)V
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryFreeListV10
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.CategoryFreeList
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,70,114,101,101,76,105,115,116,0
#endif

;; native-method palmos/Palm.CategoryGetName(IILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryGetName
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.CategoryGetName
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,71,101,116,78,97,109,101,0,0
#endif

;; native-method palmos/Palm.CategoryGetNext(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryGetNext
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.CategoryGetNext
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,71,101,116,78,101,120,116,0,0
#endif

;; native-method palmos/Palm.CategoryTruncateName(Ljava/lang/String;I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryTruncateName
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.CategoryTruncateName
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,84,114,117,110,99,97,116,101,78,97,109,101,0
#endif

;; native-method palmos/Palm.CategorySetTriggerLabel(ILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategorySetTriggerLabel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.CategorySetTriggerLabel
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,83,101,116,84,114,105,103,103,101,114,76,97,98,101,108,0,0
#endif

;; native-method palmos/Palm.CategorySelect(IIIIZLpalmos/ShortHolder;Ljava/lang/String;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	19(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	move.l	28(a6),-(a7)
	move.l	32(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategorySelectV10
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.CategorySelect
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,83,101,108,101,99,116,0
#endif

;; native-method palmos/Palm.CategorySelect(IIIIZLjava/lang/Short;Ljava/lang/String;)Z
;; uses-method palmos/Palm.CategorySelect(IIIIZLpalmos/ShortHolder;Ljava/lang/String;)Z as new_CategorySelect
;; needs-exact-layout java/lang/Short
	bra.far	new_CategorySelect

;; native-method palmos/Palm.CategoryEdit(ILpalmos/ShortHolder;I)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryEditV20
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.CategoryEdit
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,69,100,105,116,0
#endif

;; native-method palmos/Palm.CategoryEdit(ILjava/lang/Short;I)Z
;; uses-method palmos/Palm.CategoryEdit(ILpalmos/ShortHolder;I)Z as new_CategoryEdit
;; needs-exact-layout java/lang/Short
	bra.far	new_CategoryEdit

;; native-method palmos/Palm.CategorySetName(IILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategorySetName
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.CategorySetName
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,83,101,116,78,97,109,101,0,0
#endif

;; native-method palmos/Palm.CategoryEdit(ILpalmos/ShortHolder;II)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCategoryEdit
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.CategoryEdit
	dc.b	80,97,108,109,46,67,97,116,101,103,111,114,121,69,100,105,116,0
#endif

;; native-method palmos/Palm.CategoryEdit(ILjava/lang/Short;II)Z
;; uses-method palmos/Palm.CategoryEdit(ILpalmos/ShortHolder;II)Z as new_CategoryEdit
;; needs-exact-layout java/lang/Short
	bra.far	new_CategoryEdit

;; native-method palmos/Palm.ClipboardAddItem(ILjava/lang/Object;I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.b	19(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapClipboardAddItem
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.ClipboardAddItem
	dc.b	80,97,108,109,46,67,108,105,112,98,111,97,114,100,65,100,100,73,116,101,109,0
#endif

;; native-method palmos/Palm.ClipboardGetItem(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	15(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapClipboardGetItem
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.ClipboardGetItem
	dc.b	80,97,108,109,46,67,108,105,112,98,111,97,114,100,71,101,116,73,116,101,109,0
#endif

;; native-method palmos/Palm.ClipboardGetItem(ILjava/lang/Short;)I
;; uses-method palmos/Palm.ClipboardGetItem(ILpalmos/ShortHolder;)I as new_ClipboardGetItem
;; needs-exact-layout java/lang/Short
	bra.far	new_ClipboardGetItem

;; native-method palmos/Palm.CtlDrawControl(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlDrawControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.CtlDrawControl
	dc.b	80,97,108,109,46,67,116,108,68,114,97,119,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.CtlEraseControl(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlEraseControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.CtlEraseControl
	dc.b	80,97,108,109,46,67,116,108,69,114,97,115,101,67,111,110,116,114,111,108,0,0
#endif

;; native-method palmos/Palm.CtlGetLabel(I)Ljava/lang/String;
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlGetLabel
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.CtlGetLabel
	dc.b	80,97,108,109,46,67,116,108,71,101,116,76,97,98,101,108,0,0
#endif

;; native-method palmos/Palm.CtlGetValue(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlGetValue
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.CtlGetValue
	dc.b	80,97,108,109,46,67,116,108,71,101,116,86,97,108,117,101,0,0
#endif

;; native-method palmos/Palm.CtlHandleEvent(ILpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.CtlHandleEvent
	dc.b	80,97,108,109,46,67,116,108,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.CtlHideControl(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlHideControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.CtlHideControl
	dc.b	80,97,108,109,46,67,116,108,72,105,100,101,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.CtlHitControl(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlHitControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.CtlHitControl
	dc.b	80,97,108,109,46,67,116,108,72,105,116,67,111,110,116,114,111,108,0,0
#endif

;; native-method palmos/Palm.CtlEnabled(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlEnabled
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.CtlEnabled
	dc.b	80,97,108,109,46,67,116,108,69,110,97,98,108,101,100,0
#endif

;; native-method palmos/Palm.CtlSetEnabled(IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlSetEnabled
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.CtlSetEnabled
	dc.b	80,97,108,109,46,67,116,108,83,101,116,69,110,97,98,108,101,100,0,0
#endif

;; native-method palmos/Palm.CtlSetLabel(ILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlSetLabel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.CtlSetLabel
	dc.b	80,97,108,109,46,67,116,108,83,101,116,76,97,98,101,108,0,0
#endif

;; native-method palmos/Palm.CtlSetUsable(IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlSetUsable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.CtlSetUsable
	dc.b	80,97,108,109,46,67,116,108,83,101,116,85,115,97,98,108,101,0
#endif

;; native-method palmos/Palm.CtlSetValue(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlSetValue
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.CtlSetValue
	dc.b	80,97,108,109,46,67,116,108,83,101,116,86,97,108,117,101,0,0
#endif

;; native-method palmos/Palm.CtlShowControl(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCtlShowControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.CtlShowControl
	dc.b	80,97,108,109,46,67,116,108,83,104,111,119,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.DlkGetSyncInfo(Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/ByteHolder;Ljava/lang/StringBuffer;Ljava/lang/StringBuffer;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ByteHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	28(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapDlkGetSyncInfo
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-24(a6),a0
	proxy.release
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	12(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	16(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DlkGetSyncInfo
	dc.b	80,97,108,109,46,68,108,107,71,101,116,83,121,110,99,73,110,102,111,0
#endif

;; native-method palmos/Palm.DlkGetSyncInfo(Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Byte;Ljava/lang/StringBuffer;Ljava/lang/StringBuffer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DlkGetSyncInfo(Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/ByteHolder;Ljava/lang/StringBuffer;Ljava/lang/StringBuffer;Lpalmos/IntHolder;)I as new_DlkGetSyncInfo
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Byte
;; needs-exact-layout java/lang/Integer
	bra.far	new_DlkGetSyncInfo

;; native-method palmos/Palm.DlkGetSyncInfoUserName(IIILjava/lang/StringBuffer;II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
	move.l	24(a6),-(a7)
	move.l	28(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDlkGetSyncInfo
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
#endif
	move.l	16(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.DlkGetSyncInfoUserName
	dc.b	80,97,108,109,46,68,108,107,71,101,116,83,121,110,99,73,110,102,111,85,115,101,114,78,97,109,101,0
#endif

;; native-method palmos/Palm.DmArchiveRecord(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmArchiveRecord
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.DmArchiveRecord
	dc.b	80,97,108,109,46,68,109,65,114,99,104,105,118,101,82,101,99,111,114,100,0,0
#endif

;; native-method palmos/Palm.DmAttachRecord(ILpalmos/ShortHolder;ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmAttachRecord
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmAttachRecord
	dc.b	80,97,108,109,46,68,109,65,116,116,97,99,104,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmAttachRecord(ILjava/lang/Short;ILjava/lang/Integer;)I
;; uses-method palmos/Palm.DmAttachRecord(ILpalmos/ShortHolder;ILpalmos/IntHolder;)I as new_DmAttachRecord
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmAttachRecord

;; native-method palmos/Palm.DmAttachResource(IIII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmAttachResource
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmAttachResource
	dc.b	80,97,108,109,46,68,109,65,116,116,97,99,104,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmCloseDatabase(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmCloseDatabase
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.DmCloseDatabase
	dc.b	80,97,108,109,46,68,109,67,108,111,115,101,68,97,116,97,98,97,115,101,0,0
#endif

;; native-method palmos/Palm.DmCreateDatabase(ILjava/lang/String;IIZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmCreateDatabase
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmCreateDatabase
	dc.b	80,97,108,109,46,68,109,67,114,101,97,116,101,68,97,116,97,98,97,115,101,0
#endif

;; native-method palmos/Palm.DmCreateDatabaseFromImage(Ljava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmCreateDatabaseFromImage
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,30	; Debug Symbol Palm.DmCreateDatabaseFromImage
	dc.b	80,97,108,109,46,68,109,67,114,101,97,116,101,68,97,116,97,98,97,115,101,70,114,111,109,73,109,97,103,101,0,0
#endif

;; native-method palmos/Palm.DmDatabaseInfo(IILjava/lang/StringBuffer;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	28(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	32(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	36(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	40(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	44(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	48(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	52(a6),-(a7)
	move.w	58(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDatabaseInfo
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-44(a6),a0
	proxy.release
	move.l	-40(a6),a0
	proxy.release
	move.l	-36(a6),a0
	proxy.release
	move.l	-32(a6),a0
	proxy.release
	move.l	-28(a6),a0
	proxy.release
	move.l	-24(a6),a0
	proxy.release
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	48(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmDatabaseInfo
	dc.b	80,97,108,109,46,68,109,68,97,116,97,98,97,115,101,73,110,102,111,0
#endif

;; native-method palmos/Palm.DmDatabaseInfo(IILjava/lang/StringBuffer;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmDatabaseInfo(IILjava/lang/StringBuffer;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_DmDatabaseInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmDatabaseInfo

;; native-method palmos/Palm.DmDatabaseSize(IILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDatabaseSize
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmDatabaseSize
	dc.b	80,97,108,109,46,68,109,68,97,116,97,98,97,115,101,83,105,122,101,0
#endif

;; native-method palmos/Palm.DmDatabaseSize(IILjava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmDatabaseSize(IILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_DmDatabaseSize
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmDatabaseSize

;; native-method palmos/Palm.DmDeleteDatabase(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDeleteDatabase
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmDeleteDatabase
	dc.b	80,97,108,109,46,68,109,68,101,108,101,116,101,68,97,116,97,98,97,115,101,0
#endif

;; native-method palmos/Palm.DmDeleteRecord(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDeleteRecord
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmDeleteRecord
	dc.b	80,97,108,109,46,68,109,68,101,108,101,116,101,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmDetachRecord(IILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDetachRecord
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmDetachRecord
	dc.b	80,97,108,109,46,68,109,68,101,116,97,99,104,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmDetachRecord(IILjava/lang/Integer;)I
;; uses-method palmos/Palm.DmDetachRecord(IILpalmos/IntHolder;)I as new_DmDetachRecord
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmDetachRecord

;; native-method palmos/Palm.DmDetachResource(IILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDetachResource
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmDetachResource
	dc.b	80,97,108,109,46,68,109,68,101,116,97,99,104,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmDetachResource(IILjava/lang/Integer;)I
;; uses-method palmos/Palm.DmDetachResource(IILpalmos/IntHolder;)I as new_DmDetachResource
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmDetachResource

;; native-method palmos/Palm.DmFindDatabase(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmFindDatabase
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmFindDatabase
	dc.b	80,97,108,109,46,68,109,70,105,110,100,68,97,116,97,98,97,115,101,0
#endif

;; native-method palmos/Palm.DmFindRecordByID(IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmFindRecordByID
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmFindRecordByID
	dc.b	80,97,108,109,46,68,109,70,105,110,100,82,101,99,111,114,100,66,121,73,68,0
#endif

;; native-method palmos/Palm.DmFindRecordByID(IILjava/lang/Short;)I
;; uses-method palmos/Palm.DmFindRecordByID(IILpalmos/ShortHolder;)I as new_DmFindRecordByID
;; needs-exact-layout java/lang/Short
	bra.far	new_DmFindRecordByID

;; native-method palmos/Palm.DmFindResource(IIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmFindResource
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmFindResource
	dc.b	80,97,108,109,46,68,109,70,105,110,100,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmFindResourceType(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmFindResourceType
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.DmFindResourceType
	dc.b	80,97,108,109,46,68,109,70,105,110,100,82,101,115,111,117,114,99,101,84,121,112,101,0
#endif

;; native-method palmos/Palm.DmGetAppInfoID(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGetAppInfoID
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmGetAppInfoID
	dc.b	80,97,108,109,46,68,109,71,101,116,65,112,112,73,110,102,111,73,68,0
#endif

;; native-method palmos/Palm.DmGetDatabase(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGetDatabase
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.DmGetDatabase
	dc.b	80,97,108,109,46,68,109,71,101,116,68,97,116,97,98,97,115,101,0,0
#endif

;; native-method palmos/Palm.DmGetLastErr()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapDmGetLastErr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.DmGetLastErr
	dc.b	80,97,108,109,46,68,109,71,101,116,76,97,115,116,69,114,114,0
#endif

;; native-method palmos/Palm.DmGetNextDatabaseByTypeCreator(ZLpalmos/DmSearchState;IIZLpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/DmSearchState
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	19(a6),-(a7)
	move.l	20(a6),-(a7)
	move.l	24(a6),-(a7)
	move.l	28(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	35(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGetNextDatabaseByTypeCreator
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-22(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,35	; Debug Symbol Palm.DmGetNextDatabaseByTypeCreator
	dc.b	80,97,108,109,46,68,109,71,101,116,78,101,120,116,68,97,116,97,98,97,115,101,66,121,84,121,112,101,67,114,101,97,116,111,114,0
#endif

;; native-method palmos/Palm.DmGetNextDatabaseByTypeCreator(ZLpalmos/DmSearchState;IIZLjava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmGetNextDatabaseByTypeCreator(ZLpalmos/DmSearchState;IIZLpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_DmGetNextDatabaseByTypeCreator
;; needs-exact-layout palmos/DmSearchState
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmGetNextDatabaseByTypeCreator

;; native-method palmos/Palm.DmGetRecord(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGetRecord
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.DmGetRecord
	dc.b	80,97,108,109,46,68,109,71,101,116,82,101,99,111,114,100,0,0
#endif

;; native-method palmos/Palm.DmGetResource(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGetResource
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.DmGetResource
	dc.b	80,97,108,109,46,68,109,71,101,116,82,101,115,111,117,114,99,101,0,0
#endif

;; native-method palmos/Palm.DmGetResourceIndex(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGetResourceIndex
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.DmGetResourceIndex
	dc.b	80,97,108,109,46,68,109,71,101,116,82,101,115,111,117,114,99,101,73,110,100,101,120,0
#endif

;; native-method palmos/Palm.DmGet1Resource(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmGet1Resource
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmGet1Resource
	dc.b	80,97,108,109,46,68,109,71,101,116,49,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmMoveCategory(IIIZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmMoveCategory
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmMoveCategory
	dc.b	80,97,108,109,46,68,109,77,111,118,101,67,97,116,101,103,111,114,121,0
#endif

;; native-method palmos/Palm.DmMoveRecord(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmMoveRecord
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.DmMoveRecord
	dc.b	80,97,108,109,46,68,109,77,111,118,101,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmNewHandle(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNewHandle
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.DmNewHandle
	dc.b	80,97,108,109,46,68,109,78,101,119,72,97,110,100,108,101,0,0
#endif

;; native-method palmos/Palm.DmNextOpenDatabase(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNextOpenDatabase
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.DmNextOpenDatabase
	dc.b	80,97,108,109,46,68,109,78,101,120,116,79,112,101,110,68,97,116,97,98,97,115,101,0
#endif

;; native-method palmos/Palm.DmNextOpenResDatabase(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNextOpenResDatabase
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.DmNextOpenResDatabase
	dc.b	80,97,108,109,46,68,109,78,101,120,116,79,112,101,110,82,101,115,68,97,116,97,98,97,115,101,0,0
#endif

;; native-method palmos/Palm.DmNewRecord(ILpalmos/ShortHolder;I)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNewRecord
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.DmNewRecord
	dc.b	80,97,108,109,46,68,109,78,101,119,82,101,99,111,114,100,0,0
#endif

;; native-method palmos/Palm.DmNewRecord(ILjava/lang/Short;I)I
;; uses-method palmos/Palm.DmNewRecord(ILpalmos/ShortHolder;I)I as new_DmNewRecord
;; needs-exact-layout java/lang/Short
	bra.far	new_DmNewRecord

;; native-method palmos/Palm.DmNewResource(IIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNewResource
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.DmNewResource
	dc.b	80,97,108,109,46,68,109,78,101,119,82,101,115,111,117,114,99,101,0,0
#endif

;; native-method palmos/Palm.DmNumDatabases(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNumDatabases
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmNumDatabases
	dc.b	80,97,108,109,46,68,109,78,117,109,68,97,116,97,98,97,115,101,115,0
#endif

;; native-method palmos/Palm.DmNumRecords(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNumRecords
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.DmNumRecords
	dc.b	80,97,108,109,46,68,109,78,117,109,82,101,99,111,114,100,115,0
#endif

;; native-method palmos/Palm.DmNumRecordsInCategory(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNumRecordsInCategory
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.DmNumRecordsInCategory
	dc.b	80,97,108,109,46,68,109,78,117,109,82,101,99,111,114,100,115,73,110,67,97,116,101,103,111,114,121,0
#endif

;; native-method palmos/Palm.DmNumResources(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmNumResources
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmNumResources
	dc.b	80,97,108,109,46,68,109,78,117,109,82,101,115,111,117,114,99,101,115,0
#endif

;; native-method palmos/Palm.DmOpenDatabase(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmOpenDatabase
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmOpenDatabase
	dc.b	80,97,108,109,46,68,109,79,112,101,110,68,97,116,97,98,97,115,101,0
#endif

;; native-method palmos/Palm.DmOpenDatabaseByTypeCreator(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmOpenDatabaseByTypeCreator
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,32	; Debug Symbol Palm.DmOpenDatabaseByTypeCreator
	dc.b	80,97,108,109,46,68,109,79,112,101,110,68,97,116,97,98,97,115,101,66,121,84,121,112,101,67,114,101,97,116,111,114,0,0
#endif

;; native-method palmos/Palm.DmOpenDatabaseInfo(ILpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	28(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmOpenDatabaseInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.DmOpenDatabaseInfo
	dc.b	80,97,108,109,46,68,109,79,112,101,110,68,97,116,97,98,97,115,101,73,110,102,111,0
#endif

;; native-method palmos/Palm.DmOpenDatabaseInfo(ILjava/lang/Integer;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)I
;; uses-method palmos/Palm.DmOpenDatabaseInfo(ILpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I as new_DmOpenDatabaseInfo
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_DmOpenDatabaseInfo

;; native-method palmos/Palm.DmPositionInCategory(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmPositionInCategory
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.DmPositionInCategory
	dc.b	80,97,108,109,46,68,109,80,111,115,105,116,105,111,110,73,110,67,97,116,101,103,111,114,121,0
#endif

;; native-method palmos/Palm.DmQueryNextInCategory(ILpalmos/ShortHolder;I)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmQueryNextInCategory
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.DmQueryNextInCategory
	dc.b	80,97,108,109,46,68,109,81,117,101,114,121,78,101,120,116,73,110,67,97,116,101,103,111,114,121,0,0
#endif

;; native-method palmos/Palm.DmQueryNextInCategory(ILjava/lang/Short;I)I
;; uses-method palmos/Palm.DmQueryNextInCategory(ILpalmos/ShortHolder;I)I as new_DmQueryNextInCategory
;; needs-exact-layout java/lang/Short
	bra.far	new_DmQueryNextInCategory

;; native-method palmos/Palm.DmQueryRecord(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmQueryRecord
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.DmQueryRecord
	dc.b	80,97,108,109,46,68,109,81,117,101,114,121,82,101,99,111,114,100,0,0
#endif

;; native-method palmos/Palm.DmRecordInfo(IILpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmRecordInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.DmRecordInfo
	dc.b	80,97,108,109,46,68,109,82,101,99,111,114,100,73,110,102,111,0
#endif

;; native-method palmos/Palm.DmRecordInfo(IILjava/lang/Short;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmRecordInfo(IILpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_DmRecordInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmRecordInfo

;; native-method palmos/Palm.DmResourceInfo(IILpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmResourceInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmResourceInfo
	dc.b	80,97,108,109,46,68,109,82,101,115,111,117,114,99,101,73,110,102,111,0
#endif

;; native-method palmos/Palm.DmResourceInfo(IILjava/lang/Integer;Ljava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmResourceInfo(IILpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_DmResourceInfo
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmResourceInfo

;; native-method palmos/Palm.DmReleaseRecord(IIZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmReleaseRecord
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.DmReleaseRecord
	dc.b	80,97,108,109,46,68,109,82,101,108,101,97,115,101,82,101,99,111,114,100,0,0
#endif

;; native-method palmos/Palm.DmReleaseResource(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmReleaseResource
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.DmReleaseResource
	dc.b	80,97,108,109,46,68,109,82,101,108,101,97,115,101,82,101,115,111,117,114,99,101,0,0
#endif

;; native-method palmos/Palm.DmRemoveRecord(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmRemoveRecord
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmRemoveRecord
	dc.b	80,97,108,109,46,68,109,82,101,109,111,118,101,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmRemoveResource(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmRemoveResource
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmRemoveResource
	dc.b	80,97,108,109,46,68,109,82,101,109,111,118,101,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmRemoveSecretRecords(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmRemoveSecretRecords
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.DmRemoveSecretRecords
	dc.b	80,97,108,109,46,68,109,82,101,109,111,118,101,83,101,99,114,101,116,82,101,99,111,114,100,115,0,0
#endif

;; native-method palmos/Palm.DmResetRecordStates(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmResetRecordStates
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.DmResetRecordStates
	dc.b	80,97,108,109,46,68,109,82,101,115,101,116,82,101,99,111,114,100,83,116,97,116,101,115,0,0
#endif

;; native-method palmos/Palm.DmResizeRecord(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmResizeRecord
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmResizeRecord
	dc.b	80,97,108,109,46,68,109,82,101,115,105,122,101,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmResizeResource(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmResizeResource
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmResizeResource
	dc.b	80,97,108,109,46,68,109,82,101,115,105,122,101,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmSearchRecord(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSearchRecord
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DmSearchRecord
	dc.b	80,97,108,109,46,68,109,83,101,97,114,99,104,82,101,99,111,114,100,0
#endif

;; native-method palmos/Palm.DmSearchRecord(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.DmSearchRecord(ILpalmos/IntHolder;)I as new_DmSearchRecord
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmSearchRecord

;; native-method palmos/Palm.DmSearchResource(IIILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSearchResource
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmSearchResource
	dc.b	80,97,108,109,46,68,109,83,101,97,114,99,104,82,101,115,111,117,114,99,101,0
#endif

;; native-method palmos/Palm.DmSearchResource(IIILjava/lang/Integer;)I
;; uses-method palmos/Palm.DmSearchResource(IIILpalmos/IntHolder;)I as new_DmSearchResource
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmSearchResource

;; native-method palmos/Palm.DmSeekRecordInCategory(ILpalmos/ShortHolder;III)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSeekRecordInCategory
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.DmSeekRecordInCategory
	dc.b	80,97,108,109,46,68,109,83,101,101,107,82,101,99,111,114,100,73,110,67,97,116,101,103,111,114,121,0
#endif

;; native-method palmos/Palm.DmSeekRecordInCategory(ILjava/lang/Short;III)I
;; uses-method palmos/Palm.DmSeekRecordInCategory(ILpalmos/ShortHolder;III)I as new_DmSeekRecordInCategory
;; needs-exact-layout java/lang/Short
	bra.far	new_DmSeekRecordInCategory

;; native-method palmos/Palm.DmSet(Ljava/lang/Object;III)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSet
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-14(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,10	; Debug Symbol Palm.DmSet
	dc.b	80,97,108,109,46,68,109,83,101,116,0,0
#endif

;; native-method palmos/Palm.DmSetDatabaseInfo(IILjava/lang/String;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	28(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	32(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	36(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	40(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	44(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	48(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	52(a6),-(a7)
	move.w	58(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSetDatabaseInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-40(a6),a0
	proxy.release
	move.l	-36(a6),a0
	proxy.release
	move.l	-32(a6),a0
	proxy.release
	move.l	-28(a6),a0
	proxy.release
	move.l	-24(a6),a0
	proxy.release
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.DmSetDatabaseInfo
	dc.b	80,97,108,109,46,68,109,83,101,116,68,97,116,97,98,97,115,101,73,110,102,111,0,0
#endif

;; native-method palmos/Palm.DmSetDatabaseInfo(IILjava/lang/String;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmSetDatabaseInfo(IILjava/lang/String;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_DmSetDatabaseInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmSetDatabaseInfo

;; native-method palmos/Palm.DmSetRecordInfo(IILpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSetRecordInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.DmSetRecordInfo
	dc.b	80,97,108,109,46,68,109,83,101,116,82,101,99,111,114,100,73,110,102,111,0,0
#endif

;; native-method palmos/Palm.DmSetRecordInfo(IILjava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.DmSetRecordInfo(IILpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_DmSetRecordInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_DmSetRecordInfo

;; native-method palmos/Palm.DmSetResourceInfo(IILpalmos/IntHolder;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmSetResourceInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.DmSetResourceInfo
	dc.b	80,97,108,109,46,68,109,83,101,116,82,101,115,111,117,114,99,101,73,110,102,111,0,0
#endif

;; native-method palmos/Palm.DmSetResourceInfo(IILjava/lang/Integer;Ljava/lang/Short;)I
;; uses-method palmos/Palm.DmSetResourceInfo(IILpalmos/IntHolder;Lpalmos/ShortHolder;)I as new_DmSetResourceInfo
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
	bra.far	new_DmSetResourceInfo

;; native-method palmos/Palm.DmStrCopy(Ljava/lang/Object;ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmStrCopy
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.DmStrCopy
	dc.b	80,97,108,109,46,68,109,83,116,114,67,111,112,121,0,0
#endif

;; native-method palmos/Palm.DmWrite(Ljava/lang/Object;ILjava/lang/Object;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmWrite
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.DmWrite
	dc.b	80,97,108,109,46,68,109,87,114,105,116,101,0,0
#endif

;; native-method palmos/Palm.DmWrite(IILjava/lang/Object;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmWrite
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.DmWrite
	dc.b	80,97,108,109,46,68,109,87,114,105,116,101,0,0
#endif

;; native-method palmos/Palm.DmWrite(Ljava/lang/Object;I[BII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmWrite
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.DmWrite
	dc.b	80,97,108,109,46,68,109,87,114,105,116,101,0,0
#endif

;; native-method palmos/Palm.DmWrite(II[BII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmWrite
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.DmWrite
	dc.b	80,97,108,109,46,68,109,87,114,105,116,101,0,0
#endif

;; native-method palmos/Palm.DmWriteCheck(Ljava/lang/Object;II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmWriteCheck
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.DmWriteCheck
	dc.b	80,97,108,109,46,68,109,87,114,105,116,101,67,104,101,99,107,0
#endif

;; native-method palmos/Palm.DmDeleteCategory(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDmDeleteCategory
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.DmDeleteCategory
	dc.b	80,97,108,109,46,68,109,68,101,108,101,116,101,67,97,116,101,103,111,114,121,0
#endif

;; native-method palmos/Palm.ErrDisplayFileLineMsg(Ljava/lang/String;ILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapErrDisplayFileLineMsg
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.ErrDisplayFileLineMsg
	dc.b	80,97,108,109,46,69,114,114,68,105,115,112,108,97,121,70,105,108,101,76,105,110,101,77,115,103,0,0
#endif

;; native-method palmos/Palm.EvtAddEventToQueue(Lpalmos/Event;)V
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtAddEventToQueue
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.EvtAddEventToQueue
	dc.b	80,97,108,109,46,69,118,116,65,100,100,69,118,101,110,116,84,111,81,117,101,117,101,0
#endif

;; native-method palmos/Palm.EvtCopyEvent(Lpalmos/Event;Lpalmos/Event;)V
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtCopyEvent
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.EvtCopyEvent
	dc.b	80,97,108,109,46,69,118,116,67,111,112,121,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.EvtDequeuePenPoint(Lpalmos/PointType;)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtDequeuePenPoint
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.EvtDequeuePenPoint
	dc.b	80,97,108,109,46,69,118,116,68,101,113,117,101,117,101,80,101,110,80,111,105,110,116,0
#endif

;; native-method palmos/Palm.EvtDequeuePenStrokeInfo(Lpalmos/PointType;Lpalmos/PointType;)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtDequeuePenStrokeInfo
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.EvtDequeuePenStrokeInfo
	dc.b	80,97,108,109,46,69,118,116,68,101,113,117,101,117,101,80,101,110,83,116,114,111,107,101,73,110,102,111,0,0
#endif

;; native-method palmos/Palm.EvtEnableGraffiti(Z)V
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapEvtEnableGraffiti
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.EvtEnableGraffiti
	dc.b	80,97,108,109,46,69,118,116,69,110,97,98,108,101,71,114,97,102,102,105,116,105,0,0
#endif

;; native-method palmos/Palm.EvtEnqueueKey(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapEvtEnqueueKey
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.EvtEnqueueKey
	dc.b	80,97,108,109,46,69,118,116,69,110,113,117,101,117,101,75,101,121,0,0
#endif

;; native-method palmos/Palm.EvtFlushKeyQueue()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtFlushKeyQueue
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.EvtFlushKeyQueue
	dc.b	80,97,108,109,46,69,118,116,70,108,117,115,104,75,101,121,81,117,101,117,101,0
#endif

;; native-method palmos/Palm.EvtFlushNextPenStroke()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtFlushNextPenStroke
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.EvtFlushNextPenStroke
	dc.b	80,97,108,109,46,69,118,116,70,108,117,115,104,78,101,120,116,80,101,110,83,116,114,111,107,101,0,0
#endif

;; native-method palmos/Palm.EvtFlushPenQueue()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtFlushPenQueue
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.EvtFlushPenQueue
	dc.b	80,97,108,109,46,69,118,116,70,108,117,115,104,80,101,110,81,117,101,117,101,0
#endif

;; native-method palmos/Palm.EvtGetEvent(Lpalmos/Event;I)V
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtGetEvent
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.EvtGetEvent
	dc.b	80,97,108,109,46,69,118,116,71,101,116,69,118,101,110,116,0,0
#endif

;; native-method palmos/Palm.EvtGetPen(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtGetPen
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.EvtGetPen
	dc.b	80,97,108,109,46,69,118,116,71,101,116,80,101,110,0,0
#endif

;; native-method palmos/Palm.EvtGetPen(Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)V
;; uses-method palmos/Palm.EvtGetPen(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V as new_EvtGetPen
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_EvtGetPen

;; native-method palmos/Palm.EvtKeyQueueEmpty()Z
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtKeyQueueEmpty
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.EvtKeyQueueEmpty
	dc.b	80,97,108,109,46,69,118,116,75,101,121,81,117,101,117,101,69,109,112,116,121,0
#endif

;; native-method palmos/Palm.EvtKeyQueueSize()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtKeyQueueSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.EvtKeyQueueSize
	dc.b	80,97,108,109,46,69,118,116,75,101,121,81,117,101,117,101,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.EvtPenQueueSize()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtPenQueueSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.EvtPenQueueSize
	dc.b	80,97,108,109,46,69,118,116,80,101,110,81,117,101,117,101,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.EvtProcessSoftKeyStroke(Lpalmos/PointType;Lpalmos/PointType;)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapEvtProcessSoftKeyStroke
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.EvtProcessSoftKeyStroke
	dc.b	80,97,108,109,46,69,118,116,80,114,111,99,101,115,115,83,111,102,116,75,101,121,83,116,114,111,107,101,0,0
#endif

;; native-method palmos/Palm.EvtResetAutoOffTimer()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtResetAutoOffTimer
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.EvtResetAutoOffTimer
	dc.b	80,97,108,109,46,69,118,116,82,101,115,101,116,65,117,116,111,79,102,102,84,105,109,101,114,0
#endif

;; native-method palmos/Palm.EvtWakeup()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtWakeup
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.EvtWakeup
	dc.b	80,97,108,109,46,69,118,116,87,97,107,101,117,112,0,0
#endif

;; native-method palmos/Palm.EvtEventAvail()Z
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapEvtEventAvail
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.EvtEventAvail
	dc.b	80,97,108,109,46,69,118,116,69,118,101,110,116,65,118,97,105,108,0,0
#endif

;; native-method palmos/Palm.ExpInit()I
	link	a6,#0
	mem.release
	moveq.l	#expInit,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.ExpInit
	dc.b	80,97,108,109,46,69,120,112,73,110,105,116,0,0
#endif

;; native-method palmos/Palm.ExpSlotDriverInstall(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#expSlotDriverInstall,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.ExpSlotDriverInstall
	dc.b	80,97,108,109,46,69,120,112,83,108,111,116,68,114,105,118,101,114,73,110,115,116,97,108,108,0
#endif

;; native-method palmos/Palm.ExpSlotDriverInstall(ILjava/lang/Short;)I
;; uses-method palmos/Palm.ExpSlotDriverInstall(ILpalmos/ShortHolder;)I as new_ExpSlotDriverInstall
;; needs-exact-layout java/lang/Short
	bra.far	new_ExpSlotDriverInstall

;; native-method palmos/Palm.ExpSlotDriverRemove(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#expSlotDriverRemove,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.ExpSlotDriverRemove
	dc.b	80,97,108,109,46,69,120,112,83,108,111,116,68,114,105,118,101,114,82,101,109,111,118,101,0,0
#endif

;; native-method palmos/Palm.ExpSlotLibFind(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#expSlotLibFind,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.ExpSlotLibFind
	dc.b	80,97,108,109,46,69,120,112,83,108,111,116,76,105,98,70,105,110,100,0
#endif

;; native-method palmos/Palm.ExpSlotLibFind(ILjava/lang/Short;)I
;; uses-method palmos/Palm.ExpSlotLibFind(ILpalmos/ShortHolder;)I as new_ExpSlotLibFind
;; needs-exact-layout java/lang/Short
	bra.far	new_ExpSlotLibFind

;; native-method palmos/Palm.ExpSlotRegister(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#expSlotRegister,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.ExpSlotRegister
	dc.b	80,97,108,109,46,69,120,112,83,108,111,116,82,101,103,105,115,116,101,114,0,0
#endif

;; native-method palmos/Palm.ExpSlotRegister(ILjava/lang/Short;)I
;; uses-method palmos/Palm.ExpSlotRegister(ILpalmos/ShortHolder;)I as new_ExpSlotRegister
;; needs-exact-layout java/lang/Short
	bra.far	new_ExpSlotRegister

;; native-method palmos/Palm.ExpSlotUnregister(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#expSlotUnregister,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.ExpSlotUnregister
	dc.b	80,97,108,109,46,69,120,112,83,108,111,116,85,110,114,101,103,105,115,116,101,114,0,0
#endif

;; native-method palmos/Palm.ExpCardInserted(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#expCardInserted,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.ExpCardInserted
	dc.b	80,97,108,109,46,69,120,112,67,97,114,100,73,110,115,101,114,116,101,100,0,0
#endif

;; native-method palmos/Palm.ExpCardRemoved(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#expCardRemoved,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.ExpCardRemoved
	dc.b	80,97,108,109,46,69,120,112,67,97,114,100,82,101,109,111,118,101,100,0
#endif

;; native-method palmos/Palm.ExpCardPresent(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#expCardPresent,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.ExpCardPresent
	dc.b	80,97,108,109,46,69,120,112,67,97,114,100,80,114,101,115,101,110,116,0
#endif

;; native-method palmos/Palm.ExpSlotEnumerate(Lpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#expSlotEnumerate,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.ExpSlotEnumerate
	dc.b	80,97,108,109,46,69,120,112,83,108,111,116,69,110,117,109,101,114,97,116,101,0
#endif

;; native-method palmos/Palm.ExpSlotEnumerate(Ljava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.ExpSlotEnumerate(Lpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_ExpSlotEnumerate
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_ExpSlotEnumerate

;; native-method palmos/Palm.ExpCardGetSerialPort(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#expCardGetSerialPort,d2
	trap	#15
	dc.w	sysTrapExpansionDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.ExpCardGetSerialPort
	dc.b	80,97,108,109,46,69,120,112,67,97,114,100,71,101,116,83,101,114,105,97,108,80,111,114,116,0
#endif

;; native-method palmos/Palm.ExpCardGetSerialPort(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.ExpCardGetSerialPort(ILpalmos/IntHolder;)I as new_ExpCardGetSerialPort
;; needs-exact-layout java/lang/Integer
	bra.far	new_ExpCardGetSerialPort

;; native-method palmos/Palm.FindStrInStr(Ljava/lang/String;Ljava/lang/String;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFindStrInStr
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FindStrInStr
	dc.b	80,97,108,109,46,70,105,110,100,83,116,114,73,110,83,116,114,0
#endif

;; native-method palmos/Palm.FindStrInStr(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Short;)V
;; uses-method palmos/Palm.FindStrInStr(Ljava/lang/String;Ljava/lang/String;Lpalmos/ShortHolder;)V as new_FindStrInStr
;; needs-exact-layout java/lang/Short
	bra.far	new_FindStrInStr

;; native-method palmos/Palm.FldCalcFieldHeight(Ljava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldCalcFieldHeight
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FldCalcFieldHeight
	dc.b	80,97,108,109,46,70,108,100,67,97,108,99,70,105,101,108,100,72,101,105,103,104,116,0
#endif

;; native-method palmos/Palm.FldCompactText(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldCompactText
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FldCompactText
	dc.b	80,97,108,109,46,70,108,100,67,111,109,112,97,99,116,84,101,120,116,0
#endif

;; native-method palmos/Palm.FldCopy(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldCopy
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.FldCopy
	dc.b	80,97,108,109,46,70,108,100,67,111,112,121,0,0
#endif

;; native-method palmos/Palm.FldCut(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldCut
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.FldCut
	dc.b	80,97,108,109,46,70,108,100,67,117,116,0
#endif

;; native-method palmos/Palm.FldDelete(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldDelete
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.FldDelete
	dc.b	80,97,108,109,46,70,108,100,68,101,108,101,116,101,0,0
#endif

;; native-method palmos/Palm.FldDirty(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldDirty
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.FldDirty
	dc.b	80,97,108,109,46,70,108,100,68,105,114,116,121,0
#endif

;; native-method palmos/Palm.FldDrawField(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldDrawField
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FldDrawField
	dc.b	80,97,108,109,46,70,108,100,68,114,97,119,70,105,101,108,100,0
#endif

;; native-method palmos/Palm.FldEraseField(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldEraseField
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FldEraseField
	dc.b	80,97,108,109,46,70,108,100,69,114,97,115,101,70,105,101,108,100,0,0
#endif

;; native-method palmos/Palm.FldFreeMemory(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldFreeMemory
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FldFreeMemory
	dc.b	80,97,108,109,46,70,108,100,70,114,101,101,77,101,109,111,114,121,0,0
#endif

;; native-method palmos/Palm.FldGetAttributes(ILpalmos/FieldAttr;)V
;; needs-exact-layout palmos/FieldAttr
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetAttributes
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FldGetAttributes
	dc.b	80,97,108,109,46,70,108,100,71,101,116,65,116,116,114,105,98,117,116,101,115,0
#endif

;; native-method palmos/Palm.FldGetBounds(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FldGetBounds
	dc.b	80,97,108,109,46,70,108,100,71,101,116,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.FldGetFont(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetFont
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FldGetFont
	dc.b	80,97,108,109,46,70,108,100,71,101,116,70,111,110,116,0
#endif

;; native-method palmos/Palm.FldGetInsPtPosition(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetInsPtPosition
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.FldGetInsPtPosition
	dc.b	80,97,108,109,46,70,108,100,71,101,116,73,110,115,80,116,80,111,115,105,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FldGetMaxChars(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetMaxChars
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FldGetMaxChars
	dc.b	80,97,108,109,46,70,108,100,71,101,116,77,97,120,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.FldGetScrollPosition(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetScrollPosition
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.FldGetScrollPosition
	dc.b	80,97,108,109,46,70,108,100,71,101,116,83,99,114,111,108,108,80,111,115,105,116,105,111,110,0
#endif

;; native-method palmos/Palm.FldGetScrollValues(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetScrollValues
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FldGetScrollValues
	dc.b	80,97,108,109,46,70,108,100,71,101,116,83,99,114,111,108,108,86,97,108,117,101,115,0
#endif

;; native-method palmos/Palm.FldGetScrollValues(ILjava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.FldGetScrollValues(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_FldGetScrollValues
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_FldGetScrollValues

;; native-method palmos/Palm.FldGetSelection(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetSelection
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FldGetSelection
	dc.b	80,97,108,109,46,70,108,100,71,101,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FldGetSelection(ILjava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.FldGetSelection(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_FldGetSelection
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_FldGetSelection

;; native-method palmos/Palm.FldGetTextAllocatedSize(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetTextAllocatedSize
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.FldGetTextAllocatedSize
	dc.b	80,97,108,109,46,70,108,100,71,101,116,84,101,120,116,65,108,108,111,99,97,116,101,100,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.FldGetTextHandle(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetTextHandle
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FldGetTextHandle
	dc.b	80,97,108,109,46,70,108,100,71,101,116,84,101,120,116,72,97,110,100,108,101,0
#endif

;; native-method palmos/Palm.FldGetTextHeight(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetTextHeight
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FldGetTextHeight
	dc.b	80,97,108,109,46,70,108,100,71,101,116,84,101,120,116,72,101,105,103,104,116,0
#endif

;; native-method palmos/Palm.FldGetTextLength(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetTextLength
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FldGetTextLength
	dc.b	80,97,108,109,46,70,108,100,71,101,116,84,101,120,116,76,101,110,103,116,104,0
#endif

;; native-method palmos/Palm.FldGetTextPtr(I)Ljava/lang/String;
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetTextPtr
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FldGetTextPtr
	dc.b	80,97,108,109,46,70,108,100,71,101,116,84,101,120,116,80,116,114,0,0
#endif

;; native-method palmos/Palm.FldGetVisibleLines(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGetVisibleLines
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FldGetVisibleLines
	dc.b	80,97,108,109,46,70,108,100,71,101,116,86,105,115,105,98,108,101,76,105,110,101,115,0
#endif

;; native-method palmos/Palm.FldGrabFocus(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldGrabFocus
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FldGrabFocus
	dc.b	80,97,108,109,46,70,108,100,71,114,97,98,70,111,99,117,115,0
#endif

;; native-method palmos/Palm.FldHandleEvent(ILpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FldHandleEvent
	dc.b	80,97,108,109,46,70,108,100,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.FldInsert(ILjava/lang/String;I)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldInsert
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.FldInsert
	dc.b	80,97,108,109,46,70,108,100,73,110,115,101,114,116,0,0
#endif

;; native-method palmos/Palm.FldMakeFullyVisible(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldMakeFullyVisible
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.FldMakeFullyVisible
	dc.b	80,97,108,109,46,70,108,100,77,97,107,101,70,117,108,108,121,86,105,115,105,98,108,101,0,0
#endif

;; native-method palmos/Palm.FldPaste(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldPaste
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.FldPaste
	dc.b	80,97,108,109,46,70,108,100,80,97,115,116,101,0
#endif

;; native-method palmos/Palm.FldRecalculateField(IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldRecalculateField
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.FldRecalculateField
	dc.b	80,97,108,109,46,70,108,100,82,101,99,97,108,99,117,108,97,116,101,70,105,101,108,100,0,0
#endif

;; native-method palmos/Palm.FldReleaseFocus(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldReleaseFocus
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FldReleaseFocus
	dc.b	80,97,108,109,46,70,108,100,82,101,108,101,97,115,101,70,111,99,117,115,0,0
#endif

;; native-method palmos/Palm.FldScrollable(II)Z
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldScrollable
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FldScrollable
	dc.b	80,97,108,109,46,70,108,100,83,99,114,111,108,108,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.FldScrollField(III)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldScrollField
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FldScrollField
	dc.b	80,97,108,109,46,70,108,100,83,99,114,111,108,108,70,105,101,108,100,0
#endif

;; native-method palmos/Palm.FldSendChangeNotification(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSendChangeNotification
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,30	; Debug Symbol Palm.FldSendChangeNotification
	dc.b	80,97,108,109,46,70,108,100,83,101,110,100,67,104,97,110,103,101,78,111,116,105,102,105,99,97,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FldSendHeightChangeNotification(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSendHeightChangeNotification
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,36	; Debug Symbol Palm.FldSendHeightChangeNotification
	dc.b	80,97,108,109,46,70,108,100,83,101,110,100,72,101,105,103,104,116,67,104,97,110,103,101,78,111,116,105,102,105,99,97,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FldSetAttributes(ILpalmos/FieldAttr;)V
;; needs-exact-layout palmos/FieldAttr
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetAttributes
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FldSetAttributes
	dc.b	80,97,108,109,46,70,108,100,83,101,116,65,116,116,114,105,98,117,116,101,115,0
#endif

;; native-method palmos/Palm.FldSetBounds(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FldSetBounds
	dc.b	80,97,108,109,46,70,108,100,83,101,116,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.FldSetDirty(IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetDirty
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FldSetDirty
	dc.b	80,97,108,109,46,70,108,100,83,101,116,68,105,114,116,121,0,0
#endif

;; native-method palmos/Palm.FldSetFont(II)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetFont
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FldSetFont
	dc.b	80,97,108,109,46,70,108,100,83,101,116,70,111,110,116,0
#endif

;; native-method palmos/Palm.FldSetInsPtPosition(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetInsPtPosition
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.FldSetInsPtPosition
	dc.b	80,97,108,109,46,70,108,100,83,101,116,73,110,115,80,116,80,111,115,105,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FldSetMaxChars(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetMaxChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FldSetMaxChars
	dc.b	80,97,108,109,46,70,108,100,83,101,116,77,97,120,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.FldSetScrollPosition(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetScrollPosition
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.FldSetScrollPosition
	dc.b	80,97,108,109,46,70,108,100,83,101,116,83,99,114,111,108,108,80,111,115,105,116,105,111,110,0
#endif

;; native-method palmos/Palm.FldSetSelection(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetSelection
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FldSetSelection
	dc.b	80,97,108,109,46,70,108,100,83,101,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FldSetText(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetText
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FldSetText
	dc.b	80,97,108,109,46,70,108,100,83,101,116,84,101,120,116,0
#endif

;; native-method palmos/Palm.FldSetTextAllocatedSize(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetTextAllocatedSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.FldSetTextAllocatedSize
	dc.b	80,97,108,109,46,70,108,100,83,101,116,84,101,120,116,65,108,108,111,99,97,116,101,100,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.FldSetTextHandle(II)V
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetTextHandle
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FldSetTextHandle
	dc.b	80,97,108,109,46,70,108,100,83,101,116,84,101,120,116,72,97,110,100,108,101,0
#endif

;; native-method palmos/Palm.FldSetTextPtr(ILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetTextPtr
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FldSetTextPtr
	dc.b	80,97,108,109,46,70,108,100,83,101,116,84,101,120,116,80,116,114,0,0
#endif

;; native-method palmos/Palm.FldSetUsable(IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldSetUsable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FldSetUsable
	dc.b	80,97,108,109,46,70,108,100,83,101,116,85,115,97,98,108,101,0
#endif

;; native-method palmos/Palm.FldUndo(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldUndo
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.FldUndo
	dc.b	80,97,108,109,46,70,108,100,85,110,100,111,0,0
#endif

;; native-method palmos/Palm.FldWordWrap(Ljava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldWordWrap
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FldWordWrap
	dc.b	80,97,108,109,46,70,108,100,87,111,114,100,87,114,97,112,0,0
#endif

;; native-method palmos/Palm.FldNewField(Ljava/lang/Object;IIIIIIIZZZZIZZZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.b	15(a6),-(a7)
	move.b	19(a6),-(a7)
	move.b	23(a6),-(a7)
	move.b	27(a6),-(a7)
	move.b	31(a6),-(a7)
	move.b	35(a6),-(a7)
	move.b	39(a6),-(a7)
	move.l	40(a6),-(a7)
	move.b	47(a6),-(a7)
	move.w	50(a6),-(a7)
	move.w	54(a6),-(a7)
	move.w	58(a6),-(a7)
	move.w	62(a6),-(a7)
	move.w	66(a6),-(a7)
	move.l	68(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFldNewField
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-36(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FldNewField
	dc.b	80,97,108,109,46,70,108,100,78,101,119,70,105,101,108,100,0,0
#endif

;; native-method palmos/Palm.FntAverageCharWidth()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntAverageCharWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.FntAverageCharWidth
	dc.b	80,97,108,109,46,70,110,116,65,118,101,114,97,103,101,67,104,97,114,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.FntBaseLine()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntBaseLine
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FntBaseLine
	dc.b	80,97,108,109,46,70,110,116,66,97,115,101,76,105,110,101,0,0
#endif

;; native-method palmos/Palm.FntCharHeight()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntCharHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntCharHeight
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Palm.FntCharsInWidth(Ljava/lang/String;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntCharsInWidth
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FntCharsInWidth
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,115,73,110,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.FntCharsInWidth(Ljava/lang/String;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)V
;; uses-method palmos/Palm.FntCharsInWidth(Ljava/lang/String;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V as new_FntCharsInWidth
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_FntCharsInWidth

;; native-method palmos/Palm.FntCharsWidth(Ljava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntCharsWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntCharsWidth
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,115,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.FntCharsWidth(Ljava/lang/String;II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntCharsWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntCharsWidth
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,115,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.FntCharsWidth([BII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntCharsWidth
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntCharsWidth
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,115,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.FntCharsWidth([CII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntCharsWidth
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntCharsWidth
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,115,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.FntCharWidth(I)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntCharWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FntCharWidth
	dc.b	80,97,108,109,46,70,110,116,67,104,97,114,87,105,100,116,104,0
#endif

;; native-method palmos/Palm.FntDefineFont(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.b	15(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntDefineFont
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntDefineFont
	dc.b	80,97,108,109,46,70,110,116,68,101,102,105,110,101,70,111,110,116,0,0
#endif

;; native-method palmos/Palm.FntDescenderHeight()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntDescenderHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FntDescenderHeight
	dc.b	80,97,108,109,46,70,110,116,68,101,115,99,101,110,100,101,114,72,101,105,103,104,116,0
#endif

;; native-method palmos/Palm.FntGetFont()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntGetFont
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FntGetFont
	dc.b	80,97,108,109,46,70,110,116,71,101,116,70,111,110,116,0
#endif

;; native-method palmos/Palm.FntGetFontPtr()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntGetFontPtr
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntGetFontPtr
	dc.b	80,97,108,109,46,70,110,116,71,101,116,70,111,110,116,80,116,114,0,0
#endif

;; native-method palmos/Palm.FntLineHeight()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFntLineHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FntLineHeight
	dc.b	80,97,108,109,46,70,110,116,76,105,110,101,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Palm.FntLineWidth(Ljava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntLineWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FntLineWidth
	dc.b	80,97,108,109,46,70,110,116,76,105,110,101,87,105,100,116,104,0
#endif

;; native-method palmos/Palm.FntLineWidth(Ljava/lang/String;II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntLineWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FntLineWidth
	dc.b	80,97,108,109,46,70,110,116,76,105,110,101,87,105,100,116,104,0
#endif

;; native-method palmos/Palm.FntLineWidth([BII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntLineWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FntLineWidth
	dc.b	80,97,108,109,46,70,110,116,76,105,110,101,87,105,100,116,104,0
#endif

;; native-method palmos/Palm.FntLineWidth([CII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntLineWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FntLineWidth
	dc.b	80,97,108,109,46,70,110,116,76,105,110,101,87,105,100,116,104,0
#endif

;; native-method palmos/Palm.FntSetFont(I)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFntSetFont
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FntSetFont
	dc.b	80,97,108,109,46,70,110,116,83,101,116,70,111,110,116,0
#endif

;; native-method palmos/Palm.FontSelect(I)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFontSelect
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FontSelect
	dc.b	80,97,108,109,46,70,111,110,116,83,101,108,101,99,116,0
#endif

;; native-method palmos/Palm.FrmAlert(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmAlert
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.FrmAlert
	dc.b	80,97,108,109,46,70,114,109,65,108,101,114,116,0
#endif

;; native-method palmos/Palm.FrmCloseAllForms()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFrmCloseAllForms
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmCloseAllForms
	dc.b	80,97,108,109,46,70,114,109,67,108,111,115,101,65,108,108,70,111,114,109,115,0
#endif

;; native-method palmos/Palm.FrmCopyLabel(IILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmCopyLabel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FrmCopyLabel
	dc.b	80,97,108,109,46,70,114,109,67,111,112,121,76,97,98,101,108,0
#endif

;; native-method palmos/Palm.FrmCopyTitle(ILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmCopyTitle
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FrmCopyTitle
	dc.b	80,97,108,109,46,70,114,109,67,111,112,121,84,105,116,108,101,0
#endif

;; native-method palmos/Palm.FrmCustomAlert(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmCustomAlert
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FrmCustomAlert
	dc.b	80,97,108,109,46,70,114,109,67,117,115,116,111,109,65,108,101,114,116,0
#endif

;; native-method palmos/Palm.FrmDeleteForm(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmDeleteForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FrmDeleteForm
	dc.b	80,97,108,109,46,70,114,109,68,101,108,101,116,101,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmDispatchEvent(Lpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapFrmDispatchEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmDispatchEvent
	dc.b	80,97,108,109,46,70,114,109,68,105,115,112,97,116,99,104,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.FrmDoDialog(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmDoDialog
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmDoDialog
	dc.b	80,97,108,109,46,70,114,109,68,111,68,105,97,108,111,103,0,0
#endif

;; native-method palmos/Palm.FrmDrawForm(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmDrawForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmDrawForm
	dc.b	80,97,108,109,46,70,114,109,68,114,97,119,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmEraseForm(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmEraseForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FrmEraseForm
	dc.b	80,97,108,109,46,70,114,109,69,114,97,115,101,70,111,114,109,0
#endif

;; native-method palmos/Palm.FrmGetActiveForm()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetActiveForm
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmGetActiveForm
	dc.b	80,97,108,109,46,70,114,109,71,101,116,65,99,116,105,118,101,70,111,114,109,0
#endif

;; native-method palmos/Palm.FrmGetActiveFormID()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetActiveFormID
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmGetActiveFormID
	dc.b	80,97,108,109,46,70,114,109,71,101,116,65,99,116,105,118,101,70,111,114,109,73,68,0
#endif

;; native-method palmos/Palm.FrmGetControlGroupSelection(II)B
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetControlGroupSelection
	mem.reserve.savereg
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,32	; Debug Symbol Palm.FrmGetControlGroupSelection
	dc.b	80,97,108,109,46,70,114,109,71,101,116,67,111,110,116,114,111,108,71,114,111,117,112,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FrmGetControlValue(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetControlValue
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmGetControlValue
	dc.b	80,97,108,109,46,70,114,109,71,101,116,67,111,110,116,114,111,108,86,97,108,117,101,0
#endif

;; native-method palmos/Palm.FrmGetFirstForm()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetFirstForm
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FrmGetFirstForm
	dc.b	80,97,108,109,46,70,114,109,71,101,116,70,105,114,115,116,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmGetFocus(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetFocus
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmGetFocus
	dc.b	80,97,108,109,46,70,114,109,71,101,116,70,111,99,117,115,0,0
#endif

;; native-method palmos/Palm.FrmGetFormBounds(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetFormBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmGetFormBounds
	dc.b	80,97,108,109,46,70,114,109,71,101,116,70,111,114,109,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.FrmGetFormId(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetFormId
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FrmGetFormId
	dc.b	80,97,108,109,46,70,114,109,71,101,116,70,111,114,109,73,100,0
#endif

;; native-method palmos/Palm.FrmGetFormPtr(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetFormPtr
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FrmGetFormPtr
	dc.b	80,97,108,109,46,70,114,109,71,101,116,70,111,114,109,80,116,114,0,0
#endif

;; native-method palmos/Palm.FrmGetGadgetData(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetGadgetData
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmGetGadgetData
	dc.b	80,97,108,109,46,70,114,109,71,101,116,71,97,100,103,101,116,68,97,116,97,0
#endif

;; native-method palmos/Palm.FrmGetLabel(II)Ljava/lang/String;
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetLabel
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmGetLabel
	dc.b	80,97,108,109,46,70,114,109,71,101,116,76,97,98,101,108,0,0
#endif

;; native-method palmos/Palm.FrmGetNumberOfObjects(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetNumberOfObjects
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.FrmGetNumberOfObjects
	dc.b	80,97,108,109,46,70,114,109,71,101,116,78,117,109,98,101,114,79,102,79,98,106,101,99,116,115,0,0
#endif

;; native-method palmos/Palm.FrmGetObjectBounds(IILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetObjectBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmGetObjectBounds
	dc.b	80,97,108,109,46,70,114,109,71,101,116,79,98,106,101,99,116,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.FrmGetObjectId(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetObjectId
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FrmGetObjectId
	dc.b	80,97,108,109,46,70,114,109,71,101,116,79,98,106,101,99,116,73,100,0
#endif

;; native-method palmos/Palm.FrmGetObjectIndex(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetObjectIndex
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.FrmGetObjectIndex
	dc.b	80,97,108,109,46,70,114,109,71,101,116,79,98,106,101,99,116,73,110,100,101,120,0,0
#endif

;; native-method palmos/Palm.FrmGetObjectPosition(IILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetObjectPosition
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.FrmGetObjectPosition
	dc.b	80,97,108,109,46,70,114,109,71,101,116,79,98,106,101,99,116,80,111,115,105,116,105,111,110,0
#endif

;; native-method palmos/Palm.FrmGetObjectPosition(IILjava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.FrmGetObjectPosition(IILpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_FrmGetObjectPosition
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_FrmGetObjectPosition

;; native-method palmos/Palm.FrmGetObjectPtr(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetObjectPtr
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FrmGetObjectPtr
	dc.b	80,97,108,109,46,70,114,109,71,101,116,79,98,106,101,99,116,80,116,114,0,0
#endif

;; native-method palmos/Palm.FrmGetObjectType(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetObjectType
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmGetObjectType
	dc.b	80,97,108,109,46,70,114,109,71,101,116,79,98,106,101,99,116,84,121,112,101,0
#endif

;; native-method palmos/Palm.FrmGetTitle(I)Ljava/lang/String;
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetTitle
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmGetTitle
	dc.b	80,97,108,109,46,70,114,109,71,101,116,84,105,116,108,101,0,0
#endif

;; native-method palmos/Palm.FrmGetUserModifiedState(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetUserModifiedState
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.FrmGetUserModifiedState
	dc.b	80,97,108,109,46,70,114,109,71,101,116,85,115,101,114,77,111,100,105,102,105,101,100,83,116,97,116,101,0,0
#endif

;; native-method palmos/Palm.FrmGetWindowHandle(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGetWindowHandle
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmGetWindowHandle
	dc.b	80,97,108,109,46,70,114,109,71,101,116,87,105,110,100,111,119,72,97,110,100,108,101,0
#endif

;; native-method palmos/Palm.FrmGotoForm(I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmGotoForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmGotoForm
	dc.b	80,97,108,109,46,70,114,109,71,111,116,111,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmHandleEvent(ILpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FrmHandleEvent
	dc.b	80,97,108,109,46,70,114,109,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.FrmHelp(I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmHelp
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.FrmHelp
	dc.b	80,97,108,109,46,70,114,109,72,101,108,112,0,0
#endif

;; native-method palmos/Palm.FrmHideObject(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmHideObject
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FrmHideObject
	dc.b	80,97,108,109,46,70,114,109,72,105,100,101,79,98,106,101,99,116,0,0
#endif

;; native-method palmos/Palm.FrmInitForm(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmInitForm
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmInitForm
	dc.b	80,97,108,109,46,70,114,109,73,110,105,116,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmPopupForm(I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmPopupForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.FrmPopupForm
	dc.b	80,97,108,109,46,70,114,109,80,111,112,117,112,70,111,114,109,0
#endif

;; native-method palmos/Palm.FrmReturnToForm(I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmReturnToForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FrmReturnToForm
	dc.b	80,97,108,109,46,70,114,109,82,101,116,117,114,110,84,111,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmSaveAllForms()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapFrmSaveAllForms
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.FrmSaveAllForms
	dc.b	80,97,108,109,46,70,114,109,83,97,118,101,65,108,108,70,111,114,109,115,0,0
#endif

;; native-method palmos/Palm.FrmSetActiveForm(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetActiveForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmSetActiveForm
	dc.b	80,97,108,109,46,70,114,109,83,101,116,65,99,116,105,118,101,70,111,114,109,0
#endif

;; native-method palmos/Palm.FrmSetCategoryLabel(IILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetCategoryLabel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.FrmSetCategoryLabel
	dc.b	80,97,108,109,46,70,114,109,83,101,116,67,97,116,101,103,111,114,121,76,97,98,101,108,0,0
#endif

;; native-method palmos/Palm.FrmSetControlGroupSelection(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.b	15(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetControlGroupSelection
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,32	; Debug Symbol Palm.FrmSetControlGroupSelection
	dc.b	80,97,108,109,46,70,114,109,83,101,116,67,111,110,116,114,111,108,71,114,111,117,112,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.FrmSetControlValue(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetControlValue
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmSetControlValue
	dc.b	80,97,108,109,46,70,114,109,83,101,116,67,111,110,116,114,111,108,86,97,108,117,101,0
#endif

;; native-method palmos/Palm.FrmSetEventHandler(ILpalmos/FormEventHandler;)V
;; needs-exact-layout palmos/FormEventHandler
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetEventHandler
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmSetEventHandler
	dc.b	80,97,108,109,46,70,114,109,83,101,116,69,118,101,110,116,72,97,110,100,108,101,114,0
#endif

;; native-method palmos/Palm.FrmSetFocus(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetFocus
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmSetFocus
	dc.b	80,97,108,109,46,70,114,109,83,101,116,70,111,99,117,115,0,0
#endif

;; native-method palmos/Palm.FrmSetGadgetData(IILjava/lang/Object;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetGadgetData
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.FrmSetGadgetData
	dc.b	80,97,108,109,46,70,114,109,83,101,116,71,97,100,103,101,116,68,97,116,97,0
#endif

;; native-method palmos/Palm.FrmSetNotUserModified(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetNotUserModified
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.FrmSetNotUserModified
	dc.b	80,97,108,109,46,70,114,109,83,101,116,78,111,116,85,115,101,114,77,111,100,105,102,105,101,100,0,0
#endif

;; native-method palmos/Palm.FrmSetObjectPosition(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetObjectPosition
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.FrmSetObjectPosition
	dc.b	80,97,108,109,46,70,114,109,83,101,116,79,98,106,101,99,116,80,111,115,105,116,105,111,110,0
#endif

;; native-method palmos/Palm.FrmSetTitle(ILjava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmSetTitle
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.FrmSetTitle
	dc.b	80,97,108,109,46,70,114,109,83,101,116,84,105,116,108,101,0,0
#endif

;; native-method palmos/Palm.FrmShowObject(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmShowObject
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FrmShowObject
	dc.b	80,97,108,109,46,70,114,109,83,104,111,119,79,98,106,101,99,116,0,0
#endif

;; native-method palmos/Palm.FrmUpdateScrollers(IIIZZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.b	15(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmUpdateScrollers
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.FrmUpdateScrollers
	dc.b	80,97,108,109,46,70,114,109,85,112,100,97,116,101,83,99,114,111,108,108,101,114,115,0
#endif

;; native-method palmos/Palm.FrmUpdateForm(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmUpdateForm
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FrmUpdateForm
	dc.b	80,97,108,109,46,70,114,109,85,112,100,97,116,101,70,111,114,109,0,0
#endif

;; native-method palmos/Palm.FrmVisible(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmVisible
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FrmVisible
	dc.b	80,97,108,109,46,70,114,109,86,105,115,105,98,108,101,0
#endif

;; native-method palmos/Palm.FrmNewForm(ILjava/lang/String;IIIIZIII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.b	23(a6),-(a7)
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.w	34(a6),-(a7)
	move.w	38(a6),-(a7)
	move.l	40(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	46(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmNewForm
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.FrmNewForm
	dc.b	80,97,108,109,46,70,114,109,78,101,119,70,111,114,109,0
#endif

;; native-method palmos/Palm.FrmValidatePtr(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFrmValidatePtr
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.FrmValidatePtr
	dc.b	80,97,108,109,46,70,114,109,86,97,108,105,100,97,116,101,80,116,114,0
#endif

;; native-method palmos/Palm.FtrGet(IILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFtrGet
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.FtrGet
	dc.b	80,97,108,109,46,70,116,114,71,101,116,0
#endif

;; native-method palmos/Palm.FtrGet(IILjava/lang/Integer;)I
;; uses-method palmos/Palm.FtrGet(IILpalmos/IntHolder;)I as new_FtrGet
;; needs-exact-layout java/lang/Integer
	bra.far	new_FtrGet

;; native-method palmos/Palm.FtrGet(II[II)I
	link	a6,#0
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	8(a6),d1
	mulu.w	#4,d1
	adda.l	d1,a0
	sub.l	d1,d0
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFtrGet
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.FtrGet
	dc.b	80,97,108,109,46,70,116,114,71,101,116,0
#endif

;; native-method palmos/Palm.FtrGetByIndex(IZLpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	23(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFtrGetByIndex
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FtrGetByIndex
	dc.b	80,97,108,109,46,70,116,114,71,101,116,66,121,73,110,100,101,120,0,0
#endif

;; native-method palmos/Palm.FtrGetByIndex(IZLjava/lang/Integer;Ljava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.FtrGetByIndex(IZLpalmos/IntHolder;Lpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_FtrGetByIndex
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_FtrGetByIndex

;; native-method palmos/Palm.FtrSet(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFtrSet
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.FtrSet
	dc.b	80,97,108,109,46,70,116,114,83,101,116,0
#endif

;; native-method palmos/Palm.FtrUnregister(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapFtrUnregister
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.FtrUnregister
	dc.b	80,97,108,109,46,70,116,114,85,110,114,101,103,105,115,116,101,114,0,0
#endif

;; native-method palmos/Palm.GrfAddMacro(Ljava/lang/String;Ljava/lang/Object;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfAddMacro
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.GrfAddMacro
	dc.b	80,97,108,109,46,71,114,102,65,100,100,77,97,99,114,111,0,0
#endif

;; native-method palmos/Palm.GrfAddPoint(Lpalmos/PointType;)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapGrfAddPoint
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.GrfAddPoint
	dc.b	80,97,108,109,46,71,114,102,65,100,100,80,111,105,110,116,0,0
#endif

;; native-method palmos/Palm.GrfCleanState()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapGrfCleanState
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.GrfCleanState
	dc.b	80,97,108,109,46,71,114,102,67,108,101,97,110,83,116,97,116,101,0,0
#endif

;; native-method palmos/Palm.GrfDeleteMacro(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfDeleteMacro
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.GrfDeleteMacro
	dc.b	80,97,108,109,46,71,114,102,68,101,108,101,116,101,77,97,99,114,111,0
#endif

;; native-method palmos/Palm.GrfFindBranch(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfFindBranch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.GrfFindBranch
	dc.b	80,97,108,109,46,71,114,102,70,105,110,100,66,114,97,110,99,104,0,0
#endif

;; native-method palmos/Palm.GrfFilterPoints()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapGrfFilterPoints
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.GrfFilterPoints
	dc.b	80,97,108,109,46,71,114,102,70,105,108,116,101,114,80,111,105,110,116,115,0,0
#endif

;; native-method palmos/Palm.GrfFlushPoints()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapGrfFlushPoints
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.GrfFlushPoints
	dc.b	80,97,108,109,46,71,114,102,70,108,117,115,104,80,111,105,110,116,115,0
#endif

;; native-method palmos/Palm.GrfGetAndExpandMacro(Ljava/lang/String;Ljava/lang/Object;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetAndExpandMacro
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.GrfGetAndExpandMacro
	dc.b	80,97,108,109,46,71,114,102,71,101,116,65,110,100,69,120,112,97,110,100,77,97,99,114,111,0
#endif

;; native-method palmos/Palm.GrfGetAndExpandMacro(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Short;)I
;; uses-method palmos/Palm.GrfGetAndExpandMacro(Ljava/lang/String;Ljava/lang/Object;Lpalmos/ShortHolder;)I as new_GrfGetAndExpandMacro
;; needs-exact-layout java/lang/Short
	bra.far	new_GrfGetAndExpandMacro

;; native-method palmos/Palm.GrfGetGlyphMapping(ILpalmos/ShortHolder;Ljava/lang/Object;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetGlyphMapping
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.GrfGetGlyphMapping
	dc.b	80,97,108,109,46,71,114,102,71,101,116,71,108,121,112,104,77,97,112,112,105,110,103,0
#endif

;; native-method palmos/Palm.GrfGetGlyphMapping(ILjava/lang/Short;Ljava/lang/Object;Ljava/lang/Short;Ljava/lang/Short;)I
;; uses-method palmos/Palm.GrfGetGlyphMapping(ILpalmos/ShortHolder;Ljava/lang/Object;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)I as new_GrfGetGlyphMapping
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_GrfGetGlyphMapping

;; native-method palmos/Palm.GrfGetMacro(Ljava/lang/String;Ljava/lang/Object;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetMacro
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.GrfGetMacro
	dc.b	80,97,108,109,46,71,114,102,71,101,116,77,97,99,114,111,0,0
#endif

;; native-method palmos/Palm.GrfGetMacro(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Short;)I
;; uses-method palmos/Palm.GrfGetMacro(Ljava/lang/String;Ljava/lang/Object;Lpalmos/ShortHolder;)I as new_GrfGetMacro
;; needs-exact-layout java/lang/Short
	bra.far	new_GrfGetMacro

;; native-method palmos/Palm.GrfGetMacroName(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetMacroName
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.GrfGetMacroName
	dc.b	80,97,108,109,46,71,114,102,71,101,116,77,97,99,114,111,78,97,109,101,0,0
#endif

;; native-method palmos/Palm.GrfGetNumPoints(Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetNumPoints
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.GrfGetNumPoints
	dc.b	80,97,108,109,46,71,114,102,71,101,116,78,117,109,80,111,105,110,116,115,0,0
#endif

;; native-method palmos/Palm.GrfGetNumPoints(Ljava/lang/Short;)I
;; uses-method palmos/Palm.GrfGetNumPoints(Lpalmos/ShortHolder;)I as new_GrfGetNumPoints
;; needs-exact-layout java/lang/Short
	bra.far	new_GrfGetNumPoints

;; native-method palmos/Palm.GrfGetPoint(ILpalmos/PointType;)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetPoint
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.GrfGetPoint
	dc.b	80,97,108,109,46,71,114,102,71,101,116,80,111,105,110,116,0,0
#endif

;; native-method palmos/Palm.GrfGetState(Lpalmos/BoolHolder;Lpalmos/BoolHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I
;; needs-exact-layout palmos/BoolHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapGrfGetState
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.GrfGetState
	dc.b	80,97,108,109,46,71,114,102,71,101,116,83,116,97,116,101,0,0
#endif

;; native-method palmos/Palm.GrfGetState(Ljava/lang/Boolean;Ljava/lang/Boolean;Ljava/lang/Short;Ljava/lang/Boolean;)I
;; uses-method palmos/Palm.GrfGetState(Lpalmos/BoolHolder;Lpalmos/BoolHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I as new_GrfGetState
;; needs-exact-layout java/lang/Boolean
;; needs-exact-layout java/lang/Boolean
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_GrfGetState

;; native-method palmos/Palm.GrfInitState()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapGrfInitState
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.GrfInitState
	dc.b	80,97,108,109,46,71,114,102,73,110,105,116,83,116,97,116,101,0
#endif

;; native-method palmos/Palm.GrfProcessStroke(Lpalmos/PointType;Lpalmos/PointType;Z)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapGrfProcessStroke
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.GrfProcessStroke
	dc.b	80,97,108,109,46,71,114,102,80,114,111,99,101,115,115,83,116,114,111,107,101,0
#endif

;; native-method palmos/Palm.GrfSetState(ZZZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.b	15(a6),-(a7)
	move.b	19(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGrfSetState
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.GrfSetState
	dc.b	80,97,108,109,46,71,114,102,83,101,116,83,116,97,116,101,0,0
#endif

;; native-method palmos/Palm.GsiEnable(Z)V
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGsiEnable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.GsiEnable
	dc.b	80,97,108,109,46,71,115,105,69,110,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.GsiEnabled()Z
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapGsiEnabled
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.GsiEnabled
	dc.b	80,97,108,109,46,71,115,105,69,110,97,98,108,101,100,0
#endif

;; native-method palmos/Palm.GsiInitialize()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapGsiInitialize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.GsiInitialize
	dc.b	80,97,108,109,46,71,115,105,73,110,105,116,105,97,108,105,122,101,0,0
#endif

;; native-method palmos/Palm.GsiSetLocation(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGsiSetLocation
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.GsiSetLocation
	dc.b	80,97,108,109,46,71,115,105,83,101,116,76,111,99,97,116,105,111,110,0
#endif

;; native-method palmos/Palm.GsiSetShiftState(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapGsiSetShiftState
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.GsiSetShiftState
	dc.b	80,97,108,109,46,71,115,105,83,101,116,83,104,105,102,116,83,116,97,116,101,0
#endif

;; native-method palmos/Palm.HwrBacklight(ZZ)Z
	link	a6,#0
	move.b	11(a6),-(a7)
	move.b	15(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapHwrBacklight
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.HwrBacklight
	dc.b	80,97,108,109,46,72,119,114,66,97,99,107,108,105,103,104,116,0
#endif

;; native-method palmos/Palm.HwrDisplayAttributes(ZILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.b	15(a6),-(a7)
	move.b	19(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapHwrDisplayAttributes
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.HwrDisplayAttributes
	dc.b	80,97,108,109,46,72,119,114,68,105,115,112,108,97,121,65,116,116,114,105,98,117,116,101,115,0
#endif

;; native-method palmos/Palm.InsPtEnable(Z)V
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapInsPtEnable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.InsPtEnable
	dc.b	80,97,108,109,46,73,110,115,80,116,69,110,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.InsPtEnabled()Z
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapInsPtEnabled
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.InsPtEnabled
	dc.b	80,97,108,109,46,73,110,115,80,116,69,110,97,98,108,101,100,0
#endif

;; native-method palmos/Palm.InsPtGetHeight()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapInsPtGetHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.InsPtGetHeight
	dc.b	80,97,108,109,46,73,110,115,80,116,71,101,116,72,101,105,103,104,116,0
#endif

;; native-method palmos/Palm.InsPtGetLocation(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapInsPtGetLocation
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.InsPtGetLocation
	dc.b	80,97,108,109,46,73,110,115,80,116,71,101,116,76,111,99,97,116,105,111,110,0
#endif

;; native-method palmos/Palm.InsPtGetLocation(Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.InsPtGetLocation(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_InsPtGetLocation
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_InsPtGetLocation

;; native-method palmos/Palm.InsPtSetHeight(I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapInsPtSetHeight
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.InsPtSetHeight
	dc.b	80,97,108,109,46,73,110,115,80,116,83,101,116,72,101,105,103,104,116,0
#endif

;; native-method palmos/Palm.InsPtSetLocation(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapInsPtSetLocation
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.InsPtSetLocation
	dc.b	80,97,108,109,46,73,110,115,80,116,83,101,116,76,111,99,97,116,105,111,110,0
#endif

;; native-method palmos/Palm.KeyCurrentState()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapKeyCurrentState
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.KeyCurrentState
	dc.b	80,97,108,109,46,75,101,121,67,117,114,114,101,110,116,83,116,97,116,101,0,0
#endif

;; native-method palmos/Palm.KeyRates(ZLpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	27(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapKeyRates
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.KeyRates
	dc.b	80,97,108,109,46,75,101,121,82,97,116,101,115,0
#endif

;; native-method palmos/Palm.KeyRates(ZLjava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)I
;; uses-method palmos/Palm.KeyRates(ZLpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I as new_KeyRates
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_KeyRates

;; native-method palmos/Palm.LstDrawList(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstDrawList
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.LstDrawList
	dc.b	80,97,108,109,46,76,115,116,68,114,97,119,76,105,115,116,0,0
#endif

;; native-method palmos/Palm.LstEraseList(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstEraseList
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.LstEraseList
	dc.b	80,97,108,109,46,76,115,116,69,114,97,115,101,76,105,115,116,0
#endif

;; native-method palmos/Palm.LstGetNumberOfItems(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstGetNumberOfItems
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.LstGetNumberOfItems
	dc.b	80,97,108,109,46,76,115,116,71,101,116,78,117,109,98,101,114,79,102,73,116,101,109,115,0,0
#endif

;; native-method palmos/Palm.LstGetSelection(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstGetSelection
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.LstGetSelection
	dc.b	80,97,108,109,46,76,115,116,71,101,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.LstGetSelectionText(II)Ljava/lang/String;
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstGetSelectionText
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.LstGetSelectionText
	dc.b	80,97,108,109,46,76,115,116,71,101,116,83,101,108,101,99,116,105,111,110,84,101,120,116,0,0
#endif

;; native-method palmos/Palm.LstHandleEvent(ILpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.LstHandleEvent
	dc.b	80,97,108,109,46,76,115,116,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.LstMakeItemVisible(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstMakeItemVisible
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.LstMakeItemVisible
	dc.b	80,97,108,109,46,76,115,116,77,97,107,101,73,116,101,109,86,105,115,105,98,108,101,0
#endif

;; native-method palmos/Palm.LstPopupList(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstPopupList
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.LstPopupList
	dc.b	80,97,108,109,46,76,115,116,80,111,112,117,112,76,105,115,116,0
#endif

;; native-method palmos/Palm.LstSetHeight(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstSetHeight
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.LstSetHeight
	dc.b	80,97,108,109,46,76,115,116,83,101,116,72,101,105,103,104,116,0
#endif

;; native-method palmos/Palm.LstSetListChoices(ILpalmos/CharPtrArray;I)V
;; needs-exact-layout palmos/CharPtrArray
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),a0
	move.l	(a0),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstSetListChoices
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.LstSetListChoices
	dc.b	80,97,108,109,46,76,115,116,83,101,116,76,105,115,116,67,104,111,105,99,101,115,0,0
#endif

;; native-method palmos/Palm.LstSetPosition(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstSetPosition
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.LstSetPosition
	dc.b	80,97,108,109,46,76,115,116,83,101,116,80,111,115,105,116,105,111,110,0
#endif

;; native-method palmos/Palm.LstSetSelection(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstSetSelection
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.LstSetSelection
	dc.b	80,97,108,109,46,76,115,116,83,101,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.LstSetTopItem(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapLstSetTopItem
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.LstSetTopItem
	dc.b	80,97,108,109,46,76,115,116,83,101,116,84,111,112,73,116,101,109,0,0
#endif

;; native-method palmos/Palm.MemCardInfo(ILjava/lang/StringBuffer;Ljava/lang/StringBuffer;Lpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	28(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	32(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	38(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemCardInfo
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-28(a6),a0
	proxy.release
	move.l	-24(a6),a0
	proxy.release
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	28(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	32(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.MemCardInfo
	dc.b	80,97,108,109,46,77,101,109,67,97,114,100,73,110,102,111,0,0
#endif

;; native-method palmos/Palm.MemCardInfo(ILjava/lang/StringBuffer;Ljava/lang/StringBuffer;Ljava/lang/Short;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.MemCardInfo(ILjava/lang/StringBuffer;Ljava/lang/StringBuffer;Lpalmos/ShortHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_MemCardInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_MemCardInfo

;; native-method palmos/Palm.MemChunkFree(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemChunkFree
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemChunkFree
	dc.b	80,97,108,109,46,77,101,109,67,104,117,110,107,70,114,101,101,0
#endif

;; native-method palmos/Palm.MemDebugMode()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapMemDebugMode
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemDebugMode
	dc.b	80,97,108,109,46,77,101,109,68,101,98,117,103,77,111,100,101,0
#endif

;; native-method palmos/Palm.MemHandleDataStorage(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleDataStorage
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.MemHandleDataStorage
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,68,97,116,97,83,116,111,114,97,103,101,0
#endif

;; native-method palmos/Palm.MemHandleCardNo(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleCardNo
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemHandleCardNo
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,67,97,114,100,78,111,0,0
#endif

;; native-method palmos/Palm.MemHandleFree(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleFree
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.MemHandleFree
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,70,114,101,101,0,0
#endif

;; native-method palmos/Palm.MemHandleHeapID(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleHeapID
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemHandleHeapID
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,72,101,97,112,73,68,0,0
#endif

;; native-method palmos/Palm.MemHandleLock(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleLock
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.MemHandleLock
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,76,111,99,107,0,0
#endif

;; native-method palmos/Palm.MemHandleNew(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleNew
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemHandleNew
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,78,101,119,0
#endif

;; native-method palmos/Palm.MemHandleResize(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleResize
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemHandleResize
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,82,101,115,105,122,101,0,0
#endif

;; native-method palmos/Palm.MemHandleSize(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.MemHandleSize
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.MemHandleToLocalID(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleToLocalID
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.MemHandleToLocalID
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,84,111,76,111,99,97,108,73,68,0
#endif

;; native-method palmos/Palm.MemHandleUnlock(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHandleUnlock
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemHandleUnlock
	dc.b	80,97,108,109,46,77,101,109,72,97,110,100,108,101,85,110,108,111,99,107,0,0
#endif

;; native-method palmos/Palm.MemHeapCheck(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapCheck
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemHeapCheck
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,67,104,101,99,107,0
#endif

;; native-method palmos/Palm.MemHeapCompact(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapCompact
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.MemHeapCompact
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,67,111,109,112,97,99,116,0
#endif

;; native-method palmos/Palm.MemHeapDynamic(I)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapDynamic
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.MemHeapDynamic
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,68,121,110,97,109,105,99,0
#endif

;; native-method palmos/Palm.MemHeapFlags(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapFlags
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemHeapFlags
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,70,108,97,103,115,0
#endif

;; native-method palmos/Palm.MemHeapFreeBytes(ILpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapFreeBytes
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.MemHeapFreeBytes
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,70,114,101,101,66,121,116,101,115,0
#endif

;; native-method palmos/Palm.MemHeapFreeBytes(ILjava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.MemHeapFreeBytes(ILpalmos/IntHolder;Lpalmos/IntHolder;)I as new_MemHeapFreeBytes
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_MemHeapFreeBytes

;; native-method palmos/Palm.MemHeapID(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapID
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.MemHeapID
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,73,68,0,0
#endif

;; native-method palmos/Palm.MemHeapScramble(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapScramble
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemHeapScramble
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,83,99,114,97,109,98,108,101,0,0
#endif

;; native-method palmos/Palm.MemHeapSize(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemHeapSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.MemHeapSize
	dc.b	80,97,108,109,46,77,101,109,72,101,97,112,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.MemLocalIDKind(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemLocalIDKind
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.MemLocalIDKind
	dc.b	80,97,108,109,46,77,101,109,76,111,99,97,108,73,68,75,105,110,100,0
#endif

;; native-method palmos/Palm.MemLocalIDToGlobal(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemLocalIDToGlobal
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.MemLocalIDToGlobal
	dc.b	80,97,108,109,46,77,101,109,76,111,99,97,108,73,68,84,111,71,108,111,98,97,108,0
#endif

;; native-method palmos/Palm.MemLocalIDToLockedPtr(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemLocalIDToLockedPtr
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.MemLocalIDToLockedPtr
	dc.b	80,97,108,109,46,77,101,109,76,111,99,97,108,73,68,84,111,76,111,99,107,101,100,80,116,114,0,0
#endif

;; native-method palmos/Palm.MemLocalIDToPtr(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemLocalIDToPtr
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemLocalIDToPtr
	dc.b	80,97,108,109,46,77,101,109,76,111,99,97,108,73,68,84,111,80,116,114,0,0
#endif

;; native-method palmos/Palm.MemMove(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove(Ljava/lang/Object;II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove(ILjava/lang/Object;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove(Ljava/lang/Object;Ljava/lang/Object;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove([BI[BII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove(I[BII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove([BIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove(Ljava/lang/StringBuffer;II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
#endif
	move.l	16(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemMove(ILjava/lang/String;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemMove
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.MemMove
	dc.b	80,97,108,109,46,77,101,109,77,111,118,101,0,0
#endif

;; native-method palmos/Palm.MemNumCards()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapMemNumCards
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.MemNumCards
	dc.b	80,97,108,109,46,77,101,109,78,117,109,67,97,114,100,115,0,0
#endif

;; native-method palmos/Palm.MemNumHeaps(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemNumHeaps
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.MemNumHeaps
	dc.b	80,97,108,109,46,77,101,109,78,117,109,72,101,97,112,115,0,0
#endif

;; native-method palmos/Palm.MemNumRAMHeaps(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemNumRAMHeaps
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.MemNumRAMHeaps
	dc.b	80,97,108,109,46,77,101,109,78,117,109,82,65,77,72,101,97,112,115,0
#endif

;; native-method palmos/Palm.MemPtrCardNo(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrCardNo
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemPtrCardNo
	dc.b	80,97,108,109,46,77,101,109,80,116,114,67,97,114,100,78,111,0
#endif

;; native-method palmos/Palm.MemPtrDataStorage(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrDataStorage
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.MemPtrDataStorage
	dc.b	80,97,108,109,46,77,101,109,80,116,114,68,97,116,97,83,116,111,114,97,103,101,0,0
#endif

;; native-method palmos/Palm.MemPtrFree(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrFree
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.MemPtrFree
	dc.b	80,97,108,109,46,77,101,109,80,116,114,70,114,101,101,0
#endif

;; native-method palmos/Palm.MemPtrHeapID(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrHeapID
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemPtrHeapID
	dc.b	80,97,108,109,46,77,101,109,80,116,114,72,101,97,112,73,68,0
#endif

;; native-method palmos/Palm.MemPtrToLocalID(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrToLocalID
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemPtrToLocalID
	dc.b	80,97,108,109,46,77,101,109,80,116,114,84,111,76,111,99,97,108,73,68,0,0
#endif

;; native-method palmos/Palm.MemPtrNew(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrNew
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.MemPtrNew
	dc.b	80,97,108,109,46,77,101,109,80,116,114,78,101,119,0,0
#endif

;; native-method palmos/Palm.MemPtrRecoverHandle(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrRecoverHandle
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.MemPtrRecoverHandle
	dc.b	80,97,108,109,46,77,101,109,80,116,114,82,101,99,111,118,101,114,72,97,110,100,108,101,0,0
#endif

;; native-method palmos/Palm.MemPtrSetOwner(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrSetOwner
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.MemPtrSetOwner
	dc.b	80,97,108,109,46,77,101,109,80,116,114,83,101,116,79,119,110,101,114,0
#endif

;; native-method palmos/Palm.MemPtrResize(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrResize
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemPtrResize
	dc.b	80,97,108,109,46,77,101,109,80,116,114,82,101,115,105,122,101,0
#endif

;; native-method palmos/Palm.MemSet(III)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemSet
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.MemSet
	dc.b	80,97,108,109,46,77,101,109,83,101,116,0
#endif

;; native-method palmos/Palm.MemSet([BIII)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemSet
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.MemSet
	dc.b	80,97,108,109,46,77,101,109,83,101,116,0
#endif

;; native-method palmos/Palm.MemSetDebugMode(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemSetDebugMode
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MemSetDebugMode
	dc.b	80,97,108,109,46,77,101,109,83,101,116,68,101,98,117,103,77,111,100,101,0,0
#endif

;; native-method palmos/Palm.MemPtrSize(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.MemPtrSize
	dc.b	80,97,108,109,46,77,101,109,80,116,114,83,105,122,101,0
#endif

;; native-method palmos/Palm.MemPtrUnlock(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemPtrUnlock
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemPtrUnlock
	dc.b	80,97,108,109,46,77,101,109,80,116,114,85,110,108,111,99,107,0
#endif

;; native-method palmos/Palm.MemStoreInfo(IILpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/StringBuffer;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	28(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	32(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	36(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	40(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	46(a6),-(a7)
	move.w	50(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMemStoreInfo
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-36(a6),a0
	proxy.release
	move.l	-32(a6),a0
	proxy.release
	move.l	-28(a6),a0
	proxy.release
	move.l	-24(a6),a0
	proxy.release
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	32(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MemStoreInfo
	dc.b	80,97,108,109,46,77,101,109,83,116,111,114,101,73,110,102,111,0
#endif

;; native-method palmos/Palm.MemStoreInfo(IILjava/lang/Short;Ljava/lang/Short;Ljava/lang/StringBuffer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.MemStoreInfo(IILpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/StringBuffer;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_MemStoreInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_MemStoreInfo

;; native-method palmos/Palm.MenuDispose(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMenuDispose
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.MenuDispose
	dc.b	80,97,108,109,46,77,101,110,117,68,105,115,112,111,115,101,0,0
#endif

;; native-method palmos/Palm.MenuDrawMenu(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMenuDrawMenu
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.MenuDrawMenu
	dc.b	80,97,108,109,46,77,101,110,117,68,114,97,119,77,101,110,117,0
#endif

;; native-method palmos/Palm.MenuEraseStatus(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMenuEraseStatus
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MenuEraseStatus
	dc.b	80,97,108,109,46,77,101,110,117,69,114,97,115,101,83,116,97,116,117,115,0,0
#endif

;; native-method palmos/Palm.MenuGetActiveMenu()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapMenuGetActiveMenu
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.MenuGetActiveMenu
	dc.b	80,97,108,109,46,77,101,110,117,71,101,116,65,99,116,105,118,101,77,101,110,117,0,0
#endif

;; native-method palmos/Palm.MenuHandleEvent(ILpalmos/Event;Lpalmos/ShortHolder;)Z
;; needs-exact-layout palmos/Event
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMenuHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.MenuHandleEvent
	dc.b	80,97,108,109,46,77,101,110,117,72,97,110,100,108,101,69,118,101,110,116,0,0
#endif

;; native-method palmos/Palm.MenuHandleEvent(ILpalmos/Event;Ljava/lang/Short;)Z
;; uses-method palmos/Palm.MenuHandleEvent(ILpalmos/Event;Lpalmos/ShortHolder;)Z as new_MenuHandleEvent
;; needs-exact-layout palmos/Event
;; needs-exact-layout java/lang/Short
	bra.far	new_MenuHandleEvent

;; native-method palmos/Palm.MenuInit(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMenuInit
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.MenuInit
	dc.b	80,97,108,109,46,77,101,110,117,73,110,105,116,0
#endif

;; native-method palmos/Palm.MenuSetActiveMenu(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapMenuSetActiveMenu
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.MenuSetActiveMenu
	dc.b	80,97,108,109,46,77,101,110,117,83,101,116,65,99,116,105,118,101,77,101,110,117,0,0
#endif

;; native-method palmos/Palm.AbtShowAbout(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapAbtShowAbout
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.AbtShowAbout
	dc.b	80,97,108,109,46,65,98,116,83,104,111,119,65,98,111,117,116,0
#endif

;; native-method palmos/Palm.Crc16CalcBlock(Ljava/lang/Object;II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapCrc16CalcBlock
	mem.reserve.savereg
	and.l	#$ffff,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.Crc16CalcBlock
	dc.b	80,97,108,109,46,67,114,99,49,54,67,97,108,99,66,108,111,99,107,0
#endif

;; native-method palmos/Palm.DayHandleEvent(Lpalmos/DaySelector;Lpalmos/Event;)Z
;; needs-exact-layout palmos/DaySelector
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapDayHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DayHandleEvent
	dc.b	80,97,108,109,46,68,97,121,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.NetLibOpen(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibOpen
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.NetLibOpen
	dc.b	80,97,108,109,46,78,101,116,76,105,98,79,112,101,110,0
#endif

;; native-method palmos/Palm.NetLibOpenCount(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibOpenCount
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.NetLibOpenCount
	dc.b	80,97,108,109,46,78,101,116,76,105,98,79,112,101,110,67,111,117,110,116,0,0
#endif

;; native-method palmos/Palm.NetLibOpenCount(ILjava/lang/Short;)I
;; uses-method palmos/Palm.NetLibOpenCount(ILpalmos/ShortHolder;)I as new_NetLibOpenCount
;; needs-exact-layout java/lang/Short
	bra.far	new_NetLibOpenCount

;; native-method palmos/Palm.NetLibClose(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibClose
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.NetLibClose
	dc.b	80,97,108,109,46,78,101,116,76,105,98,67,108,111,115,101,0,0
#endif

;; native-method palmos/Palm.NetLibConnectionRefresh(IZLpalmos/ByteHolder;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ByteHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	19(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibConnectionRefresh
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.NetLibConnectionRefresh
	dc.b	80,97,108,109,46,78,101,116,76,105,98,67,111,110,110,101,99,116,105,111,110,82,101,102,114,101,115,104,0,0
#endif

;; native-method palmos/Palm.NetLibConnectionRefresh(IZLjava/lang/Byte;Lpalmos/ShortHolder;)I
;; uses-method palmos/Palm.NetLibConnectionRefresh(IZLpalmos/ByteHolder;Lpalmos/ShortHolder;)I as new_NetLibConnectionRefresh
;; needs-exact-layout java/lang/Byte
;; needs-exact-layout palmos/ShortHolder
	bra.far	new_NetLibConnectionRefresh

;; native-method palmos/Palm.NetLibSleep(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSleep
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.NetLibSleep
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,108,101,101,112,0,0
#endif

;; native-method palmos/Palm.NetLibWake(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibWake
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.NetLibWake
	dc.b	80,97,108,109,46,78,101,116,76,105,98,87,97,107,101,0
#endif

;; native-method palmos/Palm.NetLibSocketOpen(IIIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.b	23(a6),-(a7)
	move.b	27(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketOpen
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.NetLibSocketOpen
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,79,112,101,110,0
#endif

;; native-method palmos/Palm.NetLibSocketClose(IIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketClose
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.NetLibSocketClose
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,67,108,111,115,101,0,0
#endif

;; native-method palmos/Palm.NetLibSocketOptionGet(IIIILjava/lang/Object;Lpalmos/ShortHolder;ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.w	34(a6),-(a7)
	move.w	38(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketOptionGet
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.NetLibSocketOptionGet
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,79,112,116,105,111,110,71,101,116,0,0
#endif

;; native-method palmos/Palm.NetLibSocketOptionGet(IIIILjava/lang/Object;Ljava/lang/Short;ILpalmos/ShortHolder;)I
;; uses-method palmos/Palm.NetLibSocketOptionGet(IIIILjava/lang/Object;Lpalmos/ShortHolder;ILpalmos/ShortHolder;)I as new_NetLibSocketOptionGet
;; needs-exact-layout java/lang/Short
;; needs-exact-layout palmos/ShortHolder
	bra.far	new_NetLibSocketOptionGet

;; native-method palmos/Palm.NetLibSocketOptionSet(IIIILjava/lang/Object;IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.w	34(a6),-(a7)
	move.w	38(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketOptionSet
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-14(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.NetLibSocketOptionSet
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,79,112,116,105,111,110,83,101,116,0,0
#endif

;; native-method palmos/Palm.NetLibSocketConnect(IILpalmos/NetSocketAddrType;IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketConnect
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-14(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.NetLibSocketConnect
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,67,111,110,110,101,99,116,0,0
#endif

;; native-method palmos/Palm.NetLibSocketBind(IILpalmos/NetSocketAddrType;IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketBind
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-14(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.NetLibSocketBind
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,66,105,110,100,0
#endif

;; native-method palmos/Palm.NetLibSocketListen(IIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketListen
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.NetLibSocketListen
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,76,105,115,116,101,110,0
#endif

;; native-method palmos/Palm.NetLibSocketAccept(IILpalmos/NetSocketAddrType;Lpalmos/ShortHolder;ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketAccept
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.NetLibSocketAccept
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,65,99,99,101,112,116,0
#endif

;; native-method palmos/Palm.NetLibSocketAccept(IILpalmos/NetSocketAddrType;Ljava/lang/Short;ILpalmos/ShortHolder;)I
;; uses-method palmos/Palm.NetLibSocketAccept(IILpalmos/NetSocketAddrType;Lpalmos/ShortHolder;ILpalmos/ShortHolder;)I as new_NetLibSocketAccept
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout java/lang/Short
;; needs-exact-layout palmos/ShortHolder
	bra.far	new_NetLibSocketAccept

;; native-method palmos/Palm.NetLibSocketShutdown(IIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSocketShutdown
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.NetLibSocketShutdown
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,111,99,107,101,116,83,104,117,116,100,111,119,110,0
#endif

;; native-method palmos/Palm.NetLibSend(II[BIIIIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.l	36(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	32(a6),a0
	sub.l	32(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	42(a6),-(a7)
	move.w	46(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSend
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-22(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.NetLibSend
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,101,110,100,0
#endif

;; native-method palmos/Palm.NetLibSend(II[BIIILpalmos/NetSocketAddrType;IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.l	36(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	32(a6),a0
	sub.l	32(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	42(a6),-(a7)
	move.w	46(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibSend
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-22(a6),a0
	proxy.release
	move.l	-14(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.NetLibSend
	dc.b	80,97,108,109,46,78,101,116,76,105,98,83,101,110,100,0
#endif

;; native-method palmos/Palm.NetLibReceive(II[BIIIIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.l	36(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	32(a6),a0
	sub.l	32(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	42(a6),-(a7)
	move.w	46(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibReceive
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-24(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.NetLibReceive
	dc.b	80,97,108,109,46,78,101,116,76,105,98,82,101,99,101,105,118,101,0,0
#endif

;; native-method palmos/Palm.NetLibReceive(II[BIIILpalmos/NetSocketAddrType;Lpalmos/ShortHolder;ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	move.w	30(a6),-(a7)
	move.l	36(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	32(a6),a0
	sub.l	32(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	42(a6),-(a7)
	move.w	46(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibReceive
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-24(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.NetLibReceive
	dc.b	80,97,108,109,46,78,101,116,76,105,98,82,101,99,101,105,118,101,0,0
#endif

;; native-method palmos/Palm.NetLibReceive(II[BIIILpalmos/NetSocketAddrType;Ljava/lang/Short;ILpalmos/ShortHolder;)I
;; uses-method palmos/Palm.NetLibReceive(II[BIIILpalmos/NetSocketAddrType;Lpalmos/ShortHolder;ILpalmos/ShortHolder;)I as new_NetLibReceive
;; needs-exact-layout palmos/NetSocketAddrType
;; needs-exact-layout java/lang/Short
;; needs-exact-layout palmos/ShortHolder
	bra.far	new_NetLibReceive

;; native-method palmos/Palm.NetLibAddrINToA(IILjava/lang/StringBuffer;)Ljava/lang/String;
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibAddrINToA
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	move.l	a0,-(a7)
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	8(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,a0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.NetLibAddrINToA
	dc.b	80,97,108,109,46,78,101,116,76,105,98,65,100,100,114,73,78,84,111,65,0,0
#endif

;; native-method palmos/Palm.NetLibAddrAToIN(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibAddrAToIN
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.NetLibAddrAToIN
	dc.b	80,97,108,109,46,78,101,116,76,105,98,65,100,100,114,65,84,111,73,78,0,0
#endif

;; native-method palmos/Palm.NetLibGetHostByName(ILjava/lang/String;[IIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	16(a6),d1
	mulu.w	#4,d1
	adda.l	d1,a0
	sub.l	d1,d0
	proxy.get
	move.l	a0,(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapNetLibGetHostByName
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.NetLibGetHostByName
	dc.b	80,97,108,109,46,78,101,116,76,105,98,71,101,116,72,111,115,116,66,121,78,97,109,101,0,0
#endif

;; native-method palmos/Palm.PceNativeCall(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapPceNativeCall
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.PceNativeCall
	dc.b	80,97,108,109,46,80,99,101,78,97,116,105,118,101,67,97,108,108,0,0
#endif

;; native-method palmos/Palm.PenCalibrate(Lpalmos/PointType;Lpalmos/PointType;Lpalmos/PointType;Lpalmos/PointType;)I
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapPenCalibrate
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.PenCalibrate
	dc.b	80,97,108,109,46,80,101,110,67,97,108,105,98,114,97,116,101,0
#endif

;; native-method palmos/Palm.PenResetCalibration()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapPenResetCalibration
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.PenResetCalibration
	dc.b	80,97,108,109,46,80,101,110,82,101,115,101,116,67,97,108,105,98,114,97,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.PrefGetAppPreferences(IILjava/lang/Object;I)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapPrefGetAppPreferencesV10
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.PrefGetAppPreferences
	dc.b	80,97,108,109,46,80,114,101,102,71,101,116,65,112,112,80,114,101,102,101,114,101,110,99,101,115,0,0
#endif

;; native-method palmos/Palm.PrefGetPreferences(Lpalmos/SystemPreferences;)V
;; needs-exact-layout palmos/SystemPreferences
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapPrefGetPreferences
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.PrefGetPreferences
	dc.b	80,97,108,109,46,80,114,101,102,71,101,116,80,114,101,102,101,114,101,110,99,101,115,0
#endif

;; native-method palmos/Palm.PrefOpenPreferenceDB()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapPrefOpenPreferenceDBV10
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.PrefOpenPreferenceDB
	dc.b	80,97,108,109,46,80,114,101,102,79,112,101,110,80,114,101,102,101,114,101,110,99,101,68,66,0
#endif

;; native-method palmos/Palm.PrefSetAppPreferences(IILjava/lang/Object;I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapPrefSetAppPreferencesV10
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.PrefSetAppPreferences
	dc.b	80,97,108,109,46,80,114,101,102,83,101,116,65,112,112,80,114,101,102,101,114,101,110,99,101,115,0,0
#endif

;; native-method palmos/Palm.PrefSetPreferences(Lpalmos/SystemPreferences;)V
;; needs-exact-layout palmos/SystemPreferences
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapPrefSetPreferences
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.PrefSetPreferences
	dc.b	80,97,108,109,46,80,114,101,102,83,101,116,80,114,101,102,101,114,101,110,99,101,115,0
#endif

;; native-method palmos/Palm.PrefGetAppPreferences(IILjava/lang/Object;Lpalmos/ShortHolder;Z)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapPrefGetAppPreferences
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.PrefGetAppPreferences
	dc.b	80,97,108,109,46,80,114,101,102,71,101,116,65,112,112,80,114,101,102,101,114,101,110,99,101,115,0,0
#endif

;; native-method palmos/Palm.PrefGetAppPreferences(IILjava/lang/Object;Ljava/lang/Short;Z)I
;; uses-method palmos/Palm.PrefGetAppPreferences(IILjava/lang/Object;Lpalmos/ShortHolder;Z)I as new_PrefGetAppPreferences
;; needs-exact-layout java/lang/Short
	bra.far	new_PrefGetAppPreferences

;; native-method palmos/Palm.PrefSetAppPreferences(IIILjava/lang/Object;IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	move.l	28(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapPrefSetAppPreferences
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.PrefSetAppPreferences
	dc.b	80,97,108,109,46,80,114,101,102,83,101,116,65,112,112,80,114,101,102,101,114,101,110,99,101,115,0,0
#endif

;; native-method palmos/Palm.PrefGetPreference(I)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapPrefGetPreference
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.PrefGetPreference
	dc.b	80,97,108,109,46,80,114,101,102,71,101,116,80,114,101,102,101,114,101,110,99,101,0,0
#endif

;; native-method palmos/Palm.SclDrawScrollBar(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSclDrawScrollBar
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.SclDrawScrollBar
	dc.b	80,97,108,109,46,83,99,108,68,114,97,119,83,99,114,111,108,108,66,97,114,0
#endif

;; native-method palmos/Palm.SclGetScrollBar(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSclGetScrollBar
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SclGetScrollBar
	dc.b	80,97,108,109,46,83,99,108,71,101,116,83,99,114,111,108,108,66,97,114,0,0
#endif

;; native-method palmos/Palm.SclGetScrollBar(ILjava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.SclGetScrollBar(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_SclGetScrollBar
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_SclGetScrollBar

;; native-method palmos/Palm.SclHandleEvent(ILpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSclHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SclHandleEvent
	dc.b	80,97,108,109,46,83,99,108,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.SclSetScrollBar(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSclSetScrollBar
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SclSetScrollBar
	dc.b	80,97,108,109,46,83,99,108,83,101,116,83,99,114,111,108,108,66,97,114,0,0
#endif

;; native-method palmos/Palm.SerOpen(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerOpen
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SerOpen
	dc.b	80,97,108,109,46,83,101,114,79,112,101,110,0,0
#endif

;; native-method palmos/Palm.SerClose(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerClose
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SerClose
	dc.b	80,97,108,109,46,83,101,114,67,108,111,115,101,0
#endif

;; native-method palmos/Palm.SerSleep(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSleep
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SerSleep
	dc.b	80,97,108,109,46,83,101,114,83,108,101,101,112,0
#endif

;; native-method palmos/Palm.SerWake(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerWake
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SerWake
	dc.b	80,97,108,109,46,83,101,114,87,97,107,101,0,0
#endif

;; native-method palmos/Palm.SerGetSettings(ILpalmos/SerSettings;)I
;; needs-exact-layout palmos/SerSettings
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerGetSettings
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SerGetSettings
	dc.b	80,97,108,109,46,83,101,114,71,101,116,83,101,116,116,105,110,103,115,0
#endif

;; native-method palmos/Palm.SerSetSettings(ILpalmos/SerSettings;)I
;; needs-exact-layout palmos/SerSettings
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSetSettings
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SerSetSettings
	dc.b	80,97,108,109,46,83,101,114,83,101,116,83,101,116,116,105,110,103,115,0
#endif

;; native-method palmos/Palm.SerGetStatus(ILpalmos/BoolHolder;Lpalmos/BoolHolder;)I
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerGetStatus
	mem.reserve.savereg
	and.l	#$ffff,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SerGetStatus
	dc.b	80,97,108,109,46,83,101,114,71,101,116,83,116,97,116,117,115,0
#endif

;; native-method palmos/Palm.SerGetStatus(ILjava/lang/Boolean;Ljava/lang/Boolean;)I
;; uses-method palmos/Palm.SerGetStatus(ILpalmos/BoolHolder;Lpalmos/BoolHolder;)I as new_SerGetStatus
;; needs-exact-layout java/lang/Boolean
;; needs-exact-layout java/lang/Boolean
	bra.far	new_SerGetStatus

;; native-method palmos/Palm.SerClearErr(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerClearErr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.SerClearErr
	dc.b	80,97,108,109,46,83,101,114,67,108,101,97,114,69,114,114,0,0
#endif

;; native-method palmos/Palm.SerSend(I[BII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSend10
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SerSend
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,0,0
#endif

;; native-method palmos/Palm.SerSend(ILjava/lang/Object;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSend10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SerSend
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,0,0
#endif

;; native-method palmos/Palm.SerSend10(I[BII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSend10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.SerSend10
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,49,48,0,0
#endif

;; native-method palmos/Palm.SerSend10(ILjava/lang/Object;I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSend10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.SerSend10
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,49,48,0,0
#endif

;; native-method palmos/Palm.SerSendWait(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSendWait
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.SerSendWait
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,87,97,105,116,0,0
#endif

;; native-method palmos/Palm.SerSendCheck(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSendCheck
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SerSendCheck
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,67,104,101,99,107,0
#endif

;; native-method palmos/Palm.SerSendCheck(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.SerSendCheck(ILpalmos/IntHolder;)I as new_SerSendCheck
;; needs-exact-layout java/lang/Integer
	bra.far	new_SerSendCheck

;; native-method palmos/Palm.SerSendFlush(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSendFlush
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SerSendFlush
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,70,108,117,115,104,0
#endif

;; native-method palmos/Palm.SerReceive(I[BIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceive10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SerReceive
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,0
#endif

;; native-method palmos/Palm.SerReceive(ILjava/lang/Object;II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceive10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SerReceive
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,0
#endif

;; native-method palmos/Palm.SerReceive10(I[BIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceive10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SerReceive10
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,49,48,0
#endif

;; native-method palmos/Palm.SerReceive10(ILjava/lang/Object;II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceive10
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SerReceive10
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,49,48,0
#endif

;; native-method palmos/Palm.SerReceiveWait(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceiveWait
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SerReceiveWait
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,87,97,105,116,0
#endif

;; native-method palmos/Palm.SerReceiveCheck(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceiveCheck
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SerReceiveCheck
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,67,104,101,99,107,0,0
#endif

;; native-method palmos/Palm.SerReceiveCheck(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.SerReceiveCheck(ILpalmos/IntHolder;)I as new_SerReceiveCheck
;; needs-exact-layout java/lang/Integer
	bra.far	new_SerReceiveCheck

;; native-method palmos/Palm.SerReceiveFlush(II)V
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceiveFlush
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SerReceiveFlush
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,70,108,117,115,104,0,0
#endif

;; native-method palmos/Palm.SerSetReceiveBuffer(ILjava/lang/Object;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSetReceiveBuffer
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SerSetReceiveBuffer
	dc.b	80,97,108,109,46,83,101,114,83,101,116,82,101,99,101,105,118,101,66,117,102,102,101,114,0,0
#endif

;; native-method palmos/Palm.SerReceiveWindowOpen(I[BILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceiveWindowOpen
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.SerReceiveWindowOpen
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,87,105,110,100,111,119,79,112,101,110,0
#endif

;; native-method palmos/Palm.SerReceiveWindowOpen(I[BILjava/lang/Integer;)I
;; uses-method palmos/Palm.SerReceiveWindowOpen(I[BILpalmos/IntHolder;)I as new_SerReceiveWindowOpen
;; needs-exact-layout java/lang/Integer
	bra.far	new_SerReceiveWindowOpen

;; native-method palmos/Palm.SerReceiveWindowClose(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceiveWindowClose
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.SerReceiveWindowClose
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,87,105,110,100,111,119,67,108,111,115,101,0,0
#endif

;; native-method palmos/Palm.SerPrimeWakeupHandler(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerPrimeWakeupHandler
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.SerPrimeWakeupHandler
	dc.b	80,97,108,109,46,83,101,114,80,114,105,109,101,87,97,107,101,117,112,72,97,110,100,108,101,114,0,0
#endif

;; native-method palmos/Palm.SerControl(IILjava/lang/Object;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerControl
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SerControl
	dc.b	80,97,108,109,46,83,101,114,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.SerControl(IILjava/lang/Object;Ljava/lang/Short;)I
;; uses-method palmos/Palm.SerControl(IILjava/lang/Object;Lpalmos/ShortHolder;)I as new_SerControl
;; needs-exact-layout java/lang/Short
	bra.far	new_SerControl

;; native-method palmos/Palm.SerControl(IIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerControl
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SerControl
	dc.b	80,97,108,109,46,83,101,114,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.SerSend(I[BIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSend
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SerSend
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,0,0
#endif

;; native-method palmos/Palm.SerSend(ILjava/lang/Object;ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerSend
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SerSend
	dc.b	80,97,108,109,46,83,101,114,83,101,110,100,0,0
#endif

;; native-method palmos/Palm.SerReceive(I[BIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceive
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SerReceive
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,0
#endif

;; native-method palmos/Palm.SerReceive(ILjava/lang/Object;IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSerReceive
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SerReceive
	dc.b	80,97,108,109,46,83,101,114,82,101,99,101,105,118,101,0
#endif

;; native-method palmos/Palm.SlkClose()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapSlkClose
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SlkClose
	dc.b	80,97,108,109,46,83,108,107,67,108,111,115,101,0
#endif

;; native-method palmos/Palm.SlkCloseSocket(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSlkCloseSocket
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SlkCloseSocket
	dc.b	80,97,108,109,46,83,108,107,67,108,111,115,101,83,111,99,107,101,116,0
#endif

;; native-method palmos/Palm.SlkFlushSocket(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSlkFlushSocket
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SlkFlushSocket
	dc.b	80,97,108,109,46,83,108,107,70,108,117,115,104,83,111,99,107,101,116,0
#endif

;; native-method palmos/Palm.SlkOpen()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapSlkOpen
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SlkOpen
	dc.b	80,97,108,109,46,83,108,107,79,112,101,110,0,0
#endif

;; native-method palmos/Palm.SlkOpenSocket(ILpalmos/ShortHolder;Z)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSlkOpenSocket
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.SlkOpenSocket
	dc.b	80,97,108,109,46,83,108,107,79,112,101,110,83,111,99,107,101,116,0,0
#endif

;; native-method palmos/Palm.SlkOpenSocket(ILjava/lang/Short;Z)I
;; uses-method palmos/Palm.SlkOpenSocket(ILpalmos/ShortHolder;Z)I as new_SlkOpenSocket
;; needs-exact-layout java/lang/Short
	bra.far	new_SlkOpenSocket

;; native-method palmos/Palm.SlkReceivePacket(IZLpalmos/SlkPktHeader;Ljava/lang/Object;II)I
;; needs-exact-layout palmos/SlkPktHeader
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	27(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSlkReceivePacket
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-14(a6),a0
	proxy.release
	move.l	-10(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.SlkReceivePacket
	dc.b	80,97,108,109,46,83,108,107,82,101,99,101,105,118,101,80,97,99,107,101,116,0
#endif

;; native-method palmos/Palm.SlkSocketRefNum(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSlkSocketRefNum
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SlkSocketRefNum
	dc.b	80,97,108,109,46,83,108,107,83,111,99,107,101,116,82,101,102,78,117,109,0,0
#endif

;; native-method palmos/Palm.SlkSocketRefNum(ILjava/lang/Short;)I
;; uses-method palmos/Palm.SlkSocketRefNum(ILpalmos/ShortHolder;)I as new_SlkSocketRefNum
;; needs-exact-layout java/lang/Short
	bra.far	new_SlkSocketRefNum

;; native-method palmos/Palm.SlkSocketSetTimeout(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSlkSocketSetTimeout
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SlkSocketSetTimeout
	dc.b	80,97,108,109,46,83,108,107,83,111,99,107,101,116,83,101,116,84,105,109,101,111,117,116,0,0
#endif

;; native-method palmos/Palm.SndDoCmd(Ljava/lang/Object;Lpalmos/SndCommand;Z)I
;; needs-exact-layout palmos/SndCommand
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSndDoCmd
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SndDoCmd
	dc.b	80,97,108,109,46,83,110,100,68,111,67,109,100,0
#endif

;; native-method palmos/Palm.SndGetDefaultVolume(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSndGetDefaultVolume
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SndGetDefaultVolume
	dc.b	80,97,108,109,46,83,110,100,71,101,116,68,101,102,97,117,108,116,86,111,108,117,109,101,0,0
#endif

;; native-method palmos/Palm.SndGetDefaultVolume(Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.SndGetDefaultVolume(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_SndGetDefaultVolume
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_SndGetDefaultVolume

;; native-method palmos/Palm.SndPlaySystemSound(I)V
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSndPlaySystemSound
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.SndPlaySystemSound
	dc.b	80,97,108,109,46,83,110,100,80,108,97,121,83,121,115,116,101,109,83,111,117,110,100,0
#endif

;; native-method palmos/Palm.SndSetDefaultVolume(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSndSetDefaultVolume
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SndSetDefaultVolume
	dc.b	80,97,108,109,46,83,110,100,83,101,116,68,101,102,97,117,108,116,86,111,108,117,109,101,0,0
#endif

;; native-method palmos/Palm.SndSetDefaultVolume(Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.SndSetDefaultVolume(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_SndSetDefaultVolume
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_SndSetDefaultVolume

;; native-method palmos/Palm.SndPlayResource(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSndPlayResource
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SndPlayResource
	dc.b	80,97,108,109,46,83,110,100,80,108,97,121,82,101,115,111,117,114,99,101,0,0
#endif

;; native-method palmos/Palm.SerialMgrInstall()I
	link	a6,#0
	mem.release
	moveq.l	#sysSerialInstall,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.SerialMgrInstall
	dc.b	80,97,108,109,46,83,101,114,105,97,108,77,103,114,73,110,115,116,97,108,108,0
#endif

;; native-method palmos/Palm.SrmOpen(IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	moveq.l	#sysSerialOpen,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SrmOpen
	dc.b	80,97,108,109,46,83,114,109,79,112,101,110,0,0
#endif

;; native-method palmos/Palm.SrmOpen(IILjava/lang/Short;)I
;; uses-method palmos/Palm.SrmOpen(IILpalmos/ShortHolder;)I as new_SrmOpen
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmOpen

;; native-method palmos/Palm.SrmClose(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#sysSerialClose,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SrmClose
	dc.b	80,97,108,109,46,83,114,109,67,108,111,115,101,0
#endif

;; native-method palmos/Palm.SrmSleep()I
	link	a6,#0
	mem.release
	moveq.l	#sysSerialSleep,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SrmSleep
	dc.b	80,97,108,109,46,83,114,109,83,108,101,101,112,0
#endif

;; native-method palmos/Palm.SrmWake()I
	link	a6,#0
	mem.release
	moveq.l	#sysSerialWake,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SrmWake
	dc.b	80,97,108,109,46,83,114,109,87,97,107,101,0,0
#endif

;; native-method palmos/Palm.SrmGetDeviceCount(Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#sysSerialGetDeviceCount,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SrmGetDeviceCount
	dc.b	80,97,108,109,46,83,114,109,71,101,116,68,101,118,105,99,101,67,111,117,110,116,0,0
#endif

;; native-method palmos/Palm.SrmGetDeviceCount(Ljava/lang/Short;)I
;; uses-method palmos/Palm.SrmGetDeviceCount(Lpalmos/ShortHolder;)I as new_SrmGetDeviceCount
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmGetDeviceCount

;; native-method palmos/Palm.SrmGetStatus(ILpalmos/IntHolder;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	moveq.l	#sysSerialGetStatus,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SrmGetStatus
	dc.b	80,97,108,109,46,83,114,109,71,101,116,83,116,97,116,117,115,0
#endif

;; native-method palmos/Palm.SrmGetStatus(ILjava/lang/Integer;Ljava/lang/Short;)I
;; uses-method palmos/Palm.SrmGetStatus(ILpalmos/IntHolder;Lpalmos/ShortHolder;)I as new_SrmGetStatus
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmGetStatus

;; native-method palmos/Palm.SrmClearErr(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#sysSerialClearErr,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.SrmClearErr
	dc.b	80,97,108,109,46,83,114,109,67,108,101,97,114,69,114,114,0,0
#endif

;; native-method palmos/Palm.SrmControl(IIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	moveq.l	#sysSerialControl,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SrmControl
	dc.b	80,97,108,109,46,83,114,109,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.SrmControl(IIILjava/lang/Short;)I
;; uses-method palmos/Palm.SrmControl(IIILpalmos/ShortHolder;)I as new_SrmControl
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmControl

;; native-method palmos/Palm.SrmControl(IILpalmos/IntHolder;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	moveq.l	#sysSerialControl,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SrmControl
	dc.b	80,97,108,109,46,83,114,109,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.SrmControl(IILjava/lang/Integer;Ljava/lang/Short;)I
;; uses-method palmos/Palm.SrmControl(IILpalmos/IntHolder;Lpalmos/ShortHolder;)I as new_SrmControl
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmControl

;; native-method palmos/Palm.SrmControl(II[BILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	moveq.l	#sysSerialControl,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SrmControl
	dc.b	80,97,108,109,46,83,114,109,67,111,110,116,114,111,108,0
#endif

;; native-method palmos/Palm.SrmControl(II[BILjava/lang/Short;)I
;; uses-method palmos/Palm.SrmControl(II[BILpalmos/ShortHolder;)I as new_SrmControl
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmControl

;; native-method palmos/Palm.SrmSend(IIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSend,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SrmSend
	dc.b	80,97,108,109,46,83,114,109,83,101,110,100,0,0
#endif

;; native-method palmos/Palm.SrmSend(I[BIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSend,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.SrmSend
	dc.b	80,97,108,109,46,83,114,109,83,101,110,100,0,0
#endif

;; native-method palmos/Palm.SrmSendWait(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSendWait,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.SrmSendWait
	dc.b	80,97,108,109,46,83,114,109,83,101,110,100,87,97,105,116,0,0
#endif

;; native-method palmos/Palm.SrmSendCheck(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSendCheck,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SrmSendCheck
	dc.b	80,97,108,109,46,83,114,109,83,101,110,100,67,104,101,99,107,0
#endif

;; native-method palmos/Palm.SrmSendCheck(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.SrmSendCheck(ILpalmos/IntHolder;)I as new_SrmSendCheck
;; needs-exact-layout java/lang/Integer
	bra.far	new_SrmSendCheck

;; native-method palmos/Palm.SrmSendFlush(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSendFlush,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SrmSendFlush
	dc.b	80,97,108,109,46,83,114,109,83,101,110,100,70,108,117,115,104,0
#endif

;; native-method palmos/Palm.SrmReceive(IIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	20(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	moveq.l	#sysSerialReceive,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SrmReceive
	dc.b	80,97,108,109,46,83,114,109,82,101,99,101,105,118,101,0
#endif

;; native-method palmos/Palm.SrmReceive(I[BIIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	30(a6),-(a7)
	mem.release
	moveq.l	#sysSerialReceive,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SrmReceive
	dc.b	80,97,108,109,46,83,114,109,82,101,99,101,105,118,101,0
#endif

;; native-method palmos/Palm.SrmReceiveWait(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	moveq.l	#sysSerialReceiveWait,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SrmReceiveWait
	dc.b	80,97,108,109,46,83,114,109,82,101,99,101,105,118,101,87,97,105,116,0
#endif

;; native-method palmos/Palm.SrmReceiveCheck(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#sysSerialReceiveCheck,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SrmReceiveCheck
	dc.b	80,97,108,109,46,83,114,109,82,101,99,101,105,118,101,67,104,101,99,107,0,0
#endif

;; native-method palmos/Palm.SrmReceiveCheck(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.SrmReceiveCheck(ILpalmos/IntHolder;)I as new_SrmReceiveCheck
;; needs-exact-layout java/lang/Integer
	bra.far	new_SrmReceiveCheck

;; native-method palmos/Palm.SrmReceiveFlush(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#sysSerialReceiveFlush,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.SrmReceiveFlush
	dc.b	80,97,108,109,46,83,114,109,82,101,99,101,105,118,101,70,108,117,115,104,0,0
#endif

;; native-method palmos/Palm.SrmSetReceiveBuffer(I[BII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSetRcvBuffer,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SrmSetReceiveBuffer
	dc.b	80,97,108,109,46,83,114,109,83,101,116,82,101,99,101,105,118,101,66,117,102,102,101,114,0,0
#endif

;; native-method palmos/Palm.SrmSetReceiveBuffer(ILjava/lang/Object;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSetRcvBuffer,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-6(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SrmSetReceiveBuffer
	dc.b	80,97,108,109,46,83,114,109,83,101,116,82,101,99,101,105,118,101,66,117,102,102,101,114,0,0
#endif

;; native-method palmos/Palm.SrmReceiveWindowClose(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#sysSerialRcvWindowClose,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.SrmReceiveWindowClose
	dc.b	80,97,108,109,46,83,114,109,82,101,99,101,105,118,101,87,105,110,100,111,119,67,108,111,115,101,0,0
#endif

;; native-method palmos/Palm.SrmOpenBackground(IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	moveq.l	#sysSerialOpenBkgnd,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SrmOpenBackground
	dc.b	80,97,108,109,46,83,114,109,79,112,101,110,66,97,99,107,103,114,111,117,110,100,0,0
#endif

;; native-method palmos/Palm.SrmOpenBackground(IILjava/lang/Short;)I
;; uses-method palmos/Palm.SrmOpenBackground(IILpalmos/ShortHolder;)I as new_SrmOpenBackground
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmOpenBackground

;; native-method palmos/Palm.SrmExtOpen(ILpalmos/SrmOpenConfig;ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/SrmOpenConfig
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	mem.release
	moveq.l	#sysSerialOpenV4,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SrmExtOpen
	dc.b	80,97,108,109,46,83,114,109,69,120,116,79,112,101,110,0
#endif

;; native-method palmos/Palm.SrmExtOpen(ILpalmos/SrmOpenConfig;ILjava/lang/Short;)I
;; uses-method palmos/Palm.SrmExtOpen(ILpalmos/SrmOpenConfig;ILpalmos/ShortHolder;)I as new_SrmExtOpen
;; needs-exact-layout palmos/SrmOpenConfig
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmExtOpen

;; native-method palmos/Palm.SrmExtOpenBackground(ILpalmos/SrmOpenConfig;ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/SrmOpenConfig
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	mem.release
	moveq.l	#sysSerialOpenBkgndV4,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-10(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.SrmExtOpenBackground
	dc.b	80,97,108,109,46,83,114,109,69,120,116,79,112,101,110,66,97,99,107,103,114,111,117,110,100,0
#endif

;; native-method palmos/Palm.SrmExtOpenBackground(ILpalmos/SrmOpenConfig;ILjava/lang/Short;)I
;; uses-method palmos/Palm.SrmExtOpenBackground(ILpalmos/SrmOpenConfig;ILpalmos/ShortHolder;)I as new_SrmExtOpenBackground
;; needs-exact-layout palmos/SrmOpenConfig
;; needs-exact-layout java/lang/Short
	bra.far	new_SrmExtOpenBackground

;; native-method palmos/Palm.SrmSetWakeupHandler(ILpalmos/WakeupHandler;I)I
;; needs-exact-layout palmos/WakeupHandler
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	moveq.l	#sysSerialSetWakeupHandler,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.SrmSetWakeupHandler
	dc.b	80,97,108,109,46,83,114,109,83,101,116,87,97,107,101,117,112,72,97,110,100,108,101,114,0,0
#endif

;; native-method palmos/Palm.SrmPrimeWakeupHandler(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#sysSerialPrimeWakeupHandler,d2
	trap	#15
	dc.w	sysTrapSerialDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.SrmPrimeWakeupHandler
	dc.b	80,97,108,109,46,83,114,109,80,114,105,109,101,87,97,107,101,117,112,72,97,110,100,108,101,114,0,0
#endif

;; native-method palmos/Palm.StrAToI(Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapStrAToI
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.StrAToI
	dc.b	80,97,108,109,46,83,116,114,65,84,111,73,0,0
#endif

;; native-method palmos/Palm.StrCaselessCompare(Ljava/lang/String;Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapStrCaselessCompare
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.StrCaselessCompare
	dc.b	80,97,108,109,46,83,116,114,67,97,115,101,108,101,115,115,67,111,109,112,97,114,101,0
#endif

;; native-method palmos/Palm.StrCompare(Ljava/lang/String;Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapStrCompare
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.StrCompare
	dc.b	80,97,108,109,46,83,116,114,67,111,109,112,97,114,101,0
#endif

;; native-method palmos/Palm.StrLen(Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapStrLen
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,11	; Debug Symbol Palm.StrLen
	dc.b	80,97,108,109,46,83,116,114,76,101,110,0
#endif

;; native-method palmos/Palm.SysAppLaunch(IIIILjava/lang/Object;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysAppLaunch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SysAppLaunch
	dc.b	80,97,108,109,46,83,121,115,65,112,112,76,97,117,110,99,104,0
#endif

;; native-method palmos/Palm.SysAppLaunch(IIIILjava/lang/Object;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.SysAppLaunch(IIIILjava/lang/Object;Lpalmos/IntHolder;)I as new_SysAppLaunch
;; needs-exact-layout java/lang/Integer
	bra.far	new_SysAppLaunch

;; native-method palmos/Palm.SysAppLaunch(IIIIILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysAppLaunch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SysAppLaunch
	dc.b	80,97,108,109,46,83,121,115,65,112,112,76,97,117,110,99,104,0
#endif

;; native-method palmos/Palm.SysAppLaunch(IIIIILjava/lang/Integer;)I
;; uses-method palmos/Palm.SysAppLaunch(IIIIILpalmos/IntHolder;)I as new_SysAppLaunch
;; needs-exact-layout java/lang/Integer
	bra.far	new_SysAppLaunch

;; native-method palmos/Palm.SysFatalAlert(Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysFatalAlert
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.SysFatalAlert
	dc.b	80,97,108,109,46,83,121,115,70,97,116,97,108,65,108,101,114,116,0,0
#endif

;; native-method palmos/Palm.SysBatteryInfo(ZLpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	31(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysBatteryInfo
	mem.reserve.savereg
	and.l	#$ffff,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SysBatteryInfo
	dc.b	80,97,108,109,46,83,121,115,66,97,116,116,101,114,121,73,110,102,111,0
#endif

;; native-method palmos/Palm.SysBatteryInfo(ZLjava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)I
;; uses-method palmos/Palm.SysBatteryInfo(ZLpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)I as new_SysBatteryInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_SysBatteryInfo

;; native-method palmos/Palm.SysBroadcastActionCode(ILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysBroadcastActionCode
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.SysBroadcastActionCode
	dc.b	80,97,108,109,46,83,121,115,66,114,111,97,100,99,97,115,116,65,99,116,105,111,110,67,111,100,101,0
#endif

;; native-method palmos/Palm.SysCopyStringResource(Ljava/lang/StringBuffer;I)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysCopyStringResource
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	move.l	12(a6),a1
	bsr.far	StringBuffer_setLength
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.SysCopyStringResource
	dc.b	80,97,108,109,46,83,121,115,67,111,112,121,83,116,114,105,110,103,82,101,115,111,117,114,99,101,0,0
#endif

;; native-method palmos/Palm.SysCurAppDatabase(Lpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSysCurAppDatabase
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SysCurAppDatabase
	dc.b	80,97,108,109,46,83,121,115,67,117,114,65,112,112,68,97,116,97,98,97,115,101,0,0
#endif

;; native-method palmos/Palm.SysCurAppDatabase(Ljava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.SysCurAppDatabase(Lpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_SysCurAppDatabase
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_SysCurAppDatabase

;; native-method palmos/Palm.SysFormPointerArrayToStrings(Ljava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysFormPointerArrayToStrings
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,33	; Debug Symbol Palm.SysFormPointerArrayToStrings
	dc.b	80,97,108,109,46,83,121,115,70,111,114,109,80,111,105,110,116,101,114,65,114,114,97,121,84,111,83,116,114,105,110,103,115,0
#endif

;; native-method palmos/Palm.SysHandleEvent(Lpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSysHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SysHandleEvent
	dc.b	80,97,108,109,46,83,121,115,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.SysKeyboardDialog()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapSysKeyboardDialogV10
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SysKeyboardDialog
	dc.b	80,97,108,109,46,83,121,115,75,101,121,98,111,97,114,100,68,105,97,108,111,103,0,0
#endif

;; native-method palmos/Palm.SysLibFind(Ljava/lang/String;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysLibFind
	mem.reserve.savereg
	and.l	#$ffff,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SysLibFind
	dc.b	80,97,108,109,46,83,121,115,76,105,98,70,105,110,100,0
#endif

;; native-method palmos/Palm.SysLibFind(Ljava/lang/String;Ljava/lang/Short;)I
;; uses-method palmos/Palm.SysLibFind(Ljava/lang/String;Lpalmos/ShortHolder;)I as new_SysLibFind
;; needs-exact-layout java/lang/Short
	bra.far	new_SysLibFind

;; native-method palmos/Palm.SysRandom(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysRandom
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.SysRandom
	dc.b	80,97,108,109,46,83,121,115,82,97,110,100,111,109,0,0
#endif

;; native-method palmos/Palm.SysReset()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapSysReset
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.SysReset
	dc.b	80,97,108,109,46,83,121,115,82,101,115,101,116,0
#endif

;; native-method palmos/Palm.SysSetAutoOffTime(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysSetAutoOffTime
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SysSetAutoOffTime
	dc.b	80,97,108,109,46,83,121,115,83,101,116,65,117,116,111,79,102,102,84,105,109,101,0,0
#endif

;; native-method palmos/Palm.SysTaskDelay(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysTaskDelay
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SysTaskDelay
	dc.b	80,97,108,109,46,83,121,115,84,97,115,107,68,101,108,97,121,0
#endif

;; native-method palmos/Palm.SysUIAppSwitch(IIILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysUIAppSwitch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SysUIAppSwitch
	dc.b	80,97,108,109,46,83,121,115,85,73,65,112,112,83,119,105,116,99,104,0
#endif

;; native-method palmos/Palm.SysUIAppSwitch(IIII)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysUIAppSwitch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SysUIAppSwitch
	dc.b	80,97,108,109,46,83,121,115,85,73,65,112,112,83,119,105,116,99,104,0
#endif

;; native-method palmos/Palm.SysLibRemove(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysLibRemove
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.SysLibRemove
	dc.b	80,97,108,109,46,83,121,115,76,105,98,82,101,109,111,118,101,0
#endif

;; native-method palmos/Palm.SysLibLoad(IILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysLibLoad
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SysLibLoad
	dc.b	80,97,108,109,46,83,121,115,76,105,98,76,111,97,100,0
#endif

;; native-method palmos/Palm.SysLibLoad(IILjava/lang/Short;)I
;; uses-method palmos/Palm.SysLibLoad(IILpalmos/ShortHolder;)I as new_SysLibLoad
;; needs-exact-layout java/lang/Short
	bra.far	new_SysLibLoad

;; native-method palmos/Palm.SysTicksPerSecond()I
	link	a6,#0
	trap	#15
	dc.w	sysTrapSysTicksPerSecond
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SysTicksPerSecond
	dc.b	80,97,108,109,46,83,121,115,84,105,99,107,115,80,101,114,83,101,99,111,110,100,0,0
#endif

;; native-method palmos/Palm.SysKeyboardDialog(I)V
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysKeyboardDialog
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SysKeyboardDialog
	dc.b	80,97,108,109,46,83,121,115,75,101,121,98,111,97,114,100,68,105,97,108,111,103,0,0
#endif

;; native-method palmos/Palm.SysGetTrapAddress(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSysGetTrapAddress
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.SysGetTrapAddress
	dc.b	80,97,108,109,46,83,121,115,71,101,116,84,114,97,112,65,100,100,114,101,115,115,0,0
#endif

;; native-method palmos/Palm.SysGetOSVersionString()Ljava/lang/String;
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapSysGetOSVersionString
	mem.reserve.savereg
	bsr.far	CharPtr_to_String
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.SysGetOSVersionString
	dc.b	80,97,108,109,46,83,121,115,71,101,116,79,83,86,101,114,115,105,111,110,83,116,114,105,110,103,0,0
#endif

;; native-method palmos/Palm.SysGetROMToken(IILpalmos/IntHolder;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapHwrGetROMToken
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.SysGetROMToken
	dc.b	80,97,108,109,46,83,121,115,71,101,116,82,79,77,84,111,107,101,110,0
#endif

;; native-method palmos/Palm.SysGetROMToken(IILjava/lang/Integer;Ljava/lang/Short;)I
;; uses-method palmos/Palm.SysGetROMToken(IILpalmos/IntHolder;Lpalmos/ShortHolder;)I as new_SysGetROMToken
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Short
	bra.far	new_SysGetROMToken

;; native-method palmos/Palm.SysLibOpen(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapOpen
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SysLibOpen
	dc.b	80,97,108,109,46,83,121,115,76,105,98,79,112,101,110,0
#endif

;; native-method palmos/Palm.SysLibClose(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapClose
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.SysLibClose
	dc.b	80,97,108,109,46,83,121,115,76,105,98,67,108,111,115,101,0,0
#endif

;; native-method palmos/Palm.SysLibSleep(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapSleep
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.SysLibSleep
	dc.b	80,97,108,109,46,83,121,115,76,105,98,83,108,101,101,112,0,0
#endif

;; native-method palmos/Palm.SysLibWake(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapWake
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SysLibWake
	dc.b	80,97,108,109,46,83,121,115,76,105,98,87,97,107,101,0
#endif

;; native-method palmos/Palm.TblDrawTable(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblDrawTable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblDrawTable
	dc.b	80,97,108,109,46,84,98,108,68,114,97,119,84,97,98,108,101,0
#endif

;; native-method palmos/Palm.TblEditing(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblEditing
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.TblEditing
	dc.b	80,97,108,109,46,84,98,108,69,100,105,116,105,110,103,0
#endif

;; native-method palmos/Palm.TblEraseTable(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblEraseTable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblEraseTable
	dc.b	80,97,108,109,46,84,98,108,69,114,97,115,101,84,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.TblFindRowData(IILpalmos/ShortHolder;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblFindRowData
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.TblFindRowData
	dc.b	80,97,108,109,46,84,98,108,70,105,110,100,82,111,119,68,97,116,97,0
#endif

;; native-method palmos/Palm.TblFindRowData(IILjava/lang/Short;)Z
;; uses-method palmos/Palm.TblFindRowData(IILpalmos/ShortHolder;)Z as new_TblFindRowData
;; needs-exact-layout java/lang/Short
	bra.far	new_TblFindRowData

;; native-method palmos/Palm.TblFindRowID(IILpalmos/ShortHolder;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblFindRowID
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblFindRowID
	dc.b	80,97,108,109,46,84,98,108,70,105,110,100,82,111,119,73,68,0
#endif

;; native-method palmos/Palm.TblFindRowID(IILjava/lang/Short;)Z
;; uses-method palmos/Palm.TblFindRowID(IILpalmos/ShortHolder;)Z as new_TblFindRowID
;; needs-exact-layout java/lang/Short
	bra.far	new_TblFindRowID

;; native-method palmos/Palm.TblGetBounds(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblGetBounds
	dc.b	80,97,108,109,46,84,98,108,71,101,116,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.TblGetColumnSpacing(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetColumnSpacing
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.TblGetColumnSpacing
	dc.b	80,97,108,109,46,84,98,108,71,101,116,67,111,108,117,109,110,83,112,97,99,105,110,103,0,0
#endif

;; native-method palmos/Palm.TblGetColumnWidth(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetColumnWidth
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.TblGetColumnWidth
	dc.b	80,97,108,109,46,84,98,108,71,101,116,67,111,108,117,109,110,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.TblGetCurrentField(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetCurrentField
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.TblGetCurrentField
	dc.b	80,97,108,109,46,84,98,108,71,101,116,67,117,114,114,101,110,116,70,105,101,108,100,0
#endif

;; native-method palmos/Palm.TblGetItemBounds(IIILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetItemBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.TblGetItemBounds
	dc.b	80,97,108,109,46,84,98,108,71,101,116,73,116,101,109,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.TblGetItemInt(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetItemInt
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblGetItemInt
	dc.b	80,97,108,109,46,84,98,108,71,101,116,73,116,101,109,73,110,116,0,0
#endif

;; native-method palmos/Palm.TblGetLastUsableRow(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetLastUsableRow
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.TblGetLastUsableRow
	dc.b	80,97,108,109,46,84,98,108,71,101,116,76,97,115,116,85,115,97,98,108,101,82,111,119,0,0
#endif

;; native-method palmos/Palm.TblGetNumberOfRows(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetNumberOfRows
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.TblGetNumberOfRows
	dc.b	80,97,108,109,46,84,98,108,71,101,116,78,117,109,98,101,114,79,102,82,111,119,115,0
#endif

;; native-method palmos/Palm.TblGetRowData(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetRowData
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblGetRowData
	dc.b	80,97,108,109,46,84,98,108,71,101,116,82,111,119,68,97,116,97,0,0
#endif

;; native-method palmos/Palm.TblGetRowHeight(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetRowHeight
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblGetRowHeight
	dc.b	80,97,108,109,46,84,98,108,71,101,116,82,111,119,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Palm.TblGetRowID(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetRowID
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.TblGetRowID
	dc.b	80,97,108,109,46,84,98,108,71,101,116,82,111,119,73,68,0,0
#endif

;; native-method palmos/Palm.TblGetSelection(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetSelection
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblGetSelection
	dc.b	80,97,108,109,46,84,98,108,71,101,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.TblGetSelection(ILjava/lang/Short;Ljava/lang/Short;)Z
;; uses-method palmos/Palm.TblGetSelection(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)Z as new_TblGetSelection
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_TblGetSelection

;; native-method palmos/Palm.TblGrabFocus(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGrabFocus
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblGrabFocus
	dc.b	80,97,108,109,46,84,98,108,71,114,97,98,70,111,99,117,115,0
#endif

;; native-method palmos/Palm.TblHandleEvent(ILpalmos/Event;)Z
;; needs-exact-layout palmos/Event
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblHandleEvent
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.TblHandleEvent
	dc.b	80,97,108,109,46,84,98,108,72,97,110,100,108,101,69,118,101,110,116,0
#endif

;; native-method palmos/Palm.TblInsertRow(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblInsertRow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblInsertRow
	dc.b	80,97,108,109,46,84,98,108,73,110,115,101,114,116,82,111,119,0
#endif

;; native-method palmos/Palm.TblMarkRowInvalid(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblMarkRowInvalid
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.TblMarkRowInvalid
	dc.b	80,97,108,109,46,84,98,108,77,97,114,107,82,111,119,73,110,118,97,108,105,100,0,0
#endif

;; native-method palmos/Palm.TblMarkTableInvalid(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblMarkTableInvalid
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.TblMarkTableInvalid
	dc.b	80,97,108,109,46,84,98,108,77,97,114,107,84,97,98,108,101,73,110,118,97,108,105,100,0,0
#endif

;; native-method palmos/Palm.TblRedrawTable(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblRedrawTable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.TblRedrawTable
	dc.b	80,97,108,109,46,84,98,108,82,101,100,114,97,119,84,97,98,108,101,0
#endif

;; native-method palmos/Palm.TblReleaseFocus(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblReleaseFocus
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblReleaseFocus
	dc.b	80,97,108,109,46,84,98,108,82,101,108,101,97,115,101,70,111,99,117,115,0,0
#endif

;; native-method palmos/Palm.TblRemoveRow(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblRemoveRow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblRemoveRow
	dc.b	80,97,108,109,46,84,98,108,82,101,109,111,118,101,82,111,119,0
#endif

;; native-method palmos/Palm.TblRowInvalid(II)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblRowInvalid
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblRowInvalid
	dc.b	80,97,108,109,46,84,98,108,82,111,119,73,110,118,97,108,105,100,0,0
#endif

;; native-method palmos/Palm.TblRowSelectable(II)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblRowSelectable
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.TblRowSelectable
	dc.b	80,97,108,109,46,84,98,108,82,111,119,83,101,108,101,99,116,97,98,108,101,0
#endif

;; native-method palmos/Palm.TblRowUsable(II)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblRowUsable
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblRowUsable
	dc.b	80,97,108,109,46,84,98,108,82,111,119,85,115,97,98,108,101,0
#endif

;; native-method palmos/Palm.TblSelectItem(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSelectItem
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblSelectItem
	dc.b	80,97,108,109,46,84,98,108,83,101,108,101,99,116,73,116,101,109,0,0
#endif

;; native-method palmos/Palm.TblSetColumnSpacing(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetColumnSpacing
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.TblSetColumnSpacing
	dc.b	80,97,108,109,46,84,98,108,83,101,116,67,111,108,117,109,110,83,112,97,99,105,110,103,0,0
#endif

;; native-method palmos/Palm.TblSetColumnUsable(IIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetColumnUsable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.TblSetColumnUsable
	dc.b	80,97,108,109,46,84,98,108,83,101,116,67,111,108,117,109,110,85,115,97,98,108,101,0
#endif

;; native-method palmos/Palm.TblSetColumnWidth(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetColumnWidth
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.TblSetColumnWidth
	dc.b	80,97,108,109,46,84,98,108,83,101,116,67,111,108,117,109,110,87,105,100,116,104,0,0
#endif

;; native-method palmos/Palm.TblSetCustomDrawProcedure(IILpalmos/TableDrawItemHandler;)V
;; needs-exact-layout palmos/TableDrawItemHandler
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetCustomDrawProcedure
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,30	; Debug Symbol Palm.TblSetCustomDrawProcedure
	dc.b	80,97,108,109,46,84,98,108,83,101,116,67,117,115,116,111,109,68,114,97,119,80,114,111,99,101,100,117,114,101,0,0
#endif

;; native-method palmos/Palm.TblSetItemInt(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetItemInt
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblSetItemInt
	dc.b	80,97,108,109,46,84,98,108,83,101,116,73,116,101,109,73,110,116,0,0
#endif

;; native-method palmos/Palm.TblSetItemPtr(IIILjava/lang/Object;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetItemPtr
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblSetItemPtr
	dc.b	80,97,108,109,46,84,98,108,83,101,116,73,116,101,109,80,116,114,0,0
#endif

;; native-method palmos/Palm.TblSetItemPtr(IIII)V
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetItemPtr
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblSetItemPtr
	dc.b	80,97,108,109,46,84,98,108,83,101,116,73,116,101,109,80,116,114,0,0
#endif

;; native-method palmos/Palm.TblSetItemStyle(IIII)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetItemStyle
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblSetItemStyle
	dc.b	80,97,108,109,46,84,98,108,83,101,116,73,116,101,109,83,116,121,108,101,0,0
#endif

;; native-method palmos/Palm.TblSetLoadDataProcedure(IILpalmos/TableLoadDataHandler;)V
;; needs-exact-layout palmos/TableLoadDataHandler
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetLoadDataProcedure
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.TblSetLoadDataProcedure
	dc.b	80,97,108,109,46,84,98,108,83,101,116,76,111,97,100,68,97,116,97,80,114,111,99,101,100,117,114,101,0,0
#endif

;; native-method palmos/Palm.TblSetRowData(III)V
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowData
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TblSetRowData
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,68,97,116,97,0,0
#endif

;; native-method palmos/Palm.TblSetRowHeight(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowHeight
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblSetRowHeight
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Palm.TblSetRowID(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowID
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.TblSetRowID
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,73,68,0,0
#endif

;; native-method palmos/Palm.TblSetRowSelectable(IIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowSelectable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.TblSetRowSelectable
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,83,101,108,101,99,116,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.TblSetRowUsable(IIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowUsable
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblSetRowUsable
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,85,115,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.TblSetSaveDataProcedure(IILpalmos/TableSaveDataHandler;)V
;; needs-exact-layout palmos/TableSaveDataHandler
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetSaveDataProcedure
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.TblSetSaveDataProcedure
	dc.b	80,97,108,109,46,84,98,108,83,101,116,83,97,118,101,68,97,116,97,80,114,111,99,101,100,117,114,101,0,0
#endif

;; native-method palmos/Palm.TblUnhighlightSelection(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblUnhighlightSelection
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.TblUnhighlightSelection
	dc.b	80,97,108,109,46,84,98,108,85,110,104,105,103,104,108,105,103,104,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.TblSetRowStaticHeight(IIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowStaticHeight
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.TblSetRowStaticHeight
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,83,116,97,116,105,99,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Palm.TblSetItemFont(IIII)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetItemFont
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.TblSetItemFont
	dc.b	80,97,108,109,46,84,98,108,83,101,116,73,116,101,109,70,111,110,116,0
#endif

;; native-method palmos/Palm.TblSetColumnMasked(IIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetColumnMasked
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.TblSetColumnMasked
	dc.b	80,97,108,109,46,84,98,108,83,101,116,67,111,108,117,109,110,77,97,115,107,101,100,0
#endif

;; native-method palmos/Palm.TblSetRowMasked(IIZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetRowMasked
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblSetRowMasked
	dc.b	80,97,108,109,46,84,98,108,83,101,116,82,111,119,77,97,115,107,101,100,0,0
#endif

;; native-method palmos/Palm.TblRowMasked(II)Z
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblRowMasked
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblRowMasked
	dc.b	80,97,108,109,46,84,98,108,82,111,119,77,97,115,107,101,100,0
#endif

;; native-method palmos/Palm.TblGetNumberOfColumns(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetNumberOfColumns
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.TblGetNumberOfColumns
	dc.b	80,97,108,109,46,84,98,108,71,101,116,78,117,109,98,101,114,79,102,67,111,108,117,109,110,115,0,0
#endif

;; native-method palmos/Palm.TblGetTopRow(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblGetTopRow
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.TblGetTopRow
	dc.b	80,97,108,109,46,84,98,108,71,101,116,84,111,112,82,111,119,0
#endif

;; native-method palmos/Palm.TblSetSelection(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTblSetSelection
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.TblSetSelection
	dc.b	80,97,108,109,46,84,98,108,83,101,116,83,101,108,101,99,116,105,111,110,0,0
#endif

;; native-method palmos/Palm.DateAdjust(Lpalmos/Date;I)V
;; needs-exact-layout palmos/Date
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapDateAdjust
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.DateAdjust
	dc.b	80,97,108,109,46,68,97,116,101,65,100,106,117,115,116,0
#endif

;; native-method palmos/Palm.DateDaysToDate(ILpalmos/Date;)V
;; needs-exact-layout palmos/Date
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDateDaysToDate
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.DateDaysToDate
	dc.b	80,97,108,109,46,68,97,116,101,68,97,121,115,84,111,68,97,116,101,0
#endif

;; native-method palmos/Palm.DateSecondsToDate(ILpalmos/Date;)V
;; needs-exact-layout palmos/Date
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDateSecondsToDate
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.DateSecondsToDate
	dc.b	80,97,108,109,46,68,97,116,101,83,101,99,111,110,100,115,84,111,68,97,116,101,0,0
#endif

;; native-method palmos/Palm.DateToAscii(IIIILjava/lang/StringBuffer;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.b	15(a6),-(a7)
	move.w	18(a6),-(a7)
	move.b	23(a6),-(a7)
	move.b	27(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDateToAscii
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	8(a6),a1
	bsr.far	StringBuffer_setLength
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.DateToAscii
	dc.b	80,97,108,109,46,68,97,116,101,84,111,65,115,99,105,105,0,0
#endif

;; native-method palmos/Palm.DateToDays(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDateToDays
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.DateToDays
	dc.b	80,97,108,109,46,68,97,116,101,84,111,68,97,121,115,0
#endif

;; native-method palmos/Palm.DateToDOWDMFormat(IIIILjava/lang/StringBuffer;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.b	15(a6),-(a7)
	move.w	18(a6),-(a7)
	move.b	23(a6),-(a7)
	move.b	27(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDateToDOWDMFormat
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	8(a6),a1
	bsr.far	StringBuffer_setLength
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.DateToDOWDMFormat
	dc.b	80,97,108,109,46,68,97,116,101,84,111,68,79,87,68,77,70,111,114,109,97,116,0,0
#endif

;; native-method palmos/Palm.DayOfMonth(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDayOfMonth
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.DayOfMonth
	dc.b	80,97,108,109,46,68,97,121,79,102,77,111,110,116,104,0
#endif

;; native-method palmos/Palm.DayOfWeek(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDayOfWeek
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.DayOfWeek
	dc.b	80,97,108,109,46,68,97,121,79,102,87,101,101,107,0,0
#endif

;; native-method palmos/Palm.DaysInMonth(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDaysInMonth
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.DaysInMonth
	dc.b	80,97,108,109,46,68,97,121,115,73,110,77,111,110,116,104,0,0
#endif

;; native-method palmos/Palm.SelectDay(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/String;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSelectDayV10
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.SelectDay
	dc.b	80,97,108,109,46,83,101,108,101,99,116,68,97,121,0,0
#endif

;; native-method palmos/Palm.SelectDay(Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/String;)Z
;; uses-method palmos/Palm.SelectDay(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/String;)Z as new_SelectDay
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_SelectDay

;; native-method palmos/Palm.DayDrawDaySelector(Lpalmos/DaySelector;)V
;; needs-exact-layout palmos/DaySelector
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapDayDrawDaySelector
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.DayDrawDaySelector
	dc.b	80,97,108,109,46,68,97,121,68,114,97,119,68,97,121,83,101,108,101,99,116,111,114,0
#endif

;; native-method palmos/Palm.TimAdjust(Lpalmos/DateTime;I)V
;; needs-exact-layout palmos/DateTime
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapTimAdjust
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.TimAdjust
	dc.b	80,97,108,109,46,84,105,109,65,100,106,117,115,116,0,0
#endif

;; native-method palmos/Palm.TimDateTimeToSeconds(Lpalmos/DateTime;)I
;; needs-exact-layout palmos/DateTime
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapTimDateTimeToSeconds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.TimDateTimeToSeconds
	dc.b	80,97,108,109,46,84,105,109,68,97,116,101,84,105,109,101,84,111,83,101,99,111,110,100,115,0
#endif

;; native-method palmos/Palm.TimGetSeconds()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapTimGetSeconds
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TimGetSeconds
	dc.b	80,97,108,109,46,84,105,109,71,101,116,83,101,99,111,110,100,115,0,0
#endif

;; native-method palmos/Palm.TimGetTicks()I
	link	a6,#0
	trap	#15
	dc.w	sysTrapTimGetTicks
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.TimGetTicks
	dc.b	80,97,108,109,46,84,105,109,71,101,116,84,105,99,107,115,0,0
#endif

;; native-method palmos/Palm.TimSecondsToDateTime(ILpalmos/DateTime;)V
;; needs-exact-layout palmos/DateTime
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTimSecondsToDateTime
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.TimSecondsToDateTime
	dc.b	80,97,108,109,46,84,105,109,83,101,99,111,110,100,115,84,111,68,97,116,101,84,105,109,101,0
#endif

;; native-method palmos/Palm.TimSetSeconds(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTimSetSeconds
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.TimSetSeconds
	dc.b	80,97,108,109,46,84,105,109,83,101,116,83,101,99,111,110,100,115,0,0
#endif

;; native-method palmos/Palm.TimeToAscii(IIILjava/lang/StringBuffer;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.b	15(a6),-(a7)
	move.b	19(a6),-(a7)
	move.b	23(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapTimeToAscii
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	move.l	8(a6),a1
	bsr.far	StringBuffer_setLength
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.TimeToAscii
	dc.b	80,97,108,109,46,84,105,109,101,84,111,65,115,99,105,105,0,0
#endif

;; native-method palmos/Palm.SelectDay(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/String;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapSelectDay
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Palm.SelectDay
	dc.b	80,97,108,109,46,83,101,108,101,99,116,68,97,121,0,0
#endif

;; native-method palmos/Palm.SelectDay(ILjava/lang/Short;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/String;)Z
;; uses-method palmos/Palm.SelectDay(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/String;)Z as new_SelectDay
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_SelectDay

;; native-method palmos/Palm.SelectOneTime(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/String;)Z
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSelectOneTime
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.SelectOneTime
	dc.b	80,97,108,109,46,83,101,108,101,99,116,79,110,101,84,105,109,101,0,0
#endif

;; native-method palmos/Palm.SelectOneTime(Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/String;)Z
;; uses-method palmos/Palm.SelectOneTime(Lpalmos/ShortHolder;Lpalmos/ShortHolder;Ljava/lang/String;)Z as new_SelectOneTime
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_SelectOneTime

;; native-method palmos/Palm.SelectTime(Lpalmos/Time;Lpalmos/Time;ZLjava/lang/String;I)Z
;; needs-exact-layout palmos/Time
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.b	19(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSelectTimeV33
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SelectTime
	dc.b	80,97,108,109,46,83,101,108,101,99,116,84,105,109,101,0
#endif

;; native-method palmos/Palm.SelectTime(Lpalmos/Time;Lpalmos/Time;ZLjava/lang/String;III)Z
;; needs-exact-layout palmos/Time
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.b	27(a6),-(a7)
	move.l	28(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	32(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapSelectTime
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-20(a6),a0
	proxy.release
	move.l	-16(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.SelectTime
	dc.b	80,97,108,109,46,83,101,108,101,99,116,84,105,109,101,0
#endif

;; native-method palmos/Palm.VFSInit()I
	link	a6,#0
	mem.release
	moveq.l	#vfsTrapInit,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12	; Debug Symbol Palm.VFSInit
	dc.b	80,97,108,109,46,86,70,83,73,110,105,116,0,0
#endif

;; native-method palmos/Palm.VFSFileCreate(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileCreate,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.VFSFileCreate
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,67,114,101,97,116,101,0,0
#endif

;; native-method palmos/Palm.VFSFileOpen(ILjava/lang/String;ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	22(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileOpen,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.VFSFileOpen
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,79,112,101,110,0,0
#endif

;; native-method palmos/Palm.VFSFileOpen(ILjava/lang/String;ILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileOpen(ILjava/lang/String;ILpalmos/IntHolder;)I as new_VFSFileOpen
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileOpen

;; native-method palmos/Palm.VFSFileClose(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileClose,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.VFSFileClose
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,67,108,111,115,101,0
#endif

;; native-method palmos/Palm.VFSFileReadData(II[BIILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	16(a6),a0
	sub.l	16(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.l	24(a6),-(a7)
	move.l	28(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileReadData,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.VFSFileReadData
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,82,101,97,100,68,97,116,97,0,0
#endif

;; native-method palmos/Palm.VFSFileReadData(II[BIILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileReadData(II[BIILpalmos/IntHolder;)I as new_VFSFileReadData
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileReadData

;; native-method palmos/Palm.VFSFileRead(II[BILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	proxy.get
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileRead,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.VFSFileRead
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,82,101,97,100,0,0
#endif

;; native-method palmos/Palm.VFSFileRead(II[BILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileRead(II[BILpalmos/IntHolder;)I as new_VFSFileRead
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileRead

;; native-method palmos/Palm.VFSFileWrite(II[BILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	12(a6),a0
	sub.l	12(a6),d0
	move.l	a0,(a7)
	move.l	20(a6),-(a7)
	move.l	24(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileWrite,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.VFSFileWrite
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,87,114,105,116,101,0
#endif

;; native-method palmos/Palm.VFSFileWrite(II[BILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileWrite(II[BILpalmos/IntHolder;)I as new_VFSFileWrite
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileWrite

;; native-method palmos/Palm.VFSFileDelete(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileDelete,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.VFSFileDelete
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,68,101,108,101,116,101,0,0
#endif

;; native-method palmos/Palm.VFSFileRename(ILjava/lang/String;Ljava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileRename,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.VFSFileRename
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,82,101,110,97,109,101,0,0
#endif

;; native-method palmos/Palm.VFSFileSeek(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileSeek,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.VFSFileSeek
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,83,101,101,107,0,0
#endif

;; native-method palmos/Palm.VFSFileEOF(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileEOF,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.VFSFileEOF
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,69,79,70,0
#endif

;; native-method palmos/Palm.VFSFileTell(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileTell,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.VFSFileTell
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,84,101,108,108,0,0
#endif

;; native-method palmos/Palm.VFSFileTell(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileTell(ILpalmos/IntHolder;)I as new_VFSFileTell
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileTell

;; native-method palmos/Palm.VFSFileSize(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileSize,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.VFSFileSize
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,83,105,122,101,0,0
#endif

;; native-method palmos/Palm.VFSFileSize(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileSize(ILpalmos/IntHolder;)I as new_VFSFileSize
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileSize

;; native-method palmos/Palm.VFSFileResize(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileResize,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.VFSFileResize
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,82,101,115,105,122,101,0,0
#endif

;; native-method palmos/Palm.VFSFileGetAttributes(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileGetAttributes,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.VFSFileGetAttributes
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,71,101,116,65,116,116,114,105,98,117,116,101,115,0
#endif

;; native-method palmos/Palm.VFSFileGetAttributes(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileGetAttributes(ILpalmos/IntHolder;)I as new_VFSFileGetAttributes
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileGetAttributes

;; native-method palmos/Palm.VFSFileSetAttributes(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileSetAttributes,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.VFSFileSetAttributes
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,83,101,116,65,116,116,114,105,98,117,116,101,115,0
#endif

;; native-method palmos/Palm.VFSFileGetDate(IILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileGetDate,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.VFSFileGetDate
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,71,101,116,68,97,116,101,0
#endif

;; native-method palmos/Palm.VFSFileGetDate(IILjava/lang/Integer;)I
;; uses-method palmos/Palm.VFSFileGetDate(IILpalmos/IntHolder;)I as new_VFSFileGetDate
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSFileGetDate

;; native-method palmos/Palm.VFSFileSetDate(III)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapFileSetDate,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.VFSFileSetDate
	dc.b	80,97,108,109,46,86,70,83,70,105,108,101,83,101,116,68,97,116,101,0
#endif

;; native-method palmos/Palm.VFSDirCreate(ILjava/lang/String;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapDirCreate,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.VFSDirCreate
	dc.b	80,97,108,109,46,86,70,83,68,105,114,67,114,101,97,116,101,0
#endif

;; native-method palmos/Palm.VFSVolumeEnumerate(Lpalmos/ShortHolder;Lpalmos/IntHolder;)I
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#vfsTrapVolumeEnumerate,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.VFSVolumeEnumerate
	dc.b	80,97,108,109,46,86,70,83,86,111,108,117,109,101,69,110,117,109,101,114,97,116,101,0
#endif

;; native-method palmos/Palm.VFSVolumeEnumerate(Ljava/lang/Short;Ljava/lang/Integer;)I
;; uses-method palmos/Palm.VFSVolumeEnumerate(Lpalmos/ShortHolder;Lpalmos/IntHolder;)I as new_VFSVolumeEnumerate
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Integer
	bra.far	new_VFSVolumeEnumerate

;; native-method palmos/Palm.VFSDirEntryEnumerate(ILpalmos/IntHolder;Lpalmos/FileInfoType;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/FileInfoType
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
	mem.release
	moveq.l	#vfsTrapDirEntryEnumerate,d2
	trap	#15
	dc.w	sysTrapVFSMgr
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.VFSDirEntryEnumerate
	dc.b	80,97,108,109,46,86,70,83,68,105,114,69,110,116,114,121,69,110,117,109,101,114,97,116,101,0
#endif

;; native-method palmos/Palm.VFSDirEntryEnumerate(ILjava/lang/Integer;Lpalmos/FileInfoType;)I
;; uses-method palmos/Palm.VFSDirEntryEnumerate(ILpalmos/IntHolder;Lpalmos/FileInfoType;)I as new_VFSDirEntryEnumerate
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout palmos/FileInfoType
	bra.far	new_VFSDirEntryEnumerate

;; native-method palmos/Palm.WinAddWindow(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinAddWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinAddWindow
	dc.b	80,97,108,109,46,87,105,110,65,100,100,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinClipRectangle(Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinClipRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinClipRectangle
	dc.b	80,97,108,109,46,87,105,110,67,108,105,112,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Palm.WinCopyRectangle(IILpalmos/Rectangle;III)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	24(a6),-(a7)
	move.l	28(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinCopyRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-10(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinCopyRectangle
	dc.b	80,97,108,109,46,87,105,110,67,111,112,121,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Palm.WinCreateWindow(Lpalmos/Rectangle;IZZLpalmos/ShortHolder;)I
;; needs-exact-layout palmos/Rectangle
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	15(a6),-(a7)
	move.b	19(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinCreateWindow
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-14(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinCreateWindow
	dc.b	80,97,108,109,46,87,105,110,67,114,101,97,116,101,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinCreateWindow(Lpalmos/Rectangle;IZZLjava/lang/Short;)I
;; uses-method palmos/Palm.WinCreateWindow(Lpalmos/Rectangle;IZZLpalmos/ShortHolder;)I as new_WinCreateWindow
;; needs-exact-layout palmos/Rectangle
;; needs-exact-layout java/lang/Short
	bra.far	new_WinCreateWindow

;; native-method palmos/Palm.WinCreateOffscreenWindow(IIILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	15(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinCreateOffscreenWindow
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,29	; Debug Symbol Palm.WinCreateOffscreenWindow
	dc.b	80,97,108,109,46,87,105,110,67,114,101,97,116,101,79,102,102,115,99,114,101,101,110,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinCreateOffscreenWindow(IIILjava/lang/Short;)I
;; uses-method palmos/Palm.WinCreateOffscreenWindow(IIILpalmos/ShortHolder;)I as new_WinCreateOffscreenWindow
;; needs-exact-layout java/lang/Short
	bra.far	new_WinCreateOffscreenWindow

;; native-method palmos/Palm.WinDeleteWindow(IZ)V
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDeleteWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinDeleteWindow
	dc.b	80,97,108,109,46,87,105,110,68,101,108,101,116,101,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinDisableWindow(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDisableWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinDisableWindow
	dc.b	80,97,108,109,46,87,105,110,68,105,115,97,98,108,101,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinDisplayToWindowPt(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinDisplayToWindowPt
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.WinDisplayToWindowPt
	dc.b	80,97,108,109,46,87,105,110,68,105,115,112,108,97,121,84,111,87,105,110,100,111,119,80,116,0
#endif

;; native-method palmos/Palm.WinDisplayToWindowPt(Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.WinDisplayToWindowPt(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_WinDisplayToWindowPt
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_WinDisplayToWindowPt

;; native-method palmos/Palm.WinDrawBitmap(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawBitmap
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinDrawBitmap
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,66,105,116,109,97,112,0,0
#endif

;; native-method palmos/Palm.WinDrawChars(Ljava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinDrawChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawChars(Ljava/lang/String;IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinDrawChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawChars([CIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinDrawChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawChars([BIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinDrawChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawGrayLine(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawGrayLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinDrawGrayLine
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,71,114,97,121,76,105,110,101,0,0
#endif

;; native-method palmos/Palm.WinDrawGrayRectangleFrame(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawGrayRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,30	; Debug Symbol Palm.WinDrawGrayRectangleFrame
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,71,114,97,121,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Palm.WinDrawInvertedChars(Ljava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawInvertedChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.WinDrawInvertedChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,73,110,118,101,114,116,101,100,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawInvertedChars(Ljava/lang/String;IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawInvertedChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.WinDrawInvertedChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,73,110,118,101,114,116,101,100,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawInvertedChars([CIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawInvertedChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.WinDrawInvertedChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,73,110,118,101,114,116,101,100,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawInvertedChars([BIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinDrawInvertedChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.WinDrawInvertedChars
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,73,110,118,101,114,116,101,100,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinDrawLine(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.WinDrawLine
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,76,105,110,101,0,0
#endif

;; native-method palmos/Palm.WinDrawRectangle(Lpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinDrawRectangle
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Palm.WinDrawRectangleFrame(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.WinDrawRectangleFrame
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Palm.WinDrawWindowFrame()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinDrawWindowFrame
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinDrawWindowFrame
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,87,105,110,100,111,119,70,114,97,109,101,0
#endif

;; native-method palmos/Palm.WinEnableWindow(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinEnableWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinEnableWindow
	dc.b	80,97,108,109,46,87,105,110,69,110,97,98,108,101,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinEraseChars(Ljava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinEraseChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinEraseChars
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinEraseChars(Ljava/lang/String;IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinEraseChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinEraseChars
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinEraseChars([CIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinEraseChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinEraseChars
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinEraseChars([BIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinEraseChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinEraseChars
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinEraseLine(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinEraseLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinEraseLine
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,76,105,110,101,0
#endif

;; native-method palmos/Palm.WinEraseRectangle(Lpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinEraseRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.WinEraseRectangle
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Palm.WinEraseRectangleFrame(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinEraseRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.WinEraseRectangleFrame
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0
#endif

;; native-method palmos/Palm.WinEraseWindow()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinEraseWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinEraseWindow
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinFillLine(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinFillLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.WinFillLine
	dc.b	80,97,108,109,46,87,105,110,70,105,108,108,76,105,110,101,0,0
#endif

;; native-method palmos/Palm.WinFillRectangle(Lpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinFillRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinFillRectangle
	dc.b	80,97,108,109,46,87,105,110,70,105,108,108,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Palm.WinGetActiveWindow()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinGetActiveWindow
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinGetActiveWindow
	dc.b	80,97,108,109,46,87,105,110,71,101,116,65,99,116,105,118,101,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinGetClip(Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinGetClip
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.WinGetClip
	dc.b	80,97,108,109,46,87,105,110,71,101,116,67,108,105,112,0
#endif

;; native-method palmos/Palm.WinGetDisplayExtent(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinGetDisplayExtent
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.WinGetDisplayExtent
	dc.b	80,97,108,109,46,87,105,110,71,101,116,68,105,115,112,108,97,121,69,120,116,101,110,116,0,0
#endif

;; native-method palmos/Palm.WinGetDisplayExtent(Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.WinGetDisplayExtent(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_WinGetDisplayExtent
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_WinGetDisplayExtent

;; native-method palmos/Palm.WinGetDisplayWindow()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinGetDisplayWindow
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.WinGetDisplayWindow
	dc.b	80,97,108,109,46,87,105,110,71,101,116,68,105,115,112,108,97,121,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinGetDrawWindow()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinGetDrawWindow
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinGetDrawWindow
	dc.b	80,97,108,109,46,87,105,110,71,101,116,68,114,97,119,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinGetFirstWindow()I
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinGetFirstWindow
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.WinGetFirstWindow
	dc.b	80,97,108,109,46,87,105,110,71,101,116,70,105,114,115,116,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinGetFramesRectangle(ILpalmos/Rectangle;Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinGetFramesRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.WinGetFramesRectangle
	dc.b	80,97,108,109,46,87,105,110,71,101,116,70,114,97,109,101,115,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Palm.WinGetWindowBounds(Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinGetWindowBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinGetWindowBounds
	dc.b	80,97,108,109,46,87,105,110,71,101,116,87,105,110,100,111,119,66,111,117,110,100,115,0
#endif

;; native-method palmos/Palm.WinGetWindowExtent(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinGetWindowExtent
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinGetWindowExtent
	dc.b	80,97,108,109,46,87,105,110,71,101,116,87,105,110,100,111,119,69,120,116,101,110,116,0
#endif

;; native-method palmos/Palm.WinGetWindowExtent(Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.WinGetWindowExtent(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_WinGetWindowExtent
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_WinGetWindowExtent

;; native-method palmos/Palm.WinGetWindowFrameRect(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinGetWindowFrameRect
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.WinGetWindowFrameRect
	dc.b	80,97,108,109,46,87,105,110,71,101,116,87,105,110,100,111,119,70,114,97,109,101,82,101,99,116,0,0
#endif

;; native-method palmos/Palm.WinInitializeWindow(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinInitializeWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.WinInitializeWindow
	dc.b	80,97,108,109,46,87,105,110,73,110,105,116,105,97,108,105,122,101,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinInvertChars(Ljava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinInvertChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinInvertChars
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinInvertChars(Ljava/lang/String;IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinInvertChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinInvertChars
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinInvertChars([CIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinInvertChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinInvertChars
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinInvertChars([BIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinInvertChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinInvertChars
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,67,104,97,114,115,0
#endif

;; native-method palmos/Palm.WinInvertLine(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinInvertLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinInvertLine
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,76,105,110,101,0,0
#endif

;; native-method palmos/Palm.WinInvertRectangle(Lpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinInvertRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinInvertRectangle
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Palm.WinInvertRectangleFrame(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinInvertRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Palm.WinInvertRectangleFrame
	dc.b	80,97,108,109,46,87,105,110,73,110,118,101,114,116,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Palm.WinModal(I)Z
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinModal
	mem.reserve.savereg
	tst.b	d0
	sne.b	d0
	and.l	#1,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13	; Debug Symbol Palm.WinModal
	dc.b	80,97,108,109,46,87,105,110,77,111,100,97,108,0
#endif

;; native-method palmos/Palm.WinPushDrawState()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinPushDrawState
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinPushDrawState
	dc.b	80,97,108,109,46,87,105,110,80,117,115,104,68,114,97,119,83,116,97,116,101,0
#endif

;; native-method palmos/Palm.WinPopDrawState()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinPopDrawState
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinPopDrawState
	dc.b	80,97,108,109,46,87,105,110,80,111,112,68,114,97,119,83,116,97,116,101,0,0
#endif

;; native-method palmos/Palm.WinRemoveWindow(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinRemoveWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinRemoveWindow
	dc.b	80,97,108,109,46,87,105,110,82,101,109,111,118,101,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinResetClip()V
	link	a6,#0
	mem.release
	trap	#15
	dc.w	sysTrapWinResetClip
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinResetClip
	dc.b	80,97,108,109,46,87,105,110,82,101,115,101,116,67,108,105,112,0
#endif

;; native-method palmos/Palm.WinRestoreBits(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinRestoreBits
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinRestoreBits
	dc.b	80,97,108,109,46,87,105,110,82,101,115,116,111,114,101,66,105,116,115,0
#endif

;; native-method palmos/Palm.WinSaveBits(Lpalmos/Rectangle;Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/Rectangle
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinSaveBits
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.WinSaveBits
	dc.b	80,97,108,109,46,87,105,110,83,97,118,101,66,105,116,115,0,0
#endif

;; native-method palmos/Palm.WinSaveBits(Lpalmos/Rectangle;Ljava/lang/Short;)I
;; uses-method palmos/Palm.WinSaveBits(Lpalmos/Rectangle;Lpalmos/ShortHolder;)I as new_WinSaveBits
;; needs-exact-layout palmos/Rectangle
;; needs-exact-layout java/lang/Short
	bra.far	new_WinSaveBits

;; native-method palmos/Palm.WinScrollRectangle(Lpalmos/Rectangle;IILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.b	19(a6),-(a7)
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinScrollRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinScrollRectangle
	dc.b	80,97,108,109,46,87,105,110,83,99,114,111,108,108,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Palm.WinSetActiveWindow(I)V
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinSetActiveWindow
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.WinSetActiveWindow
	dc.b	80,97,108,109,46,87,105,110,83,101,116,65,99,116,105,118,101,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinSetClip(Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinSetClip
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.WinSetClip
	dc.b	80,97,108,109,46,87,105,110,83,101,116,67,108,105,112,0
#endif

;; native-method palmos/Palm.WinSetDrawWindow(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinSetDrawWindow
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Palm.WinSetDrawWindow
	dc.b	80,97,108,109,46,87,105,110,83,101,116,68,114,97,119,87,105,110,100,111,119,0
#endif

;; native-method palmos/Palm.WinSetUnderlineMode(I)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinSetUnderlineMode
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.WinSetUnderlineMode
	dc.b	80,97,108,109,46,87,105,110,83,101,116,85,110,100,101,114,108,105,110,101,77,111,100,101,0,0
#endif

;; native-method palmos/Palm.WinWindowToDisplayPt(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinWindowToDisplayPt
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Palm.WinWindowToDisplayPt
	dc.b	80,97,108,109,46,87,105,110,87,105,110,100,111,119,84,111,68,105,115,112,108,97,121,80,116,0
#endif

;; native-method palmos/Palm.WinWindowToDisplayPt(Ljava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Palm.WinWindowToDisplayPt(Lpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_WinWindowToDisplayPt
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_WinWindowToDisplayPt

;; native-method palmos/Palm.WinCreateBitmapWindow(ILpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinCreateBitmapWindow
	mem.reserve.savereg
	move.l	a0,d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.WinCreateBitmapWindow
	dc.b	80,97,108,109,46,87,105,110,67,114,101,97,116,101,66,105,116,109,97,112,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Palm.WinCreateBitmapWindow(ILjava/lang/Short;)I
;; uses-method palmos/Palm.WinCreateBitmapWindow(ILpalmos/ShortHolder;)I as new_WinCreateBitmapWindow
;; needs-exact-layout java/lang/Short
	bra.far	new_WinCreateBitmapWindow

;; native-method palmos/Palm.WinGetBitmap(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinGetBitmap
	mem.reserve.savereg
	move.l	a0,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinGetBitmap
	dc.b	80,97,108,109,46,87,105,110,71,101,116,66,105,116,109,97,112,0
#endif

;; native-method palmos/Palm.WinPaintBitmap(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinPaintBitmap
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinPaintBitmap
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,66,105,116,109,97,112,0
#endif

;; native-method palmos/Palm.WinRGBToIndex(Lpalmos/RGBColor;)B
;; needs-exact-layout palmos/RGBColor
	link	a6,#0
	move.l	8(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinRGBToIndex
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinRGBToIndex
	dc.b	80,97,108,109,46,87,105,110,82,71,66,84,111,73,110,100,101,120,0,0
#endif

;; native-method palmos/Palm.WinSetForeColor(I)B
	link	a6,#0
	move.b	11(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinSetForeColor
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinSetForeColor
	dc.b	80,97,108,109,46,87,105,110,83,101,116,70,111,114,101,67,111,108,111,114,0,0
#endif

;; native-method palmos/Palm.WinPalette(IIILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.b	23(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinPalette
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15	; Debug Symbol Palm.WinPalette
	dc.b	80,97,108,109,46,87,105,110,80,97,108,101,116,116,101,0
#endif

;; native-method palmos/Palm.WinScreenMode(ILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/BoolHolder;)I
;; needs-exact-layout palmos/IntHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	27(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinScreenMode
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-16(a6),a0
	proxy.release
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinScreenMode
	dc.b	80,97,108,109,46,87,105,110,83,99,114,101,101,110,77,111,100,101,0,0
#endif

;; native-method palmos/Palm.WinScreenMode(ILjava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Boolean;)I
;; uses-method palmos/Palm.WinScreenMode(ILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/BoolHolder;)I as new_WinScreenMode
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Boolean
	bra.far	new_WinScreenMode

;; native-method palmos/Palm.WinGetPixel(II)B
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinGetPixel
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16	; Debug Symbol Palm.WinGetPixel
	dc.b	80,97,108,109,46,87,105,110,71,101,116,80,105,120,101,108,0,0
#endif

;; native-method palmos/Palm.WinDrawPixel(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinDrawPixel
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinDrawPixel
	dc.b	80,97,108,109,46,87,105,110,68,114,97,119,80,105,120,101,108,0
#endif

;; native-method palmos/Palm.WinPaintPixel(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinPaintPixel
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinPaintPixel
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,80,105,120,101,108,0,0
#endif

;; native-method palmos/Palm.WinErasePixel(II)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinErasePixel
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinErasePixel
	dc.b	80,97,108,109,46,87,105,110,69,114,97,115,101,80,105,120,101,108,0,0
#endif

;; native-method palmos/Palm.WinPaintLine(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinPaintLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Palm.WinPaintLine
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,76,105,110,101,0
#endif

;; native-method palmos/Palm.WinPaintRectangle(Lpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	trap	#15
	dc.w	sysTrapWinPaintRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.WinPaintRectangle
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Palm.WinSetTextColor(I)B
	link	a6,#0
	move.b	11(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinSetTextColor
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinSetTextColor
	dc.b	80,97,108,109,46,87,105,110,83,101,116,84,101,120,116,67,111,108,111,114,0,0
#endif

;; native-method palmos/Palm.WinSetBackColor(I)B
	link	a6,#0
	move.b	11(a6),-(a7)
	trap	#15
	dc.w	sysTrapWinSetBackColor
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinSetBackColor
	dc.b	80,97,108,109,46,87,105,110,83,101,116,66,97,99,107,67,111,108,111,114,0,0
#endif

;; native-method palmos/Palm.WinSetDrawMode(I)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysTrapWinSetDrawMode
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Palm.WinSetDrawMode
	dc.b	80,97,108,109,46,87,105,110,83,101,116,68,114,97,119,77,111,100,101,0
#endif

;; native-method palmos/Palm.WinPaintChars(Ljava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinPaintChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinPaintChars
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinPaintChars(Ljava/lang/String;IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinPaintChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinPaintChars
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinPaintChars([CIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinPaintChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinPaintChars
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinPaintChars([BIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	20(a6),a0
	sub.l	20(a6),d0
	move.l	a0,(a7)
	trap	#15
	dc.w	sysTrapWinPaintChars
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinPaintChars
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,67,104,97,114,115,0,0
#endif

;; native-method palmos/Palm.WinSetCoordinateSystem(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinSetCoordinateSystem,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.WinSetCoordinateSystem
	dc.b	80,97,108,109,46,87,105,110,83,101,116,67,111,111,114,100,105,110,97,116,101,83,121,115,116,101,109,0
#endif

;; native-method palmos/Palm.WinGetCoordinateSystem()I
	link	a6,#0
	mem.release
	moveq.l	#HDSelectorWinGetCoordinateSystem,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.WinGetCoordinateSystem
	dc.b	80,97,108,109,46,87,105,110,71,101,116,67,111,111,114,100,105,110,97,116,101,83,121,115,116,101,109,0
#endif

;; native-method palmos/Palm.WinScaleCoord(IZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinScaleCoord,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinScaleCoord
	dc.b	80,97,108,109,46,87,105,110,83,99,97,108,101,67,111,111,114,100,0,0
#endif

;; native-method palmos/Palm.WinUnscaleCoord(IZ)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinUnscaleCoord,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinUnscaleCoord
	dc.b	80,97,108,109,46,87,105,110,85,110,115,99,97,108,101,67,111,111,114,100,0,0
#endif

;; native-method palmos/Palm.WinScalePoint(Lpalmos/PointType;Z)V
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#HDSelectorWinScalePoint,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Palm.WinScalePoint
	dc.b	80,97,108,109,46,87,105,110,83,99,97,108,101,80,111,105,110,116,0,0
#endif

;; native-method palmos/Palm.WinUnscalePoint(Lpalmos/PointType;Z)V
;; needs-exact-layout palmos/PointType
	link	a6,#0
	move.b	11(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#HDSelectorWinUnscalePoint,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.WinUnscalePoint
	dc.b	80,97,108,109,46,87,105,110,85,110,115,99,97,108,101,80,111,105,110,116,0,0
#endif

;; native-method palmos/Palm.WinScaleRectangle(Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#HDSelectorWinScaleRectangle,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.WinScaleRectangle
	dc.b	80,97,108,109,46,87,105,110,83,99,97,108,101,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Palm.WinUnscaleRectangle(Lpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#HDSelectorWinUnscaleRectangle,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.WinUnscaleRectangle
	dc.b	80,97,108,109,46,87,105,110,85,110,115,99,97,108,101,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Palm.WinScreenGetAttribute(ILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.b	15(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinScreenGetAttribute,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Palm.WinScreenGetAttribute
	dc.b	80,97,108,109,46,87,105,110,83,99,114,101,101,110,71,101,116,65,116,116,114,105,98,117,116,101,0,0
#endif

;; native-method palmos/Palm.WinScreenGetAttribute(ILjava/lang/Integer;)I
;; uses-method palmos/Palm.WinScreenGetAttribute(ILpalmos/IntHolder;)I as new_WinScreenGetAttribute
;; needs-exact-layout java/lang/Integer
	bra.far	new_WinScreenGetAttribute

;; native-method palmos/Palm.WinPaintTiledBitmap(ILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinPaintTiledBitmap,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.WinPaintTiledBitmap
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,84,105,108,101,100,66,105,116,109,97,112,0,0
#endif

;; native-method palmos/Palm.WinGetSupportedDensity(Lpalmos/ShortHolder;)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	mem.release
	moveq.l	#HDSelectorWinGetSupportedDensity,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	ext.l	d0
#ifdef DM_HEAP
	move.l	d0,-(a7)
	move.l	-4(a6),a0
	proxy.release
	move.l	(a7)+,d0
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Palm.WinGetSupportedDensity
	dc.b	80,97,108,109,46,87,105,110,71,101,116,83,117,112,112,111,114,116,101,100,68,101,110,115,105,116,121,0
#endif

;; native-method palmos/Palm.WinGetSupportedDensity(Ljava/lang/Short;)I
;; uses-method palmos/Palm.WinGetSupportedDensity(Lpalmos/ShortHolder;)I as new_WinGetSupportedDensity
;; needs-exact-layout java/lang/Short
	bra.far	new_WinGetSupportedDensity

;; native-method palmos/Palm.EvtGetPenNative(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V
;; needs-exact-layout palmos/ShortHolder
;; needs-exact-layout palmos/BoolHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	16(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.l	20(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorEvtGetPenNative,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-12(a6),a0
	proxy.release
	move.l	-8(a6),a0
	proxy.release
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Palm.EvtGetPenNative
	dc.b	80,97,108,109,46,69,118,116,71,101,116,80,101,110,78,97,116,105,118,101,0,0
#endif

;; native-method palmos/Palm.EvtGetPenNative(ILjava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)V
;; uses-method palmos/Palm.EvtGetPenNative(ILpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V as new_EvtGetPenNative
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_EvtGetPenNative

;; native-method palmos/Palm.WinPaintRoundedRectangleFrame(Lpalmos/Rectangle;III)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinPaintRoundedRectangleFrame,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,34	; Debug Symbol Palm.WinPaintRoundedRectangleFrame
	dc.b	80,97,108,109,46,87,105,110,80,97,105,110,116,82,111,117,110,100,101,100,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Palm.WinSetScalingMode(I)I
	link	a6,#0
	move.l	8(a6),-(a7)
	mem.release
	moveq.l	#HDSelectorWinSetScalingMode,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.WinSetScalingMode
	dc.b	80,97,108,109,46,87,105,110,83,101,116,83,99,97,108,105,110,103,77,111,100,101,0,0
#endif

;; native-method palmos/Palm.WinGetScalingMode()I
	link	a6,#0
	mem.release
	moveq.l	#HDSelectorWinGetScalingMode,d2
	trap	#15
	dc.w	sysTrapHighDensityDispatch
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.WinGetScalingMode
	dc.b	80,97,108,109,46,87,105,110,71,101,116,83,99,97,108,105,110,103,77,111,100,101,0,0
#endif

;; native-method palmos/Palm.HsExtKeyboardEnable(Z)I
	link	a6,#0
	move.b	11(a6),-(a7)
	mem.release
	move.w	#hsSelExtKeyboardEnable,-(a7)
	trap	#15
	dc.w	sysTrapHsSelector
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.HsExtKeyboardEnable
	dc.b	80,97,108,109,46,72,115,69,120,116,75,101,121,98,111,97,114,100,69,110,97,98,108,101,0,0
#endif

;; native-method palmos/Palm.ReporterTraceInit()V
	link	a6,#0
	mem.release
	move.w	#hostSelectorTraceInit,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Palm.ReporterTraceInit
	dc.b	80,97,108,109,46,82,101,112,111,114,116,101,114,84,114,97,99,101,73,110,105,116,0,0
#endif

;; native-method palmos/Palm.ReporterTraceClose()V
	link	a6,#0
	mem.release
	move.w	#hostSelectorTraceClose,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Palm.ReporterTraceClose
	dc.b	80,97,108,109,46,82,101,112,111,114,116,101,114,84,114,97,99,101,67,108,111,115,101,0
#endif

;; native-method palmos/Palm.ReporterTraceOutput(ILjava/lang/String;Ljava/lang/String;)V
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	move.w	#hostSelectorTraceOutputTL,-(a7)
	trap	#15
	dc.w	sysTrapHostControl
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Palm.ReporterTraceOutput
	dc.b	80,97,108,109,46,82,101,112,111,114,116,101,114,84,114,97,99,101,79,117,116,112,117,116,0,0
#endif

