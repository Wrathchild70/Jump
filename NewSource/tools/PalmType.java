// added CharArray for 2.1.4

package tools;

import java.io.*;
import java.util.*;

class PalmTypeJavaLangString extends PalmTypeJavaLang
{
  PalmTypeJavaLangString()
  {
    super("String");
  }

  String getRetReg(){ return "a0";}

  boolean printParamASM(PrintWriter aout, int [] paramIndex,
    int [] psize, Vector proxies)
  {
    int i=paramIndex[0];
    aout.println("\tmove.l\t" + (8+4*i) + "(a6),-(a7)");
    aout.println("\tbsr.far\tgetvoidptr");
    aout.println("\tmove.l\ta0,(a7)");
    psize[0] += 4;
    paramIndex[0]++;
    return true;
  }

  boolean printRetASM(PrintWriter aout)
  {
    aout.println("\tbsr.far\tCharPtr_to_String");
    return true;
  }
}

class PalmTypeJavaLangStringPlus extends PalmTypeJavaLang
{
  PalmTypeJavaLangStringPlus()
  {
    super("String");
  }

  String getJava(String paramName)
  {
    return jType + " " + paramName + ", int _" + paramName + "_off";
  }

  String getJavaSig()
  {
    return jSig + "I";
  }

  String getRetReg(){ return "a0";}

  boolean printParamASM(PrintWriter aout, int [] paramIndex,
    int [] psize, Vector proxies)
  {
    int i=paramIndex[0];
    aout.println("\tmove.l\t" + (8+4*(i+1)) + "(a6),-(a7)");

    // This gets the data at address (a7) and puts the pointer in
    // in a0 and puts the size(bytes) of the data in d0
    aout.println("\tbsr.far\tgetvoidptr");

    // add the offset to the address
    aout.println("\tadda.l\t" + (8+4*i) + "(a6),a0");
    // Subtract the offset from the size
    aout.println("\tsub.l\t" + (8+4*i) + "(a6),d0");

    // Then it puts the memory address on the stack
    aout.println("\tmove.l\ta0,(a7)");
    paramIndex[0] = i+2;
    psize[0] += 4;
    return true;
  }

  boolean printRetASM(PrintWriter aout)
  {
    aout.println("\tbsr.far\tCharPtr_to_String");
    return true;
  }
}

class PalmTypeJavaLangStringBuffer extends PalmTypeJavaLang
{
	PalmTypeJavaLangStringBuffer()
	{
		super("StringBuffer");
	}

	boolean needsParamPostProcessing(){ return true; }
}

class PalmTypeJavaLang extends PalmTypePtr
{
	PalmTypeJavaLang(String className)
	{
		super(className, "Ljava/lang/" + className + ";");
	}
}

class PalmTypePalmosCharPtrArray extends PalmTypePalmos
{
	PalmTypePalmosCharPtrArray()
	{
		super("CharPtrArray");
	}

	boolean printParamASM(PrintWriter aout, int [] paramIndex,
						  int [] psize, Vector proxies)
	{
		int i = paramIndex[0];
		aout.println("\tmove.l\t" + (8+4*i) + "(a6),a0");
		aout.println("\tmove.l\t(a0),-(a7)");
		psize[0] += 4;
		paramIndex[0]++;
		return true;
	}
}

class PalmTypePalmos extends PalmTypePtr
{
	PalmTypePalmos(String className)
	{
		super(className, "Lpalmos/" + className + ";");
	}
}

class PalmTypePtr extends PalmType
{
  boolean isConst = false;

	PalmTypePtr(String javaType, String javaSig)
	{
		super(javaType, javaSig);
		if( !(pSig.startsWith("L") || pSig.startsWith("[")) )
    {
			throw new RuntimeException(
        "Trying to use PalmTypePtr for a type that" +
				" isn't a ptr.  Must be L's or ['s" );
		}
	}

