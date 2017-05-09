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
    This file has been modified in 2000,2001
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/
/*
	Cosmetic changes by P.M.Dickerson <peter.dickerson@ukonline.co.uk>
	Changes (c) 2002 P.M.Dickerson
*/

import java.io.*;
import java.util.*;

class JumpStatistics implements JVM 
{
  int nClasses = 0;
  int nInstanceClasses = 0;
  int nInterfaces = 0;
  int nJavaMethods = 0;
  int nNativeMethods = 0;
  int nBytesBytecode = 0;
  
  /**
   * create a JumpStatistics.
   */
  JumpStatistics ()
  {
  }

  void addMethod (MethodInfo method)
  {
    Klass cl = method.cls;

    if (method.isNeeded(JavaElement.NEEDED)) 
    {
      if (((method.access_flags & ACC_NATIVE) != 0) ||
        (method.nativeRef != null)) 
      {
        nNativeMethods++;
      }
      else 
      {
        nJavaMethods++;
        nBytesBytecode += method.attributes.code.code.length;
      }
    }
  }

  void addClass (Klass cls)
  {
    if (cls.isNeeded(JavaElement.NEEDED)) 
    {
      if (cls.isInterface()) 
      {
        nInterfaces++;
      }
      else 
      {
        nClasses++;
        if (cls.isNeeded(JavaElement.INSTANCE_NEEDED)) 
        {
          nInstanceClasses++;
        }
      }
    }
  }

  /**
   * print the statistics to System.out.
   */
  void report()
  {
    System.out.println();
    System.out.println("       number of classes: " +          nClasses + 
      " (" + nInstanceClasses + " having instances)");
    System.out.println("    number of interfaces: " +       nInterfaces);
    System.out.println("  number of Java methods: " +      nJavaMethods);
    System.out.println("number of native methods: " +    nNativeMethods);
    System.out.println("     total bytecode size: " +    nBytesBytecode);
  }
}
