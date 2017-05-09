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
    This file has been modified in 03-04/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;

class Klass extends JavaElement implements JVM {

  /** code for a normal class. */
  static final int CLASSINFO_OBJECT = 0x0000;

  /** code for a scalar-array class. */
  static final int CLASSINFO_ARRAY = 0x0001;

  /** code for an object-array class. */
  static final int CLASSINFO_ARRAYOFOBJECTS = 0x0002;

  /** hashtable: classname string -> Klass object. */
  private static Hashtable Classes = new Hashtable();

  /** vector of all Klass objects. */
  static Vector ClassList = new Vector();

  /** 
   * vector of all classes having an explicit representation 
   * in our resulting target code.
   * The field 'classIndex' is an index into this vector.
   */
  static Vector targetClassList = null;

  /** 
   * vector of all target classes for 'instanceof' checks.
   * The field 'instanceofClassIndex' is an index into this vector.
   */
  static Vector instanceofTargetClassList = new Vector();

  /** 
   * vector of all needed static fields of scalar type.
   * For these fields, 'FieldInfo.fieldIndex' is an index into this vector.
   */
  static Vector neededScalarFields = null;

  /** 
   * vector of all needed static fields of object type.
   * For these fields, 'FieldInfo.fieldIndex' is an index into this vector.
   */
  static Vector neededObjectFields = null;

  // static Vector Strings = new Vector();

  /** 
   * array giving the bytecodes used in our program.
   * 'BytecodeUsed[C] == true' means: bytecode C is used
   * at least once in the code.
   */
  static boolean[] BytecodeUsed = new boolean[256];

  int magic;
  int minor_version;
  int major_version;
  ConstantPool constant_pool;
  int access_flags;

  Klass superclass;

  Klass[] interfaces;

  /** 
   * (for a class) list of direct subclasses
   * -or- (for an interface)
   * list of subinterfaces and directly implementing classes.
   */
  Vector subclasses = null;

  FieldInfo[] fields;

  MethodInfo[] methods;

  AttributeTable attributes;

  /**
   * name of the class.
   * classname in slash-syntax for ordinary classes,
   * signature with '[' for array classes,
   * signature enclosed in dashes for primitive types.
   */
  String className;

  /**
   * the index of this class in structures like the ClassTable.
   */
  int classIndex = -1;

  /**
   * the index of this class for 'instanceof' checks.
   */
  int instanceofClassIndex = -1;

  /**
   * the index of this class for <clinit> checks.
   */
  int clinitClassIndex = -1;

  /**
   * indicates that this class or one of its subclasses is in the
   * early-init list, so don't generate dynamic class checks for it.
   */
  boolean hasEarlyInit = false;

  /**
   * indicates that this class requires has instances because the properties
   * file said so (target of Class.forName()?).
   */
  boolean propertySaysHasInstance = false;

  /**
   * data size of the instance fields, not including
   * management overhead.
   */
  int dataSize = -1;

  /**
   * number of entries in the virtual-or-interface function table for
   * this class. This field also counts the additional table entries
   * for interface methods. 
   */
  int fullVtableSize = -1;

  /**
   * the virtual-or-interface function table of this class.
   */
  Vector vtable = null;

  /**
   * the 'instanceof' compatibility array for this class.
   * <p>
   * Let <ul>
   * <li>'I' be an instance of this class</li>
   * <li>'C' be another class</li>
   * <li>'n' be the 'instanceofClassIndex' of the other class 'C' </li>
   * </ul>
   * Then 'itable[n]' is true if and only if 'I instanceof C' is true.
   * The array is only filled for classes having instances
   * (at least INSTANCE_NEEDED flag set).
   */
  boolean[] itable = null;

  /*
   *          Constructors and related methods
   * ====================================================
   */

