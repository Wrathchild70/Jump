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

class CONSTANT_NameAndType_info extends cp_info implements JVM {
  private int name_index;
  private int signature_index;
  String name;
  String signature;

  CONSTANT_NameAndType_info(DataInput in) throws IOException
  {
    super(CONSTANT_NameAndType);
    name_index = in.readShort();
    signature_index = in.readShort();
  }

  void resolveStrings(ConstantPool pool)
  {
    name = pool.getString(name_index);
    signature = pool.getString(signature_index);
  }
}
