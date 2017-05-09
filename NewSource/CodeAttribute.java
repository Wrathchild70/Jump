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
    This file has been modified in 03-05/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/
/*
   November 2001
    This file has been modified by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    to add some code optimization and to extend the functionality.
*/

import java.io.*;
import java.util.*;

class CodeAttribute extends JavaElement implements JVM 
{

  class exception_table_entry 
  {
    int start_pc;
    int end_pc;
    int handler_pc;
    String catch_type_name;
  }

  class NeededInstructionsCollector 
  {
    boolean[] needed;
    boolean onceMore = false;

    NeededInstructionsCollector (int n) 
    {
      needed = new boolean[n];
    }

    boolean isNeeded (int i) 
    {
      return needed[i];
    }

    boolean isNeeded (StackEntry entry) 
    {
      int[] ids = entry.sourceIDs;
      if (ids.length == 0) 
      {
        return true;
      }
      for (int i=0; i<ids.length; i++) 
      {
        if (needed[ids[i]]) 
        {
          return true;
        }
      }
      return false;
    }

    /**
     * needed if any of the sourceIDs is a static field (that has to be an array) and
     * that array is needed. used to make element inits of an array needed if the
     * array itself is.
     */
    boolean isArrayNeeded(StackEntry entry, CodeIterator iterator, boolean initArray) 
    {
      int[] ids = entry.sourceIDs;
      if (ids.length == 0) 
      {
        return true;
      }
      for (int i=0; i<ids.length; i++) 
      {
        if (needed[ids[i]]) 
          return true;
        if (initArray)
        {
          int mark = iterator.mark;
          iterator.toTarget(ids[i]);
          if (iterator.opcode == op_getstatic)
          {
            FieldInfo field = iterator.pool.getFieldInfo(iterator.getUnsignedInteger(0,2));
            iterator.toTarget(mark);
            if ( field.constantValue() == null && field.isNeeded() )
              return true;
          }
          else
          {
            iterator.toTarget(mark);
            return true;
          }
        }
      }
      return false;
    }

    boolean[] getArray() 
    {
      return needed;
    }

    void setNeeded (int i) 
    {
      if ((i >= 0) && (!needed[i])) 
      {
        needed[i] = true;
        onceMore = true;
      }
    }

    void setNeeded (StackEntry entry) 
    {
      int[] ids = entry.sourceIDs;
      for (int i=0; i<ids.length; i++) 
      {
        setNeeded (ids[i]);
      }
    }

    boolean needsIteration () 
    {
      boolean result = onceMore;
      onceMore = false;
      return result;
    }
  }

  int max_stack;
  int max_locals;
  byte[] code;

  /** Instuctions that are needed. Indexed byte instruction position. */
  boolean[] codeNeeded = null;

  exception_table_entry[] exception_table;
  private AttributeTable attributes;
  MethodInfo method;
  ConstantPool pool;

  CodeAttribute (Object obj, ConstantPool pool, DataInput in) throws IOException
  {
    method = (MethodInfo) obj;
    this.pool = pool;

    max_stack = in.readShort();
    max_locals = in.readShort();
    code = new byte[in.readInt()];
    in.readFully(code);
    int exception_table_length = in.readShort();
    exception_table = new exception_table_entry[exception_table_length];
    for (int i = 0; i < exception_table_length; i++) 
    {
      exception_table[i] = new exception_table_entry();
      exception_table[i].start_pc = in.readShort();
      exception_table[i].end_pc = in.readShort();
      exception_table[i].handler_pc = in.readShort();

      int catch_type_index = in.readShort();
      exception_table[i].catch_type_name = 
        (catch_type_index == 0 ?
        "java/lang/Object" :
        pool.getClassname (catch_type_index));
    }
    attributes = new AttributeTable(this, pool, in);
  }

  /**
   * declare a named exception class as 'INSTANCE_NEEDED'.
   * A JVM instruction that can cause such an exception to be thrown
   * uses this call in the 'updateNeeded()' process to declare
   * the dependency on this exception class. In addition to
   * the class itself, its no-args initializer is 'NEEDED' too.
   *
   * @param className the name of the exception class.
   */
  void needException (String className) 
  {
    Klass exClass = Klass.forName (className);

    exClass.markNeeded(method, INSTANCE_NEEDED);
    exClass.findMethod("<init>", "()V").markNeeded(method, NEEDED);
  }

  /**
   * declare the element types of all reference-array classes 
   * with instances as 'NEEDED_INSTANCEOF'.
   * E.g. if [Ljava/lang/String; has instances, then the 
   * java/lang/String class becomes 'NEEDED_INSTANCEOF'.
   * This is a result of having an 'aastore' instruction.
   * Any reference-array can become destination of such an
   * instruction, and thus an implicit 'checkcast' to the
   * element type of the array (determined at run-time!)
   * must be executed.
   */
  void needAastore () 
  {
    for (int i=0; i<Klass.ClassList.size(); i++) 
    {
      Klass cl = (Klass) Klass.ClassList.elementAt(i);

      if ((cl.className.startsWith ("[[") ||
        cl.className.startsWith ("[L")) &&
        cl.isNeeded (INSTANCE_NEEDED)) 
      {
        Klass.forSignature (cl.className.substring(1)).
          markNeeded (method, NEEDED + NEEDED_INSTANCEOF);
      }
    }
  }

  /**
   * update the 'needed' state of this code's method and the
   * elements referenced in this code.
   */
  void updateNeeded ()
  {
    if (method.name.equals ("<clinit>")) 
    {
      updateNeededComplex (Jump.codeOptions);
    }
    else 
    {
      updateNeededSimple();
    }
    if (method.isNeeded(JavaElement.NEEDED)) 
    {
      for (int i=0; i<exception_table.length; i++) 
      {
        Klass catchClass = Klass.forName (exception_table[i].catch_type_name);
        if (catchClass.hasInstances()) 
        {
          catchClass.markNeeded (method, NEEDED + NEEDED_INSTANCEOF);
        }
      }
    }
  }

