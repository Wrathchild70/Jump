/*
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
    This file has been written by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    allow Jump to read class files that SuperWaba has embedded in Palm OS PDB files.
*/

import java.io.*;
import java.util.*;

/**
 * SuperWabaPDB read file embedded in Palm OS PDB file
 */
class SuperWabaPDB
{
  File file;
  String[] dictionary;
  int[] offsets;

  /** create object to represent PDB */
  public SuperWabaPDB(String filename) throws IOException
  {
    file = new File(filename);
    FileInputStream fis = new FileInputStream(file);
    DataInputStream dos = new DataInputStream(fis);

    // skip header
    dos.skipBytes(32+1+1+2+8+16);

    // check that we have a SW format file
    byte[] wrp2 = new byte[4];
    dos.read(wrp2);
    String wrpname = new String(wrp2);
    if ( !wrpname.equals("Wrp2") && !wrpname.equals("SWAX") )
      throw new IOException( "PDB format error" );

    // some more header to skip
    dos.skipBytes(4+8);

    int file_count = dos.readShort(), i;
    dictionary = new String[file_count];
    offsets = new int[file_count+1];

    for (i=0; i<file_count; i++)
    {
      offsets[i] = dos.readInt();
      dos.skipBytes(4);
    }
    offsets[i] = (int)file.length();
    int pos = 32+1+1+2+8+16 +4 +4+8 +2 +8*file_count;
    for (i=0; i<file_count; i++)
    {
      dos.skipBytes(offsets[i]-pos);
      int len = dos.readShort();
      pos = offsets[i]+2;
      if ( len > 0 && len < 256 && pos+len < offsets[i+1] )
      {
        byte[] s = new byte[len];
        dos.read(s);
        dictionary[i] = new String(s);
        pos += len;
      }
    }
    fis.close();
  }

  /** return an input stream for record named */
  public InputStream getInputStream(String name) throws IOException
  {
    for (int index=0; index<dictionary.length; index++)
    {
      if ( name.equals(dictionary[index]) )
        return getInputStream(index);
    }
    throw new FileNotFoundException(name);
  }

  /** return an input stream for record index */
  public InputStream getInputStream(int index) throws IOException
  {
    FileInputStream fis = new FileInputStream(file);
    DataInputStream dos = new DataInputStream(fis);
    dos.skipBytes(offsets[index]);
    int namelen = dos.readShort();
    dos.skipBytes(namelen);
    int len = offsets[index+1] - offsets[index] - 2 - namelen;
    byte[] data = new byte[len];
    dos.read(data);
    fis.close();
    return new ByteArrayInputStream(data);
  }

  /** return the dictionary of filenames for this PDB */
  public String[] getDictionary()
  {
    return dictionary;
  }

  /** copy the record corresponding to record 'index' of the PDB */
  public int extractRecordToFile(int index, String filename, boolean contentOnly) throws IOException
  {
    FileInputStream fis = new FileInputStream(file);
    DataInputStream dos = new DataInputStream(fis);
    int len = offsets[index+1] - offsets[index];
    dos.skipBytes(offsets[index]);
    if ( contentOnly )
    {
      int namelen = dos.readShort();
      dos.skipBytes(namelen);
      len -= 2+namelen;
    }
    byte[] data = new byte[len];
    dos.read(data);
    fis.close();
    FileOutputStream fos = new FileOutputStream(filename);
    fos.write(data);
    fos.close();
    return data.length;
  }
}
