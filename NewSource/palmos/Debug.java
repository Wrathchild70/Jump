package palmos;

public class Debug {
	public native static void breakpoint();

	/**
	 * Called to print a debug line on the top line of the screen
	 *
	 *@param sText A text String to print
	 */	
	public static void write (String sText)
	{
    	Palm.WinDrawChars(sText,sText.length(),0,0);
    	Palm.SysTaskDelay (50); // 500 ms.
	}
}
