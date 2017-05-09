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

class CodeIterator implements JVM 
{

  /** the code array */
  byte[] code;

  /** the constant pool of my class. */
  ConstantPool pool;

  /** the method that the code belongs to */
  MethodInfo method;

  /** 
   * a flag telling that the current opcode is wide-modified.
   * The opcode 'op_wide' itself is handled inside the iterator
   * and not shown to the user as an individual instruction.
   */
  boolean wide = false;

  /** the current opcode. */
  int opcode;

  /** The index into the 'code' array where we find the current opcode.
   *  This will point past the wide prefix if any.
   */
  int opcodeIndex;

  /** 
   * the index into the 'code' array where we find the first operand. 
   * For most instructions, this is opcodeIndex+1, except for
   * 'tableswitch' and 'lookupswitch', which contain padding bytes.
   */
  int operandIndex;

  /** the index into the 'code' array where the next instruction begins. */
  int nextIndex;
  
  /**
   * opcode of the instruction following the current one.
   * Used for peephole optimization
   */
  int nextOpcode;

  /** The index into the 'code' array where the current instruction begins.
   * This position could be a wide prefix. It is useful for jump targets
   * and for restoring the state to an earlier position. 
   */
  int mark;
  
  /**
   * make a code iterator that traverses a given array of bytecodes.
   */
  CodeIterator (byte[] code, ConstantPool pool, MethodInfo method)
  {
    this.code = code;
    this.pool = pool;
    this.method = method;
    nextIndex = 0;

    iterate();
  }

  /**
   * go to the next instruction.
   * All fields of the iterator are updated to correctly represent
   * the next instruction. 
   * When the end of the code array is reached, the method returns 
   * 'false' and the contents of the iterator's fields are invalid.
   */
  boolean iterate ()
  {
    return toTarget(nextIndex);
  }

  /**
   * go to a given instruction.
   * All fields of the iterator are updated to correctly represent
   * this target instruction. 
   * When the end of the code array is reached, the method returns 
   * 'false' and the contents of the iterator's fields are invalid.
   *
   * @param target the index of the target op-code.
   */
  boolean toTarget (int target)
  {
    mark = opcodeIndex = target;
    if (opcodeIndex >= code.length) 
    {
      return false;
    }
    opcode = (code[opcodeIndex]) & 0xff;
    if (opcode == op_wide) 
    {
      wide = true;
      opcodeIndex++;
      opcode = (code[opcodeIndex]) & 0xff;
    }
    else 
    {
      wide = false;
    }

    if (opcode == op_tableswitch) 
    {
      // padding to 4-byte-boundary
      operandIndex = (opcodeIndex & 0xfffffffc) + 4;

      int low  = getSignedInteger (4, 4);
      int high = getSignedInteger (8, 4);
      
      nextIndex = operandIndex + 12 + 4 * (high - low + 1);
    }
    else if (opcode == op_lookupswitch) 
    {
      // padding to 4-byte-boundary
      operandIndex = (opcodeIndex & 0xfffffffc) + 4;

      int npairs = getSignedInteger (4, 4);
      
      nextIndex = operandIndex + 8 + 8 * npairs;
    }
    else 
    {
      operandIndex = opcodeIndex + 1;
      nextIndex = opcodeIndex + BytecodeLength[opcode];
    }
    
    // iload, fload, aload, lload, dload, istore, fstore, 
    // astore, lstore, dstore, and ret can be 'widened': length+1
    if (wide) 
    {
      switch (opcode) 
      {
      case op_iload:
      case op_lload:
      case op_fload:
      case op_dload:
      case op_aload:
      case op_istore:
      case op_lstore:
      case op_fstore:
      case op_dstore:
      case op_astore:
        nextIndex += 1;
        break;
      case op_iinc:
        nextIndex += 2;
        break;
      }
    }
    nextOpcode = nextIndex < code.length ? (code[nextIndex] & 0xFF) : op_nop;
    return true;
  }

  /**
   * construct a new iterator, starting at the given target index.
   *
   * @param target the index of the target op-code.
   */
  CodeIterator makeChild (int target)
  {
    CodeIterator newIterator = new CodeIterator (code, pool, method);
    newIterator.toTarget (target);
    return newIterator;
  }