  /**
   * update the 'needed' state of this code's method and the
   * elements referenced in this code.
   * This is the simple version treating the method as an atomic entity.
   * Its code is either completely included or completely excluded.
   */
  void updateNeededSimple ()
  {
    CodeIterator iterator = new CodeIterator (code, pool, method);
    FieldInfo field;
    int t, u;

    if (method.isNeeded(JavaElement.NEEDED)) 
    {
      // if method needed, all elements used in the code
      // are also needed (methods called, fields read, etc.).
      do 
      {
        int op = iterator.opcode;
        switch (op)
        {
        case op_nop:
        case op_aconst_null:
        case op_iconst_m1:
        case op_iconst_0:
        case op_iconst_1:
        case op_iconst_2:
        case op_iconst_3:
        case op_iconst_4:
        case op_iconst_5:
        case op_lconst_0:
        case op_lconst_1:
        case op_fconst_0:
        case op_fconst_1:
        case op_fconst_2:
        case op_dconst_0:
        case op_dconst_1:
        case op_bipush:
        case op_sipush:
        case op_ldc:
        case op_ldc_w:
        case op_ldc2_w:
        case op_iload:
        case op_lload:
        case op_fload:
        case op_dload:
        case op_aload:
        case op_iload_0:
        case op_iload_1:
        case op_iload_2:
        case op_iload_3:
        case op_lload_0:
        case op_lload_1:
        case op_lload_2:
        case op_lload_3:
        case op_fload_0:
        case op_fload_1:
        case op_fload_2:
        case op_fload_3:
        case op_dload_0:
        case op_dload_1:
        case op_dload_2:
        case op_dload_3:
        case op_aload_0:
        case op_aload_1:
        case op_aload_2:
        case op_aload_3:
          break;

        case op_iaload:
        case op_laload:
        case op_faload:
        case op_daload:
        case op_aaload:
        case op_baload:
        case op_caload:
        case op_saload:
          needException("java/lang/NullPointerException");
          needException("java/lang/ArrayIndexOutOfBoundsException");
          break;

        case op_istore:
        case op_lstore:
        case op_fstore:
        case op_dstore:
        case op_astore:
        case op_istore_0:
        case op_istore_1:
        case op_istore_2:
        case op_istore_3:
        case op_lstore_0:
        case op_lstore_1:
        case op_lstore_2:
        case op_lstore_3:
        case op_fstore_0:
        case op_fstore_1:
        case op_fstore_2:
        case op_fstore_3:
        case op_dstore_0:
        case op_dstore_1:
        case op_dstore_2:
        case op_dstore_3:
        case op_astore_0:
        case op_astore_1:
        case op_astore_2:
        case op_astore_3:
          break;

        case op_iastore:
        case op_lastore:
        case op_fastore:
        case op_dastore:
        case op_bastore:
        case op_castore:
        case op_sastore:
          needException("java/lang/NullPointerException");
          needException("java/lang/ArrayIndexOutOfBoundsException");
          break;
        case op_aastore:
          needException("java/lang/NullPointerException");
          needException("java/lang/ArrayIndexOutOfBoundsException");
          needException("java/lang/ArrayStoreException");
          needAastore();
          break;

        case op_pop:
        case op_pop2:
        case op_dup:
        case op_dup_x1:
        case op_dup_x2:
        case op_dup2:
        case op_dup2_x1:
        case op_dup2_x2:
        case op_swap:
        case op_iadd:
        case op_ladd:
        case op_fadd:
        case op_dadd:
        case op_isub:
        case op_lsub:
        case op_fsub:
        case op_dsub:
        case op_imul:
        case op_lmul:
        case op_fmul:
        case op_dmul:
          break;

        case op_idiv:
        case op_ldiv:
        case op_fdiv:
        case op_ddiv:
        case op_irem:
        case op_lrem:
        case op_frem:
        case op_drem:
          needException("java/lang/ArithmeticException");
          break;
	    
        case op_ineg:
        case op_lneg:
        case op_fneg:
        case op_dneg:
        case op_ishl:
        case op_lshl:
        case op_ishr:
        case op_lshr:
        case op_iushr:
        case op_lushr:
        case op_iand:
        case op_land:
        case op_ior:
        case op_lor:
        case op_ixor:
        case op_lxor:
        case op_iinc:
          break;
	    
        case op_i2l:
        case op_i2f:
        case op_i2d:
        case op_l2i:
        case op_l2f:
        case op_l2d:
        case op_f2i:
        case op_f2l:
        case op_f2d:
        case op_d2i:
        case op_d2l:
        case op_d2f:
        case op_i2b:
        case op_i2c:
        case op_i2s:
          break;

        case op_lcmp:
        case op_fcmpl:
        case op_fcmpg:
        case op_dcmpl:
        case op_dcmpg:
        case op_ifeq:
        case op_ifne:
        case op_iflt:
        case op_ifge:
        case op_ifgt:
        case op_ifle:
        case op_if_icmpeq:
        case op_if_icmpne:
        case op_if_icmplt:
        case op_if_icmpge:
        case op_if_icmpgt:
        case op_if_icmple:
        case op_if_acmpeq:
        case op_if_acmpne:
          break;

        case op_goto:
        case op_jsr:
        case op_ret:
        case op_tableswitch:
        case op_lookupswitch:
        case op_ireturn:
        case op_lreturn:
        case op_freturn:
        case op_dreturn:
        case op_areturn:
        case op_return:
          break;

        case op_getstatic:
          t = iterator.getUnsignedInteger (0, 2);
          field = pool.getFieldInfo(t);
          // constant-value fields will be coded in-line
          if (field.constantValue() == null) 
          {
            field.markNeeded (method, NEEDED);
          }
          break;

        case op_getfield:
          t = iterator.getUnsignedInteger (0, 2);
          pool.getFieldInfo(t).markNeeded (method, NEEDED);
          needException("java/lang/NullPointerException");
          break;

          // Writing into a field doesn't mean we need it!
          // (Maybe someone else needs it.)
          // An optimizer can eliminate PUTs into unneeded fields.
        case op_putfield:
        case op_putstatic:
          break;
	    
        case op_invokevirtual: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          pool.getMethodInfo(t).markNeeded(method, NEEDED_VIRTUALLY);
          needException("java/lang/NullPointerException");
          break;
        }
	    
          // JVM spec for 'invokespecial' is very complicated!!
        case op_invokespecial: 
        {
          Klass ourClass = method.cls;
          t = iterator.getUnsignedInteger (0, 2);
          MethodInfo m = pool.getMethodInfo(t);
          needException("java/lang/NullPointerException");
	    
          // In a special case, the method has to be found in a class
          // different from the one mentioned in the constant pool.
          if ((!m.name.equals ("<init>")) &&
            ((ourClass.access_flags & ACC_SUPER) != 0) &&
            ourClass.hasSuperclass (m.cls)) 
          {
            // re-search method beginning in our superclass
            m = ourClass.superclass.findMethod (m.name, m.signature);
          }
          if ((m.access_flags & ACC_ABSTRACT) != 0) 
          {
            ASSERT.fail ("invokespecial of abstract method " + m);
          }
          else 
          {
            m.markNeeded(method, NEEDED);
          }
          break;
        }

        case op_invokestatic: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          pool.getMethodInfo(t).markNeeded(method, NEEDED);
          break;
        }

        case op_invokeinterface: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          pool.getInterfaceMethodInfo(t).markNeeded(method, NEEDED_VIRTUALLY);
          needException("java/lang/NullPointerException");
          break;
        }

        case op_new: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          pool.getKlass(t).markNeeded(method, INSTANCE_NEEDED);
          break;
        }

        case op_newarray: 
        {
          String classname = "";
          t = iterator.getUnsignedInteger (0, 1);
          switch (t) 
          {
          case  4: classname = "[Z"; break;
          case  5: classname = "[C"; break;
          case  6: classname = "[F"; break;
          case  7: classname = "[D"; break;
          case  8: classname = "[B"; break;
          case  9: classname = "[S"; break;
          case 10: classname = "[I"; break;
          case 11: classname = "[J"; break;
          default:
            ASSERT.fail("Internal error: Unknown array type: " + t);
            break;
          }
          Klass.forName(classname).markNeeded(method, INSTANCE_NEEDED);
          needException("java/lang/NegativeArraySizeException");
          break;
        }
	    
