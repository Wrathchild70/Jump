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
    This file has been modified in 03-09/2000 
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

class MethodInfo extends JavaElement implements JVM {
  Klass cls;
  ConstantPool pool;
  int access_flags;
  AttributeTable attributes;
  String name;
  String signature;

  /** 
   * reference to a native implementation of this method. 
   * Details are visible only to the appropriate back-end.
   * If 'nativeRef' is non-null, JVM bytecode for this 
   * method is ignored.
   */
  Object nativeRef = null;

  /**
   * for native methods, the fields / methods / classes it 
   * uses / calls / instantiates.
   */
  Vector dependencies = null;

  /** the generic method that this method belongs to. */
  GenericMethod genericMethod = null;

  /** 
   * If 'this' method is 'needed_virtually', this field can hold the 
   * effective method for virtual invocations if it is always
   * the same method in all possible cases (this 'invokevirtual'
   * needs no virtual function table).
   * Otherwise, the field is 'null'.
   * The 'effective method' is not necessarily 'this' method.
   * If non-null, an invokevirtual call of 'this' method can be 
   * compiled to a non-virtual call of the 'effective method'.
   */
  MethodInfo effectiveMethod = null;

  /**
   * flag: has effective method been computed?
   */
  boolean effectiveMethodComputed = false;

  /**
   * This method's index in virtual function tables.
   * For class methods, a pointer to the method can always be found
   * at this index in the vtable of all classes containing this method.
   * For interface methods, it's more complicated.
   * For every interface / implementing class pair, we find a vtable 
   * offset in the interface data structures. Adding this offset to
   * the method's index, we get the index into the vtable.
   * So, the vtable layout of a class begins with the inherited vtable
   * of the superclass, then contains extensions for its own methods,
   * then has a section for the first interface's methods, then for
   * the second, and so on.
   * If there are no virtual calls to this method, the index is -1.
   * It is no contradiction to have both, an 'effective method' and
   * a 'vtable index'.
   */
  int vtableIndex = -1;

  /**
   * the (globally unique) index of this needed method.
   * Unneeded methods have -1.
   */
  int methodIndex = -1;

  /**
   * indicates that the method has no useful code.
   * code could be a ret or a single call of empty code.
   * used to speed up isEmpty().
   */
  private boolean empty = false;

  /**
   * indicates the segment that this method has been allocated to.
   * used to try to avoid intersegment vectoring when the method
   * is in the same segment.
   */
  int segno = 0;

  /**
   * indicates that the method has been accessed via an inter-segment call.
   */
  boolean intersegment = false;

  /**
   * create a MethodInfo from a section of a class file.
   * The MethodInfo is filled by reading from a stream.
   * On entry, the stream is positioned to the beginning
   * of the 'method_info' structure. The method leaves the
   * stream positioned immediately after the end of
   * this structure.
   *
   * @param cls   description of the defining class
   * @param pool  the constant pool - already read from the class file
   * @param in    the stream to read exactly 1 'method_info' structure from
   */
  MethodInfo (Klass cls, ConstantPool pool, DataInput in) throws IOException
  {
    this.cls = cls;
    this.pool = pool;
    this.access_flags = in.readShort();
    this.name = pool.getString(in.readShort());
    this.signature = pool.getString(in.readShort());
    this.attributes = new AttributeTable (this, pool, in);

    if ((this.access_flags & ACC_STATIC) == 0) {
      GenericMethod.register (this);
    }

  }

  /** reports whether this method is a finalizer */
  boolean isFinalizer()
  {
    // added for version 2.0.3
    return name.equals("finalize") && signature.equals("()V");
  }


  /**
   * Reports whether the method is empty.
   * Tests if it is a single return or a single call to an empty method.
   * This catches many <init> calls that do nothing.
   * Native methods are assumed not be empty.
   */
  boolean isEmpty()
  {
    CodeAttribute code = attributes.code;
    if ( !empty && Jump.codeOptions.optimization > 4 && nativeRef == null && code != null && code.code != null )
    {
      if ( code.code.length == 1 )
        empty = true;
      else if ( code.code.length == 5 && code.code[0] == op_aload_0 &&
           ( code.code[1] == (byte)op_invokespecial || code.code[1] == (byte)op_invokevirtual ) )
      {
        // looks like a method that only calls one method, is it empty.
        CodeIterator iterator = new CodeIterator(code.code, cls.constant_pool, this);
        iterator.iterate(); // skip aload_0
        // must be invokespecial
        MethodInfo m = cls.constant_pool.getMethodInfo( iterator.getUnsignedInteger(0,2) );
        empty = m.isEmpty();
      }
    }
    return empty;
  }

