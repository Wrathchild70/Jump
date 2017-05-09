| from Startup.inc by Darrin Massena (darrin@massena.com) 17 Jul 96
| modified for GCC 25 July 2003 by P.M.Dickerson
    .text
    .even
	.globl start
start:
__Startup__:
    trap    #8
    link	%a6,#-12
	pea     -12(%a6)
	pea	    -8(%a6)
	pea     -4(%a6)
	trap	#15
	dc.w	sysTrapSysAppStartup
	lea     12(%sp),%sp
    tst.w   %d0
    beq.s   _SU1
	move.b	#sndError,-(%sp)
	trap	#15
	dc.w	sysTrapSndPlaySystemSound
	addq.l	#2,%sp
    moveq   #-1,%d0
    bra.s   _SUExit
_SU1:
    movea.l -4(%a6),%a0
	move.w	6(%a0),-(%sp)
	move.l	2(%a0),-(%sp)
	move.w	(%a0),-(%sp)
	jsr	PilotMain1(%pc)
	addq.l	#8,%a7
	move.l	-12(%a6),-(%sp)
	move.l	-8(%a6),-(%sp)
	move.l	-4(%a6),-(%sp)
	trap	#15
	dc.w	sysTrapSysAppExit
	lea	12(%sp),%sp
    moveq   #0,%d0
_SUExit:
    unlk	%a6
	rts
	
    .data
    ds.l    1       | loader stores SysAppInfoPtr here
    
    .text
    