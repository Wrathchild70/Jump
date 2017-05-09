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
    This file has been written by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;

/**
 * A JumpException encapsulates a Throwable and its original 
 * backtrace, but allows nested exception handlers to add information
 * to the JumpException while passing it out to the top-level.
 */
class JumpException extends RuntimeException 
{
  /** the encapsulated Throwable */
  protected Throwable throwable;

  /** the accumulated infos */
  protected Vector infos = new Vector();

  static JumpException addInfo(Throwable throwable, String info)
  {
    JumpException jex = 
      (throwable instanceof JumpException) ?
      (JumpException) throwable :
      new JumpException(throwable);
    jex.addInfo(info);
    return jex;
  }

  /** creates a new JumpException encapsulating a Throwable. */
  JumpException(Throwable throwable)
  {
    this.throwable = throwable;
  }

  /** creates a new JumpException with an info encapsulating a Throwable. */
  JumpException(Throwable throwable, String info)
  {
    this.throwable = throwable;
    infos.add(info);
  }

  /** adds a new String to the accumulated information. */
  void addInfo (String info)
  {
    infos.add(info);
  }

  /** print stack trace. */
  public void printStackTrace()
  {
    printStackTrace(System.err);
  }

  /** print stack trace. */
  public void printStackTrace(PrintStream s)
  {
    throwable.printStackTrace(s);
    s.println("--- Info ---");
    for (int i=0; i<infos.size(); i++) {
      s.println(" +++ " + (String) infos.get(i));
    }
  }

  /** print stack trace. */
  public void printStackTrace(PrintWriter s)
  {
    throwable.printStackTrace(s);
    s.println();
    for (int i=0; i<infos.size(); i++) {
      s.println(" +++ " + (String) infos.get(i));
    }
  }
}
