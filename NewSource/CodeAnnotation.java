/*
    Jump - Java post-compiler for PalmPilot
    (c) 2001 Peter M. Dickerson MA <peter.dickerson@ukonline.co.uk>

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
   December 2001
    This file has been created by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    to add some code optimization and to extend the functionality.
*/

import java.io.*;
import java.util.*;

public class CodeAnnotation  {
  /** Indicates that a pointer check can to be removed. */
  boolean checkForNull;

  /** Valid for an aload that will be consumed by a putfield.
   * For aload indicates that aload will be consumed by a putfield that knows
   * what is going on and doesn't need the address on the stack.
   * For putfield indicates that aload was not performed, use localSlot.
   */
  boolean dontPush = false;

  boolean classInitialized;

  /** Indicates the originating local variable slot if known, else -1 */
  int localSlot = -1;

  /** Create an annotation to a bytecode instruction.
   * The annotaions carry information during code generation
   * obtained during code analysis. The is one CodeAnnotion
   * for every bytecode that needs special consideration.
   */
  CodeAnnotation()
  {
    checkForNull = true;
    localSlot = -1;
    classInitialized = true;
  }

  CodeAnnotation(int l, boolean checked)
  {
    checkForNull = !checked;
    localSlot = l;
    classInitialized = false;
  }

  /** Indicate whether a null check is needed.
   * No annotation means that a null check is needed.
   */
  static boolean isNullCheckNeeded(CodeAnnotation[] annotations, int index)
  {
    return (annotations == null || annotations[index] == null || annotations[index].checkForNull );
  }

  /** Return the local variable slot associated with this instruction index if known.
   */
  static int getLocalSlot(CodeAnnotation[] annotations, int index)
  {
    return (annotations == null || annotations[index] == null) ? -1 : annotations[index].localSlot;
  }

  /** Return the dontPush associated with this instruction index if known.
   * No annotation means that we do push.
   */
  static boolean dontPush(CodeAnnotation[] annotations, int index)
  {
    return (annotations != null && annotations[index] != null && annotations[index].dontPush );
  }

  /** Returns true if class is already initialized.
   * No annotation means that class needs initialization. This method is only valid for
   * op_putfield, op_getfield, op_invokevirtual, op_invokestatic and op_new.
   */
  static boolean classInitialized(CodeAnnotation[] annotations, int index)
  {
    return (annotations != null && annotations[index] != null && annotations[index].classInitialized );
    // return false;
  }
}
