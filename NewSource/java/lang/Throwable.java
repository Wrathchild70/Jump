/* java.lang.Throwable
 * 
    Jump - Java post-compiler for Palm OS
    Copyright (C) 2003 Peter Dickerson <peter.dickerson@ukonline.co.uk>

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
 * 11-Feb-2004 PMD v2.2.1 added initCause, getCause to keep J2SDK 1.4.2 happy
 */

package java.lang;

/** this standard class is required as the base class for all
 * Exceptions and Errors. The version here is not multi-thread aware -
 * Jump does not support java.lang.Thread style threading.
 * 
 * <P>This class is a JUMP specific version of the standard Java
 * class and may only support a subset of the full class. See
 * the standard Java javadocs for clarification.
 * 
 * @author Peter M Dickerson
 */

public class Throwable
{
  private String message;
  // the order of the fields is critical, used by asm
  private int current_pc;
  private int level1_pc;
  private int level2_pc;
  private int level3_pc;
  private int level4_pc;
  private int level5_pc;
  private int level6_pc;
  private int level7_pc;

  public Throwable()
  {
    fillInStackTrace();
  }
  
  public Throwable(String msg)
  {
    message = msg;
  }
  
  public String getMessage()
  {
    return message;
  }
  
  public String toString()
  {
    String result = getClass().getName();
    if ( message == null )
      return result;
    return result + ": " + message;
  }
  
  static void printMethod(int address)
  {
    if ( address != 0 )
    {
      palmos.JumpLog.println( getMethodName(address) );
    }
  }

  /** implemented here to keep J2SDK 1.4 happy */
  public Throwable getCause()
  {
    return null;  // PMD 2.2.1
  }

  /** implemented here to keep J2SDK 1.4 happy */
  public Throwable initCause(Throwable cause)
  {
    return this;  // PMD 2.2.1
  }

  /** dummy  */
  public void printStackTrace()
  {
    palmos.JumpLog.println( "*** Exception *** " + toString() );
    palmos.JumpLog.println( "stack trace:" );
    printMethod(current_pc);
    printMethod(level1_pc);
    printMethod(level2_pc);
    printMethod(level3_pc);
    printMethod(level4_pc);
    printMethod(level5_pc);
    printMethod(level6_pc);
    printMethod(level7_pc);
  }

  /** dummy  */
  public void printStackTrace(java.io.PrintStream ps)
  {
    printStackTrace();
  }

  /** dummy  */
  public void printStackTrace(java.io.PrintWriter pw)
  {
    printStackTrace();
  }

  public native Throwable fillInStackTrace();
  native static String getMethodName(int address);
}