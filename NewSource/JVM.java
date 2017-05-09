/*
    Jump - Java post-compiler for PalmPilot
    Copyright (C) 1996,97  Greg Hewgill <gregh@lightspeed.net>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
    This file has been modified in 03/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;

interface JVM {
  static final int ACC_PUBLIC       = 0x0001; // Class, Method, Variable
  static final int ACC_PRIVATE      = 0x0002; // Method, Variable
  static final int ACC_PROTECTED    = 0x0004; // Method, Variable
  static final int ACC_STATIC       = 0x0008; // Method, Variable
  static final int ACC_FINAL        = 0x0010; // Class, Method, Variable
  static final int ACC_SYNCHRONIZED = 0x0020; // Method
  static final int ACC_SUPER        = 0x0020; // Class
  static final int ACC_VOLATILE     = 0x0040; // Variable
  static final int ACC_TRANSIENT    = 0x0080; // Variable
  static final int ACC_NATIVE       = 0x0100; // Method
  static final int ACC_INTERFACE    = 0x0200; // Class
  static final int ACC_ABSTRACT     = 0x0400; // Class, Method

  static final int CONSTANT_Class              = 7;
  static final int CONSTANT_Fieldref           = 9;
  static final int CONSTANT_Methodref          = 10;
  static final int CONSTANT_InterfaceMethodref = 11;
  static final int CONSTANT_String             = 8;
  static final int CONSTANT_Integer            = 3;
  static final int CONSTANT_Float              = 4;
  static final int CONSTANT_Long               = 5;
  static final int CONSTANT_Double             = 6;
  static final int CONSTANT_NameAndType        = 12;
  static final int CONSTANT_Utf8               = 1;
  static final int CONSTANT_Unicode            = 2;

  static final int op_nop              = 0;
  static final int op_aconst_null      = 1;
  static final int op_iconst_m1        = 2;
  static final int op_iconst_0         = 3;
  static final int op_iconst_1         = 4;
  static final int op_iconst_2         = 5;
  static final int op_iconst_3         = 6;
  static final int op_iconst_4         = 7;
  static final int op_iconst_5         = 8;
  static final int op_lconst_0         = 9;
  static final int op_lconst_1         = 10;
  static final int op_fconst_0         = 11;
  static final int op_fconst_1         = 12;
  static final int op_fconst_2         = 13;
  static final int op_dconst_0         = 14;
  static final int op_dconst_1         = 15;
  static final int op_bipush           = 16;
  static final int op_sipush           = 17;
  static final int op_ldc              = 18;
  static final int op_ldc_w            = 19;
  static final int op_ldc2_w           = 20;
  static final int op_iload            = 21;
  static final int op_lload            = 22;
  static final int op_fload            = 23;
  static final int op_dload            = 24;
  static final int op_aload            = 25;
  static final int op_iload_0          = 26;
  static final int op_iload_1          = 27;
  static final int op_iload_2          = 28;
  static final int op_iload_3          = 29;
  static final int op_lload_0          = 30;
  static final int op_lload_1          = 31;
  static final int op_lload_2          = 32;
  static final int op_lload_3          = 33;
  static final int op_fload_0          = 34;
  static final int op_fload_1          = 35;
  static final int op_fload_2          = 36;
  static final int op_fload_3          = 37;
  static final int op_dload_0          = 38;
  static final int op_dload_1          = 39;
  static final int op_dload_2          = 40;
  static final int op_dload_3          = 41;
  static final int op_aload_0          = 42;
  static final int op_aload_1          = 43;
  static final int op_aload_2          = 44;
  static final int op_aload_3          = 45;
  static final int op_iaload           = 46;
  static final int op_laload           = 47;
  static final int op_faload           = 48;
  static final int op_daload           = 49;
  static final int op_aaload           = 50;
  static final int op_baload           = 51;
  static final int op_caload           = 52;
  static final int op_saload           = 53;
  static final int op_istore           = 54;
  static final int op_lstore           = 55;
  static final int op_fstore           = 56;
  static final int op_dstore           = 57;
  static final int op_astore           = 58;
  static final int op_istore_0         = 59;
  static final int op_istore_1         = 60;
  static final int op_istore_2         = 61;
  static final int op_istore_3         = 62;
  static final int op_lstore_0         = 63;
  static final int op_lstore_1         = 64;
  static final int op_lstore_2         = 65;
  static final int op_lstore_3         = 66;
  static final int op_fstore_0         = 67;
  static final int op_fstore_1         = 68;
  static final int op_fstore_2         = 69;
  static final int op_fstore_3         = 70;
  static final int op_dstore_0         = 71;
  static final int op_dstore_1         = 72;
  static final int op_dstore_2         = 73;
  static final int op_dstore_3         = 74;
  static final int op_astore_0         = 75;
  static final int op_astore_1         = 76;
  static final int op_astore_2         = 77;
  static final int op_astore_3         = 78;
  static final int op_iastore          = 79;
  static final int op_lastore          = 80;
  static final int op_fastore          = 81;
  static final int op_dastore          = 82;
  static final int op_aastore          = 83;
  static final int op_bastore          = 84;
  static final int op_castore          = 85;
  static final int op_sastore          = 86;
  static final int op_pop              = 87;
  static final int op_pop2             = 88;
  static final int op_dup              = 89;
  static final int op_dup_x1           = 90;
  static final int op_dup_x2           = 91;
  static final int op_dup2             = 92;
  static final int op_dup2_x1          = 93;
  static final int op_dup2_x2          = 94;
  static final int op_swap             = 95;
  static final int op_iadd             = 96;
  static final int op_ladd             = 97;
  static final int op_fadd             = 98;
  static final int op_dadd             = 99;
  static final int op_isub             = 100;
  static final int op_lsub             = 101;
  static final int op_fsub             = 102;
  static final int op_dsub             = 103;
  static final int op_imul             = 104;
  static final int op_lmul             = 105;
  static final int op_fmul             = 106;
  static final int op_dmul             = 107;
  static final int op_idiv             = 108;
  static final int op_ldiv             = 109;
  static final int op_fdiv             = 110;
  static final int op_ddiv             = 111;
  static final int op_irem             = 112;
  static final int op_lrem             = 113;
  static final int op_frem             = 114;
  static final int op_drem             = 115;
  static final int op_ineg             = 116;
  static final int op_lneg             = 117;
  static final int op_fneg             = 118;
  static final int op_dneg             = 119;
  static final int op_ishl             = 120;
  static final int op_lshl             = 121;
  static final int op_ishr             = 122;
  static final int op_lshr             = 123;
  static final int op_iushr            = 124;
  static final int op_lushr            = 125;
  static final int op_iand             = 126;
  static final int op_land             = 127;
  static final int op_ior              = 128;
  static final int op_lor              = 129;
  static final int op_ixor             = 130;
  static final int op_lxor             = 131;
  static final int op_iinc             = 132;
  static final int op_i2l              = 133;
  static final int op_i2f              = 134;
  static final int op_i2d              = 135;
  static final int op_l2i              = 136;
  static final int op_l2f              = 137;
  static final int op_l2d              = 138;
  static final int op_f2i              = 139;
  static final int op_f2l              = 140;
  static final int op_f2d              = 141;
  static final int op_d2i              = 142;
  static final int op_d2l              = 143;
  static final int op_d2f              = 144;
  static final int op_i2b              = 145;
  static final int op_i2c              = 146;
  static final int op_i2s              = 147;
  static final int op_lcmp             = 148;
  static final int op_fcmpl            = 149;
  static final int op_fcmpg            = 150;
  static final int op_dcmpl            = 151;
  static final int op_dcmpg            = 152;
  static final int op_ifeq             = 153;
  static final int op_ifne             = 154;
  static final int op_iflt             = 155;
  static final int op_ifge             = 156;
  static final int op_ifgt             = 157;
  static final int op_ifle             = 158;
  static final int op_if_icmpeq        = 159;
  static final int op_if_icmpne        = 160;
  static final int op_if_icmplt        = 161;
  static final int op_if_icmpge        = 162;
  static final int op_if_icmpgt        = 163;
  static final int op_if_icmple        = 164;
  static final int op_if_acmpeq        = 165;
  static final int op_if_acmpne        = 166;
  static final int op_goto             = 167;
  static final int op_jsr              = 168;
  static final int op_ret              = 169;
  static final int op_tableswitch      = 170;
  static final int op_lookupswitch     = 171;
  static final int op_ireturn          = 172;
  static final int op_lreturn          = 173;
  static final int op_freturn          = 174;
  static final int op_dreturn          = 175;
  static final int op_areturn          = 176;
  static final int op_return           = 177;
  static final int op_getstatic        = 178;
  static final int op_putstatic        = 179;
  static final int op_getfield         = 180;
  static final int op_putfield         = 181;
  static final int op_invokevirtual    = 182;
  static final int op_invokespecial    = 183;
  static final int op_invokestatic     = 184;
  static final int op_invokeinterface  = 185;
  static final int op_new              = 187;
  static final int op_newarray         = 188;
  static final int op_anewarray        = 189;
  static final int op_arraylength      = 190;
  static final int op_athrow           = 191;
  static final int op_checkcast        = 192;
  static final int op_instanceof       = 193;
  static final int op_monitorenter     = 194;
  static final int op_monitorexit      = 195;
  static final int op_wide             = 196;
  static final int op_multianewarray   = 197;
  static final int op_ifnull           = 198;
  static final int op_ifnonnull        = 199;
  static final int op_goto_w           = 200;
  static final int op_jsr_w            = 201;
  // reserved opcode, not a normal instruction
  static final int op_breakpoint       = 202;
  // non-existent instruction!
  // static final int op_ret_w            = 209;

  static final byte BytecodeLength[] = {
    1, //op_nop
    1, //op_aconst_null
    1, //op_iconst_m1
    1, //op_iconst_0
    1, //op_iconst_1
    1, //op_iconst_2
    1, //op_iconst_3
    1, //op_iconst_4
    1, //op_iconst_5
    1, //op_lconst_0
    1, //op_lconst_1
    1, //op_fconst_0
    1, //op_fconst_1
    1, //op_fconst_2
    1, //op_dconst_0
    1, //op_dconst_1
    2, //op_bipush
    3, //op_sipush
    2, //op_ldc
    3, //op_ldc_w
    3, //op_ldc2_w
    2, //op_iload
    2, //op_lload
    2, //op_fload
    2, //op_dload
    2, //op_aload
    1, //op_iload_0
    1, //op_iload_1
    1, //op_iload_2
    1, //op_iload_3
    1, //op_lload_0
    1, //op_lload_1
    1, //op_lload_2
    1, //op_lload_3
    1, //op_fload_0
    1, //op_fload_1
    1, //op_fload_2
    1, //op_fload_3
    1, //op_dload_0
    1, //op_dload_1
    1, //op_dload_2
    1, //op_dload_3
    1, //op_aload_0
    1, //op_aload_1
    1, //op_aload_2
    1, //op_aload_3
    1, //op_iaload
    1, //op_laload
    1, //op_faload
    1, //op_daload
    1, //op_aaload
    1, //op_baload
    1, //op_caload
    1, //op_saload
    2, //op_istore
    2, //op_lstore
    2, //op_fstore
    2, //op_dstore
    2, //op_astore
    1, //op_istore_0
    1, //op_istore_1
    1, //op_istore_2
    1, //op_istore_3
    1, //op_lstore_0
    1, //op_lstore_1
    1, //op_lstore_2
    1, //op_lstore_3
    1, //op_fstore_0
    1, //op_fstore_1
    1, //op_fstore_2
    1, //op_fstore_3
    1, //op_dstore_0
    1, //op_dstore_1
    1, //op_dstore_2
    1, //op_dstore_3
    1, //op_astore_0
    1, //op_astore_1
    1, //op_astore_2
    1, //op_astore_3
    1, //op_iastore
    1, //op_lastore
    1, //op_fastore
    1, //op_dastore
    1, //op_aastore
    1, //op_bastore
    1, //op_castore
    1, //op_sastore
    1, //op_pop
    1, //op_pop2
    1, //op_dup
    1, //op_dup_x1
    1, //op_dup_x2
    1, //op_dup2
    1, //op_dup2_x1
    1, //op_dup2_x2
    1, //op_swap
    1, //op_iadd
    1, //op_ladd
    1, //op_fadd
    1, //op_dadd
    1, //op_isub
    1, //op_lsub
    1, //op_fsub
    1, //op_dsub
    1, //op_imul
    1, //op_lmul
    1, //op_fmul
    1, //op_dmul
    1, //op_idiv
    1, //op_ldiv
    1, //op_fdiv
    1, //op_ddiv
    1, //op_irem
    1, //op_lrem
    1, //op_frem
    1, //op_drem
    1, //op_ineg
    1, //op_lneg
    1, //op_fneg
    1, //op_dneg
    1, //op_ishl
    1, //op_lshl
    1, //op_ishr
    1, //op_lshr
    1, //op_iushr
    1, //op_lushr
    1, //op_iand
    1, //op_land
    1, //op_ior
    1, //op_lor
    1, //op_ixor
    1, //op_lxor
    3, //op_iinc
    1, //op_i2l
    1, //op_i2f
    1, //op_i2d
    1, //op_l2i
    1, //op_l2f
    1, //op_l2d
    1, //op_f2i
    1, //op_f2l
    1, //op_f2d
    1, //op_d2i
    1, //op_d2l
    1, //op_d2f
    1, //op_int2byte
    1, //op_int2char
    1, //op_int2short
    1, //op_lcmp
    1, //op_fcmpl
    1, //op_fcmpg
    1, //op_dcmpl
    1, //op_dcmpg
    3, //op_ifeq
    3, //op_ifne
    3, //op_iflt
    3, //op_ifge
    3, //op_ifgt
    3, //op_ifle
    3, //op_if_icmpeq
    3, //op_if_icmpne
    3, //op_if_icmplt
    3, //op_if_icmpge
    3, //op_if_icmpgt
    3, //op_if_icmple
    3, //op_if_acmpeq
    3, //op_if_acmpne
    3, //op_goto
    3, //op_jsr
    2, //op_ret
    0, //op_tableswitch
    0, //op_lookupswitch
    1, //op_ireturn
    1, //op_lreturn
    1, //op_freturn
    1, //op_dreturn
    1, //op_areturn
    1, //op_return
    3, //op_getstatic
    3, //op_putstatic
    3, //op_getfield
    3, //op_putfield
    3, //op_invokevirtual
    3, //op_invokespecial
    3, //op_invokestatic
    5, //op_invokeinterface
    0, //op_186
    3, //op_new
    2, //op_newarray
    3, //op_anewarray
    1, //op_arraylength
    1, //op_athrow
    3, //op_checkcast
    3, //op_instanceof
    1, //op_monitorenter
    1, //op_monitorexit
    1, //op_wide
    4, //op_multianewarray
    3, //op_ifnull
    3, //op_ifnonnull
    5, //op_goto_w
    5, //op_jsr_w
    1, //op_breakpoint
  };

  static final byte StackDeltas[] = {
    0, //op_nop
    1, //op_aconst_null
    1, //op_iconst_m1
    1, //op_iconst_0
    1, //op_iconst_1
    1, //op_iconst_2
    1, //op_iconst_3
    1, //op_iconst_4
    1, //op_iconst_5
    2, //op_lconst_0
    2, //op_lconst_1
    1, //op_fconst_0
    1, //op_fconst_1
    1, //op_fconst_2
    2, //op_dconst_0
    2, //op_dconst_1
    1, //op_bipush
    1, //op_sipush
    1, //op_ldc
    1, //op_ldc_w
    2, //op_ldc2_w
    1, //op_iload
    2, //op_lload
    1, //op_fload
    2, //op_dload
    1, //op_aload
    1, //op_iload_0
    1, //op_iload_1
    1, //op_iload_2
    1, //op_iload_3
    2, //op_lload_0
    2, //op_lload_1
    2, //op_lload_2
    2, //op_lload_3
    1, //op_fload_0
    1, //op_fload_1
    1, //op_fload_2
    1, //op_fload_3
    2, //op_dload_0
    2, //op_dload_1
    2, //op_dload_2
    2, //op_dload_3
    1, //op_aload_0
    1, //op_aload_1
    1, //op_aload_2
    1, //op_aload_3
    -1, //op_iaload
    0, //op_laload
    -1, //op_faload
    0, //op_daload
    -1, //op_aaload
    -1, //op_baload
    -1, //op_caload
    -1, //op_saload
    -1, //op_istore
    -2, //op_lstore
    -1, //op_fstore
    -2, //op_dstore
    -1, //op_astore
    -1, //op_istore_0
    -1, //op_istore_1
    -1, //op_istore_2
    -1, //op_istore_3
    -2, //op_lstore_0
    -2, //op_lstore_1
    -2, //op_lstore_2
    -2, //op_lstore_3
    -1, //op_fstore_0
    -1, //op_fstore_1
    -1, //op_fstore_2
    -1, //op_fstore_3
    -2, //op_dstore_0
    -2, //op_dstore_1
    -2, //op_dstore_2
    -2, //op_dstore_3
    -1, //op_astore_0
    -1, //op_astore_1
    -1, //op_astore_2
    -1, //op_astore_3
    -3, //op_iastore
    -4, //op_lastore
    -3, //op_fastore
    -4, //op_dastore
    -3, //op_aastore
    -3, //op_bastore
    -3, //op_castore
    -3, //op_sastore
    -1, //op_pop
    -2, //op_pop2
    1, //op_dup
    1, //op_dup_x1
    1, //op_dup_x2
    2, //op_dup2
    2, //op_dup2_x1
    2, //op_dup2_x2
    0, //op_swap
    -1, //op_iadd
    -2, //op_ladd
    -1, //op_fadd
    -2, //op_dadd
    -1, //op_isub
    -2, //op_lsub
    -1, //op_fsub
    -2, //op_dsub
    -1, //op_imul
    -2, //op_lmul
    -1, //op_fmul
    -2, //op_dmul
    -1, //op_idiv
    -2, //op_ldiv
    -1, //op_fdiv
    -2, //op_ddiv
    -1, //op_irem
    -2, //op_lrem
    -1, //op_frem
    -2, //op_drem
    0, //op_ineg
    0, //op_lneg
    0, //op_fneg
    0, //op_dneg
    -1, //op_ishl
    -1, //op_lshl
    -1, //op_ishr
    -1, //op_lshr
    -1, //op_iushr
    -1, //op_lushr
    -1, //op_iand
    -2, //op_land
    -1, //op_ior
    -2, //op_lor
    -1, //op_ixor
    -2, //op_lxor
    0, //op_iinc
    1, //op_i2l
    0, //op_i2f
    1, //op_i2d
    -1, //op_l2i
    -1, //op_l2f
    0, //op_l2d
    0, //op_f2i
    1, //op_f2l
    1, //op_f2d
    -1, //op_d2i
    0, //op_d2l
    -1, //op_d2f
    0, //op_i2b
    0, //op_i2c
    0, //op_i2s
    -3, //op_lcmp
    -1, //op_fcmpl
    -1, //op_fcmpg
    -3, //op_dcmpl
    -3, //op_dcmpg
    -1, //op_ifeq
    -1, //op_ifne
    -1, //op_iflt
    -1, //op_ifge
    -1, //op_ifgt
    -1, //op_ifle
    -2, //op_if_icmpeq
    -2, //op_if_icmpne
    -2, //op_if_icmplt
    -2, //op_if_icmpge
    -2, //op_if_icmpgt
    -2, //op_if_icmple
    -2, //op_if_acmpeq
    -2, //op_if_acmpne
    0, //op_goto
    0, //op_jsr
    0, //op_ret
    -1, //op_tableswitch
    -1, //op_lookupswitch
    0, //op_ireturn
    0, //op_lreturn
    0, //op_freturn
    0, //op_dreturn
    0, //op_areturn
    0, //op_return
    99, //op_getstatic
    99, //op_putstatic
    99, //op_getfield
    99, //op_putfield
    99, //op_invokevirtual
    99, //op_invokespecial
    99, //op_invokestatic
    99, //op_invokeinterface
    0, //op_186
    1, //op_new
    0, //op_newarray
    0, //op_anewarray
    0, //op_arraylength
    0, //op_athrow
    0, //op_checkcast
    0, //op_instanceof
    -1, //op_monitorenter
    -1, //op_monitorexit
    0, //op_wide
    99, //op_multianewarray
    -1, //op_ifnull
    -1, //op_ifnonnull
    0, //op_goto_w
    0, //op_jsr_w
    0, //op_breakpoint
  };

  static final String[] OPCODE_NAMES = 
  {
    "nop",
    "aconst_null",
    "iconst_m1",
    "iconst_0",
    "iconst_1",
    "iconst_2",
    "iconst_3",
    "iconst_4",
    "iconst_5",
    "lconst_0",
    "lconst_1",
    "fconst_0",
    "fconst_1",
    "fconst_2",
    "dconst_0",
    "dconst_1",
    "bipush",
    "sipush",
    "ldc",
    "ldc_w",
    "ldc2_w",
    "iload",
    "lload",
    "fload",
    "dload",
    "aload",
    "iload_0",
    "iload_1",
    "iload_2",
    "iload_3",
    "lload_0",
    "lload_1",
    "lload_2",
    "lload_3",
    "fload_0",
    "fload_1",
    "fload_2",
    "fload_3",
    "dload_0",
    "dload_1",
    "dload_2",
    "dload_3",
    "aload_0",
    "aload_1",
    "aload_2",
    "aload_3",
    "iaload",
    "laload",
    "faload",
    "daload",
    "aaload",
    "baload",
    "caload",
    "saload",
    "istore",
    "lstore",
    "fstore",
    "dstore",
    "astore",
    "istore_0",
    "istore_1",
    "istore_2",
    "istore_3",
    "lstore_0",
    "lstore_1",
    "lstore_2",
    "lstore_3",
    "fstore_0",
    "fstore_1",
    "fstore_2",
    "fstore_3",
    "dstore_0",
    "dstore_1",
    "dstore_2",
    "dstore_3",
    "astore_0",
    "astore_1",
    "astore_2",
    "astore_3",
    "iastore",
    "lastore",
    "fastore",
    "dastore",
    "aastore",
    "bastore",
    "castore",
    "sastore",
    "pop",
    "pop2",
    "dup",
    "dup_x1",
    "dup_x2",
    "dup2",
    "dup2_x1",
    "dup2_x2",
    "swap",
    "iadd",
    "ladd",
    "fadd",
    "dadd",
    "isub",
    "lsub",
    "fsub",
    "dsub",
    "imul",
    "lmul",
    "fmul",
    "dmul",
    "idiv",
    "ldiv",
    "fdiv",
    "ddiv",
    "irem",
    "lrem",
    "frem",
    "drem",
    "ineg",
    "lneg",
    "fneg",
    "dneg",
    "ishl",
    "lshl",
    "ishr",
    "lshr",
    "iushr",
    "lushr",
    "iand",
    "land",
    "ior",
    "lor",
    "ixor",
    "lxor",
    "iinc",
    "i2l",
    "i2f",
    "i2d",
    "l2i",
    "l2f",
    "l2d",
    "f2i",
    "f2l",
    "f2d",
    "d2i",
    "d2l",
    "d2f",
    "int2byte",
    "int2char",
    "int2short",
    "lcmp",
    "fcmpl",
    "fcmpg",
    "dcmpl",
    "dcmpg",
    "ifeq",
    "ifne",
    "iflt",
    "ifge",
    "ifgt",
    "ifle",
    "if_icmpeq",
    "if_icmpne",
    "if_icmplt",
    "if_icmpge",
    "if_icmpgt",
    "if_icmple",
    "if_acmpeq",
    "if_acmpne",
    "goto",
    "jsr",
    "ret",
    "tableswitch",
    "lookupswitch",
    "ireturn",
    "lreturn",
    "freturn",
    "dreturn",
    "areturn",
    "return",
    "getstatic",
    "putstatic",
    "getfield",
    "putfield",
    "invokevirtual",
    "invokespecial",
    "invokestatic",
    "invokeinterface",
    "186",
    "new",
    "newarray",
    "anewarray",
    "arraylength",
    "athrow",
    "checkcast",
    "instanceof",
    "monitorenter",
    "monitorexit",
    "wide",
    "multianewarray",
    "ifnull",
    "ifnonnull",
    "goto_w",
    "jsr_w",
    "breakpoint",
  };
}
