; Created by MkApi for Jump 2.2.2
;; native-method palmos/Symbol.ScanMgrLibOpen(ILpalmos/ShortHolder;)I
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
	dc.w	sysLibTrapScanMgrLibOpen
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
	dc.b	$80,21	; Debug Symbol Symbol.ScanMgrLibOpen
	dc.b	83,121,109,98,111,108,46,83,99,97,110,77,103,114,76,105,98,79,112,101,110,0
#endif

;; native-method palmos/Symbol.ScanMgrLibOpen(ILjava/lang/Short;)I
;; uses-method palmos/Symbol.ScanMgrLibOpen(ILpalmos/ShortHolder;)I as new_ScanMgrLibOpen
;; needs-exact-layout java/lang/Short
	bra.far	new_ScanMgrLibOpen

;; native-method palmos/Symbol.ScanMgrLibClose(ILpalmos/IntHolder;)I
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
	dc.w	sysLibTrapScanMgrLibClose
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
	dc.b	$80,22	; Debug Symbol Symbol.ScanMgrLibClose
	dc.b	83,121,109,98,111,108,46,83,99,97,110,77,103,114,76,105,98,67,108,111,115,101,0,0
#endif

;; native-method palmos/Symbol.ScanMgrLibClose(ILjava/lang/Integer;)I
;; uses-method palmos/Symbol.ScanMgrLibClose(ILpalmos/IntHolder;)I as new_ScanMgrLibClose
;; needs-exact-layout java/lang/Integer
	bra.far	new_ScanMgrLibClose

