;;; 
;;; native method for CharPtrArray.java
;;; -----------------------------------------------

;; native-method palmos/CharPtrArray.makeCArray()V
;; needs-exact-layout palmos/CharPtrArray
;; uses-field palmos/CharPtrArray.cArray as cArray
;; uses-field palmos/CharPtrArray.dummyArray as dummyArray
;; uses-field palmos/CharPtrArray.texts as texts
	movem.l	d3/a2-a3,-(a7)
	move.l	16(a7),a1	; CharPtrArray instance
	move.l	texts(a1),a3
	clr.l	d3
	move.w	Array.length(a3),d3
	move.l	Array.data(a3),a3
	move.l	dummyArray(a1),a0 ; int[] array as a placeholder
	move.l	Array.data(a0),a2
	move.l	a2,cArray(a1)
	subq.l	#1,d3
makeCArray_Loop
	move.l	(a3)+,a0	; get Java String
	bsr.far	StringToChars	; convert to C-type char*
	move.l	a0,(a2)+	; write to C-style array
	dbra	d3,makeCArray_Loop
	movem.l	(a7)+,d3/a2-a3
	rts
