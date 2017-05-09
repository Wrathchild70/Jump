/* java.lang.ClassNotFoundException
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

package java.lang;

/** this standard class is required. The version here is not multi-thread aware.
 * Jump does not support java.lang.Thread style threading.
 * 
 * <P>This class is a JUMP specific version of the standard Java
 * class and may only support a subset of the full class. See
 * the standard Java javadocs for clarification.
 * 
 * @author Peter M Dickerson
 */

public class ClassNotFoundException extends Exception 
{
  public ClassNotFoundException()
  {
  }

  public ClassNotFoundException(String message)
  {
    super(message);
  }
}