;; native-method palmos/Symbol.ScanMgrLibClose(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanMgrLibClose
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Symbol.ScanMgrLibClose
	dc.b	83,121,109,98,111,108,46,83,99,97,110,77,103,114,76,105,98,67,108,111,115,101,0,0
#endif

;; native-method palmos/Symbol.ScanMgrLibSleep(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanMgrLibSleep
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22	; Debug Symbol Symbol.ScanMgrLibSleep
	dc.b	83,121,109,98,111,108,46,83,99,97,110,77,103,114,76,105,98,83,108,101,101,112,0,0
#endif

;; native-method palmos/Symbol.ScanMgrLibWake(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanMgrLibWake
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Symbol.ScanMgrLibWake
	dc.b	83,121,109,98,111,108,46,83,99,97,110,77,103,114,76,105,98,87,97,107,101,0
#endif

;; native-method palmos/Symbol.ScanMgrLibGetLibAPIVersion(ILpalmos/IntHolder;)I
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
	dc.w	sysLibTrapScanMgrLibGetLibAPIVersion
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
	dc.b	$80,33	; Debug Symbol Symbol.ScanMgrLibGetLibAPIVersion
	dc.b	83,121,109,98,111,108,46,83,99,97,110,77,103,114,76,105,98,71,101,116,76,105,98,65,80,73,86,101,114,115,105,111,110,0
#endif

;; native-method palmos/Symbol.ScanMgrLibGetLibAPIVersion(ILjava/lang/Integer;)I
;; uses-method palmos/Symbol.ScanMgrLibGetLibAPIVersion(ILpalmos/IntHolder;)I as new_ScanMgrLibGetLibAPIVersion
;; needs-exact-layout java/lang/Integer
	bra.far	new_ScanMgrLibGetLibAPIVersion

;; native-method palmos/Symbol.ScanKernGetDecodedData(II)I
	link	a6,#0
	move.l	8(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetDecodedData
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,29	; Debug Symbol Symbol.ScanKernGetDecodedData
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,68,101,99,111,100,101,100,68,97,116,97,0
#endif

;; native-method palmos/Symbol.ScanKernGetDecodedData(ILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetDecodedData
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
	dc.b	$80,29	; Debug Symbol Symbol.ScanKernGetDecodedData
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,68,101,99,111,100,101,100,68,97,116,97,0
#endif

;; native-method palmos/Symbol.ScanKernCommandSend(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernCommandSend
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Symbol.ScanKernCommandSend
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,67,111,109,109,97,110,100,83,101,110,100,0,0
#endif

;; native-method palmos/Symbol.ScanKernSendParams(II)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernSendParams
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25	; Debug Symbol Symbol.ScanKernSendParams
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,83,101,110,100,80,97,114,97,109,115,0
#endif

;; native-method palmos/Symbol.ScanKernParamPacket(IIIII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernParamPacket
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,26	; Debug Symbol Symbol.ScanKernParamPacket
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,80,97,114,97,109,80,97,99,107,101,116,0,0
#endif

;; native-method palmos/Symbol.ScanSetBarcodeEnable(IIIII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanSetBarcodeEnable
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Symbol.ScanSetBarcodeEnable
	dc.b	83,121,109,98,111,108,46,83,99,97,110,83,101,116,66,97,114,99,111,100,101,69,110,97,98,108,101,0
#endif

;; native-method palmos/Symbol.ScanSetTriggeringModes(IIIII)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	move.w	26(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanSetTriggeringModes
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,29	; Debug Symbol Symbol.ScanSetTriggeringModes
	dc.b	83,121,109,98,111,108,46,83,99,97,110,83,101,116,84,114,105,103,103,101,114,105,110,103,77,111,100,101,115,0
#endif

;; native-method palmos/Symbol.ScanGetExtendedDecodedData(IILpalmos/ShortHolder;[BI)I
;; needs-exact-layout palmos/ShortHolder
	link	a6,#0
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	adda.l	8(a6),a0
	sub.l	8(a6),d0
	proxy.get
	move.l	a0,(a7)
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
	dc.w	sysLibTrapScanGetExtendedDecodedData
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
	dc.b	$80,33	; Debug Symbol Symbol.ScanGetExtendedDecodedData
	dc.b	83,121,109,98,111,108,46,83,99,97,110,71,101,116,69,120,116,101,110,100,101,100,68,101,99,111,100,101,100,68,97,116,97,0
#endif

;; native-method palmos/Symbol.ScanGetExtendedDecodedData(IILjava/lang/Short;[BI)I
;; uses-method palmos/Symbol.ScanGetExtendedDecodedData(IILpalmos/ShortHolder;[BI)I as new_ScanGetExtendedDecodedData
;; needs-exact-layout java/lang/Short
	bra.far	new_ScanGetExtendedDecodedData

;; native-method palmos/Symbol.ScanKernParamRequest(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernParamRequest
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Symbol.ScanKernParamRequest
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,80,97,114,97,109,82,101,113,117,101,115,116,0
#endif

;; native-method palmos/Symbol.ScanGetBarcodeEnabled(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanGetBarcodeEnabled
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Symbol.ScanGetBarcodeEnabled
	dc.b	83,121,109,98,111,108,46,83,99,97,110,71,101,116,66,97,114,99,111,100,101,69,110,97,98,108,101,100,0,0
#endif

;; native-method palmos/Symbol.ScanKernParamRequestMultiple(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernParamRequestMultiple
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,35	; Debug Symbol Symbol.ScanKernParamRequestMultiple
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,80,97,114,97,109,82,101,113,117,101,115,116,77,117,108,116,105,112,108,101,0
#endif

;; native-method palmos/Symbol.ScanKernGetParam(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetParam
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23	; Debug Symbol Symbol.ScanKernGetParam
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,80,97,114,97,109,0
#endif

;; native-method palmos/Symbol.ScanKernParamBatchIsRoom(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernParamBatchIsRoom
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,31	; Debug Symbol Symbol.ScanKernParamBatchIsRoom
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,80,97,114,97,109,66,97,116,99,104,73,115,82,111,111,109,0
#endif

;; native-method palmos/Symbol.ScanKernGetAllParams(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetAllParams
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,27	; Debug Symbol Symbol.ScanKernGetAllParams
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,65,108,108,80,97,114,97,109,115,0
#endif

;; native-method palmos/Symbol.ScanKernCmdLED(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernCmdLED
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,21	; Debug Symbol Symbol.ScanKernCmdLED
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,67,109,100,76,69,68,0
#endif

;; native-method palmos/Symbol.ScanKernBeep(II)I
	link	a6,#0
	move.b	11(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernBeep
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,19	; Debug Symbol Symbol.ScanKernBeep
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,66,101,101,112,0
#endif

;; native-method palmos/Symbol.ScanKernSetBeepParams(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.b	15(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernSetBeepParams
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Symbol.ScanKernSetBeepParams
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,83,101,116,66,101,101,112,80,97,114,97,109,115,0,0
#endif

;; native-method palmos/Symbol.ScanKernGetBeepParams(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetBeepParams
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Symbol.ScanKernGetBeepParams
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,66,101,101,112,80,97,114,97,109,115,0,0
#endif

;; native-method palmos/Symbol.ScanKernDecInitDecoder(ILjava/lang/Object;)I
	link	a6,#0
	move.l	8(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernDecInitDecoder
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
	dc.b	$80,29	; Debug Symbol Symbol.ScanKernDecInitDecoder
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,68,101,99,73,110,105,116,68,101,99,111,100,101,114,0
#endif

;; native-method palmos/Symbol.ScanKernDecInitDecoder(ILpalmos/SymbolComm;)I
;; needs-exact-layout palmos/SymbolComm
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
	dc.w	sysLibTrapScanKernDecInitDecoder
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
	dc.b	$80,29	; Debug Symbol Symbol.ScanKernDecInitDecoder
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,68,101,99,73,110,105,116,68,101,99,111,100,101,114,0
#endif

;; native-method palmos/Symbol.ScanKernDecKillDecoder(I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernDecKillDecoder
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,29	; Debug Symbol Symbol.ScanKernDecKillDecoder
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,68,101,99,75,105,108,108,68,101,99,111,100,101,114,0
#endif

;; native-method palmos/Symbol.ScanKernSetLocalParam(III)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	move.w	18(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernSetLocalParam
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Symbol.ScanKernSetLocalParam
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,83,101,116,76,111,99,97,108,80,97,114,97,109,0,0
#endif

;; native-method palmos/Symbol.ScanKernGetLocalParam(II)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.w	14(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetLocalParam
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,28	; Debug Symbol Symbol.ScanKernGetLocalParam
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,76,111,99,97,108,80,97,114,97,109,0,0
#endif

;; native-method palmos/Symbol.ScanKernGetVersionString(IILjava/lang/StringBuffer;I)I
	link	a6,#0
	move.w	10(a6),-(a7)
	move.l	12(a6),-(a7)
	bsr.far	getvoidptr
	proxy.get
	move.l	a0,(a7)
	move.w	18(a6),-(a7)
	move.w	22(a6),-(a7)
	mem.release
	trap	#15
	dc.w	sysLibTrapScanKernGetVersionString
	mem.reserve.savereg
	ext.l	d0
	move.l	d0,-(a7)
#ifdef DM_HEAP
	move.l	-6(a6),a0
	proxy.release
#endif
	move.l	12(a6),a1
	bsr.far	StringBuffer_setLength
	move.l	(a7)+,d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,31	; Debug Symbol Symbol.ScanKernGetVersionString
	dc.b	83,121,109,98,111,108,46,83,99,97,110,75,101,114,110,71,101,116,86,101,114,115,105,111,110,83,116,114,105,110,103,0
#endif

;; native-method palmos/Symbol.ScanGetPrefixSuffixValue(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
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
	dc.w	sysLibTrapScanGetPrefixSuffixValue
	mem.reserve.savereg
	ext.l	d0
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,31	; Debug Symbol Symbol.ScanGetPrefixSuffixValue
	dc.b	83,121,109,98,111,108,46,83,99,97,110,71,101,116,80,114,101,102,105,120,83,117,102,102,105,120,86,97,108,117,101,0
#endif

