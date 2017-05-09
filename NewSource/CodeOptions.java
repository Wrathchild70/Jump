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
    This file has been created in 05/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

/*
   November 2001
    This file has been modified by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    to add some code optimization and to extend the functionality.
*/

import java.io.*;
import java.util.*;

class CodeOptions {

  /** memory model constant for single-segment application. */
  public static final int SMALL = 0;
  
  /** memory model constant for multi-segment application. */
  public static final int LARGE = 1;

  /** memory model constant for multi-segment, large-heap application. */
  public static final int HUGE = 2;

  /**
   * assume side-effect-free local methods in static-field initializations.
   */
  boolean localMethodsHaveNoSideEffect = true;

  /**
   * assume &lt;init&gt; methods to be side-effect-free: 
   * they only need to be called if the instance is needed.
   */
  boolean initMethodsHaveNoSideEffect = true;

  /**
   * assume array data in static class initilization is needed.
   */
  boolean initStaticArrayData = false;

  /**
   * memory model: SMALL or LARGE or HUGE.
   * <p>
   * SMALL is a single-segment application 
   * (code size < 32K, heap in dynamic space)
   * <p>
   * LARGE is a multi-segment application 
   * (code size unlimited, heap in dynamic space)
   * <p>
   * HUGE is a multi-segment, large-heap application 
   * (code size unlimited, heap in data storage space)
   */
  int memoryModel = SMALL;

  /**
   * wabajump compilation mode (different startup)
   */
  boolean wabajump = false;

  /** breakpoint at startup. */
  boolean breakpoint = false;

  /** include procedure names. */
  boolean debugSymbols = false;

  /** degree of output messages. */
  int verbosity = 0;

  /** stack size in bytes. */
  int stacksize = 0;
  
  /** optimisation level. */
  int optimization = 0;

  /** check accesses for null. */
  boolean checkNull = true;

  /** check access for null inline if checkNull true. */
  boolean checkNullInline = false;

  /** check array access in bounds. */
  boolean checkBounds = true;

  /** indicates that stack checks are required  */
  boolean checkStack = true;

  /** for backward compatibility include Pilot.inc */
  boolean usePilotInc = false;

  /** Indicates whether to store class names in prc */
  boolean includeClassNames = true;

  /** Indicated that Peephole optimization should be applied */
  boolean usePeephole = false;

  /** indicates to include finalizer handling in the memory manager */
  boolean useFinalizers = true;

  /**
   * indicates to call static clinits dynamically
   * when a static is referenced rather than calling all
   * clinits in some sequence during startup.
   */
  boolean useDynamicClinit = false;

  /**
   * indicates to use GNU gas assembler syntax instead of Pila
   */
  boolean useGNUAsm = false;

  /** indicates to use the package path of the main Class for the asm file  */
  boolean asmPathUsesPackage = true;   // compatibility with previous version

  /** Vector of names defined by -D option */
  Vector defines = null;

  /** name of class known to be safely called virtually without instance
   * used to suppress warning
   */
  private String knownCVWI= "";

  /* limit on number of bytecodes compiled into one segment segment bytecode */
  int segmentBytecodeLimit = 0;

