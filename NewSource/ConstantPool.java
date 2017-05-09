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

/*
    This file has been modified on 6 May 2002
    by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    to make Jump handle version 1.2 class files. This involves
    following the class hierarch when searching for fields,
    methods and interfaces.
    Thanks to Greg and Ralf!
*/

import java.io.*;
import java.util.*;

class ConstantPool implements JVM {
  cp_info[] table;

  ConstantPool(DataInput in) throws IOException
  {
    int count = in.readShort();
    table = new cp_info[count];
    table[0] = null;
    for (int i = 1; i < count; i++) {
      int tag = in.readByte();
      switch (tag) {
        case CONSTANT_Class:
          table[i] = new CONSTANT_Class_info(in);
          break;
        case CONSTANT_Fieldref:
          table[i] = new CONSTANT_Fieldref_info(in);
          break;
        case CONSTANT_Methodref:
          table[i] = new CONSTANT_Methodref_info(in);
          break;
        case CONSTANT_InterfaceMethodref:
          table[i] = new CONSTANT_InterfaceMethodref_info(in);
          break;
        case CONSTANT_String:
          table[i] = new CONSTANT_String_info(in);
          break;
        case CONSTANT_Integer:
          table[i] = new CONSTANT_Integer_info(in);
          break;
        case CONSTANT_Float:
          table[i] = new CONSTANT_Float_info(in);
          break;
        case CONSTANT_Long:
          table[i] = new CONSTANT_Long_info(in);
          i++;
          table[i] = null;
          break;
        case CONSTANT_Double:
          table[i] = new CONSTANT_Double_info(in);
          i++;
          table[i] = null;
          break;
        case CONSTANT_NameAndType:
          table[i] = new CONSTANT_NameAndType_info(in);
          break;
        case CONSTANT_Utf8:
          table[i] = new CONSTANT_Utf8_info(in);
          break;
        case CONSTANT_Unicode:
          table[i] = new CONSTANT_Unicode_info(in);
          break;
        default:
          ASSERT.fail("Unknown constant pool tag: " + tag);
          break;
      }
    }
    for (int i = 1; i < count; i++) {
      if (table[i] != null) {
        table[i].resolveStrings(this);
      }
    }
  }

  /**
   * get the type signature of a java language constant 
   * stored in the constant pool at the given index.
   * Returns null if entry isn't a java language constant
   * (e.g. entry is a methodref info).
   */
  String getSignature(int index)
  {
    switch (table[index].tag) {
    case CONSTANT_Class:
    case CONSTANT_Fieldref:
    case CONSTANT_Methodref:
    case CONSTANT_InterfaceMethodref:
    case CONSTANT_NameAndType:
    case CONSTANT_Utf8:
    case CONSTANT_Unicode:
      return null;
    case CONSTANT_String:
      return "Ljava/lang/String;";
    case CONSTANT_Integer:
      return "I";
    case CONSTANT_Float:
      return "F";
    case CONSTANT_Long:
      return "J";
    case CONSTANT_Double:
      return "D";
    default:
      ASSERT.fail("Unknown constant pool tag: " + table[index].tag);
      return null;
    }
  }

  /** get the integer value at a given index. */
  int getInteger (int index)
  {
    return ((CONSTANT_Integer_info)table[index]).bytes;
  }

  /** get the float value at a given index. */
  float getFloat (int index)
  {
    return ((CONSTANT_Float_info)table[index]).bytes;
  }

  /** get an int-bits version of the float value at a given index. */
  int getFloatAsIntBits (int index)
  {
    return Float.floatToIntBits (((CONSTANT_Float_info)table[index]).bytes);
  }

  /** get the long value at a given index. */
  long getLong (int index)
  {
    return ((CONSTANT_Long_info)table[index]).bytes;
  }

  /** get the double value at a given index. */
  double getDouble (int index)
  {
    return ((CONSTANT_Double_info)table[index]).bytes;
  }

  /** get an long-bits version of the double value at a given index. */
  long getDoubleAsLongBits (int index)
  {
    return Double.doubleToLongBits (((CONSTANT_Double_info)table[index]).bytes);
  }

  /** check for the entry being a String. */
  boolean isString(int index)
  {
    return (table[index] instanceof CONSTANT_String_info);
  }

  /** get a string from a CONSTANT_Utf8_info or CONSTANT_String_info entry */
  String getString(int index)
  {
    int index2;
    switch (table[index].tag) {
    case CONSTANT_String:
      return ((CONSTANT_String_info)table[index]).string;
    case CONSTANT_Utf8:
      return ((CONSTANT_Utf8_info)table[index]).string;
    default:
      ASSERT.fail ("ConstantPool index " + index + 
                   " isn't a String or UTF8 constant.");
      return null;
    }
  }

