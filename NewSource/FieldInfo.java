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

class FieldInfo extends JavaElement implements JVM 
{
  int access_flags = 0;
  AttributeTable attributes = null;
  ConstantPool pool;
  Klass cls;
  String name;
  String signature;
  boolean inStaticInitializer = false;

  /** 
   * the (globally unique) index of this needed static field.
   * Unneeded or instance fields have -1.
   */
  int fieldIndex = -1;

  /** offset of this field in the instance's layout. */
  int offset;

  /** byte size of this field. */
  int size;

  /**
   * create a FieldInfo for a 'normal' field.
   * It's a non-static field with default access.
   *
   * @param cls       description of the defining class
   * @param name      name of field
   * @param signature the field's type signature
   */
  FieldInfo (Klass cls, String name, String signature)
  {
    Jump.currentElement = this;

    this.access_flags = 0;
    this.attributes = null;
    this.cls = cls;
    this.name = name;
    this.signature = signature;
    size = computeSize();
  }

  /**
   * create a FieldInfo from a section of a class file.
   * The FieldInfo is filled by reading from a stream.
   * On entry, the stream is positioned to the beginning
   * of the field_info structure. The method leaves the
   * stream positioned immediately after the end of
   * this structure.
   *
   * @param cls   description of the defining class
   * @param pool  the constant pool - already read from the class file
   * @param in    the stream to read exactly 1 field_info structure from
   */
  FieldInfo (Klass cls, ConstantPool pool, DataInput in) throws IOException
  {
    Jump.currentElement = this;

    this.cls = cls;
    this.pool = pool;
    this.access_flags = in.readShort();
    this.name = pool.getString(in.readShort());
    this.signature = pool.getString(in.readShort());
    this.attributes = new AttributeTable (this, pool, in);
    size = computeSize();
  }

  /**
   * compute the byte size of this field.
   */
  int computeSize ()
  {
    switch (signature.charAt(0)) 
    {
    case 'B':
    case 'Z':
      return 1;
    case 'C':
      return Jump.CHARSIZE;
    case 'S':
      return 2;
    case 'F':
    case 'I':
    case 'L':
    case '[':
      return 4;
    case 'D':
    case 'J':
      return 8;
    default:
      ASSERT.fail("Unknown field data type signature (" + 
        this + " ): " + signature);
      return 0;
    }
  }

  /**
   * get the constant value of this field, or null.
   *
   * @return a Boolean, Byte, Short, Integer, Long, Float,
   *         Double, or String containing the constant value,
   *         or null, if there is no such constant value.
   */
  Object constantValue ()
  {
    int idx = attributes.constantValueIndex;

    if (idx < 0) 
    {
      return null;
    }
    else if (signature.equals ("Ljava/lang/String;")) 
    {
      return cls.constant_pool.getString(idx);
    }
    else switch (signature.charAt(0)) 
         {
         case 'B':
         case 'Z':
         case 'C':
         case 'S':
         case 'I':
           return new Integer (cls.constant_pool.getInteger (idx));
         case 'J':
           return new Long (cls.constant_pool.getLong (idx));
         case 'F':
           return new Float (cls.constant_pool.getFloat (idx));
         case 'D':
           return new Double (cls.constant_pool.getDouble (idx));
         default:
           ASSERT.fail("Unknown constant-field data type signature (" + 
             this + " ): " + signature);
           return null;
         }
  }

  /**
   * update the 'needed' state of this field and all related elements.
   * <p>
   * If non-static field is needed, its class is needed, too.
   * We also need the class for the field's declared type.
   */
  void updateNeeded ()
  {
    Jump.currentElement = this;

    if (isNeeded(NEEDED)) 
    {
      if ((access_flags & ACC_STATIC) == 0) 
      {
        cls.markNeeded(this,NEEDED);
      }
      Klass.forSignature(signature).markNeeded(this,NEEDED);
    }
  }

  /**
   * the short label of this static field.
   */
  String shortLabel() 
  {
    if (fieldIndex < 0) 
    {
      ASSERT.fail ("trying to access deleted field " + this);
    }
    switch (signature.charAt(0)) 
    {
    case 'L':
    case '[':
      return "SOF" + fieldIndex;
    case 'B':
    case 'C':
    case 'D':
    case 'F':
    case 'I':
    case 'J':
    case 'S':
    case 'Z':
      return "SF" + fieldIndex;
    default:
      ASSERT.fail ("unknown type " + signature + 
        " at " + this);
      return null;
    }
  }

  /** field name, prefixed by class */
  public String toString()
  {
    return (cls.className + "." + name);
  }

  void report()
  {
    if (isNeeded()) 
    {
      if ((access_flags & ACC_STATIC) != 0) 
      {
        System.out.print ("static ");
      }
      if ((access_flags & ACC_FINAL) != 0) 
      {
        System.out.print ("final ");
      }
      System.out.println ("Field " + cls.className + "." + 
        name + ":" + signature);
      System.out.println ("    " + size + " bytes at +" + offset);
    }
    else 
    {
      System.out.println ("  [unneeded field " + cls.className + "." + 
        name + ":" + signature + "]");
    }

    if (Jump.codeOptions.verbosity >= 2) 
    {
      if (isNeeded()) 
      {
        for (int i=0; i<neededReasons.size(); i++) 
        {
          System.out.println ("      needed for " + neededReasons.elementAt(i));
        }
      }
    }

  }
}
