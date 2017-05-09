package tools;

import java.io.*;
import java.util.*;

class MkApi {
  /** Version of MkApi */
  static final String MKAPI_VERSION = "MkApi for Jump 2.2.2";

  static String className   = "Palm";
  static String packageName = "palmos";
  static String apiFile     = "tools/palmos.api";
  static String asmFile     = "native-palmos.asm";
  static String includeFile = "../jar/jump.inc";
  static double minOsVersion = 0.0;
  static double maxOsVersion = 9.9;

  /** Use to check include file defines trap name */
  static Hashtable defines;

  public static void writeHeaderJOut(PrintWriter jout)
  {
    jout.println("/** Get memory location as an int. */"); 
    jout.println("public static native int nativeGetInt(int palmMemPtr);"); 

    jout.println("/** Get memory location as an short. */"); 
    jout.println("public static native int nativeGetShort(int palmMemPtr);");

    jout.println("/** Get memory location as an byte. */"); 
    jout.println("public static native int nativeGetByte(int palmMemPtr);");

    jout.println("/** Lock object and return address as int.\n" +
      " * When using the 'huge' memory model the returned pointer is proxy object\n" +
      " * which can be used for Palm OS calls. Unlocking the object with nativeOvjectUnlock\n" +
      " * copies the proxy back to the original object. */"); 
    jout.println("public static native int nativeObjectLock(Object obj);");

    jout.println("/** Return address of object as int. */"); 
    jout.println("public static native int nativeObjectAddress(Object obj);");


    jout.println("/** Set memory location as an int. */"); 
    jout.println("public static native void nativeSetInt(int palmMemPtr, int val);");

    jout.println("/** Set memory location as an short. */"); 
    jout.println("public static native void nativeSetShort(int palmMemPtr, short val);");

    jout.println("/** Set memory location as an byte. */"); 
    jout.println("public static native void nativeSetByte(int palmMemPtr, byte val);");

    jout.println("/** Lock object locked by nativeObjectLock. */"); 
    jout.println("public static native void nativeObjectUnlock(Object obj);");
  }

