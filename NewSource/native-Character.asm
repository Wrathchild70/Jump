;;; 
;;; replacements for character-related java methods
;;; -----------------------------------------------

;; native-method java/lang/Integer.toString(I)Ljava/lang/String;
	move.l	4(a7),d0
	;; PalmOS doesn't like the Integer.MIN_VALUE of 0x80000000 
	cmp.l	#$80000000,d0
	beq.s	integer_toString_0
	move.l	d0,-(a7)
	pea	integer_toString_buffer(a5)
	mem.release
	trap	#15
	dc.w	sysTrapStrIToA
	mem.reserve
	addq.l	#8,a7
	lea.l	integer_toString_buffer(a5),a0
	bra.s	integer_toString_1
integer_toString_0
	lea	integer_toString_minbuf(pc),a0
integer_toString_1
	bsr.far	CharPtr_to_String
	rts
integer_toString_minbuf
	dc.b	'-2147483648',0
	align	2
	data
integer_toString_buffer:
	ds.b	20
	enddata

;; native-method java/lang/String.valueOf(I)Ljava/lang/String;
;; uses-method java/lang/Integer.toString(I)Ljava/lang/String; as _Integer_toString
;; uses-method java/lang/Integer.<clinit>()V as _Integer_clinit
#ifdef DYNAMIC_CLINIT
    bsr.far _Integer_clinit
#endif
	bra.far	_Integer_toString

;; native-method java/lang/String.valueOf(D)Ljava/lang/String;
;; uses-method java/lang/Double.toString(D)Ljava/lang/String; as _Double_toString
;; uses-method java/lang/Double.<clinit>()V as _Double_clinit
#ifdef DYNAMIC_CLINIT
    bsr.far _Double_clinit
#endif
	bra.far	_Double_toString

;; native-method java/lang/String.valueOf(J)Ljava/lang/String;
;; uses-method java/lang/Long.toString(J)Ljava/lang/String; as _Long_toString
;; uses-method java/lang/Long.<clinit>()V as _Long_clinit
#ifdef DYNAMIC_CLINIT
    bsr.far _Long_clinit
#endif
	bra.far	_Long_toString

;; native-method java/lang/String.valueOf(F)Ljava/lang/String;
;; uses-method java/lang/Float.toString(F)Ljava/lang/String; as _Float_toString
;; uses-method java/lang/Float.<clinit>()V as _Float_clinit
#ifdef DYNAMIC_CLINIT
    bsr.far _Float_clinit
#endif
	bra.far	_Float_toString

;; native-method java/lang/String.hashCode()I
;; uses-field java/lang/String.count as String_count
;; uses-field java/lang/String.offset as String_offset
;; uses-field java/lang/String.value as String_value
    move.l  4(a7),a1                ; string
    move.l  String_count(a1),d1     ; count
    move.l  String_value(a1),a0     ; array
    move.l  Array.data(a0),a0       ; point to actual data
    add.l   String_offset(a1),a0    ; adjust pointer into data
    clr.l   d0
    bra.s   String_hashCode_1
String_hashCode_0
    move.l  d0,d2
    asl.l   #5,d2
    sub.l   d0,d2       ; multiply by #31
    clr.l   d0
    move.b  (a0)+,d0
    add.l   d2,d0
String_hashCode_1
    dbra    d1,String_hashCode_0
    rts

;; native-method java/lang/String.compareTo(Ljava/lang/String;)I
;; uses-field java/lang/String.count as String_count
;; uses-field java/lang/String.offset as String_offset
;; uses-field java/lang/String.value as String_value
    move.l  4(a7),a0                ; other string
    bsr.far nonnull_check
    move.l  String_count(a0),d2
    move.l  String_value(a0),a1     ; array
    move.l  Array.data(a1),a1       ; point to actual data
    add.l   String_offset(a0),a1    ; adjust pointer into data
    move.l  8(a7),a0                ; this pointer
    move.l  String_count(a0),d1
    move.l  String_offset(a0),d0
    move.l  String_value(a0),a0
    move.l  Array.data(a0),a0
    add.l   d0,a0                   ; a0,a1 data ptrs, d1, d2 counts
    sub.l   d2,d1
    bpl.s   String_compareTo_0
    sub.l   d1,d2                   ; compare for min
