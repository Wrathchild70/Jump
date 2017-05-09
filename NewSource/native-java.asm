; Java native routines needed for Jump2

;; empty-method *.registerNatives()V
	rts

;; empty-method *.initNative()V
	rts

;; empty-method java/lang/SecurityManager.*
	rts

;; empty-method java/security/AccessController.*
	rts

;; native-method java/lang/Class.desiredAssertionStatus()Z
    moveq.l #0,d0
    rts

;; native-method java/lang/Class.getName()Ljava/lang/String;
    move.l  4(a7),a0
    clr.l   d0      ; not sign extend
    move.w  ClassInfo.Name-ClassHeader_sizeof(a0),d0
    move.l	SegStart1(a5),a0
    add.l   d0,a0
    bsr.far	CharPtr_to_String
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'Class.getName',0
	align	2
#endif

;; native-method java/lang/Object.toString()Ljava/lang/String;
;; uses-class java/lang/StringBuffer as _SB_class
;; uses-method java/lang/StringBuffer.<init>()V as _SB_init
;; uses-method java/lang/Class.getClass()Ljava/lang/Class; as _Class_getClass
;; uses-method java/lang/Class.getName()Ljava/lang/String; as _Class_getName
;; uses-method java/lang/StringBuffer.append(Ljava/lang/String;)Ljava/lang/StringBuffer; as _SB_appendString
;; uses-method java/lang/StringBuffer.append(C)Ljava/lang/StringBuffer; as _SB_appendChar
;; uses-method java/lang/Integer.toHexString(I)Ljava/lang/String; as _I_toHexString
;; uses-method java/lang/StringBuffer.toString()Ljava/lang/String; as _SB_toString
;; uses-method java/lang/Integer.<clinit>()V as _I_clinit
#ifdef DYNAMIC_CLINIT
    bsr.far _I_clinit
#endif
	link	a6,#0
	move.l	#_SB_class,d0	; Class java/lang/StringBuffer
	bsr.far op_new
	move.l	(a7),-(a7)
	bsr.far _SB_init
	move.l	8(a6),(a7)
	bsr.far _Class_getClass
	move.l	a0,(a7)
	bsr.far _Class_getName
	move.l	a0,(a7)
	bsr.far _SB_appendString
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	#'@',d0
	move.l	d0,-(a7)
	move.l	4(a7),a0
	bsr.far _SB_appendChar
	addq.l	#8,a7
	move.l	a0,-(a7)
	move.l	8(a6),-(a7)
	bsr.far _I_toHexString
	move.l	a0,(a7)
	move.l	4(a7),a0
	bsr.far _SB_appendString
	addq.l	#8,a7
	move.l	a0,-(a7)
	bsr.far _SB_toString
	unlk	a6
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15,'Object.toString',0
	align	2
#endif

;; native-method java/lang/Class.forName(Ljava/lang/String;)Ljava/lang/Class;
;; uses-class java/lang/ClassNotFoundException as _CNFE_class
;; uses-instance java/lang/ClassNotFoundException
;; uses-method java/lang/ClassNotFoundException.<init>(Ljava/lang/String;)V as _CNFE_init
    move.l  4(a7),a0    ; string
    bsr.far StringToChars
    move.l  a0,a1   ; a1 = target name
    move.l  d0,d1   ; length+1
    clr.l   d0
    bsr.far getclassinfo    ; a0 = first class
    move.w  #ClassCount,d0  ; number of classes
    movem.l d3/a2-a3,-(a7)
    bra.s   class_forName_enter
class_forName_loop
    clr.l   d3  ; not sign extend
    move.w  ClassInfo.Name(a0),d3
    move.l	SegStart1(a5),a2
    add.l   d3,a2
    move.l  a1,a3
    move.w  d1,d2
    subq.w  #1,d2
    ; compare strings
class_forName_cloop
    move.b  (a2)+,d3
    cmp.b   (a3)+,d3
class_forName_center
    dbne    d2,class_forName_cloop
    beq.s   class_forName_found
    lea.l   ClassInfo_size(a0),a0
class_forName_enter
    dbra    d0,class_forName_loop
    ; throw ClassNotFoundException
	move.w	#_CNFE_class,d0
	bsr.far	op_new
	move.l  20(a7),-(a7)    ; class name
	bsr.far	_CNFE_init
	add	    #4,a7    ; remove parm
	move.l	(a7)+,a0
	movem.l	(a7)+,d3/a2-a3
	move.l	(a7)+,a1
	bra.far	do_athrow
class_forName_found
    movem.l (a7)+,d3/a2-a3
    addq.l  #ClassHeader_sizeof,a0
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'Class.forName',0
	align	2
#endif

;; native-method java/lang/Class.newInstance()Ljava/lang/Object;
;; uses-class java/lang/InstantiationException as _IE_class
;; uses-instance java/lang/InstantiationException
;; uses-method java/lang/InstantiationException.<init>()V as _IE_init
    move.l  4(a7),a0
    tst.w   ClassInfo.DefaultCtor-ClassHeader_sizeof(a0)
    beq.s   class_newInstance_fail
    move.b  ClassInfo.Flags-ClassHeader_sizeof(a0),d0
    and.b   #ClassInfo_array+ClassInfo_arrayofobjects+ClassInfo_primitive+ClassInfo_interface,d0
    beq.s   class_newInstance_ok
