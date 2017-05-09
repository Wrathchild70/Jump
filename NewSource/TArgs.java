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

/**
 * describes an argument list signature.
 */

class TArgs 
{
  private Vector args = new Vector();
  private String retType;
  private int words;
  private boolean objectArg;

  /** 
   * constructs an argument list from a signature.
   */
  TArgs(String signature)
  {
    int i = 0;
    i++;
    words = 0;
    objectArg = false;
    while (signature.charAt(i) != ')') 
    {
      switch (signature.charAt(i)) 
      {
      case 'B':
      case 'C':
      case 'F':
      case 'I':
      case 'S':
      case 'Z':
        args.addElement(new Character(signature.charAt(i)));
        words++;
        break;
      case 'D':
      case 'J':
        args.addElement(new Character(signature.charAt(i)));
        words += 2;
        break;
      case 'L': 
      {
        words++;
        StringBuffer t = new StringBuffer();
        do 
        {
          t.append(signature.charAt(i));
          i++;
        } while (signature.charAt(i) != ';');
        // append the ';' too...
        t.append(signature.charAt(i));
        args.addElement(t);
        objectArg = true;
        break;
      }
      case '[': 
      {
        words++;
        StringBuffer t = new StringBuffer();
        while (signature.charAt(i) == '[') 
        {
          t.append(signature.charAt(i));
          i++;
        }
        if (signature.charAt(i) == 'L') 
        {
          do 
          {
            t.append(signature.charAt(i));
            i++;
          } while (signature.charAt(i) != ';');
          // append the ';' too...
          t.append(signature.charAt(i));
        } 
        else 
        {
          t.append(signature.charAt(i));
        }
        args.addElement(t);
        objectArg = true;
        break;
      }
      default:
        ASSERT.fail("Unknown method signature format: "+signature);
        break;
      }
      i++;
    }
    i++;
    retType = signature.substring(i);
  }

  /**
   * return the call stack's size in words (???)
   */
  int words()
  {
    return words;
  }

  /**
   * return the number of arguments.
   */
  int argCount()
  {
    return args.size();
  }

  /**
   * returns whether there is an onject or array in athe arg list.
   */
  boolean hasObjectArg()
  {
    return objectArg;
  }

  /**
   * return the type signature of the i'th argument.
   */
  String arg(int i)
  {
    return args.elementAt(i).toString();
  }

  /**
   * return the type signature of the return value.
   */
  String ret()
  {
    return retType;
  }
}