  /**
   * construct a non-loaded class (like an array class)
   * that's completely defined by its name/Signature.
   */
  Klass(String classname)
  {
    Jump.currentElement = this;

    className = classname;
    Classes.put (classname, this);
    ClassList.addElement(this);

    magic = 0;
    minor_version = 0;
    major_version = 0;
    constant_pool = null;
    access_flags = 0;
    interfaces = null;
    fields = null;
    methods = null;
    attributes = null;
    if (classname.charAt(0) == '[') {
      // change asm "struct Array" declaration when changing this
      fields = new FieldInfo[3];
      fields[0] = new FieldInfo (this, "length",  "S");
      fields[1] = new FieldInfo (this, "elsize",  "S");
      fields[2] = new FieldInfo (this, "data",    "I");
      superclass = Klass.forName("java/lang/Object");
      superclass.addSubclass (this);

      interfaces = new Klass[2];
      interfaces[0] = Klass.forName("java/lang/Cloneable");
      interfaces[1] = Klass.forName("java/io/Serializable");

      Klass.forSignature (classname.substring(1));
    }
  }

  /**
   * construct a class from a class file
   */
  Klass(String classname, InputStream instream) throws IOException
  {
    Jump.currentElement = this;

    className = classname;
    Classes.put (classname, this);
    ClassList.addElement(this);

    DataInputStream in = new DataInputStream(instream);
    magic = in.readInt();
    minor_version = in.readShort();
    major_version = in.readShort();

    constant_pool = new ConstantPool(in);

    access_flags = in.readShort();
    
    int this_class_index = in.readShort();

    // check that the filename for the class matches the class name in case
    String this_class = constant_pool.getClassname(this_class_index);
    if ( classname.equalsIgnoreCase(this_class) && !classname.equals(this_class) )
      ASSERT.fail("Class " + classname + " not found (case mismatch)");
    // throw new FileNotFoundException("file name does not match class name");

    int super_class_index = in.readShort();
    if (super_class_index > 0) {
      superclass = 
        Klass.forName (constant_pool.getClassname(super_class_index));
      superclass.addSubclass (this);
    }

    interfaces = new Klass[in.readShort()];
    for (int i = 0; i < interfaces.length; i++) {
      int index = in.readShort();
      interfaces[i] = Klass.forName (constant_pool.getClassname(index));
      interfaces[i].addSubclass (this);
    }
    
    fields = new FieldInfo[in.readShort()];
    for (int i = 0; i < fields.length; i++) {
      fields[i] = new FieldInfo (this, constant_pool, in);
    }
    methods = new MethodInfo[in.readShort()];
    for (int i = 0; i < methods.length; i++) {
      methods[i] = new MethodInfo (this, constant_pool, in);
    }

    // added version 2.0.3
    // If class is java/lang/Object then we should remove the
    // finalize() method. We could provide or own version of
    // java/lang/Object but some versions of the SDK have
    // issues with compiling java/lang/Object (bootstrapping).
    if ( classname.equals("java/lang/Object") )
    {
      for (int i = 0; i < methods.length; i++ )
      {
        if ( methods[i].isFinalizer() )
        {
          MethodInfo meths[] = new MethodInfo[methods.length-1];
          System.arraycopy(methods, 0   ,meths,0, i);
          System.arraycopy(methods, i+1 ,meths,i, meths.length-i);
          methods = meths;
          // System.out.println( m+" removed" );
          break;
        }
      }
    }

    attributes = new AttributeTable (this, constant_pool, in);

    // available() method not usable on ZipInputStreams
    // ASSERT.check(in.available() == 0, 
    //           "Internal error: Extra data at end of " +
    //           classname + " class file");

    if (Jump.backEnd != null) {
      Jump.backEnd.insertNatives (this);
    }
  }

  /**
   * returns a class descriptor for a class with a given name.
   * The name can also be an array classname beginning with '['.
   * Classnames in dot-syntax are converted to slash-syntax.
   */
  static Klass forName (String name)
  {
    try {
      name = name.replace ('.', '/');
      
      Klass cls = (Klass)Classes.get(name);
      if (cls != null) {
        return cls;
      }

      if (name.charAt(0) == '[') {
        return new Klass(name);
      } 
      else if (name.charAt(0) == '-') {
        return new Klass(name);
      } 
      else {
        InputStream cstream = 
          Jump.getClasspathStream(name + ".class");
        if (cstream == null) {
          ASSERT.fail("Class " + name + " not found");
        }
        return new Klass(name, new BufferedInputStream(cstream));
      }
    }
    catch (Exception exc) {
      throw JumpException.addInfo(exc, "error opening class " + name);
    }
  }