  boolean printParamASM(PrintWriter aout, int [] paramIndex,
    int [] psize, Vector proxies)
  {
    int i = paramIndex[0];
    boolean needvoidptr = jSig.charAt(0) == '[' ||
      jSig.equals("Ljava/lang/String;") ||
      jSig.equals("Ljava/lang/StringBuffer;") ||
      jSig.equals("Ljava/lang/Object;");
    aout.println("\tmove.l\t" + (8+4*i) + "(a6),-(a7)");
    psize[0] += 4;
    if ( !isConst || needvoidptr )
    {
      if ( !needvoidptr )
        aout.println("#ifdef DM_HEAP");
      aout.println("\tbsr.far\tgetvoidptr");
    }
    if ( !isConst )
    {
      aout.println("\tproxy.get");
      proxies.add(new Integer(-psize[0]));
    }
    if ( !isConst || needvoidptr )
    {
      aout.println("\tmove.l\ta0,(a7)");
      if ( !needvoidptr )
        aout.println("#endif");
    }
    paramIndex[0]++;
    return true;
  }

  void setConst(boolean isConst)
  {
    this.isConst = isConst;
  }

	/*
	 * If there is a pointer type that can be returned
	 * this function should be overridden with code
	 * that does the correct wrapping
	 */
	boolean printRetASM(PrintWriter aout)
	{
		// we should wrap the result into a Jump Object
		throw new RuntimeException(
      "wrapping of a PalmOS " + pSig +
			" into a Java " + jSig +
			" not implemented." );
		// return false;
	}

	String getRetReg()
	{
		// we should wrap the result into a Jump Object
		throw new RuntimeException(
      "wrapping of a PalmOS " + pSig +
			" into a Java " + jSig +
			" not implemented." );

		// return null;
	}
}

class PalmTypeByte extends PalmTypeSimple
{
	PalmTypeByte()
	{
		super("int", "I", "B");
	}

	/*
	 * this is a special byte case as a parameter
	 * it appears as an int
	 * as a return value it appears as a byte
	 */
	String getRetJava(){ return "byte"; }
	String getRetJavaSig(){ return "B"; }
}

class PalmTypeBool extends PalmTypeSimple
{
	PalmTypeBool()
	{
    // super("boolean", "Z", "S");  // this has endian problems

    // treat boolean as byte for parameter purposes
    super("boolean", "Z", "Z");   // PMD/RCM 05 Feb 2002
  }

	/*
	 * this is a special boolean case
	 * to the java world it always looks like a boolean
	 * but for that to happen it needs to be translated
	 * when it is a ret value passed back
	 */
	boolean printRetASM(PrintWriter aout)
	{
		aout.println("\ttst.b\td0");
		aout.println("\tsne.b\td0");
		aout.println("\tand.l\t#1,d0");
		return true;
	}
}

class PalmTypeHandle extends PalmTypeSimple
{
	/*
	 *  This will get treated by the PalmType functions
	 *  as an int.  But if it returned then it must
	 *  be moved from the address reg
	 */
	PalmTypeHandle()
	{
		super("int", "I");
	}

	/*
	 * The palm function returns an address,
	 * but we turn it into an int
	 */
	boolean printRetASM(PrintWriter aout)
	{
		aout.println("\tmove.l\ta0,d0");
		return true;
	}
}

class PalmTypeObjHandle extends PalmTypeJavaLang
{
	/*
	 *
	 * This is a special case
	 *  the input (param) goes in as a Ljava/lang/Object
	 * the output (ret) comes out as a int in the address reg
	 *   (like a HANDLE)
	 * so we need to extend the return asembly and java sig code
	 * This is weird of course, becuase it means you can't pass the return
	 * value back to the function.
	 */
	PalmTypeObjHandle()
	{
		super("Object");
	}

	String getRetJava(){ return "int"; }
	String getRetJavaSig(){ return "I"; }
	String getRetReg(){ return "d0"; }

	boolean printRetASM(PrintWriter aout)
	{
		/*
		 * Treat this like a handle where the palm function
		 * returns an address, but we turn it into an int
		 */
		aout.println("\tmove.l\ta0,d0");
		return true;
	}
}

class PalmTypeVoid extends PalmType
{
	PalmTypeVoid()
	{
		super("void", "V");
	}

	boolean printParamASM(PrintWriter aout, int [] paramIndex,
						  int [] psize, Vector proxies)
	{
		throw new RuntimeException("Can't have void parameters");
		// return false;
	}

	boolean printRetASM(PrintWriter aout)
	{
		// do nothing
		return true;
	}

	String getRetReg(){ return "";}
}