  /** 
   * find the constant pool index of a given String. 
   *
   * @param string the string we are looking for.
   * @return the index of the constant pool entry for that string,
   *         or -1, if no such constant pool entry.
   */
  int findStringIndex (String string)
  {
    for (int i=0; i<table.length; i++) {
      if ((table[i] instanceof CONSTANT_Utf8_info) &&
          (((CONSTANT_Utf8_info)table[i]).string.equals(string))) {
        return i;
      }
    }
    return -1;
  }

  /** get the classname for a CONSTANT_Class_info entry */
  String getClassname(int index)
  {
    return ((CONSTANT_Class_info)table[index]).name;
  }

  /** 
   * find the constant pool index of a class with a given name. 
   *
   * @param classname the classname in slash-syntax.
   * @return the index of the constant pool entry for that classname,
   *         or -1, if no such constant pool entry.
   */
  int findClassnameIndex (String classname)
  {
    for (int i=0; i<table.length; i++) {
      if ((table[i] instanceof CONSTANT_Class_info) &&
          (((CONSTANT_Class_info)table[i]).name.equals(classname))) {
        return i;
      }
    }
    return -1;
  }

  /** 
   * find the constant pool index of a given class. 
   *
   * @param cl the class to search for.
   * @return the index of the constant pool entry for that classname,
   *         or -1, if no such constant pool entry.
   */
  int findClassnameIndex(Klass cl)
  {
    if (cl == null) {
      return 0;
    }
    else {
      return findClassnameIndex (cl.className);
    }
  }

  /** get the class descriptor for a CONSTANT_Class_info entry */
  Klass getKlass(int index)
  {
    Klass kl = Klass.forName(((CONSTANT_Class_info)table[index]).name);
    if (kl == null) {
      ASSERT.fail("Class " + ((CONSTANT_Class_info)table[index]).name + 
                  " (constant pool index " + index + ") not found.");
    }
    return kl;
  }

  /** get a FieldInfo from a CONSTANT_Fieldref_info entry */
  FieldInfo getFieldInfo(int index)
  {
    CONSTANT_Fieldref_info cpe = (CONSTANT_Fieldref_info) table[index];

    // since version 1.2 we need to search the class hierarch for fields
    Klass cls = Klass.forName(cpe.class_name);
    FieldInfo fi;
    do
    {
      fi = cls.findField(cpe.name);
      if ( fi != null )
        return fi;
      cls = cls.superclass;
    } while ( cls != null );
    ASSERT.fail("Field " + cpe.class_name + "." + cpe.name +
        " (constant pool index " + index + ") not found.");
    return null;
  }

  /**
   * get a MethodInfo from a CONSTANT_Methodref_info 
   * or a CONSTANT_InterfaceMethodref_info entry 
   */
  MethodInfo getMethodInfo(int index)
  {
    try
    {
      CONSTANT_Methodref_info cpe = (CONSTANT_Methodref_info) table[index];
      // since version 1.2 we need to search the class hierarch for methods
      Klass cls = Klass.forName(cpe.class_name);
      MethodInfo mi;
      do
      {
        mi = cls.findMethod(cpe.name, cpe.signature);
        if (mi != null) 
          return mi;
        cls = cls.superclass;
      } while ( cls != null );
      ASSERT.fail("Method " + cpe.class_name + "." + cpe.name +
        " (constant pool index " + index + ") not found."); 
      return null;
    }
    catch (ClassCastException ex)
    {
      return getInterfaceMethodInfo(index);
    }
  }

  /** get a MethodInfo from a CONSTANT_InterfaceMethodref_info entry */
  MethodInfo getInterfaceMethodInfo(int index)
  {
    CONSTANT_InterfaceMethodref_info cpe = 
      (CONSTANT_InterfaceMethodref_info) table[index];

    // since version 1.2 we need to search the class hierarch for interfaces
    Klass cls = Klass.forName(cpe.class_name);
    MethodInfo mi;
    do
    {
      mi = cls.findMethod(cpe.name, cpe.signature);
      if (mi != null)
        return mi;
      cls = cls.superclass;
    } while ( cls != null );
    ASSERT.fail("Method " + cpe.class_name + "." + cpe.name +
      " (constant pool index " + index + ") not found."); 
    return null;
  }

  /** 
   * find the constant pool index of a given NameAndType entry. 
   *
   * @param name      the name to search for.
   * @param signature the type to search for.
   * @return the index of the constant pool entry,
   *         or -1, if no such constant pool entry.
   */
  int findNameAndTypeIndex(String name, String signature)
  {
    for (int i=0; i<table.length; i++) {
      if ((table[i] instanceof CONSTANT_NameAndType_info)) {
        CONSTANT_NameAndType_info cni = 
          (CONSTANT_NameAndType_info) table[i];
        if ((cni.name.equals(name)) &&
            (cni.signature.equals(signature))) {
          return i;
        }
      }
    }
    return -1;
  }

}
