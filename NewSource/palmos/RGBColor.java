package palmos;

public class RGBColor {
	
	/** Index byte. */
	public byte index;

	/** Red byte. */
	public byte r;

	/** Green byte. */
	public byte g;

	/** Blue byte. */
	public byte b;
	
	/** Define a White reference color. This saves always having to create a color */
	public static RGBColor WHITE = new RGBColor (255,255,255);
	public static RGBColor BLACK = new RGBColor (0,0,0);

	/** Define Palm operations for the Windows Palette for the RGB colors */
	public static byte	winPaletteGet = 0;
	public static byte	winPaletteSet = 1;
	public static byte	winPaletteSetToDefault = 2;
	
	/** Create an black RGBColor. */
	public RGBColor () 
	{
		r = 0; g = 0; b = 0;
		index = (byte) Palm.WinRGBToIndex(this);	
	}

	/** Create an RGBColor from all values. */
	public RGBColor (int r, int g, int b) 
	{
    	this.index = (byte) index;
    	this.r     = (byte) r;
    	this.g     = (byte) g;
    	this.b     = (byte) b;
		this.index = (byte) Palm.WinRGBToIndex(this);	
	    
	}

	/** Create an RGBColor from all values. */
	public RGBColor (int index, int r, int g, int b) 
	{
    	this.index = (byte) index;
    	this.r     = (byte) r;
    	this.g     = (byte) g;
    	this.b     = (byte) b;
	}

}
