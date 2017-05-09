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
    This file has been modified in 03-05/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;

class PilaWriter extends PrintWriter 
{
  /** local class describing a macro. */
  class Macro
  {
    String name;
    String[] params;
    Vector lines = new Vector();

    Macro (String name, String[] params) 
    {
      this.name = name;
      this.params = params;

      macros.put (name, this);
    }

    void addExpansionLine (String line)
    {
      lines.add(line);
    }

    String[] expand (String[] args)
    {
      int nArgs = Math.max(args.length, params.length);
      int nLines = lines.size();
      String[] result = new String[nLines];

      for (int i=0; i<nLines; i++) {
	String line = (String) lines.get(i);
	String comment = null;
	int posSemi = line.indexOf(';');
	if (posSemi >= 0) {
	  comment = line.substring(posSemi);
	  line = line.substring(0, posSemi);
	}
	for (int j=0; j<nArgs; j++) {
	  String param = params[j];
	  int startpos = 0;
	  int pos;
	  while ((pos = line.indexOf (param, startpos)) >= 0) {
	    line = (line.substring (0, pos) + args[j] + 
		    line.substring (pos + param.length()));
	    startpos = pos + args[j].length();
	  }
	}
	result[i] = (comment == null ? 
		     line :
		     line + comment);
      }
      return result;
    }
  }

  /** Constant: the fresh lines from the application go here. */
  final String STREAM_MARKER = new String("***STREAM_MARKER***");

  /** Constant: empty string array. */
  final static String[] ZERO_STRINGS = new String[0];

  /** The so-far accumulated current text line. */
  protected StringBuffer currentLine = new StringBuffer(80);

  /** Linked list of lines (Strings) to be processed. */
  LinkedList lineStack = new LinkedList();

  /** Vector of all lines belonging into the data segment. */
  Vector dataLines = new Vector();

  /** Flag: we are collecting data for the data segment. */
  boolean collectingData = false;

  /** Flag: we are replaying data for the data segment. */
  boolean replayingData = false;

  /** Macro storage. Hashtable macro-name -> Macro. */
  Hashtable macros = new Hashtable();

  /** the macro we currently collect lines into. */
  Macro currentMacro = null;

  /** Definitions storage. Hashtable symbol -> Boolean.TRUE. */
  Hashtable definitions = new Hashtable();

  /** 
   * Stack of #ifdef truth-values applying to the current line.
   * Vector of Boolean.TRUE and Boolean.FALSE values,
   * the first corresponding to the outermost #ifdef block.
   * A line is assembled only if all elements are TRUE.
   */
  Vector ifdefStack = new Vector();

  /**
   * Summary truth value of truthStack.
   */
  boolean ifdefValue = true;

  /**
   * Construct a PilaWriter writing to a given stream.
   */
  public PilaWriter (Writer out) {
    super(out);
    lineStack.add(STREAM_MARKER);
    lineStack.add("\tdata");
  }

