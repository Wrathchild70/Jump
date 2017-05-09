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
    This file has been modified in 2000,2001
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/

import java.io.*;
import java.util.*;
import java.util.zip.*;


class Jump implements JVM 
{

  static int CHARSIZE = 1; // or 2

  public static final String JUMP_VERSION = "2.2.2";

  static String Javac;
  static String Pila;

  /** 
   * flag: while resolving dependencies, we detected 
   * new 'needed' elements, meaning that we have to
   * go into one more iteration to find needed elements.
   */
  static boolean newNeeds;

  /**
   * a CodeOptions instance controlling the code generation.
   */
  static CodeOptions codeOptions;

  // static boolean NativeMethodsMissing = false;

  // static Hashtable Native = new Hashtable();

  static Properties projectProps;
  static String mainClassName = null;
  static BackEnd backEnd = null;
  static Klass mainClass = null;

  static JavaElement currentElement = null;

  static void showUsage()
  {
    System.out.println("Usage: java Jump [-mhwgbvVsOcanPDpf] [parms...] classname");
    System.out.println();
    System.out.println("Options:");
    System.out.println("         -t         single segment code (SMALL model, default)");
    System.out.println("         -m         multi-segment code (LARGE model)");
    System.out.println("         -h         storage-memory heap (HUGE model)");
    System.out.println("         -w         WabaJump program");
    System.out.println("         -y         use dynamic class init (more compatible but more code)");
    System.out.println("         -g         include debugger symbols");
    // System.out.println("         -G         generate code for GNU gas assembler (experimental)");
    System.out.println("         -b         *** POSE only ***");
    System.out.println("                    breakpoint plus debugger symbols");
    System.out.println("         -v         verbose output");
    System.out.println("         -V         super-verbose output");
    System.out.println("         -s bytes   *** only if PalmOS >= 3.0 ***");
    System.out.println("                    stack size in bytes");
    System.out.println("         -B bytes   set limit on bytecodes per segment");
    System.out.println("         -On        code optimization level n=0 to 6");
    System.out.println("         -c         disable inclusion of class names (save space)");
    System.out.println("         -a         disable array bound checking *** DANGEROUS ***");
    System.out.println("         -n         disable null checking *** DANGEROUS ***");
    System.out.println("         -S         disable stack checking *** DANGEROUS ***");
    System.out.println("         -N         inline null checking, faster but more code.");
    System.out.println("         -A         initialize static array data");
    System.out.println("         -P         enable/disable peephole optimization phase");
    System.out.println("         -q         don't use main Class package name as part of Asm file name");
    System.out.println("         -Dsymbol   define preprocessor symbol for assembler");
    System.out.println("                    -DOLD_HEAP use the old heap manager");
    System.out.println("                    -DNO_AASTORE_CHECK speed up object array stores");
    System.out.println("                    -DCHECK_HEAP trace heap");
    System.out.println("                    -DDEBUG_HEAP turns on OS heap scrambling (slow)");
    System.out.println("                    -DGC_BEEP beep at garbage collection");
    System.out.println("         -f         disable finalize support");
    System.out.println("         -p         use old pilot.inc for backward compatibility");
    
    System.exit(0);
  }

  static int Run(String cmdline) throws IOException
  {
    System.out.println("Running: " + cmdline);
    Process p = Runtime.getRuntime().exec(cmdline);
    InputStream in = p.getInputStream();
    while (true) 
    {
      int c = in.read();
      if (c < 0) 
      {
        break;
      }
      System.out.write(c);
    }
    return p.exitValue();
  }

  static InputStream getClasspathStream (String name)
  {
    if (name.startsWith("/")) 
    {
      name = name.substring(1);
    }
    String cp = System.getProperty("java.class.path");
    
    StringTokenizer st = new StringTokenizer(cp, File.pathSeparator);
    while(st.hasMoreTokens()) 
    {
      String path = st.nextToken();
      if (path.toLowerCase().endsWith(".zip") ||
        path.toLowerCase().endsWith(".jar")) 
      {
        try 
        {
          ZipInputStream zs = new ZipInputStream(new FileInputStream(path));
          ZipEntry ze = null;
          while ((ze = zs.getNextEntry()) != null) 
          {
            if (ze.getName().equals(name)) 
            {
              return zs;
            }
          }
        }
        catch (Exception e) 
        {
        }
      }
      else if (path.toLowerCase().endsWith(".pdb"))
      {
        try 
        {
          SuperWabaPDB swpdb = new SuperWabaPDB(path);
          return swpdb.getInputStream(name);
        }
        catch (Exception e) 
        {
        }
      }
      else 
      {
        try 
        {
          File f;
          if (path.endsWith(File.separator)) 
          {
            f = new File(path + name);
          }
          else 
          {
            f = new File(path + File.separator + name);
          }
          return new FileInputStream(f);
        }
        catch (FileNotFoundException e) 
        {
        }
      }
    }
    return(ClassLoader.getSystemResourceAsStream(name));
  }