class_newInstance_fail
    ; throw InstantiationException
	move.w	#_IE_class,d0
	bsr.far	op_new
	bsr.far	_IE_init
	move.l	(a7)+,a0
	move.l	(a7)+,a1
	bra.far	do_athrow
class_newInstance_ok
    clr.l   d0
    bsr.far getclassinfo
    move.l  4(a7),d0
    sub.l   a0,d0
    divu    #ClassInfo_size,d0  ; convert ptr diff to class index
    bsr.far op_new
    move.l  (a7),a0
    bsr.far getclassinfo_a0
    ; call the default constructor
#ifdef MULTI_SEGMENT
    move.w  ClassInfo.DefaultCtor(a0),d0
    jsr     0(a5,d0.w)
#else
    clr.l   d0
    move.w  ClassInfo.DefaultCtor(a0),d0
    move.l  Segment1(a5),a0
    jsr     0(pc,d0.l)
#endif
    move.l  (a7)+,a0
    ; now we need to call init but don't know how to do that yet.
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17,'Class.newInstance',0
	align	2
#endif

;; native-method java/lang/Object.clone()Ljava/lang/Object;
;; uses-cast-target java/lang/Cloneable as Cloneable_iti
;; uses-class java/lang/CloneNotSupportedException as _CNSE_class
;; uses-instance java/lang/CloneNotSupportedException
;; uses-method java/lang/CloneNotSupportedException.<init>()V as _CNSE_init
;; uses-class java/lang/OutOfMemoryError as _OOME_class
;; uses-instance java/lang/OutOfMemoryError
;; uses-method java/lang/OutOfMemoryError.<init>()V as _OOME_init
	movem.l	d3/a2-a3,-(a7)
	move.l	16(a7),a2	; a2 = orig object
	move.l	a2,a0
	bsr.far	getclassinfo_a0
iti_offset	set	Cloneable_iti>>3
iti_bitno	set	Cloneable_iti&7
	btst	#iti_bitno,ClassInfo.Itable+iti_offset(a0)
	bne.s	object_clone_doit
	move.w	#_CNSE_class,d0
	bsr.far	op_new
	bsr.far	_CNSE_init
	move.l	(a7)+,a0
	movem.l	(a7)+,d3/a2-a3
	move.l	(a7)+,a1
	bra.far	do_athrow
object_clone_doit
	move.w	ClassInfo.ObjectSizePlusHeader(a0),d3
#ifdef OLD_HEAP
	subq.w	#ObjectHeader_sizeof,d3		; d3.w = size of object
#endif
	move.b	ClassInfo.Flags(a0),d0		; some sort of array?
	and.b	#ClassInfo_array+ClassInfo_arrayofobjects,d0
	bne.s	object_clone_array
	move.w	ObjectHeader_ClassIndex(a2),d0
	bsr.far	op_new
	move.l	(a7)+,a3	; a3 = clone
	move.l	a2,a1
	move.l	a3,a0
	move.w	d3,d0
	bsr.far	memcopy
	move.l	a3,a0
	bra.s	object_clone_out
object_clone_array
	move.w	ObjectHeader_ClassIndex(a2),d0
	bsr.far	op_new
	move.l	(a7)+,a3	; a3 = clone
	move.l	a2,a1
	move.l	a3,a0
	move.w	d3,d0
	bsr.far	memcopy
	move.w	Array.length(a3),d0
	mulu.w	Array.elsize(a3),d0
	move.l	d0,d3		; d3 = rawData size in bytes
	bsr.far	allocRawMem
	cmp.w	#0,a0
	bne.s	object_clone_gotMem
	movem.l	(a7)+,d3/a2-a3
	bra.far	throw_OutOfMemoryError
object_clone_gotMem
	move.w	d3,d0
	move.l	Array.data(a2),a1
	move.l  a0,Array.data(a3)   ; point new array at its data
	bsr.far memcopy
	move.l	a3,a0
object_clone_out
	movem.l	(a7)+,d3/a2-a3
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,12,'Object.clone',0
	align	2
#endif

;; native-method java/lang/Throwable.getMethodName(I)Ljava/lang/String;
	move.l  4(a7),a0
	bsr.far getMethodName
	bsr.far	CharPtr_to_String
	rts

;; native-method java/lang/Class.isInterface()Z
	move.l	4(a7),a0
    clr.l   d0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_interface,d0
	sne.b	d0
	neg.b	d0
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17,'Class.isInterface',0
	align	2
#endif

;; native-method java/lang/Class.isPrimitive()Z
	move.l	4(a7),a0
    clr.l   d0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_primitive,d0
	sne.b	d0
	neg.b	d0
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,17,'Class.isPrimative',0
	align	2
#endif