  /**
   * returns a class descriptor for a given type signature.
   * Signature can be 'Lxxx;' or '[xxx' 
   * for normal classes or array classes, respectively.
   */
  static Klass forSignature (String signature)
  {
    int len = signature.length();

    if (signature.charAt(0) == 'L') {
      ASSERT.check ((signature.charAt(len-1) == ';'),
                    "malformed signature " + signature);
      return Klass.forName (signature.substring(1,len-1));
    }
    else if (signature.charAt(0) == '[') {
      return Klass.forName (signature);
    }
    else {
      return Klass.forName ("-" + signature + "-");
    }
  }

  /**
   * helper method for the contruction's phase:
   * register a subclass.
   */
  void addSubclass (Klass cl)
  {
    if (subclasses == null) {
      subclasses = new Vector();
    }
    subclasses.addElement (cl);
  }

  /*
   *        methods for the code traversal phase
   * ====================================================
   */

  /**
   * mark this class needed in a specific mode,
   * adding logically to the current mode.
   * As a side-effect, all elements that this one 
   * depends upon, are also marked 'needed' recursively.
   *
   * @param reason the reason why this element is needed
   *               (normally another JavaElement referencing this one).
   * @param mode   a mode constant describing how this element is needed.
   */
  void markNeeded (Object reason, int mode)
  {
    Jump.currentElement = this;

    if (((access_flags & ACC_ABSTRACT) != 0) &&
        ((mode & 0xff) >= INSTANCE_NEEDED)) {
      ASSERT.fail ("instances of abstract " + this + 
                   " needed for " + reason + 
                   " in mode " + mode);
    }
    super.markNeeded(reason, mode);
  }

  /**
   * update the 'needed' state of this class and the
   * elements this class depends upon.
   */
  void updateNeeded ()
  {
    Jump.currentElement = this;

    if (isNeeded(EXACT_INSTANCE_NEEDED)) {
      for (Klass sc = superclass; 
           sc != null;
           sc = sc.superclass) {
        FieldInfo[] superFields = sc.fields;
        if (superFields != null) {
          for (int i=0; i<superFields.length; i++) {
            FieldInfo fi = superFields[i];
            if ((fi.access_flags & ACC_STATIC) == 0) {
              fi.markNeeded(this, NEEDED);
            }
          }
        }
      }
    }

    // we need the classtable entry of the superclass
    // and all implemented interfaces
    // if this class has a classtable entry.
    if (isNeeded(NEEDED)) {
      if (superclass != null) {
        superclass.markNeeded(this,NEEDED);
      }
      if (interfaces != null) {
        for (int i=0; i<interfaces.length; i++) {
          interfaces[i].markNeeded(this,NEEDED);
        }
      }
    }

    // added by PMD version 2.0.3
    // if we are implementing finalizers and the class has instances
    // then if the class has a finalizer we need it virtually
    if ( Jump.codeOptions.useFinalizers && isNeeded(INSTANCE_NEEDED) )
    {
      MethodInfo m = getFinalizer();
      if ( m != null )
      {
        m.markNeeded(this, NEEDED_VIRTUALLY);
        m.intersegment = true;  // make sure we that the thunk in large and huge models
      }
    }

    // if an array class has instances, we need all its fields.
    if (isNeeded(INSTANCE_NEEDED) && (className.charAt(0) == '[')) {
      if (fields != null) {
        for (int i=0; i<fields.length; i++) {
          fields[i].markNeeded(this,NEEDED);
        }
      }
      if (className.startsWith("[[") || className.startsWith("[L")) {
        Klass.forSignature(className.substring(1)).markNeeded(this,NEEDED_INSTANCEOF);
      }
    }

    // For 'exact-layout' classes,
    // keep all instance fields (structure elements).
    if (isNeeded(EXACT_INSTANCE_NEEDED)) {
      if (fields != null) {
        for (int i=0; i<fields.length; i++) {
          if ((fields[i].access_flags & ACC_STATIC) == 0) {
            fields[i].markNeeded(this, NEEDED);
          }
        }
      }
    }
    
    if (fields != null) {
      for (int i=0; i<fields.length; i++) {
        fields[i].updateNeeded();
      }
    }
    if (methods != null) {
      for (int i=0; i<methods.length; i++) {
        methods[i].updateNeeded();
      }
    }
  }

