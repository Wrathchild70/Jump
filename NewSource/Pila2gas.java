/*
    Pila2gas GNU GAS output module for Jump
    Copyright (c) 2003 by Peter Dickerson <peter.dickerson@ukonline.co.uk>

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

import java.io.*;
import java.util.*;

class Pila2gas
{
  static Hashtable renamer;

  /**
   *  the source assembler file.
   */
  LineNumberReader in;

  /**
   * the output assembler file.
   */
  PrintWriter out;

  static
  {
    renamer = new Hashtable();
    // special regs
    renamer.put( "pc", "%pc" );
    renamer.put( "ccr", "%ccr" );
    // data regs
    renamer.put( "d0", "%d0" );
    renamer.put( "d1", "%d1" );
    renamer.put( "d2", "%d2" );
    renamer.put( "d3", "%d3" );
    renamer.put( "d4", "%d4" );
    renamer.put( "d5", "%d5" );
    renamer.put( "d6", "%d6" );
    renamer.put( "d7", "%d7" );
    // address regs
    renamer.put( "a0", "%a0" );
    renamer.put( "a1", "%a1" );
    renamer.put( "a2", "%a2" );
    renamer.put( "a3", "%a3" );
    renamer.put( "a4", "%a4" );
    renamer.put( "a5", "%a5" );
    renamer.put( "a6", "%a6" );
    renamer.put( "a7", "%sp" );
  }

  /**
   * translate Pila register names to gas register names.
   */
  StringBuffer translateParam(StringBuffer param)
  {
    StringBuffer result = new StringBuffer();
    int pos, len = param.length();

    for (pos=0; pos<len; pos++)
    {
      char c = param.charAt(pos);
      if ( Character.isLetter(c) || c == '$' || c == '_' )
      {
        int p1 = pos;
        while ( ++pos<len && ( (c=param.charAt(pos)) == '_' || Character.isLetterOrDigit(c) ) )
          ;
        String token = param.substring(p1,pos);
        if ( token.charAt(0) == '$' )
        {
          token = "0x" + token.substring(1);
        }
        else
        {
          String sub = (String)renamer.get(token);
          if ( sub != null )
            token = sub;
        }
        result.append(token);
        pos--;
      }
      else if ( c == '(' && param.charAt(pos+1) == 'a' && param.charAt(pos+2) == '5' && param.charAt(pos+3) == ')' )
        result.append( "@END(" ); // a5 global use negative offsets
      else
        result.append(c);
    }

    return result;
  }

  /**
   * translate multiline struct definition into equates
   */
  void translateStruct( String name ) throws IOException
  {
    String line;
    int offset = 0;

    while ( (line = in.readLine()) != null && !line.startsWith("endstruct") )
    {
      line = line.trim();
      int pos;
      for (pos=0; pos<line.length(); pos++)
      {
        char c = line.charAt(pos);
        if ( c == ' ' || c == '\t' || c ==';' )
          break;
      }
      String field = line.substring(0,pos-2);
      String type = line.substring(pos-2,pos);
      // System.out.println( name + "." + field + " = " + offset );
      out.println( name + "." + field + " = " + offset );
      if ( type.equals(".l") )
        offset += 4;
      else if ( type.equals(".w") )
        offset += 2;
      else if ( type.equals(".b") )
        offset += 1;
      else if ( type.equals(".8") )
        offset += 8;
    }
  }

  /**
   * output code to call a systrap
   */
  void translateSystrap(StringBuffer param)
  {
    int s = param.length()-1, stack_adjust=0;
    char c;
    String p;

    do
    {
      int e = s;

      c = '(';
    while ( --s >= 0 && (c=param.charAt(s)) != '(' && c != ',' )
    {
      if ( c == ')' )
      {
        while ( --s >= 0 && (c=param.charAt(s)) != '(' )
          ;
      }
    }
      p = param.substring(s+1,e);
      // s--;
      if ( p.startsWith("&") )
      {
        int l = p.length();
        if ( p.endsWith(".l") )
          l -= 2;
        out.println( "\tpea\t"+p.substring(1,l) );
        stack_adjust += 4;
      }
      else
      {
        int l = p.length();
        if ( l > 0 )
        {
          String value = p.substring(0,l-2);
          String size = p.substring(l-2);
          if ( value.equals( "#0" ) )
            out.println( "\tclr" + size + "\t-(%sp)" );
          else
            out.println( "\tmove" + size + "\t" + value + ",-(%sp)" );
          if ( size.equals(".l") )
            stack_adjust += 4;
          else
            stack_adjust += 2;
        }
      }
    } while ( c == ',' );
    p = param.substring(0,s);
    out.println( "\ttrap\t#15" );
    out.println( "\tdc.w\tsysTrap" + p );
    if ( stack_adjust > 8 )
      out.println( "\tlea\t" + stack_adjust + "(%sp),%sp" );
    else if ( stack_adjust != 0 )
      out.println( "\taddq.l\t#" + stack_adjust + ",%sp" );
  }

  Pila2gas(String inName, String outName, boolean delete) throws IOException
  {
    File infile = new File(inName);
    File outfile = new File(outName);

    in = new LineNumberReader(new FileReader(infile));
    out = new PrintWriter(new FileOutputStream(outfile));

    out.println("|=============================");
    out.println("| Generated by Pila2gas GNU GAS output module for Jump " + Jump.JUMP_VERSION);
    out.println("|=============================");
    out.println();
    out.println("\t.globl\tPilotMain");

    String line, label, opcode, comment;
    StringBuffer param = new StringBuffer();
    boolean in_vtable = false;

    while ( (line = in.readLine()) != null )
    {
      int len = line.length();
      if ( len == 0 )
        continue;
      int pos;
      char c;

      // get label
      for (pos=0;
        pos < len && ((c = line.charAt(pos)) == '.' || c == '_' || Character.isLetterOrDigit(c));
        pos++)
        ;
      label = line.substring(0,pos);

      // get opcode
      while ( pos < len && ((c = line.charAt(pos)) == ':' || Character.isWhitespace(c)) )
        pos++;
      int p1 = pos;
      while ( pos < len && (c = line.charAt(pos)) != ';' && !Character.isWhitespace(c) )
        pos++;
      opcode = line.substring(p1, pos);

      // get param
      param.setLength(0);
      while ( pos < len && Character.isWhitespace(line.charAt(pos)) )
        pos++;
      while ( pos < len && (c = line.charAt(pos)) != ';' )
      {
        if ( !Character.isWhitespace(c) )
          param.append(c);
        pos++;
      }

      // comment
      if ( pos < len )
        comment = "\t|" + line.substring(pos+1);
      else
        comment = "";

      if ( label.equals("struct") )
      {
        translateStruct( opcode );  // opcode position if struct name
        continue;
      }
      else if ( opcode.equals( "appl" ) || opcode.equals( "end" ) )
        opcode = "| " + opcode;
      else if ( opcode.equals( "res" ) )
      {
        if ( param.toString().startsWith("'code',") )
          out.println( ".section\tseg" + param.substring(7) + ",\"x\"" );
        opcode = "| " + opcode;
      }
      else if ( opcode.equals( "systrap" ) )
      {
        // System.out.println( label + "\t" + opcode + "\t" + param );
        if ( label.length() > 0 )
        {
          out.println( label+":" );
          label = "";
        }
        out.println( "\t| " + opcode + "\t" + param );
        translateSystrap( translateParam(param) );
        out.println( "\t| end systrap" );
        continue;
      }
      else if ( opcode.equals( "include" ) )
      {
        // System.out.println( label + "\t" + opcode + "\t" + param );
        out.println( "\t.include\t" + param.substring(0, param.length()-4) + "s\"" );
        opcode = "| " + opcode;
      }
      else if ( opcode.equals( "code" ) )
        opcode = ".text";
      else if ( opcode.equals( "align" ) )
      {
        out.println( "\t.even" );
        continue;
      }
      else if ( opcode.equals( "data" ) )
        opcode = ".data";
      else if ( opcode.equals( "dc.b" ) )
      {
        String s = new String(param);
        if ( s.indexOf('\'') >= 0 )
        {
          out.println( "\t|\t" + s );
          len = s.length();
          param.setLength(0);
          for (pos =0; pos<len; pos++ )
          {
            c = s.charAt(pos);
            if ( c == '\'' )
            {
              String start = "0x";
              while (++pos<len && (c=s.charAt(pos)) != '\'' )
              {
                param.append( start + Integer.toHexString( (byte)c ) );
                start = ",0x";
              }
            }
            else
              param.append(c);
          }
        }
      }
      else if ( opcode.equals( "list" ) )
      {
        if ( param.charAt(0) == '0' )
          out.println( "\t.nolist" );
        else
          out.println( "\t.list" );
        continue;
      }
 //     else if ( in_vtable && opcode.equals("dc.w") )
 //       param.append("@END"); // relocate vatable entries

      // process changes needed for GAS
      if ( opcode.equals("equ") || opcode.equals("set") )
      {
        opcode = "=";
        if ( param.charAt(0) == '\'')
        {
          // number literals of the for 'pqrs', 'pqr' or 'pq'
          switch ( param.length() )
          {
          case 6:
            param = new StringBuffer( "0x" + Integer.toHexString(
              ((param.charAt(1)*256 + param.charAt(2))*256 + param.charAt(3))*256 + param.charAt(4)
              ) );
            break;
          case 5:
            param = new StringBuffer( "0x" + Integer.toHexString(
              (param.charAt(1)*256 + param.charAt(2))*256 + param.charAt(3)
              ) );
            break;
          case 4:
            param = new StringBuffer( "0x" + Integer.toHexString(
              param.charAt(1)*256 + param.charAt(2)
              ) );
            break;
          }
        }
      }
      else if ( label.length() > 0 )
      {
        in_vtable = label.startsWith("class") && label.endsWith("__vtable");
        label += ':';
      }

      param = translateParam(param);

      // print
      out.println( label + "\t" + opcode + "\t" + param + comment );
    }

    out.close();
    in.close();

    if (delete)
      infile.delete();

    System.out.println();
  }

  static void process(String inName, String outName, boolean delete) throws IOException
  {
    new Pila2gas(inName, outName, delete);
  }

  static void process(String className, boolean delete) throws IOException
  {
    new Pila2gas(className+".asm", className+".s", delete);
  }

  public static void main(String[] args)
  {
    System.out.println("GNU GAS output module for Jump " + Jump.JUMP_VERSION);
    System.out.println("Copyright (c) 2003 by Peter Dickerson <peter.dickerson@ukonline.co.uk>");
    System.out.println("Please see the file COPYING (GPL v2) for distribution rights.\n");

    if ( args.length == 1 || args.length == 2 )
    {
      try
      {
        if ( args.length == 1 )
          Pila2gas.process(args[0], false);
        else
          Pila2gas.process(args[0], args[1], false);
      }
      catch (FileNotFoundException fnfe)
      {
        System.out.println( fnfe.getMessage() );
      }
      catch (IOException e)
      {
        System.out.println( e.getMessage() );
      }
    }
    else
      System.out.println("Usage: Pila2gas <class>\n    or Pila2gas <in-file> <out-file>");
  }
}