  /**
   * Translate the first String in lineStack according to 
   * specific macroexpansion/translation rules.
   * <p>
   * Translates macros according to their definition.
   * Ignores conditional lines if their #ifdef test isn't satisfied.
   * Collects and consumes lines for the data segment.
   * They are sent when the stream is closed.
   * <p>
   * Lines are either sent immediately to the output stream or
   * pushed onto the lineStack.
   */
  public void processLine () throws IOException {
    String inLine = (String) lineStack.removeFirst();
    String codePart = "";
    String comment = "";
    int posSemi;
    if ((posSemi = inLine.indexOf(";")) >= 0) {
      comment = inLine.substring(posSemi);
      codePart = inLine.substring(0,posSemi);
    }
    else {
      codePart = inLine;
    }

    StringTokenizer st = new StringTokenizer(codePart," \t");
    String label = "";
    String opcode = "";
    String opcodeLower = null;
    String args = "";
    String rest = "";
    try {
      if (!Character.isWhitespace(codePart.charAt(0))) {
	label = st.nextToken();
      }
      opcode = st.nextToken();
      args = st.nextToken();
      rest = st.nextToken("");
    }
    catch (Exception ex) {
    }
    opcodeLower = opcode.toLowerCase();

    //
    // conditional assembly
    //
    if (label.equals("#ifdef")) {
      Boolean satisfied = (definitions.get(opcodeLower) != null ?
			   Boolean.TRUE : Boolean.FALSE);
      ifdefStack.add(satisfied);
      updateIfdefValue();
      out.write("; ( " + inLine + " )");
      doPrintln();
    }
    else if (label.equals("#ifndef")) 
    {
      Boolean satisfied = (definitions.get(opcodeLower) == null ?
        Boolean.TRUE : Boolean.FALSE);
      ifdefStack.add(satisfied);
      updateIfdefValue();
      out.write("; ( " + inLine + " )");
      doPrintln();
    }
    else if (label.equals("#else")) 
    {
      int lastIndex = ifdefStack.size() - 1;
      ifdefStack.set(lastIndex,
		     (ifdefStack.get(lastIndex) == Boolean.TRUE ?
		      Boolean.FALSE : Boolean.TRUE));
      updateIfdefValue();
      out.write("; ( " + inLine + " )");
      doPrintln();
    }
    else if (label.equals("#endif")) {
      int lastIndex = ifdefStack.size() - 1;
      ifdefStack.remove(lastIndex);
      updateIfdefValue();
      out.write("; ( " + inLine + " )");
      doPrintln();
    }
    else if (!ifdefValue) {
      // ignore line
    }
    else if (label.equals("#define")) {
      definitions.put(opcodeLower, Boolean.TRUE);
      out.write("; ( " + inLine + " )");
      doPrintln();
    }

    //
    // macro definitions and usages
    //
    else if (label.equals("#defmacro")) {
      StringTokenizer argTok = new StringTokenizer(args, ",");
      int nArgs = argTok.countTokens();
      String[] macroArgs = new String[nArgs];
      for (int i=0; i<nArgs; i++) {
	macroArgs[i] = argTok.nextToken();
      }
      currentMacro = new Macro(opcodeLower, macroArgs);
      out.write("; ( " + inLine + " )");
      doPrintln();
    }
    else if (label.equals("#endmacro")) {
      currentMacro = null;
    }
    else if (currentMacro != null) {
      currentMacro.addExpansionLine(inLine);
    }
    else if (macros.get(opcodeLower) != null) {
      Macro macro = (Macro) macros.get(opcodeLower);
      StringTokenizer argTok = new StringTokenizer(args, " ,	");
      int nArgs = argTok.countTokens();
      String[] macroArgs = new String[nArgs];
      for (int i=0; i<nArgs; i++) {
	macroArgs[i] = argTok.nextToken();
      }
      String[] expansion = macro.expand(macroArgs);
      for (int i=expansion.length-1; i>=0; i--) {
	lineStack.addFirst(expansion[i]);
      }
    }

    //
    // data and segmentation directives
    //
    else if (replayingData) {
      out.write(inLine);
      doPrintln();
    }
    else if (opcodeLower.equals("data")) {
      collectingData = true;
    }
    else if (opcodeLower.equals("enddata")) {
      collectingData = false;
    }
    else if (opcodeLower.equals("code")) {
      collectingData = false;
      out.write(inLine);
      doPrintln();
    }
    else if (opcodeLower.equals("res")) {
      collectingData = false;
      out.write(inLine);
      doPrintln();
    }
    else if (collectingData) {
      lineStack.addLast(inLine);
    }

    //
    // plain line
    //
    else {
      out.write(inLine);
      doPrintln();
    }
  }

  /**
   * Update the ifdefValue field to be the summary value 
   * of ifdefStack - true iff all elements are Boolean.TRUE.
   */
  public void updateIfdefValue()
  {
    boolean result = true;
    for (int i=0; i<ifdefStack.size(); i++) {
      result = result && ((Boolean) ifdefStack.get(i)).booleanValue();
    }
    ifdefValue = result;
  }

  /**
   * Process the lineStack from the from the front.
   * Stops when reaching the STREAM_MARKER or the stack's end.
   */
  public void processLineStack() 
  {
    try {
      String line;
      while ((line=((String)lineStack.get(0))) != STREAM_MARKER) {
	processLine();
      }
    }
    catch (IOException ioexc) {
      throw JumpException.addInfo(ioexc, "processing PilaWriter's lineStack");
    }
    catch (Exception exc) {
    }
  }

  /**
   * Add the current line to lineStack's front. 
   * Processing of line is immediately started.
   */
  public void addAndProcessCurrentLine()
  {
    lineStack.addFirst(currentLine.toString());
    currentLine.setLength(0);
    processLineStack();
  }

  /** 
   * Write a single character. 
   */
  public void write(int c) 
  {
    currentLine.append((char) c);
  }

  /** 
   * Write a portion of an array of characters. 
   */
  public void write(char buf[], int off, int len) 
  {
    currentLine.append(buf, off, len);
  }

  /**
   * Write an array of characters.
   */
  public void write(char buf[]) 
  {
    currentLine.append(buf);
  }

  /** 
   * Write a portion of a string. 
   */
  public void write(String s, int off, int len) 
  {
    currentLine.append(s.substring(off, len));
  }

  /**
   * Write a string.
   */
  public void write(String s) 
  {
    currentLine.append(s);
  }

  /**
   * Terminate the current line by writing the line separator string.
   * Before writing, the line is translated.
   */
  public void println() 
  {
    addAndProcessCurrentLine();
  }

  /**
   * Really do newline.
   */
  public void doPrintln() 
  {
    super.println();
  }

  /** 
   * Flush the stream. 
   */
  public void flush() 
  {
    addAndProcessCurrentLine();

    lineStack.removeFirst();
    lineStack.addLast("\tend");
    replayingData = true;
    processLineStack();
    super.flush();
  }

  /**
   * close the stream, after writing the collected data-segment lines.
   */
  public void close()
  {
    flush();
    super.close();
  }
}
