; Created by MkApi for Jump 2.2.2
;; native-method palmos/Sony.HROpen(I)I
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
	dc.b	$80,11	; Debug Symbol Sony.HROpen
	dc.b	83,111,110,121,46,72,82,79,112,101,110,0
#endif

;; native-method palmos/Sony.HRClose(I)I
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
	dc.b	$80,12	; Debug Symbol Sony.HRClose
	dc.b	83,111,110,121,46,72,82,67,108,111,115,101,0,0
#endif

;; native-method palmos/Sony.HRSleep(I)I
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
	dc.b	$80,12	; Debug Symbol Sony.HRSleep
	dc.b	83,111,110,121,46,72,82,83,108,101,101,112,0,0
#endif

;; native-method palmos/Sony.HRWake(I)I
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
	dc.b	$80,11	; Debug Symbol Sony.HRWake
	dc.b	83,111,110,121,46,72,82,87,97,107,101,0
#endif

;; native-method palmos/Sony.HRGetAPIVersion(ILpalmos/ShortHolder;)I
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
	dc.w	HRTrapGetAPIVersion
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
	dc.b	$80,20	; Debug Symbol Sony.HRGetAPIVersion
	dc.b	83,111,110,121,46,72,82,71,101,116,65,80,73,86,101,114,115,105,111,110,0,0
#endif

;; native-method palmos/Sony.HRGetAPIVersion(ILjava/lang/Short;)I
;; uses-method palmos/Sony.HRGetAPIVersion(ILpalmos/ShortHolder;)I as new_HRGetAPIVersion
;; needs-exact-layout java/lang/Short
	bra.far	new_HRGetAPIVersion