  public static void writeHeaderAOut(PrintWriter aout)
  {
    aout.println(";; native-method palmos/Palm.nativeGetInt(I)I");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t8(a6),a0");
    aout.println("\tmove.l\t(a0),d0");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeGetShort(I)I");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t8(a6),a0");
    aout.println("\tmove.w\t(a0),d0");
    aout.println("\text.l\td0");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeGetByte(I)I");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t8(a6),a0");
    aout.println("\tmove.b\t(a0),d0");
    aout.println("\text.w\td0");
    aout.println("\text.l\td0");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeObjectLock(Ljava/lang/Object;)I");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t8(a6),-(a7)");
    aout.println("\tbsr.far\tgetvoidptr");
    // this should put the object pointer in a0
    aout.println("\tproxy.get");
    aout.println("\tmove.l\ta0,d0");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeObjectAddress(Ljava/lang/Object;)I");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t8(a6),-(a7)");
    aout.println("\tbsr.far\tgetvoidptr");
    aout.println("\tmove.l\ta0,d0");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeObjectLock(Ljava/lang/Object;)I");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t8(a6),-(a7)");
    aout.println("\tbsr.far\tgetvoidptr");
    // this should put the object pointer in a0
    aout.println("\tmove.l\ta0,d0");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeSetInt(II)V");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t12(a6),a0");
    aout.println("\tmove.l\t8(a6),(a0)");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeSetShort(IS)V");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t12(a6),a0");
    aout.println("\tmove.w\t10(a6),(a0)");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeSetByte(IB)V");
    aout.println("\tlink\ta6,#0");
    aout.println("\tmove.l\t12(a6),a0");
    aout.println("\tmove.b\t11(a6),(a0)");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

    aout.println(";; native-method palmos/Palm.nativeObjectUnlock(Ljava/lang/Object;)V");
    aout.println("\tlink\ta6,#0");
    aout.println("#ifdef DM_HEAP");
    aout.println("\tmove.l\t8(a6),a0");
    aout.println("\tproxy.release");
    aout.println("#endif");
    aout.println("\tunlk\ta6");
    aout.println("\trts");
    aout.println("");

  }

  static void processFile() throws IOException
  {
    PrintWriter aout = new PrintWriter(new BufferedWriter(new FileWriter(asmFile)));
    BufferedReader in = new BufferedReader (new FileReader (new File (apiFile)));
    PrintWriter jout = new PrintWriter (new BufferedWriter
      (new FileWriter(new File (packageName, className+".java"))));

    double  currentOsVersion = 0.0;
    String requirements = null;
    boolean include = true;

    Vector javadoc = new Vector();

    System.out.println( className );
    aout.println( "; Created by "+MKAPI_VERSION  );
    
    jout.println("package "+packageName+";");
    jout.println();
    jout.println( "/** Created by "+MKAPI_VERSION+" */"  );
    jout.println("public class "+className+" {");
    // don't include the nativeGetXXX() nativeSetXXX() methods
    // uless we are building palmos/Palm.java
    if ( packageName.equals("palmos") && className.equals("Palm") )
    {
      writeHeaderJOut(jout);
      writeHeaderAOut(aout);
    }
    while (true) 
    {

      boolean addDeprecatedVersion = false;

      String s = in.readLine();
      if (s == null) 
      {
        break;
      }
      if (s.length() == 0 || s.charAt(0) == '/') 
      {
        continue;
      }
      if (s.startsWith("public ")) 
      {
        while (true) 
        {
          jout.println(s);
          if (s.charAt(0) == '}') 
          {
            break;
          }
          s = in.readLine();
        }
        continue;
      }
      StringTokenizer st = new StringTokenizer (s, "(), \t");

      // ======== analyze input line (one API function) ========

      // --- return type ---

      String rettype = st.nextToken();

      // check for lines of the form
      // PalmOS 3.1
      if ( rettype.equalsIgnoreCase("PalmOS") )
      {
        currentOsVersion = Double.parseDouble(st.nextToken());
        include = currentOsVersion >= minOsVersion && currentOsVersion <= maxOsVersion;
        requirements = st.hasMoreElements() ? st.nextToken("") : null;
        continue;
      }
      else if ( rettype.equalsIgnoreCase("java") )
      {
        while ( true )
        {
          s = in.readLine();
          if ( s == null )
          {
            System.err.println("ERROR: end of input file while processing 'java' section");
            System.exit(1);
          }
          if ( s.toLowerCase().startsWith("endjava") )
            break;
          if ( include )
            jout.println( s );
        }
        continue;
      }
      else if ( rettype.equalsIgnoreCase("asm") )
      {
        while ( true )
        {
          s = in.readLine();
          if ( s == null )
          {
            System.err.println("ERROR: end of input file while processing 'asm' section");
            System.exit(1);
          }
          if ( s.toLowerCase().startsWith("endasm") )
            break;
          if ( include )
            aout.println( s );
        }
        continue;
      }
      else if ( rettype.equalsIgnoreCase("struct") )
      {
        // PMD 2.1.7 added struct definitions in api file
        String name = st.nextToken();
        if ( !st.nextToken().equals("=") )
        {
          System.err.println("ERROR: syntax error: equals expected in struct: " + name);
          System.exit(1);
        }
        String javaName = st.nextToken();
        if ( javaName.endsWith(";") )
          javaName = javaName.substring(0,javaName.length()-1);
        PalmType.addType(name,
          javaName.startsWith(packageName+'.') ? javaName.substring(packageName.length()+1) : javaName,
          javaName.replace('.', '/') );
        continue;
      }

      // skip os versions that are not appropriate
      if ( !include )
        continue;

      // accumulate comments for javadoc
      // don't accumulate for entries that are going to be filtered out
      // i.e. test after os version.
      // javadoc entries apply to the definition below
      if ( rettype.equalsIgnoreCase("javadoc") )
      {
        javadoc.add( s.substring(8) );
        continue;
      }

      PalmType retType = PalmType.getType(rettype);

      // --- method name ---

      String methodName = st.nextToken();
      String trapName, selector = null, selector16 = null;

      // PMD 2.1.7 add huge attribute to say that call doesn't
      // require semaphore release/reserve.
      boolean hugeAware = methodName.equalsIgnoreCase("huge") || methodName.equalsIgnoreCase("noproxy");
      if (hugeAware)
        methodName = st.nextToken();

      if (methodName.charAt(0) == '&') 
      {
        methodName = methodName.substring(1);
        trapName = "sysLibTrap"+methodName;
      }
      else
        trapName = "sysTrap"+methodName;

      // report the return type error once we know the method name
      if (retType == null) 
      {
        System.err.println("ERROR: unknown return type (table): " + rettype + " in method " + methodName);
        System.exit(1);
      }

      // --- parameters ---

      Vector params = new Vector();
      while (true) 
      {
        String type = st.nextToken();
        boolean isConst = type.equalsIgnoreCase("const") || type.equalsIgnoreCase("noproxy");

        if ( isConst)
          type = st.nextToken();

        if (type.charAt(0) == ';') 
          break;
        if ( type.equals("=") )
        {
          trapName = st.nextToken();
          if ( trapName.endsWith( ";" ) )
          {
            trapName = trapName.substring(0, trapName.length()-1 );
            break;
          }
          String tok = st.nextToken();
          if ( tok.charAt(0) == ';' )
            break;
          if ( tok.equalsIgnoreCase("selector") || tok.equalsIgnoreCase("selector16") )
          {
            selector = st.nextToken();
            if ( selector.endsWith( ";" ) )
              selector = selector.substring(0, selector.length()-1 );
            else if ( st.nextToken().charAt(0) != ';' )
            {
              System.err.println("ERROR: syntax error: semicolon expected in method: " + methodName);
              System.exit(1);
            }
            if ( tok.equalsIgnoreCase("selector16") )
            {
              selector16 = selector;
              selector = null;
            }
          }
          else
          {
            System.err.println("ERROR: syntax error: semicolon expected in method: " + methodName);
            System.exit(1);
          }
          break;
        }
        
        // PMD 2.1.7 add huge attribute, parameters are implicitly noproxy
        ParamInfo param = PalmType.getParamFromType(type, isConst || hugeAware);

        if (param == null) 
        {
          System.err.println("ERROR: unknown parameter type (table): " + type + " in method " + methodName);
          System.exit(1);
        }

        if(param.hasDepType)
          addDeprecatedVersion = true;

        param.name = st.nextToken();
        params.addElement (param);
      }

      if ( defines != null )
      {
        // verify that the trap is defined
        if ( trapName.charAt(0) > '9' && !defines.containsKey(trapName) )
            System.err.println( "WARNING: No include file definition for "+trapName );
        // verify that the selector is defined
        if ( selector != null && selector.charAt(0) > '9' && !defines.containsKey(selector) )
          System.err.println( "WARNING: No include file definition for "+selector );
        // verify that the selector16 is defined
        if ( selector16 != null && selector16.charAt(0) > '9' && !defines.containsKey(selector16) )
          System.err.println( "WARNING: No include file definition for "+selector16 );
      }

      // ======== write Java ========

      jout.println();
      jout.print("  /** PalmOS SysTrap: " + trapName);
      if ( selector != null )
        jout.print("/" + selector );
      if ( selector16 != null )
        jout.print("/" + selector16 );
      if ( currentOsVersion > 1.0 )
        jout.print(" (<B>PalmOS "+currentOsVersion+"</B>)" );
      jout.println();
      if ( requirements != null )
        jout.println("   * (<B>requires" + requirements + "</B>)");
      jout.println("   *");
      jout.println("   * <P>Defined as: " + s);

      for (Enumeration e = javadoc.elements(); e.hasMoreElements(); )
      {
        Object o = e.nextElement();
        jout.println( "   * " + o.toString() );
      }
      jout.println("   */");


      jout.print("  public native static " + 
        retType.getRetJava() +
        " " + methodName + "(");

      for (int i=0; i<params.size(); i++) 
      {
        ParamInfo param = (ParamInfo) params.elementAt(i);
        if (i>0) 
        {
          jout.print(", ");
        }
        // by Scott
        jout.print(param.type.getJava(param.name));
      }
      jout.println(");");

      if (addDeprecatedVersion && currentOsVersion < 2.0) 
      {
        jout.print("  /** PalmOS SysTrap: " + trapName);
        if ( selector != null )
          jout.print("/" + selector );
        if ( selector16 != null )
          jout.print("/" + selector16 );
        if ( currentOsVersion > 1.0 )
          jout.print(" (<B>PalmOS "+currentOsVersion+"</B>)" );
        jout.println();
        if ( requirements != null )
          jout.println("   * (<B>requires" + requirements + "</B>)");
        jout.println("   *  @deprecated Use the xxxHolder version instead.");
        jout.println("   *");
        jout.println("   * <P>Defined as: " + s);
        for (Enumeration e = javadoc.elements(); e.hasMoreElements(); )
        {
          Object o = e.nextElement();
          jout.println( "   * " + o.toString() );
        }
        jout.println("   */");
  
        jout.print("  public native static " + 
          retType.getRetJava() +
          " " + methodName + "(");

        for (int i=0; i<params.size(); i++) 
        {
          ParamInfo param = (ParamInfo) params.elementAt(i);
          if (i>0) 
          {
            jout.print(", ");
          }
          jout.print(param.depType.getJava(param.name));
        }
        jout.println(");");
      }
      // clear docs ready for next
      javadoc = new Vector();

      // ======== write assembly ========

      String signature = null;
      String deprecatedSignature = null;
      StringBuffer buf = new StringBuffer(packageName+"/"+className+".");

      buf.append(methodName).append("(");
      for (int i=0; i<params.size(); i++) 
      {
        ParamInfo param = (ParamInfo) params.elementAt(i);
        // by Scott
        buf.append(param.type.getJavaSig());
      }
      buf.append (")" + retType.getRetJavaSig());
      signature = buf.toString();

      if (addDeprecatedVersion) 
      {
        buf = new StringBuffer(packageName+"/"+className+".");

        buf.append(methodName).append("(");
        for (int i=0; i<params.size(); i++) 
        {
          ParamInfo param = (ParamInfo) params.elementAt(i);
          buf.append(param.depType.getJavaSig());
        }
        buf.append (")" + retType.getRetJavaSig());
        deprecatedSignature = buf.toString();
      }
      
      // --- write method-declaration comment line ---

      aout.println (";; native-method " + signature);

      // --- write dependency comment lines ---

      Hashtable classesMentioned = new Hashtable();
      for (int i=0; i<params.size(); i++) 
      {
        String psig = ((ParamInfo) params.elementAt(i)).type.getPalmSig();
        if (classesMentioned.get(psig) != null) 
        {
          // don't repeat
        }
        else if (psig.equals ("Ljava/lang/String;") || 
          psig.equals ("Ljava/lang/Object;")) 
        {
        }
        else if (psig.equals ("Ljava/lang/StringBuffer;")) 
        {
          // aout.println (";; uses-field java/lang/StringBuffer.value as StringBuffer_value");
          // aout.println (";; uses-field java/lang/StringBuffer.count as StringBuffer_count");
        }
        else if (psig.charAt(0) == 'L' && !psig.equals("L")) 
        {
          aout.println (";; needs-exact-layout " + 
            psig.substring (1, psig.length()-1));
        }
        classesMentioned.put(psig, Boolean.TRUE);
      }

      // --- write instructions (parameter handling) ---
      
      aout.println("\tlink\ta6,#0");
      int psize = 0;
      Vector proxies = new Vector();
      // by Scott
      int numParams = params.size();
      int [] paramIndexPtr = {0};
      int [] psizePtr = {0};

      for (int i=0; i<numParams; i++) 
      {
        ParamInfo param = (ParamInfo) params.elementAt(numParams-i-1);
        
        if(!param.type.printParamASM(aout, paramIndexPtr, psizePtr, 
          proxies))
        {
          System.err.println("ERROR: unknown parameter type (asm): " + param.type);
          System.exit(1);
        }         

      }

      // release the memory semaphone
      if (!hugeAware)
        aout.println("\tmem.release");

      // some calls use a 8-bit selector in register D2
      if ( selector != null )
        aout.println("\tmoveq.l\t#"+selector+",d2");

      // some calls use a 16-bit selector on the stack
      if ( selector16 != null )
        aout.println("\tmove.w\t#"+selector16+",-(a7)");

      // --- write instructions (systrap call) ---
      aout.println("\ttrap\t#15");
      aout.println("\tdc.w\t" + trapName);

      if (!hugeAware)
        aout.println("\tmem.reserve.savereg");
      
      // --- write instructions (return-value handling) ---
      retType.printRetASM(aout);

      boolean retPushed = false;
      if(!retType.getRetReg().equals(""))
      {
        // need to save the return register because of post-processing?
        for (int i=0; i<params.size(); i++) 
        {
          // I changed this to count up not down.
          ParamInfo param = (ParamInfo) params.elementAt(i);
          if(param.type.needsParamPostProcessing())
          {
            aout.println("\tmove.l\t" + retType.getRetReg() + ",-(a7)");
            retPushed = true;
            break;
          }
        }
      }

      // copy back from proxies
      if (proxies.size() > 0) 
      {
        aout.println("#ifdef DM_HEAP");
        // save the return-value locally inside the #ifdef
        if (!retPushed && !retType.getRetReg().equals("")) 
        {
          aout.println("\tmove.l\t" + retType.getRetReg() + ",-(a7)");
        }
        for (int i=proxies.size()-1; i>=0; i--) 
        {
          aout.println("\tmove.l\t" + proxies.get(i) + "(a6),a0");
          aout.println("\tproxy.release");
        }
        // restore the return-value
        if (!retPushed && !retType.getRetReg().equals("")) 
        {
          aout.println("\tmove.l\t(a7)+," + retType.getRetReg());
        }
        aout.println("#endif");
      }

      // --- CharBuf / StringBuffer post-processing ---
      for (int i=0; i<params.size(); i++) 
      {
        ParamInfo param = (ParamInfo) params.elementAt(params.size()-i-1);
        if (param.type.getRetJavaSig().equals("Ljava/lang/StringBuffer;")) 
        {
          aout.println("\tmove.l\t"+(8+4*i)+"(a6),a1");
/*
          aout.println("\tmove.l\tStringBuffer_value(a1),a0");
          aout.println("\tmove.l\tArray.data(a0),a0");
          aout.println("\tmove.l\ta0,d0");
          aout.println("\tbsr.far\tfindNextNull");
          // rk bugfix - negative StringBuffer count
          aout.println("\tsub.l\td0,a0");
          aout.println("\tmove.l\ta0,StringBuffer_count(a1)");
*/
          aout.println("\tbsr.far\tStringBuffer_setLength");
        }
      }

      if (retPushed) 
      {
        aout.println("\tmove.l\t(a7)+," + retType.getRetReg());
        retPushed = false;
      }

      aout.println("\tunlk\ta6");
      aout.println("\trts");
      String name = className +"." +methodName;
      aout.println("#ifdef DEBUG_SYMBOLS");
      aout.println("\tdc.b\t$80," +name.length() + "\t; Debug Symbol " +name);
      aout.print("\tdc.b\t" +(int)name.charAt(0));
      for (int i=1; i<name.length(); i++)
        aout.print( ","+(int)name.charAt(i) );
      aout.println( (name.length() & 1) != 0 ? ",0" : ",0,0" );
      aout.println("#endif");
      aout.println();

      // --- deprecated version ---
      
      if (addDeprecatedVersion) 
      {
  
        // --- write method-declaration comment line ---
  
        aout.println (";; native-method " + deprecatedSignature);
  
        // --- write dependency comment lines ---

        aout.println (";; uses-method " + signature + " as new_" + methodName);
        for (int i=0; i<params.size(); i++) 
        {
          ParamInfo param = (ParamInfo) params.elementAt(i);
          String psig = param.depType.getPalmSig();

          if (psig.equals ("Ljava/lang/String;") || 
            psig.equals ("Ljava/lang/StringBuffer;") || 
            psig.equals ("Ljava/lang/Object;")) 
          {
          }
          else if (psig.charAt(0) == 'L' && !psig.equals("L")) 
          {
            aout.println (";; needs-exact-layout " + 
              psig.substring (1, psig.length()-1));
          }
        }

        // --- write method body: branch to new version ---
  
        aout.println ("\tbra.far\tnew_" + methodName);
        aout.println();
      }

      System.out.println("  "+methodName);
    }
    jout.println("}");
    jout.close();
    aout.close();
  }

  public static void parseIncDefinitions() throws IOException
  {
    BufferedReader in;
    try
    {
      in = new BufferedReader(new FileReader(new File(includeFile)));
    }
    catch (FileNotFoundException e)
    {
      return;
    }
    defines = new Hashtable();

    while (true) 
    {
      String s = in.readLine();
      if (s == null) 
      {
        break;
      }
      if (s.length() == 0 || s.charAt(0) == ';') 
      {
        continue;
      }
      StringTokenizer st = new StringTokenizer(s, ": \t");
      String label = st.nextToken();
      if ( st.hasMoreTokens() )
      {
        String equ = st.nextToken();
        if ( equ.equals( "equ" ) )
          defines.put( label, "" );
      }
    }
    in.close();
  }
  

  public static void usage()
  {
    System.err.println( "Usage: MkApi [options]" );
    System.err.println();
    System.err.println( "where options are:" );
    System.err.println( "  -a apifile      source file containing method templates" );
    System.err.println( "                     (default tools/palmos.api)" );
    System.err.println( "  -p package      package (directory) used to output Java code (default palmos)" );
    System.err.println( "  -c class        output Java code containing methods (default Palm)" );
    System.err.println( "  -o asmfile      output file containing code for native methods" );
    System.err.println( "                     (default native-palmos.asm)" );
    System.err.println( "  -i includefile  file containing trap definitions (default ../jar/jump.inc)" );
    System.err.println( "  -n              do not check trap definitions again include file" );
    System.err.println( "  -r minOS maxOS  range of  OS level to be extracted from api file" );
    System.err.println( "                     (default 0.0 9.9)" );
    System.exit(1);
  }

  public static void parseOptions( String[] args )
  {
    int optIndex, i;
    for (optIndex=0; optIndex<args.length; optIndex++)
    {
      String arg = args[optIndex].toLowerCase();
      if ( arg.charAt(0) == '-' )
      {
        for (i=1; i<arg.length(); i++)
        {
          try
          {
            switch ( arg.charAt(i) )
            {
              case 'c':   // class
                className = args[++optIndex];
                break;
              case 'p':   // package
                packageName = args[++optIndex];
                break;
              case 'a':   // api file
                apiFile = args[++optIndex];
                break;
              case 'o':   // output file
                asmFile = args[++optIndex];
                break;
              case 'n':   // no include checks
                includeFile = null;
                break;
              case 'i':   // include file
                includeFile = args[++optIndex];
                break;
              case 'r':   // os range
                minOsVersion = Double.parseDouble(args[++optIndex]);
                maxOsVersion = Double.parseDouble(args[++optIndex]);
                break;
              default:
                throw new IndexOutOfBoundsException();
            }
          }
          catch (IndexOutOfBoundsException e)
          {
            System.err.println( "ERROR: command line option -"+arg.charAt(i) );
            System.err.println();
            usage();
          }
        }
      }
      else
      {
        System.err.println( "ERROR: command line option "+args[optIndex] );
        System.err.println();
        usage();
      }
    }
  }
  
  public static void main(String[] args) throws IOException
  {
    System.err.println( MKAPI_VERSION );
    System.err.println();

    parseOptions( args );

    if ( includeFile != null )
      parseIncDefinitions();

    processFile();

    if ( includeFile != null && defines == null )
      System.err.println( "WARNING: trap definitions were not checked: "+includeFile+" not found" );
  }
}
