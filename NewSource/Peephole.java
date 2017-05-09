/*
    Peephole Jump Assembler file optimizer
    Copyright (c) 2002 by Peter Dickerson <peter.dickerson@ukonline.co.uk>

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
 *  23-Feb-2004 PMD 2.2.2 wasted pushes removed including unused dup
 */
import java.io.*;
import java.util.*;

class Peephole
{
  static final boolean RENAME = true;  // rename files at end

  private class Line
  {
    /**
     * text of the line represented by this Line object.
     */
    String text;

    /**
     * this Line represents a push of a location or D0 onto the stack.
     */
    boolean isPush;

    /**
     * this Line represents a pop of the stack to a location or register.
     */
    boolean isPop;

    /**
     * this Line represents a 32-bit move that is no a push or pop
     */
    boolean isMove;

    /**
     * this Line represents a call to the null checking code.
     */
    boolean isNullCheck;

    /**
     * this Line represents an instruction that does not touch A7.
     * Note that this includes any call or branch.
     */
    boolean isStackSafe;

    /**
     * this Line includes a label.
     * It is not possible to push before a label and pop after it since
     * there is a branch to the label somewhere.
     */
    boolean isLabel;

    /**
     * this line is a stack ajustment.
     * addq.l #?,a7 or lea ?(a7),a7
     */
    boolean isStackAdjust;

    /**
     * the operation (move.l etc)
     */
    String op;

    /**
     * the source location when the Line is a push.
     */
    String source;

    /**
     * the destination location when the Line is a pop.
     */
    String destination; // for pop
  
    Line(String s)
    {
      setText(s);
    }

    /**
     * Change the text of a Line.
     * The new text is parsed to classify it.
     */
    void setText(String s)
    {
      isPush = false;
      isPop = false;
      isMove = false;
      isStackSafe = true;
      isLabel = false;
      isStackAdjust = false;
      source = null;      // for push
      destination = null; // for pop
      op = null;
      text = s;

      if ( s.charAt(0) != '\t' )
      {
        isLabel = true;
        isStackSafe = false;
        op = "";
      }
      else
      {
        int n = s.indexOf(';');

        if ( n>0 )
          s = s.substring(0,n);

        n = s.indexOf('\t',1);
        if ( n < 0 )
          n = s.indexOf(' ',1);
        if ( n < 0 )
          op = s.substring(1);
        else
        {
          op = s.substring(1,n);
          int c = s.indexOf(',', n );
          if ( c < 0 )
          {
            source = s.substring(n+1).trim();
            if ( op.equals("pea") )
              isStackSafe = false;
          }
          else
          {
            int c1 = s.indexOf(',', c+1);
            if ( c1 > 0 && s.charAt(c1-1) == ')' )
              c = c1;
            source = s.substring(n+1,c);
            destination = s.substring(c+1).trim();
            isMove = op.equals( "move.l" );
          }

          if ( s.indexOf( "a7" ) > 0 )
          {
            isStackSafe = false;
            if ( source.equals( "(a7)+" ) )
              isPop = true;
            if ( destination != null && destination.equals( "-(a7)" ) )
              isPush = true;
            if ( !isMove && ( op.equals("addq.l")
              || (op.equals("lea") && s.endsWith("(a7),a7") ) ) )
              isStackAdjust = true;
          }
          else if ( op.charAt(0) == 'j' || (op.charAt(0) == 'b' && op.charAt(1) != 't') )
          {
            isStackSafe = false;
            isNullCheck = text.indexOf( "nonnull_check" ) >= 0;
          }
        }
      }
      // if ( source != null && source.startsWith("#$7f") )
      //  System.out.println( toString() );
    }

    public String toString()
    {
      return (isPush ? "Push" : "") + (isPop ? "Pop" : "" ) + (isStackSafe ? "Ss" : "Su" )
        + (isMove ? "Mv" : "" )+ (isStackAdjust ? "Sa" : "" ) + (isLabel ? "Lbl" : "" )
        + "|" + op +"|" + source + "|" + destination;
    }
  }

  /**
   *  the source assembler file.
   */
  LineNumberReader in;

  /**
   * the output assembler file.
   * On completion the source file is replaced with the output file. The
   * source is deleted and the output renamed.
   */
  PrintWriter out;

  /**
   * this is a queue of buffered lines.
   * The queue size represents the limits of the peephole window.
   */
  ArrayList lines;

  /** inside a method suitable for optimization. */
  boolean active = false;

  /**
   * the first machine generated method M0 has been found.
   * this means that we have skipped over the kernel.
   */
  boolean foundM0 = false;