  /**
   * constructs a new CodeOptions instance with values
   * from the command line and the properties files.
   *
   * @param args  Jump's command-line arguments
   * @param props combined Properties for Jump and project
   */
  CodeOptions (String[] args, Properties props)
  {
    for (Enumeration pe = props.propertyNames();
      pe.hasMoreElements(); ) 
    {
      String name = ((String) pe.nextElement()).toLowerCase();
      String value = props.getProperty(name);
      String valueLower = value.toLowerCase();

      if (name.equals("memory")) 
      {
        if (valueLower.equals("small")) 
        {
          memoryModel = SMALL;
        }
        else if (valueLower.equals("large")) 
        {
          memoryModel = LARGE;
        }
        else if (valueLower.equals("huge")) 
        {
          memoryModel = HUGE;
        }
      }
      else if (name.equals("target")) 
      {
        wabajump = (valueLower.equals("wabajump"));
      }
      else if (name.equals("debug")) 
      {
        if (valueLower.equals("no")) 
        {
          breakpoint   = false;
          debugSymbols = false;
        }
        else if (valueLower.equals("symbols")) 
        {
          breakpoint   = false;
          debugSymbols = true;
        }
        else if (valueLower.equals("break")) 
        {
          breakpoint   = true;
          debugSymbols = true;
        }
      }
      else if (name.equals("verbose")) 
      {
        int val = Integer.parseInt(value);
        if (val < 0) 
        {
          val = 0;
        }
        else if (val > 2) 
        {
          val = 2;
        }
        verbosity = val;
      }
      else if (name.equals("stacksize")) 
      {
        int val = Integer.parseInt(value);
        if (val < 2000) 
        {
          val = 2000;
        }
        else if (val > 64000) 
        {
          val = 64000;
        }
        stacksize = val;
      }
      else if (name.equals("segment-bytecode-limit")) 
      {
        segmentBytecodeLimit = Integer.parseInt(value);
        if (segmentBytecodeLimit < 2000) 
          segmentBytecodeLimit = 2000;
        else if (segmentBytecodeLimit > 10000) 
          segmentBytecodeLimit = 10000;
      }
      else if (name.equals("optimization")) 
      {
        int val = Integer.parseInt(value);
        if (val < 0)
          val = 0;
        optimization = val;
      }
      else if (name.equals("check-null")) 
      {
        checkNull = !valueLower.equals("no"); 
        checkNullInline = valueLower.equals("fast"); 
      }
      else if (name.equals("check-bounds")) 
      {
        checkBounds = !valueLower.equals("no"); 
      }
      else if (name.equals("check-stack")) 
      {
        checkStack = !valueLower.equals("no"); 
      }
      else if (name.equals("use-pilot-inc")) 
      {
        usePilotInc = !valueLower.equals("no"); 
      }
      else if (name.equals("class-names")) 
      {
        usePilotInc = !valueLower.equals("no"); 
      }
      else if (name.equals("peephole")) 
      {
        usePeephole = !valueLower.equals("no"); 
      }
      else if (name.equals("finalize")) 
      {
        useFinalizers = !valueLower.equals("no"); 
      }
      else if (name.equals("init-static-array-data")) 
      {
        initStaticArrayData = !valueLower.equals("no"); 
      }
      else if (name.equals("dynamic-class-init")) 
      {
        useDynamicClinit = !valueLower.equals("no"); 
      }
      else if (name.equals("asm-path-uses-package")) 
      {
        asmPathUsesPackage = !valueLower.equals("no"); 
      }
      else if (name.equals("gnu-asm")) 
      {
        useGNUAsm = !valueLower.equals("no"); 
      }
      else if (name.equals("define")) 
      {
        if ( defines == null )
          defines = new Vector();
        defines.add(value);
      }
      else if (name.equals("called-virtually-without-instances")) 
      {
        knownCVWI = knownCVWI + " " + value;
      }
    }
    
    for (int i=0; i<args.length-1; i++) 
    {
      if (args[i].charAt(0) == '-') 
      {
        String optionArg = args[i];
        int len = optionArg.length();
        for (int j=1; j<len; j++) 
        {
          switch (optionArg.charAt(j)) 
          {
          case 'a':
            checkBounds = !checkBounds;
            break;
          case 'A':
            initStaticArrayData = !initStaticArrayData;
            break;
          case 'b':
            debugSymbols = true;
            breakpoint   = true;
            break;
          case 'B':
            // stacksize
            if (i < args.length-2) 
            {
              i++;
               segmentBytecodeLimit = Integer.parseInt(args[i]);
              if (segmentBytecodeLimit < 2000) 
                segmentBytecodeLimit = 2000;
              else if (segmentBytecodeLimit > 10000) 
                segmentBytecodeLimit = 10000;
            }
            break;
          case 'c':
            includeClassNames = !includeClassNames;
            break;
          case 'D':
            if ( defines == null )
              defines = new Vector();
            defines.add(optionArg.substring(j+1));
            j = len;
            break;
          case 'f':
            useFinalizers = !useFinalizers;
            break;
          case 'g':
            debugSymbols = true;
            breakpoint   = false;
            break;
          case 'G':
            useGNUAsm = !useGNUAsm;
            break;
          case 'h':
            memoryModel = HUGE;
            break;
          case 'l':
          case 'm':
            memoryModel = LARGE;
            break;
          case 'n':
            checkNull = !checkNull;
            checkNullInline = false;
            break;
          case 'N':
            checkNull = !checkNull;
            checkNullInline = checkNull;
            break;
          case 'O':
            // optimization
            if ( j+1 < len && Character.isDigit(optionArg.charAt(j+1)) )
            {
              j++;    // skip char
              optimization = (int)optionArg.charAt(j)-(int)'0';
            }
            else
              optimization = 6;
            break;
          case 'p':
            usePilotInc = true;
            break;
          case 'P':
            usePeephole = !usePeephole;
            break;
          case 'q':
            asmPathUsesPackage = !asmPathUsesPackage;
            break;
          case 's':
            // stacksize
            if (i < args.length-2) 
            {
              i++;
              int val = Integer.parseInt(args[i]);
              if (val < 2000) 
              {
                val = 2000;
              }
              else if (val > 64000) 
              {
                val = 64000;
              }
              stacksize = val;
            }
            break;
          case 'S':
            checkStack = !checkStack;
            break;
          case 't': /* aka small */
            memoryModel = SMALL;
            break;
          case 'v':
            verbosity = 1;
            break;
          case 'V':
            verbosity = 2;
            break;
          case 'w':
            wabajump = true;
            break;
          case 'X': // for experimental/undocumented options
            // optimization
            if ( j+1 < len && Character.isDigit(optionArg.charAt(j+1)) )
            {
              int n = optionArg.charAt(j+1);
              j++;    // skip char
              localMethodsHaveNoSideEffect = (n & 1) != 0;
              initMethodsHaveNoSideEffect = (n & 2) != 0;
              initStaticArrayData = (n & 4) == 0;
            }
            else
            {
              localMethodsHaveNoSideEffect = false;
              initMethodsHaveNoSideEffect = false;
              initStaticArrayData = true;
            }
            // System.out.println( "localMethodsHaveNoSideEffect=" + localMethodsHaveNoSideEffect +
            //  " initMethodsHaveNoSideEffect=" + initMethodsHaveNoSideEffect );
            break;
          case 'y':
            useDynamicClinit = !useDynamicClinit;
            break;
          default:
            Jump.showUsage();
            break;
          }
        }
      }
    }
  }