  /**
   * do one iteration to update the 'needed' state of all elements.
   */
  static void updateAll ()
  {
    for (int i=0; i<ClassList.size(); i++) {
      ((Klass) ClassList.elementAt(i)).updateNeeded();
    }
  }

  /**
   * marks the bytecodes used in the needed methods of this class.
   */
  void markBytecodesUsed (boolean[] bytecodesUsed)
  {
    Jump.currentElement = this;

    if (methods != null) {
      for (int i=0; i<methods.length; i++) {
        if (methods[i].isNeeded(NEEDED)) {
          methods[i].markBytecodesUsed(bytecodesUsed);
        }
      }
    }
  }

  /**
   * returns an array showing all bytecodes used in all classes.
   *
   * @return a boolean array, indexed by bytecode,
   *         element='true' means that the corresponding bytecode is used.
   */
  static boolean[] getAllBytecodesUsed ()
  {
    boolean[] bytecodesUsed = new boolean[OPCODE_NAMES.length];
    for (int i=0; i<ClassList.size(); i++) {
      ((Klass) ClassList.elementAt(i)).markBytecodesUsed(bytecodesUsed);
    }
    return bytecodesUsed;
  }

  /*
   *             code generation methods
   * ====================================================
   */

  /**
   * lay out the fields of this class. This method computes
   * the address offsets for the fields for this class.
   */
  void layoutFields ()
  {
    Jump.currentElement = this;

    // if layout already done, do nothing.
    if (dataSize < 0) {
      dataSize = 0;

      // append to the superclass's layout, if present
      if (superclass != null) {
        superclass.layoutFields();
        dataSize = superclass.dataSize;
      }

      if (fields != null) {
        for (int i=0; i<fields.length; i++) {
          FieldInfo field = fields[i];

          if (field.isNeeded(NEEDED)) {
            if ((field.access_flags & ACC_STATIC) == 0) {
              // --- instance fields ---
              int fSize = field.size;

              // word-align the field if necessary
              if ((fSize > 1) && ((dataSize & 1) != 0)) {
                dataSize++;
              }

              // layout a single field
              field.offset = dataSize;
              dataSize += fSize;
            }
            else {
              // --- static fields ---
              field.offset = 0;
              switch (field.signature.charAt(0)) {
              case 'L':
              case '[':
                field.fieldIndex = neededObjectFields.size();
                neededObjectFields.addElement (field);
                break;
              case 'B':
              case 'C':
              case 'D':
              case 'F':
              case 'I':
              case 'J':
              case 'S':
              case 'Z':
                field.fieldIndex = neededScalarFields.size();
                neededScalarFields.addElement (field);
                break;
              default:
                ASSERT.fail ("unknown type " + field.signature + 
                             " at " + field);
                break;
              }
            }
          } else {
            // --- unneeded fields ---
            field.offset = Integer.MIN_VALUE;
            field.size = 0;
          }
        }
        if ((dataSize & 1) != 0) {
          dataSize++;
        }
      }
    }
  }

  /**
   * lay out the fields for all classes
   */
  static void layoutFieldsAll ()
  {
    int fieldIndex = 0;

    neededScalarFields = new Vector();
    neededObjectFields = new Vector();

    for (int j=0; j<ClassList.size(); j++) {
      Klass cl = (Klass) ClassList.elementAt(j);
      cl.layoutFields();
    }
  }

  /**
   * lay out the vtables for all classes and interfaces.
   */
  static void layoutVtableAll ()
  {
    int methodIndex = 0;

    // assign method indices to all needed methods
    for (int i=0; i<ClassList.size(); i++) {
      Klass cl = (Klass) ClassList.elementAt(i);
      if (cl.methods != null) {
        for (int j=0; j<cl.methods.length; j++) {
          MethodInfo m = cl.methods[j];
          if (m.isNeeded(NEEDED)) {
            m.methodIndex = methodIndex++;
          }
        }
      }
    }

    // collect generic methods that need vtable entries
    // and their instantiated subclasses
    Vector gms = new Vector();

    for (Enumeration enum=GenericMethod.elements();
         enum.hasMoreElements(); ) {
      GenericMethod gm = (GenericMethod) enum.nextElement();

      gm.compute();

      if (gm.needsVtable) {
        gms.addElement (gm);
      }
    }

    // sort by decreasing number of classes
    Collections.sort 
      (gms, 
       new Comparator() 
       {
         public int compare (Object o1, Object o2) {
           return (((GenericMethod) o1).instantiatedClasses.length -
                   ((GenericMethod) o2).instantiatedClasses.length);
         }
       } );
    
    // assign lowest method index available across all these classes
    for (int i=0; i<gms.size(); i++) {
      ((GenericMethod) gms.elementAt(i)).assignVtableIndex();
    }
  }
  
