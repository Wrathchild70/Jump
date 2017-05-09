package palmos;

/**
 * Structure for Bitmaps in the Palm.<br>
 *
 * This definition correspond to the 'Tbmp' and 'tAIB' resource types
 *
 * [colorTableType] pixels | pixels<br>
 * If hasColorTable != 0, we have:
 * <pre>
 * ColorTableType followed by pixels. 
 * If hasColorTable == 0: this is the start of the pixels
 * If indirect != 0 bits are stored indirectly.
 * the address of bits is stored here
 * In some cases the ColorTableType will
 * have 0 entries and be 2 bytes long.
 * 
 *
 * @author <a href="mailto:rmontrose@avidwireless.com">Rod Montrose</a>
 *
 */
public class Bitmap {
	
	public final static int RESOURCE_TYPE_Tbmp = 0x54626D70;	// String 'Tbmp'
	public final static int RESOURCE_TYPE_tAIB = 0x74414942;	// String 'tAIB'

    /** Bitmap version numbers */
    public final static short BitmapVersionZero = 0;
    public final static short BitmapVersionOne = 1;
    public final static short BitmapVersionTwo = 2;
    
    /** types of bitmap compressions */
    public final static short BitmapCompressionTypeScanLine = 0;
    public final static short BitmapCompressionTypeRLE = 1;
    public final static short BitmapCompressionTypeNone = 0xFF;
    
    // bitfields were counted from wrong end of word PMD Jump 2.1.5
    /** BitmapFlag Constants - these values or ORed together in the field BitmapFlag<br>
     *  Data format:  0=raw; 1=compressed */
    public final static short BITMAPFLAGSTYPE_COMPRESSED = (short)0x8000;
    
    /** if true, color table stored before bits[] */
    public final static short BITMAPFLAGSTYPE_hasColorTable = 0x4000;
  
    /** true if transparency is used */
    public final static short BITMAPFLAGSTYPE_hasTransparency = 0x2000;
 
    /** true if bits are stored indirectly */
    public final static short BITMAPFLAGSTYPE_indirect = 0x1000;
 
    /** system use only */
    public final static short BITMAPFLAGSTYPE_forScreen = 0x0800;
    
    
    /** The struture for Bitmap Flags 
     *  Width of the bitmap */  
    public short width;
    
    /** Bitmap height */
    public short  height;
    
    /** Number of rows bytes */
    public short  rowBytes;
    
    /** See the BITMAPFLAGSTYPEvalues. This is a single 16 bit value and each bit must be
     *  masked off to get the value */
    public short  bitmapFlag;
    
    /** Number of bits/pixel */
    public byte   pixelSize;
    
    /** version of bitmap. This is vers 2 */
    public byte  version;
    
    /** # of DWords to next Bitmap from beginnning of this one */
    public short  nextDepthOffset;
    
    /** v2 only, if flags.hasTransparency is true, index number of transparent color*/
    public byte  transparentIndex;
    
    /** v2 only, if flags.compressed is true, this is the type, see BitmapCompressionType*/
    public byte  compressionType;
    
    /** for future use, must be zero! */
    public short  reserved;
}