  /**
   * disassemble the current instruction.
   */
  String disassemble()
  {
    String result = OPCODE_NAMES[opcode];
    int t, u;
	  
    switch (opcode) 
    {
    case op_bipush:
      result = result + " " + getSignedInteger (0,1);
      break;
    case op_sipush:
      result = result + " " + getSignedInteger (0,2);
      break;
    case op_ldc:
    case op_ldc_w:
    {
      if (opcode == op_ldc) 
      {
        t = getUnsignedInteger (0,1);
      }
      else 
      {
        t = getUnsignedInteger (0,2);
      }
      String sig = pool.getSignature (t);
      if (sig.equals ("Ljava/lang/String;")) 
      {
        String cString = pool.getString (t);
        result = result + " \"" + stringFilter (cString) + "\"";
      }
      else if (sig.equals ("I")) 
      {
        result = result + " " + pool.getInteger (t);
      }
      else if (sig.equals ("F")) 
      {
        result = result + " " + pool.getFloat (t);
      }
      else 
      {
        result = result + " ???";
      }
      break;
    }
    case op_ldc2_w:
    {
      t = getUnsignedInteger (0,2);
      String sig = pool.getSignature (t);
      if (sig.equals ("J")) 
      {
        result = result + " " + pool.getLong (t);
      }
      else if (sig.equals ("D")) 
      {
        result = result + " " + pool.getDouble(t);
      }
      else 
      {
        result = result + " ???";
      }
      break;
    }
    case op_iload:
    case op_fload:
    case op_aload:
    case op_lload:
    case op_dload:
    case op_istore:
    case op_fstore:
    case op_astore:
    case op_lstore:
    case op_dstore:
      t = getUnsignedInteger (0, wide ? 2 : 1);
      result = result + " _" + t;
      break;
	    
    case op_iinc:
      if (wide) 
      {
        t = getUnsignedInteger (0, 2);
        u = getSignedInteger (2, 2);
      } 
      else 
      {
        t = getUnsignedInteger (0, 1);
        u = getSignedInteger (1, 1);
      }
      result = result + (u>=0 ? " +" : " ") + u + ",_" + t;
      break;

    case op_ifeq:
    case op_ifne:
    case op_iflt:
    case op_ifge:
    case op_ifgt:
    case op_ifle:
    case op_ifnull:
    case op_ifnonnull:
    case op_if_icmpeq:
    case op_if_icmpne:
    case op_if_icmplt:
    case op_if_icmpge:
    case op_if_icmpgt:
    case op_if_icmple:
    case op_if_acmpeq:
    case op_if_acmpne:
    case op_goto:
    case op_jsr:
      t = getSignedInteger (0, 2);
      result = result + " <" + (opcodeIndex + t) + ">";
      break;

    case op_ret:
      t = getUnsignedInteger (0, wide ? 2 : 1);
      result = result + " _" + t;
      break;
    case op_tableswitch: 
    case op_lookupswitch:
      result = result + " ...";
      break;

    case op_getstatic: 
    case op_putstatic: 
    case op_getfield: 
    case op_putfield: 
      t = getUnsignedInteger (0, 2);
      result = result + " " + pool.getFieldInfo (t);
      break;

    case op_invokevirtual: 
    case op_invokespecial:
    case op_invokestatic:
      t = getUnsignedInteger (0, 2);
      result = result + " " + pool.getMethodInfo (t);
      break;
      
    case op_invokeinterface: 
      t = getUnsignedInteger (0, 2);
      result = result + " " + pool.getInterfaceMethodInfo (t);
      break;
      
    case op_new: 
      t = getUnsignedInteger (0, 2);
      result = result + " " + pool.getKlass (t);
      break;
    case op_newarray: 
      t = getUnsignedInteger (0, 1);
      switch (t) 
      {
      case  4: result = result + " [Z"; break;
      case  5: result = result + " [C"; break;
      case  6: result = result + " [F"; break;
      case  7: result = result + " [D"; break;
      case  8: result = result + " [B"; break;
      case  9: result = result + " [S"; break;
      case 10: result = result + " [I"; break;
      case 11: result = result + " [J"; break;
      default: result = result + " [???"; break;
      }
      break;
    case op_anewarray: 
      t = getUnsignedInteger (0, 2);
      result = result + " [" + pool.getKlass(t).getSignature();
      break;
    case op_checkcast: 
    case op_instanceof: 
      t = getUnsignedInteger (0, 2);
      result = result + " " + pool.getKlass(t).getSignature();
      break;
    case op_multianewarray: 
      t = getUnsignedInteger (0, 2);
      u = getUnsignedInteger (2, 1);
      result = result + " " + u + "," + 
        pool.getKlass(t).getSignature();
      break;
    case op_goto_w:
    case op_jsr_w:
      t = getSignedInteger (0, 4);
      result = result + " <" + (opcodeIndex + t) + ">";
      break;
    }
    return result;
  }

  /**
   * get a variable-length unsigned integer from the code array.
   *
   * @param offset the offset of the integer's first byte from the
   *               first operand position of the current instruction.
   * @param size the length of the integer in bytes.
   * @return the unsigned integer from the code array
   */
  int getUnsignedInteger (int offset, int size)
  {
    int index = operandIndex + offset;
    int res = ((int) code[index++]) & 0xff;
    for (int i=1; i<size; i++) 
    {
      res = (res << 8) + (((int) code[index++]) & 0xff);
    }
    return res;
  }

  /**
   * get a variable-length signed integer from the code array.
   *
   * @param offset the offset of the integer's first byte from the
   *               first operand position of the current instruction.
   * @param size the length of the integer in bytes.
   * @return the signed integer from code[index] to code[index+size-1]
   */
  int getSignedInteger (int offset, int size)
  {
    int index = operandIndex + offset;
    int res = code[index++];
    for (int i=1; i<size; i++) 
    {
      res = (res << 8) + (((int) code[index++]) & 0xff);
    }
    return res;
  }

  /**
   * get an abbreviated, one-line version of a string without
   * any dangerous characters, suitable for disassembled arguments.
   */
  String stringFilter (String s)
  {
    char[] chars;
    if (s.length() > 30) 
    {
      chars = new char[30];
      s.getChars (0, 30, chars, 0);
    }
    else 
    {
      chars = s.toCharArray();
    }

    for (int i=0; i<chars.length; i++) 
    {
      char c = chars[i];
      if (Character.getNumericValue(c) > 255) 
      {
        chars[i] = '*';
      }
      else if (Character.isWhitespace(c)) 
      {
        chars[i] = ' ';
      }
      else if (Character.isISOControl(c)) 
      {
        chars[i] = '.';
      }
    }
    return new String (chars);
  }
}