  /**
   * assign class indices to all needed classes.
   */
  static void assignAllClassIndices ()
  {
    Klass cl;

    targetClassList = new Vector ();

    cl = Klass.forName("java/lang/Object");
    cl.classIndex = 0;
    targetClassList.addElement (cl);

    cl = Klass.forName("java/lang/Class");
    cl.classIndex = 1;
    targetClassList.addElement (cl);

    int current = 2;
    int iCurrent = 0;
    for (int i=0; i<ClassList.size(); i++) {
      cl = (Klass) ClassList.elementAt(i);
      if (cl.isNeeded(NEEDED) && (cl.classIndex < 0)) {
        cl.classIndex = current;
        targetClassList.addElement (cl);
        current++;
      }
      if (cl.isNeeded(NEEDED_INSTANCEOF) && (cl.instanceofClassIndex < 0)) {
        cl.instanceofClassIndex = iCurrent;
        instanceofTargetClassList.addElement (cl);
        iCurrent++;
      }
    }
  }

  /**
   * compute an appropriate ordering of the needed &lt;clinit&gt; methods.
   * Superclass clinit methods have to precede those of their subclasses.
   *
   * @return vector of all &lt;clinit&gt; methods in an appropriate ordering.
   */
  static Vector clinitOrdering ()
  {
    Vector all = Klass.forName("java/lang/Object").getAllSubclasses();
    all.insertElementAt (Klass.forName ("java/lang/Object"), 0);
    Vector result = new Vector();

    for (int i=0; i<all.size(); i++) {
      Klass cl = (Klass) all.elementAt(i);
      MethodInfo m = cl.findMethod ("<clinit>","()V");
      if ((m != null) && (m.cls == cl) && m.isNeeded(NEEDED)) {
        result.addElement (m);
      }
    }
    return result;
  }

  /**
   * get the effective &lt;clinit&gt; method for this class.
   * if the class doesn't have a &lt;clinit&gt; then try its
   * superclass etc.
   * 
   * @return &lt;clinit&gt; method or null
   */
  MethodInfo getEffectiveClinit()
  {
    //  output call to next non-empty super.<clinit>
    Klass cls = this;
    while ( cls != null ) // ignore java.lang.Object
    {
      MethodInfo clinit = cls.findMethod("<clinit>","()V");
      if ( clinit == null || clinit.cls.isJavaLangObject() )
        break;
      if ( !clinit.isEmpty() )
        return clinit;
      cls = clinit.cls.superclass; // try further down
    }
    return null;
  }

  /**
   * compute the 'instanceof' class compatibility table
   * 'itable' for this class.
   */
  void fillItable ()
  {
    Jump.currentElement = this;

    if (instanceofTargetClassList != null) {
      itable = new boolean[instanceofTargetClassList.size()];
      for (int i=0; i<itable.length; i++) {
        Klass target = (Klass) instanceofTargetClassList.elementAt (i);
        itable[i] = isCastableTo (target);
      }
    }
  }

  /**
   * compute the 'instanceof' class compatibility table
   * 'itable' for all classes.
   */
  static void layoutItableAll ()
  {
    for (int i=0; i<ClassList.size(); i++) {
      Klass source = (Klass) ClassList.elementAt (i);
      if (source.isNeeded (INSTANCE_NEEDED)) {
        source.fillItable();
      }
    }
  }

  /*
   *                  helper methods
   * ====================================================
   */

  /**
   * test whether this Klass is an interface.
   */
  boolean isInterface()
  {
    return ((access_flags & ACC_INTERFACE) != 0);
  }

  /**
   * returns the classname in signature syntax.
   */
  String getSignature ()
  {
    switch (className.charAt(0)) {
    case '[': 
      return className;
    case '-': 
      return className.substring(1,2);
    default:
      return "L" + className + ";";
    }
  }