class PalmTypeArray extends PalmTypePtr
{
	String arrayType = null;
	int elementSize = 1;
	// {"ByteArray",        "byte[]",        "[B"},
	// This will handle byte and object arrays
	// it is only meant to be used as a param type
	PalmTypeArray(String type, String javaSig)
	{
		super(type + " []", "[" + javaSig);
		arrayType = javaSig;
		if(arrayType.equals("S")){
			elementSize = 2;
		} else if(arrayType.equals("I")){
			elementSize = 4;
		}
	}

	String getJava(String paramName)
	{
		return jType + " " + paramName + ", int _" + paramName + "_off";
	}

	String getJavaSig()
	{
		return jSig + "I";
	}

	boolean printParamASM(PrintWriter aout, int [] paramIndex,
						  int [] psize, Vector proxies)
	{
		int i = paramIndex[0];
		if (arrayType.equals("B") || arrayType.equals("S") ||
			arrayType.equals("I") || arrayType.equals("C") ||
      arrayType.equals("C"))
    {
			aout.println("\tmove.l\t" + (8+4*(i+1)) + "(a6),-(a7)");

			// This gets the data at address (a7) and puts the pointer in
			// in a0 and puts the size(bytes) of the data in d0
			aout.println("\tbsr.far\tgetvoidptr");
			// Add the offset
			if(elementSize > 1){
				aout.println("\tmove.l\t" + (8+4*i) + "(a6),d1");
				// multiply by the offset size
				aout.println("\tmulu.w\t#" + elementSize + ",d1");
				// add the offset to the address
				aout.println("\tadda.l\td1,a0");
				// subtract the offset form the size
				aout.println("\tsub.l\td1,d0");
			} else {
				// add the offset to the address
				aout.println("\tadda.l\t" + (8+4*i) + "(a6),a0");
				// Subtract the offset from the size
				aout.println("\tsub.l\t" + (8+4*i) + "(a6),d0");
			}

      paramIndex[0] = i+2;
      psize[0] += 4;
      
      // This gets the memory at address a0 with size d0
      if ( !isConst )
      {
        aout.println("\tproxy.get");
        proxies.add(new Integer(-psize[0]));
      }

			// Then it puts the memory address on the stack
			aout.println("\tmove.l\ta0,(a7)");
			return true;
		} else {
			return super.printParamASM(aout, paramIndex, psize, proxies);
		}
	}
}

class PalmTypeSimple extends PalmType
{
	PalmTypeSimple(String javaType, String javaSig, String palmSig)
	{
		super(javaType, javaSig, palmSig);
	}

	PalmTypeSimple(String javaType, String javaSig)
	{
		super(javaType, javaSig, javaSig);
	}

	boolean printParamASM(PrintWriter aout, int [] paramIndex,
						  int [] psize, Vector proxies)
	{
		int i = paramIndex[0];
		if (pSig.equals("I") ||	pSig.equals("F"))
    {
			aout.println("\tmove.l\t" + (8+4*i) + "(a6),-(a7)");
			psize[0] += 4;
			paramIndex[0]++;
			return true;
		}
    else if (pSig.equals("S") || pSig.equals("S+"))
    {
			aout.println("\tmove.w\t" + (8+4*i+2) + "(a6),-(a7)");
			psize[0] += 2;
			paramIndex[0]++;
			return true;
		}
    else if (pSig.equals("B") || pSig.equals("B+") ||
				     pSig.equals("C") ||  pSig.equals("Z"))
    {
			aout.println("\tmove.b\t" + (8+4*i+3) + "(a6),-(a7)");
			psize[0] += 2;
			paramIndex[0]++;
			return true;
		}
    else
			return false;
	}

	boolean printRetASM(PrintWriter aout)
	{
		String pRetSig = pSig;

		if (pRetSig.equals("Z")) {
			// Note that so far this Z isn't used because
			// the bool type handles all existing
			aout.println("\ttst.b\td0");
			aout.println("\tsne.b\td0");
			aout.println("\tand.l\t#1,d0");
		} else if (pRetSig.equals("C")) {
			aout.println("\tand.l\t#$ff,d0");
		} else if (pRetSig.equals("B")) {
			aout.println("\text.w\td0");
			aout.println("\text.l\td0");
		} else if (pRetSig.equals("B+")) {
			aout.println("\tand.l\t#$ff,d0");
		} else if (pRetSig.equals("S")) {
			aout.println("\text.l\td0");
		} else if (pRetSig.equals("S+")) {
			aout.println("\tand.l\t#$ffff,d0");
		} else if (pRetSig.equals("I")) {
			// nothing
		}  else if (pRetSig.equals("I+")) {
			// nothing
		} else {
			return false;
		}

		return true;
	}

