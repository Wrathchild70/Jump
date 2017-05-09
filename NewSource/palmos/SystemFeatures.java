/* Source Safe Version information
 * $Header: /Waba/Jump/source/palmos/SystemFeatures.java 4     12/06/01 12:34p Rmontrose $
 * $Modtime: 12/06/01 12:33p $
 * $NoKeywords: $
 */

package palmos;

/**
 * Defines system features we can test for in our device.<br>
 *
 * The main feature used will probably be the ROM version so we have
 * provided a method to easily get it, but any Palm or Handspring feature
 * can be determined using the Palm.FtrGet method and these parameters
 *
 * @author <a href="mailto:rmontrose@avidwireless.com">Rod Montrose</a>
 * @version
 * 11/13/01 RCM Initial version
 *
 */

public class SystemFeatures {

/** Creator ID for internal Palm system variables */
public final static String PSYS = "psys";

/** Creator ID for internal Palm system variables */
public final static int psys = 0x70737973;

/** Creator ID for internal Handspring system extensions */
public final static String HSEX = "hsEx";

/** Creator ID for internal Handspring system extensions */
public final static int hsex = 0x68734578;

/**
 * ROM Version<br>
 * 0xMMmfsbbb, where MM is major version, m is minor version
 * f is bug fix, s is stage: 3-release,2-beta,1-alpha,0-development,
 * bbb is build number for non-releases 
 * <pre>
 * V1.12b3   would be: 0x01122003
 * V2.00a2   would be: 0x02001002
 * V1.01     would be: 0x01013000
 * </pre>
 */
public final static int sysFtrNumROMVersion = 1;

/** Product id */
public final static int sysFtrNumProcessorID = 2;

/** 
 * Mask to obtain processor model<br>
 *  0xMMMMRRRR, where MMMM is the processor model and RRRR is the revision.*/
public final static int sysFtrNumProcessorMask = 0xFFFF0000;

/** Motorola 68328		(Dragonball) */
public final static int sysFtrNumProcessor328 = 0x00010000;

/** Motorola 68EZ328	(Dragonball EZ) */
public final static int sysFtrNumProcessorEZ = 0x00020000;

/** old (obsolete) define */
public final static int sysFtrNumProductID = sysFtrNumProcessorID;

/** Backlight<br>
 * bit 0:	1 if present. 0 if Feature does not exist or backlight is not present */
public final static int sysFtrNumBacklight = 3;

/** 
 * Which encryption schemes are present */
public final static int sysFtrNumEncryption = 4;

/**
 *  bit 0:	1 if DES is present */
public final static int sysFtrNumEncryptionMaskDES = 0x00000001;

/**
 * International ROM identifier<br>
 * Result is of type CountryType as defined in Preferences.h.
 * Result is essentially the "default" country for this ROM.
 * Assume cUnitedStates if sysFtrNumROMVersion >= 02000000
 * and feature does not exist. Result is in low sixteen bits. */
public final static int sysFtrNumCountry = 5;

/**
 * Language identifier<br>
 * Result is of untyped; values are defined in Incs:BuildRules.h
 * Result is essentially the "default" language for this ROM.
 * This is new for the WorkPad (v2.0.2) and did NOT exist for any of the
 * following: GermanPersonal, GermanPro, FrenchPersonal, FrenchPro
 * Thus we can't really assume anything if the feature doesn't exist,
 * though the actual language MAY be determined from sysFtrNumCountry,
 * above. Result is in low sixteen bits.
 */
public final static int sysFtrNumLanguage = 6;

/**
 * Display depth<br>
 * Result is the "default" display depth for the screen.					(PalmOS 3.0)
 * This value is used by ScrDisplayMode when setting the default display depth.*/
public final static int sysFtrNumDisplayDepth = 7;

/**
 * GHwrMiscFlags value			(PalmOS 3.1) */
public final static int sysFtrNumHwrMiscFlags = 8;

/**
 *  GHwrMiscFlagsExt value		(PalmOS 3.1) */
public final static int sysFtrNumHwrMiscFlagsExt = 9;

/**
 * Result is a set of flags that define functionality supported
 * by the Int'l Manager.		(PalmOS 3.1) */
public final static int sysFtrNumIntlMgr = 10;

/**
 * Result is the character encoding (defined in TextMgr.h) supported
 * by this ROM. If this feature doesn't exist then the assumed encoding
 * is latin (Windows code page 1252).	(PalmOS 3.1)
 *  */
public final static int sysFtrNumEncoding = 11;

/**
 * Default font ID used for displaying text. (PalmOS 3.1) */
public final static int sysFtrDefaultFont = 12;

/**
 * Default font ID used for displaying bold text.	(PalmOS 3.1) */
public final static int sysFtrDefaultBoldFont = 13;

/**
 * // Globals for supporting gremlins.
 * This value is a pointer to a memory location that stores global variables needed
 * for intelligently supporting gremlins.  Currently, it is only used in Progress.c.
 * It is only initialized on first use (gremlins and progress bar in combination)
 * when ERROR_CHECK_LEVEL == ERROR_CHECK_FULL.	(PalmOS 3.2) */
public final static int sysFtrNumGremlinsSupportGlobals = 14;

/**
 * Result is the vendor id, in the low sixteen bits. (PalmOS 3.3) */
public final static int sysFtrNumVendor = 15;

/**
 * Flags for a given character encoding, specified in TextMgr.h	(PalmOS 3.5) */
public final static int sysFtrNumCharEncodingFlags = 16;

/**
 * version of the NotifyMgr, if any	(PalmOS 3.5) */
public final static int sysFtrNumNotifyMgrVersion = 17;

/**
 * Supplemental ROM version, provided by OEM
 * This value may be present in OEM devices, and is in the same format
 * as sysFtrNumROMVersion.	(PalmOS 3.5) */
public final static int sysFtrNumOEMROMVersion = 18;

/**
 * // ROM build setting of ERROR_CHECK_LEVEL
 * May be set to ERROR_CHECK_NONE, ERROR_CHECK_PARTIAL, or ERROR_CHECK_FULL
 * as defined in <BuildDefines.h>. (PalmOS 3.5) */
public final static int sysFtrNumErrorCheckLevel = 19;

/**
 * GHwrOEMCompanyID value		(PalmOS 3.5) */
public final static int sysFtrNumOEMCompanyID = 20;

/**
 * GHwrOEMDeviceID value		(PalmOS 3.5) */
public final static int sysFtrNumOEMDeviceID = 21;

/**
 * GHwrOEMHALID value			(PalmOS 3.5) */
public final static int sysFtrNumOEMHALID = 22;

/**
 * Will return the Palm OS version as MMmf where:
 * <pre>
 * MM is the major release number. i.e. 3
 * m is the minor release number i.e. 2
 * f is the bug fix number i.e. 2
 *</pre>
 * This allows you to do tests like
 * <pre><code>
 * if (palmos.SystemFeatures.getRomVersion() >= 0x350) {
 *    // we have at least version 3.5 of the OS
 * }
 * </code></pre>
 */
public static int getRomVersion () {
	IntHolder romVer = new IntHolder();
	Palm.FtrGet (psys, sysFtrNumROMVersion, romVer);
	return romVer.value >> 16;
}



}