  /**
   * return method if class has a finalize() != Object.finalize()
   */
  MethodInfo getFinalizer()
  {
    // assumes finalize() has been patched out of java/lang/Object
    return findMethod( "finalize", "()V" );
  }

  /**
   * return method if class has a default constructor
   */
  MethodInfo getDefaultConstructor()
  {
    return findMethod( "<init>", "()V" );
  }

  /**
   * return whether class with instances has a finalizer
   */
  static boolean needsFinalizers()
  {
    for (int i=0; i<targetClassList.size(); i++)
    {
      Klass cls = (Klass) targetClassList.elementAt(i);
      if ( cls.isNeeded(INSTANCE_NEEDED) && cls.getFinalizer() != null )
        return true;
    }
    return false;
  }

  /**
   * finds a field with a given name.
   */
  FieldInfo findField(String name)
  {
    for (int i = 0; i < fields.length; i++) {
      if (name.equals(fields[i].name)) {
        return fields[i];
      }
    }
    return null;
  }

  /**
   * finds a method with given name and signature (exact!)
   * in this class and its superclasses.
   */
  MethodInfo findMethod(String name, String signature)
  {
    Klass cls = this;
    while (cls != null) {
      if (cls.methods != null) {
        for (int i = 0; i < cls.methods.length; i++) {
          if (name.equals(cls.methods[i].name) && 
              signature.equals(cls.methods[i].signature)) {
            return cls.methods[i];
          }
        }
      }
      cls = cls.superclass;
    }
    return null;
  }

  /**
   * finds a method with given name
   * in this class and its superclasses.
   */
  MethodInfo findMethod(String name)
  {
    Klass cls = this;
    while (cls != null) {
      for (int i = 0; i < cls.methods.length; i++) {
        if (name.equals(cls.methods[i].name)) {
          return cls.methods[i];
        }
      }
      cls = cls.superclass;
    }
    return null;
  }

  /**
   * check whether a direct instance of this class
   * can be cast to the 'target' class.
   */
  boolean isCastableTo (Klass target)
  {
    if (target == this) {
      return true;
    }

    // checkcast to an array class
    if (target.className.charAt(0) == '[') {
      return ((this.className.charAt(0) == '[') &&
              Klass.forSignature(this.className.substring(1))
              .isCastableTo(Klass.forSignature(target.className.substring(1))));
    }
    else {
      return this.hasSuperclass(target);
    }
  }

  /**
   * check whether this class has a given class as direct or 
   * indirect superclass.
   */
  boolean hasSuperclass (Klass sup)
  {
    if (!isInterface()) {
      if (superclass == sup) {
        return true;
      }
      if ((superclass != null) && 
          (superclass.hasSuperclass (sup))) {
        return true;
      }
    }
    if (interfaces != null) {
      for (int i=0; i<interfaces.length; i++) {
        if (interfaces[i] == sup) {
          return true;
        }
        if (interfaces[i].hasSuperclass (sup)) {
          return true;
        }
      }
    }
    return false;
  }

  /**
   * return a Vector of all superclasses and implemented interfaces.
   */
  Vector getAllSuperclasses () 
  {
    Vector result = new Vector();
    addAllSuperclasses (result);
    return result;
  }

  private void addAllSuperclasses (Vector coll) 
  {
    if ((superclass != null) && !coll.contains(superclass)) {
      coll.addElement (superclass);
      superclass.addAllSuperclasses (coll);
    }
    if (interfaces != null) {
      for (int i=0; i<interfaces.length; i++) {
        if (!coll.contains(interfaces[i])) {
          coll.addElement (interfaces[i]);
          interfaces[i].addAllSuperclasses (coll);
        }
      }
    }
  }

  /**
   * return a Vector of all (currently known) subclasses.
   * For an interface, all sub-interfaces and implementing
   * classes are returned.
   */
  Vector getAllSubclasses () 
  {
    Vector result = new Vector();
    addAllSubclasses (result);
    return result;
  }

  private void addAllSubclasses (Vector coll) 
  {
    if (subclasses != null) {
      for (int i=0; i<subclasses.size(); i++) {
        Klass cls = (Klass) subclasses.elementAt(i);
        if (!coll.contains (cls)) {
          coll.addElement (cls);
          cls.addAllSubclasses (coll);
        }
      }
    }
  }