	String getRetReg(){return "d0";}
}

public abstract class PalmType
{
  // watch out for params that are unsigned.  the current code treats them as signed
  final static PalmTypeSimple INT32 = new PalmTypeSimple("int", "I");
  final static PalmTypeSimple USHORT16 = new PalmTypeSimple("int", "I", "S+");
  final static PalmTypeSimple SHORT16 = new PalmTypeSimple("int", "I", "S");
  final static PalmTypeSimple BYTE8 = new PalmTypeSimple("int", "I", "B");
  final static PalmTypeSimple UBYTE8 = new PalmTypeSimple("int", "I", "B+");
  final static PalmTypeSimple CHAR = new PalmTypeSimple("char", "C", "S");

  final static PalmTypeHandle HANDLE = new PalmTypeHandle();
  final static PalmTypeObjHandle OBJ_HANDLE = new PalmTypeObjHandle();

  final static PalmTypePalmos SHORT_HOLDER = new PalmTypePalmos("ShortHolder");
  final static PalmTypePalmos INT_HOLDER = new PalmTypePalmos("IntHolder");

  // DEPRECIATED TYPES
  final static PalmTypeJavaLang OLD_BOOL = new PalmTypeJavaLang("Boolean");
  final static PalmTypeJavaLang OLD_INT = new PalmTypeJavaLang("Integer");
  final static PalmTypeJavaLang OLD_SHORT = new PalmTypeJavaLang("Short");
  final static PalmTypeJavaLang OLD_BYTE = new PalmTypeJavaLang("Byte");

