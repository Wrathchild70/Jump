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
    This file has been modified in 07/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;

/**
 * A GenericMethod is the collection of all methods with the 
 * same name and signature.
 * The concept applies only to non-static methods.
 * Implementing and overriding can only take place within 
 * the methods of one generic method.
 */

class GenericMethod 
{

  /** 
   * a static hashtable String -> GenericMethod,
   * referencing all GenericMethods via their genericName. 
   */
  static Hashtable allGenerics = new Hashtable();

  /** method name + signature, identifies one generic method. */
  String genericName;

  /** method name */
  String name;

  /** method signature (args and return type) */
  String signature;

  /** the individual methods of this generic method. */
  Vector methods;

  /** 
   * all instantiated classes that this generic method applies to.
   * <p>
   * This field is set in the 'compute' method. After that point,
   * changes in the 'methods' field or in the class tree are illegal.
   */
  Klass[] instantiatedClasses = null;

  /** 
   * flag: this generic method needs a vtable.
   * <p>
   * This field is set in the 'compute' method. After that point,
   * changes in the 'methods' field or in the class tree are illegal.
   */
  boolean needsVtable = false;

  /** 
   * the vtable index for this generic method. 
   * This field is set in the 'assignVtableIndex' method.
   */
  int vtableIndex = -1;

  /**
   * constructs an empty GenericMethod.
   */
  private GenericMethod (String name, String signature)
  {
    this.name        = name;
    this.signature   = signature;
    this.genericName = name + signature;
    methods = new Vector();
    allGenerics.put (genericName, this);
  }

  /**
   * finds or constructs the GenericMethod 
   * for the given name and signature.
   */
  static GenericMethod forName (String name, String signature)
  {
    String genericName = name + signature;
    GenericMethod gm = (GenericMethod) allGenerics.get (genericName);

    if (gm != null) 
    {
      return gm;
    } 
    else 
    {
      return new GenericMethod (name, signature);
    }
  }

  /**
   * returns an Enumeration of all generic methods.
   */
  static Enumeration elements()
  {
    return allGenerics.elements();
  }

  /**
   * adds a method to this generic method.
   */
  void addMethod (MethodInfo method)
  {
    if (!methods.contains(method)) 
    {
      methods.addElement (method);
    }
  }

  /**
   * registers a method with its generic method.
   */
  static GenericMethod register (MethodInfo method)
  {
    GenericMethod gm = GenericMethod.forName (method.name, method.signature);
    gm.addMethod (method);
    return gm;
  }

  /**
   * compute the dependent fields of this GenericMethod object.
   */
  public void compute()
  {
    Hashtable ht = new Hashtable();

    for (int i=0; i<methods.size(); i++) 
    {
      MethodInfo m = (MethodInfo) methods.elementAt(i);
      Klass cl = m.cls;
      Vector subs = cl.getAllSubclasses();

      subs.addElement (cl);

      for (int j=0; j<subs.size(); j++) 
      {
        Klass subCl = (Klass) subs.elementAt(j);
        if (subCl.isNeeded(JavaElement.INSTANCE_NEEDED)) 
        {
          ht.put (subCl, Boolean.TRUE);
        }
      }

      if (m.isNeeded(JavaElement.NEEDED_VIRTUALLY) &&
        (m.getEffectiveMethod() == null)) 
      {
        needsVtable = true;
      }
    }

    instantiatedClasses = new Klass[ht.size()];
  {
    Enumeration enum;
    int i;
    for (enum=ht.keys(), i=0; 
      enum.hasMoreElements(); 
      i++) 
    {
      instantiatedClasses[i] = (Klass) enum.nextElement();
    }
  }    
  }

  /**
   * compute the vtable index for this class and register it.
   * The vtable index is registered in this GenericMethod,
   * in all its individual methods, and in all related
   * classes with instances.
   */
  void assignVtableIndex ()
  {
    boolean isFree = false;

    if (needsVtable && (vtableIndex < 0)) 
    {
      // find next free vtable index
      for (int index=0; ; index++) 
      {
        isFree = true;
        for (int i=0; i<instantiatedClasses.length; i++) 
        {
          Vector vtable = instantiatedClasses[i].vtable;

          if (vtable == null) 
          {
          } 
          else if (index >= vtable.size()) 
          {
          }
          else if (vtable.elementAt(index) != null) 
          {
            isFree = false;
            break;
          }
        }
        if (isFree) 
        {
          vtableIndex = index;
          break;
        }
      }

      for (int i=0; i<methods.size(); i++) 
      {
        ((MethodInfo) methods.elementAt(i)).vtableIndex = vtableIndex;
      }

      for (int i=0; i<instantiatedClasses.length; i++) 
      {
        Klass cls = instantiatedClasses[i];
        Vector vtable = cls.vtable;
        MethodInfo m = cls.findMethod (name, signature);
	
        if (vtable == null) 
        {
          vtable = new Vector();
          cls.vtable = vtable;
        }
        if (vtableIndex >= vtable.size()) 
        {
          vtable.setSize (vtableIndex + 1);
        }
        vtable.setElementAt (m, vtableIndex);
      }
    }
  }
}
