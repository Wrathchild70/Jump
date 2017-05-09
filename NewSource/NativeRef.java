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
    This file has been introduced in 03-09/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;

/**
 * a reference to the source of one native method.
 */
class NativeRef extends JavaElement implements JVM {
  /** the method signature. */
  String signature;

  /** the source filename. */
  String filename;

  /** the start line number. */
  int start;

  /** flag: whole file insteaf of single routine */
  boolean wholeFile = false;

  /** Hashtable symbol -> names of depended-upon classes, methods and fields. */
  Hashtable dependencies;

  /** constructor. */
  NativeRef (String signature, String filename, int start)
  {
    this.signature = signature;
    this.filename = filename;
    this.start = start;
    this.dependencies = new Hashtable();
  }

  /** constructor. */
  NativeRef (String signature, String filename)
  {
    this.signature = signature;
    this.filename = filename;
    this.start = 0;
    this.wholeFile = true;
    this.dependencies = new Hashtable();
  }

  /** replacement string for a given symbol. */
  String dependencyReplacement (String sym)
  {
    String element = (String) dependencies.get (sym);
    String result;
    int dotPos = element.indexOf (".");
    int parenPos = element.indexOf ("(");
    
    if (element.startsWith("cast ")) {
      Klass cl = Klass.forName(element.substring (5));
      return String.valueOf (Klass.instanceofTargetClassList.indexOf (cl));
    }
    else if (dotPos < 0) {
      return String.valueOf (Klass.forName(element).classIndex);
    }
    else if (parenPos < 0) {
      String cln = element.substring (0, dotPos);
      String fln = element.substring (dotPos+1);
      FieldInfo field = Klass.forName(cln).findField(fln);

      if ((field.access_flags & ACC_STATIC) != 0) {
        return field.shortLabel();
      }
      else {
        return String.valueOf (field.offset);
      }
    }
    else {
      String cln = element.substring (0, dotPos);
      String mtn = element.substring (dotPos+1, parenPos);
      String mts = element.substring (parenPos);
      
      Klass.forName(cln).findMethod(mtn,mts).intersegment = true;

      return Klass.forName(cln).findMethod(mtn,mts).shortLabel();
    }
  }

  /**
   * update the 'needed' state of this native code and related elements.
   * Only used for opcode implementations and kernel routines,
   * not for native method implementations.
   */
  void updateNeeded ()
  {
    if (isNeeded(JavaElement.NEEDED)) {
      String element = "";
      for (Enumeration enum=dependencies.elements();
           enum.hasMoreElements(); ) {
        element = (String) enum.nextElement();
        int dotPos = element.indexOf (".");
        int parenPos = element.indexOf ("(");
          
        try {
          if (element.startsWith ("new ")) {
            Klass.forName(element.substring(4)).
              markNeeded(signature,JavaElement.INSTANCE_NEEDED);
          }
          else if (element.startsWith ("cast ")) {
            Klass.forName(element.substring(5)).
              markNeeded(signature, 
                         JavaElement.NEEDED + JavaElement.NEEDED_INSTANCEOF);
          }
          else if (element.startsWith ("exact ")) {
            Klass.forName(element.substring(6)).
              markNeeded(signature,JavaElement.EXACT_INSTANCE_NEEDED);
          }
          else if (dotPos < 0) {
            Klass.forName(element).
              markNeeded(signature,JavaElement.NEEDED);
          }
          else if (parenPos < 0) {
            String cln = element.substring (0, dotPos);
            String fln = element.substring (dotPos+1);
            Klass.forName(cln).findField(fln).
              markNeeded(signature,JavaElement.NEEDED);
          }
          else {
            String cln = element.substring (0, dotPos);
            String mtn = element.substring (dotPos+1, parenPos);
            String mts = element.substring (parenPos);

            Klass.forName(cln).findMethod(mtn,mts).
              markNeeded(signature,JavaElement.NEEDED);
          }
        }
        catch (NullPointerException e) {
          throw JumpException.addInfo(e, signature + " depends upon non-existent " + element);
        }
      }
    }
  }

  /** copy native lines to stream. */
  void copyTo (PrintWriter asmout)
  {
    try {
      LineNumberReader nf = (new LineNumberReader 
                             (new InputStreamReader 
                              (Jump.getClasspathStream (filename))));
        
      if (!wholeFile) {
        while (nf.getLineNumber() < start) {
          nf.readLine();
        }
      }

      while (true) {
        String s = nf.readLine();
        boolean bsrFar = false;
        if (s == null) {
          break;
        }

        for (Enumeration enum=dependencies.keys();
             enum.hasMoreElements(); ) {
          try {
            String sym = (String) enum.nextElement();
            int startpos = 0;
            int pos;
            while ((pos = s.indexOf (sym, startpos)) >= 0) {
              String rep = dependencyReplacement (sym);
              s = (s.substring (0, pos) + rep + 
                   s.substring (pos + sym.length()));
              startpos = pos + rep.length();
            }
          }
          catch (Exception e) { }
        }
        if (s.length() > 80) {
          int ps = s.indexOf(";");
          if (ps < 0) {
          }
          else if (ps < 80) {
            s = s.substring(0,80) + "...";
          }
          else {
            s = s.substring(0,ps);
          }
        }
        asmout.println(s);
        if (!wholeFile &&
            (s.length() == 0 || s.charAt(0) == '\r')) { // grr
          break;
        }
      }
    } 
    catch (Exception e) {
      throw JumpException.addInfo(e, "Exception while reading from " + filename);
    }
  }

  /** 
   * Find all global labels declared in this code.
   * The labels are appended to the Vector's end.
   * Global labels are those followed by a colon.
   */
  void addAllLabels(Vector labels)
  {
    try {
      LineNumberReader nf = (new LineNumberReader 
                             (new InputStreamReader 
                              (Jump.getClasspathStream (filename))));
        
      if (!wholeFile) {
        while (nf.getLineNumber() < start) {
          nf.readLine();
        }
      }

      while (true) {
        String s = nf.readLine();
        if (s == null) {
          break;
        }

        StringTokenizer st = new StringTokenizer(s);
        try {
          String label = st.nextToken();
          if (label.endsWith(":")) {
            labels.addElement(label.substring(0, label.length()-1));
          }
        }
        catch (NoSuchElementException e) {
        }
        if (!wholeFile &&
            (s.length() == 0 || s.charAt(0) == '\r')) { // grr
          break;
        }
      }
    } 
    catch (Exception e) {
      throw JumpException.addInfo(e, "exception while reading from " + filename);
    }
  }

  /** 
   * add a dependency to this NativeRef. 
   * In addition, this method can define a string to name the
   * depended-upon object in the context of this native code.
   * Jump replaces this symbol according to the following rules:
   * <table>
   * <tr><td>Class</td>
   *     <td>the numerical index of the class</td></tr> 
   * <tr><td>Method</td>        
   *     <td>the label of the corresponding routine</td></tr> 
   * <tr><td>Static field</td>
   *     <td>the label of the field</td></tr> 
   * <tr><td>Instance field</td>
   *     <td>the numerical offset of the field</td></tr>
   * </table>
   *
   * @param signature a string in signature syntax
   *                  naming a class, method or field.
   * @param asmSymbol the symbol to be replaced (or null: no replacement)
   */
  void addDependency (String signature, String asmSymbol)
  {
    if (asmSymbol != null) {
      dependencies.put (asmSymbol, signature);
    }
    else {
      dependencies.put (new Integer (AsmBackEnd.depCounter++), signature);
    }
  }
} 