  static Object XLATE[][] =
    {
      {"BitmapPtr", HANDLE},
      {"Boolean",              new PalmTypeBool()},
      {"Boolean*",             new PalmTypePalmos("BoolHolder"), OLD_BOOL},
      {"BooleanPtr",           new PalmTypePalmos("BoolHolder"), OLD_BOOL},
      {"Byte",  new PalmTypeByte()},
      {"ByteArray",            new PalmTypeArray("byte", "B")},
      {"CharArray",            new PalmTypeArray("char", "C")},
      {"CharBuf",              new PalmTypeJavaLangStringBuffer()},
      {"CharPtr",              new PalmTypeJavaLangString()},
      {"CharPtr+",             new PalmTypeJavaLangStringPlus()},
      {"ClipboardFormatType", BYTE8},
      {"ColorTablePtr",  OBJ_HANDLE},
      {"ControlPtr",  HANDLE},
      {"Coord", SHORT16},
      {"CoordPtr",  SHORT_HOLDER},
      {"DWord", INT32},
      {"DWord*", INT_HOLDER, OLD_INT},
      {"DWordPtr", INT_HOLDER, OLD_INT},
      {"DateFormatType", BYTE8},
      {"DatePtr",              new PalmTypePalmos("Date")},
      {"DateTimePtr",          new PalmTypePalmos("DateTime")},
      {"DateType", SHORT16},
      {"DaySelectorPtr",       new PalmTypePalmos("DaySelector")},
      {"DirectionType", BYTE8},
      {"DmOpenRef", HANDLE},
      {"DmOpenRef*", INT_HOLDER, OLD_INT},
      {"DmSearchStatePtr",     new PalmTypePalmos("DmSearchState")},
      {"Err", SHORT16},
      {"Err*", SHORT_HOLDER},
      {"ErrPtr", SHORT_HOLDER},
      {"EventPtr",             new PalmTypePalmos("Event")},
      {"FieldAttrPtr",         new PalmTypePalmos("FieldAttr")},
      {"FieldPtr", HANDLE},
      {"FileInfoTypePtr",        new PalmTypePalmos("FileInfoType")},
      {"FileRef", INT32},
      {"FileRefPtr", INT_HOLDER, OLD_INT },
      {"FindParamsPtr",        new PalmTypePalmos("FindParams")},
      {"FloatPtr",             new PalmTypePalmos("FloatHolder")},
      {"FontID", UBYTE8},
      {"FontPtr",  HANDLE},
      {"FormEventHandlerPtr",  new PalmTypePalmos("FormEventHandler")},
      {"FormObjectKind", UBYTE8},
      {"FormPtr", HANDLE},
      {"FrameType", SHORT16},
      {"GrfMatchInfoPtr",      new PalmTypePalmos("GrfMatchInfo")},
      {"Handle", HANDLE},
      {"Handle*", INT_HOLDER, OLD_INT},
      {"Int", SHORT16},
      {"Int*", SHORT_HOLDER, OLD_SHORT},
      {"Int8", BYTE8},
      {"Int16", SHORT16},
      {"Int32", INT32},
      {"IntArray",             new PalmTypeArray("int", "I")},
      {"IntPtr", SHORT_HOLDER, OLD_SHORT},
      {"ListPtr", INT32},
      {"LocalID", INT32},
      {"LocalID*", INT_HOLDER, OLD_INT},
      {"LocalIDKind", UBYTE8},
      {"Long", INT32},
      {"MenuBarPtr", HANDLE},
      //	 {"NetHostInfoPtr", 	new PalmTypePalmos("NetHostInfoType")},
      //	 {"NetHostInfoBufPtr", 	new PalmTypePalmos("NetHostInfoBufType")},
      {"NetIPAddr", INT32},
      {"NetSocketAddrEnum", UBYTE8},		// most enumerations are a single byte size
      {"NetSocketAddrTypePtr", 	new PalmTypePalmos("NetSocketAddrType")},
      {"NetSocketOptEnum", USHORT16},
      {"NetSocketOptLevelEnum", USHORT16},
      {"NetSocketRef", SHORT16},
      {"NetSocketTypeEnum", UBYTE8},
      {"PointType*",           new PalmTypePalmos("PointType")},
      {"Ptr", OBJ_HANDLE},
      {"RGBColorTypePtr",      new PalmTypePalmos("RGBColor")},
      {"RectanglePtr",         new PalmTypePalmos("Rectangle")},
      {"SWord", SHORT16},
      {"SWord*", SHORT_HOLDER, OLD_SHORT},
      {"SWordPtr", SHORT_HOLDER, OLD_SHORT},
      {"ScrOperation", BYTE8},
      {"ScrollBarPtr", HANDLE},
      {"SerSettingsPtr",       new PalmTypePalmos("SerSettings")},
      {"ShortArray",           new PalmTypeArray("short", "S")},
      {"SlkPktHeaderPtr",      new PalmTypePalmos("SlkPktHeader")},
      {"SlkSocketListenPtr",   new PalmTypePalmos("SlkSocketListenPtr")},
      {"SlkWriteDataPtr",      new PalmTypePalmos("SlkWriteData")},
      {"SndCommandPtr",        new PalmTypePalmos("SndCommand")},
      {"SndSysBeepType", BYTE8},
      {"SrmOpenConfigPtr",     new PalmTypePalmos("SrmOpenConfig")},
      {"SysBatteryKind*", SHORT_HOLDER, OLD_SHORT},
      {"SystemPreferencesPtr", new PalmTypePalmos("SystemPreferences")},
      {"TableDrawItemFuncPtr",  new PalmTypePalmos("TableDrawItemHandler")},
      {"TableItemStyleType", BYTE8},
      {"TableLoadDataFuncPtr",  new PalmTypePalmos("TableLoadDataHandler")},
      {"TablePtr", INT32},
      {"TableSaveDataFuncPtr",  new PalmTypePalmos("TableSaveDataHandler")},
      {"TimePtr",          new PalmTypePalmos("Time")},
      {"TimeFormatType",  BYTE8},
      {"UBytePtr",             new PalmTypePalmos("ByteHolder"), OLD_BYTE},
      {"UInt", USHORT16},
      {"UInt8", UBYTE8},
      {"UInt16", USHORT16},
      {"UInt32", INT32},
      {"UIntPtr", SHORT_HOLDER, OLD_SHORT},
      {"ULong", INT32},
      {"ULongPtr", INT_HOLDER, OLD_INT},
      {"UnderlineModeType", UBYTE8},
      {"VoidHand", HANDLE},
      {"VoidHand*", INT_HOLDER, OLD_INT},
      {"VoidPtr", OBJ_HANDLE},
      {"WakeupHandlerProcPtr",  new PalmTypePalmos("WakeupHandler")},
      {"WinHandle", HANDLE},
      {"WinPtr", HANDLE},
      {"WindowFormatType", BYTE8},
      {"WinScreenAttrType", UBYTE8 },
      {"Word", USHORT16},
      {"WordPtr", SHORT_HOLDER, OLD_SHORT},
      {"byte", BYTE8},
      {"char", CHAR},
      {"char**",   			new PalmTypePalmosCharPtrArray()},
      {"int", SHORT16},
      {"int*", SHORT_HOLDER, OLD_SHORT},
      {"short", SHORT16},
      {"shortPtr", SHORT_HOLDER, OLD_SHORT},
      {"void",                 new PalmTypeVoid() },
      {"void*", OBJ_HANDLE},
      {"voidptr", HANDLE},
	 
      // Added RCM 7/22/02
      {"JustificationType", BYTE8},
      {"Enum", UBYTE8},				// generic enumeration type.
      {"KeyboardType", UBYTE8},		// most enumerations are a single byte size
      {"Int16Ptr", SHORT_HOLDER, OLD_SHORT},
      {"UInt16Ptr", SHORT_HOLDER, OLD_SHORT},
      // Added RCM 11/5/02 for Symbol barcode scanner support
      // {"SymbolMessagePtr", new PalmTypePalmos("SymbolMessage")},
      {"SymbolComm", new PalmTypePalmos("SymbolComm")}
	 
    };