  /**
   * recent lines of text.
   * line1 is futher down the file then line 2 etc.
   */
  private Line line1 = null, line2 = null, line3 = null, line4 = null, line5 = null;

  /** flush all the queued line to the output. */
  void flush()
  {
    while ( lines.size() > 0 )
    {
      out.println( ((Line)lines.get(0)).text );
      lines.remove(0);
    }
  }

  boolean nextLine() throws IOException
  {
    if ( lines.size() > 4 )
    {
      out.println( ((Line)lines.get(0)).text );
      lines.remove(0);
    }
    String s;
    for (;;)
    {
      s = in.readLine();
      if ( s == null )
        return false;
      if ( s.length() > 0 )
      {
        if ( s.charAt(0) == ';' )
        {
          if ( s.startsWith( "; native Method" ) )
          {
            active = false;
            break;
          }
          else if ( s.startsWith( "; Method" ) )
          {
            active = foundM0;
            break;
          }
        }
        else if ( Character.isWhitespace(s.charAt(0)) )
          s = '\t' + s.trim();
        else
        {
          s = s.trim();
          if ( !foundM0 && s.startsWith("PilotMain:") )
              foundM0 = true;
          else if ( s.startsWith("ClassTable:") )
              foundM0 = false;
        }
        if ( s.length() > 0 && s.charAt(0) != ';' && !s.startsWith("\t;") )
          break;
      }
    }
    line5 = line4;
    line4 = line3;
    line3 = line2;
    line2 = line1;
    line1 = new Line(s);
    lines.add( line1 );
    return true;
  }

