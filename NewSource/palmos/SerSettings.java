package palmos;

public class SerSettings {
	/** mask for stop bits field */
	public static final int FlagStopBitsM    = 0x00000001;	
	/** 1 stop bits */
	public static final int FlagStopBits1    = 0x00000000;
	/** 2 stop bits	*/
	public static final int FlagStopBits2    = 0x00000001;
	
	/** mask for parity on*/
	public static final int FlagParityOnM    = 0x00000002;
	/** mask for parity even */
	public static final int FlagParityEvenM  = 0x00000004;
	
	/** mask for Xon/Xoff flow control (NOT IMPLEMENTED) */
	public static final int FlagXonXoffM     = 0x00000008;
	/** mask for RTS rcv flow control */
	public static final int FlagRTSAutoM     = 0x00000010;
	/** mask for CTS xmit flow control */
	public static final int FlagCTSAutoM     = 0x00000020;
	
	/** mask for bits/char */
	public static final int FlagBitsPerCharM = 0x000000c0;
	/** 5 bits/char	*/
	public static final int FlagBitsPerChar5 = 0x00000000;
	/** 6 bits/char	*/
	public static final int FlagBitsPerChar6 = 0x00000040;
	/** 7 bits/char	*/
	public static final int FlagBitsPerChar7 = 0x00000080;
	/** 8 bits/char	*/
	public static final int FlagBitsPerChar8 = 0x000000c0;
	
	/** 
	 * These are additional settings which are used with the SerControl function.
	 * It has the prototype:  
	 * <pre><code>
	 * SerControl(int refNum, int op, Object valueP, ShortHolder valueLenP)
	 * and
	 * SerControl(int refNum, int op, int valueP, int valueLenP) // used for null valueP andvalueLenP
	 * </code></pre>
	 *  You call it like:
	 * <pre><code>
	 * int flag = 
	 * ShortHolder valueLenP = new ShortHolder(0);
	 * int err = Palm.SerControl (iRefNum, flag, null, null);
	 * </code></pre>
	 * Using one of the next values:
	 *<br>
	 * turn RS232 break signal on: users are responsible for ensuring that the break is set
	 * long enough to genearate a valie BREAK! valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlStartBreak = 1;
	
	/**
	 * turn RS232 break signal off: 
	 *<br>
	 *valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlStopBreak = 2;

	/**
	 * Get RS232 break signal status(on or off)
	 *<br>
	 * valueP = MemPtr to UInt16 for returning status(0 = off, !0 = on)
	 * *valueLenP = sizeof(UInt16)
	 */
	public static final int SerCtlBreakStatus = 3;

	/**
	 * Start local loopback test
	 *<br>
	 * valueP = 0 (null), valueLenP = 0 (null)
	 */
	public static final int SerCtlStartLocalLoopback = 4;

	/**
	 * Stop local loopback test.
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlStopLocalLoopback = 5;

	/**
	 * Get maximum supported baud rate:
	 *<br>
	 * valueP = MemPtr to UInt32 for returned baud, *valueLenP = sizeof(UInt32)
	 */
	public static final int SerCtlMaxBaud = 6;

	/**
	 * retrieve HW handshake threshold; this is the maximum baud rate
	 * which does not require hardware handshaking.
	 *<br>
	 * valueP = MemPtr to UInt32 for returned baud, *valueLenP = sizeof(UInt32)
	 */
	public static final int SerCtlHandshakeThreshold = 7;

	/**
	 * Set a blocking hook routine FOR EMULATION MODE ONLY - NOT SUPPORTED ON THE PALM.
	 *<br>
	 * valueP = MemPtr to SerCallbackEntryType, *valueLenP = sizeof(SerCallbackEntryType)<br>
	 * RETURNS: the old settings in the first argument
	 */
	public static final int SerCtlEmuSetBlockingHook = 8;

	/**
	 * Enable  IrDA connection on this serial port.
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlIrDAEnable = 9;

	/**
	 * Disable  IrDA connection on this serial port.
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlIrDADisable = 10;

	/**
	 * Start Ir Scanning mode	
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlIrScanningOn = 11;

	/**
	 * Stop Ir Scanning mode
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlIrScanningOff = 12;

	/**
	 * enable receiver  ( for IrDA )
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlRxEnable = 13;

	/**
	 * disable receiver ( for IrDA )
	 *<br>
	 * valueP = 0, valueLenP = 0
	 */
	public static final int SerCtlRxDisable = 14;

	/** The value for our baudrate for this setting */
	public int baudRate;
	
	/** Value of ORing the FlagXXXX values defined in this class together*/
	public int flags;
	
	/** The timeout for the Clear To Send line when transmitting, in terms of Palm ticks.
	 *  (100 ticks per second). This is only valid if FlagCTSAutoM is set. */
	public int ctsTimeout;
	
	/** Null creator for a new Serial Settings */
	public SerSettings() {}
}