String_compareTo_0
    clr.l   d0
    bra.s   String_compareTo_2
String_compareTo_1
    move.b  (a0)+,d0
    cmp.b   (a1)+,d0
String_compareTo_2
    dbne    d2,String_compareTo_1
    beq.s   String_compareTo_3      ; return
    clr.l   d1
    move.b  -(a1),d1
    sub.l   d1,d0
    rts
String_compareTo_3
    move.l  d1,d0
    rts

;; native-method java/lang/String.regionMatches(ILjava/lang/String;II)Z
;; uses-field java/lang/String.count as String_count
;; uses-field java/lang/String.offset as String_offset
;; uses-field java/lang/String.value as String_value
    move.l  16(a7),d0   ; toffset
    bmi.s   String_regionMatches_false
    move.l  8(a7),d1    ; ooffset
    bmi.s   String_regionMatches_false
    move.l  20(a7),a1   ; this
    add.l   4(a7),d0    ; len
    cmp.l   String_count(a1),d0
    bgt.s   String_regionMatches_false
    move.l  12(a7),a0   ; other
    bsr.far nonnull_check   ; other != null
    add.l   4(a7),d1    ; len
    cmp.l   String_count(a0),d1
    bgt.s   String_regionMatches_false
    move.l  String_offset(a1),d0
    move.l  String_value(a1),a1
    move.l  Array.data(a1),a1
    add.l   d0,a1
    add.l   16(a7),a1   ; this.value.data+this.offset+toffset
    move.l  String_offset(a0),d1
    move.l  String_value(a0),a0
    move.l  Array.data(a0),a0
    add.l   d1,a0
    add.l   8(a7),a0    ; other.value.data+other.offset+ooffset
    move.l  4(a7),d0    ; len
    clr.w   d1          ; set Z flag
    bra.s   String_regionMatches_1
String_regionMatches_0
    move.b  (a0)+,d1
    cmp.b   (a1)+,d1
String_regionMatches_1
    dbne    d0,String_regionMatches_0
    bne.s   String_regionMatches_false
    moveq.l #1,d0
    rts
String_regionMatches_false
    moveq.l #0,d0
    rts

;; empty-method java/lang/Character.<clinit>()V
	rts

;; native-method java/lang/Character.getPrimitiveClass()Ljava/lang/Class;
;; uses-class -C- as _class_Char
	move.w	#_class_Char,d0
	bsr.far	getclassinfo
	addq.l	#ClassHeader_sizeof,a0
	rts

;; native-method java/lang/Character.getType(C)I
	move.w	6(a7),d1
	cmp.w	#$100,d1
	bcc.s	character_getType_no
	lea	character_getType_table(pc),a0
	clr.l	d0
	move.b	0(a0,d1.w),d0
	rts
character_getType_no
	clr.l	d0
	rts
character_getType_table
	dc.b	15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	dc.b	15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	dc.b	12,24,24,24,26,24,24,24,21,22,24,25,24,20,24,24
	dc.b	9,9,9,9,9,9,9,9,9,9,24,24,25,25,25,24
	dc.b	24,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	dc.b	1,1,1,1,1,1,1,1,1,1,1,21,24,22,27,23
	dc.b	27,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	dc.b	2,2,2,2,2,2,2,2,2,2,2,21,25,22,25,15
	dc.b	15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	dc.b	15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	dc.b	12,24,26,26,26,26,28,28,27,28,2,21,25,20,28,27
	dc.b	28,25,11,11,27,2,28,24,27,11,2,22,11,11,11,24
	dc.b	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	dc.b	1,1,1,1,1,1,1,25,1,1,1,1,1,1,1,2
	dc.b	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	dc.b	2,2,2,2,2,2,2,25,2,2,2,2,2,2,2,2