  Peephole(String classname) throws IOException
  {
    int signextends = 0;
    int stackops = 0;
    int arithcombines = 0;

    File infile = new File(classname+".asm");
    File outfile = new File(classname+".peephole");

    in = new LineNumberReader(new FileReader(infile));
    out = new PrintWriter(new FileOutputStream(outfile));

    lines = new ArrayList();

    while ( nextLine() )
    {
      if ( !active )
        continue;
      int size = lines.size();
      // out.println( "; L1=" +line1+ " L2=" +line2+ " L3=" +line3+ " L4=" +line4+ " L5=" +line5 );

      if ( size >= 4 &&
        line4.isPush && line4.isMove &&
        line3.isStackSafe &&
        line2.isStackSafe &&
        line1.source != null &&
        line1.isPop &&
        line1.destination != null &&
        line1.destination.equals("d0") &&
        line2.text.indexOf( "d1" ) < 0 && // version 2.1.3
        line3.text.indexOf( "d1" ) < 0 && // d1 must not be in use, used as temp
        ( line1.op.equals( "cmp.l" ) ||
        line1.op.equals( "add.l" ) ||
        line1.op.equals( "or.l" ) ||
        line1.op.equals( "and.l" ) ) )
      {
        stackops++;
        String source = line4.source;
        if (
          ( source.indexOf("d0") >= 0 &&
          ( line2.text.indexOf( "d0" ) >= 0 || line3.text.indexOf( "d0" ) >= 0 ) )
          || 
          ( source.indexOf("a0") >= 0 &&
          ( line2.text.indexOf( "a0" ) >= 0 || line3.text.indexOf( "a0" ) >= 0 ) )
          )
        {
          line4.setText( "\tmove.l\t"+source+",d1" );
          line1.setText( "\t" +line1.op+ "\td1,d0" );
        }
        else
        {
          line4.setText( "; removed" );
          line1.setText( "\t" +line1.op+ "\t" +source+ ",d0" );
        }
        /*
        System.out.println( in.getLineNumber()+":"+line4.text );
        System.out.println( in.getLineNumber()+":"+line3.text );
        System.out.println( in.getLineNumber()+":"+line2.text );
        System.out.println( in.getLineNumber()+":"+line1.text );
        System.out.println();
        */
      }
      else if ( size>=3 &&
        line3.isPush && line3.isMove &&
        line2.isStackSafe &&
        line1.isPop && line1.isMove &&
        ( line3.source.indexOf("d0") < 0 || line2.text.indexOf("d0") < 0 ) )
      {
        stackops++;
        String source = line3.source;
        String dest = line1.destination;
        line3.setText("; removed");
        if ( dest.equals( source ) )
        {
          line1.setText( "; removed" );
          stackops++;
        }
        else
          line1.setText( "\tmove.l\t" + source + "," + dest );
        /*
        System.out.println( in.getLineNumber()+":"+line2.text );
        System.out.println( in.getLineNumber()+":"+line1.text );
        System.out.println();
        */
      }
      else if ( size>=3 &&
        line3.op.equals("ext.w") &&
        line2.op.equals("ext.l") &&
        line1.op.equals("move.b") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided ext.w/ext.l" );
        signextends += 2;
        lines.remove(size-2);
        lines.remove(size-3);
        line2 = line4;
        line3 = line5;
        line4 = null;
        line5 = null;
      }
      else if ( size>=3 &&
        line3.op.equals("ext.w") &&
        line2.op.equals("ext.l") &&
        line1.op.equals("tst.l") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided ext.w/ext.l/tst.l" );
        signextends += 2;
        lines.remove(size-2);
        lines.remove(size-3);
        line2 = line4;
        line3 = line5;
        line4 = null;
        line5 = null;
        line1.setText( "\ttst.b\td0" );
      }
      else if ( size>=3 &&
        line3.isMove && !line3.isPop &&
        !line2.isMove && line2.destination != null &&
        !line2.source.equals("d0") && line2.destination.equals("d0") &&
        line3.destination.equals("d0") && !line3.source.equals("d0") &&
        line1.isMove && line1.destination.equals(line3.source) && line1.source.equals("d0") &&
        !line2.op.startsWith("as") && !line2.op.startsWith("ls") )  // not shifts
      {
        // System.out.println( in.getLineNumber()+":\tcombined aritmetic expession" );
        String dest = line1.destination;
        String source = line2.source;
        String op = line2.op;
        if ( source.charAt(0) == '#' || source.charAt(0) == 'd' ||
          (dest.charAt(0) == 'd' && !op.equals("eor.l") ) )
        {
          // collapse to single instruction
          arithcombines += 2;
          lines.remove(size-2);
          lines.remove(size-3);
          line2 = line4;
          line3 = line5;
          line4 = null;
          line5 = null;
          line1.setText( "\t" + op + "\t" + source + "," + dest );
        }
        else
        {
          arithcombines++;
          // collapse to two instructions
          lines.remove(size-3);
          line3 = line4;
          line4 = line5;
          line5 = null;
          line2.setText( "\tmove.l\t" + source + ",d0" );
          line1.setText( "\t" + op + "\td0," + dest );
        }
        // System.out.println( in.getLineNumber() + ": arithcombines " + op );
      }
      else if ( size >= 5 && line1.op.equals("unlk") )
      {
        if ( line2.isStackAdjust )
        {
          // System.out.println( in.getLineNumber()+":\tAvoided stack adjust (1)" );
          stackops++;
          lines.remove(size-2);
          line2 = line3;
          line3 = line4;
          line4 = line5;
          line5 = null;
        }
        else if ( line3.isStackAdjust && line2.isStackSafe )
        {
          // System.out.println( in.getLineNumber()+":\tAvoided stack adjust (2)" );
          stackops++;
          lines.remove(size-3);
          line3 = line4;
          line4 = line5;
          line5 = null;
        }
        else if ( line4.isStackAdjust && line3.isStackSafe && line2.isStackSafe )
        {
          // System.out.println( in.getLineNumber()+":\tAvoided stack adjust (3)" );
          stackops++;
          lines.remove(size-4);
          line4 = line5;
          line5 = null;
        }
        else if ( line5.isStackAdjust && line4.isStackSafe &&
          line3.isStackSafe && line2.isStackSafe )
        {
          // System.out.println( in.getLineNumber()+":\tAvoided stack adjust (4)" );
          stackops++;
          lines.remove(size-5);
          line5 = null;
        }
      }
      else if ( size>=3 &&
        line3.isMove && line3.isStackSafe &&
        line2.isMove && line2.isPush &&
        line1.isMove && line1.isStackSafe &&
        line3.source.equals("a0") && line3.destination.equals("d0") &&
        line2.source.equals("d0") &&
        line1.source.equals("d0") && line1.destination.equals("a0") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided a0 shuffle" );
        stackops++;
        lines.remove(size-2);
        lines.remove(size-3);
        line2 = line4;
        line3 = line5;
        line4 = null;
        line5 = null;
        line1.setText( "\tmove.l\ta0,-(a7)" );
      }
      else if ( size>=3 &&
        line3.isMove && line3.isStackSafe &&
        line2.op.equals("tst.l") && line2.isStackSafe &&
        line1.op.startsWith("b") &&
        (line3.destination.equals(line2.source) || line3.source.equals(line2.source)) &&
        !line2.source.startsWith("a") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided tst.l" );
        arithcombines++;
        /*
        lines.remove(size-2);
        line2 = line3;
        line3 = line4;
        line4 = line5;
        line5 = null;
        */
        line2.setText("\t; avoided " + line2.text);
      }
      else if ( size>=2 &&
        line2.op.equals("ext.l") &&
        line1.op.equals("move.w") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided ext.l" );
        signextends++;
        lines.remove(size-2);
        line2 = line3;
        line3 = line4;
        line4 = line5;
        line5 = null;
      }
      else if ( size>=2 &&
        line2.op.equals("ext.l") &&
        line1.op.equals("tst.l") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided ext.l" );
        signextends++;
        lines.remove(size-2);
        line2 = line3;
        line3 = line4;
        line4 = line5;
        line5 = null;
        line1.setText( "\ttst.w\td0" );
      }
      else if ( size>=2 &&
        line2.isPush && line2.isMove && // line2.source.equals("(a7)") &&
        line1.text.equals("\taddq.l\t#4,a7") )
      {
        // PMD 2.2.2 wasted pushes removed including unused dup
        // System.out.println( in.getLineNumber()+":\tAvoided unused push+stack adjust" );
        stackops += 2;
        lines.remove(size-1);
        lines.remove(size-2);
        line1 = line3;
        line2 = line4;
        line3 = line5;
        line4 = null;
        line5 = null;
      }
      else if ( size>=2 &&
        line2.text.equals("\taddq.l\t#4,a7") &&
        line1.isPush && line1.isMove && line1.source.indexOf("a7") < 0 )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided unused stack adjust" );
        stackops++;
        lines.remove(size-2);
        line2 = line3;
        line3 = line4;
        line4 = line5;
        line5 = null;
        line1.setText( "\tmove.l\t" + line1.source + ",(a7)" );
      }
      else if ( size>=2 &&
        line2.isPush && line2.isMove &&
        line1.text.equals("\ttst.l\t(a7)") )
      {
        // System.out.println( in.getLineNumber()+":\tAvoided testing TOS" );
        stackops++;
        lines.remove(size-1);
        line1 = line2;
        line2 = line3;
        line3 = line4;
        line4 = line5;
        line5 = null;
      }
      else if ( size>=2 &&
        line2.isPush && line2.isMove &&
        line1.isPop && line1.isMove )
      {
        if ( ( line2.source.equals("d0") && line1.destination.startsWith("d0") ) ||
          ( line2.source.equals("a0") && line1.destination.startsWith("a0") ) )
        {
          // System.out.println( in.getLineNumber()+":\tAvoided push/pop" );
          stackops += 2;
          lines.remove(size-1);
          lines.remove(size-2);
          line1 = line3;
          line2 = line4;
          line3 = line5;
          line4 = null;
          line5 = null;
        }
        else
        {
          stackops++;
          String source = line2.source;
          String dest = line1.destination;
          // System.out.println( in.getLineNumber()+":\tmove.l\t"+source+","+dest );
          lines.remove(size-2);
          line2 = line3;
          line3 = line4;
          line4 = line5;
          line5 = null;
          line1.setText( "\tmove.l\t" + source + "," + dest );
        }
      }
      /* **
      else if ( size>=5 &&    // PMD 2.1.7
        line5.isPush && line5.isMove &&
        line1.isPop && line1.isMove &&
        line4.isPush && line4.isMove &&
        line2.isPop &&
        line3.isStackSafe && line3.isMove &&
        line1.destination.startsWith("a0") && line5.source.equals("a0") &&
        !line3.destination.startsWith("a0") && !line2.destination.startsWith("a0")
        )
      {
        System.out.println( in.getLineNumber()+": this.x++ style" );
        lines.remove(size-1);
        lines.remove(size-5);
        line1 = line2;
        line2 = line3;
        line3 = line4;
        line4 = null;
        line5 = null;
      }
      ** */
    }

    flush();

    out.close();
    in.close();

    if ( RENAME )
    {
      infile.delete();
      outfile.renameTo(infile);
    }

    if ( signextends > 0 )
      System.out.println( " sign-extensions removed: " + signextends );
    if ( stackops > 0 )
      System.out.println( "stack operations removed: " + stackops );
    if ( arithcombines > 0 )
      System.out.println( "     combined arithmetic: " + arithcombines );
    System.out.println();
  }

  static void process(String className) throws IOException
  {
    new Peephole(className);
  }

  public static void main(String[] args)
  {
    System.out.println("Peephole Optimizer for Jump " + Jump.JUMP_VERSION);
    System.out.println("Copyright (c) 2002 by Peter Dickerson <peter.dickerson@ukonline.co.uk>");
    System.out.println("Please see the file COPYING (GPL v2) for distribution rights.\n");

    if ( args.length == 1 )
    {
      try
      {
        Peephole.process(args[0]);
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
      System.out.println("Usage: Peephope <class>");
  }
}