  boolean knownCalledVirtuallyWithoutInstances(Klass cls)
  {
    return knownCVWI.indexOf(cls.className) >= 0;
  }

  /**
   * gives a readable description of the CodeOptions settings.
   */
  public String toString()
  {
    StringBuffer buf = new StringBuffer("Code Options: ");

    if (wabajump) 
      buf.append("WabaJump, ");
    
    if (debugSymbols) 
      buf.append("Debug Symbols, ");

    if (breakpoint) 
      buf.append("Breakpoint, ");

    if (stacksize > 0) 
      buf.append("Stack=" + stacksize + ", ");
    
    if (optimization>0) 
    {
      buf.append("Optimization=" + optimization + ", ");
    }

    if ( usePeephole )
      buf.append("Peephole pass, ");

    if ( checkNullInline )
      buf.append("Fast null checks, ");

    if ( !checkNull )
      buf.append("Nulls unchecked, ");

    if ( !checkBounds )
      buf.append("Bounds unchecked, ");

    if ( !checkStack )
      buf.append("Stack unchecked, ");

    if ( !includeClassNames )
      buf.append("Remove Class names, ");

    if ( !useFinalizers )
      buf.append("No finalizers, ");

    if ( useDynamicClinit )
      buf.append("Dynamic clinit, ");

    if ( segmentBytecodeLimit != 0 )
      buf.append("Segment bytecode limit=" + segmentBytecodeLimit + ", ");

    if ( initStaticArrayData )
      buf.append("Init static array data, ");

    if ( useGNUAsm )
      buf.append("GNU asm, ");

    if ( !asmPathUsesPackage )
      buf.append("Remove package name from Asm filename, ");

    if ( usePilotInc )
      buf.append("use pilot.inc, ");

    if ( defines != null )
    {
      for (int i=0; i<defines.size(); i++)
        buf.append("define "+defines.elementAt(i)+", ");
    }

    switch (memoryModel) 
    {
    case SMALL:
      buf.append("Small Model");
      break;
    case LARGE:
      buf.append("Large Model");
      break;
    case HUGE:
      buf.append("Huge Model");
      break;
    }

    return buf.toString();
  }
}