  public static PalmType getType(String name)
  {
    int index = -1;
    for (int i=0; i<XLATE.length; i++) 
    {
      String curName = (String)(XLATE[i][0]);
      if (curName.equals(name)) 
      {
        return (PalmType)XLATE[i][1];
      }
    }
    return null;
  }

  public static void addType(String name, String javaName, String javaSig)
  {
    Object[][] xlat = new Object[XLATE.length+1][];
    System.arraycopy(XLATE, 0, xlat, 0, XLATE.length);
    xlat[XLATE.length] = new Object[] { name, new PalmTypePtr(javaName, "L"+javaSig+";") };
    XLATE = xlat;
  }

  public static ParamInfo getParamFromType(String name, boolean isConst)
  {
    ParamInfo param = new ParamInfo();
    param.isConst = isConst;
    int index = -1;
    for (int i=0; i<XLATE.length; i++) 
    {
      String curName = (String)(XLATE[i][0]);
      if (curName.equals(name)) 
      {
        index = i;
        break;
      }
    }
    if(index == -1) return null;
    param.type =  (PalmType)XLATE[index][1];
    param.type.setConst(isConst);
    if(XLATE[index].length > 2)
    {
      param.depType = (PalmType)XLATE[index][2];
      param.hasDepType = true;
    } 
    else 
    {
      param.depType = param.type;
      param.hasDepType = false;
    }
    return param;
  }

  String jType = null;
  String jSig = null;
  String pSig = null;

  PalmType(String javaType, String javaSig, String palmSig)
  {
    jType = javaType;
    jSig = javaSig;
    pSig = palmSig;
  }

  PalmType(String javaType, String javaSig)
  {
    this(javaType, javaSig, javaSig);
  }

  void setConst(boolean b) {};

  String getJava(String paramName)
  {
    return jType + " " + paramName;
  }

  String getRetJava(){ return jType; }
  String getJavaSig(){ return jSig; }
  String getRetJavaSig() { return jSig; }
  String getPalmSig(){ return pSig; }
  public String toString()
  {
    return super.toString() + " jType: " + jType + " jSig: " + jSig + " pSig: " + pSig;
  }

  boolean needsParamPostProcessing(){ return false; }

  abstract String getRetReg();

  abstract boolean printParamASM(PrintWriter aout, int [] paramIndex,
    int [] psize, Vector proxies);

  abstract boolean printRetASM(PrintWriter aout);
}
