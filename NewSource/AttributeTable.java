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

class AttributeTable {
  /** the class, field or method where these attributes belong to. */
  Object obj;

  /** the constant pool that this table refers to */
  ConstantPool pool = null;

  /** source file name */
  String sourceFile = null;

  /** the index into the constant pool for the constant value of a static field. */
  int constantValueIndex = -1;

  /** the code of a method (includes ExceptionTable) */
  CodeAttribute code = null;

  /** a method's Exception classnames from the 'throws' clause. */
  String[] exceptions = null;

  /** Hashtable of the other attributes, if present. */
  Hashtable otherAttributes = new Hashtable();

  AttributeTable (Object obj, ConstantPool pool, DataInput in) throws IOException
  {
    this.obj = obj;
    this.pool = pool;
    int count = in.readShort();
    for (int i = 0; i < count; i++) {
      int attribute_name = in.readShort();
      int attribute_length = in.readInt();
      String name = pool.getString(attribute_name);

      if (name.equals("SourceFile")) {
	sourceFile = pool.getString (in.readShort());
      } 
      else if (name.equals("ConstantValue")) {
	constantValueIndex = in.readShort();
      } 
      else if (name.equals("Code")) {
        code = new CodeAttribute(obj, pool, in);
      } 
      else if (name.equals("Exceptions")) {
	exceptions = new String[in.readShort()];
	for (int j=0; j<exceptions.length; j++) {
	  exceptions[j] = pool.getClassname(in.readShort());
	}
      } 
      else {
	byte[] attrib = new byte[attribute_length];
	in.readFully (attrib);
	otherAttributes.put (name, attrib);
      }
    }
  }

}