;; native-method palmos/Sony.HRWinClipRectangle(ILpalmos/Rectangle;)V
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
	dc.w	HRTrapWinClipRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Sony.HRWinClipRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,67,108,105,112,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Sony.HRWinCopyRectangle(IIILpalmos/Rectangle;III)V
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
	move.w	34(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinCopyRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-10(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Sony.HRWinCopyRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,67,111,112,121,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Sony.HRWinCreateBitmapWindow(IILpalmos/ShortHolder;)I
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
	mem.release
	trap	#15
	dc.w	HRTrapWinCreateBitmapWindow
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
	dc.b	$80,28	; Debug Symbol Sony.HRWinCreateBitmapWindow
	dc.b	83,111,110,121,46,72,82,87,105,110,67,114,101,97,116,101,66,105,116,109,97,112,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Sony.HRWinCreateBitmapWindow(IILjava/lang/Short;)I
;; uses-method palmos/Sony.HRWinCreateBitmapWindow(IILpalmos/ShortHolder;)I as new_HRWinCreateBitmapWindow
;; needs-exact-layout java/lang/Short
	bra.far	new_HRWinCreateBitmapWindow

;; native-method palmos/Sony.HRWinCreateOffscreenWindow(IIIILpalmos/ShortHolder;)I
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
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinCreateOffscreenWindow
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
	dc.b	$80,31	; Debug Symbol Sony.HRWinCreateOffscreenWindow
	dc.b	83,111,110,121,46,72,82,87,105,110,67,114,101,97,116,101,79,102,102,115,99,114,101,101,110,87,105,110,100,111,119,0
#endif

;; native-method palmos/Sony.HRWinCreateOffscreenWindow(IIIILjava/lang/Short;)I
;; uses-method palmos/Sony.HRWinCreateOffscreenWindow(IIIILpalmos/ShortHolder;)I as new_HRWinCreateOffscreenWindow
;; needs-exact-layout java/lang/Short
	bra.far	new_HRWinCreateOffscreenWindow

;; native-method palmos/Sony.HRWinCreateWindow(ILpalmos/Rectangle;IZZLpalmos/ShortHolder;)I
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
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinCreateWindow
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
	dc.b	$80,22	; Debug Symbol Sony.HRWinCreateWindow
	dc.b	83,111,110,121,46,72,82,87,105,110,67,114,101,97,116,101,87,105,110,100,111,119,0,0
#endif

;; native-method palmos/Sony.HRWinCreateWindow(ILpalmos/Rectangle;IZZLjava/lang/Short;)I
;; uses-method palmos/Sony.HRWinCreateWindow(ILpalmos/Rectangle;IZZLpalmos/ShortHolder;)I as new_HRWinCreateWindow
;; needs-exact-layout palmos/Rectangle
;; needs-exact-layout java/lang/Short
	bra.far	new_HRWinCreateWindow

;; native-method palmos/Sony.HRWinDisplayToWindowPt(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
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
	trap	#15
	dc.w	HRTrapWinDisplayToWindowPt
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
	dc.b	$80,27	; Debug Symbol Sony.HRWinDisplayToWindowPt
	dc.b	83,111,110,121,46,72,82,87,105,110,68,105,115,112,108,97,121,84,111,87,105,110,100,111,119,80,116,0
#endif

;; native-method palmos/Sony.HRWinDrawBitmap(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawBitmap
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinDrawBitmap
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,66,105,116,109,97,112,0,0
#endif

;; native-method palmos/Sony.HRWinDrawChar(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawChar
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRWinDrawChar
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,67,104,97,114,0,0
#endif

;; native-method palmos/Sony.HRWinDrawChars(ILjava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRWinDrawChars
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,67,104,97,114,115,0
#endif

;; native-method palmos/Sony.HRWinDrawGrayLine(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawGrayLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Sony.HRWinDrawGrayLine
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,71,114,97,121,76,105,110,101,0,0
#endif

;; native-method palmos/Sony.HRWinDrawGrayRectangleFrame(IILpalmos/Rectangle;)V
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
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawGrayRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,32	; Debug Symbol Sony.HRWinDrawGrayRectangleFrame
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,71,114,97,121,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Sony.HRWinDrawInvertedChars(ILjava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawInvertedChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Sony.HRWinDrawInvertedChars
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,73,110,118,101,114,116,101,100,67,104,97,114,115,0
#endif

;; native-method palmos/Sony.HRWinDrawLine(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRWinDrawLine
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,76,105,110,101,0,0
#endif

;; native-method palmos/Sony.HRWinDrawPixel(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawPixel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRWinDrawPixel
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,80,105,120,101,108,0
#endif

;; native-method palmos/Sony.HRWinDrawRectangle(ILpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Sony.HRWinDrawRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Sony.HRWinDrawRectangleFrame(IILpalmos/Rectangle;)V
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
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Sony.HRWinDrawRectangleFrame
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Sony.HRWinDrawTruncChars(ILjava/lang/String;IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinDrawTruncChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Sony.HRWinDrawTruncChars
	dc.b	83,111,110,121,46,72,82,87,105,110,68,114,97,119,84,114,117,110,99,67,104,97,114,115,0,0
#endif

;; native-method palmos/Sony.HRWinEraseChars(ILjava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinEraseChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinEraseChars
	dc.b	83,111,110,121,46,72,82,87,105,110,69,114,97,115,101,67,104,97,114,115,0,0
#endif

;; native-method palmos/Sony.HRWinEraseLine(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinEraseLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRWinEraseLine
	dc.b	83,111,110,121,46,72,82,87,105,110,69,114,97,115,101,76,105,110,101,0
#endif

;; native-method palmos/Sony.HRWinErasePixel(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinErasePixel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinErasePixel
	dc.b	83,111,110,121,46,72,82,87,105,110,69,114,97,115,101,80,105,120,101,108,0,0
#endif

;; native-method palmos/Sony.HRWinEraseRectangle(ILpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinEraseRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Sony.HRWinEraseRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,69,114,97,115,101,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Sony.HRWinEraseRectangleFrame(IILpalmos/Rectangle;)V
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
	mem.release
	trap	#15
	dc.w	HRTrapWinEraseRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,29	; Debug Symbol Sony.HRWinEraseRectangleFrame
	dc.b	83,111,110,121,46,72,82,87,105,110,69,114,97,115,101,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0
#endif

;; native-method palmos/Sony.HRWinFillLine(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinFillLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRWinFillLine
	dc.b	83,111,110,121,46,72,82,87,105,110,70,105,108,108,76,105,110,101,0,0
#endif

;; native-method palmos/Sony.HRWinFillRectangle(ILpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinFillRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Sony.HRWinFillRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,70,105,108,108,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Sony.HRWinGetClip(ILpalmos/Rectangle;)V
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
	dc.w	HRTrapWinGetClip
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Sony.HRWinGetClip
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,67,108,105,112,0
#endif

;; native-method palmos/Sony.HRWinGetDisplayExtent(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
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
	trap	#15
	dc.w	HRTrapWinGetDisplayExtent
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
	dc.b	$80,26	; Debug Symbol Sony.HRWinGetDisplayExtent
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,68,105,115,112,108,97,121,69,120,116,101,110,116,0,0
#endif

;; native-method palmos/Sony.HRWinGetFramesRectangle(IILpalmos/Rectangle;Lpalmos/Rectangle;)V
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
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinGetFramesRectangle
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
	dc.b	$80,28	; Debug Symbol Sony.HRWinGetFramesRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,70,114,97,109,101,115,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Sony.HRWinGetPixel(III)B
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinGetPixel
	mem.reserve.savereg
	ext.w	d0
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRWinGetPixel
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,80,105,120,101,108,0,0
#endif

;; native-method palmos/Sony.HRWinGetWindowBounds(ILpalmos/Rectangle;)V
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
	dc.w	HRTrapWinGetWindowBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Sony.HRWinGetWindowBounds
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,87,105,110,100,111,119,66,111,117,110,100,115,0
#endif

;; native-method palmos/Sony.HRWinGetWindowExtent(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
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
	trap	#15
	dc.w	HRTrapWinGetWindowExtent
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
	dc.b	$80,25	; Debug Symbol Sony.HRWinGetWindowExtent
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,87,105,110,100,111,119,69,120,116,101,110,116,0
#endif

;; native-method palmos/Sony.HRWinGetWindowFrameRect(IILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
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
	dc.w	HRTrapWinGetWindowFrameRect
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Sony.HRWinGetWindowFrameRect
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,87,105,110,100,111,119,70,114,97,109,101,82,101,99,116,0,0
#endif

;; native-method palmos/Sony.HRWinInvertChars(ILjava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinInvertChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Sony.HRWinInvertChars
	dc.b	83,111,110,121,46,72,82,87,105,110,73,110,118,101,114,116,67,104,97,114,115,0
#endif

;; native-method palmos/Sony.HRWinInvertLine(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinInvertLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinInvertLine
	dc.b	83,111,110,121,46,72,82,87,105,110,73,110,118,101,114,116,76,105,110,101,0,0
#endif

;; native-method palmos/Sony.HRWinInvertPixel(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinInvertPixel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Sony.HRWinInvertPixel
	dc.b	83,111,110,121,46,72,82,87,105,110,73,110,118,101,114,116,80,105,120,101,108,0
#endif

;; native-method palmos/Sony.HRWinInvertRectangle(ILpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinInvertRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Sony.HRWinInvertRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,73,110,118,101,114,116,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Sony.HRWinInvertRectangleFrame(IILpalmos/Rectangle;)V
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
	mem.release
	trap	#15
	dc.w	HRTrapWinInvertRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,30	; Debug Symbol Sony.HRWinInvertRectangleFrame
	dc.b	83,111,110,121,46,72,82,87,105,110,73,110,118,101,114,116,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0,0
#endif

;; native-method palmos/Sony.HRWinPaintBitmap(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintBitmap
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Sony.HRWinPaintBitmap
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,66,105,116,109,97,112,0
#endif

;; native-method palmos/Sony.HRWinPaintChar(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintChar
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRWinPaintChar
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,67,104,97,114,0
#endif

;; native-method palmos/Sony.HRWinPaintChars(ILjava/lang/String;III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.l	20(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintChars
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinPaintChars
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,67,104,97,114,115,0,0
#endif

;; native-method palmos/Sony.HRWinPaintLine(IIIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintLine
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRWinPaintLine
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,76,105,110,101,0
#endif

;; native-method palmos/Sony.HRWinPaintLines(II[SI)V
	link	a6,#0
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	8(a6),d1
	mulu.w	#2,d1
	adda.l	d1,a0
	sub.l	d1,d0
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintLines
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinPaintLines
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,76,105,110,101,115,0,0
#endif

;; native-method palmos/Sony.HRWinPaintPixel(III)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintPixel
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRWinPaintPixel
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,80,105,120,101,108,0,0
#endif

;; native-method palmos/Sony.HRWinPaintPixels(II[SI)V
	link	a6,#0
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	8(a6),d1
	mulu.w	#2,d1
	adda.l	d1,a0
	sub.l	d1,d0
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintPixels
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Sony.HRWinPaintPixels
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,80,105,120,101,108,115,0
#endif

;; native-method palmos/Sony.HRWinPaintRectangle(ILpalmos/Rectangle;I)V
;; needs-exact-layout palmos/Rectangle
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintRectangle
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,24	; Debug Symbol Sony.HRWinPaintRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,82,101,99,116,97,110,103,108,101,0,0
#endif

;; native-method palmos/Sony.HRWinPaintRectangleFrame(IILpalmos/Rectangle;)V
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
	mem.release
	trap	#15
	dc.w	HRTrapWinPaintRectangleFrame
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,29	; Debug Symbol Sony.HRWinPaintRectangleFrame
	dc.b	83,111,110,121,46,72,82,87,105,110,80,97,105,110,116,82,101,99,116,97,110,103,108,101,70,114,97,109,101,0
#endif

;; native-method palmos/Sony.HRWinRestoreBits(IIII)V
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.l	16(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinRestoreBits
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Sony.HRWinRestoreBits
	dc.b	83,111,110,121,46,72,82,87,105,110,82,101,115,116,111,114,101,66,105,116,115,0
#endif

;; native-method palmos/Sony.HRWinSaveBits(ILpalmos/Rectangle;Lpalmos/ShortHolder;)I
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
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinSaveBits
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
	dc.b	$80,18	; Debug Symbol Sony.HRWinSaveBits
	dc.b	83,111,110,121,46,72,82,87,105,110,83,97,118,101,66,105,116,115,0,0
#endif

;; native-method palmos/Sony.HRWinSaveBits(ILpalmos/Rectangle;Ljava/lang/Short;)I
;; uses-method palmos/Sony.HRWinSaveBits(ILpalmos/Rectangle;Lpalmos/ShortHolder;)I as new_HRWinSaveBits
;; needs-exact-layout palmos/Rectangle
;; needs-exact-layout java/lang/Short
	bra.far	new_HRWinSaveBits

;; native-method palmos/Sony.HRWinScreenMode(IILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/BoolHolder;)I
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
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinScreenMode
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
	dc.b	$80,20	; Debug Symbol Sony.HRWinScreenMode
	dc.b	83,111,110,121,46,72,82,87,105,110,83,99,114,101,101,110,77,111,100,101,0,0
#endif

;; native-method palmos/Sony.HRWinScreenMode(IILjava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Boolean;)I
;; uses-method palmos/Sony.HRWinScreenMode(IILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/BoolHolder;)I as new_HRWinScreenMode
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Boolean
	bra.far	new_HRWinScreenMode

;; native-method palmos/Sony.HRWinScrollRectangle(ILpalmos/Rectangle;IILpalmos/Rectangle;)V
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
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinScrollRectangle
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
	dc.b	$80,25	; Debug Symbol Sony.HRWinScrollRectangle
	dc.b	83,111,110,121,46,72,82,87,105,110,83,99,114,111,108,108,82,101,99,116,97,110,103,108,101,0
#endif

;; native-method palmos/Sony.HRWinSetClip(ILpalmos/Rectangle;)V
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
	dc.w	HRTrapWinSetClip
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Sony.HRWinSetClip
	dc.b	83,111,110,121,46,72,82,87,105,110,83,101,116,67,108,105,112,0
#endif

;; native-method palmos/Sony.HRWinSetWindowBounds(IILpalmos/Rectangle;)V
;; needs-exact-layout palmos/Rectangle
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
	dc.w	HRTrapWinSetWindowBounds
	mem.reserve.savereg
#ifdef DM_HEAP
	move.l	-4(a6),a0
	proxy.release
#endif
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Sony.HRWinSetWindowBounds
	dc.b	83,111,110,121,46,72,82,87,105,110,83,101,116,87,105,110,100,111,119,66,111,117,110,100,115,0
#endif

;; native-method palmos/Sony.HRWinWindowToDisplayPt(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
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
	trap	#15
	dc.w	HRTrapWinWindowToDisplayPt
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
	dc.b	$80,27	; Debug Symbol Sony.HRWinWindowToDisplayPt
	dc.b	83,111,110,121,46,72,82,87,105,110,87,105,110,100,111,119,84,111,68,105,115,112,108,97,121,80,116,0
#endif

;; native-method palmos/Sony.HRWinGetPixelRGB(IIILpalmos/IntHolder;)I
;; needs-exact-layout palmos/IntHolder
	link	a6,#0
	move.l	8(a6),-(a7)
#ifdef DM_HEAP
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
#endif
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapWinGetPixelRGB
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
	dc.b	$80,21	; Debug Symbol Sony.HRWinGetPixelRGB
	dc.b	83,111,110,121,46,72,82,87,105,110,71,101,116,80,105,120,101,108,82,71,66,0
#endif

;; native-method palmos/Sony.HRWinGetPixelRGB(IIILjava/lang/Integer;)I
;; uses-method palmos/Sony.HRWinGetPixelRGB(IIILpalmos/IntHolder;)I as new_HRWinGetPixelRGB
;; needs-exact-layout java/lang/Integer
	bra.far	new_HRWinGetPixelRGB

;; native-method palmos/Sony.HRBmpBitsSize(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapBmpBitsSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRBmpBitsSize
	dc.b	83,111,110,121,46,72,82,66,109,112,66,105,116,115,83,105,122,101,0,0
#endif

;; native-method palmos/Sony.HRBmpSize(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapBmpSize
	mem.reserve.savereg
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,14	; Debug Symbol Sony.HRBmpSize
	dc.b	83,111,110,121,46,72,82,66,109,112,83,105,122,101,0,0
#endif

;; native-method palmos/Sony.HRBmpCreate(IIIILjava/lang/Object;Lpalmos/ShortHolder;)I
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
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapBmpCreate
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
	dc.b	$80,16	; Debug Symbol Sony.HRBmpCreate
	dc.b	83,111,110,121,46,72,82,66,109,112,67,114,101,97,116,101,0,0
#endif

;; native-method palmos/Sony.HRBmpCreate(IIIILjava/lang/Object;Ljava/lang/Short;)I
;; uses-method palmos/Sony.HRBmpCreate(IIIILjava/lang/Object;Lpalmos/ShortHolder;)I as new_HRBmpCreate
;; needs-exact-layout java/lang/Short
	bra.far	new_HRBmpCreate

;; native-method palmos/Sony.HRFntGetFont(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntGetFont
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Sony.HRFntGetFont
	dc.b	83,111,110,121,46,72,82,70,110,116,71,101,116,70,111,110,116,0
#endif

;; native-method palmos/Sony.HRFntSetFont(II)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntSetFont
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Sony.HRFntSetFont
	dc.b	83,111,110,121,46,72,82,70,110,116,83,101,116,70,111,110,116,0
#endif

;; native-method palmos/Sony.HRFontSelect(II)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFontSelect
	mem.reserve.savereg
	and.l	#$ff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17	; Debug Symbol Sony.HRFontSelect
	dc.b	83,111,110,121,46,72,82,70,111,110,116,83,101,108,101,99,116,0
#endif

;; native-method palmos/Sony.HRFntBaseLine(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntBaseLine
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRFntBaseLine
	dc.b	83,111,110,121,46,72,82,70,110,116,66,97,115,101,76,105,110,101,0,0
#endif

;; native-method palmos/Sony.HRFntCharHeight(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntCharHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRFntCharHeight
	dc.b	83,111,110,121,46,72,82,70,110,116,67,104,97,114,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Sony.HRFntLineHeight(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntLineHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRFntLineHeight
	dc.b	83,111,110,121,46,72,82,70,110,116,76,105,110,101,72,101,105,103,104,116,0,0
#endif

;; native-method palmos/Sony.HRFntAverageCharWidth(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntAverageCharWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Sony.HRFntAverageCharWidth
	dc.b	83,111,110,121,46,72,82,70,110,116,65,118,101,114,97,103,101,67,104,97,114,87,105,100,116,104,0,0
#endif

;; native-method palmos/Sony.HRFntCharWidth(II)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntCharWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRFntCharWidth
	dc.b	83,111,110,121,46,72,82,70,110,116,67,104,97,114,87,105,100,116,104,0
#endif

;; native-method palmos/Sony.HRFntWCharWidth(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntWCharWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRFntWCharWidth
	dc.b	83,111,110,121,46,72,82,70,110,116,87,67,104,97,114,87,105,100,116,104,0,0
#endif

;; native-method palmos/Sony.HRFntCharsWidth(ILjava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntCharsWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20	; Debug Symbol Sony.HRFntCharsWidth
	dc.b	83,111,110,121,46,72,82,70,110,116,67,104,97,114,115,87,105,100,116,104,0,0
#endif

;; native-method palmos/Sony.HRFntWidthToOffset(ILjava/lang/String;IILpalmos/BoolHolder;Lpalmos/ShortHolder;)I
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
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntWidthToOffset
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
	dc.b	$80,23	; Debug Symbol Sony.HRFntWidthToOffset
	dc.b	83,111,110,121,46,72,82,70,110,116,87,105,100,116,104,84,111,79,102,102,115,101,116,0
#endif

;; native-method palmos/Sony.HRFntWidthToOffset(ILjava/lang/String;IILjava/lang/Boolean;Ljava/lang/Short;)I
;; uses-method palmos/Sony.HRFntWidthToOffset(ILjava/lang/String;IILpalmos/BoolHolder;Lpalmos/ShortHolder;)I as new_HRFntWidthToOffset
;; needs-exact-layout java/lang/Boolean
;; needs-exact-layout java/lang/Short
	bra.far	new_HRFntWidthToOffset

;; native-method palmos/Sony.HRFntCharsInWidth(ILjava/lang/String;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V
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
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntCharsInWidth
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
	dc.b	$80,22	; Debug Symbol Sony.HRFntCharsInWidth
	dc.b	83,111,110,121,46,72,82,70,110,116,67,104,97,114,115,73,110,87,105,100,116,104,0,0
#endif

;; native-method palmos/Sony.HRFntCharsInWidth(ILjava/lang/String;Ljava/lang/Short;Ljava/lang/Short;Ljava/lang/Boolean;)V
;; uses-method palmos/Sony.HRFntCharsInWidth(ILjava/lang/String;Lpalmos/ShortHolder;Lpalmos/ShortHolder;Lpalmos/BoolHolder;)V as new_HRFntCharsInWidth
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Boolean
	bra.far	new_HRFntCharsInWidth

;; native-method palmos/Sony.HRFntDescenderHeight(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntDescenderHeight
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Sony.HRFntDescenderHeight
	dc.b	83,111,110,121,46,72,82,70,110,116,68,101,115,99,101,110,100,101,114,72,101,105,103,104,116,0
#endif

;; native-method palmos/Sony.HRFntLineWidth(ILjava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntLineWidth
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Sony.HRFntLineWidth
	dc.b	83,111,110,121,46,72,82,70,110,116,76,105,110,101,87,105,100,116,104,0
#endif

;; native-method palmos/Sony.HRFntWordWrap(ILjava/lang/String;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntWordWrap
	mem.reserve.savereg
	and.l	#$ffff,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18	; Debug Symbol Sony.HRFntWordWrap
	dc.b	83,111,110,121,46,72,82,70,110,116,87,111,114,100,87,114,97,112,0,0
#endif

;; native-method palmos/Sony.HRFntWordWrapReverseNLines(ILjava/lang/String;ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
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
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntWordWrapReverseNLines
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
	dc.b	$80,31	; Debug Symbol Sony.HRFntWordWrapReverseNLines
	dc.b	83,111,110,121,46,72,82,70,110,116,87,111,114,100,87,114,97,112,82,101,118,101,114,115,101,78,76,105,110,101,115,0
#endif

;; native-method palmos/Sony.HRFntWordWrapReverseNLines(ILjava/lang/String;ILjava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Sony.HRFntWordWrapReverseNLines(ILjava/lang/String;ILpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_HRFntWordWrapReverseNLines
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_HRFntWordWrapReverseNLines

;; native-method palmos/Sony.HRFntGetScrollValues(ILjava/lang/String;IILpalmos/ShortHolder;Lpalmos/ShortHolder;)V
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
	move.l	24(a6),-(a7)
	bsr.far	getvoidptr
	move.l	a0,(a7)
	move.w	30(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapFntGetScrollValues
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
	dc.b	$80,25	; Debug Symbol Sony.HRFntGetScrollValues
	dc.b	83,111,110,121,46,72,82,70,110,116,71,101,116,83,99,114,111,108,108,86,97,108,117,101,115,0
#endif

;; native-method palmos/Sony.HRFntGetScrollValues(ILjava/lang/String;IILjava/lang/Short;Ljava/lang/Short;)V
;; uses-method palmos/Sony.HRFntGetScrollValues(ILjava/lang/String;IILpalmos/ShortHolder;Lpalmos/ShortHolder;)V as new_HRFntGetScrollValues
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_HRFntGetScrollValues

;; native-method palmos/Sony.HRSystem(IILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I
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
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	HRTrapSystem
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
	dc.b	$80,13	; Debug Symbol Sony.HRSystem
	dc.b	83,111,110,121,46,72,82,83,121,115,116,101,109,0
#endif

;; native-method palmos/Sony.HRSystem(IILjava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)I
;; uses-method palmos/Sony.HRSystem(IILpalmos/IntHolder;Lpalmos/IntHolder;Lpalmos/IntHolder;)I as new_HRSystem
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
;; needs-exact-layout java/lang/Integer
	bra.far	new_HRSystem

;; native-method palmos/Sony.HRGetInfo(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)I
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
	trap	#15
	dc.w	HRTrapGetInfo
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
	dc.b	$80,14	; Debug Symbol Sony.HRGetInfo
	dc.b	83,111,110,121,46,72,82,71,101,116,73,110,102,111,0,0
#endif

;; native-method palmos/Sony.HRGetInfo(ILjava/lang/Short;Ljava/lang/Short;)I
;; uses-method palmos/Sony.HRGetInfo(ILpalmos/ShortHolder;Lpalmos/ShortHolder;)I as new_HRGetInfo
;; needs-exact-layout java/lang/Short
;; needs-exact-layout java/lang/Short
	bra.far	new_HRGetInfo