;; native-method java/lang/Character.digit(CI)I
	move.l	8(a7),d0
	cmp.w	#$30,d0
	bcs	character_digit_no
	cmp.w	#$3a,d0
	bcs	character_digit_numeric
	cmp.w	#$41,d0
	bcs	character_digit_no
	cmp.w	#$5b,d0
	bcs	character_digit_uppercase
	cmp.w	#$61,d0
	bcs	character_digit_no
	cmp.w	#$7b,d0
	bcs	character_digit_lowercase
character_digit_no:
	moveq.l	#-1,d0
	rts
character_digit_numeric:
	sub.w	#$30,d0
	cmp.w	6(a7),d0
	bcc	character_digit_no
	rts
character_digit_uppercase:
	sub.w	#$37,d0
	cmp.w	6(a7),d0
	bcc	character_digit_no
	rts
character_digit_lowercase:
	sub.w	#$57,d0
	cmp.w	6(a7),d0
	bcc	character_digit_no
	rts

;; native-method java/lang/Character.forDigit(II)C
	move.w	10(a7),d0
	cmp.w	6(a7),d0
	bcc	character_for_digit_no
	add.w	#$30,d0
	cmp.w	#$3a,d0
	bcs	character_for_digit_out
	addq.w	#$26,d0
character_for_digit_out:
	rts
character_for_digit_no:
	clr.l	d0
	rts

;; native-method java/lang/Character.getNumericValue(C)I
	clr.l	d0
	move.w	6(a7),d0
	cmp.w	#$30,d0
	bcs.s	character_getNumericValue_no
	cmp.w	#$3a,d0
	bcc.s	character_getNumericValue_no
	sub.w	#$30,d0
	bra.s	character_getNumericValue_out
character_getNumericValue_no
	moveq.l	#-1,d0
character_getNumericValue_out
	rts

;; native-method java/lang/Character.toLowerCase(C)C
	move.l	4(a7),d0
	cmp.w	#$41,d0
	bcc	character_to_lower_case_1
	rts
character_to_lower_case_1:
	cmp.w	#$5b,d0
	bcc	character_to_lower_case_2
	add.w	#$20,d0
	rts
character_to_lower_case_2:
	cmp.w	#$c0,d0
	bcc	character_to_lower_case_3
	rts
character_to_lower_case_3:
	cmp.w	#$d7,d0
	bcc	character_to_lower_case_4
	add.w	#$20,d0
	rts
character_to_lower_case_4:
	cmp.w	#$d8,d0
	bcc	character_to_lower_case_5
	rts
character_to_lower_case_5:
	cmp.w	#$df,d0
	bcc	character_to_lower_case_6
	add.w	#$20,d0
	rts
character_to_lower_case_6:
	rts

;; native-method java/lang/Character.toUpperCase(C)C
	move.l	4(a7),d0
	cmp.w	#$61,d0
	bcc	character_to_upper_case_1
	rts
character_to_upper_case_1:
	cmp.w	#$7b,d0
	bcc	character_to_upper_case_2
	sub.w	#$20,d0
	rts
character_to_upper_case_2:
	cmp.w	#$e0,d0
	bcc	character_to_upper_case_3
	rts
character_to_upper_case_3:
	cmp.w	#$f7,d0
	bcc	character_to_upper_case_4
	sub.w	#$20,d0
	rts
character_to_upper_case_4:
	cmp.w	#$f8,d0
	bcc	character_to_upper_case_5
	rts
character_to_upper_case_5:
	cmp.w	#$ff,d0
	bcc	character_to_upper_case_6
	sub.w	#$20,d0
	rts
character_to_upper_case_6:
	rts

;; native-method java/lang/String._fillInternTable()V
;; uses-method java/lang/String.intern()Ljava/lang/String; as _String_intern
	movem.l	d3/a2,-(a7)
#ifdef MULTI_SEGMENT
    move.l  ICSdata(a5),a2
#else
	lea.l	CS0(a5),a2
#endif
	move.w	#CS_NUM,d3
	bra.s	string_fillInternTable_end
string_fillInternTable_loop
	move.l	a2,-(a7)
	bsr.far	_String_intern
	addq.l	#4,a7
	lea.l	CS_SIZE(a2),a2
string_fillInternTable_end
	dbra	d3,string_fillInternTable_loop
	movem.l	(a7)+,d3/a2
	rts
