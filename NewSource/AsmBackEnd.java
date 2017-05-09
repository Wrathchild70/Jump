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

/*
   November 2001
    This file has been modified by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    to add some code optimization and to extend the functionality.
    A number of changes have been made.
    1) A flag is kept that records whether the top of stack is currently in
    the D0 register. Bytecodes are classified according whether they can accept a
    value in D0 (optionally) or only on the stack. The code generation for each
    bytecode can then look ahead one bytecode to see there is best to leave the
    result. At a branch label the result must be stacked because it is not clear
    what state other paths to this point might do - so we assume the worst. This
    peephole approach save a small amount of code by occasionally avoiding a push
    or pop but generally improves speed by reducing the number of memory moves.
    2) Register A0 is used to store the value of a pointer loaded from a local
    variable via an aload_n bytecode. A record is kept of which pointer is currently
    in A0 (localInA0) which is invalidated by bytecodes that might destroy A0, such
    as those implemented by function calls. This caching of a pointer in A0 can avoid
    loading of the pointer.
    3) Whenever a pointer is dereferenced it must be checked for null. A record is
    kept of which local variables have been checked already and avoid retesting. At
    a label all knowledge is thrown away rather than analysing all execution paths.
    This information can be used to reduce the checks for array accesses too.
    4) A number of patterns are matched to avoid generating very poor code. For
    example by detecting array initializers and converting them to one instruction
    per element (typically). Operations by a constant are also detected so that
    multiplies by a small constant or divides by a power of two can generate inline
    code. Short runs of integer operations coresponding to e.g. a+b+c are handled as
    special cases to avoid stacking operations. Other patterns such as aload_n followed
    by getfield can be combined into an indexed load.
    5) The stack is analysed in more detail to record the origin of pointers. This
    means that, at code generation it, may be known what pointer is on the stack, the
    push can then be avoided by disabling the originating instruction and the load
    combined with a putfield (for example). This is acheived by maintaining an array
    of code annotations, one element for each bytecode.
    6) The code generated for an array access has been shortened and more address to
    the support routine. This save about four bytes of code per array element access.
*/
/*
 * 16 Jan 2003.  PMD Fix for op_saload, which caused Pila errors
 * 19 Sept 2003. PMD Fix so that J2SDK 1.4.2 can be used.
 * 11 Dec 2003.  PMD String init moved to start of segment to increase literal capacity.
 * 13 Dec 2003.  PMD Resource file (.res) uses current dir if asm-path-uses-package = no.
 * 22 Feb 2004. 2.2.2 PMD Make sure class init runs before any construction caused by Class.newInstance().
 * 
 */
import java.io.*;
import java.util.*;

class AsmBackEnd implements BackEnd, JVM 
{

  /** when true forces Jump to call a test routine after every field write */
  static private final boolean TRACE_STORES = false;

  /** limit on the total size of all constant strings */
  static private final int STRING_POOL_SIZE = 64000;

  /** the output stream for the asm file. */
  PrintWriter asmout;

  /** the filename of the asm file. */
  String asmoutFilename;

  /** the project name */
  String projectname;

  /** counter for producing unique hash keys. */
  static int depCounter = 0;

  /** Hashtable of natives found on the path. */
  Hashtable allNatives;
  
  /**
   * Array indicating which opcodes can handle the top of stack
   * in a register.
   */
  boolean opHandlesRegister[] = new boolean[256];

  /** The length of Itables in words */
  int itableWords = 0;

  /** Flag: segmentedCode memory model. */
  boolean segmentedCode = false;

  /** Flag: wabajump compilation mode. */
  boolean wabajump = false;

  /** Flag: use data storage for heap. */
  boolean dmHeap = false;

  /** Flag: include debug symbols. */
  boolean debugSymbols = false;

  /** Flag: include startup breakpoint. */
  boolean breakpoint = false;

  /** Flag: include finalizers */
  boolean useFinalizers = false;

  /** Requested stack size in bytes. */
  int stacksize = 0;
  
  /** Optimization level. */
  int optimization = 0;

  /** Indicates that null checking is to be used */
  boolean checkNull = true;

  /** check access for null inline if checkNull true. */
  boolean checkNullInline = false;

  /** Indicates that array bounds checking is to be used */
  boolean checkBounds = true;

  /** indicates that stack checks are required  */
  boolean checkStack = true;

  /** for backward compatibility include Pilot.inc */
  boolean usePilotInc = false;

  /** Indicates whether to store class names in prc */
  boolean includeClassNames = true;

  /** Indicates that dynamic class initialization code should be generated */
  boolean useDynamicClinit = false;

  /** Vector: v[i] = Vector of methods in segment 'i'. */
  Vector segmentMethods = new Vector();

  /** Each Class that must have <clinit> called early. */
  Vector earlyClassInit = new Vector();
  
  /** count of null pointer checks */
  int nullChecksTotalCount = 0;
  
  /** count of null pointer checks that have been removed */
  int nullChecksAvoidedCount = 0;

  CodeIterator iterator;
  MethodInfo method;
  String label;
  ConstantPool pool;
  boolean[] jumpTargets;
  boolean[] neededArray;
  private int localInA0;      // which aload is cached in a0 (-1 for none)
  private int localInD0;      // which iload is cached in d0 (-1 for none)
  private boolean needsReturn;
  private CodeAnnotation[] annotations;
  private boolean finalizer; // true for finalize() method
  private int methodNum=0;  // counter for progress

  /**
   * names of register for registered locals
   */
  String registerNames[];

  /** 
   * Limit for the bytecode size that probably fits into one segment.
   */
  int segmentBytecodeLimit = 3200;

  /*
   *          Constructors and related methods
   * ====================================================
   */

  /**
   * construct an AsmBackEnd from project name and directory.
   */
  AsmBackEnd (String projectname, String baseDirectory)
  {
    File out = new File (baseDirectory, projectname + ".asm");

    asmoutFilename = out.getPath();
    this.projectname = projectname;

    segmentedCode = (Jump.codeOptions.memoryModel >= CodeOptions.LARGE);
    dmHeap        = (Jump.codeOptions.memoryModel >= CodeOptions.HUGE);
    wabajump      = Jump.codeOptions.wabajump;
    debugSymbols  = Jump.codeOptions.debugSymbols;
    breakpoint    = Jump.codeOptions.breakpoint;
    useFinalizers = Jump.codeOptions.useFinalizers;
    stacksize     = Jump.codeOptions.stacksize;
    optimization  = Jump.codeOptions.optimization;
    checkNull     = Jump.codeOptions.checkNull;
    checkNullInline = Jump.codeOptions.checkNullInline;
    checkBounds   = Jump.codeOptions.checkBounds;
    usePilotInc   = Jump.codeOptions.usePilotInc;
    includeClassNames = Jump.codeOptions.includeClassNames;
    useDynamicClinit = Jump.codeOptions.useDynamicClinit;
    checkStack    = Jump.codeOptions.checkStack;

    if (Jump.codeOptions.segmentBytecodeLimit != 0)
      segmentBytecodeLimit = Jump.codeOptions.segmentBytecodeLimit;

    if ( optimization > 0 )
    {
      // D0 top-of-stack optimization only occurs for
      // instructions that can handle it.
      // All instructions have to be able to handle tos 
      // on the real stack.
        
      opHandlesRegister[op_nop] = true;

      opHandlesRegister[op_iadd] = true;
      opHandlesRegister[op_isub] = true;
      opHandlesRegister[op_ineg] = true;
      opHandlesRegister[op_ishl] = true;
      opHandlesRegister[op_ishr] = true;
      opHandlesRegister[op_iushr] = true;
      opHandlesRegister[op_iand] = true;
      opHandlesRegister[op_ior] = true;
      opHandlesRegister[op_ixor] = true;

      opHandlesRegister[op_istore_0] = true;
      opHandlesRegister[op_istore_1] = true;
      opHandlesRegister[op_istore_2] = true;
      opHandlesRegister[op_istore_3] = true;

      opHandlesRegister[op_istore] = true;
      opHandlesRegister[op_fstore] = true;
      opHandlesRegister[op_astore] = true;

      opHandlesRegister[op_iaload] = true;
      opHandlesRegister[op_faload] = true;
      opHandlesRegister[op_aaload] = true;

      opHandlesRegister[op_laload] = true;
      opHandlesRegister[op_daload] = true;
      opHandlesRegister[op_baload] = true;
      opHandlesRegister[op_caload] = true;
      opHandlesRegister[op_saload] = true;
            
      opHandlesRegister[op_fstore_0] = true;
      opHandlesRegister[op_fstore_1] = true;
      opHandlesRegister[op_fstore_2] = true;
      opHandlesRegister[op_fstore_3] = true;
    
      opHandlesRegister[op_astore_0] = true;
      opHandlesRegister[op_astore_1] = true;
      opHandlesRegister[op_astore_2] = true;
      opHandlesRegister[op_astore_3] = true;
            
      opHandlesRegister[op_pop] = true;
        
      opHandlesRegister[op_dup] = true;
      opHandlesRegister[op_dup_x1] = true;  // PMD 2.1.8
            
      opHandlesRegister[op_iinc] = true;
            
      opHandlesRegister[op_i2b] = true;
      opHandlesRegister[op_i2s] = true;
        
      opHandlesRegister[op_putstatic] = true;
      opHandlesRegister[op_putfield] = true;
      opHandlesRegister[op_getfield] = true;

      opHandlesRegister[op_ifeq] = true;
      opHandlesRegister[op_ifne] = true;
      opHandlesRegister[op_iflt] = true;
      opHandlesRegister[op_ifge] = true;
      opHandlesRegister[op_ifgt] = true;
      opHandlesRegister[op_ifle] = true;

      opHandlesRegister[op_ifnull] = true;
      opHandlesRegister[op_ifnonnull] = true;

      opHandlesRegister[op_if_icmpeq] = true;
      opHandlesRegister[op_if_icmpne] = true;
      opHandlesRegister[op_if_icmplt] = true;
      opHandlesRegister[op_if_icmpge] = true;
      opHandlesRegister[op_if_icmpgt] = true;
      opHandlesRegister[op_if_icmple] = true;

      opHandlesRegister[op_if_acmpeq] = true;
      opHandlesRegister[op_if_acmpne] = true;

      opHandlesRegister[op_ireturn] = true;
      opHandlesRegister[op_freturn] = true;

    }

    // regsiter names - order must be decreasing for movem to work
    if ( optimization >= 6 )
      registerNames = new String[] { "d7", "d6", "d5", "d4", "d3" };
    else
      registerNames = new String[0];
  }

  /*
   *             natives inclusion methods
   * ====================================================
   */

  /**
   * insert native methods into a class.
   * If a java version (from the class file) exists, it is replaced
   * by the native method.
   */
  public void insertNatives (Klass cls)
  {
    loadAllNatives();

    if (cls.methods != null) 
    {
      for (int i=0; i<cls.methods.length; i++) 
      {
        MethodInfo method = cls.methods[i];
        NativeRef ref = (NativeRef) allNatives.get (method.fullName());

        // allow for wildcard as in '*.registerNatives()V'
        if (ref == null) 
        {
          String wildname = "*." + method.name + method.signature;
          ref = (NativeRef) allNatives.get (wildname);
        }

        // allow for wildcard as in 'java/lang/SecurityManager.*'
        if (ref == null) 
        {
          String wildname = method.cls.className + ".*";
          ref = (NativeRef) allNatives.get (wildname);
        }

        if (ref != null) 
        {
          Vector deps = new Vector();
          for (Enumeration enum=ref.dependencies.elements();
            enum.hasMoreElements(); )
          {
            String element = (String) enum.nextElement();
            int dotPos = element.indexOf(".");
            int parenPos = element.indexOf("(");

            if (element.startsWith ("new "))
            {
              deps.addElement 
                (new DependencyInfo (Klass.forName (element.substring (4)),
                JavaElement.INSTANCE_NEEDED));
            }
            else if (element.startsWith ("cast "))
            {
              deps.addElement 
                (new DependencyInfo (Klass.forName (element.substring (5)),
                JavaElement.NEEDED + JavaElement.NEEDED_INSTANCEOF));
            }
            else if (element.startsWith ("exact "))
            {
              deps.addElement 
                (new DependencyInfo (Klass.forName (element.substring (6)),
                JavaElement.EXACT_INSTANCE_NEEDED));
            }
            else if (element.startsWith ("empty "))
            {
              if ( optimization > 4 )
                method.setEmpty();
            }
            else if (dotPos < 0)
            {
              deps.addElement (Klass.forName (element));
            }
            else if (parenPos < 0)
            {
              String cln = element.substring (0, dotPos);
              String fln = element.substring (dotPos+1);

              deps.addElement (Klass.forName(cln).findField(fln));
            }
            else
            {
              String cln = element.substring (0, dotPos);
              String mtn = element.substring (dotPos+1, parenPos);
              String mts = element.substring (parenPos);

              deps.addElement (Klass.forName(cln).findMethod(mtn,mts));
            }
          }
          method.makeNative (ref, deps);
        }
      }
    }
  }

  /**
   * update the 'needed' state of all elements
   * that the back-end's implementation depends upon.
   */
  public void updateAll()
  {
    Klass stringClass = Klass.forName("java/lang/String");
    FieldInfo vField = stringClass.findField("value");
    FieldInfo cField = stringClass.findField("count");
    FieldInfo oField = stringClass.findField("offset");
            
    stringClass.markNeeded("AsmBackEnd", JavaElement.INSTANCE_NEEDED);
    if (vField != null) 
      vField.markNeeded("AsmBackEnd", JavaElement.NEEDED);
    if (cField != null)
      cField.markNeeded("AsmBackEnd", JavaElement.NEEDED);
    if (oField != null)
      oField.markNeeded("AsmBackEnd", JavaElement.NEEDED);

    Klass.forName ("[C").
      markNeeded ("AsmBackEnd", JavaElement.INSTANCE_NEEDED);

    try 
    {
      ((NativeRef) allNatives.get ("kernel-routines")).
        markNeeded("kernel", JavaElement.NEEDED);
    }
    catch (NullPointerException e) { }

    boolean[] used = Klass.getAllBytecodesUsed();
    for (int i=0; i<used.length; i++) 
    {
      if (used[i])
      {
        try 
        {
          ((NativeRef) allNatives.get ("op_" + OPCODE_NAMES[i])).
            markNeeded("opcode", JavaElement.NEEDED);
        }
        catch (NullPointerException e) { }
      }
    }

    // multianewarray uses anewarray and newarray
    if (used[op_multianewarray])
    {
      ((NativeRef) allNatives.get ("op_anewarray")).
        markNeeded("op_multianewarray", JavaElement.NEEDED);
      ((NativeRef) allNatives.get ("op_newarray")).
        markNeeded("op_multianewarray", JavaElement.NEEDED);
    }

    for (Enumeration enum=allNatives.elements(); enum.hasMoreElements(); )
    {
      ((NativeRef) enum.nextElement()).updateNeeded();
    }
  }