        case op_anewarray: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          Klass.forName ("[" + pool.getKlass (t).getSignature())
            .markNeeded(method, INSTANCE_NEEDED);
          needException("java/lang/NegativeArraySizeException");
          break;
        }

        case op_arraylength:
          needException("java/lang/NullPointerException");
          break;

        case op_athrow:
          needException("java/lang/NullPointerException");
          break;

        case op_checkcast: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          pool.getKlass(t).markNeeded(method, NEEDED + NEEDED_INSTANCEOF);
          needException("java/lang/ClassCastException");
          break;
        }

        case op_instanceof: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          pool.getKlass(t).markNeeded(method, NEEDED + NEEDED_INSTANCEOF);
          break;
        }

        case op_monitorenter:
        case op_monitorexit:
        case op_wide:
          break;

        case op_multianewarray: 
        {
          t = iterator.getUnsignedInteger (0, 2);
          u = iterator.getUnsignedInteger (2, 1);
	    
          String cln;
          int i;
          for (i=0, cln=pool.getClassname(t); 
            i<u; 
            i++, cln=cln.substring(1)) 
          {
            Klass.forName(cln).markNeeded(method, INSTANCE_NEEDED);
          }
          needException("java/lang/NegativeArraySizeException");
          break;
        }

        case op_ifnull:
        case op_ifnonnull:
        case op_goto_w:
        case op_jsr_w:
          break;
        }

      } while (iterator.iterate());
    }
    else if (method.name.equals ("<clinit>")) 
    {
      // By now, it is an 'unneeded' class initializer.
      // But it can become 'needed' e.g. if it writes 
      // to a 'needed' static field.
      do 
      {
        int op = iterator.opcode;
        switch (op)
        {
        case op_putfield:
        case op_putstatic: 
        {
          FieldInfo fi = pool.getFieldInfo(iterator.getUnsignedInteger(0,2));
          if (fi.isNeeded()) 
          {
            method.markNeeded(fi, NEEDED);
          }
          break;
        }

        case op_invokevirtual:
        case op_invokespecial:
        case op_invokestatic: 
        {
          // if external code is called, this code might have
          // ANY effect you can imagine, so a <clinit> method
          // *should* become 'needed' if it calls external code.
          MethodInfo mi = pool.getMethodInfo(iterator.getUnsignedInteger(0,2));
          method.markNeeded(mi, NEEDED);
          break;
        }
        case op_invokeinterface: 
        {
          // if external code is called, this code might have
          // ANY effect you can imagine, so a <clinit> method
          // *should* become 'needed' if it calls external code.
          MethodInfo mi = pool.getInterfaceMethodInfo(iterator.getUnsignedInteger(0,2));
          method.markNeeded(mi, NEEDED);
          break;
        }
        }
      } while (iterator.iterate());
    }
  }

  /**
   * update the 'needed' state of this code's method and the
   * elements referenced in this code.
   * This is the complex version looking at the individual instructions
   * and deciding which of them are necessary.
   */
  void updateNeededComplex (CodeOptions options)
  {
    if (method.isNeeded(JavaElement.NEEDED) || method.name.equals("<clinit>")) 
    {
      StackEntry[] stackArray = computeStackArray();
      codeNeeded = computeInstructionsNeeded (stackArray, options);
    }
  }

  /**
   * return a boolean array marking the jump targets of this code.
   * Start-pc and end-pc of exception-handling regions are 
   * considered jump targets too, as they also need to have labels.
   */
  boolean[] computeJumpTargets ()
  {
    CodeIterator iterator = new CodeIterator (code, pool, method);
    boolean[] result = new boolean[code.length];
    int t, n;

    // collect programmatic jump targets
    do 
    {
      int op = iterator.opcode;
      int index = iterator.opcodeIndex;

      switch (op) 
      {
      case op_ifeq:
      case op_ifne:
      case op_iflt:
      case op_ifge:
      case op_ifgt:
      case op_ifle:
      case op_if_icmpeq:
      case op_if_icmpne:
      case op_if_icmplt:
      case op_if_icmpge:
      case op_if_icmpgt:
      case op_if_icmple:
      case op_if_acmpeq:
      case op_if_acmpne:
      case op_ifnull:
      case op_ifnonnull:
      case op_goto:
      case op_jsr:
        t = iterator.getSignedInteger (0, 2);
        result [index+t] = true;
        break;

      case op_tableswitch:
        t = iterator.getSignedInteger (0, 4);
        result [index+t] = true;
        n = 4 * (iterator.getSignedInteger(8,4) -
          iterator.getSignedInteger(4,4) + 1) + 12;
        for (int off=12; off<n; off+=4) 
        {
          t = iterator.getSignedInteger (off, 4);
          result [index+t] = true;
        }
        break;

      case op_lookupswitch:
        t = iterator.getSignedInteger (0, 4);
        result [index+t] = true;
        n = 8 * (iterator.getSignedInteger(4,4)) + 8;
        for (int off=12; off<n; off+=8) 
        {
          t = iterator.getSignedInteger (off, 4);
          result [index+t] = true;
        }
        break;

      case op_goto_w:
      case op_jsr_w:
        t = iterator.getSignedInteger (0, 4);
        result [index+t] = true;
        break;

      }
    } while (iterator.iterate());
    
    // collect exception targets
    for (int i=0; i<exception_table.length; i++) 
    {
      result [exception_table[i].start_pc] = true;
      result [exception_table[i].end_pc] = true;
      result [exception_table[i].handler_pc] = true;
    }

    return result;
  }

  static void addInitialized(HashSet ci, Klass cls)
  {
    for (; cls != null; cls = cls.superclass )
      ci.add(cls);
  }

  /**
   * Calculate which instructions need to check for null.
   * We try to avoid checking local vars for null when we
   * are sure it is not needed or has been done before. Currently
   * this is pessimistic because we assume no knowledge after a
   * jump target.
   */
  CodeAnnotation[] computeAnnotations(boolean[] jumpTargets)
  {
    StackEntry[] preStack = computeStackArray();
    int locals = max_locals+1;
    CodeIterator iterator = new CodeIterator (code, pool, method);
    CodeAnnotation[] result = new CodeAnnotation[code.length];
    boolean[] localChecked = new boolean[locals];
    boolean[][] localCheckPoint = new boolean[code.length][];
    HashSet classesInitialized = new HashSet();
    HashSet[] classesInitializedPoint = new HashSet[code.length];
    
    addInitialized(classesInitialized,method.cls);  // we in this class so must be inited

    annotateCode( 
      iterator, preStack, jumpTargets,
      localChecked, localCheckPoint,
      classesInitialized, classesInitializedPoint,
      result );

    return result;
  }

  /** recursively follow the code to determine which null checks can be removed. */
  private void annotateCode(
    CodeIterator iterator,
    StackEntry[] preStack,
    boolean[] jumpTargets,
    boolean[] localChecked,
    boolean[][] localCheckPoint,
    HashSet classesInitialized,
    HashSet[] classesInitializedPoint,
    CodeAnnotation[] result)
  {
    int locals = max_locals+1;
    boolean notNull;
    localChecked[0] = (method.access_flags & ACC_STATIC) == 0;
    Klass myClass = method.cls;
    do 
    {
      int op = iterator.opcode;
      int index = iterator.opcodeIndex;
      int mark = iterator.mark;
      int l, t;


      if (jumpTargets[mark] )
      {
        // if we hit jump target we need to merge the current
        // classInitialized and the checkpoint value.
        HashSet ci = classesInitializedPoint[mark];
        if ( ci == null )
          classesInitializedPoint[mark] = (HashSet)classesInitialized.clone();
        else
        {
          for (Iterator i=ci.iterator(); i.hasNext(); )
          {
            Klass cls = (Klass)i.next();
            if ( !classesInitialized.contains(cls) )
              i.remove();
          }
          classesInitialized = (HashSet)ci.clone();
        }

        // if we hit jump target we need to merge the current
        // localChecked with the checkpoint value, if any. If
        // they match then we are done.
        boolean[] cp = localCheckPoint[mark];
        if ( cp == null )
          localCheckPoint[mark] = (boolean[]) localChecked.clone();
        else
        {
          boolean same = true;
          for (int i=0; i<localChecked.length; i++)
          {
            // if the previously checked section says a local is checked but
            // the branch to the top of it says it isn't then the section
            // needs to be re=evaluated.
            if ( cp[i] && !localChecked[i] )
            {
              // only checked if checked on both paths
              cp[i] = false;
              same = false;
            }
            localChecked[i] = cp[i];
          }
          // this path has been followed before and this time
          // gives the same result, so bail out.
          if ( same )
            return;
        }
      }
      if ( codeNeeded == null || codeNeeded[index] )
      {
        switch ( op )
        {
        case op_dup:  // PMD 2.1.7 improve obj.field += <exp>;
          // top-of-stack is target pointer
          l = preStack[index].localSlot;
          if ( l>=0 && result[index] == null )
            result[index] = new CodeAnnotation(l, false );
          break;
        case op_invokespecial:
        case op_invokeinterface:
        case op_invokevirtual:
          {
          t = iterator.getUnsignedInteger (0, 2);
          MethodInfo mm = pool.getMethodInfo(t);
          // In a special case, the method has to be found in a class
          // different from the one mentioned in the constant pool.
          boolean init = mm.name.equals ("<init>");
          if (!init && op == op_invokespecial &&
            ((myClass.access_flags & ACC_SUPER) != 0) &&
            myClass.hasSuperclass(mm.cls)) 
          {
            // re-search method beginning in our superclass
            mm = myClass.superclass.findMethod(mm.name, mm.signature);
          }
          int argStackSize = mm.argStackSize();
          StackEntry se = preStack[index];
          se = se.popNWords(argStackSize);   // find new 'this'
          l = se.localSlot;
          notNull = se.isKnownNonNull;
          if ( l>=0 || notNull || init)
            result[index] = new CodeAnnotation(l, notNull || init || localChecked[l] );
          if ( l>=0 )
            localChecked[l] = true; // checked now
          if ( result[index] == null )
            result[index] = new CodeAnnotation();
          result[index].classInitialized = classesInitialized.contains(mm.cls);
          if ( !result[index].classInitialized )
            addInitialized(classesInitialized,mm.cls);
        }
          break;
        case op_arraylength:
        case op_getfield:
          // top-of-stack is target pointer
          l = preStack[index].localSlot;
          notNull = preStack[index].isKnownNonNull;
          if ( l>=0 || notNull )
            result[index] = new CodeAnnotation(l, notNull || localChecked[l] );
          if ( l>=0 )
            localChecked[l] = true; // checked now
          break;
        case op_bastore:
        case op_castore:
        case op_sastore:
        case op_iastore:
        case op_fastore:
        case op_lastore:
        case op_dastore:
          // don't yet handle aastore because of different support code
          // third-on-stack is target pointer
          l = preStack[index].next.next.localSlot;
          notNull = preStack[index].next.next.isKnownNonNull;
          if ( l>=0 || notNull )
          {
            CodeAnnotation ca = result[index];
            result[index] = new CodeAnnotation(l, notNull || localChecked[l]);
            if ( l>=0 ) 
            {
              // tell the originating aload not to bother because
              // the putfield etc knows which pointer to use.
              int source = preStack[index].next.next.sourceIDs[0];
              // ASSERT.check(result[source] == null || ca != null, "xastore reused");
              result[source] = new CodeAnnotation(l, false);
              result[source].dontPush = true;
              result[index].dontPush = true;
              localChecked[l] = true; // checked now
            }
          }
          break;
        case op_putfield:
        case op_baload:
        case op_saload:
        case op_iaload:
        case op_faload:
        case op_aaload:
        case op_caload:
        case op_laload:
        case op_daload:
          // second-on-stack is target pointer
          l = preStack[index].next.localSlot;
          notNull = preStack[index].next.isKnownNonNull;
          if ( l>=0 || notNull )
          {
            CodeAnnotation ca = result[index];
            result[index] = new CodeAnnotation(l, notNull || localChecked[l]);
            if ( l>=0 )
            {
              // tell the originating aload not to bother because
              // the putfield etc knows which pointer to use.
              int source = preStack[index].next.sourceIDs[0];
              // ASSERT.check(result[source] == null || ca != null, "xaload reused");
              result[source] = new CodeAnnotation(l, false);
              result[source].dontPush = true;
              result[index].dontPush = true;
              localChecked[l] = true; // checked now
            }
          }
          break;
        case op_astore_0:
        case op_astore_1:
        case op_astore_2:
        case op_astore_3:
        case op_astore:
          // store into local so invalidate
          if ( op == op_astore )
            l = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
          else
            l = op-op_astore_0;
          localChecked[l] = preStack[index].isKnownNonNull;
          // local already loaded on the eval stack can not now trust that
          // they match the local.
          for (StackEntry se = preStack[index]; se != null; se = se.next )
          {
            if ( se.localSlot == l )
              se.localSlot = -1;
          }
          break;
        case op_ifeq:
        case op_ifne:
        case op_iflt:
        case op_ifge:
        case op_ifgt:
        case op_ifle:
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
          t = iterator.getSignedInteger (0, 2);
          annotateCode( 
            iterator.makeChild(index+t), preStack, jumpTargets,
            (boolean[])localChecked.clone(), localCheckPoint,
            (HashSet)classesInitialized.clone(), classesInitializedPoint,
            result );
          if ( op == op_goto )
            return;
          break;
        case op_ifnull:
          t = iterator.getSignedInteger (0, 2);
          l = preStack[index].localSlot;
          if ( l >= 0 )
            localChecked[l] = false;
          annotateCode( 
            iterator.makeChild(index+t), preStack, jumpTargets,
            (boolean[])localChecked.clone(), localCheckPoint,
            (HashSet)classesInitialized.clone(), classesInitializedPoint,
            result );
          if ( l >= 0 )
            localChecked[l] = true;
          break;
        case op_ifnonnull:
          t = iterator.getSignedInteger (0, 2);
          l = preStack[index].localSlot;
          if ( l >= 0 )
            localChecked[l] = true;
          annotateCode( 
            iterator.makeChild(index+t), preStack, jumpTargets,
            (boolean[])localChecked.clone(), localCheckPoint,
            (HashSet)classesInitialized.clone(), classesInitializedPoint,
            result );
          if ( l >= 0 )
            localChecked[l] = false;
          break;
        case op_return:
        case op_ireturn:
        case op_lreturn:
        case op_freturn:
        case op_dreturn:
        case op_areturn:
          return;
        case op_getstatic:
        case op_putstatic:
          t = iterator.getUnsignedInteger (0, 2);
          FieldInfo field = pool.getFieldInfo (t);
          if (field.constantValue() == null) 
          {
            if ( classesInitialized.contains(field.cls) )
              result[index] = new CodeAnnotation();
            else
            {
              addInitialized(classesInitialized,field.cls);
              result[index] = null;
            }
          }
          break;
        case op_new:
          {
          t = iterator.getUnsignedInteger (0, 2);
          Klass cls = pool.getKlass (t);
          if ( classesInitialized.contains(cls) )
            result[index] = new CodeAnnotation();
          else
          {
            addInitialized(classesInitialized,cls);
            result[index] = null;
          }
        }
          break;
        case op_invokestatic:
          {
          t = iterator.getUnsignedInteger (0, 2);
          MethodInfo m = pool.getMethodInfo(t);
          if ( classesInitialized.contains(m.cls) )
            result[index] = new CodeAnnotation();
          else
          {
            addInitialized(classesInitialized,m.cls);
            result[index] = null;
          }
        }
          break;
        }
      }
    } while ( iterator.iterate() );
  }

  /**
   * computes the stack contents array. This array contains the
   * stack description for every instruction in the code.
   * At index N, the array shows the stack contents 
   * <b>before</b> executing the instruction at index N.
   */
  StackEntry[] computeStackArray()
  {
    StackEntry[] stackArray = new StackEntry[code.length];
    StackEntry[] preStackArray = new StackEntry[code.length];
    StackEntry current = new StackEntry ("XXX", 0, null);
    StackEntry stack;
    FieldInfo fieldInfo;
    MethodInfo methodInfo;
    TArgs args;
    String type;
    char sigChar;

    for (int i=0; i<exception_table.length; i++) 
    {
      preStackArray[exception_table[i].handler_pc] = 
        current.push ("Ljava/lang/Throwable;", new int[0]);
    }

    for (int rounds = code.length + 1; 
      rounds >= 0; 
      rounds--) 
    {
      CodeIterator iterator = new CodeIterator (code, pool, method);
      int t, n;
      int nulls = 0;
      
      do 
      {
        int op = iterator.opcode;
        int index = iterator.opcodeIndex;

        StackEntry merged = StackEntry.merge (current, preStackArray[index]);
        current = merged;
        preStackArray[index] = merged;

        if (merged == null) 
        {
          nulls++;
        }
        else 
        {
          switch (op)
          {
          case op_nop:
          case op_iinc:
            break;
          case op_aconst_null:
            current = current.push ("Lnull;", index);
            break;
          case op_iconst_m1:
          case op_iconst_0:
          case op_iconst_1:
          case op_iconst_2:
          case op_iconst_3:
          case op_iconst_4:
          case op_iconst_5:
            current = current.push ("I", index);
            break;
          case op_lconst_0:
          case op_lconst_1:
            current = current.push ("J", index);
            break;
          case op_fconst_0:
          case op_fconst_1:
          case op_fconst_2:
            current = current.push ("F", index);
            break;
          case op_dconst_0:
          case op_dconst_1:
            current = current.push ("D", index);
            break;
          case op_bipush:
          case op_sipush:
            current = current.push ("I", index);
            break;
          case op_ldc:
            t = iterator.getUnsignedInteger (0, 1);
            current = current.push (pool.getSignature (t), index);
            break;
          case op_ldc_w:
          case op_ldc2_w:
            t = iterator.getUnsignedInteger (0, 2);
            current = current.push (pool.getSignature (t), index);
            break;
          case op_iload:
          case op_iload_0:
          case op_iload_1:
          case op_iload_2:
          case op_iload_3:
            current = current.push ("I", index);
            break;
          case op_lload:
          case op_lload_0:
          case op_lload_1:
          case op_lload_2:
          case op_lload_3:
            current = current.push ("J", index);
            break;
          case op_fload:
          case op_fload_0:
          case op_fload_1:
          case op_fload_2:
          case op_fload_3:
            current = current.push ("F", index);
            break;
          case op_dload:
          case op_dload_0:
          case op_dload_1:
          case op_dload_2:
          case op_dload_3:
            current = current.push ("D", index);
            break;
          case op_aload:
            t = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
            current = current.push (t, index);
            break;
          case op_aload_0:
          case op_aload_1:
          case op_aload_2:
          case op_aload_3:
            current = current.push (op - op_aload_0, index);
            break;
          case op_iaload:
          case op_baload:
          case op_caload:
          case op_saload:
            current = current.popSingle().popSingle().push("I",index);
            break;
          case op_laload:
            current = current.popSingle().popSingle().push("J",index);
            break;
          case op_faload:
            current = current.popSingle().popSingle().push("F",index);
            break;
          case op_daload:
            current = current.popSingle().popSingle().push("D",index);
            break;
          case op_aaload:
            current = current.popSingle().popSingle().push("Ljava/lang/Object;",index);
            break;
          case op_istore:
          case op_istore_0:
          case op_istore_1:
          case op_istore_2:
          case op_istore_3:
            current = current.popSingle();
            break;
          case op_lstore:
          case op_lstore_0:
          case op_lstore_1:
          case op_lstore_2:
          case op_lstore_3:
            current = current.popDouble();
            break;
          case op_fstore:
          case op_fstore_0:
          case op_fstore_1:
          case op_fstore_2:
          case op_fstore_3:
            current = current.popSingle();
            break;
          case op_dstore:
          case op_dstore_0:
          case op_dstore_1:
          case op_dstore_2:
          case op_dstore_3:
            current = current.popDouble();
            break;
          case op_astore:
          case op_astore_0:
          case op_astore_1:
          case op_astore_2:
          case op_astore_3:
            current = current.popSingle();
            break;
          case op_iastore:
          case op_fastore:
          case op_aastore:
          case op_bastore:
          case op_castore:
          case op_sastore:
            current = current.popSingle().popSingle().popSingle();
            break;
          case op_lastore:
          case op_dastore:
            current = current.popDouble().popSingle().popSingle();
            break;
          case op_pop:
            current = current.popSingle();
            break;
          case op_pop2:
            current = current.popDouble();
            break;
          case op_dup:
            current = current.dupSingle();
            break;
          case op_dup_x1:
            current = current.dupSingleBury1();
            break;
          case op_dup_x2:
            current = current.dupSingleBury2();
            break;
          case op_dup2:
            current = current.dupDouble();
            break;
          case op_dup2_x1:
            current = current.dupDoubleBury1();
            break;
          case op_dup2_x2:
            current = current.dupDoubleBury2();
            break;
          case op_swap:
            current = current.swapSingle();
            break;
          case op_iadd:
          case op_isub:
          case op_imul:
          case op_idiv:
          case op_irem:
          case op_ishl:
          case op_ishr:
          case op_iushr:
          case op_iand:
          case op_ior:
          case op_ixor:
            current = current.popSingle().popSingle().push("I",index);
            break;
          case op_ladd:
          case op_lsub:
          case op_lmul:
          case op_ldiv:
          case op_lrem:
          case op_land:
          case op_lor:
          case op_lxor:
            current = current.popDouble().popDouble().push("J",index);
            break;
          case op_lshl:
          case op_lshr:
          case op_lushr:
            // these were incorrectly treated like op_ladd, PMD 29Nov2001
            current = current.popSingle().popDouble().push("J",index);
            break;
          case op_fadd:
          case op_fsub:
          case op_fmul:
          case op_fdiv:
          case op_frem:
            current = current.popSingle().popSingle().push("F",index);
            break;
          case op_dadd:
          case op_dsub:
          case op_dmul:
          case op_ddiv:
          case op_drem:
            current = current.popDouble().popDouble().push("D",index);
            break;
          case op_ineg:
            current = current.popSingle().push("I",index);
            break;
          case op_lneg:
            current = current.popDouble().push("J",index);
            break;
          case op_fneg:
            current = current.popSingle().push("F",index);
            break;
          case op_dneg:
            current = current.popDouble().push("D",index);
            break;
          case op_i2l:
            current = current.popSingle().push("J",index);
            break;
          case op_i2f:
            current = current.popSingle().push("F",index);
            break;
          case op_i2d:
            current = current.popSingle().push("D",index);
            break;
          case op_l2i:
            current = current.popDouble().push("I",index);
            break;
          case op_l2f:
            current = current.popDouble().push("F",index);
            break;
          case op_l2d:
            current = current.popDouble().push("D",index);
            break;
          case op_f2i:
            current = current.popSingle().push("I",index);
            break;
          case op_f2l:
            current = current.popSingle().push("J",index);
            break;
          case op_f2d:
            current = current.popSingle().push("D",index);
            break;
          case op_d2i:
            current = current.popDouble().push("I",index);
            break;
          case op_d2l:
            current = current.popDouble().push("J",index);
            break;
          case op_d2f:
            current = current.popDouble().push("F",index);
            break;
          case op_i2b:
          case op_i2c:
          case op_i2s:
            current = current.popSingle().push("I",index);
            break;
          case op_lcmp:
          case op_dcmpl:
          case op_dcmpg:
            current = current.popDouble().popDouble().push("I",index);
            break;
          case op_fcmpl:
          case op_fcmpg:
            current = current.popSingle().popSingle().push("I",index);
            break;
          case op_ifeq:
          case op_ifne:
          case op_iflt:
          case op_ifge:
          case op_ifgt:
          case op_ifle:
          case op_ifnull:
          case op_ifnonnull:
            current = current.popSingle();
            t = iterator.getSignedInteger (0, 2);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], current);
            break;
          case op_if_icmpeq:
          case op_if_icmpne:
          case op_if_icmplt:
          case op_if_icmpge:
          case op_if_icmpgt:
          case op_if_icmple:
          case op_if_acmpeq:
          case op_if_acmpne:
            current = current.popSingle().popSingle();
            t = iterator.getSignedInteger (0, 2);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], current);
            break;
          case op_goto:
            t = iterator.getSignedInteger (0, 2);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], current);
            current = null;
            break;
          case op_goto_w:
            t = iterator.getSignedInteger (0, 4);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], current);
            current = null;
            break;
          case op_jsr:
            t = iterator.getSignedInteger (0, 2);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], 
              (new StackEntry ("X" + (index+t) + "X", 
              0,
              null)).push ("Ljava/lang/Ret;", 0));
            break;
          case op_jsr_w:
            t = iterator.getSignedInteger (0, 4);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], 
              (new StackEntry ("X" + (index+t) + "X", 
              0,
              null)).push ("Ljava/lang/Ret;", 0));
            break;
          case op_ret:
            current = null;
            break;
          case op_tableswitch: 
          {
            stack = current.popSingle();
            t = iterator.getSignedInteger (0, 4);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], stack);
            n = 4 * (iterator.getSignedInteger(8,4) -
              iterator.getSignedInteger(4,4) + 1) + 12;
            for (int off=12; off<n; off+=4) 
            {
              t = iterator.getSignedInteger (off, 4);
              preStackArray [index+t] = 
                StackEntry.merge (preStackArray [index+t], stack);
            }
            current = null;
            break;
          }
          case op_lookupswitch: 
          {
            stack = current.popSingle();
            t = iterator.getSignedInteger (0, 4);
            preStackArray [index+t] = 
              StackEntry.merge (preStackArray [index+t], stack);
            n = 8 * (iterator.getSignedInteger(4,4)) + 8;
            for (int off=12; off<n; off+=8) 
            {
              t = iterator.getSignedInteger (off, 4);
              preStackArray [index+t] = 
                StackEntry.merge (preStackArray [index+t], stack);
            }
            current = null;
            break;
          }
          case op_ireturn:
          case op_lreturn:
          case op_freturn:
          case op_dreturn:
          case op_areturn:
          case op_return:
            current = null;
            break;
          case op_getstatic:
            fieldInfo = pool.getFieldInfo (iterator.getUnsignedInteger (0, 2));
            current = current.push(fieldInfo.signature, index);
            sigChar = fieldInfo.signature.charAt(0);
            // we're only interested in statics that are objects or arrays.
            if (fieldInfo.constantValue() == null && (sigChar == 'L' || sigChar == '[')) 
              current.staticName = fieldInfo.toString();
            break;
          case op_putstatic:
            fieldInfo = pool.getFieldInfo (iterator.getUnsignedInteger (0, 2));
            switch (fieldInfo.signature.charAt(0)) 
            {
            case 'J':
            case 'D':
              current = current.popDouble();
              break;
            default:
              current = current.popSingle();
              break;
            }
            break;
          case op_getfield:
            fieldInfo = pool.getFieldInfo (iterator.getUnsignedInteger (0, 2));
            current = current.popSingle().push(fieldInfo.signature,index);
            break;
          case op_putfield:
            fieldInfo = pool.getFieldInfo (iterator.getUnsignedInteger (0, 2));
            switch (fieldInfo.signature.charAt(0)) 
            {
            case 'J':
            case 'D':
              current = current.popDouble().popSingle();
              break;
            default:
              current = current.popSingle().popSingle();
              break;
            }
            break;
          case op_invokevirtual:
          case op_invokespecial:
            methodInfo = pool.getMethodInfo (iterator.getUnsignedInteger (0, 2));
            args = new TArgs (methodInfo.signature);
            current = current.popNWords(args.words()).popSingle();
            type = args.ret();
            if (!type.equals("V")) 
            {
              current = current.push (type, index);
            }
            break;
          case op_invokestatic:
            methodInfo = pool.getMethodInfo (iterator.getUnsignedInteger (0, 2));
            args = new TArgs (methodInfo.signature);
            current = current.popNWords(args.words());
            type = args.ret();
            if (!type.equals("V")) 
            {
              current = current.push (type, index);
            }
            break;
          case op_invokeinterface:
            methodInfo = pool.getInterfaceMethodInfo (iterator.getUnsignedInteger (0, 2));
            args = new TArgs (methodInfo.signature);
            current = current.popNWords(args.words()).popSingle();
            type = args.ret();
            if (!type.equals("V")) 
            {
              current = current.push (type, index);
            }
            break;
          case op_new:
            t = iterator.getUnsignedInteger (0, 2);
            current = current.push (pool.getKlass(t).getSignature(), index);
            current.isKnownNonNull = true;
            break;
          case op_newarray:
            switch (iterator.getUnsignedInteger (0, 1)) 
            {
            case 4:
              type = "[Z";
              break;
            case 5:
              type = "[C";
              break;
            case 6:
              type = "[F";
              break;
            case 7:
              type = "[D";
              break;
            case 8:
              type = "[B";
              break;
            case 9:
              type = "[S";
              break;
            case 10:
              type = "[I";
              break;
            case 11:
              type = "[J";
              break;
            default:
              type = "[";
              break;
            }
            current = current.popSingle().push(type,index);
            current.isKnownNonNull = true;
            break;
          case op_anewarray:
            current = current.popSingle().push("[Ljava/lang/Object;",index);
            current.isKnownNonNull = true;
            break;
          case op_arraylength:
            current = current.popSingle().push("I",index);
            break;
          case op_athrow:
            current = null;
            break;
          case op_checkcast:
            t = iterator.getUnsignedInteger (0, 2);
            current = current.popSingle().push (pool.getKlass(t).getSignature(), 
              index);
            break;
          case op_instanceof:
            current = current.popSingle().push("I",index);
            break;
          case op_monitorenter:
          case op_monitorexit:
            current = current.popSingle();
            break;
            // case op_wide:
          case op_multianewarray:
            t = iterator.getUnsignedInteger (2, 1);
            for (int i=0; i<t; i++) 
            {
              current = current.popSingle();
            }
            t = iterator.getUnsignedInteger (0, 2);
            current = current.push (pool.getKlass(t).getSignature(), index);
            break;
          }
        }
        stackArray[index] = current;
      } while (iterator.iterate());

      if (rounds > nulls) 
      {
        rounds = nulls;
      }
    }
    return preStackArray;
  }

  /**
   * marks the bytecodes used in this code.
   */
  void markBytecodesUsed (boolean[] bytecodesUsed)
  {
    CodeIterator iterator = new CodeIterator (code, pool, method);

    if (codeNeeded != null) 
    {
      do 
      {
        if (codeNeeded[iterator.opcodeIndex]) 
        { 
          bytecodesUsed[iterator.opcode] = true;
        }
      } while (iterator.iterate());
    }
    else 
    {
      do 
      {
        bytecodesUsed[iterator.opcode] = true;
      } while (iterator.iterate());
    }
  }

  // TODO: isolate the 2 aspects of this method into distinct ones.
  /**
   * For a method that is globally needed, compute an array marking 
   * individual instructions as needed or unneeded. True means 'needed'.
   * As a side-effect, elements that this code depends upon
   * (e.g. fields or methods) are marked 'needed', too.
   * If the code has a 'needed' side-effect, it is marked 'needed'
   * itself (to allow for &lt;clinit&gt; methods to become needed
   * for the side-effects).
   */
  boolean[] computeInstructionsNeeded (StackEntry[] preStackArray, 
    CodeOptions options)
  {
    FieldInfo fieldInfo;
    MethodInfo methodInfo;
    TArgs args;
    String type;
    NeededInstructionsCollector coll = 
      new NeededInstructionsCollector (code.length);
    Klass ourClass = method.cls;
    boolean stdClass = ourClass.className.startsWith("java/") ||
      ourClass.className.startsWith( "javax/" ) ||
      ourClass.className.startsWith( "sun/" ) ||
      ourClass.className.startsWith("com/sun/");
    
    do 
    {
      CodeIterator iterator = new CodeIterator (code, pool, method);
      int t, u, n;
      
      do 
      {
        int op = iterator.opcode;
        int index = iterator.opcodeIndex;
        StackEntry currentStack = preStackArray[index];
        switch (op)
        {
        case op_nop:
          break;
        case op_iinc:
          coll.setNeeded (index);
          break;
        case op_aconst_null:
        case op_iconst_m1:
        case op_iconst_0:
        case op_iconst_1:
        case op_iconst_2:
        case op_iconst_3:
        case op_iconst_4:
        case op_iconst_5:
        case op_lconst_0:
        case op_lconst_1:
        case op_fconst_0:
        case op_fconst_1:
        case op_fconst_2:
        case op_dconst_0:
        case op_dconst_1:
        case op_bipush:
        case op_sipush:
        case op_ldc:
        case op_ldc_w:
        case op_ldc2_w:
          break;
        case op_iload:
        case op_iload_0:
        case op_iload_1:
        case op_iload_2:
        case op_iload_3:
        case op_lload:
        case op_lload_0:
        case op_lload_1:
        case op_lload_2:
        case op_lload_3:
        case op_fload:
        case op_fload_0:
        case op_fload_1:
        case op_fload_2:
        case op_fload_3:
        case op_dload:
        case op_dload_0:
        case op_dload_1:
        case op_dload_2:
        case op_dload_3:
        case op_aload:
        case op_aload_0:
        case op_aload_1:
        case op_aload_2:
        case op_aload_3:
          break;
        case op_iaload:
        case op_baload:
        case op_caload:
        case op_saload:
        case op_laload:
        case op_faload:
        case op_daload:
        case op_aaload:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            coll.setNeeded (currentStack.next);
            needException("java/lang/NullPointerException");
            needException("java/lang/ArrayIndexOutOfBoundsException");
          }
          break;
        case op_istore:
        case op_istore_0:
        case op_istore_1:
        case op_istore_2:
        case op_istore_3:
        case op_lstore:
        case op_lstore_0:
        case op_lstore_1:
        case op_lstore_2:
        case op_lstore_3:
        case op_fstore:
        case op_fstore_0:
        case op_fstore_1:
        case op_fstore_2:
        case op_fstore_3:
        case op_dstore:
        case op_dstore_0:
        case op_dstore_1:
        case op_dstore_2:
        case op_dstore_3:
        case op_astore:
        case op_astore_0:
        case op_astore_1:
        case op_astore_2:
        case op_astore_3:
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          break;
        case op_iastore:
        case op_fastore:
        case op_bastore:
        case op_castore:
        case op_sastore:
        case op_lastore:
        case op_dastore:
          // array store instructions are needed if the array is needed.
          if ( coll.isNeeded(index) ||
            coll.isArrayNeeded(currentStack.next.next, iterator, options.initStaticArrayData) ) 
          {
            coll.setNeeded(index);
            coll.setNeeded(currentStack);
            coll.setNeeded(currentStack.next);
            coll.setNeeded(currentStack.next.next);
            needException("java/lang/NullPointerException");
            needException("java/lang/ArrayIndexOutOfBoundsException");
          }
          break;
        case op_aastore:
          // array store instructions are needed if the array is needed.
          if ( coll.isNeeded(index) ||
            coll.isArrayNeeded(currentStack.next.next, iterator, options.initStaticArrayData) ) 
          {
            coll.setNeeded(index);
            coll.setNeeded(currentStack);
            coll.setNeeded(currentStack.next);
            coll.setNeeded(currentStack.next.next);
            needException("java/lang/NullPointerException");
            needException("java/lang/ArrayIndexOutOfBoundsException");
            needException("java/lang/ArrayStoreException");
            needAastore();
          }
          break;
        case op_pop:
        case op_pop2:
        case op_dup:
        case op_dup_x1:
        case op_dup_x2:
        case op_dup2:
        case op_dup2_x1:
        case op_dup2_x2:
        case op_swap:
          // TODO: perhaps we don't need stack manipulation
          // when it occurs within an unneeded code segment??
          coll.setNeeded (index);
          break;
        case op_iadd:
        case op_isub:
        case op_imul:
        case op_ishl:
        case op_ishr:
        case op_iushr:
        case op_iand:
        case op_ior:
        case op_ixor:
        case op_ladd:
        case op_lsub:
        case op_lmul:
        case op_lshl:
        case op_lshr:
        case op_lushr:
        case op_land:
        case op_lor:
        case op_lxor:
        case op_fadd:
        case op_fsub:
        case op_fmul:
        case op_dadd:
        case op_dsub:
        case op_dmul:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            coll.setNeeded (currentStack.next);
          }
          break;
        case op_idiv:
        case op_ldiv:
        case op_fdiv:
        case op_ddiv:
        case op_irem:
        case op_lrem:
        case op_frem:
        case op_drem:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            coll.setNeeded (currentStack.next);
          }
          needException("java/lang/ArithmeticException");
          break;
        case op_ineg:
        case op_lneg:
        case op_fneg:
        case op_dneg:
        case op_i2l:
        case op_i2f:
        case op_i2d:
        case op_l2i:
        case op_l2f:
        case op_l2d:
        case op_f2i:
        case op_f2l:
        case op_f2d:
        case op_d2i:
        case op_d2l:
        case op_d2f:
        case op_i2b:
        case op_i2c:
        case op_i2s:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
          }
          break;
        case op_lcmp:
        case op_dcmpl:
        case op_dcmpg:
        case op_fcmpl:
        case op_fcmpg:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            coll.setNeeded (currentStack.next);
          }
          break;
        case op_ifeq:
        case op_ifne:
        case op_iflt:
        case op_ifge:
        case op_ifgt:
        case op_ifle:
        case op_ifnull:
        case op_ifnonnull:
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          break;
        case op_if_icmpeq:
        case op_if_icmpne:
        case op_if_icmplt:
        case op_if_icmpge:
        case op_if_icmpgt:
        case op_if_icmple:
        case op_if_acmpeq:
        case op_if_acmpne:
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          coll.setNeeded (currentStack.next);
          break;
        case op_goto:
        case op_goto_w:
        case op_jsr:
        case op_jsr_w:
        case op_ret:
          coll.setNeeded (index);
          break;
        case op_tableswitch: 
        case op_lookupswitch: 
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          break;
        case op_ireturn:
        case op_lreturn:
        case op_freturn:
        case op_dreturn:
        case op_areturn:
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          break;
        case op_return:
          coll.setNeeded (index);
          break;
        case op_getstatic:
          if (coll.isNeeded (index)) 
          {
            FieldInfo field = pool.getFieldInfo (iterator.getUnsignedInteger(0,2));
            if (field.constantValue() == null) 
            {
              field.markNeeded(method,NEEDED);
            }
          }
          break;
        case op_putstatic:
          fieldInfo = pool.getFieldInfo (iterator.getUnsignedInteger(0,2));
          if (fieldInfo.isNeeded()) 
          {
            coll.setNeeded (index);
            coll.setNeeded (currentStack);
            method.markNeeded (fieldInfo, NEEDED);
          }
          break;
        case op_getfield:
          if (coll.isNeeded (index)) 
          {
            pool.getFieldInfo (iterator.getUnsignedInteger(0,2)).markNeeded(method,NEEDED);
            coll.setNeeded (currentStack);
            needException("java/lang/NullPointerException");
          }
          break;
        case op_putfield:
          fieldInfo = pool.getFieldInfo (iterator.getUnsignedInteger(0,2));
          if (fieldInfo.isNeeded()) 
          {
            coll.setNeeded (index);
            coll.setNeeded (currentStack);
            coll.setNeeded (currentStack.next);
            method.markNeeded (fieldInfo, NEEDED);
            needException("java/lang/NullPointerException");
          }
          break;
        case op_invokevirtual: 
          coll.setNeeded (index);
          methodInfo = pool.getMethodInfo (iterator.getUnsignedInteger (0, 2));
          methodInfo.markNeeded (method, NEEDED_VIRTUALLY);
          method.markNeeded (methodInfo, NEEDED);
          needException("java/lang/NullPointerException");
          // set needed: n arguments plus instance
          n = (new TArgs (methodInfo.signature)).argCount();
        {
          int i;
          StackEntry se;
          for (i=0, se=currentStack; i<=n; i++, se=se.next) 
          {
            coll.setNeeded (se);
          }
        }
          break;
        case op_invokespecial:
          // TODO: calling <init> only necessary if object is needed.
          methodInfo = pool.getMethodInfo (iterator.getUnsignedInteger (0, 2));
          // special case of method lookup
          if ((!methodInfo.name.equals ("<init>")) &&
            ((ourClass.access_flags & ACC_SUPER) != 0) &&
            ourClass.hasSuperclass (methodInfo.cls)) 
          {
            methodInfo = 
              ourClass.superclass.findMethod (methodInfo.name, 
              methodInfo.signature);
          }
          n = (new TArgs (methodInfo.signature)).argCount();
          // TODO: what about insane code doing all work in the constructor??
          // risky optimization only enabled by the options instance:
          // "if <init> method, only call it if instance needed."
          if ( (options.initMethodsHaveNoSideEffect || stdClass) &&
            methodInfo.name.equals ("<init>")) 
          {
            StackEntry se = currentStack;
            for (int i=0; i<n; i++) 
            {
              se = se.next;
            }
            if (coll.isNeeded (se)) 
            {
              coll.setNeeded (index);
            }
          }
          else 
          {
            coll.setNeeded (index);
          }
          if (coll.isNeeded (index)) 
          {
            methodInfo.markNeeded(method,JavaElement.NEEDED);
            method.markNeeded(methodInfo,JavaElement.NEEDED);
            needException("java/lang/NullPointerException");
            // set needed: n arguments plus instance
          {
            int i;
            StackEntry se;
            for (i=0, se=currentStack; i<=n; i++, se=se.next) 
            {
              coll.setNeeded (se);
            }
          }
          }
          break;
        case op_invokestatic:
          methodInfo = pool.getMethodInfo (iterator.getUnsignedInteger (0, 2));
          // risky optimization only enabled by the options instance:
          // "calling a local static method is only necessary 
          //	if the return-value is needed."
          if (options.localMethodsHaveNoSideEffect || stdClass) 
          {
            if ((methodInfo.cls == ourClass) &&
              ((methodInfo.access_flags & ACC_STATIC) != 0) &&
              !methodInfo.returnType().equals("V")) 
            {
              // don't declare the call 'needed'!
            }
            else 
            {
              coll.setNeeded (index);
            }
          }
          else 
          {
            coll.setNeeded (index);
          }
          if (coll.isNeeded (index)) 
          {
            methodInfo.markNeeded (method, NEEDED);
            method.markNeeded (methodInfo, NEEDED);
            // set needed: n arguments
            n = (new TArgs (methodInfo.signature)).argCount();
          {
            int i;
            StackEntry se;
            for (i=0, se=currentStack; i<n; i++, se=se.next) 
            {
              coll.setNeeded (se);
            }
          }
          }
          break;
        case op_invokeinterface:
          coll.setNeeded (index);
          methodInfo = pool.getInterfaceMethodInfo (iterator.getUnsignedInteger (0, 2));
          methodInfo.markNeeded (method, NEEDED_VIRTUALLY);
          method.markNeeded (methodInfo, NEEDED);
          needException("java/lang/NullPointerException");
          // set needed: n arguments plus instance
          n = (new TArgs (methodInfo.signature)).argCount();
        {
          int i;
          StackEntry se;
          for (i=0, se=currentStack; i<=n; i++, se=se.next) 
          {
            coll.setNeeded (se);
          }
        }
          break;
        case op_new:
          if (coll.isNeeded (index)) 
          {
            t = iterator.getUnsignedInteger (0, 2);
            pool.getKlass(t).markNeeded(method,INSTANCE_NEEDED);
          }
          break;
        case op_newarray:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            switch (iterator.getUnsignedInteger (0, 1)) 
            {
            case 4:
              Klass.forName ("[Z").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 5:
              Klass.forName ("[C").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 6:
              Klass.forName ("[F").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 7:
              Klass.forName ("[D").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 8:
              Klass.forName ("[B").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 9:
              Klass.forName ("[S").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 10:
              Klass.forName ("[I").markNeeded(method,INSTANCE_NEEDED);
              break;
            case 11:
              Klass.forName ("[J").markNeeded(method,INSTANCE_NEEDED);
              break;
            }
            needException("java/lang/NegativeArraySizeException");
          }
          break;
        case op_anewarray:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            t = iterator.getUnsignedInteger (0, 2);
            Klass elClass = pool.getKlass(t);
            Klass.forName("[" + elClass.getSignature())
              .markNeeded(method,INSTANCE_NEEDED);
            needException("java/lang/NegativeArraySizeException");
          }
          break;
        case op_arraylength:
          if (coll.isNeeded (index)) 
          {
            coll.setNeeded (currentStack);
            needException("java/lang/NullPointerException");
          }
          break;
        case op_athrow:
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          needException("java/lang/NullPointerException");
          break;
        case op_checkcast:
          if (coll.isNeeded (index)) 
          {
            t = iterator.getUnsignedInteger (0, 2);
            pool.getKlass(t).markNeeded(method, NEEDED + NEEDED_INSTANCEOF);
            coll.setNeeded (currentStack);
            needException("java/lang/ClassCastException");
          }
          break;
        case op_instanceof:
          if (coll.isNeeded (index)) 
          {
            t = iterator.getUnsignedInteger (0, 2);
            pool.getKlass(t).markNeeded(method, NEEDED + NEEDED_INSTANCEOF);
            coll.setNeeded (currentStack);
          }
          break;
        case op_monitorenter:
        case op_monitorexit:
          coll.setNeeded (index);
          coll.setNeeded (currentStack);
          break;
          // case op_wide:
        case op_multianewarray:
          if (coll.isNeeded (index)) 
          {
            t = iterator.getUnsignedInteger (0, 2);
            u = iterator.getUnsignedInteger (2, 1);
	      
            String cln;
            int i;
            StackEntry se;
            for (i=0, se=currentStack, cln=pool.getKlass(t).getSignature();
              i<u; 
              i++, se=se.next, cln=cln.substring(1)) 
            {
              Klass.forName(cln).markNeeded(method,INSTANCE_NEEDED);
              coll.setNeeded (se);
            }
            needException("java/lang/NegativeArraySizeException");
          }
          break;
        }
      } while (iterator.iterate());
    } while (coll.needsIteration());

    return coll.getArray();
  }

  /**
   * print to System.out a readable description of this code.
   */
  void report()
  {
    if ((codeNeeded == null) || (Jump.codeOptions.verbosity < 2)) 
    {
      System.out.println ("    code length: " + code.length);
    }
    else 
    {
      CodeIterator iterator = new CodeIterator (code, pool, method);
      do 
      {
        int op = iterator.opcode;
        int index = iterator.opcodeIndex;

        if (codeNeeded[index]) 
        {
          System.out.println ("	   " + index + ": " + iterator.disassemble());
        }
        else 
        {
          System.out.println ("	       (" + index + ": " + iterator.disassemble() + ")");
        }
      } while (iterator.iterate());
    }
  }
}