  /**
   * mark this method as empty.
   */
  void setEmpty()
  {
    empty = true;
  }

  /**
   * add a native implementation to this method. 
   * This call also registers the native implementation's dependencies:
   * <ul>
   * <li>the fields being set or read in the native code,</li>
   * <li>the methods being called (direct calls, no virtual functions),</li>
   * <li>the classes being instantiated.</li>
   * </ul>
   *
   * @param nativeRef    a reference to the implementation,
   *                     to be used by the back-end.
   * @param dependencies a vector of fields, methods and classes 
   *                     used in the native implementation.
   */
  void makeNative (Object nativeRef, Vector dependencies)
  {
    this.nativeRef = nativeRef;
    this.dependencies = dependencies;
  }

  /**
   * update the 'needed' state of this method and 
   * related elements.
   */
  void updateNeeded ()
  {
    try {
      Jump.currentElement = this;
      if (isNeeded(NEEDED)) {
        if ((access_flags & ACC_ABSTRACT) != 0) {
          ASSERT.fail ("abstract method " + this + " needed by some element!!!");
        }
      
        cls.markNeeded (this, NEEDED);
      
        TArgs arglist = new TArgs(signature);
        for (int i=0; i<arglist.argCount(); i++) {
          Klass.forSignature(arglist.arg(i));
        }
        Klass.forSignature(arglist.ret());
      }

      if (isNeeded(NEEDED_VIRTUALLY)) {
        Vector subclasses = cls.getAllSubclasses();
        subclasses.addElement (cls);

        // for all instantiated subclasses,
        // their version of this method is needed.
        for (int i=0; i<subclasses.size(); i++) {
          Klass cl = (Klass) subclasses.elementAt(i);
          if (cl.isNeeded(INSTANCE_NEEDED)) {
            cl.findMethod (name, signature). markNeeded(this, NEEDED);
          }
        }
      }
      if (nativeRef != null) {
        if (isNeeded(NEEDED)) {
          for (int i=0; i<dependencies.size(); i++) {
            Object dep = dependencies.elementAt(i);
            if (dep instanceof JavaElement) {
              ((JavaElement) dep).markNeeded (this, NEEDED);
            }
            else if (dep instanceof DependencyInfo) {
              DependencyInfo di = (DependencyInfo) dep;
              di.element.markNeeded (this, di.mode);
            }
          }
        }
      }
      else if (attributes.code != null) {
        attributes.code.updateNeeded();
      }
    }
    catch (Exception exc) {
      throw JumpException.addInfo(exc, "resolving dependencies of " + this);
    }
  }

  /** Determine if a method is a simple 'getter'.
   * If so, return the FieldInfo for the field to load else
   * return null. Both instance and static getters are
   * possible.
   */
  FieldInfo getGetterField()
  {
    if ( argStackSize() == 0
      && nativeRef == null
      && attributes != null
      && attributes.code != null )  // fix for missing natives, 2.1.4
    {
      if ( (access_flags & ACC_STATIC) == 0 )
      {
        // instance field
        if ( attributes.code.code.length == 5 )
        {
          CodeIterator iterator = new CodeIterator(attributes.code.code, pool, this);
          if ( iterator.opcode == op_aload_0 )
          {
            iterator.iterate();
            if ( iterator.opcode == op_getfield )
            {
              int tt = iterator.getUnsignedInteger(0, 2);
              FieldInfo f = pool.getFieldInfo(tt);
              if ( f.size <= 4 )
                return f;
            }
          }
        }
      }
      else
      {
        // static field
        if ( attributes.code.code.length == 4 )
        {
          CodeIterator iterator = new CodeIterator(attributes.code.code, pool, this);
          if ( iterator.opcode == op_getstatic )
          {
            int tt = iterator.getUnsignedInteger(0, 2);
            FieldInfo f = pool.getFieldInfo(tt);
            if ( f.size <= 4 && f.constantValue() == null )
              return f;
          }
        }
      }
    }
    return null;
  }
    