  public static void main(String[] args)
  {
    System.out.println("Jump  Java(tm) User Module for PalmOS  Version " + JUMP_VERSION);
    System.out.println("Copyright (c) 1996,1997 by Greg Hewgill");
    System.out.println("Copyright (c) 2000,2002 by Ralf Kleberhoff <kleberhoff@aol.com>");
    System.out.println("Copyright (c) 2001-2004 by Peter Dickerson <peter.dickerson@ukonline.co.uk>");
    System.out.println("Please see the file COPYING (GPL v2) for distribution rights.\n");
    try 
    {
      if (args.length > 0) 
      {
        mainClassName = args[args.length-1];
      }

      if (mainClassName == null) 
      {
        showUsage();
      }
      if (mainClassName.toLowerCase().endsWith(".class")) 
      {
        mainClassName = mainClassName.substring(0, mainClassName.length()-6);
      }

      InputStream propStream;

      projectProps = new Properties();

      propStream = getClasspathStream("jump.properties");
      if (propStream != null)
        projectProps.load(propStream);

      propStream = getClasspathStream(mainClassName.replace('.', File.separatorChar) + ".jump");
      if (propStream == null)
      {
        // PMD 2.1.7 always check without package name too
        int basepos = mainClassName.lastIndexOf('/');
        if  ( basepos < 0 )
          basepos = mainClassName.lastIndexOf('.');
        if  ( basepos >= 0 )
          propStream = getClasspathStream(mainClassName.substring(basepos+1) + ".jump");
      }
      if (propStream != null)
        projectProps.load (propStream);

      codeOptions = new CodeOptions(args, projectProps);

      // Javac = new String(projectProps.getProperty("javac", "javac"));
      // Pila = new String(projectProps.getProperty("pila", "pila"));
      
      System.out.println("Compiling class " + mainClassName);

      String opts = codeOptions.toString();
      while ( opts.length() > 79 )
      {
        int pos = opts.substring(0,79).lastIndexOf(',')+1;
        if ( pos <= 0 )
          pos = opts.length();
        System.out.println(opts.substring(0,pos));
        opts = "             " + opts.substring(pos);
      }
      System.out.println(opts);

      if (codeOptions.memoryModel == CodeOptions.HUGE &&
        (!codeOptions.checkBounds || !codeOptions.checkNull) )
      {
        System.out.println();
        System.out.println(" **************************************");
        System.out.println(" ***    HIGH RISK OF DATA LOSS      ***");
        System.out.println(" ***     Memory Model 'Huge'.       ***");
        System.out.println(" *** Make sure code has been tested ***");
        System.out.println(" ***  with null pointer and bounds  ***");
        System.out.println(" ***       checking enabled.        ***");
        System.out.println(" **************************************");
        System.out.println();
      }

      // new for 2.1.6, asm file does have to go in path of main class package
      String mainClassBasename = mainClassName;
      if ( !codeOptions.asmPathUsesPackage )
      {
        int basepos = mainClassBasename.lastIndexOf('/');
        if  ( basepos >= 0 )
          mainClassBasename = mainClassBasename.substring(basepos+1);
      }
      backEnd = new AsmBackEnd (mainClassBasename, null);

      mainClass = Klass.forName(mainClassName);
      MethodInfo mainMethod;
      if ((mainMethod = mainClass.findMethod("PilotMain", "(III)I")) != null)
      {
        mainMethod.markNeeded ("PilotMain",JavaElement.NEEDED);
      }

      if (codeOptions.wabajump)
      {
        Klass jumpAppClass = Klass.forName("waba/sys/JumpApp");

        mainClass.markNeeded("wabastart", JavaElement.INSTANCE_NEEDED);
        mainClass.findMethod("<init>","()V")
          .markNeeded("wabastart", JavaElement.NEEDED);
        
        jumpAppClass.markNeeded("wabastart", JavaElement.INSTANCE_NEEDED);
        jumpAppClass.findMethod("<init>","(Lwaba/ui/MainWindow;)V")
          .markNeeded("wabastart", JavaElement.NEEDED);
        jumpAppClass.findMethod("start","()V")
          .markNeeded("wabastart", JavaElement.NEEDED);
      }
      else
      {
        mainClass.findMethod("PilotMain", "(III)I")
          .markNeeded ("PilotMain",JavaElement.NEEDED);
      }

      // mark classes that are required to be treated as
      // having instances. This is useful for Class.newInstance
      String instancelist = (Jump.projectProps.getProperty ("jump-instances", "") +
        " " + Jump.projectProps.getProperty ("instances", ""));

      if (Jump.codeOptions.verbosity >= 1) 
        System.out.println("Instances required for " + instancelist);

      StringTokenizer stn = new StringTokenizer(instancelist);
      while (stn.hasMoreTokens()) 
      {
        Klass cls = Klass.forName( stn.nextToken() );
        cls.markNeeded("instances", JavaElement.INSTANCE_NEEDED);
        cls.propertySaysHasInstance = true;
      }
      stn = null;

      do 
      {
        newNeeds = false;
        Klass.updateAll();
        backEnd.updateAll();
      } while (newNeeds);

      Klass.assignAllClassIndices();
      Klass.layoutFieldsAll();
      Klass.layoutVtableAll();
      Klass.layoutItableAll();

      if (codeOptions.verbosity > 0) 
      {
        Klass.reportAll();
      }

      JumpStatistics stat = new JumpStatistics();
      for (int i=0; i<Klass.ClassList.size(); i++) 
      {
        Klass cl = (Klass) Klass.ClassList.elementAt(i);
        stat.addClass (cl);
        if (cl.methods != null) 
        {
          for (int j=0; j<cl.methods.length; j++) 
          {
            stat.addMethod (cl.methods[j]);
          }
        }
      }
      stat.report();

      // generate target output here
      backEnd.generate();

      if ( codeOptions.usePeephole )
      {
        // System.out.println("\n\nPeephole optimization pass...");
        Peephole.process( mainClassBasename );
      }

      if ( codeOptions.useGNUAsm )
      {
        // System.out.println("\n\nPila to GAS conversion pass...");
        Pila2gas.process(mainClassBasename, true);
      }

      System.out.println();
    } 
    catch (Throwable e) 
    {
      System.err.println ("Exception encountered while operating on " + 
        currentElement);
      e.printStackTrace();
      System.exit(1);
    }
    System.exit(0);
  }
}