  /**
   * return true if an instance can exist that satisfies
   * 'instanceof <i>&lt;this class&gt;</i>.
   */
  boolean hasInstances()
  {
    Vector subclasses = getAllSubclasses();
    subclasses.addElement (this);

    for (int i=0; i<subclasses.size(); i++) {
      if (((Klass) subclasses.elementAt(i)).isNeeded(INSTANCE_NEEDED)) {
        return true;
      }
    }
    return false;
  }

  /** return whether this class ins java.lang.Object */
  boolean isJavaLangObject()
  {
    // return className.equals("java/lang/Object");
    return superclass == null;
  }


  /*
   *               debugging methods
   * ====================================================
   */

  /** the full name of this class. */
  public String toString()
  {
    return ((isInterface() ? "Interface " : "Class ") + 
            className);
  }

  /** alignment */
  void alignment()
  {
    int firstObjectOffset = 65536, lastObjectOffset = -1, alignment=0;
    Klass cls = this;
    String name = cls.toString();
    if ( dataSize > 0 )
    {
      do
      {
        if ( cls.fields != null )
        {
          for (int i=0; i<cls.fields.length; i++)
          {
            FieldInfo f = cls.fields[i];
            char sig = f.signature.charAt(0);
            if ( f.isNeeded(NEEDED) &&
              (f.access_flags & ACC_STATIC) == 0 &&
              (sig == 'L' || sig == '[') )
            {
              if ( f.offset > lastObjectOffset )
                lastObjectOffset = f.offset;
              if ( f.offset < firstObjectOffset )
                firstObjectOffset = f.offset;
              alignment |= f.offset;
            }
          }
        }
        cls = cls.superclass;
      } while ( cls != null );

      if ( firstObjectOffset > lastObjectOffset )
      {
        System.out.println( name + " no sub-objects size=" + dataSize );
      }
      else
      {
        alignment = (alignment & 3) != 0 ? 2 : 4;
        System.out.println( name + " start=" + firstObjectOffset +
          " end=" + lastObjectOffset +
          " alignment=" + alignment +
          " size=" + dataSize );
      }
    }
  }

  void report()
  {
    System.out.println ("=======================================");
    System.out.println (this);

    if (superclass != null) {
      System.out.println ("   extends " + superclass.className);
    }
    if ((interfaces != null) &&
        (interfaces.length >= 1)) {
      System.out.print ("   implements " + interfaces[0].className);
      for (int i=1; i<interfaces.length; i++) {
        System.out.print (", " + interfaces[i].className);
      }
      System.out.println();
    }

    if (isNeeded(INSTANCE_NEEDED)) {
      System.out.println ("      (has instances)");
    }

    if (isNeeded(NEEDED_INSTANCEOF)) {
      System.out.println ("      (instanceof target)");
    }

    System.out.println ("   [generate: " + isNeeded(NEEDED) + "]");

    if (Jump.codeOptions.verbosity >= 2) {
      if (isNeeded(NEEDED)) {
        for (int i=0; i<neededReasons.size(); i++) {
          System.out.println ("    needed for " + neededReasons.elementAt(i));
        }
      }
    }

    if (fields != null) {
      System.out.println();
      System.out.println ("   === Fields ===");
      for (int i=0; i<fields.length; i++) {
        if (fields[i].isNeeded(NEEDED) || (Jump.codeOptions.verbosity >= 2)) {
          fields[i].report();
        }
      }
    }

    if (methods != null) {
      System.out.println();
      System.out.println ("   === Methods ===");
      for (int i=0; i<methods.length; i++) {
        if (methods[i].isNeeded(NEEDED) || (Jump.codeOptions.verbosity >= 2)) {
          methods[i].report();
        }
      }
    }

    if (vtable != null) {
      System.out.println ("   === Vtable ===");
      for (int i=0; i<vtable.size(); i++) {
        System.out.println ("    " + i + ": " + (MethodInfo) vtable.elementAt(i));
      }
    }
  }

  /**
   * print to System.out a report on all classes and their elements.
   */
  static void reportAll()
  {
    for (int i=0; i<ClassList.size(); i++) {
      ((Klass) ClassList.elementAt(i)).report();
    }
  }

}