  /**
   * load all native methods.
   */
  void loadAllNatives ()
  {
    if (allNatives == null) 
    {
      allNatives = new Hashtable();

      // process early-init options
      String earlylist = Jump.projectProps.getProperty("jump-early-init", "") + " " + Jump.projectProps.getProperty("early-init", "");

      if (Jump.codeOptions.verbosity >= 1) 
      {
        System.out.println("Marking for early initialization " + earlylist);
      }

      StringTokenizer stn = new StringTokenizer(earlylist);
      while (stn.hasMoreTokens()) 
      {
        String s = stn.nextToken();
        // avoid dupicates otherwise init will be called more than once
        if ( !earlyClassInit.contains(s) )
          earlyClassInit.add(s);
      }

      // process natives files
      String nativelist = (Jump.projectProps.getProperty ("jump-natives", "") +
        " " + Jump.projectProps.getProperty ("natives", ""));

      if (Jump.codeOptions.verbosity >= 1) 
      {
        System.out.println("Loading natives and opcodes from " + nativelist);
      }

      stn = new StringTokenizer (nativelist);
      Vector natives = new Vector();
      while (stn.hasMoreTokens()) 
      {
        natives.addElement (stn.nextToken());
      }

      for (int i=0; i<natives.size(); i++)
      {
        String file = (String) natives.elementAt(i);

        if (Jump.codeOptions.verbosity >= 1)
        {
          System.out.println("Reading " + file);
        }
        try
        {
          LineNumberReader nf = (new LineNumberReader 
            (new InputStreamReader 
            (Jump.getClasspathStream (file))));
          NativeRef currentRef = null;
          while (true)
          {
            String s = nf.readLine();
            StringTokenizer st;
            Vector tokens;
            int pos;

            if (s == null) 
            {
              break;
            }
            if (s.startsWith (";;")) 
            {
              try 
              {
                st = new StringTokenizer(s);
                tokens = new Vector();
                while (st.hasMoreTokens()) 
                {
                  tokens.addElement(st.nextToken());
                }

                if ((tokens.size() == 2) &&
                  (tokens.elementAt(1).equals("kernel-routines"))) 
                {
                  currentRef = new NativeRef ("kernel-routines", file);
                  allNatives.put ("kernel-routines", currentRef);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("native-method"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef = new NativeRef (sig, file, nf.getLineNumber());
                  allNatives.put (sig, currentRef);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("jvm-opcode"))) 
                {
                  String opcodeName = "op_" + (String) tokens.elementAt(2);
                  currentRef = new NativeRef (opcodeName, file, nf.getLineNumber());
                  allNatives.put (opcodeName, currentRef);
                }
                else if ((tokens.size() == 5) &&
                  (tokens.elementAt(1).equals("uses-class")) &&
                  (tokens.elementAt(3).equals("as"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  String sym = (String) tokens.elementAt(4);
                  currentRef.addDependency (sig, sym);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("uses-class"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef.addDependency (sig, null);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("uses-instance"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef.addDependency ("new " + sig, null);
                }
                else if ((tokens.size() == 5) &&
                  (tokens.elementAt(1).equals("uses-cast-target")) &&
                  (tokens.elementAt(3).equals("as"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  String sym = (String) tokens.elementAt(4);
                  currentRef.addDependency ("cast " + sig, sym);
                }
                else if ((tokens.size() == 5) &&
                  (tokens.elementAt(1).equals("uses-method")) &&
                  (tokens.elementAt(3).equals("as"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  String sym = (String) tokens.elementAt(4);
                  currentRef.addDependency (sig, sym);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("uses-method"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef.addDependency (sig, null);
                }
                else if ((tokens.size() == 5) &&
                  (tokens.elementAt(1).equals("uses-field")) &&
                  (tokens.elementAt(3).equals("as"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  String sym = (String) tokens.elementAt(4);
                  currentRef.addDependency (sig, sym);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("uses-field"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef.addDependency (sig, null);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("needs-exact-layout"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef.addDependency ("exact " + sig, null);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("empty-method"))) 
                {
                  String sig = (String) tokens.elementAt(2);
                  currentRef = new NativeRef (sig, file, nf.getLineNumber());
                  currentRef.addDependency ("empty " + sig, null);
                  allNatives.put (sig, currentRef);
                }
                else if ((tokens.size() == 3) &&
                  (tokens.elementAt(1).equals("early-init"))) 
                {
                  // mark this class as needing an early initialization
                  // avoid dupicates otherwise init will be called more than once
                  String name = (String) tokens.elementAt(2);
                  if ( !earlyClassInit.contains(name) )
                    earlyClassInit.add(name);
                }
              }
              catch (Exception e) 
              {
                throw JumpException.addInfo(e, "syntax error in file " + file + ": " + s);
              }
            }
          }
          nf.close();
        } 
        catch (Exception e) 
        {
          throw JumpException.addInfo(e, "error in file " + file);
        }
      }
    }
  }

  /**
   * copy the contents of an open stream to the assembly output stream.
   */
  void copyStream(InputStream stream, String name)
  {
    try 
    {
      BufferedReader in = new BufferedReader (new InputStreamReader (stream));
      String line;
      
      asmout.println();
      asmout.println(";; --- from file " + name + " ---");
      asmout.println();
      
      while ((line = in.readLine()) != null) 
      {
        asmout.println(line);
      }
      in.close();
    }
    catch (Exception e) 
    {
      throw JumpException.addInfo(e, "error copying stream " + name);
    }
    asmout.println();
  }

  /*
   *             code generation methods
   * ====================================================
   */

  /**
   * generate the code.
   */
  public void generate()
  {
    try 
    {
      assertCompatibility();

      asmout = new PilaWriter (new BufferedWriter
        (new FileWriter (asmoutFilename)));

      if ( useFinalizers )
        useFinalizers = Klass.needsFinalizers();

      if (segmentedCode) 
      {
        layoutSegments();
      }

      generateHeader();
      generateSubroutines();  // moved just before class table

      generatePilotMain();
      generateClinitCode();
      generateJumptableInit();

      generateStatic();

      // System.out.println();
      System.out.print("     method translations: ");

      if (segmentedCode) 
      {
        for (int segno=4; segno<segmentMethods.size(); segno++) 
        {
          Vector methods = (Vector) segmentMethods.elementAt(segno);

          if (methods != null) 
          {
            asmout.println();
            asmout.println(";");
            asmout.println(";========================================");
            asmout.println("; Code segment number " + segno);
            asmout.println(";");
            asmout.println("\tres\t'code', " + segno);
            asmout.println("__segment__" + segno);
            asmout.println("\tdc.w\t" + segno);
            asmout.println();

            // for large methods that take up a whole segment it is better
            // to have the exception handler first to improve addressibility
            if ( optimization > 0 )
            {
              for (int i=registerNames.length; i > 0; i--)
              {
                asmout.println("__segment"+segno+"__exceptions_" + i);
                asmout.println("\tmove.l\t" + (-4-i*4) +"(a6)," + registerNames[i-1]);
              }
              // generate the default exception handler (one per segment)
              asmout.println("__segment"+segno+"__exceptions_0");
              // d2 = initiating address
              // a2 = Throwable instance
              // a0 = classtable entry for Throwable instance
              // a6 = frame pointer of last full-featured stack frame
            
              asmout.println("\t; default exception handler for segment "+segno);
              asmout.println("\t; go up to next frame");
              asmout.println("\tmove.l\t4(a6),d2");
              asmout.println("\tunlk\ta6");
              asmout.println("\tmove.l\t-4(a6),a1");
              asmout.println("\tjmp\t(a1)\t; previous exception handler");
              asmout.println();
            }

            for (int i=0; i<methods.size(); i++) 
            {
              generateMethod((MethodInfo) methods.elementAt(i), segno);
            }

            asmout.println();
            asmout.println(";");
            asmout.println("; End of code segment number " + segno);
            asmout.println(";========================================");
            asmout.println(";");
            asmout.println();
          }
        }
      }
      else 
      {
        asmout.println("\tcode");
        asmout.println();
        for (int i=0; i<Klass.ClassList.size(); i++) 
        {
          Klass cl = (Klass) Klass.ClassList.elementAt(i);
          if (cl.methods != null) 
          {
            for (int j=0; j<cl.methods.length; j++) 
            {
              MethodInfo m = cl.methods[j];
              if (m.isNeeded(JavaElement.NEEDED)) 
              {
                generateMethod (m, 0);
              }
            }
          }
        }
      }
      System.out.print("\r");
      
      generateClassTable();
      generateVtableAll();

      generateJumptable();

      generateConstantStrings();

      //    generateSubroutines();  // moved earlier to minimize distance to class table

      generateResources();

      generateLeadout();
      
      asmout.close();
      
      if ( checkNull && nullChecksAvoidedCount > 0 )
        System.out.println( "     null checks removed: " + nullChecksAvoidedCount + " of " + nullChecksTotalCount );
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "exception in AsmBackEnd.generate()");
    }
  }

  /**
   * write the (more or less constant) header part of the asm file.
   */
  void generateHeader ()
  {
    try 
    {
      Jump.currentElement = null;

      String appName = 
        new String (Jump.projectProps.getProperty ("appname", projectname));

      String projNameExtended = projectname + "XYZZ";

      String appIdDefault = "" +
        Character.toLowerCase(projNameExtended.charAt(0)) +
        Character.toUpperCase(projNameExtended.charAt(1)) +
        Character.toLowerCase(projNameExtended.charAt(2)) +
        Character.toUpperCase(projNameExtended.charAt(3));

      String appId = 
        new String (Jump.projectProps.getProperty ("appid", appIdDefault));

      asmout.println("; Generated from " + projectname + " by Jump " + Jump.JUMP_VERSION);
      String opts = "; " + Jump.codeOptions.toString();
      while ( opts.length() > 79 )
      {
        int pos = opts.substring(0,79).lastIndexOf(',')+1;
        if ( pos <= 0 )
          pos = opts.length();
        asmout.println(opts.substring(0,pos));
        opts = ";              " + opts.substring(pos);
      }
      asmout.println(opts);
      asmout.println();

      if (segmentedCode) 
        asmout.println("#define MULTI_SEGMENT");

      if (dmHeap) 
        asmout.println("#define DM_HEAP");

      if (wabajump) 
        asmout.println("#define WABAJUMP");

      if (useFinalizers) 
        asmout.println("#define FINALIZERS");

      if (debugSymbols) 
        asmout.println("#define DEBUG_SYMBOLS");

      if (!checkStack) 
        asmout.println("#define NO_STACK_CHECK");

      if (useDynamicClinit) 
        asmout.println("#define DYNAMIC_CLINIT");

      Vector defines = Jump.codeOptions.defines;
      if ( defines != null )
      {
        for (int i=0; i<defines.size(); i++)
          asmout.println("#define "+defines.elementAt(i));
      }


      asmout.println();
      asmout.println("\tappl\t\"" + appName + "\",'" + appId + "'");
      asmout.println();
      asmout.println("JumpAppID\tequ\t'" + appId + "'");
      asmout.println();
      if ( usePilotInc )
        asmout.println("\tinclude\t\"pilot.inc\"");
      else
        asmout.println("\tinclude\t\"jump.inc\"");
      asmout.println("\tinclude\t\"startup.inc\"");
      asmout.println();

      // add additional includes specified in property files.
      // we copy rather than use include so that macro processing can be
      // applied in necessary.
      String inclist = Jump.projectProps.getProperty ("jump-includes", "") +
        " " + Jump.projectProps.getProperty ("includes", "");

      StringTokenizer stn = new StringTokenizer(inclist);
      while (stn.hasMoreTokens()) 
      {
        String fileName = stn.nextToken();
        // asmout.println("\tinclude\t\""+fileName+"\"");
        copyStream(Jump.getClasspathStream(fileName), fileName);
      }

      copyStream(Jump.getClasspathStream("define.asm"), "define.asm");
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating header");
    }
  }

  /**
   * write a Jumptable as it is needed for the CodeOptions.LARGE memory model.
   */
  void generateJumptable()
  {
    try 
    {
      Jump.currentElement = null;

      int nSegments = (segmentedCode ? segmentMethods.size()-1 : 1);

      asmout.println("\tdata");
      asmout.println();
      asmout.println("nSegments:\tdc.w\t" + nSegments);
      for (int segno=1; segno<=nSegments; segno++) 
      {
        asmout.println("SegStart" + segno + ":\tdc.l\t0");
      }

      for (int segno=1; segno<=nSegments; segno++) 
      {
        asmout.println("SegHandle" + segno + ":\tdc.l\t0");
      }

      if (segmentedCode) 
      {
        for (int segno=1; segno<=nSegments; segno++) 
        {
          Vector methods = (Vector) segmentMethods.elementAt(segno);
          if (methods != null) 
          {
            int count = 0;
            asmout.println();
            asmout.println("jt" + segno + "start:");
            for (int i=0; i<methods.size(); i++) 
            {
              Object obj = methods.elementAt(i);
              String label;
              boolean valid = true;
              if (obj instanceof MethodInfo) 
              {
                MethodInfo m = (MethodInfo) obj;
                label = m.shortLabel();
                valid = !m.isEmpty();
                if ( optimization >= 5 && valid && m.nativeRef == null && !m.intersegment)
                {
                  // System.out.println( "Rejected "+m );
                  valid = false;
                }
              }
              else 
              {
                label = (String) obj;
              }
              if ( valid )
              {
                String segStart = segno == 1 ? "-__Startup__" : "-__segment__"+segno;
                asmout.println("to_" + label + ":");
                asmout.println("\tdc.w\t$4EF9\t; JMP opcode");
                asmout.println("\tdc.l\t" + label + segStart );
                count++;
              }
            }
            asmout.println("jt" + segno + "count\tequ\t" + count);
            asmout.println();
          }
        }
      }
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating jumptable");
    }
  }

  /**
   * write a Jumptable initialization code needed for CodeOptions.LARGE memory model.
   */
  void generateJumptableInit()
  {
    try 
    {
      Jump.currentElement = null;

      int nSegments = (segmentedCode ? segmentMethods.size()-1 : 1);

      asmout.println("\tcode");
      asmout.println();
      asmout.println("init_jumptable:");
      if (segmentedCode) 
      {
        asmout.println("\tlea.l\tPilotMain(pc),a0");
        asmout.println("\tcmp.l\tto_PilotMain+2(a5),a0");
        asmout.println("\tbeq\tinit_jumptable_out");
        asmout.println();
        for (int segno=1; segno<=nSegments; segno++) 
        {
          asmout.println("\t\t; Adjust code segment " + segno);
          asmout.println("\tsystrap\tDmGetResource(#$636f6465.l,#" + segno + ".w)");
          asmout.println("\tmove.l\ta0,SegHandle" + segno + "(a5)");
          asmout.println("\tsystrap\tMemHandleLock(a0.l)");
          asmout.println("\tmove.l\ta0,d0");
          asmout.println("\tmove.l\ta0,SegStart" + segno + "(a5)");
          if (segmentMethods.elementAt(segno) != null) 
          {
            asmout.println("\tlea.l\tjt" + segno + "start+2(a5),a1");
            asmout.println("\tmove.w\t#jt" + segno + "count-1,d1");
            asmout.println("init_jumptable_loop" + segno + ":");
            asmout.println("\tadd.l\td0,(a1)");
            asmout.println("\taddq.l\t#6,a1");
            asmout.println("\tdbra\td1,init_jumptable_loop" + segno);
            asmout.println();
          }
        }
        asmout.println("init_jumptable_out:");
      }
      else 
      {
        asmout.println("\tlea.l\t__Startup__(pc),a0");
        asmout.println("\tmove.l\ta0,SegStart1(a5)");
      }
      asmout.println("\trts");
      asmout.println();
      asmout.println("cleanup_jumptable:");
      if (segmentedCode) 
      {
        for (int segno=1; segno<=nSegments; segno++) 
        {
            asmout.println("\t\t; Release code segment " + segno);
            asmout.println("\tmove.l\tSegHandle" + segno + "(a5),a0");
            asmout.println("\tsystrap\tMemHandleUnlock(a0.l)");
            asmout.println("\tmove.l\tSegHandle" + segno + "(a5),a0");
            asmout.println("\tsystrap\tDmReleaseResource(a0.l)");
        }
      }
      else 
      {
      }
      asmout.println("\trts");
      asmout.println();
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating jumptable initialization");
    }
  }

  /**
   * write one Itable.
   */
  void generateItable (boolean[] itable)
  {
    int itableBits = 16 * itableWords;

    asmout.println("\t;; Itable");
    for (int i=0; i<itableBits; i+=8) 
    {
      int byteval = 0;
      for (int j=0; j<8; j++) 
      {
        if ((i+j < itable.length) && itable[i+j]) 
        {
          byteval += (1 << j);
        }
      }
      asmout.println( "\tdc.b\t$" + Integer.toHexString(byteval) + "\t; %" + Integer.toBinaryString(byteval) );
    }
  }


  /**
   * write one class table entry to the asm file.
   */
  void generateClassTableEntry (Klass cl)
  {
    try 
    {
      Jump.currentElement = cl;
      MethodInfo m;

      // a comment naming the class
      asmout.println("\t; " + cl);
      if (cl.superclass != null) 
      {
        asmout.println("\t; extends " + cl.superclass.className);
      }

      // the ObjectHeader_ClassIndex for the fake Class object
      asmout.println("\tdc.w\t1\t\t; ObjectHeader_ClassIndex: java/lang/Class");

      // the class-index of the superclass
      if (cl.superclass != null) 
      {
        asmout.println("\tdc.w\t" + cl.superclass.classIndex + 
          "\t; " + cl.superclass.className);
      } 
      else 
      {
        asmout.println("\tdc.w\t-1\t; (no superclass)");
      }

      // the size in bytes of an instance of this class
      asmout.println("\tdc.w\tObjectHeader_sizeof+" + cl.dataSize);

      // the class type:
      // 0=instance, 
      // 1=scalar array, 
      // 2=object array, 
      // 4=primitive type,
      // 8=interface
      // 128=has finalize
      if ((cl.className.startsWith("[L")) || (cl.className.startsWith("[[")))  
        asmout.println("\tdc.b\t0,ClassInfo_arrayofobjects");
      else if (cl.className.startsWith("[")) 
        asmout.println("\tdc.b\t0,ClassInfo_array");
      else if (cl.className.startsWith("-")) 
        asmout.println("\tdc.b\t0,ClassInfo_primitive");
      else 
      {
        // change version 2.0.3 most classes looked primative.
        if (cl.isInterface()) 
          asmout.println("\tdc.b\t0,ClassInfo_interface");
        else if ( cl.getFinalizer() != null )
          asmout.println("\tdc.b\t0,ClassInfo_finalize");
        else 
          asmout.println("\tdc.b\t0,0");
      }

      // the address of the default constructor
      m = cl.getDefaultConstructor();
      if ( m == null || !cl.isNeeded(JavaElement.INSTANCE_NEEDED) )
        asmout.println( "\tdc.w\t0\t; no def constructor" );
      else
        asmout.println( (segmentedCode ? "\tdc.w\tto_" : "\tdc.w\t" )
          + m.shortLabel() + "\t; def constructor");

      // the name of this class
      if ( includeClassNames )
        asmout.println("\tdc.w\tclass" + cl.classIndex + "__name");
      else
        asmout.println("\tdc.w\tclass_unknown__name");

      // the vtable and vtable size for this class
      if (cl.vtable != null) 
      {
        int i;  // PMD 2.1.7 remove leading empty vtable entries
        for (i=0; i<cl.vtable.size(); i++)
        {
          if ( cl.vtable.elementAt(i) != null )
            break;
        }
        asmout.println("\tdc.l\tclass" + cl.classIndex + "__vtable-" + i*2 );
      }
      else 
      {
        asmout.println("\tdc.l\t0\t\t; no vtable");
      }

      // the ArrayStoreException test code
      // (only for array classes of reference types, having instances)
      if ((cl.className.startsWith ("[[") ||
        cl.className.startsWith ("[L")) &&
        cl.isNeeded (JavaElement.INSTANCE_NEEDED)) 
      {
        Klass elClass = Klass.forSignature (cl.className.substring(1));
        int bitnum = elClass.instanceofClassIndex;
        if (bitnum < 0) 
        {
          ASSERT.fail ("'aastore' check code for " + cl + " not prepared!");
        }

        asmout.println("\tbtst\t#" +  bitnum%8 + 
          ",ClassInfo.Itable+" + bitnum/8 + "(a1)");
        asmout.println("\trts");
      }
      else 
      {
        asmout.println("\tdc.w\t0,0,0,0\t\t; no itable index");
      }

      if (cl.itable != null) 
      {
        generateItable (cl.itable);
      }
      else 
      {
        for (int i=0; i<itableWords; i++) 
        {
          asmout.println("\tdc.w\t0" + (i==0 ? "\t\t; no itable" : ""));
        }
      }

      // added version 2.0.3 P.M.Dickerson 10 Dec 2002
      if ( useFinalizers )
      {
        m = cl.getFinalizer();
        if ( m == null || !cl.isNeeded (JavaElement.INSTANCE_NEEDED))
          asmout.println("\tdc.w\t0\t; no finalizer");
        else
          asmout.println( (segmentedCode ? "\tdc.w\tto_" : "\tdc.w\t" )+m.shortLabel()+"\t; finalizer");
      }

      asmout.println();

      // cl.alignment();
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating classtable entry for " + cl);
    }
  }

  /**
   * write the class table to the asm file.
   */
  void generateClassTable ()
  {
    try 
    {
      Jump.currentElement = null;

      if (Klass.instanceofTargetClassList != null) 
      {
        itableWords = (Klass.instanceofTargetClassList.size() + 15) / 16;
      }

      asmout.println("\tcode");
      asmout.println();
      asmout.println("ClassCount\tequ\t" + Klass.targetClassList.size());
      asmout.println("ClassInfo_size\tequ\tClassInfo_basesize+" + 
        (2 * itableWords)+(useFinalizers ? "+2" : ""));
      asmout.println();
      asmout.println("\talign\t2");
      asmout.println("ClassTable:");
      for (int i=0; i<Klass.targetClassList.size(); i++) 
      {
        Klass cl = (Klass) Klass.targetClassList.elementAt(i);
        generateClassTableEntry (cl);
      }
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating classtable");
    }
  }

  /**
   * write the vtable and the classname for this class
   */
  void generateVtable (Klass cl)
  {
    try 
    {
      Jump.currentElement = cl;


      if ( includeClassNames )
      {
        asmout.println("class" + cl.classIndex + 
          "__name\tdc.b\t'" + cl.className.replace('/', '.') + "',0");  // forName fix 2.1.5
      }
      asmout.println("\talign\t2");

      if (cl.vtable != null) 
      {
        // PMD 2.0.3, vtable shorted to 2 bytes per.
        // PMD 2.1.7 remove leading empty vtable entries
        asmout.println("class" + cl.classIndex + "__vtable:");
        String to = segmentedCode ? "to_" : "";
        int i;
        for (i=0; i<cl.vtable.size(); i++)
        {
          if ( cl.vtable.elementAt(i) != null )
            break;
        }
        for (; i<cl.vtable.size(); i++) 
        {
          MethodInfo m = (MethodInfo) cl.vtable.elementAt(i);
          if (m != null) 
          {
            asmout.println("\tdc.w\t" + to + m.shortLabel() + "\t; " + m);
            m.intersegment = segmentedCode;
          }
          else 
          {
            asmout.println("\tdc.w\tto_M_none\t; (unused vtable entry)");
          }
        }
      }
      asmout.println();
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating vtable for " + cl);
    }
  }

  /**
   * write classname and (if needed) vtable for all classes.
   */
  void generateVtableAll ()
  {
    Jump.currentElement = null;

    asmout.println();
    asmout.println("\tcode");
    asmout.println();

    // if not storing class names then all will point to Unkown
    if ( !includeClassNames )
    {
      asmout.println("class_unknown__name\tdc.b\t'Unknown',0");
    }
    
    for (int i=0; i<Klass.targetClassList.size(); i++) 
    {
      Klass cl = (Klass) Klass.targetClassList.elementAt(i);
      generateVtable (cl);
    }
  }

  /**
   * write the section for the static fields.
   */
  void generateStatic ()
  {
    try 
    {
      Jump.currentElement = null;

      // the extra static object is to handle OutOfMemoryError without calling new
      asmout.println("StaticObjectCount\tequ\t" + (Klass.neededObjectFields.size()+1));
      asmout.println();
      asmout.println("\tdata");
      asmout.println();
      asmout.println("StackEnd\tds.l\t1");
      asmout.println("StackLimit\tds.l\t1");
      asmout.println();
      asmout.println("StaticObjects:");
      asmout.println();
    
      // object fields
      asmout.println("\t; static object fields");
      asmout.println("OutOfMemoryError_obj\tds.l\t1\t; for exception handling");
      for (int i=0; i<Klass.neededObjectFields.size(); i++) 
      {
        FieldInfo field = (FieldInfo) Klass.neededObjectFields.elementAt(i);

        asmout.println(field.shortLabel() + "\tds.l\t1\t; " + field);
      }
      asmout.println();

      // scalar one-byte fields
      asmout.println("\t; static scalar one-byte fields");
      for (int i=0; i<Klass.neededScalarFields.size(); i++) 
      {
        FieldInfo field = (FieldInfo) Klass.neededScalarFields.elementAt(i);
        Object val = field.constantValue();

        switch (field.signature.charAt(0)) 
        {
        case 'Z':
        case 'B':
        case 'C':
          if (val == null) 
          {
            asmout.println(field.shortLabel() + "\tds.b\t1\t; " + field);
          }
          else 
          {
            asmout.println(field.shortLabel() + "\tdc.b\t$" +
              Integer.toHexString(((Number) val).intValue()) +
              "\t; " + field);
          }
          break;
        }
      }
      asmout.println();

      // scalar multi-byte fields
      asmout.println("\t; static scalar multi-byte fields");
      asmout.println("\talign\t2");
      for (int i=0; i<Klass.neededScalarFields.size(); i++) 
      {
        FieldInfo field = (FieldInfo) Klass.neededScalarFields.elementAt(i);
        Object val = field.constantValue();

        switch (field.signature.charAt(0)) 
        {
        case 'S':
          if (val == null) 
          {
            asmout.println(field.shortLabel() + "\tds.w\t1\t; " + field);
          }
          else 
          {
            int cInt = ((Number) val).intValue();
            asmout.println(field.shortLabel() + "\tdc.w\t$" +
              Integer.toHexString(cInt & 0xffff) +
              "\t; " + field);
          }
          break;
        case 'I':
          if (val == null) 
          {
            asmout.println(field.shortLabel() + "\tds.l\t1\t; " + field);
          }
          else 
          {
            int cInt = ((Number) val).intValue();
            asmout.println(field.shortLabel() + "\tdc.l\t$" +
              Integer.toHexString(cInt) +
              "\t; " + field);
          }
          break;
        case 'F':
          if (val == null) 
          {
            asmout.println(field.shortLabel() + "\tds.l\t1\t; " + field);
          }
          else 
          {
            int cInt = Float.floatToIntBits(((Float) val).floatValue());
            asmout.println(field.shortLabel() + "\tdc.l\t$" +
              Integer.toHexString(cInt) +
              "\t; " + field);
          }
          break;
        case 'D':
          if (val == null) 
          {
            asmout.println(field.shortLabel() + "\tds.l\t2\t; " + field);
          }
          else 
          {
            long cLong = Double.doubleToLongBits(((Double) val).doubleValue());
            asmout.println(field.shortLabel() + "\tdc.l\t$" +
              Long.toHexString ((cLong >> 32) & 0xffffffffL));
            asmout.println("\tdc.l\t$" +
              Long.toHexString (cLong & 0xffffffffL) +
              "\t; " + field);
          }
          break;
        case 'J':
          if (val == null) 
          {
            asmout.println(field.shortLabel() + "\tds.l\t2\t; " + field);
          }
          else 
          {
            long cLong = ((Long) val).longValue();
            asmout.println(field.shortLabel() + "\tdc.l\t$" +
              Long.toHexString ((cLong >> 32) & 0xffffffffL));
            asmout.println("\tdc.l\t$" +
              Long.toHexString (cLong & 0xffffffffL) +
              "\t; " + field);
          }
          break;
        }
      }
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating static fields");
    }
  }

  /* generate constant string data as concatinated C strings */
  int generateCStrings(String[] strings, int start, int count)
  {
    int totalLength = 0;

    // write the character block
    for (int i=0; i<count; i++) 
    {
      String s = strings[start+i];
      int len = s.length();
      if (len > 0) 
      {
        asmout.print ("\t;; \"" + commentFilter(s) + "\"");
        for (int j=0; j<len; j++) 
        {
          int charCode = (int) s.charAt (j);
          if ((charCode & 0xff00) != 0) 
          {
            charCode = (int) '?';
          }
          if ((j & 15) == 0) 
          {
            asmout.println();
            asmout.print ("\tdc.b\t$" + Integer.toHexString (charCode));
          }
          else 
          {
            asmout.print (",$" + Integer.toHexString (charCode));
          }
        }
        asmout.println(", 0");
      }
      else 
      {
        asmout.println("\t;; empty string");
        asmout.println("\tdc.b\t0");
      }
      asmout.println();
      totalLength += len+1;
    }
    asmout.println("\talign\t2");
    asmout.println();

    if ( totalLength > STRING_POOL_SIZE )
      ASSERT.fail( "more than " +STRING_POOL_SIZE +" bytes of constant string data" );

    return totalLength;
  }

  /**
   * write the constant strings. <p>
   *
   * This is:
   * <ul>
   * <li>One big character block in the code segment,
   *     containing all the constant strings,
   *     always terminated with a Null character.</li>
   * <li>A fake character-array object in the data segment,
   *     pointing to this block.</li>
   * <li>Many fake String objects in the data segment,
   *     pointing (with offset) into the character array.</li>
   * <li>An 'init_constant_strings' routine to set up the pointers.</li>
   * </ul>
   */
  void generateConstantStrings ()
  {
    try 
    {
      Jump.currentElement = null;
      String[] strings = ConstantStrings.getStringArray();
      Klass stringClass = Klass.forName ("java/lang/String");
      int stringClassIndex = stringClass.classIndex;
      FieldInfo[] fields = stringClass.fields;
      FieldInfo vField = stringClass.findField ("value");
      FieldInfo cField = stringClass.findField ("count");
      FieldInfo oField = stringClass.findField ("offset");

      if ( segmentedCode )
      {
        asmout.println();
        asmout.println(";");
        asmout.println(";========================================");
        asmout.println("; Code segment number 2");
        asmout.println(";");
        asmout.println("\tres\t'code',2");
        asmout.println("__segment__2");
        asmout.println("\tdc.w\t2");
        asmout.println();

        int len2 = 0;
        for (int total=strings.length*2+100; len2<strings.length; len2++)
        {
          total += strings[len2].length()+1;
          if ( total > STRING_POOL_SIZE )
            break;
        }
        int len3 = strings.length-len2;
              
        asmout.println("init_constant_strings:");
        asmout.println("\tmove.l\t#CS_SIZE*"+strings.length+",-(a7)");
        asmout.println("\ttrap\t#15");
        asmout.println("\tdc.w\tsysTrapMemPtrNew");
        asmout.println("\taddq.l\t#4,a7");
        asmout.println("\tmove.l\ta0,string_data(a5)");
        asmout.println("\tlea.l\tcstring_block2(pc),a1");
        asmout.println("\tmove.l\ta1,cstring_array_data2(a5)");
        asmout.println("\tmove.l\tSegStart3(a5),a1");
        asmout.println("\tlea.l\tcstring_block3-__segment__3(a1),a1");
        asmout.println("\tmove.l\ta1,cstring_array_data3(a5)");
        asmout.println("\tmovem.l\td2/a3,-(a7)");
        asmout.println("\tlea.l\tcstring_lengths(pc),a1");
        asmout.println("\tlea.l\tICSdata(a5),a2");
        if ( len2>0 )
        {
          asmout.println();
          asmout.println("\tlea.l\tcstring_array2(a5),a3");
          asmout.println("\tmove.w\t#" + (len2-1) + ",d0");
          asmout.println("\tbsr.s\tinit_constant_string_section");
        }
        if ( len3>0 )
        {
          asmout.println();
          asmout.println("\tlea.l\tcstring_array3(a5),a3");
          asmout.println("\tmove.w\t#" + (len3-1) + ",d0");
          asmout.println("\tbsr.s\tinit_constant_string_section");
        }
        asmout.println("\tmovem.l\t(a7)+,d2/a3");
        asmout.println("\trts");
        asmout.println();

        asmout.println("init_constant_string_section");
        // there just might be no string literals
        asmout.println("\tmoveq\t#0,d1");
        asmout.println("\tmoveq\t#0,d2");
        // a0 points to string_object data (C array of String objects)
        // a1 points cstring_lengths
        // a2 points to ICS pointers
        // a3 points to cstring_array(a5)
        // d0 contains count of strings
        // d1 contains computed offset
        // d2 contains current string length 
        asmout.println("init_constant_strings_loop");
        asmout.println("\tmove.w\t#"+stringClassIndex+",(a0)+\t; String class index");
        asmout.println("\tmove.l\ta0,(a2)+");

        boolean odd = false;
        int stringFieldsSize = 0;
        for (int j=0; j<fields.length; j++) 
        {
          FieldInfo f = fields[j];
          if (f.isNeeded() && ((f.access_flags & ACC_STATIC) == 0)) 
          {
            if (odd && f.size > 1) 
            {
              asmout.println("\tclr.b\t(a0)+\t; pad");
              stringFieldsSize++;
              odd = false;
            }
            if (f == vField) 
            {
              asmout.println("\tmove.l\ta3,(a0)+\t; 'value' String field");
            }
            else if (f == oField) 
            {
              asmout.println("\tmove.l\td1,(a0)+\t; 'offset' String field");
            }
            else if (f == cField) 
            {
              asmout.println("\tmove.w\t(a1)+,d2");
              asmout.println("\tmove.l\td2,(a0)+\t; 'count' String field");
            }
            else if (f.size == 1) 
            {
              asmout.println("\tclr.b\t(a0)+\t; '"+f.name+"'");
              odd = !odd;
            }
            else if (f.size == 2) 
            {
              asmout.println("\tclr.w\t(a0)+\t; '"+f.name+"'");
            }
            else if (f.size == 4) 
            {
              asmout.println("\tclr.l\t(a0)+\t; '"+f.name+"'");
            }
            else if (f.size == 8) 
            {
              asmout.println("\tclr.l\t(a0)+\t; '"+f.name+"'");
              asmout.println("\tclr.l\t(a0)+");
            }
            stringFieldsSize += f.size;
          }
        }
        asmout.println("\tadd.w\td2,d1");
        asmout.println("\taddq.w\t#1,d1\t; offset");
        asmout.println("\tdbra\td0,init_constant_strings_loop");
        asmout.println("\trts");
        asmout.println();

        // write string lengths
        asmout.println("cstring_lengths");
        for (int i=0; i<strings.length; i++) 
        {
          asmout.println( "\tdc.w\t"+strings[i].length() );
        }

        asmout.println("cstring_block2");
        int totalLength2 = generateCStrings(strings, 0, len2);

        asmout.println();
        asmout.println(";");
        asmout.println(";========================================");
        asmout.println("; Code segment number 3");
        asmout.println(";");
        asmout.println("\tres\t'code',3");
        asmout.println("__segment__3");
        asmout.println("\tdc.w\t2");
        asmout.println();
      
        asmout.println("cstring_block3");
        int totalLength3 = generateCStrings(strings, len2, len3);

        // write the fake character-array object
        asmout.println("\tdata");
        asmout.println("\tdc.w\t" + Klass.forName("[C").classIndex);
        asmout.println("cstring_array2");
        asmout.println("\tdc.w\t" + totalLength2 + "\t; length");
        asmout.println("\tdc.w\t1\t; elsize");
        asmout.println("cstring_array_data2");
        asmout.println("\tdc.l\t0\t; data");
        asmout.println();
    
        asmout.println("\tdc.w\t" + Klass.forName("[C").classIndex);
        asmout.println("cstring_array3");
        asmout.println("\tdc.w\t" + totalLength3 + "\t; length");
        asmout.println("\tdc.w\t1\t; elsize");
        asmout.println("cstring_array_data3");
        asmout.println("\tdc.l\t0\t; data");
        asmout.println();
    
        asmout.println("ICSdata");

        // write the fake String objects
        int index = 0;
        for (int i=0; i<strings.length; i++) 
        {
          String s = strings[i];
          int len = s.length();
          asmout.println("\t;; \"" + commentFilter(s) + "\"");
          asmout.println("ICS" + ConstantStrings.getIndex(s)+"\tdc.l\t0");

          index += len+1;
        }

        asmout.println("CS_NUM\tequ\t" + strings.length);
        asmout.println("CS_SIZE\tequ\tClassHeader_sizeof+" + stringFieldsSize);
      
        // write the initializer routine
        asmout.println("\tenddata");

      }
      else
      {
        asmout.println();
        asmout.println("\tcode");
        asmout.println();
      
        // PMD 11 Dec 2003, string init moved to start of segment.
        // for version 2.1 constant strings are inited in a loop rather than
        // a stream of individual inits. This is a size win for all but the
        // smallest of apps.
        asmout.println("init_constant_strings:");
        asmout.println("\tlea.l\tcstring_block(pc),a0");
        asmout.println("\tmove.l\ta0,cstring_array_data(a5)");

        // there just might be no string literals
        if ( strings.length != 0 )
        {
          asmout.println("\tlea.l\tcstring_array(a5),a0");
          asmout.println("\tlea.l\tCS0_value(a5),a1");
          asmout.println("\tmove.w\t#" + (strings.length-1) + ",d0");
          asmout.println("init_constant_strings_loop");
          asmout.println("\tmove.l\ta0,(a1)");
          asmout.println("\tlea.l\tCS_SIZE(a1),a1");
          asmout.println("\tdbra\td0,init_constant_strings_loop");
        }

        asmout.println("\trts");
        asmout.println();

        // write the character block
        asmout.println("cstring_block");
        int totalLength = generateCStrings(strings, 0, strings.length);

        // write the fake character-array object
        asmout.println("\tdata");
        asmout.println("\tdc.w\t" + Klass.forName("[C").classIndex);
        asmout.println("cstring_array:");
        asmout.println("\tdc.w\t" + totalLength + "\t; length");
        asmout.println("\tdc.w\t1\t; elsize");
        asmout.println("cstring_array_data:");
        asmout.println("\tdc.l\t0\t; data");
        asmout.println();
    
        if (strings.length == 0) 
        {
          asmout.println("CS0:");
        }

        // write the fake String objects
        int index = 0;
        int stringFieldsSize = 0;

        for (int i=0; i<strings.length; i++) 
        {
          String s = strings[i];
          int len = s.length();
          String label = "CS" + ConstantStrings.getIndex(s);
      
          asmout.println("\t;; \"" + commentFilter(s) + "\"");
          asmout.println("\tdc.w\t" + stringClassIndex);
          asmout.println(label + ":");

          boolean odd = false;
          stringFieldsSize = 0;
          for (int j=0; j<fields.length; j++) 
          {
            FieldInfo f = fields[j];
            if (f.isNeeded() && ((f.access_flags & ACC_STATIC) == 0)) 
            {
              if (odd && f.size > 1) 
              {
                asmout.println("\talign\t2");
                stringFieldsSize++;
                odd = false;
              }
              if (f == vField) 
              {
                asmout.println(label + "_value:");
                asmout.println("\tdc.l\t0\t; 'value' points to cstring_array");
              }
              else if (f == oField) 
              {
                asmout.println("\tdc.l\t" + index + "\t; 'offset' within cstring_array");
              }
              else if (f == cField) 
              {
                asmout.println("\tdc.l\t" + len + "\t; 'count' String length");
              }
              else if (f.size == 1) 
              {
                asmout.println("\tdc.b\t0\t; '" + f.name + "'");
                odd = !odd;
              }
              else if (f.size == 2) 
              {
                asmout.println("\tdc.w\t0\t; '" + f.name + "'");
              }
              else if (f.size == 4) 
              {
                asmout.println("\tdc.l\t0\t; '" + f.name + "'");
              }
              else if (f.size == 8) 
              {
                asmout.println("\tdc.l\t0\t; '" + f.name + "'");
                asmout.println("\tdc.l\t0");
              }
              stringFieldsSize += f.size;
            }
          }
          if (odd) 
          {
            asmout.println("\talign\t2");
          }
          
          asmout.println();

          index += len+1;
        }

        asmout.println("CS_NUM\tequ\t" + strings.length);
        asmout.println("CS_SIZE\tequ\tClassHeader_sizeof+" + stringFieldsSize);
      
        // write the initializer routine
        asmout.println("\tenddata");

        if ( totalLength > STRING_POOL_SIZE )
          ASSERT.fail( "more than " +STRING_POOL_SIZE +" bytes of constant string data" );

      }
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating constant strings");
    }
  }

  /**
   * write PalmOS PilotMain code.
   */
  void generatePilotMain ()
  {
    try 
    {
      Jump.currentElement = null;

      asmout.println();
      asmout.println("\tcode");
      asmout.println();

      asmout.println("PilotMain:");
      asmout.println("cmd     set     8");
      asmout.println("cmdPBP  set     10");
      asmout.println("launchFlags     set     14");
      asmout.println("        link    a6,#-4");
      asmout.println("        lea     catch_Any(pc),a0");
      asmout.println("        move.l  a0,-4(a6)");
      asmout.println("        move.l  a5,-(a7)");

      // safety measure: exit immediately unless normal launch
      asmout.println("        tst.w   cmd(a6)");
      asmout.println("        bne     PilotMain_leave");

      asmout.println("        move.w  launchFlags(a6),d0");
      asmout.println("        and.w   #sysAppLaunchFlagNewGlobals,d0");
      asmout.println("        bne.s   PilotMain_have_globals");
      asmout.println("        systrap MemPtrNew(#DataSize.l)");
      asmout.println("        move.l  a0,a5");
      asmout.println("PilotMain_have_globals:");
      asmout.println("        move.l  a7,StackEnd(a5)");
      asmout.println("        lea.l   -" +
        (stacksize==0 ? 2000 : stacksize) + "(a7),a0");
      asmout.println("        move.l  a0,StackLimit(a5)");
    
      asmout.println("        bsr     init_jumptable");

      if (dmHeap)
        asmout.println("        systrap MemSemaphoreReserve(#1.b)");
      asmout.println("        bsr     initHeap");

      asmout.println("        bsr.far init_constant_strings");

      if (breakpoint) 
      {
        asmout.println("\ttrap #8");
      }

      asmout.println("\tbsr\tall_clinit");

      // startup code dependent on compilation mode
      if (wabajump) 
      {
        Klass cls = Jump.mainClass;
        Klass jcls = Klass.forName("waba/sys/JumpApp");

        // PMD 2.1.8
        if ( useDynamicClinit )
        {
          earlyClassInit.add( jcls.className );
          earlyClassInit.add( cls.className );
        }
        asmout.println("                ;; (new JumpApp(new " + 
          Jump.mainClassName + "())).start()");
        asmout.println("        move.l  #" + jcls.classIndex + ",d0\t; " + jcls);
        asmout.println("        bsr.far op_new");
      
        asmout.println("        move.l  #" + cls.classIndex + ",d0\t; " + cls);
        asmout.println("        bsr.far op_new");

        MethodInfo m = cls.findMethod("<init>","()V");
        m.intersegment = true;
        asmout.println("        bsr.far " + m.shortLabel());
        
        m = jcls.findMethod("<init>","(Lwaba/ui/MainWindow;)V");
        m.intersegment = true;
        asmout.println("        bsr.far " + m.shortLabel());
        asmout.println("        lea     4(a7),a7");

        m = jcls.findMethod("start","()V"); 
        m.intersegment = true;
        asmout.println("        bsr.far " + m.shortLabel());
        asmout.println("        lea     4(a7),a7");
      }
      else 
      {
        asmout.println("        clr.l   d0");
        asmout.println("        move.w  cmd(a6),d0");
        asmout.println("        move.l  d0,-(a7)");
        asmout.println("        move.l  cmdPBP(a6),-(a7)");
        asmout.println("        clr.l   d0");
        asmout.println("        move.w  launchFlags(a6),d0");
        asmout.println("        move.l  d0,-(a7)");
        MethodInfo m = Jump.mainClass.findMethod("PilotMain", "(III)I");
        m.intersegment = true;
        asmout.println("        bsr.far     " + m.shortLabel());
        asmout.println("        lea     12(a7),a7");
      }

      asmout.println("        bsr     clearHeap");

      asmout.println("        bsr     cleanup_jumptable");

      if (dmHeap) 
        asmout.println("        systrap MemSemaphoreRelease(#1.b)");

      asmout.println("        move.w  launchFlags(a6),d0");
      asmout.println("        and.w   #sysAppLaunchFlagNewGlobals,d0");
      asmout.println("        bne.s   PilotMain_had_globals");
      asmout.println("        systrap MemChunkFree(a5.l)");
      asmout.println("PilotMain_had_globals:");

      asmout.println("PilotMain_leave:");
      asmout.println("        move.l  (a7)+,a5");
      asmout.println("        unlk    a6");
      asmout.println("        rts");
      asmout.println();
      asmout.println("        dc.b    $80,9,'PilotMain',0,0,0");
      asmout.println("        align   2");
      asmout.println();
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating PilotMain");
    }
  }

  /** producuce null pointer check code . */
  void generateNullCheck(String source, boolean doit)
  {
    nullChecksTotalCount++;
    if ( checkNull && doit )
    {
      if ( checkNullInline )
      {
        if ( source != null )
          asmout.println( "\tmove.l\t" + source + ",d2" );
        else
          asmout.println("\tcmp.w\t#0,a0");
        asmout.println("\tbne.s\t_nc"+nullChecksTotalCount);    // bne.s pc+4
        asmout.println("\tbsr.far\tthrow_NullPointerException");
        asmout.println("_nc"+nullChecksTotalCount);
      }
      else
      {
        if ( source != null )
          asmout.println( "\tmove.l\t" + source + ",a0" );
        asmout.println("\tbsr.far\tnonnull_check");
      }
    }
    else
    {
      asmout.println("\t\t; removed nonnull_check");
      nullChecksAvoidedCount++;
    }
  }

  /** Disassemble current instruction into listing. */
  String disassemble()
  {
    return "\t\t; " + iterator.opcodeIndex + ": " + iterator.disassemble();
  }

  /** Output vector of speculative asm code and clear.  */
  private void asmCommit( Vector v )
  {
    for (int i=0; i<v.size(); i++)
      asmout.println( (String)v.elementAt(i) );
    v.clear();
  }

  /** genrate address of string constant */
  void generateStringConstant(String s, boolean inD0 )
  {
    int index = ConstantStrings.getIndex(s);
    if ( segmentedCode )
    {
      asmout.println( "\tmove.l\tICS" + index + "(a5),"
        +(inD0 ? "d0" : "-(a7)")
        + "\t; \"" + commentFilter(s) + "\"");
    }
    else if ( inD0 )
    {
        asmout.println( "\tlea\tCS" +index +"(a5),a1\t; \"" + commentFilter(s) + "\"");
        asmout.println( "\tmove.l\ta1,d0" );
    }
    else
      asmout.println( "\tpea\tCS" +index +"(a5)\t; \"" + commentFilter(s) + "\"");
  }

  /** Generate code for some common integer expression cases.
   * left is a string indicating the source address.
   * "#1234", "d0", "8(a6)" etc.
   */
  void basicIntegerExpression(String left)
  {
    CodeIterator iterator = this.iterator;
    int t, cInt=0, slot, oldSlot;

    do
    {
      int mark = iterator.mark;   // record position for backtrack
      iterator.iterate();
      if ( jumpTargets[iterator.mark] || (neededArray != null && !neededArray[iterator.mark]) )
      {
        // backtrack
        iterator.toTarget(mark);
        nextTosInRegister = opHandlesRegister[iterator.nextOpcode];
        asmout.println("\tmove.l\t"+left+ (nextTosInRegister ? ",d0" : ",-(a7)") );
        return;
      }
      oldSlot = localInA0;
      int index = iterator.opcodeIndex;
      int op = iterator.opcode;
      String right = null;
      Vector action = new Vector();
      action.add (disassemble());
      switch (op)
      {
      case op_areturn:
        asmCommit(action);
        if ( left.equals("a0") )
          asmout.println("\t; return in a0 already");
        else
          asmout.println("\tmove.l\t" + left + ",a0\t; return in a0");
        generateMethodEpilogue();
        nextTosInRegister = false;
        needsReturn = iterator.nextIndex < iterator.code.length;
        if ( debugSymbols && needsReturn )
          asmout.println("\tdc.w   0");  // stop SysFatalAlert from tripping up
        return;
      case op_ifnull:
      case op_ifeq:
        asmCommit(action);
        if ( left.equals("a0") )  // should only be able to happen for ifnull
          asmout.println("\tmove.l\ta0,d0");
        else
          asmout.println("\ttst.l\t" + left);
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbeq\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_ifnonnull:
      case op_ifne:
        asmCommit(action);
        if ( left.equals("a0") )  // should only be able to happen for ifnonnull
          asmout.println("\tmove.l\ta0,d0");
        else
          asmout.println("\ttst.l\t" + left);  // TBD PMD: is this needed for D0 ?
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbne\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_iflt:
        asmCommit(action);
        asmout.println("\ttst.l\t" + left);
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tblt\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_ifge:
        asmCommit(action);
        asmout.println("\ttst.l\t" + left);
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbge\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_ifgt:
        asmCommit(action);
        asmout.println("\ttst.l\t" + left);
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbgt\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_ifle:
        asmCommit(action);
        asmout.println("\ttst.l\t" + left);
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tble\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_iconst_m1:
        cInt = -1;
        right = "#"+cInt;
        break;
      case op_iconst_0:
      case op_iconst_1:
      case op_iconst_2:
      case op_iconst_3:
      case op_iconst_4:
      case op_iconst_5:
        cInt = op-op_iconst_0;
        right = "#"+cInt;
        break;
      case op_sipush:
        cInt = iterator.getSignedInteger (0,2);
        right = "#"+cInt;
        break;
      case op_bipush:
        cInt = iterator.getSignedInteger (0,1);
        right = "#"+cInt;
        break;
      case op_ldc:
      case op_ldc_w:
        if (op == op_ldc) 
          t = iterator.getUnsignedInteger (0,1);
        else 
          t = iterator.getUnsignedInteger (0,2);
        String sig = pool.getSignature (t);
        if (sig.equals ("I"))
        {
          cInt = pool.getInteger (t);
          right = "#"+cInt;
        }
        break;
      case op_iload_0:
      case op_iload_1:
      case op_iload_2:
      case op_iload_3:
        right = localNames[op - op_iload_0];
        break;
      case op_aload_0:
      case op_aload_1:
      case op_aload_2:
      case op_aload_3:
      case op_aload:    // this is safe because code is generated only if consumed
        if ( op == op_aload )
          slot = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
        else
          slot = op - op_aload_0;
        right = localNames[slot];
        // test
        if ( iterator.nextOpcode == op_getfield && (slot == localInA0 || left.indexOf("a0")<0) )
        {
          int submark = iterator.mark;
          iterator.iterate();
          t = iterator.getUnsignedInteger (0, 2);
          FieldInfo field = pool.getFieldInfo (t);
          if ( field.signature.charAt(0) == 'I' && !jumpTargets[iterator.mark] )
          {
            action.add( disassemble() );
            if ( slot != localInA0 )
            {
              action.add("\tmove.l\t" + localNames[slot] + ",a0");
              localInA0 = slot;
              // System.out.println("reloaded with slot "+slot);
            }
            if ( checkNull && CodeAnnotation.isNullCheckNeeded(annotations, iterator.opcodeIndex) )
              action.add("\tbsr.far\tnonnull_check");
            else
              action.add("\t\t; removed nonnull_check");
            right = (field.offset == 0 ? "" : Integer.toString(field.offset)) + "(a0)";
          }
          else
            iterator.toTarget(submark);
        }
        break;
      case op_iload:
        t = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
        right = localNames[t];
        break;
      case op_istore_0:
      case op_istore_1:
      case op_istore_2:
      case op_istore_3:
        asmCommit(action);
        asmout.println("\tmove.l\t" + left + ","+localNames[op - op_istore_0]);
        nextTosInRegister = false;
        return;
      case op_astore:
      case op_astore_0:
      case op_astore_1:
      case op_astore_2:
      case op_astore_3:
        if ( op == op_astore )
          t = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
        else
          t = op - op_astore_0;
        asmCommit(action);
        asmout.println("\tmove.l\t" + left + "," + localNames[t]);
        nextTosInRegister = false;
        if ( localInA0 == t )
          localInA0 = -1; // invalidate a0 if same local written
        return;
      case op_istore:
      case op_fstore:
        asmCommit(action);
        t = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
        asmout.println("\tmove.l\t" + left + "," + localNames[t]);
        nextTosInRegister = false;
        return;
      case op_fstore_0:
      case op_fstore_1:
      case op_fstore_2:
      case op_fstore_3:
        asmCommit(action);
        asmout.println("\tmove.l\t" + left + "," + localNames[op - op_fstore_0]);
        nextTosInRegister = false;
        return;
      case op_putfield:
        slot = CodeAnnotation.getLocalSlot(annotations, index);
        t = iterator.getUnsignedInteger (0, 2);
        FieldInfo field = pool.getFieldInfo (t);
        // only optimize move if left and right index from A0 using the same local var or left
        // source is not indexed from A0.
        if ( field.offset >= 0 && (field.signature.charAt(0) == 'I' || field.signature.charAt(0) == 'L') &&
          ( (slot == localInA0 && localInA0 >= 0) || left.indexOf("a0")<0 ) )
        {
          if ( finalizer && field.signature.charAt(0) == 'L' )
          {
            System.out.println("\n--- WARNING --- : object assignment not supported in finalize() methods");
            System.out.println(" for "+field);
          }
          asmCommit(action);
          right = (field.offset == 0 ? "" : Integer.toString(field.offset)) + "(a0)";
          // System.out.println( "Optimized putfield "+left+" -> "+right );
          // asmout.println( "\t; Optimized putfield "+left+" -> "+right );
          if ( optimization >= 5 && CodeAnnotation.dontPush(annotations, index) )
          {
            // Even if the field is not writeable we may still need the address for
            // a potential null pointer exception.
            // If the pointer is never needed then we don't disturb the localInA0
            if ( slot != localInA0 )
              asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
            else
              asmout.println( "\t\t; local var " + slot + " already in a0" );
          }
          else
            asmout.println("\tmove.l\t(a7)+,a0");
          generateNullCheck( null, CodeAnnotation.isNullCheckNeeded(annotations, index) );
          asmout.println("\tmove.l\t"+left+","+right);
          localInA0 = slot;
          nextTosInRegister = false;
          if (TRACE_STORES)
            asmout.println("\tbsr.far\tstore_delay");
          return;
        }
        break;
      }

      iterator.iterate();
      if ( right == null ||
        jumpTargets[iterator.mark] ||
        (neededArray != null && !neededArray[iterator.mark]) )
      {
        // backtrack, abandon action vector
        iterator.toTarget(mark);
        nextTosInRegister = opHandlesRegister[iterator.nextOpcode];
        if ( nextTosInRegister )
        {
          if ( !left.equals("d0") )
            asmout.println("\tmove.l\t"+left+ ",d0" );
        }
        else
          asmout.println("\tmove.l\t"+left+ ",-(a7)" );
        localInA0 = oldSlot;
        return;
      }
      index = iterator.opcodeIndex;
      op = iterator.opcode;
      switch ( op )
      {
      case op_iadd:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tadd.l\t"+right+",d0" );
        nextTosInRegister = true;
        break;
      case op_isub:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tsub.l\t"+right+",d0" );
        nextTosInRegister = true;
        break;
      case op_ixor:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        // eor <ea>,d0 doesn't exist
        // it might be easier to remove it here a use the
        // general case
        if ( right.charAt(0) == '#' )
          asmout.println("\teor.l\t"+right+",d0" );
        else
        {
          asmout.println("\tmove.l\t"+right+",d1" );
          asmout.println("\teor.l\td1,d0" );
        }
        nextTosInRegister = true;
        break;
      case op_iand:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tand.l\t"+right+",d0" );
        nextTosInRegister = true;
        break;
      case op_ior:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tor.l\t"+right+",d0" );
        nextTosInRegister = true;
        break;
      case op_ishr:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        cInt &= 0x1F; // see VM spec
        if ( right.charAt(0) == '#' )
        {
          if ( cInt > 0 && cInt <= 8 )
            asmout.println("\tasr.l\t#"+cInt+",d0" );
          else
          {
            asmout.println("\tmoveq.l\t"+right+",d1" );
            asmout.println("\tasr.l\td1,d0" );
          }
        }
        else
        {
          asmout.println("\tmove.l\t"+right+",d1" );
          asmout.println("\tand.w\t#$1F,d1  ; require by VM spec" );
          asmout.println("\tasr.l\td1,d0" );
        }
        nextTosInRegister = true;
        break;
      case op_iushr:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        cInt &= 0x1F; // see VM spec
        if ( right.charAt(0) == '#' )
        {
          if ( cInt > 0 && cInt <= 8 )
            asmout.println("\tlsr.l\t#"+cInt+",d0" );
          else
          {
            asmout.println("\tmoveq.l\t"+right+",d1" );
            asmout.println("\tlsr.l\td1,d0" );
          }
        }
        else
        {
          asmout.println("\tmove.l\t"+right+",d1" );
          asmout.println("\tand.w\t#$1F,d1  ; require by VM spec" );
          asmout.println("\tlsr.l\td1,d0" );
        }
        nextTosInRegister = true;
        break;
      case op_ishl:
        if ( !left.equals("d0") )
          asmout.println("\tmove.l\t"+left+",d0" );
        asmCommit(action);
        asmout.println(disassemble());
        cInt &= 0x1F; // see VM spec
        if ( right.charAt(0) == '#' )
        {
          if ( cInt > 0 && cInt <= 8 )
            asmout.println("\tasl.l\t#"+cInt+",d0" );
          else
          {
            asmout.println("\tmoveq.l\t"+right+",d1" );
            asmout.println("\tasl.l\td1,d0" );
          }
        }
        else
        {
          asmout.println("\tmove.l\t"+right+",d1" );
          asmout.println("\tand.w\t#$1F,d1  ; require by VM spec" );
          asmout.println("\tasl.l\td1,d0" );
        }
        nextTosInRegister = true;
        break;
      case op_if_icmpeq:
      case op_if_acmpeq:
        if ( right.charAt(0) != '#' && !left.equals("d0") )
        {
          asmout.println("\tmove.l\t"+left+",d0" );
          left = "d0";
        }
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tcmp.l\t"+right+","+left );
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbeq\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_if_icmpne:
      case op_if_acmpne:
        if ( right.charAt(0) != '#' && !left.equals("d0") )
        {
          asmout.println("\tmove.l\t"+left+",d0" );
          left = "d0";
        }
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tcmp.l\t"+right+","+left );
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbne\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_if_icmplt:
        if ( right.charAt(0) != '#' && !left.equals("d0") )
        {
          asmout.println("\tmove.l\t"+left+",d0" );
          left = "d0";
        }
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tcmp.l\t"+right+","+left );
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tblt\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_if_icmpge:
        if ( right.charAt(0) != '#' && !left.equals("d0") )
        {
          asmout.println("\tmove.l\t"+left+",d0" );
          left = "d0";
        }
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tcmp.l\t"+right+","+left );
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbge\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_if_icmpgt:
        if ( right.charAt(0) != '#' && !left.equals("d0") )
        {
          asmout.println("\tmove.l\t"+left+",d0" );
          left = "d0";
        }
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tcmp.l\t"+right+","+left );
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tbgt\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      case op_if_icmple:
        if ( right.charAt(0) != '#' && !left.equals("d0") )
        {
          asmout.println("\tmove.l\t"+left+",d0" );
          left = "d0";
        }
        asmCommit(action);
        asmout.println(disassemble());
        asmout.println("\tcmp.l\t"+right+","+left );
        t = iterator.getSignedInteger (0, 2);
        asmout.println("\tble\t" + label + "__" + (index + t));
        nextTosInRegister = false;
        return;
      default:
        // backtrack two instructions, abandon action vector
        iterator.toTarget(mark);
        nextTosInRegister = opHandlesRegister[iterator.nextOpcode];
        if ( nextTosInRegister )
        {
          if ( !left.equals("d0") )
            asmout.println("\tmove.l\t"+left+ ",d0" );
        }
        else
          asmout.println("\tmove.l\t"+left+ ",-(a7)" );
        localInA0 = oldSlot;
        return;
      }
      left = "d0";
    } while (true);
  }

  /** Generate code for multiply by a small constant etc.
   * left is a string indicating the source address.
   * "#1234" (unlikely), "d0", "8(a6)" etc.
   * returns false if no operation was performed - ie general code needed.
   */
  boolean operationByConst(String left, int n)
  {
    int log2n, t, elsize, mark;
    String sig;
    int currentIndex=0;
    boolean firstTime = true;
    int op = iterator.nextOpcode;
    String loadD0 = left.equals("d0") ? "\t\t; source in register" : "\tmove.l\t"+left+",d0";
    switch (op)
    {
    case op_newarray:
      if ( finalizer )
        System.out.println("\n--- WARNING --- : new array not supported in finalize() methods");
      // we try to condense array initialization 'cos it can take huge amount of code
      asmout.println( "\tmove.l #"+n+",-(a7)" );
      iterator.iterate();
      asmout.println(disassemble());
      elsize = new_array();  // code gives us size
      while ( iterator.nextOpcode == op_dup )
      {
        int index, val=0;
        long lval=0;
        mark = iterator.mark;
        iterator.iterate(); // dup
        String disasmDup = disassemble();
        iterator.iterate(); // const of some sort
        op = iterator.opcode;
        String disasmIndex = disassemble();
        switch (op)
        {
        case op_iconst_0:
        case op_iconst_1:
        case op_iconst_2:
        case op_iconst_3:
        case op_iconst_4:
        case op_iconst_5:
          index = op-op_iconst_0;
          break;
        case op_bipush:
          index = iterator.getSignedInteger(0,1);
          break;
        case op_sipush:
          index = iterator.getSignedInteger(0,2);
          break;
        case op_ldc:
        case op_ldc_w:
          if (op == op_ldc) 
            t = iterator.getUnsignedInteger (0,1);
          else 
            t = iterator.getUnsignedInteger (0,2);
          if ( pool.getSignature(t).equals("I") ) 
            index = pool.getInteger (t);
          else
          {
            // backout
            iterator.toTarget(mark);
            return true;
          }
          break;
        default:
          // backout
          iterator.toTarget(mark);
          return true;
        }
        iterator.iterate();
        String disasmVal = disassemble();
        op = iterator.opcode;
        switch (op)
        {
        case op_iconst_0:
        case op_iconst_1:
        case op_iconst_2:
        case op_iconst_3:
        case op_iconst_4:
        case op_iconst_5:
          val = op-op_iconst_0;
          break;
        case op_bipush:
          val = iterator.getSignedInteger(0,1);
          break;
        case op_sipush:
          val = iterator.getSignedInteger(0,2);
          break;
        case op_ldc:
        case op_ldc_w:
          if (op == op_ldc) 
            t = iterator.getUnsignedInteger (0,1);
          else 
            t = iterator.getUnsignedInteger (0,2);
          sig = pool.getSignature(t);
          if ( sig.equals("I") ) 
            val = pool.getInteger (t);
          else if (sig.equals("F") )
            val = pool.getFloatAsIntBits (t);
          else
          {
            // backout
            iterator.toTarget(mark);
            return true;
          }
          break;
        case op_fconst_0:
          val = 0;            // 0.0F
          break;
        case op_fconst_1:
          val = 0x3f800000;   // 1.0F
          break;
        case op_fconst_2:
          val = 0x40000000;   // 2.0F
          break;
        case op_dconst_0:
          lval = 0L;                  // 0.0D
          break;
        case op_dconst_1:
          lval = 0x3ff0000000000000L;  // 1.0D
          break;
        case op_ldc2_w:
          t = iterator.getUnsignedInteger (0,2);
          sig = pool.getSignature (t);
          if (sig.equals ("J")) 
            lval = pool.getLong (t);
          else if (sig.equals ("D"))
            lval = pool.getDoubleAsLongBits(t);
          else 
          {
            ASSERT.fail ("op_ldc2_w " + t + " not long or double in " + method);
          }
          break;
        default:
          // backout
          iterator.toTarget(mark);
          return true;
        }
        String line1, line2=null;
        iterator.iterate();
        switch (iterator.opcode)
        {
        case op_bastore:
        case op_castore:
          if ( val == 0)
            line1 = "\tclr.b\t(a1)+";
          else
          {
            // if ( val >= 256 || val <= -128 )
            //   System.out.println("\nWarning: character constant truncated to 8-bit value\n         in " +method);
            line1 = "\tmove.b\t#$"+Integer.toHexString(val & 0xFF)+",(a1)+";
          }
          break;
        case op_sastore:
          if ( val == 0)
            line1 = "\tclr.w\t(a1)+";
          else
            line1 = "\tmove.w\t#"+val+",(a1)+";
          break;
        case op_iastore:
        case op_fastore:
          if ( val == 0)
            line1 = "\tclr.l\t(a1)+";
          else
            line1 = "\tmove.l\t#"+val+",(a1)+";
          break;
        case op_lastore:
        case op_dastore:
          if ( (int)(lval>>32) == 0)
            line1 = "\tclr.l\t(a1)+";
          else
            line1 = "\tmove.l\t#$"+Integer.toHexString((int)(lval >> 32))+",(a1)+";
          if ( (int)lval == 0)
            line2 = "\tclr.l\t(a1)+";
          else
            line2 = "\tmove.l\t#$"+Integer.toHexString((int)lval)+",(a1)+";
          break;
        default:
          // backout
          iterator.toTarget(mark);
          return true;
        }

        // is this this the first time, then set up addressing
        if (firstTime)
        {
          firstTime = false;
          asmout.println( "\tmove.l\t(a7),a1" );
          asmout.println( "\tmove.l\tArray.data(a1),a1" );
        }
        if ( currentIndex != index )
        {
          asmout.println( "\tlea\t"+(index-currentIndex)*elsize+"(a1),a1" );
          currentIndex = index;
        }
        asmout.println( disasmDup );
        asmout.println( disasmIndex );
        asmout.println( disasmVal );
        asmout.println( disassemble() );
        asmout.println( line1 );
        if (line2 != null)
          asmout.println( line2 );
        if ( index < 0 || index >= n )
          ASSERT.fail ("array index "+index+" out of bounds ["+n+"] in " + method);
        currentIndex++;
      }
      nextTosInRegister = false;
      return true;
    case op_anewarray:
      if ( finalizer )
        System.out.println("\n--- WARNING --- : new array not supported in finalize() methods");
      // we try to condense string array initialization 'cos it can take huge amount of code
      asmout.println( "\tmove.l #"+n+",-(a7)" );
      iterator.iterate();
      asmout.println(disassemble());
      t = iterator.getUnsignedInteger (0, 2);
      sig = pool.getKlass(t).getSignature();
      Klass acls = Klass.forName ("["+sig);
      asmout.println("\tmove.l\t#" + acls.classIndex + ",d0");
      asmout.println("\tbsr.far\top_anewarray");
      localInA0 = -1;
      nextTosInRegister = false;
      // this optimization is only for String[]
      if ( !sig.equals("Ljava/lang/String;") )
        return true;
      while ( iterator.nextOpcode == op_dup )
      {
        int index, val=0;
        long lval=0;
        mark = iterator.mark;
        iterator.iterate(); // dup
        String disasmDup = disassemble();
        iterator.iterate(); // const of some sort
        op = iterator.opcode;
        String disasmIndex = disassemble();
        switch (op)
        {
        case op_iconst_0:
        case op_iconst_1:
        case op_iconst_2:
        case op_iconst_3:
        case op_iconst_4:
        case op_iconst_5:
          index = op-op_iconst_0;
          break;
        case op_bipush:
          index = iterator.getSignedInteger(0,1);
          break;
        case op_sipush:
          index = iterator.getSignedInteger(0,2);
          break;
        case op_ldc:
        case op_ldc_w:
          if (op == op_ldc) 
            t = iterator.getUnsignedInteger (0,1);
          else 
            t = iterator.getUnsignedInteger (0,2);
          if ( pool.getSignature(t).equals("I") ) 
            index = pool.getInteger (t);
          else
          {
            // backout
            iterator.toTarget(mark);
            return true;
          }
          break;
        default:
          // backout
          iterator.toTarget(mark);
          return true;
        }
        iterator.iterate();
        String disasmVal = disassemble();
        op = iterator.opcode;
        if (op == op_ldc) 
          t = iterator.getUnsignedInteger (0,1);
        else 
          if (op == op_ldc_w) 
          t = iterator.getUnsignedInteger (0,2);
        else
        {
          // backout
          iterator.toTarget(mark);
          return true;
        }
        sig = pool.getSignature(t);
        if (sig.equals ("Ljava/lang/String;")) 
        {
          String cString = pool.getString (t);
          val = ConstantStrings.getIndex(cString);
        }
        else
        {
          // backout
          iterator.toTarget(mark);
          return true;
        }
        iterator.iterate();
        if (iterator.opcode == op_aastore)
        {
          // is this this the first time, then set up addressing
          if (firstTime)
          {
            firstTime = false;
            asmout.println( "\tmove.l\t(a7),a1" );
            asmout.println( "\tmove.l\tArray.data(a1),a1" );
          }
          if ( currentIndex != index )
          {
            asmout.println( "\tlea\t"+(index-currentIndex)*4+"(a1),a1" );
            currentIndex = index;
          }
          asmout.println( disasmDup );
          asmout.println( disasmIndex );
          asmout.println( disasmVal );
          asmout.println( disassemble() );
          if ( segmentedCode )
          {
            asmout.println( "\tmove.l\tICS"+val+"(a5),(a1)+" );
          }
          else
          {
            asmout.println( "\tlea\tCS"+val+"(a5),a0" );
            asmout.println( "\tmove.l\ta0,(a1)+" );
          }
        }
        else
        {
          // backout
          iterator.toTarget(mark);
          return true;
        }

        if ( index < 0 || index >= n )
          ASSERT.fail ("array index "+index+" out of bounds ["+n+"] in " + method);
        currentIndex++;
      }
      return true;
    case op_imul:
      switch ( n )
      {
      case -1:
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tneg.l\td0\t; multiply by "+n);
        break;
      case 0:
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tclr.l\td0\t; multiply by "+n);
        break;
      case 1:
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\t\t; multiply by "+n);
        break;
      case 2:
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tadd.l\td0,d0\t; multiply by "+n);
        break;
      case 3:
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tmove.l\td0,d1");
        asmout.println("\tadd.l\td0,d0");
        asmout.println("\tadd.l\td1,d0\t; multiply by "+n);
        break;
      case 16-2:
      case 32-2:
      case 64-2:
      case 128-2:
      case 256-2:
      case 512-2:
        // 2**n+2 added PMD version 2.0.3
        for (log2n=8; ((1<<log2n) & n) == 0; log2n--)
          ;
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tadd.l\td0,d0");
        asmout.println("\tmove.l\td0,d1");
        asmout.println("\tasl.l\t#"+log2n+",d0");
        asmout.println("\tsub.l\td1,d0\t; multiply by "+n);
        break;
      case 8-1:
      case 16-1:
      case 32-1:
      case 64-1:
      case 128-1:
      case 256-1:
        // 2**n-1
        for (log2n=8; ((1<<log2n) & n) == 0; log2n--)
          ;
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tmove.l\td0,d1");
        asmout.println("\tasl.l\t#"+(log2n+1)+",d0");
        asmout.println("\tsub.l\td1,d0\t; multiply by "+n);
        break;
      case 4:
      case 8:
      case 16:
      case 32:
      case 64:
      case 128:
      case 256:
        // 2**n
        for (log2n=8; ((1<<log2n) & n) == 0; log2n--)
          ;
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tasl.l\t#"+log2n+",d0\t; multiply by "+n);
        break;
      case 4+1:
      case 8+1:
      case 16+1:
      case 32+1:
      case 64+1:
      case 128+1:
      case 256+1:
        // 2**n+1
        for (log2n=8; ((1<<log2n) & n) == 0; log2n--)
          ;
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tmove.l\td0,d1");
        asmout.println("\tasl.l\t#"+log2n+",d0");
        asmout.println("\tadd.l\td1,d0\t; multiply by "+n);
        break;
      case 4+2:
      case 8+2:
      case 16+2:
      case 32+2:
      case 64+2:
      case 128+2:
      case 256+2:
      case 512+2:
        // 2**n+2
        for (log2n=9; ((1<<log2n) & n) == 0; log2n--)
          ;
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tadd.l\td0,d0");
        asmout.println("\tmove.l\td0,d1");
        asmout.println("\tasl.l\t#"+(log2n-1)+",d0");
        asmout.println("\tadd.l\td1,d0\t; multiply by "+n);
        break;
      case 3*4:
      case 3*8:
      case 3*16:
      case 3*32:
      case 3*64:
      case 3*128:
      case 3*256:
        // 2**n+2**(n-1)
        for (log2n=9; ((1<<log2n) & n) == 0; log2n--)
          ;
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tmove.l\td0,d1");
        asmout.println("\tadd.l\td0,d0");
        asmout.println("\tadd.l\td1,d0");
        asmout.println("\tasl.l\t#"+(log2n-1)+",d0\t; multiply by "+n);
        break;
      default:
        return false;
      }
      break;
    case op_idiv:
      //
      if ( n == 1 )
      {
        iterator.iterate();
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\t\t; divide by 1");
      }
      else if ( n > 1 && (n & (n-1)) == 0 ) // n is power of 2
      {
        for (log2n=1; (1<<log2n) != n; log2n++)
          ;
        iterator.iterate();
        String subLabel = method.shortLabel() + "__" + iterator.opcodeIndex + "a";
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tbpl.s\t" + subLabel);
        asmout.println("\tadd" + (n<=8 ? "q" : "") + ".l\t#"+(n-1)+",d0"); // bias negatives
        asmout.println(subLabel + ":");
        while ( log2n > 8 )
        {
          // fix problem in release 2.0 for divide by power of 2 greater than 256
          asmout.println("\tasr.l\t#8,d0\t; divide by "+n);
          log2n -= 8;
        }
        asmout.println("\tasr.l\t#"+log2n+",d0\t; divide by "+n);
      }
      else
        return false;
      break;
      
    case op_irem:
      //
      if ( n > 0 && (n & (n-1)) == 0 ) // n is power of 2
      {
        iterator.iterate();
        String subLabel = method.shortLabel() + "__" + iterator.opcodeIndex;
        asmout.println(disassemble());
        asmout.println(loadD0);
        asmout.println("\tbpl.s\t" + subLabel + "a");
        asmout.println("\tneg.l\td0");
        asmout.println("\tand.l\t#"+(n-1)+",d0\t; when negative");
        asmout.println("\tneg.l\td0");
        asmout.println("\tbra.s\t" + subLabel + "b");
        asmout.println(subLabel + "a:");
        asmout.println("\tand.l\t#"+(n-1)+",d0\t; when positive");
        asmout.println(subLabel + "b:");
      }
      else
        return false;
      break;
      
    case op_ishr:
      iterator.iterate();
      asmout.println(disassemble());
      asmout.println(loadD0);
      n &= 0x1F;  // see VM spec
      while ( n > 8 )
      {
        asmout.println("\tasr.l\t#8,d0" );
        n -= 8;
      }
      if ( n>0 )
        asmout.println("\tasr.l\t#"+n+",d0" );
      break;
    case op_iushr:
      iterator.iterate();
      asmout.println(disassemble());
      asmout.println(loadD0);
      n &= 0x1F;  // see VM spec
      while ( n > 8 )
      {
        asmout.println("\tlsr.l\t#8,d0" );
        n -= 8;
      }
      if ( n>0 )
        asmout.println("\tlsr.l\t#"+n+",d0" );
      break;
    case op_ishl:
      iterator.iterate();
      asmout.println(disassemble());
      asmout.println(loadD0);
      n &= 0x1F;  // see VM spec
      while ( n > 8 )
      {
        asmout.println("\tasl.l\t#8,d0" );
        n -= 8;
      }
      if ( n>0 )
        asmout.println("\tasl.l\t#"+n+",d0" );
      break;
    case op_istore_0:
    case op_istore_1:
    case op_istore_2:
    case op_istore_3:
    case op_istore:
      if ( n >= -128 && n <= 127 && n != 0 )
        return false;   // better off with moveq.l
      iterator.iterate(); // we were still processing constant load
      if ( op == op_istore )
        t = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
      else
        t = op - op_istore_0;
      asmout.println(disassemble());
      if ( n == 0 )
        asmout.println("\tclr.l\t" + localNames[t]);
      else
        asmout.println("\tmove.l\t#" + n + "," + localNames[t]);
      nextTosInRegister = left.equals("d0");  // we haven't changed the tos
      return true;
    case op_fstore_0:
    case op_fstore_1:
    case op_fstore_2:
    case op_fstore_3:
    case op_fstore:
      if ( n >= -128 && n <= 127 && n != 0)
        return false;   // better off with moveq.l
      iterator.iterate(); // we were still processing constant load
      if ( op == op_fstore )
        t = iterator.getUnsignedInteger (0, iterator.wide ? 2 : 1);
      else
        t = op - op_fstore_0;
      asmout.println(disassemble());
      // shorter code for constant 0
      if ( n == 0 )
        asmout.println("\tclr.l\t" + localNames[t]);
      else
        asmout.println("\tmove.l\t#" + n + "," + localNames[t]);
      nextTosInRegister = left.equals("d0");  // we haven't changed the tos
      return true;
    default:
      return false;
    }
    // all the optimizations leave the tos in register
    nextTosInRegister = true;
    return true;
  }

  /** After the current instruction the top-of-stack
   *  will be in a register.
   */
  private boolean nextTosInRegister;

  int new_array()
  {
    int t = iterator.getUnsignedInteger (0, 1);
    String classname = null;
    int elsize = 0;
    switch (t) 
    {
    case  4: classname = "[Z"; elsize = 1; break;
    case  5: classname = "[C"; elsize = 1; break;
    case  6: classname = "[F"; elsize = 4; break;
    case  7: classname = "[D"; elsize = 8; break;
    case  8: classname = "[B"; elsize = 1; break;
    case  9: classname = "[S"; elsize = 2; break;
    case 10: classname = "[I"; elsize = 4; break;
    case 11: classname = "[J"; elsize = 8; break;
    default:
      ASSERT.fail("Internal error: Unknown array type: " + t);
      break;
    }
    Klass cls = Klass.forName (classname);
    asmout.println("\tmove.l\t#" + cls.classIndex + ",d0");
    asmout.println("\tmove.l\t#" + elsize + ",d1");
    asmout.println("\tbsr.far\top_newarray");
    localInA0 = -1;
    return elsize;
  }

  /** Generate code for an array bounds check. */
  void checkArray(boolean isNullCheckNeeded)
  {
    if ( !checkNull )
      isNullCheckNeeded = false;
    if ( checkBounds )
      asmout.println( "\tbsr.far\tarray_check"+(isNullCheckNeeded ? "" : "_safe") );
    else
    {
      generateNullCheck( null, isNullCheckNeeded );
      asmout.println( "\tmove.l\tArray.data(a0),a1" );
    }
  }

  /** generate code to initialize class dynamically */
  boolean generateDynamicClinit(Klass from_cls, Klass target_cls, boolean save_D0)
  {
    // PMD 2.1.8
    if ( target_cls == null )
      return false;

    MethodInfo clinit = target_cls.getEffectiveClinit();

    // not effective init for target class, so do nothing
    if ( clinit == null || clinit.cls.hasEarlyInit || clinit.methodIndex<0 || clinit.isEmpty() )
      return false;

    // if the target class's effective init is in from_class or its
    // hierachy then the target class is bound to have been inited.
    for ( Klass cls = from_cls; cls != null; cls = cls.superclass )
    {
      if ( cls == clinit.cls )
        return false;
    }

    asmout.println("\t; invoke clinit " + clinit);
    if ( save_D0 )
      asmout.println("\tmove.l\td0,-(a7)");
    asmout.println("\tbsr.far\t" + clinit.shortLabel());
    clinit.intersegment = true;
    localInA0 = -1;
    return true;
  }

  String[] localNames;
  int allocatedRegs;
  int parametersInRegs;

  /**
   * Generate code to construct stack frame
   */
  void generateMethodPrologue(MethodInfo m, int segno, int args, int maxLocals, boolean catches)
  {
    int r = 0;
    localNames = new String[maxLocals];

    // assign registers to some locals and parameters
    // this uses a heuristic algorithm based on static instruction counts
    if ( optimization >= 6 )
    {
      int localCost[] = new int[maxLocals];  // notional bytes
      int returns = 0;

      for (r=0; r<args; r++)
        localCost[r] = 4;   // cost of setting up in register

      CodeIterator iterator = this.iterator;
      iterator.toTarget(0);
      do
      {
        int op = iterator.opcode;
        int t;
        switch ( op )
        {
        case op_aload_0:
        case op_aload_1:
        case op_aload_2:
        case op_aload_3:
        case op_aload:
          if ( op == op_aload )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_aload_0;
          localCost[t] -= 2;
          break;
        case op_iload_0:
        case op_iload_1:
        case op_iload_2:
        case op_iload_3:
        case op_iload:
          if ( op == op_iload )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_iload_0;
          localCost[t] -= 2;
          break;
        case op_fload_0:
        case op_fload_1:
        case op_fload_2:
        case op_fload_3:
        case op_fload:
          if ( op == op_fload )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_fload_0;
          localCost[t] -= 2;
          break;
        case op_dload_0:
        case op_dload_1:
        case op_dload_2:
        case op_dload_3:
        case op_dload:
          if ( op == op_dload )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_dload_0;
          localCost[t] -= 2;
          localCost[t+1] -= 2;
          break;
        case op_lload_0:
        case op_lload_1:
        case op_lload_2:
        case op_lload_3:
        case op_lload:
          if ( op == op_lload )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_lload_0;
          localCost[t] -= 2;
          localCost[t+1] -= 2;
          break;
        case op_astore_0:
        case op_astore_1:
        case op_astore_2:
        case op_astore_3:
        case op_astore:
          if ( op == op_astore )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_astore_0;
          localCost[t] -= 2;
          break;
        case op_istore_0:
        case op_istore_1:
        case op_istore_2:
        case op_istore_3:
        case op_istore:
          if ( op == op_istore )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_istore_0;
          localCost[t] -= 2;
          break;
        case op_fstore_0:
        case op_fstore_1:
        case op_fstore_2:
        case op_fstore_3:
        case op_fstore:
          if ( op == op_fstore )
            t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          else
            t = op - op_fstore_0;
          localCost[t] -= 2;
          break;
        case op_iinc:
          t = iterator.getUnsignedInteger(0, iterator.wide ? 2 : 1);
          localCost[t] -= 2*2;  // count twice, probably a loop variable
          break;
        case op_ireturn:
        case op_areturn:
        case op_freturn:
        case op_lreturn:
        case op_dreturn:
        case op_return:
          returns++;
          break;
        }
      } while ( iterator.iterate() );
      iterator.toTarget(0);

      for ( r=0; r < registerNames.length; r++)
      {
        int i = 0, min = 0, j;
        for (j=0; j < maxLocals; j++)
        {
          if ( localCost[j] < min )
          {
            min = localCost[j];
            i = j;
          }
        }
        if ( min > -3-returns )
          break;
        localCost[i] = 0;  // clear so not max for next scan
        localNames[i] = registerNames[r]; //assigne
      }
    }
    allocatedRegs = r;

    asmout.println("\t; args=" + args + ", maxLocals=" + maxLocals);

    // if we are a class init with dynamic support then generate it here
    if ( useDynamicClinit && m.genericName().equals("<clinit>()V") )
    {
      int index = m.cls.clinitClassIndex;
      if ( index >= 0 )
      {
        asmout.println("\t; only invoke clinit once");
        asmout.println("\tbset\t#" + (index & 7) + ",classInitBitmap+"+(index>>3)+"(a5)");
        asmout.println("\tbeq.s\t" + m.shortLabel()+"_clinit_ok");
        asmout.println("\trts");
        asmout.println(m.shortLabel()+"_clinit_ok");
      }

      // PMD 2.1.8
      // output call to next non-empty super.<clinit>
      generateDynamicClinit( null, m.cls.superclass, false );
    }

    // set up stack frame
    asmout.println("\tlink\ta6,#0");
    if ( catches )
      asmout.println("\tpea\t" + label + "__exceptions(pc)");
    else
      asmout.println("\tpea\t__segment" + segno + "__exceptions_" + allocatedRegs + "(pc)");

    // save registers
    if ( allocatedRegs > 1 )
      asmout.println("\tmovem.l\t" + registerNames[0] + "-" + registerNames[allocatedRegs-1] + ",-(a7)" );
    else if ( allocatedRegs != 0 )
      asmout.println("\tmove.l\t" + registerNames[0] + ",-(a7)");

    // fill in any nulls with stack references.
    // generate code to clear locals in regs or copy
    // paameters to regs
    int slot = allocatedRegs;
    parametersInRegs = 0;
    for (int i=0; i<maxLocals; i++)
    {
      if ( localNames[i] == null )
      {
        // assigned names on the stack to other locals
        if ( i < args ) 
          localNames[i] = (args-i+1)*4+"(a6)";
        else
        {
          localNames[i] = (-slot-2)*4+"(a6)";
          slot++;
        }
      }
      else if ( i < args )
      {
        // copy parameter to reg
        asmout.println("\tmove.l\t" + (args-i+1)*4 + "(a6)," + localNames[i] + "\t; arg " + i);
        parametersInRegs++;
      }
      else
      {
        // clear local in reg
        asmout.println("\tclr.l\t" + localNames[i] + "\t; local " + i);
      }
    }

    // clearr locals on stack
    int localonly = maxLocals - args + parametersInRegs - allocatedRegs;
    if (localonly < 6)
    {
      for (int j=0; j<localonly; j++) 
      {
        asmout.println("\tclr.l\t-(a7)");
      }
    }
    else
    {
      if ( localonly <= 128 )
        asmout.println("\tmoveq.l\t#"+(localonly-1)+",d0");
      else
        asmout.println("\tmove.w\t#"+(localonly-1)+",d0");
      asmout.println(label+"__zeroFrame");
      asmout.println("\tclr.l\t-(a7)");
      asmout.println("\tdbra\td0,"+label+"__zeroFrame");
    }
      
    if ( checkStack )
    {
      // check for stack overflow
      asmout.println("\tcmp.l\tStackLimit(a5),a7");
      asmout.println("\tbcc.s\t" + label + "__stackOK");
      asmout.println("\tbsr.far\tthrow_StackOverflowError");
      asmout.println(label + "__stackOK");
    }
  }

  /**
   * Generate code to restore registers
   */
  void generateMethodEpilogue()
  {
    // restore any save temp registers
    if ( allocatedRegs > 1 )
    {
      asmout.println("\tmovem.l\t" + (-4-allocatedRegs*4) + "(a6),"
        + registerNames[0] + "-" + registerNames[allocatedRegs-1]);
    }
    else if ( allocatedRegs != 0 )
      asmout.println("\tmove.l\t-8(a6)," + registerNames[0]);

    asmout.println("\tunlk\ta6");
    asmout.println("\trts");
  }

  /**
   * write a single method.
   */
  void generateMethod (MethodInfo method, int segno)
  {
    // if empty it should never be called. virtuals will go to M_none
    if ( method.isEmpty() )
      return;
      
    try 
    {
      Jump.currentElement = this.method = method;

      CodeAttribute code = method.attributes.code;
      String label = this.label = method.shortLabel();
      Klass myClass = method.cls;
      ConstantPool pool = this.pool = myClass.constant_pool;
      int t, u;

      // method could be referenced as a constructor when using
      // Class.newInstance().
      if ( method.genericName().equals("<init>()V") )   // remove subtest for 2.1.2
        method.intersegment = true;

      if (method.nativeRef != null) 
      {
        NativeRef nr = (NativeRef) method.nativeRef;
      
        asmout.println("; native " + method);
        asmout.println(";-------------------------------------------------");
        asmout.println();
        asmout.println(label + ":");
      
        nr.copyTo (asmout);
      }
      else if ((code != null) && (code.code != null)) 
      {
        boolean staticMethod = (method.access_flags & ACC_STATIC) != 0;
        boolean isClinit = method.genericName().equals("<clinit>()V");
        int args = method.argStackSize() + ( staticMethod ? 0 : 1);
        ASSERT.check(args <= code.max_locals, "Internal error: More args than locals");
        int localonly = code.max_locals - method.argStackSize();
        boolean[] jumpTargets = this.jumpTargets = code.computeJumpTargets();
        finalizer = method.isFinalizer() && useFinalizers;

        asmout.println("; " + method);
        asmout.println(";-------------------------------------------------");
        asmout.println();
        asmout.println(label + ":");

        // The default constructor for classes that might be the target of Class.newInstance()
        // may not have had the static class init run, so make sure it runs.
        // PMD 2.2.2
        if ( useDynamicClinit
          && method.cls.propertySaysHasInstance && method.genericName().equals("<init>()V") )
        {
          generateDynamicClinit( null, method.cls, false );
        }

        // generate bytecode translations
        CodeIterator iterator = new CodeIterator(code.code, pool, method);
        this.iterator = iterator;

        generateMethodPrologue( method, segno, args, code.max_locals,
          segno == 0 || code.exception_table.length>0 || optimization == 0 );

        /*
         * PMD 2.1.7 explicit calls to finalize() do not disable finalize() at GC
         * in Sun VM in spite of wha the docs seem to imply. Marking finalize()
         * as called removed.
         */

        int stackDelta = 0;
        // try to keep track op_aload'ed in reg a0
        boolean tosInRegister = false;  // current top-of-stack in register
        boolean[] neededArray = this.neededArray = code.codeNeeded;
        needsReturn = true;       // cleared if return was swallowed by optimization
        boolean branchToReturn = false;   // set if an internal return replace by branch
        CodeAnnotation[] annotations = optimization<3 ? null : code.computeAnnotations(jumpTargets);
        this.annotations = annotations;
        localInA0 = -1;
        do 
        {
          int op = iterator.opcode;
          int nextOpcode = iterator.nextOpcode;
          int index = iterator.opcodeIndex;
          int next = iterator.nextIndex;
          boolean wide = iterator.wide;
          boolean thisOpHandlesRegister = opHandlesRegister[op];
          boolean nextOpHandlesRegister = opHandlesRegister[nextOpcode] &&
            next < code.code.length && !jumpTargets[next];
          nextTosInRegister = false;
          String foffset;

          // if the current instruction is needed then output
          // a stack adjust for any unneeded instructions up
          // to this point.
          if ((neededArray == null) || neededArray[index]) 
          {
            generateStackAdjust(-stackDelta);
            stackDelta = 0;
            // if the current opcode can't cope with data in
            // register then we had better make sure its on the
            // real stack.
            if ( tosInRegister && !thisOpHandlesRegister ) 
            {
              asmout.println("\tmove.l\td0,-(a7)");
              tosInRegister = false;
            }
          }

          // insert a label for this instruction?
          int tIndex = iterator.mark;
          if (jumpTargets[tIndex]) 
          {
            generateStackAdjust(-stackDelta);
            stackDelta = 0;
            localInA0 = -1;
            // everything should be stacked before a label
            if ( tosInRegister ) 
            {
              asmout.println("\tmove.l\td0,-(a7)");
              tosInRegister = false;
            }
            asmout.println(label + "__" + tIndex + ":");
          }
          asmout.println(disassemble());

          if ((neededArray == null) || neededArray[index]) 
          {
          
            switch (op) 
            {
            case op_nop:
              nextTosInRegister = tosInRegister;
              break;
            case op_iconst_m1:
              // we will check for the specific case multiply by a
              // small constant.
              if ( optimization == 0 || jumpTargets[next] || !operationByConst("(a7)+",-1) )
              {
                asmout.println("\tmove.l\t#-1,d0");
                nextTosInRegister = true;
              }
              break;
            case op_aconst_null:
            case op_fconst_0:
            case op_iconst_0:
              // we will check for the specific case multiply by a
              // small constant.
              if ( optimization == 0 || jumpTargets[next] || !operationByConst("(a7)+",0) )
              {
                asmout.println( "\tclr.l\t" + (nextOpHandlesRegister ? "d0" : "-(a7)") );
                nextTosInRegister = nextOpHandlesRegister;
              }
              break;
            case op_iconst_1:
            case op_iconst_2:
            case op_iconst_3:
            case op_iconst_4:
            case op_iconst_5:
              // we will check for the specific case multiply by a
              // small constant.
              t = op-op_iconst_0;
              if ( optimization == 0 || jumpTargets[next] || !operationByConst("(a7)+",t) )
              {
                if (nextOpHandlesRegister)
                  asmout.println("\tmove.l\t#" + t + ",d0");
                else
                  asmout.println("\tpea\t" + t);
                nextTosInRegister = nextOpHandlesRegister;
              }
              break;
            case op_lconst_0:
              asmout.println("\tclr.l\t-(a7)");
              asmout.println("\tclr.l\t-(a7)");
              break;
            case op_lconst_1:
              asmout.println("\tmove.l\t#1,d0");
              asmout.println("\tmove.l\td0,-(a7)");
              asmout.println("\tclr.l\t-(a7)");
              break;
            case op_fconst_1:
              asmout.println("\tmove.l\t#F_CONST_1,-(a7)");
              break;
            case op_fconst_2:
              asmout.println("\tmove.l\t#F_CONST_2,-(a7)");
              break;
            case op_dconst_0:
              asmout.println("\tclr.l\t-(a7)");
              asmout.println("\tclr.l\t-(a7)");
              break;
            case op_dconst_1:
              asmout.println("\tmove.l\t#D_CONST_1L,-(a7)");
              asmout.println("\tmove.l\t#D_CONST_1H,-(a7)");
              break;
            case op_bipush:
              t = iterator.getSignedInteger (0,1);
              // we will check for the specific case multiply by a
              // small constant etc.
              if ( optimization == 0 || jumpTargets[next] || !operationByConst("(a7)+",t) )
              {
                if (nextOpHandlesRegister)
                  asmout.println("\tmove.l\t#" + t + ",d0");
                else
                  asmout.println("\tpea\t" + t);
                nextTosInRegister = nextOpHandlesRegister;
              }
              break;
            case op_sipush:
              t = iterator.getSignedInteger (0,2);
              // we will check for the specific case multiply by a
              // small constant etc.
              if ( optimization == 0 || jumpTargets[next] || !operationByConst("(a7)+",t) )
              {
                if (t >= -128 && t < 128) 
                {
                  asmout.println("\tmove.l\t#" + t + ",d0");
                  nextTosInRegister = true;
                } 
                else 
                {
                  if (nextOpHandlesRegister)
                    asmout.println("\tmove.l\t#" + t + ",d0");
                  else
                    asmout.println("\tpea\t" + t);
                  nextTosInRegister = nextOpHandlesRegister;
                }
              }
              break;
            case op_ldc:
            case op_ldc_w:
            {
              if (op == op_ldc) 
              {
                t = iterator.getUnsignedInteger (0,1);
              }
              else 
              {
                t = iterator.getUnsignedInteger (0,2);
              }
              nextTosInRegister = nextOpHandlesRegister;
              String sig = pool.getSignature (t);
              if (sig.equals ("Ljava/lang/String;")) 
              {
                String cString = pool.getString (t);
                generateStringConstant(cString,nextOpHandlesRegister);
              }
              else if (sig.equals ("I")) 
              {
                int cInt = pool.getInteger (t);
                // try to do inline of multiply by small constants
                if (  optimization == 0 || jumpTargets[next] || !operationByConst("(a7)+",cInt) )
                  asmout.println("\tmove.l\t#" + cInt + 
                    (nextOpHandlesRegister ? ",d0" : ",-(a7)") );
              }
              else if (sig.equals ("F")) 
              {
                int cInt = pool.getFloatAsIntBits (t);
                asmout.println("\tmove.l\t#$" + 
                  Integer.toHexString (cInt) + 
                  (nextOpHandlesRegister ? ",d0" : ",-(a7)") +
                  "\t; " + pool.getFloat(t));
              }
              else 
              {
                ASSERT.fail ("op_ldc " + t + " not int, float or String in " + method);
              }
              break;
            }
            case op_ldc2_w:
            {
              t = iterator.getUnsignedInteger (0,2);
              String sig = pool.getSignature (t);
              if (sig.equals ("J")) 
              {
                long cLong = pool.getLong (t);
                asmout.println("\tmove.l\t#$" + 
                  Long.toHexString (cLong & 0xffffffffL) + 
                  ",-(a7)");
                asmout.println("\tmove.l\t#$" + 
                  Long.toHexString ((cLong >> 32) & 0xffffffffL) + 
                  ",-(a7)\t; " + pool.getLong(t));
              }
              else if (sig.equals ("D")) 
              {
                long cLong = pool.getDoubleAsLongBits (t);
                asmout.println("\tmove.l\t#$" + 
                  Long.toHexString (cLong & 0xffffffffL) + 
                  ",-(a7)");
                asmout.println("\tmove.l\t#$" + 
                  Long.toHexString ((cLong >> 32) & 0xffffffffL) + 
                  ",-(a7)\t; " + pool.getDouble(t));
              }
              else 
              {
                ASSERT.fail ("op_ldc2_w " + t + " not long or double in " + method);
              }
              break;
            }
            case op_iload:
            case op_fload:
              t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              if ( optimization >= 3 )
                basicIntegerExpression( localNames[t] );
              else
              {
                asmout.println("\tmove.l\t" + localNames[t] +
                  (nextOpHandlesRegister ? ",d0" : ",-(a7)") );
                nextTosInRegister = nextOpHandlesRegister;
              }
              break;
            case op_lload:
            case op_dload:
              t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              asmout.println("\tmove.l\t" + localNames[t] + ",-(a7)");
              asmout.println("\tmove.l\t" + localNames[t+1] + ",-(a7)");
              break;
            case op_iload_0:
            case op_iload_1:
            case op_iload_2:
            case op_iload_3:
              if ( optimization >= 3 )
                basicIntegerExpression( localNames[op - op_iload_0] );
              else
              {
                asmout.println("\tmove.l\t" + 
                  localNames[op - op_iload_0] + 
                  (nextOpHandlesRegister ? ",d0" : ",-(a7)") );
                nextTosInRegister = nextOpHandlesRegister;
              }
              break;
            case op_lload_0:
            case op_lload_1:
            case op_lload_2:
            case op_lload_3:
              asmout.println("\tmove.l\t" + localNames[op - op_lload_0] + ",-(a7)");
              asmout.println("\tmove.l\t" + localNames[op - op_lload_0 + 1] + ",-(a7)");
              break;
            case op_fload_0:
            case op_fload_1:
            case op_fload_2:
            case op_fload_3:
              asmout.println("\tmove.l\t" + localNames[op - op_fload_0] + 
                (nextOpHandlesRegister ? ",d0" : ",-(a7)") );
              nextTosInRegister = nextOpHandlesRegister;
              break;
            case op_dload_0:
            case op_dload_1:
            case op_dload_2:
            case op_dload_3:
              asmout.println("\tmove.l\t" + localNames[op - op_dload_0] + ",-(a7)");
              asmout.println("\tmove.l\t" + localNames[op - op_dload_0 + 1] + ",-(a7)");
              break;
            case op_aload_0:
            case op_aload_1:
            case op_aload_2:
            case op_aload_3:
            case op_aload:
            case op_dup:  
              // PMD 2.1.7 dup treated as an aload_n if local slot is known. this allows
              // any preceeding aload to be marked dontPush.
              // is this dup to be consumed by putfield and putfield doesn't need it?
              if ( optimization >= 5 && CodeAnnotation.dontPush(annotations, index) )
                break;
              if ( op == op_dup )
              {
                t = CodeAnnotation.getLocalSlot(annotations, index);
                if ( t < 0 || optimization < 5 )
                {
                  if ( tosInRegister ) 
                  {
                    asmout.println("\tmove.l\td0,-(a7)");
                    nextTosInRegister = true;
                  }
                  else 
                  {
                    asmout.println("\tmove.l\t(a7)" +
                      (nextOpHandlesRegister ? ",d0" : ",-(a7)") );
                    nextTosInRegister = nextOpHandlesRegister;
                  }
                  break;
                }
                asmout.println("\t\t; dup converted to aload_"+t );
                // System.out.println( "dup converted to aload_"+t );
                if ( tosInRegister ) 
                {
                  asmout.println("\tmove.l\td0,-(a7)");
                  tosInRegister = false;  // falling through to aload which expects this
                }
              }
              else if ( op == op_aload )
                t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              else
                t = op - op_aload_0;
              // we will try to combine the sequences
              //   aload n
              //   getfield ...
              if ( optimization == 0 || nextOpcode != op_getfield || jumpTargets[next] )
              {
                if ( optimization >= 4 && localInA0 == t )
                {
                  basicIntegerExpression( "a0" );
                  /*
                          {
                          // we no this local is cached in A0
                          asmout.println("\tmove.l\ta0" +
                          (nextOpHandlesRegister ? ",d0" : ",-(a7)") +
                          "\t; local var " + t + " already in a0");
                          }
                          */
                }
                else
                {
                  if (optimization >= 3)
                    basicIntegerExpression( localNames[t] );
                  else
                  {
                    // normal handling
                    asmout.println("\tmove.l\t" + localNames[t] + 
                      (nextOpHandlesRegister ? ",d0" : ",-(a7)") );
                    nextTosInRegister = nextOpHandlesRegister;
                  }
                }
                // nextTosInRegister = nextOpHandlesRegister;
              }
              else
              {
                // next is a getfield bytecode so process it
                iterator.iterate(); // next instruction
                index = iterator.opcodeIndex;
                nextOpcode = iterator.nextOpcode;
                nextOpHandlesRegister = opHandlesRegister[nextOpcode];

                // note t is still from aload bytecode
                // skipped onto next instruction so need to disassemble it
                asmout.println(disassemble());
                if ( optimization >= 4 && localInA0 == t )
                  asmout.println( "\t\t; local var " + t + " already in a0" );
                else
                  asmout.println("\tmove.l\t" + localNames[t] + ",a0" );
                localInA0 = t;

                // The 'this' pointer on a non-static method can't be null.
                // So we won't do the stack check it. All this only at a
                // suitable optimization level.
                generateNullCheck( null,
                  (optimization < 2 || t != 0 || staticMethod ) &&
                  CodeAnnotation.isNullCheckNeeded(annotations, index) );
                  
                // t now for getfield bytecode
                t = iterator.getUnsignedInteger (0, 2);
                FieldInfo field = pool.getFieldInfo(t);
                foffset = field.offset == 0 ? "" : Integer.toString(field.offset);
                switch (field.signature.charAt(0)) 
                {
                case 'B':
                case 'Z':
                  if ( nextOpcode == op_ifeq && !jumpTargets[next] )
                  {
                    asmout.println("\ttst.b\t" + foffset + "(a0)");
                    iterator.iterate();
                    asmout.println(disassemble());
                    t = iterator.getSignedInteger (0, 2);
                    asmout.println("\tbeq\t" + label + "__" + (iterator.opcodeIndex + t));
                    nextTosInRegister = false;
                  }
                  else
                  {
                    asmout.println("\tmove.b\t" + foffset + "(a0),d0");
                    asmout.println("\text.w\td0");
                    asmout.println("\text.l\td0");
                    nextTosInRegister = true;
                    if ( optimization >= 3 )
                      basicIntegerExpression("d0");
                  }
                  break;
                case 'C':
                  asmout.println("\tclr.l\td0");
                  asmout.println("\tmove.b\t" + foffset + "(a0),d0");
                  nextTosInRegister = true;
                  if ( optimization >= 3 )
                    basicIntegerExpression("d0");
                  break;
                case 'S':
                  asmout.println("\tmove.w\t" + foffset + "(a0),d0");
                  asmout.println("\text.l\td0");
                  nextTosInRegister = true;
                  if ( optimization >= 3 )
                    basicIntegerExpression("d0");
                  break;
                case 'F':
                case 'I':
                case 'L':
                case '[':
                  if ( optimization >= 3 )
                    basicIntegerExpression(foffset+"(a0)");
                  else
                  {
                    asmout.println("\tmove.l\t" + foffset + 
                      "(a0)," + (nextOpHandlesRegister ? "d0" : "-(a7)") );
                    nextTosInRegister = nextOpHandlesRegister;
                  }
                  break;
                case 'D':
                case 'J':
                  asmout.println("\tmove.l\t" + (field.offset+4) + 
                    "(a0),-(a7)");
                  asmout.println("\tmove.l\t" + foffset + "(a0),-(a7)" );
                  break;
                default:
                  ASSERT.fail("Internal error: Unknown field signature (" + 
                    field + "): " + field.signature);
                  break;
                }
              }
              break;
            case op_iaload:
            case op_faload:
            case op_aaload:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial substripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tasl.l\t#2,d0");
              asmout.println("\tmove.l\t0(a1,d0.l)," + (nextOpHandlesRegister ? "d0" : "-(a7)") );
              nextTosInRegister = nextOpHandlesRegister;
              localInA0 = slot;
            }
              break;
            case op_laload:
            case op_daload:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial substripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tasl.l\t#3,d0");
              asmout.println("\tadd.l\td0,a1");
              asmout.println("\tmove.l\t4(a1),-(a7)");
              asmout.println("\tmove.l\t(a1),-(a7)");
              localInA0 = slot;
            }
              break;
            case op_baload:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial substripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tmove.b\t0(a1,d0.l),d0");
              asmout.println("\text.w\td0");
              asmout.println("\text.l\td0");
              nextTosInRegister = true;
              localInA0 = slot;
              if ( optimization >= 3 )
                basicIntegerExpression( "d0" );
            }
              break;
            case op_caload:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial substripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tadda.l\td0,a1");
              asmout.println("\tclr.l\td0");
              asmout.println("\tmove.b\t(a1),d0");
              nextTosInRegister = true;
              localInA0 = slot;
              if ( optimization >= 3 )
                basicIntegerExpression( "d0" );
            }
              break;
            case op_saload:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" ); // fixed 2.1.1
              // partial substripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tadd.l\td0,d0");
              asmout.println("\tmove.w\t0(a1,d0.l),d0");
              asmout.println("\text.l\td0");
              nextTosInRegister = true;
              localInA0 = slot;
              if ( optimization >= 3 )
                basicIntegerExpression( "d0" );
            }
              break;
            case op_istore:
            case op_fstore:
              t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              asmout.println("\tmove.l\t" + (tosInRegister ? "d0," : "(a7)+,") + localNames[t] );
              break;
            case op_astore_0:
            case op_astore_1:
            case op_astore_2:
            case op_astore_3:
            case op_astore:
              if ( op == op_astore )
                t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              else
                t = op - op_astore_0;
              asmout.println("\tmove.l\t" + (tosInRegister ? "d0," : "(a7)+,") + localNames[t] );
              if ( localInA0 == t )
                localInA0 = -1; // invalidate A0 cache if we write in its local var slot
              break;
            case op_lstore:
            case op_dstore:
              t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              asmout.println("\tmove.l\t(a7)+," + localNames[t+1]);
              asmout.println("\tmove.l\t(a7)+," + localNames[t]);
              break;
            case op_istore_0:
            case op_istore_1:
            case op_istore_2:
            case op_istore_3:
              asmout.println("\tmove.l\t" + (tosInRegister ? "d0," : "(a7)+,") + 
                localNames[op - op_istore_0]);
              break;
            case op_lstore_0:
            case op_lstore_1:
            case op_lstore_2:
            case op_lstore_3:
              asmout.println("\tmove.l\t(a7)+," + localNames[op - op_lstore_0 + 1]);
              asmout.println("\tmove.l\t(a7)+," + localNames[op - op_lstore_0]);
              break;
            case op_fstore_0:
            case op_fstore_1:
            case op_fstore_2:
            case op_fstore_3:
              asmout.println("\tmove.l\t" + (tosInRegister ? "d0," : "(a7)+,") + 
                localNames[op - op_fstore_0]);
              break;
            case op_dstore_0:
            case op_dstore_1:
            case op_dstore_2:
            case op_dstore_3:
              asmout.println("\tmove.l\t(a7)+," + localNames[op - op_dstore_0 + 1]);
              asmout.println("\tmove.l\t(a7)+," + localNames[op - op_dstore_0]);
              break;
    
            case op_iastore:
            case op_fastore:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              asmout.println("\tmove.l\t(a7)+,d2");
              asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial subscripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tasl.l\t#2,d0");
              asmout.println("\tmove.l\td2,0(a1,d0.l)");
              localInA0 = slot;
              if (TRACE_STORES)
                asmout.println("\tbsr.far\tstore_delay");
            }
              break;
            case op_aastore:
              asmout.println("\tbsr.far\taastore_check");
              asmout.println("\tmove.l\t(a7)+,d1");
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tmove.l\t(a7)+,a0");
              asmout.println("\tasl.l\t#2,d0");
              asmout.println("\tmove.l\tArray.data(a0),a1");
              asmout.println("\tmove.l\td1,0(a1,d0.l)");
              localInA0 = -1;
              if (TRACE_STORES)
                asmout.println("\tbsr.far\tstore_delay");
              break;
            case op_lastore:
            case op_dastore:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              asmout.println("\tmove.l\t(a7)+,d2");
              asmout.println("\tmove.l\t(a7)+,d1");
              asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              asmout.println("\tmove.l\td1,-(a7)"); // used by checkArray
              // partial subscripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tasl.l\t#3,d0");
              asmout.println("\tadd.l\td0,a1");
              asmout.println("\tmove.l\td2,(a1)+");
              asmout.println("\tmove.l\t(a7)+,(a1)");
              localInA0 = slot;
              if (TRACE_STORES)
                asmout.println("\tbsr.far\tstore_delay");
            }
              break;
            case op_bastore:
            case op_castore:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              asmout.println("\tmove.l\t(a7)+,d2");
              asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial subscripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tmove.b\td2,0(a1,d0.l)");
              localInA0 = slot;
              if (TRACE_STORES)
                asmout.println("\tbsr.far\tstore_delay");
            }
              break;
            case op_sastore:
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              asmout.println("\tmove.l\t(a7)+,d2");
              asmout.println("\tmove.l\t(a7)+,d0");
              // can we avoid loading?
              if ( optimization < 5 || !CodeAnnotation.dontPush(annotations, index) )
                asmout.println("\tmove.l\t(a7)+,a0");
              else if ( slot != localInA0 )
                asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
              // partial subscripting
              checkArray(CodeAnnotation.isNullCheckNeeded(annotations, index));
              asmout.println("\tasl.l\t#1,d0");
              asmout.println("\tmove.w\td2,0(a1,d0.l)");
              localInA0 = slot;
              if (TRACE_STORES)
                asmout.println("\tbsr.far\tstore_delay");
            }
              break;
            case op_pop:
              if ( !tosInRegister )
                generateStackAdjust(1);
              break;
            case op_pop2:
              generateStackAdjust(2);
              break;
            case op_dup_x1:
              // PMD 2.1.8 improved handling of dup_x1, used in multiple assignment.
              if ( tosInRegister )
              {
                asmout.println("\tmove.l\t(a7),-(a7)");
                asmout.println("\tmove.l\td0,4(a7)");
                nextTosInRegister = true;
              }
              else if ( nextOpHandlesRegister )
              {
                asmout.println("\tmove.l\t(a7)+,d0");
                asmout.println("\tmove.l\t(a7),-(a7)");
                asmout.println("\tmove.l\td0,4(a7)");
                nextTosInRegister = true;
              }
              else
              {
                asmout.println("\tmove.l\t(a7),-(a7)");
                asmout.println("\tmove.l\t8(a7),4(a7)");
                asmout.println("\tmove.l\t(a7),8(a7)");
              }
              break;
            case op_dup_x2:
              asmout.println("\tmove.l\t(a7),-(a7)");
              asmout.println("\tmove.l\t8(a7),4(a7)");
              asmout.println("\tmove.l\t12(a7),8(a7)");
              asmout.println("\tmove.l\t(a7),12(a7)");
              break;
            case op_dup2: 
            {
              asmout.println("\tmove.l\t4(a7),-(a7)");
              asmout.println("\tmove.l\t4(a7),-(a7)");
              break;
            }
            case op_dup2_x1:
              asmout.println("\tmove.l\t4(a7),-(a7)");
              asmout.println("\tmove.l\t4(a7),-(a7)");
              asmout.println("\tmove.l\t16(a7),8(a7)");
              asmout.println("\tmove.l\t(a7),12(a7)");
              asmout.println("\tmove.l\t4(a7),16(a7)");
              break;
            case op_dup2_x2:
              asmout.println("\tmove.l\t4(a7),-(a7)");
              asmout.println("\tmove.l\t4(a7),-(a7)");
              asmout.println("\tmove.l\t16(a7),8(a7)");
              asmout.println("\tmove.l\t20(a7),12(a7)");
              asmout.println("\tmove.l\t(a7),16(a7)");
              asmout.println("\tmove.l\t4(a7),20(a7)");
              break;
            case op_swap:
              asmout.println("\tmove.l\t(a7),d0");
              asmout.println("\tmove.l\t4(a7),(a7)");
              asmout.println("\tmove.l\td0,4(a7)");
              break;
            case op_iadd:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              if ( nextOpHandlesRegister )
              {
                asmout.println("\tadd.l\t(a7)+,d0");
                nextTosInRegister = true;
              }
              else
                asmout.println("\tadd.l\td0,(a7)");
              break;
            case op_ladd:
              asmout.println("\tlea.l\t8(a7),a0");
              asmout.println("\tlea.l\t16(a7),a1");
              asmout.println("\tmove.w\t#$4,ccr");
              asmout.println("\taddx.l\t-(a0),-(a1)");
              asmout.println("\taddx.l\t-(a0),-(a1)");
              asmout.println("\tmove.l\ta1,a7");
              localInA0 = -1;
              break;
            case op_fadd:
              asmout.println("\tbsr.far\top_fadd");
              localInA0 = -1;
              break;
            case op_dadd:
              asmout.println("\tbsr.far\top_dadd");
              localInA0 = -1;
              break;
            case op_isub:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tsub.l\td0,(a7)");
              break;
            case op_lsub:
              asmout.println("\tlea.l\t8(a7),a0");
              asmout.println("\tlea.l\t16(a7),a1");
              asmout.println("\tmove.w\t#$4,ccr");
              asmout.println("\tsubx.l\t-(a0),-(a1)");
              asmout.println("\tsubx.l\t-(a0),-(a1)");
              asmout.println("\tmove.l\ta1,a7");
              localInA0 = -1;
              break;
            case op_fsub:
              asmout.println("\tbsr.far\top_fsub");
              localInA0 = -1;
              break;
            case op_dsub:
              asmout.println("\tbsr.far\top_dsub");
              localInA0 = -1;
              break;
            case op_imul:
              asmout.println("\tbsr.far\top_imul");
              // localInA0 = -1;  // op_imul does not touch A0
              break;
            case op_lmul:
              asmout.println("\tbsr.far\top_lmul");
              localInA0 = -1;
              break;
            case op_fmul:
              asmout.println("\tbsr.far\top_fmul");
              localInA0 = -1;
              break;
            case op_dmul:
              asmout.println("\tbsr.far\top_dmul");
              localInA0 = -1;
              break;
            case op_idiv:
              asmout.println("\tbsr.far\top_idiv");
              // localInA0 = -1; // op_idiv does not touch a0
              break;
            case op_ldiv:
              asmout.println("\tbsr.far\top_ldiv");
              localInA0 = -1;
              break;
            case op_fdiv:
              asmout.println("\tbsr.far\top_fdiv");
              localInA0 = -1;
              break;
            case op_ddiv:
              asmout.println("\tbsr.far\top_ddiv");
              localInA0 = -1;
              break;
            case op_irem:
              asmout.println("\tbsr.far\top_irem");
              localInA0 = -1;
              break;
            case op_lrem:
              asmout.println("\tbsr.far\top_lrem");
              localInA0 = -1;
              break;
            case op_frem:
              asmout.println("\tbsr.far\top_frem");
              localInA0 = -1;
              break;
            case op_drem:
              asmout.println("\tbsr.far\top_drem");
              localInA0 = -1;
              break;
            case op_ineg:
              asmout.println("\tneg.l\t" +
                (tosInRegister ? "d0" : "(a7)") );
              nextTosInRegister = tosInRegister;
              break;
            case op_lneg:
              asmout.println("\tneg.l\t4(a7)");
              asmout.println("\tnegx.l\t(a7)");
              break;
            case op_fneg:
              asmout.println("\tbsr.far\top_fneg");
              localInA0 = -1;
              break;
            case op_dneg:
              asmout.println("\tbsr.far\top_dneg");
              localInA0 = -1;
              break;
            case op_ishl:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tmove.l\t(a7),d1");
              asmout.println("\tand.w\t#$1F,d0  ; require by VM spec" );
              asmout.println("\tlsl.l\td0,d1");
              asmout.println("\tmove.l\td1,(a7)");
              break;
            case op_lshl:
              asmout.println("\tbsr.far\top_lshl");
              localInA0 = -1;
              break;
            case op_ishr:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tmove.l\t(a7),d1");
              asmout.println("\tand.w\t#$1F,d0  ; require by VM spec" );
              asmout.println("\tasr.l\td0,d1");
              asmout.println("\tmove.l\td1,(a7)");
              break;
            case op_lshr:
              asmout.println("\tbsr.far\top_lshr");
              localInA0 = -1;
              break;
            case op_iushr:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tmove.l\t(a7),d1");
              asmout.println("\tand.w\t#$1F,d0  ; require by VM spec" );
              asmout.println("\tlsr.l\td0,d1");
              asmout.println("\tmove.l\td1,(a7)");
              break;
            case op_lushr:
              asmout.println("\tbsr.far\top_lushr");
              localInA0 = -1;
              break;
            case op_iand:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              if ( nextOpHandlesRegister )
              {
                asmout.println("\tand.l\t(a7)+,d0");
                nextTosInRegister = true;
              }
              else
                asmout.println("\tand.l\td0,(a7)");
              break;
            case op_land:
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tand.l\td0,4(a7)");
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tand.l\td0,4(a7)");
              break;
            case op_ior:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              if ( nextOpHandlesRegister )
              {
                asmout.println("\tor.l\t(a7)+,d0");
                nextTosInRegister = true;
              }
              else
                asmout.println("\tor.l\td0,(a7)");
              break;
            case op_lor:
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tor.l\td0,4(a7)");
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tor.l\td0,4(a7)");
              break;
            case op_ixor:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\teor.l\td0,(a7)");
              break;
            case op_lxor:
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\teor.l\td0,4(a7)");
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\teor.l\td0,4(a7)");
              break;

            case op_iinc:
              if (wide) 
              {
                t = iterator.getUnsignedInteger (0, 2);
                u = iterator.getSignedInteger (2, 2);
              } 
              else 
              {
                t = iterator.getUnsignedInteger (0, 1);
                u = iterator.getSignedInteger (1, 1);
              }
              if ( u < 0 ) // PMD 2.1.7
                asmout.println("\tsub.l\t#" + (-u) + "," + localNames[t]);
              else
                asmout.println("\tadd.l\t#" + u + "," + localNames[t]);
              nextTosInRegister = tosInRegister;
              break;
            case op_i2l:
              asmout.println("\ttst.l\t(a7)");
              asmout.println("\tsmi.b\td0");
              asmout.println("\text.w\td0");
              asmout.println("\text.l\td0");
              asmout.println("\tmove.l\td0,-(a7)");
              break;
            case op_i2f:
              asmout.println("\tbsr.far\top_i2f");
              localInA0 = -1;
              break;
            case op_i2d:
              asmout.println("\tbsr.far\top_i2d");
              localInA0 = -1;
              break;
            case op_l2i:
              generateStackAdjust(1);
              break;
            case op_l2f:
              asmout.println("\tbsr.far\top_l2f");
              localInA0 = -1;
              break;
            case op_l2d:
              asmout.println("\tbsr.far\top_l2d");
              localInA0 = -1;
              break;
            case op_f2i:
              asmout.println("\tbsr.far\top_f2i");
              localInA0 = -1;
              break;
            case op_f2l:
              asmout.println("\tbsr.far\top_f2l");
              localInA0 = -1;
              break;
            case op_f2d:
              asmout.println("\tbsr.far\top_f2d");
              localInA0 = -1;
              break;
            case op_d2i:
              asmout.println("\tbsr.far\top_d2i");
              localInA0 = -1;
              break;
            case op_d2l:
              asmout.println("\tbsr.far\top_d2l");
              localInA0 = -1;
              break;
            case op_d2f:
              asmout.println("\tbsr.far\top_d2f");
              localInA0 = -1;
              break;
            case op_i2b:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\text.w\td0");
              asmout.println("\text.l\td0");
              nextTosInRegister = true;
              break;
            case op_i2c:
              asmout.println("\tclr.l\td0");
              asmout.println("\tmove.b\t3(a7),d0");
              asmout.println("\tmove.l\td0,(a7)");
              break;
            case op_i2s:
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\text.l\td0");
              nextTosInRegister = true;
              break;
            case op_lcmp:
              asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tmove.l\t(a7)+,a1");
              asmout.println("\tmove.l\t(a7)+,d2");
              asmout.println("\tmove.l\t(a7)+,d1");
              asmout.println("\tsub.l\ta1,d1");
              asmout.println("\tsubx.l\td0,d2");
              asmout.println("\tsne.b\td0");
              asmout.println("\tblt.s\t" + label + "__" + index + "a");
              asmout.println("\tneg.b\td0");
              asmout.println(label + "__" + index + "a:");
              asmout.println("\text.w\td0");
              asmout.println("\text.l\td0");
              nextTosInRegister = true;
              break;
            case op_fcmpl:
              asmout.println("\tbsr.far\top_fcmpl");
              localInA0 = -1;
              break;
            case op_fcmpg:
              asmout.println("\tbsr.far\top_fcmpg");
              localInA0 = -1;
              break;
            case op_dcmpl:
              asmout.println("\tbsr.far\top_dcmpl");
              localInA0 = -1;
              break;
            case op_dcmpg:
              asmout.println("\tbsr.far\top_dcmpg");
              localInA0 = -1;
              break;
            case op_ifeq:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbeq\t" + label + "__" + (index + t));
              break;
            case op_ifne:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbne\t" + label + "__" + (index + t));
              break;
            case op_iflt:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbmi\t" + label + "__" + (index + t));
              break;
            case op_ifge:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbpl\t" + label + "__" + (index + t));
              break;
            case op_ifgt:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbgt\t" + label + "__" + (index + t));
              break;
            case op_ifle:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tble\t" + label + "__" + (index + t));
              break;
            case op_if_icmpeq:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tbeq\t" + label + "__" + (index + t));
              break;
            case op_if_icmpne:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tbne\t" + label + "__" + (index + t));
              break;
            case op_if_icmplt:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tbgt\t" + label + "__" + (index + t));
              break;
            case op_if_icmpge:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tble\t" + label + "__" + (index + t));
              break;
            case op_if_icmpgt:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tblt\t" + label + "__" + (index + t));
              break;
            case op_if_icmple:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tbge\t" + label + "__" + (index + t));
              break;
            case op_if_acmpeq:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tbeq\t" + label + "__" + (index + t));
              break;
            case op_if_acmpne:
              t = iterator.getSignedInteger (0, 2);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tcmp.l\t(a7)+,d0");
              asmout.println("\tbne\t" + label + "__" + (index + t));
              break;
            case op_goto:
              t = iterator.getSignedInteger (0, 2);
              asmout.println("\tbra\t" + label + "__" + (index + t));
              break;
            case op_jsr:
              t = iterator.getSignedInteger (0, 2);
              asmout.println("\tbsr\t" + label + "__" + (index + t));
              localInA0 = -1;
              break;
            case op_ret:
              t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
              asmout.println("\tmove.l\t" + localNames[t] + ",a1");
              asmout.println("\tjmp\t(a1)");
              break;
            case op_tableswitch: 
            {
              int def = iterator.getSignedInteger (0, 4);
              int low = iterator.getSignedInteger (4, 4);
              int high = iterator.getSignedInteger (8, 4);
              int off, x;
              asmout.println("\tmove.l\t(a7)+,d0");
              for (x=low, off=12; x<=high; x++, off+=4) 
              {
                asmout.println("\tcmp.l\t#" + x + ",d0");
                t = iterator.getSignedInteger (off, 4);
                asmout.println("\tbeq\t" + label + "__" + (index + t));
              }
              asmout.println("\tbra\t" + label + "__" + (index + def));
              break;
            }
            case op_lookupswitch: 
            {
              int def = iterator.getSignedInteger (0, 4);
              int n = iterator.getSignedInteger (4, 4);
              int off, x;
              asmout.println("\tmove.l\t(a7)+,d0");
              for (x=0, off=8; x<n; x++, off+=8) 
              {
                t = iterator.getSignedInteger (off, 4);
                asmout.println("\tcmp.l\t#" + t + ",d0");
                t = iterator.getSignedInteger (off+4, 4);
                asmout.println("\tbeq\t" + label + "__" + (index + t));
              }
              asmout.println("\tbra\t" + label + "__" + (index + def));
              break;
            }
            case op_ireturn:
            case op_freturn:
              if (next < code.code.length) 
              {
                if ( tosInRegister )
                {
                  // return value should be in D0 anyway
                  asmout.println("\t\t; return in register directly");
                  generateMethodEpilogue();
                  if ( debugSymbols )
                    asmout.println("\tdc.w 0");  // stop SysFatalAlert from tripping up
                }
                else
                {
                  branchToReturn = true;
                  asmout.println("\tbra\t" + label + "__out");
                }
              }
              else
                nextTosInRegister = tosInRegister;
              break;
            case op_areturn:
            case op_lreturn:
            case op_dreturn:
              if (next < code.code.length) 
              {
                branchToReturn = true;
                asmout.println("\tbra\t" + label + "__out");
              }
              break;
            case op_return:
              if (next < code.code.length) 
              {
                if ( optimization > 0 )
                {
                  // stack should be empty - void return
                  asmout.println("\t\t; return directly");
                  generateMethodEpilogue();
                  if ( debugSymbols )
                    asmout.println("\tdc.w  0");  // stop SysFatalAlert from tripping up
                }
                else
                {
                  branchToReturn = true;
                  asmout.println("\tbra\t" + label + "__out");
                }
              }
              break;

              // TODO? re-implement constant-value optimization?
              // [ NO: I don't think it's useful with today's compilers ]
              // OOPS! MISTAKE! Compilers don't always detect constant fields,
              // so here's the optimization
            case op_getstatic: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              if (field.constantValue() == null) 
              {
                // PMD 2.1.8
                if (useDynamicClinit && !CodeAnnotation.classInitialized(annotations,index))
                  generateDynamicClinit(method.cls, field.cls, false);
                switch (field.signature.charAt(0)) 
                {
                case 'B':
                case 'Z':
                  asmout.println("\tmove.b\t" + field.shortLabel() + "(a5),d0");
                  if ( (nextOpcode == op_ifeq || nextOpcode == op_ifne) && !jumpTargets[next] )
                  {
                    iterator.iterate();
                    asmout.println(disassemble());
                    t = iterator.getSignedInteger (0, 2);
                    asmout.println( (nextOpcode == op_ifeq ? "\tbeq\t" : "\tbne\t" ) +
                      label + "__" + (iterator.opcodeIndex + t));
                    nextTosInRegister = false;
                  }
                  else
                  {
                    asmout.println("\text.w\td0");
                    asmout.println("\text.l\td0");
                    nextTosInRegister = true;
                    if ( optimization >= 3 )
                      basicIntegerExpression( "d0" );
                  }
                  break;
                case 'C':
                  asmout.println("\tclr.l\td0");
                  asmout.println("\tmove.b\t" + field.shortLabel() + "(a5),d0");
                  nextTosInRegister = true;
                  if ( optimization >= 3 )
                    basicIntegerExpression( "d0" );
                  break;
                case 'S':
                  asmout.println("\tmove.w\t" + field.shortLabel() + "(a5),d0");
                  asmout.println("\text.l\td0");
                  nextTosInRegister = true;
                  if ( optimization >= 3 )
                    basicIntegerExpression( "d0" );
                  break;
                case 'F':
                case 'I':
                case 'L':
                case '[':
                  if ( optimization >= 3 )
                    basicIntegerExpression( field.shortLabel() + "(a5)" );
                  else
                  {
                    asmout.println("\tmove.l\t" + field.shortLabel() + "(a5)," + 
                      (nextOpHandlesRegister ? "d0" : "-(a7)" ) );
                    nextTosInRegister = nextOpHandlesRegister;
                  }
                  break;
                case 'D':
                case 'J':
                  asmout.println("\tmove.l\t" + field.shortLabel() + 
                    "+4(a5),-(a7)");
                  asmout.println("\tmove.l\t" + field.shortLabel() + "(a5),-(a7)");
                  break;
                default:
                  ASSERT.fail("Internal error: Unknown field signature (" + 
                    field + "): " + field.signature);
                  break;
                }
              }
              else 
              {
                // field with a constant value: inline the constant
                Object val = field.constantValue();
                int cInt;
                long cLong;
                String cString;
                asmout.println("\t\t; (constant value)");
                switch (field.signature.charAt(0)) 
                {
                case 'B':
                case 'Z':
                case 'C':
                case 'S':
                case 'I':
                  cInt = ((Integer) val).intValue();
                  if ( optimization >= 3 )
                    basicIntegerExpression( "#" + cInt );
                  else
                  {
                    asmout.println("\tmove.l\t#" + cInt + "," +
                      (nextOpHandlesRegister ? "d0" : "-(a7)"));
                    nextTosInRegister = nextOpHandlesRegister;
                  }
                  break;
                case 'F':
                  cInt = Float.floatToIntBits (((Float) val).floatValue());
                  asmout.println("\tmove.l\t#" + cInt + "," +
                    (nextOpHandlesRegister ? "d0" : "-(a7)") +
                    "\t; " + val);
                  nextTosInRegister = nextOpHandlesRegister;
                  break;
                case 'J':
                  cLong = ((Long) val).longValue();;
                  asmout.println("\tmove.l\t#$" + 
                    Long.toHexString (cLong & 0xffffffffL) + 
                    ",-(a7)");
                  asmout.println("\tmove.l\t#$" + 
                    Long.toHexString ((cLong >> 32) & 0xffffffffL) + 
                    ",-(a7)");
                  nextTosInRegister = false;
                  break;
                case 'D':
                  cLong = Double.doubleToLongBits (((Double) val).doubleValue());
                  asmout.println("\tmove.l\t#$" + 
                    Long.toHexString (cLong & 0xffffffffL) + 
                    ",-(a7)");
                  asmout.println("\tmove.l\t#$" + 
                    Long.toHexString ((cLong >> 32) & 0xffffffffL) + 
                    ",-(a7)\t; " + val);
                  nextTosInRegister = false;
                  break;
                case 'L':
                  if (field.signature.equals ("Ljava/lang/String;")) 
                  {
                    cString = (String) val;
                    generateStringConstant(cString,nextOpHandlesRegister);
                    nextTosInRegister = nextOpHandlesRegister;
                  }
                  else 
                  {
                    ASSERT.fail("Internal error: Illegal constant-field signature (" + 
                      field + "): " + field.signature);
                  }
                  break;
                default:
                  ASSERT.fail("Internal error: Unknown field signature (" + 
                    field + "): " + field.signature);
                  break;
                }
              }
              break;
            }
            case op_putstatic: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              boolean writeable = (field.offset >= 0);
              // PMD 2.1.8
              if ( useDynamicClinit &&
                !CodeAnnotation.classInitialized(annotations,index) &&
                generateDynamicClinit(method.cls, field.cls, tosInRegister) )
              {
                tosInRegister = false;
              }
              switch (field.signature.charAt(0)) 
              {
              case 'B':
              case 'C':
              case 'Z':
                if ( !tosInRegister )
                  asmout.println("\tmove.l\t(a7)+,d0");
                if (writeable) 
                {
                  asmout.println("\tmove.b\td0," + field.shortLabel() + "(a5)");
                }
                break;
              case 'S':
                if ( !tosInRegister )
                  asmout.println("\tmove.l\t(a7)+,d0");
                if (writeable) 
                {
                  asmout.println("\tmove.w\td0," + field.shortLabel() + "(a5)");
                }
                break;
              case 'F':
              case 'I':
                if (writeable) 
                {
                  asmout.println("\tmove.l\t" +
                    (tosInRegister ? "d0," : "(a7)+," ) +
                    field.shortLabel() + "(a5)");
                }
                else if ( !tosInRegister ) 
                  asmout.println("\taddq.l\t#4,a7");
                break;
              case 'L':
              case '[':
                if ( finalizer )
                {
                  System.out.println("\n--- WARNING --- : static object assignment not supported in finalize() methods");
                  System.out.println(" for "+field);
                }
                if (writeable) 
                {
                  asmout.println("\tmove.l\t" + (tosInRegister ? "d0," : "(a7)+," ) +
                    field.shortLabel() + "(a5)");
                }
                else if ( !tosInRegister ) 
                  asmout.println("\taddq.l\t#4,a7");
                break;
              case 'D':
              case 'J':
                if ( tosInRegister )
                  ASSERT.fail("Internal error: value not on stack in "+method);
                if (writeable) 
                {
                  asmout.println("\tmove.l\t(a7)+," + field.shortLabel() + 
                    "(a5)");
                  asmout.println("\tmove.l\t(a7)+," + field.shortLabel() + "+4(a5)");
                }
                else 
                {
                  asmout.println("\taddq.l\t#8,a7");
                }
                break;
              default:
                ASSERT.fail("Internal error: Unknown field signature (" + 
                  field + "): " + field.signature);
                break;
              }
              break;
            }
            case op_getfield: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              foffset = field.offset == 0 ? "" : Integer.toString(field.offset);
              if ( tosInRegister )
                asmout.println("\tmove.l\td0,a0");
              else
                asmout.println("\tmove.l\t(a7)+,a0");
              localInA0 = CodeAnnotation.getLocalSlot(annotations, index);
              // The 'this' pointer on a non-static method can't be null.
              // So we won't do the stack check it. All this only at a
              // suitable optimization level.
              // probably needs a check always since the simple case
              // is dealt with by aload + getfield
              generateNullCheck( null, CodeAnnotation.isNullCheckNeeded(annotations, index) );
              switch (field.signature.charAt(0)) 
              {
              case 'B':
              case 'Z':
                asmout.println("\tmove.b\t" + foffset + "(a0),d0");
                if ( (nextOpcode == op_ifeq || nextOpcode == op_ifne) && !jumpTargets[next] )
                {
                  iterator.iterate();
                  asmout.println(disassemble());
                  t = iterator.getSignedInteger (0, 2);
                  asmout.println( (nextOpcode == op_ifeq ? "\tbeq\t" : "\tbne\t" ) +
                    label + "__" + (iterator.opcodeIndex + t));
                  nextTosInRegister = false;
                }
                else
                {
                  asmout.println("\text.w\td0");
                  asmout.println("\text.l\td0");
                  nextTosInRegister = true;
                  if ( optimization >= 3 )
                    basicIntegerExpression( "d0" );
                }
                break;
              case 'C':
                asmout.println("\tclr.l\td0");
                asmout.println("\tmove.b\t" + foffset + "(a0),d0");
                nextTosInRegister = true;
                if ( optimization >= 3 )
                  basicIntegerExpression( "d0" );
                break;
              case 'S':
                asmout.println("\tmove.w\t" + foffset + "(a0),d0");
                asmout.println("\text.l\td0");
                nextTosInRegister = true;
                if ( optimization >= 3 )
                  basicIntegerExpression( "d0" );
                break;
              case 'F':
              case 'I':
              case 'L':
              case '[':
                asmout.println("\tmove.l\t" + foffset + 
                  "(a0)," +
                  (nextOpHandlesRegister ? "d0" : "-(a7)"));
                nextTosInRegister = nextOpHandlesRegister;
                break;
              case 'D':
              case 'J':
                asmout.println("\tmove.l\t" + (field.offset+4) + "(a0),-(a7)");
                asmout.println("\tmove.l\t" + foffset + "(a0),-(a7)");
                break;
              default:
                ASSERT.fail("Internal error: Unknown field signature (" + 
                  field + "): " + field.signature);
                break;
              }
              break;
            }
            case op_putfield: 
            {
              int slot = CodeAnnotation.getLocalSlot(annotations, index);
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              foffset = field.offset == 0 ? "" : Integer.toString(field.offset);
              boolean writeable = (field.offset >= 0);
              if ( !tosInRegister )
                asmout.println("\tmove.l\t(a7)+,d0");
              // for doubles and long the data takes two registers
              if ( field.signature.charAt(0) == 'D' || field.signature.charAt(0) == 'J' )
                asmout.println("\tmove.l\t(a7)+,d1");
              // if we haven't pushed the address we shouldn't pop it
              if ( optimization >= 5 && CodeAnnotation.dontPush(annotations, index) )
              {
                // Even if the field is not writeable we may still need the address for
                // a potential null pointer exception.
                // If the pointer is never needed then we don't disturb the localInA0
                if ( slot != localInA0 )
                {
                  if (CodeAnnotation.isNullCheckNeeded(annotations, index) || writeable )
                  {
                    asmout.println("\tmove.l\t" + localNames[slot] + ",a0" );
                    localInA0 = slot;
                  }
                  else
                    asmout.println( "\t\t; local var " + slot + " not needed here" );
                }
                else
                  asmout.println( "\t\t; local var " + slot + " already in a0" );
              }
              else
              {
                // writeable or not, we must pop the address
                asmout.println("\tmove.l\t(a7)+,a0");
                localInA0 = slot;
              }
              generateNullCheck( null, CodeAnnotation.isNullCheckNeeded(annotations, index) );
              if (writeable)
              {
                switch (field.signature.charAt(0)) 
                {
                case 'B':
                case 'C':
                case 'Z':
                  asmout.println("\tmove.b\td0," + foffset + "(a0)");
                  break;
                case 'S':
                  asmout.println("\tmove.w\td0," + foffset + "(a0)");
                  break;
                case 'F':
                case 'I':
                  asmout.println("\tmove.l\td0," + foffset + "(a0)");
                  break;
                case 'L':
                case '[':
                  if ( finalizer )
                  {
                    System.out.println("\n--- WARNING --- : object assignment not supported in finalize() methods");
                    System.out.println(" for "+field);
                  }
                  asmout.println("\tmove.l\td0," + foffset + "(a0)");
                  break;
                case 'D':
                case 'J':
                  asmout.println("\tmove.l\td0," + foffset + 
                    "(a0)");
                  asmout.println("\tmove.l\td1," + (field.offset + 4) + "(a0)");
                  break;
                default:
                  ASSERT.fail("Internal error: Unknown field signature (" + 
                    field + "): " + field.signature);
                  break;
                }
                if (TRACE_STORES)
                  asmout.println("\tbsr.far\tstore_delay");
              }
              else
                asmout.println("\t\t; field not written");
            }
              break;
            case op_invokevirtual: 
            case op_invokeinterface:
            {
              t = iterator.getUnsignedInteger (0, 2);
              MethodInfo mm = pool.getMethodInfo (t);
              if ( finalizer )
              {
                System.out.println("\n--- WARNING --- : invoke virtual/interface not supported in finalize() methods");
                System.out.println(" for "+mm);
              }
              int argStackSize = mm.argStackSize();
              String ret = mm.returnType();
              MethodInfo mmEff = mm.getEffectiveMethod();
              localInA0 = -1;
              if (mmEff != null) 
              {
                FieldInfo f = optimization > 5 ? mmEff.getGetterField() : null;
                if ( checkNull && CodeAnnotation.isNullCheckNeeded(annotations, index) )
                {
                  if ( argStackSize > 0 )
                    generateNullCheck( (4 * argStackSize) + "(a7)", true );
                  else if ( f != null )
                  {
                    asmout.println("\tmove.l\t(a7)+,a0");
                    generateNullCheck( null, true );
                  }
                  else
                    generateNullCheck( "(a7)", true );
                }
                else
                {
                  if ( f != null )
                    asmout.println("\tmove.l\t(a7)+,a0");
                  generateNullCheck( null, false );
                }
                if ( f != null )
                {
                  asmout.println( "\t\t; inlined getfield "+f );
                  // added for 2.0.3
                  String faddr = f.offset == 0 ? "(a0)" : f.offset+"(a0)";
                  switch ( f.signature.charAt(0) )
                  {
                  case 'Z':
                  case 'B':
                    // System.out.println("signed byte getter for "+f);
                    asmout.println("\tmove.b\t"+faddr+",d0");
                    asmout.println("\text.w\td0");
                    asmout.println("\text.l\td0");
                    nextTosInRegister = true;
                    basicIntegerExpression( "d0" );
                    break;
                  case 'C':
                    // System.out.println("unsigned byte getter for "+f);
                    asmout.println("\tclr.l\td0");
                    asmout.println("\tmove.b\t"+faddr+",d0");
                    nextTosInRegister = true;
                    basicIntegerExpression( "d0" );
                    break;
                  case 'S':
                    // System.out.println("short getter for "+f);
                    asmout.println("\tmove.w\t"+faddr+",d0");
                    asmout.println("\text.l\td0");
                    nextTosInRegister = true;
                    basicIntegerExpression( "d0" );
                    break;
                  case 'I':
                  case 'F':
                    // System.out.println("32-bit getter for "+f);
                    basicIntegerExpression( faddr );
                    break;
                  case 'L':
                  case '[':
                    // System.out.println("Object getter for "+f);
                    basicIntegerExpression( faddr );
                    break;
                  default:
                    ASSERT.fail ("unhandled type inlined " + f.signature + " at " + f);
                    break;
                  }
                  break;
                }
                if ( mmEff.isEmpty() )
                  asmout.println("\t\t; removed empty call to " + mmEff );
                else if ( !segmentedCode || (mmEff.segno == segno && optimization >= 6) )
                  asmout.println("\tbsr\t" + mmEff.shortLabel() + "\t; (direct)" + mmEff);
                else
                {
                  asmout.println("\tjsr\tto_" + mmEff.shortLabel() + "(a5)\t; " + mmEff);
                  mmEff.intersegment = true;
                }
              }
              else if (segmentedCode) 
              {
                // changed version 2.0.3, vtable shorted to 2 bytes per.
                // a0 = instance
                if ( argStackSize > 0 )
                  asmout.println("\tmove.l\t" + (4 * argStackSize) + "(a7),a0");
                else
                  asmout.println("\tmove.l\t(a7),a0");
                generateNullCheck( null, CodeAnnotation.isNullCheckNeeded(annotations, index) );
                // don't generate code for case where there is no instance - must have warned
                if ( true )
                {
                  // a0 = ClassInfo structure
                  asmout.println("\tbsr.far\tgetclassinfo_a0");
                  // a0 = vtable relative address
                  asmout.println("\tmove.l\tClassInfo.Vtable(a0),a0");
                  // a0 = vtable absolute address
                  // asmout.println("\tmove.l\tSegStart1(a5),a1");
                  // asmout.println("\tadd.l\ta1,a0");
                  asmout.println("\tadd.l\tSegStart1(a5),a0");  // PMD version 2.0.3
                  // a0 = jumptable-entry data-relative address
                  asmout.println("\tmove.w\t" + (2 * mm.vtableIndex) + "(a0),a0");
                  // a0 = method absolute address
                  asmout.println("\tjsr\t0(a5,a0.l)\t; ..." + mm);
                }
                else
                  asmout.println("\t; removed, no vtable for " + mm);
              }
              else 
              {
                // changed version 2.0.3, vtable shorted to 2 bytes per.
                // a0 = instance
                if ( argStackSize > 0 )
                  asmout.println("\tmove.l\t" + (4 * argStackSize) + "(a7),a0");
                else
                  asmout.println("\tmove.l\t(a7),a0");
                generateNullCheck( null, CodeAnnotation.isNullCheckNeeded(annotations, index) );
                // don't generate code for case where there is no instance - must have warned
                if ( true )
                {
                  // a0 = ClassInfo structure
                  asmout.println("\tbsr.far\tgetclassinfo_a0");
                  // a0 = vtable relative address
                  asmout.println("\tmove.l\tClassInfo.Vtable(a0),a0");
                  // a0 = vtable absolute address
                  asmout.println("\tlea\t__Startup__(pc),a1");
                  asmout.println("\tadd.l\ta1,a0");
                  // a0 = method relative address
                  asmout.println("\tclr.l\td0");
                  asmout.println("\tmove.w\t" + (2 * mm.vtableIndex) + "(a0),d0");
                  // a0 = method absolute address
                  // asmout.println("\tlea\t0(pc),a1");
                  asmout.println("\tjsr\t0(a1,d0.l)\t; ..." + mm);
                }
                else
                  asmout.println("\t; removed, no vtable for " + mm);
              }
              // if we are returning the result of a invoke we can just pass it on
              if ( !jumpTargets[next] &&
                ( nextOpcode == op_ireturn ||
                nextOpcode == op_lreturn ||
                nextOpcode == op_dreturn ||
                nextOpcode == op_freturn ||
                nextOpcode == op_areturn ||
                nextOpcode == op_return
                ) &&
                optimization > 0 )
              {
                // don't need to adjust a7 since unlink does it for us
                asmout.println("\t\t; return the result directly");
                generateMethodEpilogue();
                iterator.iterate();                // skip the ret we have handled
                needsReturn = iterator.nextIndex < code.code.length;
                if ( debugSymbols && needsReturn )
                  asmout.println("\tdc.w   0");  // stop SysFatalAlert from tripping up
                break;
              }
              generateStackAdjust(argStackSize+1);
              switch (ret.charAt(0)) 
              {
              case 'B':
              case 'C':
              case 'I':
              case 'F':
              case 'S':
              case 'Z':
                nextTosInRegister = true;
                if ( optimization >= 5 )
                  basicIntegerExpression("d0");
                break;
              case 'J':
              case 'D':
                asmout.println("\tmove.l\td1,-(a7)");
                asmout.println("\tmove.l\td0,-(a7)");
                break;
              case 'L':
              case '[':
                nextTosInRegister = nextOpHandlesRegister;
                if ( nextOpHandlesRegister )
                {
                  if ( nextOpcode == op_astore || (nextOpcode >= op_astore_0 && nextOpcode <= op_astore_3) )
                  {
                    iterator.iterate();
                    asmout.println(disassemble());
                    op = iterator.opcode;
                    wide = iterator.wide;
                    if ( op == op_astore )
                      t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
                    else
                      t = op - op_astore_0;
                    asmout.println("\tmove.l\ta0," + localNames[t] + "\t; direct from A0");
                    nextTosInRegister = false;
                    localInA0 = t;    // we might as well remember that we have cached it
                  }
                  else
                    asmout.println("\tmove.l\ta0,d0");
                }
                else
                  asmout.println("\tmove.l\ta0,-(a7)");
                break;
              case 'V':
                break;
              default:
                ASSERT.fail("Internal error: Unknown return type: " + ret);
                break;
              }
              break;
            }
            case op_invokespecial:
            {
              t = iterator.getUnsignedInteger (0, 2);
              MethodInfo m = pool.getMethodInfo(t);
              // In a special case, the method has to be found in a class
              // different from the one mentioned in the constant pool.
              if ((!m.name.equals ("<init>")) &&
                ((myClass.access_flags & ACC_SUPER) != 0) &&
                myClass.hasSuperclass (m.cls)) 
              {
                // re-search method beginning in our superclass
                m = myClass.superclass.findMethod(m.name, m.signature);
              }
              localInA0 = -1;
              if ( checkNull && 
                ( optimization == 0 ||
                ( !m.name.equals ("<init>") &&    // can't call a constructor with null
                CodeAnnotation.isNullCheckNeeded(annotations, index) )
                )
                )
              {
                if ( m.argStackSize() > 0 )
                  generateNullCheck( (4 * m.argStackSize()) + "(a7)", true);
                else
                  generateNullCheck( "(a7)", true );
              }
              else
                generateNullCheck(null, false);

              // PMD 2.1.8
              if (useDynamicClinit && !CodeAnnotation.classInitialized(annotations,index))
                generateDynamicClinit(method.cls, m.cls, false);
              if ( m.isEmpty() )
                asmout.println("\t\t; removed empty call to " + m );
              else
              {
                if ( m.segno == segno && optimization >= 6 )
                  asmout.println("\tbsr\t" + m.shortLabel() + "\t; (direct)" + m);
                else
                {
                  asmout.println("\tbsr.far\t" + m.shortLabel() + "\t; " + m);
                  m.intersegment = true;
                }
              }
              // if we are returning the result of a invoke we can just pass it on
              if ( !jumpTargets[next] && nextOpcode == op_return && optimization > 0 )
              {
                // don't need to adjust a7 since unlink does it for us
                asmout.println("\t\t; return void directly");
                generateMethodEpilogue();
                iterator.iterate();                // skip the ret we have handled
                needsReturn = iterator.nextIndex < code.code.length;
                if ( debugSymbols && needsReturn )
                  asmout.println("\tdc.w   0");  // stop SysFatalAlert from tripping up
                break;
              }
              int ss = m.argStackSize();
              generateStackAdjust(ss+1);
              switch (m.returnType().charAt(0)) 
              {
              case 'B':
              case 'C':
              case 'I':
              case 'F':
              case 'S':
              case 'Z':
                nextTosInRegister = true;
                if ( optimization >= 5 )
                  basicIntegerExpression("d0");
                break;
              case 'J':
              case 'D':
                asmout.println("\tmove.l\td1,-(a7)");
                asmout.println("\tmove.l\td0,-(a7)");
                break;
              case 'L':
              case '[':
                nextTosInRegister = nextOpHandlesRegister;
                if ( nextOpHandlesRegister )
                  asmout.println("\tmove.l\ta0,d0");
                else
                  asmout.println("\tmove.l\ta0,-(a7)");
                break;
              case 'V':
                break;
              default:
                ASSERT.fail("Internal error: Unknown return type: " + m.returnType());
                break;
              }
              break;
            }
            case op_invokestatic:
            {
              t = iterator.getUnsignedInteger (0, 2);
              MethodInfo m = pool.getMethodInfo(t);
              FieldInfo f = optimization >= 6 ? m.getGetterField() : null;
              // PMD 2.1.8
              if (useDynamicClinit && !CodeAnnotation.classInitialized(annotations,index))
                generateDynamicClinit(method.cls, m.cls, false);
              if ( finalizer && m.hasObjectArg() )
              {
                System.out.println("\n--- WARNING --- : object/array arguments not supported in finalize() methods");
                System.out.println(" for "+m);
              }
              if ( f != null )
              {
                asmout.println( "\t\t; inlined getstatic "+f );
                // added for 2.0.3
                String faddr = f.shortLabel()+"(a5)";
                switch ( f.signature.charAt(0) )
                {
                case 'Z':
                case 'B':
                  // System.out.println("static signed byte getter for "+f);
                  asmout.println("\tmove.b\t"+faddr+",d0");
                  asmout.println("\text.w\td0");
                  asmout.println("\text.l\td0");
                  nextTosInRegister = true;
                  basicIntegerExpression( "d0" );
                  break;
                case 'C':
                  // System.out.println("static unsigned byte getter for "+f);
                  asmout.println("\tclr.l\td0");
                  asmout.println("\tmove.b\t"+faddr+",d0");
                  nextTosInRegister = true;
                  basicIntegerExpression( "d0" );
                  break;
                case 'S':
                  // System.out.println("static short getter for "+f);
                  asmout.println("\tmove.w\t"+faddr+",d0");
                  asmout.println("\text.l\td0");
                  nextTosInRegister = true;
                  basicIntegerExpression( "d0" );
                  break;
                case 'L':
                case '[':
                  // System.out.println("static Object getter for "+f);
                  basicIntegerExpression( faddr );
                  break;
                case 'I':
                case 'F':
                  // System.out.println("static 32-bit getter for "+f);
                  basicIntegerExpression( faddr );
                  break;
                default:
                  ASSERT.fail ("unhandled type inlined " + f.signature + " at " + f);
                  break;
                }
                break;
              }
              else if ( m.isEmpty() )
                asmout.println("\t\t; removed empty call to " + m );
              else if ( !segmentedCode || (m.segno == segno && optimization >= 6) )
              {
                asmout.println("\tbsr\t" + m.shortLabel() + "\t; (direct)" + m);
                localInA0 = -1;
              }
              else
              {
                asmout.println("\tjsr\tto_" + m.shortLabel() + "(a5)\t; " + m);
                m.intersegment = true;
                localInA0 = -1;
              }
              // if we are returning the result of a invoke we can just pass it on
              if ( !jumpTargets[next] &&
                ( nextOpcode == op_ireturn ||
                nextOpcode == op_lreturn ||
                nextOpcode == op_dreturn ||
                nextOpcode == op_freturn ||
                nextOpcode == op_areturn ||
                nextOpcode == op_return
                ) &&
                optimization > 0 )
              {
                // don't need to adjust a7 since unlink does it for us
                asmout.println("\t\t; return the result directly");
                generateMethodEpilogue();
                iterator.iterate();                 // skip the ret we have handled
                needsReturn = iterator.nextIndex < code.code.length;
                if ( debugSymbols && needsReturn )
                  asmout.println("\tdc.w    0");  // stop SysFatalAlert from tripping up
                break;
              }
              int ss = m.argStackSize();
              generateStackAdjust(ss);
              switch (m.returnType().charAt(0)) 
              {
              case 'B':
              case 'C':
              case 'I':
              case 'F':
              case 'S':
              case 'Z':
                nextTosInRegister = true;
                if ( optimization >= 5 )
                  basicIntegerExpression("d0");
                break;
              case 'J':
              case 'D':
                asmout.println("\tmove.l\td1,-(a7)");
                asmout.println("\tmove.l\td0,-(a7)");
                break;
              case 'L':
              case '[':
                nextTosInRegister = nextOpHandlesRegister;
                if ( nextOpHandlesRegister )
                {
                  if ( nextOpcode == op_astore || (nextOpcode >= op_astore_0 && nextOpcode <= op_astore_3) )
                  {
                    iterator.iterate();
                    asmout.println(disassemble());
                    op = iterator.opcode;
                    wide = iterator.wide;
                    if ( op == op_astore )
                      t = iterator.getUnsignedInteger (0, wide ? 2 : 1);
                    else
                      t = op - op_astore_0;
                    asmout.println("\tmove.l\ta0," + localNames[t] + "\t; direct from A0");
                    nextTosInRegister = false;
                    localInA0 = t;    // we might as well remember that we have cached it
                  }
                  else
                    asmout.println("\tmove.l\ta0,d0");
                }
                else
                  asmout.println("\tmove.l\ta0,-(a7)");
                break;
              case 'V':
                break;
              default:
                ASSERT.fail("Internal error: Unknown return type: " + m.returnType());
                break;
              }
              break;
            }
            case op_new: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              Klass cls = pool.getKlass (t);
              if ( finalizer )
                System.out.println("\n--- WARNING --- : new not supported in finalize() methods");
              else if (useDynamicClinit && !CodeAnnotation.classInitialized(annotations,index))
                  generateDynamicClinit(method.cls, cls, false); // PMD 2.1.8
              asmout.println("\tmove.l\t#" + cls.classIndex + ",d0\t; " + cls);
              asmout.println("\tbsr.far\top_new");
              localInA0 = -1;
            }
              break;
            case op_newarray:
              if ( finalizer )
                System.out.println("\n--- WARNING --- : new array not supported in finalize() methods");
              new_array();
              localInA0 = -1;
              break;
            case op_anewarray: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              Klass cls = pool.getKlass (t);
              if ( finalizer )
                System.out.println("\n--- WARNING --- : new array not supported in finalize() methods");
              Klass acls = Klass.forName ("[" + cls.getSignature());
              asmout.println("\tmove.l\t#" + acls.classIndex + ",d0");
              asmout.println("\tbsr.far\top_anewarray");
              localInA0 = -1;
            }
              break;
            case op_arraylength:
              asmout.println("\tmove.l\t(a7)+,a0");
              localInA0 = CodeAnnotation.getLocalSlot(annotations, index);
              generateNullCheck( null, CodeAnnotation.isNullCheckNeeded(annotations, index) );
              if (nextOpHandlesRegister)
              {
                asmout.println("\tclr.l\td0");
                asmout.println("\tmove.w\tArray.length(a0),d0");
              }
              else
              {
                asmout.println("\tmove.w\tArray.length(a0),-(a7)");
                asmout.println("\tclr.w\t-(a7)");
              }
              nextTosInRegister = nextOpHandlesRegister;
              break;
            case op_athrow:
              asmout.println("\tbsr.far\top_athrow");
              localInA0 = -1;
              break;
            case op_checkcast: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              Klass cls = pool.getKlass (t);
              if ( finalizer )
              {
                System.out.println("\n--- WARNING --- : object cast not supported in finalize() methods");
                System.out.println(" for "+cls);
              }
              int targetIndex = Klass.instanceofTargetClassList.indexOf (cls);
              String subLabel = label + "__" + index + "ok";

              if (targetIndex < 0) 
              {
                ASSERT.fail (cls + " not in Klass.instanceofTargetClassList");
              }
              localInA0 = -1;
              asmout.println("\tmove.l\t(a7),a0");
              asmout.println("\tcmp.w\t#0,a0");
              asmout.println("\tbeq.s\t" + subLabel);
              asmout.println("\tbsr.far\tgetclassinfo_a0");
              asmout.println("\tbtst\t#" + (targetIndex % 8) + 
                ",ClassInfo.Itable+" +
                (targetIndex / 8) + "(a0)");
              asmout.println("\tbne.s\t" + subLabel);
              asmout.println("\tbsr.far\tthrow_ClassCastException");
              asmout.println(subLabel + ":");
              localInA0 = -1;
              break;
            }
            case op_instanceof: 
            {
              t = iterator.getUnsignedInteger (0, 2);
              Klass cls = pool.getKlass (t);
              if ( finalizer )
              {
                System.out.println("\n--- WARNING --- : instanceof not supported in finalize() methods");
                System.out.println(" for "+cls);
              }
              int targetIndex = Klass.instanceofTargetClassList.indexOf (cls);
              String subLabel = label + "__" + index + "a";

              if (targetIndex < 0) 
              {
                ASSERT.fail (cls + " not in Klass.instanceofTargetClassList");
              }

              asmout.println("\tclr.l\td0");
              asmout.println("\tmove.l\t(a7)+,a0");
              asmout.println("\tcmp.l\td0,a0");
              asmout.println("\tbeq.s\t" + subLabel);
              asmout.println("\tbsr.far\tgetclassinfo_a0");
              asmout.println("\tbtst\t#" + (targetIndex % 8) + 
                ",ClassInfo.Itable+" +
                (targetIndex / 8) + "(a0)");
              asmout.println("\tsne.b\td0");
              asmout.println("\tand.l\t#1,d0");
              asmout.println(subLabel + ":");
              nextTosInRegister = true;
              localInA0 = -1;
            }
              break;
            case op_monitorenter:
              generateStackAdjust(1);
              // asmout.println("\tbsr.far\top_monitorenter");
              // localInA0 = -1;
              break;
            case op_monitorexit:
              generateStackAdjust(1);
              // asmout.println("\tbsr.far\top_monitorexit");
              // localInA0 = -1;
              break;
            case op_multianewarray: 
            {
              if ( finalizer )
                System.out.println("\n--- WARNING --- : multi new array not supported in finalize() methods");
              t = iterator.getUnsignedInteger (0, 2);
              u = iterator.getUnsignedInteger (2, 1);
              generateMultianewarray (pool.getKlass(t), u, 4*(u-1), 
                label + "__" + index);
              generateStackAdjust(u);
              asmout.println("\tmove.l\ta0,-(a7)");
              localInA0 = -1;
            }
              break;
            case op_ifnull:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbeq\t" + label + "__" + (index + t));
              break;
            case op_ifnonnull:
              t = iterator.getSignedInteger (0, 2);
              if ( tosInRegister )
                asmout.println("\ttst.l\td0");
              else
                asmout.println("\tmove.l\t(a7)+,d0");
              asmout.println("\tbne\t" + label + "__" + (index + t));
              break;
            case op_goto_w:
              ASSERT.fail("Unimplemented: Opcode 'goto_w'");
              break;
            case op_jsr_w:
              ASSERT.fail("Unimplemented: Opcode 'jsr_w'");
              break;
            case op_breakpoint:
              asmout.println("\tdc.w\tbreakpoint");
              break;
            default:
              ASSERT.fail("Internal error: Unknown bytecode: "+op);
              break;
            }
          }
          else 
          {
            // Everything should be stacked if unneeded instruction
            // processed. This is caution rather than absolute
            // necessity.
            if ( tosInRegister ) 
            {
              asmout.println("\tmove.l\td0,-(a7)");
              tosInRegister = false;
            }

            switch (op) 
            {
            case op_getstatic:
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              switch (field.signature.charAt(0)) 
              {
              case 'D':
              case 'J':
                stackDelta += 2;
                break;
              default:
                stackDelta += 1;
                break;
              }
              break;
            }
            case op_putstatic:
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              switch (field.signature.charAt(0)) 
              {
              case 'D':
              case 'J':
                stackDelta -= 2;
                break;
              default:
                stackDelta -= 1;
                break;
              }
              break;
            }
            case op_getfield:
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              switch (field.signature.charAt(0)) 
              {
              case 'D':
              case 'J':
                stackDelta += 1;
                break;
              default:
                stackDelta += 0;
                break;
              }
              break;
            }
            case op_putfield:
            {
              t = iterator.getUnsignedInteger (0, 2);
              FieldInfo field = pool.getFieldInfo (t);
              switch (field.signature.charAt(0)) 
              {
              case 'D':
              case 'J':
                stackDelta -= 3;
                break;
              default:
                stackDelta -= 2;
                break;
              }
              break;
            }
            case op_invokevirtual:
            case op_invokespecial:
            case op_invokeinterface:
            {
              t = iterator.getUnsignedInteger (0, 2);
              MethodInfo mm = pool.getMethodInfo (t);
              int argStackSize = mm.argStackSize();
              String ret = mm.returnType();
              switch (ret.charAt(0)) 
              {
              case 'D':
              case 'J':
                stackDelta -= argStackSize + 1 - 2;
                break;
              case 'V':
                stackDelta -= argStackSize + 1 - 0;
                break;
              default:
                stackDelta -= argStackSize + 1 - 1;
                break;
              }
              break;
            }
            case op_invokestatic:
            {
              t = iterator.getUnsignedInteger (0, 2);
              MethodInfo mm = pool.getMethodInfo (t);
              int argStackSize = mm.argStackSize();
              String ret = mm.returnType();
              switch (ret.charAt(0)) 
              {
              case 'D':
              case 'J':
                stackDelta -= argStackSize - 2;
                break;
              case 'V':
                stackDelta -= argStackSize - 0;
                break;
              default:
                stackDelta -= argStackSize - 1;
                break;
              }
              break;
            }
            case op_multianewarray:
              t = iterator.getUnsignedInteger (2, 1);
              stackDelta -= t - 1;
              break;
            default:
              stackDelta += StackDeltas[op];
              break;
            }
            asmout.println("\t\t; dStack = " + stackDelta);
          }
          tosInRegister = nextTosInRegister;
        } while (iterator.iterate());

        if ( needsReturn || branchToReturn )
        {
          // if the are no branches to the return then don't label it
          // and try to handle result directly in a register
          if ( branchToReturn )
          {
            if ( tosInRegister ) 
            {
              asmout.println("\tmove.l\td0,-(a7)");
              tosInRegister = false;
            }
            asmout.println(label + "__out:");
          }
          if ( tosInRegister )
            asmout.println("\t\t; return avoids push/pop");
          switch (method.returnType().charAt(0)) 
          {
          case 'B':
          case 'C':
          case 'F':
          case 'I':
          case 'S':
          case 'Z':
            if ( !tosInRegister ) 
              asmout.println("\tmove.l\t(a7)+,d0");
            break;
          case 'D':
          case 'J':
            if ( !tosInRegister ) 
              asmout.println("\tmove.l\t(a7)+,d0");
            asmout.println("\tmove.l\t(a7)+,d1");
            break;
          case 'L':
          case '[':
            // still slightly quicker than pushing ad popping
            asmout.println("\tmove.l\t" + ( tosInRegister ? "d0" :"(a7)+") + ",a0");
            break;
          case 'V':
            break;
          default:
            ASSERT.fail("Internal error: Unknown return type at " + method);
            break;
          }
          generateMethodEpilogue();
        }
        asmout.println();
        if (debugSymbols) 
        {
          generateDebugSymbol(method.shortName());
        }
      
        if ( segno == 0 || code.exception_table.length>0 || optimization == 0 )
        {
          // exception handling code

          // d2 = initiating address
          // a2 = Throwable instance
          // a0 = classtable entry for Throwable instance
          // a6 = frame pointer of last full-featured stack frame
        
          // exception handler entry point
          asmout.println(label + "__exceptions:");
        
          for (int j=0; j<code.exception_table.length; j++) 
          {
            int spc = code.exception_table[j].start_pc;
            int epc = code.exception_table[j].end_pc;
            int hpc = code.exception_table[j].handler_pc;
            Klass catchClass = Klass.forName (code.exception_table[j].catch_type_name);
        
            asmout.println("\t; goto " + hpc + " if within [" + spc +
              ".." + epc + ") type " + catchClass);
        
            if (catchClass.hasInstances()) 
            {
              int targetIndex = Klass.instanceofTargetClassList.indexOf (catchClass);
              if (targetIndex < 0) 
              {
                ASSERT.fail (catchClass + " not in Klass.instanceofTargetClassList");
              }
          
              // type match?
              asmout.println("\tbtst\t#" + (targetIndex % 8) + 
                ",ClassInfo.Itable+" +
                (targetIndex / 8) + "(a0)");
              asmout.println("\tbeq.s\t" + label + "__exc" + j);
              // after start pc? 
              // (exclusive test because 68K already inc'ed its pc)
              asmout.println("\tlea.l\t" + label + "__" + spc + "(pc),a1");
              asmout.println("\tcmp.l\ta1,d2");
              asmout.println("\tbls.s\t" + label + "__exc" + j);
              // before end pc? 
              // (inclusive test because 68K already inc'ed its pc)
              asmout.println("\tlea.l\t" + label + "__" + epc + "(pc),a1");
              asmout.println("\tcmp.l\ta1,d2");
              asmout.println("\tbhi.s\t" + label + "__exc" + j);
              // match: adjust stack and jump to handler-pc
              asmout.println("\tlea.l\t" + (- 4 * (localonly + parametersInRegs + 1)) + "(a6),a7");
              asmout.println("\tmove.l\tcurrentException(a5),-(a7)");
              asmout.println("\tbra\t" + label + "__" + hpc);
              asmout.println(label + "__exc" + j + ":");
            }
            else 
            {
              asmout.println("\t; (program cannot generate this exception class)");
            }
          }

          // no applicable exception handler in this frame: go up
          if ( segno == 0 || optimization == 0 )
          {
            // d2 = initiating address
            // a2 = Throwable instance
            // a0 = classtable entry for Throwable instance
            // a6 = frame pointer of last full-featured stack frame
          
            asmout.println("\t; go up to next frame");
            asmout.println("\tmove.l\t4(a6),d2");
            asmout.println("\tunlk\ta6");
            asmout.println("\tmove.l\t-4(a6),a1");
            asmout.println("\tjmp\t(a1)\t; previous exception handler");
            asmout.println();
            if (debugSymbols) 
            {
              asmout.println("\trts");
              generateDebugSymbol(method.shortName() + "%exc");
            }
          }
          else
            asmout.println("\tbra\t__segment" + segno + "__exceptions_" + allocatedRegs);
        }
      }
      else 
      {
        // report if the missing method is native.
        ASSERT.fail ("Code missing for " + ((method.access_flags & ACC_NATIVE) != 0 ? "native " : "") + method);
      }
      // System.out.print(".");
      String progress = Integer.toString(methodNum++);
      System.out.print( progress + "\b\b\b\b\b".substring(0, progress.length()) );
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating code for " + method);
    }
    this.iterator = null;
    this.method = null;
    this.label = null;
    this.pool = null;
    this.jumpTargets = null;
    this.neededArray = null;
    this.annotations = null;
    this.localNames = null;
  }

  /**
   * generate code for a 'multianewarray' instruction.
   *
   * The code leaves the array in register a0.
   *
   * @param cls            the array class to be instantiated
   * @param dimensions     the number of dimensions
   * @param offsetToLength the stack-relative offset where we find 
   *                       the length for this dimension
   * @param labelPrefix    prefix to be used for branch labels within
   *                       this 'multianewarray' code block
   */
  void generateMultianewarray (Klass cls, int dimensions, 
    int offsetToLength, String labelPrefix)
  {
    if (dimensions <= 1) 
    {
      generateMultianewarrayCore (cls, dimensions, offsetToLength, labelPrefix);
    }
    else if (dimensions == 2) 
    {
      asmout.println("\tmove.l\td7,-(a7)");
      generateMultianewarrayCore (cls, dimensions, offsetToLength+4, labelPrefix);
      asmout.println("\tmove.l\t(a7)+,d7");
    }
    else if (dimensions >= 7) 
    {
      ASSERT.fail ("Jump cannot handle multianewarray instruction with dimensions >= 7");
    }
    else 
    {
      String firstReg = "d" + (9-dimensions);
      asmout.println("\tmovem.l\t" + firstReg + "-d7,-(a7)");
      generateMultianewarrayCore (cls, dimensions, 
        offsetToLength + 4*(dimensions-1), 
        labelPrefix);
      asmout.println("\tmovem.l\t(a7)+," + firstReg + "-d7");
    }
  }

  /**
   * generate core for a 'multianewarray' instruction.
   *
   * The code leaves the array in register a0.
   *
   * @param cls            the array class to be instantiated
   * @param dimensions     the number of dimensions
   * @param offsetToLength the stack-relative offset where we find 
   *                       the length for this dimension
   * @param labelPrefix    prefix to be used for branch labels within
   *                       this 'multianewarray' code block
   */
  void generateMultianewarrayCore (Klass cls, int dimensions, 
    int offsetToLength, String labelPrefix)
  {
    int index = cls.classIndex;
    int elsize = 4;
    int shift = 2;
    boolean objArray = false;
    String sig = cls.getSignature();
    
    if      (sig.startsWith("[B")) { elsize = 1; shift = 0; }
    else if (sig.startsWith("[C")) { elsize = 1; shift = 0; }
    else if (sig.startsWith("[D")) { elsize = 8; shift = 3; }
    else if (sig.startsWith("[F")) { elsize = 4; shift = 2; }
    else if (sig.startsWith("[I")) { elsize = 4; shift = 2; }
    else if (sig.startsWith("[J")) { elsize = 8; shift = 3; }
    else if (sig.startsWith("[L")) { elsize = 4; shift = 2; objArray = true; }
    else if (sig.startsWith("[S")) { elsize = 2; shift = 1; }
    else if (sig.startsWith("[Z")) { elsize = 1; shift = 0; }
    else if (sig.startsWith("[[")) { elsize = 4; shift = 2; objArray = true; }

    if (dimensions <= 1) 
    {
      if (objArray) 
      {
        asmout.println("\tmove.w\t#" + cls.classIndex + ",d0\t; " + cls);
        asmout.println("\tmove.l\t" + offsetToLength + "(a7),-(a7)");
        asmout.println("\tbsr.far\top_anewarray");
        asmout.println("\tmove.l\t(a7)+,a0");
      }
      else 
      {
        asmout.println("\tmove.w\t#" + cls.classIndex + ",d0\t; " + cls);
        asmout.println("\tmove.w\t#" + elsize + ",d1");
        asmout.println("\tmove.l\t" + offsetToLength + "(a7),-(a7)");
        asmout.println("\tbsr.far\top_newarray");
        asmout.println("\tmove.l\t(a7)+,a0");
      }
    }
    else 
    {
      if (!sig.startsWith("[[")) 
      {
        ASSERT.fail ("Wrong array type in 'multianewarray'");
      }

      // data register to be used for the loop
      String loopReg = "d" + (9-dimensions);
      String loopLabel = labelPrefix + "_loop" + dimensions;
      String loopEndLabel = labelPrefix + "_end" + dimensions;
      Klass nextClass = Klass.forName (sig.substring (1));

      // new instance 
      asmout.println("\tmove.l\t" + offsetToLength + "(a7)," + loopReg);
      asmout.println("\tmove.l\t" + loopReg + ",-(a7)");
      asmout.println("\tmove.w\t#" + cls.classIndex + ",d0\t; " + cls);
      asmout.println("\tbsr.far\top_anewarray");
      asmout.println("\tmove.l\t(a7),a0");
      asmout.println("\tmove.l\tArray.data(a0),-(a7)");
      // stack is ... array-ptr, data-ptr

      // the loop
      asmout.println("\tbra.s\t" + loopEndLabel);
      asmout.println(loopLabel + ":");

      generateMultianewarrayCore (nextClass, dimensions-1, offsetToLength+4, 
        labelPrefix);

      asmout.println("\tmove.l\t(a7),a1");
      asmout.println("\tmove.l\ta0,(a1)+");
      asmout.println("\tmove.l\ta1,(a7)");
      asmout.println(loopEndLabel + ":");
      asmout.println("\tdbra\t" + loopReg + "," + loopLabel);
      asmout.println("\taddq.l\t#4,a7");
      asmout.println("\tmove.l\t(a7)+,a0");
    }
  }

  /**
   * generate a stack-adjust instruction as a replacement 
   * for unneeded bytecodes and method calls.
   *
   * @param delta the stack growth to be simulated (in 4-byte int-units)
   */
  void generateStackAdjust(int n)
  {
    if ( n < -2 || n > 2 )
      asmout.println( "\tlea\t"+(n*4)+"(a7),a7" );
    else if (n < 0)
      asmout.println( "\tsubq.l\t#"+(-n*4)+",a7" );
    else if (n > 0)
      asmout.println( "\taddq.l\t#"+(n*4)+",a7" );
  }

  /**
   * generate a Macsbug-compatible routine name entry.
   */
  void generateDebugSymbol(String rawName)
  {
    int pos;

    // put symbol on same line so that comment is not pruned by peephole phase
    // added 2.0.3 P.M.Dickerson
    // shorten symbol to base class.method if too long
    while ( rawName.length() > 31 && (pos = rawName.indexOf('/')) > 0 )
    {
        rawName = ".." + rawName.substring(pos+1);
    }
    asmout.print  ("\tdc.b\t$80," + rawName.length()+"\t; Debug Symbol " + rawName);
    for (int i=0; i<rawName.length(); i++) 
    {
      if ((i & 15) == 0) 
      {
        asmout.println();
        asmout.print("\tdc.b\t");
      }
      else 
      {
        asmout.print(",");
      }

      char ch = rawName.charAt(i);
      if ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._%"
        .indexOf(ch) >= 0) 
      {
      }
      else if ((pos = "$/<>".indexOf(ch)) >= 0) 
      {
        ch = "%.__".charAt(pos);
      }
      else 
      {
        ch = '_';
      }
      asmout.print("$" + Integer.toHexString((int) ch));
    }
    asmout.println();
    /* PMD: the symbol name is not necessarily NUL terminated if it has
     * odd length because align 2 fills with junk. As a result an exception
     * could report the wrong method name because it would skip forward too
     * far.
     */
    asmout.println("\tdc.b\t0");    // asmout.println("\talign\t2");
    asmout.println("\talign\t2");    // asmout.println("\tdc.w\t0");

    asmout.println();
  }

  /**
   * write the code that calls the &lt;clinit&gt; methods.
   */
  void generateClinitCode()
  {
    Jump.currentElement = null;

    Vector clinits = Klass.clinitOrdering();

    int clindex = 0;

    asmout.println();
    asmout.println("\tcode");
    asmout.println();
    asmout.println("all_clinit:");
    // early inits must be init specified order whatever jump might think.
    for (int j=0; j<earlyClassInit.size(); j++)
    {
      String clsName = (String)earlyClassInit.elementAt(j);
      for (int i=0; i<clinits.size(); i++) 
      {
        MethodInfo m = (MethodInfo) clinits.elementAt(i);
        if ( clsName.equals(m.cls.className) )
        {
          if ( Jump.codeOptions.verbosity > 0 )
            System.out.println( "Class "+clsName+" uses early initialization" );
          if ( !m.isEmpty() )
          {
            asmout.println("\t; early class init for " + clsName);
            asmout.println("\tbsr.far\t" + m.shortLabel());
            m.intersegment = true;
            m.cls.clinitClassIndex = clindex++;
          }
          // mark class as being already inited i.e. trust it.
          // PMD 2.1.9 fix too agressive assumptions about class initialization
          m.cls.hasEarlyInit = true;
          break;
        }
      }
    }
    for (int i=0; i<clinits.size(); i++) 
    {
      MethodInfo m = (MethodInfo) clinits.elementAt(i);
      if ( !earlyClassInit.contains(m.cls.className) && !m.isEmpty() )
      {
        if (!useDynamicClinit)
        {
          asmout.println("\t; class init for " + m.cls);
          asmout.println("\tbsr.far\t" + m.shortLabel());
          m.intersegment = true;
        }
        m.cls.clinitClassIndex = clindex++;
      }
    }
    asmout.println("\trts");
    asmout.println();
    if (useDynamicClinit)
    {
      asmout.println("\tdata");
      asmout.println("classInitBitmap\tds.b\t" + ((clindex+15)/16)*2);
    }
  }

  /**
   * write the needed subroutines. This is controlled mainly by
   * the JVM opcodes used in the program.
   */
  void generateSubroutines ()
  {
    try 
    {
      Jump.currentElement = null;

      asmout.println();
      asmout.println("\tcode");
      asmout.println();
    
      boolean[] used = Klass.getAllBytecodesUsed();
      asmout.println(";; --- the JVM bytecode implementations ---");
      for (int i=0; i<OPCODE_NAMES.length; i++) 
      {
        String label = "op_" + OPCODE_NAMES[i];
        NativeRef ref = (NativeRef) allNatives.get (label);
        
        if ((ref != null) && ref.isNeeded()) 
        {
          asmout.println(label + ":");
          ref.copyTo (asmout);
        }
      }

      // moved after opcodes to be next to class table
      ((NativeRef) allNatives.get("kernel-routines")).copyTo(asmout);

    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating subroutines");
    }
  }

  /**
   * write the leadout code. This is the DataSize label.
   */
  void generateLeadout ()
  {
    Jump.currentElement = null;

    asmout.println();
    asmout.println("\tdata");
    asmout.println("DataSize\tds.w\t0");
    asmout.println();
  }

  /**
   * write the resources section.
   */
  void generateResources()
  {
    try 
    {
      Jump.currentElement = null;

      // String resFilename = Jump.mainClassName.replace('.', File.separatorChar) + ".res";
      // 13 Dec 2003.  PMD Resource file (.res) uses current dir if asm-path-uses-package = no.
      String resFilename = projectname.replace('.', File.separatorChar) + ".res";

      if (stacksize > 0) 
      {
        asmout.println();
        asmout.println(";========================================");
        asmout.println("; System application preferences");
        asmout.println(";");
        asmout.println("\tres\t'pref', 0");
        asmout.println("\tdc.w\t30\t; default priority");
        asmout.println("\tdc.l\t" + (stacksize+512) + "\t; stack size");
        asmout.println("\tdc.l\t10000\t; min heap size");
        asmout.println();
      }

      if (wabajump) 
      {
        InputStream instream = Jump.getClasspathStream (resFilename);
        if (instream != null) 
        {
          copyStream(instream, resFilename);
        }
      }
      else 
      {
        copyStream(Jump.getClasspathStream (resFilename), 
          resFilename);
      }
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "generating resources");
    }
  }

  /*
   *                  helper methods
   * ====================================================
   */

  /**
   * assert compatibility of Java classes.
   */
  void assertCompatibility()
  {
    ASSERT.check (Jump.CHARSIZE == 1, "For AsmBackEnd, Jump.CHARSIZE must be 1");

    // AsmBackEnd needs a specific layout of the java.lang.String class.
    boolean incompatible = false;
    Klass stringClass = Klass.forName ("java/lang/String");
    FieldInfo[] fields = stringClass.fields;

    // the fields needed for Jump
    FieldInfo vField = stringClass.findField ("value");
    FieldInfo cField = stringClass.findField ("count");
    FieldInfo oField = stringClass.findField ("offset");

    // optional field that doesn't hurt
    FieldInfo hField = stringClass.findField ("hash");
        
    // String class must not contain additional non-static fields
    for (int i=0; i<fields.length; i++) 
    {
      FieldInfo f = fields[i];
      if (f.isNeeded() && ((f.access_flags & ACC_STATIC) == 0)) 
      {
        if (f == vField) 
        {
        }
        else if (f == cField) 
        {
        }
        else if (f == oField) 
        {
        }
        else if (f == hField) 
        {
        }
        else 
        {
          incompatible = true;
        }
      }
    }
        
    if ((vField == null) || 
      (oField == null) ||     
      (cField == null) || 
      incompatible) 
    {

      System.out.println();
      System.out.println("***                JAVA VERSION INCOMPATIBILITY                 ***");
      System.out.println("***        Use a different Java version, e.g. JDK 1.2.x         ***");
      System.out.println("***  Please report the following lines to the authors !         ***");
      System.out.println("***        Please add information on your Java version !        ***");
          
      if (fields != null) 
      {
        System.out.println();
        System.out.println("   === java.lang.String fields ===");
        for (int i=0; i<fields.length; i++) 
        {
          fields[i].report();
        }
      }

      ASSERT.fail ("java.lang.String class incompatible with Jump's AsmBackEnd.");
    } 
  }

  /**
   * Assign segment numbers to the methods.
   * <p>
   * The segment layout tries to make sure that the code
   * in one segment cannot exceed 32K.
   * Segment 1 contains the kernel routines, 
   * segment 2 the constant strings,
   * methods are found in segments starting with number 3.
   * <p>
   * The layout is based on heuristic assumptions on
   * the expansion factor from bytecode to native code.
   */
  void layoutSegments() 
  {
    try 
    {
      int segmentNumber = 4;
      int segmentBytecodeSize = 0;

      segmentMethods.setSize(segmentNumber+1);

      segmentMethods.set(1, segmentOneLabels());
      segmentMethods.set(2, segmentTwoLabels());

      for (int i=0; i<Klass.ClassList.size(); i++) 
      {
        Klass cl = (Klass) Klass.ClassList.elementAt(i);
        if (cl.methods != null) 
        {
          for (int j=0; j<cl.methods.length; j++) 
          {
            MethodInfo m = cl.methods[j];
            CodeAttribute code = m.attributes.code;
            int methodBytecodeSize = 0;

            if ( m.isNeeded(JavaElement.NEEDED) && !m.isEmpty() ) 
            {
              if (m.nativeRef != null) 
              {
                methodBytecodeSize = 50;
              }
              else if ((code != null) && (code.code != null)) 
              {
                methodBytecodeSize = code.code.length;
              }

              if (segmentBytecodeSize + methodBytecodeSize < segmentBytecodeLimit) 
              {
                segmentBytecodeSize += methodBytecodeSize;
              }
              else 
              {
                segmentBytecodeSize = methodBytecodeSize;
                segmentNumber += 1;
                segmentMethods.setSize(segmentNumber+1);
              }

              if (Jump.codeOptions.verbosity >= 1) 
              {
                System.out.println("Segment " + segmentNumber + 
                  " + " + (segmentBytecodeSize - methodBytecodeSize) +
                  ": " + m);
              }

              Vector methods = (Vector) segmentMethods.elementAt(segmentNumber);
              if (methods == null) 
              {
                methods = new Vector();
                segmentMethods.setElementAt(methods, segmentNumber);
              }
            
              m.segno = segmentNumber;  // so that the method knows where it is too.
              methods.addElement (m);
            }
          }
        }
      }
      // System.out.println();
      System.out.println("      segments allocated: " + segmentNumber);
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "laying out segments");
    }
  }

  /**
   * Collect the segment-1 labels. 
   * The method returns a Vector containing all global labels
   * from code segment 1. These are the fixed labels from the
   * invariant part of the code generator plus the global labels
   * from file 'kernel.asm' (those with a colon).
   */
  Vector segmentOneLabels()
  {
    Vector result = new Vector();

    // result.addElement("ClassTable");
    result.addElement("PilotMain");

    for (int i=0; i<OPCODE_NAMES.length; i++) 
    {
      String label = "op_" + OPCODE_NAMES[i];
      NativeRef ref = (NativeRef) allNatives.get (label);
        
      if ((ref != null) && ref.isNeeded()) 
      {
        result.addElement(label);
      }
    }

    ((NativeRef) allNatives.get("kernel-routines")).addAllLabels(result);

    return result;
  }

  /**
   * Collect the segment-2 labels. 
   * The method returns a Vector containing all global labels
   * from code segment 2. 
   * These are the labels for the constant strings.
   */
  Vector segmentTwoLabels()
  {
    Vector result = new Vector();

    result.addElement("init_constant_strings");

    return result;
  }

  /**
   * get an abbreviated, one-line version of a string without
   * any dangerous characters, suitable for comments.
   */
  String commentFilter (String s)
  {
    char[] chars;
    if (s.length() > 30) 
    {
      chars = new char[30];
      s.getChars (0, 30, chars, 0);
    }
    else 
    {
      chars = s.toCharArray();
    }

    for (int i=0; i<chars.length; i++) 
    {
      char c = chars[i];
      if (Character.getNumericValue(c) > 255) 
      {
        chars[i] = '*';
      }
      else if (Character.isWhitespace(c)) 
      {
        chars[i] = ' ';
      }
      else if (Character.isISOControl(c)) 
      {
        chars[i] = '.';
      }
    }
    return new String (chars);
  }

  /*
   *               debugging methods
   * ====================================================
   */

  /** the full name of this class. */
  public String toString()
  {
    return "AsmBackEnd " + asmoutFilename;
  }

  void report()
  {
  }
}
