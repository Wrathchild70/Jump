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

/* 2.1.9
 *  2/Feb/04 added -q option to remove sign-on message. Convenient when stdout & stderr can't be split
 */


import java.io.*;
import java.util.*;

class UnWarp
{
  private static void extract(SuperWabaPDB pdb, String[] dict, boolean[] inUse, boolean[] selected, boolean all, boolean contentOnly, boolean list) throws IOException
  {
    if ( dict != null )
    {
      for (int j=0; j<dict.length; j++)
      {
        if ( all || selected[j])
        {
          String recname = dict[j];
          int hash = recname.hashCode() & 0x1FFF;
          String id = "000"+Integer.toHexString(hash);
          id = id.substring(id.length()-4);
          if ( list )
          {
            System.err.println( "Record " +id + ": " +recname );
          }
          else if ( !recname.endsWith(".class") )
          {
            // the name is hashed to produce a resource id to find file.
            if ( contentOnly )
            {
              if ( inUse[hash] )
                throw new IOException( "Filenames cause cause hash collision" );
              inUse[hash] = true;
              int pos = recname.lastIndexOf('/');
              String filename = recname.substring(pos+1);
              pos = filename.lastIndexOf('\\');
              filename = filename.substring(pos+1);
              int len = pdb.extractRecordToFile(j, filename, true);
              System.out.println("BITMAPCOLOR ID " +hash + " \"" +filename +"\" NOCOLORTABLE" );
            }
            else
            {
              int i;
              for (i=0; inUse[hash] && i<8192; i++)
              {
                hash++;
              }
              if ( i > 20 )
                throw new IOException( "Filenames cause too may hash collisions" );
              else if ( i > 10 )
                System.err.println( "Warning: many hash collisions" );
              inUse[hash] = true;
              String filename = "Wrp2" + id + ".bin";
              int len = pdb.extractRecordToFile(j, filename, false);
              System.out.println("\tres\t'Wrp2', " + hash + ", \"" + filename + "\"\t; " + recname );
              // System.err.println("Extracting " +args[i]+ "::" +recname+ " as " +filename+ " (" +len+ " bytes)" );
            }
          }
        }
      }
    }
  }

  private static void usage()
  {
    System.err.println("\nUsage: java UnWarp [-q] [-b|-l] pdbfile [[-x] recordname]...");
    System.err.println(  "       -q    quiet, remove sign-on banner.");
    System.err.println(  "       -b    extract files (default is Warp records).");
    System.err.println(  "       -l    list all Warp records.");
    System.err.println(  "       -x    exclude named records (default include)");
    System.err.println(  "     Records can be a name e.g. image.bmp, or contain one wildcard\n" +
                         "     star character e.g. \"icon*.bmp\". Enclose wildcard names in quotes\n" +
                         "     to avoid potential command line filename expansion.");
    System.exit(1);
  }

  public static void main(String[] args) throws IOException
  {
    SuperWabaPDB pdb = null;
    String[] dict = null;
    boolean[] selected = null;
    boolean all = false;
    boolean contentOnly = false;
    boolean list = false;
    boolean[] inUse = new boolean[8192];
    boolean exclude = false;

    if ( args.length==0 || !args[0].equalsIgnoreCase("-q") )
    {
      System.err.println("UnWarp: SuperWaba resource extractor for Jump");
      System.err.println("Copyright (c) 2003-2004 by Peter Dickerson <peter.dickerson@ukonline.co.uk>");
      System.err.println("Please see the file COPYING (GPL v2) for distribution rights.\n");
    }

    for (int i=0; i<args.length; i++)
    {
      String arg = args[i];
      if ( arg.startsWith( "-" ) )
      {
        if ( arg.equalsIgnoreCase("-b") )
          contentOnly = true;
        else if ( arg.equalsIgnoreCase("-l") )
          list = true;
        else if ( arg.equalsIgnoreCase("-x") )
          exclude = true;
        else if ( arg.equalsIgnoreCase("-q") )
        {
          if ( i != 0 )
          {
            System.err.println("Option " +arg + " can only be the first command line option");
            usage();
          }
        }
        else
        {
          System.err.println("Unknown option "+arg);
          usage();
        }
      }
      else if ( arg.toLowerCase().endsWith(".pdb") )
      {
        extract( pdb, dict, inUse, selected, all, contentOnly, list );
        pdb = new SuperWabaPDB(args[i]);
        dict = pdb.getDictionary();
        selected = new boolean[dict.length];
        all = true;
        exclude = false;
      }
      else
      {
        if ( dict == null )
        {
          System.err.println("PDB file expected");
          usage();
        }
        int star = arg.indexOf('*');
        for (int j=0; j<dict.length; j++)
        {
          if ( exclude && all )
              selected[j] = true;
          if ( ( star >= 0 && dict[j].startsWith(arg.substring(0,star)) && dict[j].endsWith(arg.substring(star+1)) )
            || ( star < 0 && dict[j].equals(arg) ) )
          {
            selected[j] = !exclude;
          }
        }
        all = false;
        exclude = false;
      }
    }

    if ( pdb == null )
      usage();
    else
      extract( pdb, dict, inUse, selected, all, contentOnly, list );
  }
}