  /**
   * marks the bytecodes used in this method.
   */
  void markBytecodesUsed (boolean[] bytecodesUsed)
  {
    Jump.currentElement = this;
    if ((nativeRef == null) && (attributes.code != null)) {
      attributes.code.markBytecodesUsed (bytecodesUsed);
    }
  }

  /**
   * check whether this 'neededVirtual' method has a single
   * effective method for all possible cases.
   * If so, return that method, otherwise, return null.
   */
  MethodInfo getEffectiveMethod ()
  {
    if (effectiveMethodComputed) {
      return effectiveMethod;
    }
    else {
      Vector allSubclasses = cls.getAllSubclasses();
      allSubclasses.addElement (cls);
      MethodInfo result = null;
      
      for (int i=0; i<allSubclasses.size(); i++) {
        Klass subcl = (Klass) allSubclasses.elementAt(i);
        if (subcl.isNeeded(INSTANCE_NEEDED)) {
          MethodInfo subMethod = subcl.findMethod (name, signature);
          if (result == null) {
            result = subMethod;
          }
          else if (result != subMethod) {
            effectiveMethod = null;
            effectiveMethodComputed = true;
            return null;
          }
        }
      }
      // PMD 2.1.7 don't complain about abstract class/method since this is normal.
      if (result == null &&
        ( access_flags & ACC_ABSTRACT ) == 0 &&
        ( cls.access_flags & ACC_ABSTRACT ) == 0 &&
        !Jump.codeOptions.knownCalledVirtuallyWithoutInstances(cls)) {
        System.out.println ("--- WARNING --- : " + this + 
                            " called virtually without any instances!?");
      }
      effectiveMethod = result;
      effectiveMethodComputed = true;
      return result;
    }
  }

  /**
   * the short label of this method.
   */
  String shortLabel() 
  {
    if (methodIndex < 0 || isEmpty() )
      return "M_none";
    else
      return "M" + methodIndex;
  }

  /**
   * short name of this method (package/class.method).
   */
  String shortName() 
  {
    return cls.className + "." + name;
  }

  /**
   * generic name of this method (method(args)result).
   */
  String genericName() 
  {
    return name + signature;
  }

  /**
   * full name of this method (package/class.method(args)result).
   */
  String fullName() 
  {
    return cls.className + "." + name + signature;
  }

  /** the full name of this method, prefixed by "Method ". */
  public String toString()
  {
    String sig = signature;
    try {
      if (sig.length() > 60) {
        sig = "(..." + sig.substring (sig.indexOf (')'));
      }
    }
    catch (Exception e) {
      sig = "(???)???";
    }
    return "Method " + cls.className + "." + name + sig;
  }

  /** 
   * the stack size (in 32-bit-units) needed for the method arguments. 
   * The instance ('this' object) is not counted. 
   */
  int argStackSize()
  {
    return (new TArgs (signature)).words();
  }

  /** 
   * the return-type signature.
   */
  String returnType()
  {
    return (new TArgs (signature)).ret();
  }

  /** 
   * the return-type signature.
   */
  boolean hasObjectArg()
  {
    return (new TArgs (signature)).hasObjectArg();
  }

  /**
   * print to System.out a readable description of this method.
   */
  void report()
  {
    if (isNeeded(NEEDED)) {
      if ( (access_flags & ACC_STATIC) != 0 )
      System.out.print ("static ");

      System.out.print ("Method " + cls.className + "." + 
                        name + signature);
      if (isNeeded(NEEDED_VIRTUALLY)) {
        System.out.print ("    (virtual invocation)");
      }
      System.out.println();
      if (nativeRef != null) {
        System.out.println ("    --- have native code ---");
      }
      else if (attributes.code != null) {
        attributes.code.report();
      }
    }
    else if (isNeeded(NEEDED_VIRTUALLY)) {
      System.out.println ("    [virtually needed Method " + cls.className + "." + 
                          name + signature + "]");
    }

    if (Jump.codeOptions.verbosity >= 2) {
      if (isNeeded()) {
        for (int i=0; i<neededReasons.size(); i++) {
          System.out.println ("      needed for " + neededReasons.elementAt(i));
        }
      }
    }

    if (isNeeded() && (vtableIndex >= 0)) {
      System.out.println ("  vtable = " + vtableIndex);
    }
    if (effectiveMethod != null) {
      System.out.println ("  effective method = " + effectiveMethod);
    }
  }

}