;; native-method java/lang/Class.isArray()Z
	move.l	4(a7),a0
    clr.l   d0
	move.b	ClassInfo.Flags(a0),d0
	and.b	#ClassInfo_array+ClassInfo_arrayofobjects,d0
	sne.b	d0
	neg.b	d0
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,13,'Class.isArray',0
	align	2
#endif

;; native-method java/lang/Class.getPrimitiveClass(Ljava/lang/String;)Ljava/lang/Class;
	clr.l   d0
	move.l	d0,a0
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23,'Class.getPrimitiveClass',0
	align	2
#endif

;; native-method java/lang/Object.getClass()Ljava/lang/Class;
;; uses-instance java/lang/Class
	move.l	4(a7),a0
	bsr.far	getclassinfo_a0
    addq.l	#ClassHeader_sizeof,a0
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,15,'Object.getClass',0
	align	2
#endif

;; native-method java/lang/Object.hashCode()I
        move.l  4(a7),d0
        rts

;; native-method java/lang/Float.floatToIntBits(F)I
	move.l	4(a7),d0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20,'Float.floatToIntBits',0
	align	2
#endif

;; native-method java/lang/Float.intBitsToFloat(I)F
	move.l	4(a7),d0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,20,'Float.intBitsToFloat',0
	align	2
#endif

;; native-method java/lang/Double.doubleToLongBits(D)J
	move.l	4(a7),d0
	move.l	8(a7),d1
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23,'Double.doubleToLongBits',0
	align	2
#endif

;; native-method java/lang/Double.longBitsToDouble(J)D
	move.l	4(a7),d0
	move.l	8(a7),d1
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23,'Double.longBitsToDouble',0
	align	2
#endif

;; native-method java/lang/Math.abs(D)D
	move.l	4(a7),d0
	move.l	8(a7),d1
	bclr.l	#31,d0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,8,'Math.abs',0
	align	2
#endif

;; native-method java/lang/Math.abs(I)I
	move.l	4(a7),d0
	bpl.s	absI_1
	neg.l	d0
absI_1
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,8,'Math.abs',0
	align	2
#endif

;; native-method java/lang/Math.abs(F)F
	move.l	4(a7),d0
	bclr.l	#31,d0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,8,'Math.abs',0
	align	2
#endif

;; native-method java/lang/Runtime.gc()V
	bra.far	garbage

;; native-method java/lang/Runtime.freeMemory()J
    link    a6,#-8
    clr.l   d1
#ifdef DM_HEAP
    sysTrap MemCardInfo(d1.w,d1.l,d1.l,d1.l,d1.l,d1.l,d1.l,&-8(a6).l)
#else
    sysTrap MemHeapFreeBytes(d1.w,&-8(a6).l,&-4(a6).l)
#endif
    move.l  (a7),d1
    clr.l   d0
    unlk    a6
    rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,18,'Runtime.freeMemory',0
	align	2
#endif

;; native-method java/lang/System.arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
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
        ; overlapping arrays fixed PMD 6 Dec 2001
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
#ifdef DEBUG_SYMBOLS
	dc.b	$80,16,'System.arraycopy',0
	align	2
#endif

;; native-method java/lang/Throwable.fillInStackTrace()Ljava/lang/Throwable;
    move.l  4(a7),a0    ; return this
    rts
    
;; empty-method java/lang/Throwable.<init>()V
     rts

;; native-method java/lang/Boolean.getPrimitiveClass()Ljava/lang/Class;
;; uses-class -Z- as _class_boolean
	move.w	#_class_boolean,d0
	bsr.far	getclassinfo
	addq.l	#ClassHeader_sizeof,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25,'Boolean.getPrimitiveClass',0
	align	2
#endif

;; native-method java/lang/Byte.getPrimitiveClass()Ljava/lang/Class;
;; uses-class -B- as _class_byte
	move.w	#_class_byte,d0
	bsr.far	getclassinfo
	addq.l	#ClassHeader_sizeof,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22,'Byte.getPrimitiveClass',0
	align	2
#endif

;; native-method java/lang/Short.getPrimitiveClass()Ljava/lang/Class;
;; uses-class -S- as _class_short
	move.w	#_class_short,d0
	bsr.far	getclassinfo
	addq.l	#ClassHeader_sizeof,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,23,'Short.getPrimitiveClass',0
	align	2
#endif

;; native-method java/lang/Integer.getPrimitiveClass()Ljava/lang/Class;
;; uses-class -I- as _class_integer
	move.w	#_class_integer,d0
	bsr.far	getclassinfo
	addq.l	#ClassHeader_sizeof,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,25,'Integer.getPrimitiveClass',0
	align	2
#endif

;; native-method java/lang/Long.getPrimitiveClass()Ljava/lang/Class;
;; uses-class -J- as _class_long
	move.w	#_class_long,d0
	bsr.far	getclassinfo
	addq.l	#ClassHeader_sizeof,a0
	rts
#ifdef DEBUG_SYMBOLS
	dc.b	$80,22,'Long.getPrimitiveClass',0
	align	2
#endif

