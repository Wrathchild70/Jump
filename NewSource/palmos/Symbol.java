package palmos;

/** Created by MkApi for Jump 2.2.2 */
public class Symbol {
    public final static int ROMToken = ('s'<<24)|('c'<<16)|('n'<<8)|'r';
    public final static int DECODE_UPC_EAN_SUPPLEMENTALS = 0x10;
    public final static int PARAM_DECODER_ENABLE = 0xAC;
    public final static int LEVEL = 0x00;
    public final static int SCAN_ANGLE_NARROW = 0xB5;
    public final static int SCAN_ANGLE_WIDE = 0xB6;

  /** PalmOS SysTrap: sysLibTrapScanMgrLibOpen
   *
   * <P>Defined as: Err &ScanMgrLibOpen(UInt16 refNum, UIntPtr value);
   */
  public native static int ScanMgrLibOpen(int refNum, ShortHolder value);
  /** PalmOS SysTrap: sysLibTrapScanMgrLibOpen
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err &ScanMgrLibOpen(UInt16 refNum, UIntPtr value);
   */
  public native static int ScanMgrLibOpen(int refNum, Short value);

  /** PalmOS SysTrap: sysLibTrapScanMgrLibClose
   *
   * <P>Defined as: Err &ScanMgrLibClose(UInt16 refNum, ULongPtr numappsP);
   */
  public native static int ScanMgrLibClose(int refNum, IntHolder numappsP);
  /** PalmOS SysTrap: sysLibTrapScanMgrLibClose
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err &ScanMgrLibClose(UInt16 refNum, ULongPtr numappsP);
   */
  public native static int ScanMgrLibClose(int refNum, Integer numappsP);

  /** PalmOS SysTrap: sysLibTrapScanMgrLibClose
   *
   * <P>Defined as: Err &ScanMgrLibClose(UInt16 refNum, Int32 numappsP);
   */
  public native static int ScanMgrLibClose(int refNum, int numappsP);

  /** PalmOS SysTrap: sysLibTrapScanMgrLibSleep
   *
   * <P>Defined as: Err &ScanMgrLibSleep(UInt16 refNum);
   */
  public native static int ScanMgrLibSleep(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanMgrLibWake
   *
   * <P>Defined as: Err &ScanMgrLibWake(UInt16 refNum);
   */
  public native static int ScanMgrLibWake(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanMgrLibGetLibAPIVersion
   *
   * <P>Defined as: Err &ScanMgrLibGetLibAPIVersion(UInt16 refNum, ULongPtr version);
   */
  public native static int ScanMgrLibGetLibAPIVersion(int refNum, IntHolder version);
  /** PalmOS SysTrap: sysLibTrapScanMgrLibGetLibAPIVersion
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err &ScanMgrLibGetLibAPIVersion(UInt16 refNum, ULongPtr version);
   */
  public native static int ScanMgrLibGetLibAPIVersion(int refNum, Integer version);

  /** PalmOS SysTrap: sysLibTrapScanKernGetDecodedData
   *
   * <P>Defined as: Err &ScanKernGetDecodedData(UInt16 refNum, voidptr messagePtr);
   */
  public native static int ScanKernGetDecodedData(int refNum, int messagePtr);

  /** PalmOS SysTrap: sysLibTrapScanKernGetDecodedData
   *
   * <P>Defined as: Err &ScanKernGetDecodedData(UInt16 refNum, VoidPtr messagePtr);
   */
  public native static int ScanKernGetDecodedData(int refNum, Object messagePtr);

  /** PalmOS SysTrap: sysLibTrapScanKernCommandSend
   *
   * <P>Defined as: Err &ScanKernCommandSend(UInt16 refNum);
   */
  public native static int ScanKernCommandSend(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernSendParams
   *
   * <P>Defined as: Err &ScanKernSendParams(UInt16 refNum, Enum beep);
   */
  public native static int ScanKernSendParams(int refNum, int beep);

  /** PalmOS SysTrap: sysLibTrapScanKernParamPacket
   *
   * <P>Defined as: Err &ScanKernParamPacket(UInt16 refNum, Int param1, Int param2 , Int param3 ,Int param4 );
   */
  public native static int ScanKernParamPacket(int refNum, int param1, int param2, int param3, int param4);

  /** PalmOS SysTrap: sysLibTrapScanSetBarcodeEnable
   *
   * <P>Defined as: Err &ScanSetBarcodeEnable(UInt16 refNum, Int barcodeType, Int bEnable , Int param1 ,Int param2 );
   */
  public native static int ScanSetBarcodeEnable(int refNum, int barcodeType, int bEnable, int param1, int param2);

  /** PalmOS SysTrap: sysLibTrapScanSetTriggeringModes
   *
   * <P>Defined as: Err &ScanSetTriggeringModes(UInt16 refNum, Int triggerModeCmd, Int triggerMode , Int param1 ,Int param2 );
   */
  public native static int ScanSetTriggeringModes(int refNum, int triggerModeCmd, int triggerMode, int param1, int param2);

  /** PalmOS SysTrap: sysLibTrapScanGetExtendedDecodedData
   *
   * <P>Defined as: Err &ScanGetExtendedDecodedData(UInt16 refNum, Int16 length, Int16Ptr type, ByteArray extendedData);
   */
  public native static int ScanGetExtendedDecodedData(int refNum, int length, ShortHolder type, byte [] extendedData, int _extendedData_off);
  /** PalmOS SysTrap: sysLibTrapScanGetExtendedDecodedData
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err &ScanGetExtendedDecodedData(UInt16 refNum, Int16 length, Int16Ptr type, ByteArray extendedData);
   */
  public native static int ScanGetExtendedDecodedData(int refNum, int length, Short type, byte [] extendedData, int _extendedData_off);

  /** PalmOS SysTrap: sysLibTrapScanKernParamRequest
   *
   * <P>Defined as: Err &ScanKernParamRequest(UInt16 refNum, Int command);
   */
  public native static int ScanKernParamRequest(int refNum, int command);

  /** PalmOS SysTrap: sysLibTrapScanGetBarcodeEnabled
   *
   * <P>Defined as: Err &ScanGetBarcodeEnabled(UInt16 refNum, Int barcodeType);
   */
  public native static int ScanGetBarcodeEnabled(int refNum, int barcodeType);

  /** PalmOS SysTrap: sysLibTrapScanKernParamRequestMultiple
   *
   * <P>Defined as: Err &ScanKernParamRequestMultiple(UInt16 refNum);
   */
  public native static int ScanKernParamRequestMultiple(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernGetParam
   *
   * <P>Defined as: Err &ScanKernGetParam(UInt16 refNum);
   */
  public native static int ScanKernGetParam(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernParamBatchIsRoom
   *
   * <P>Defined as: Err &ScanKernParamBatchIsRoom(UInt16 refNum);
   */
  public native static int ScanKernParamBatchIsRoom(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernGetAllParams
   *
   * <P>Defined as: Err &ScanKernGetAllParams(UInt16 refNum);
   */
  public native static int ScanKernGetAllParams(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernCmdLED
   *
   * <P>Defined as: Err &ScanKernCmdLED(UInt16 refNum);
   */
  public native static int ScanKernCmdLED(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernBeep
   *
   * <P>Defined as: Err &ScanKernBeep(UInt16 refNum, Enum beepType);
   */
  public native static int ScanKernBeep(int refNum, int beepType);

  /** PalmOS SysTrap: sysLibTrapScanKernSetBeepParams
   *
   * <P>Defined as: Err &ScanKernSetBeepParams(UInt16 refNum, Enum param, UInt16 beepFreqDur);
   */
  public native static int ScanKernSetBeepParams(int refNum, int param, int beepFreqDur);

  /** PalmOS SysTrap: sysLibTrapScanKernGetBeepParams
   *
   * <P>Defined as: Err &ScanKernGetBeepParams(UInt16 refNum);
   */
  public native static int ScanKernGetBeepParams(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernDecInitDecoder
   *
   * <P>Defined as: Err &ScanKernDecInitDecoder(UInt16 refNum, VoidPtr initData);
   */
  public native static int ScanKernDecInitDecoder(int refNum, Object initData);

  /** PalmOS SysTrap: sysLibTrapScanKernDecInitDecoder
   *
   * <P>Defined as: Err &ScanKernDecInitDecoder(UInt16 refNum, SymbolComm initData);
   */
  public native static int ScanKernDecInitDecoder(int refNum, SymbolComm initData);

  /** PalmOS SysTrap: sysLibTrapScanKernDecKillDecoder
   *
   * <P>Defined as: Err &ScanKernDecKillDecoder(UInt16 refNum);
   */
  public native static int ScanKernDecKillDecoder(int refNum);

  /** PalmOS SysTrap: sysLibTrapScanKernSetLocalParam
   *
   * <P>Defined as: Err &ScanKernSetLocalParam(UInt16 refNum, Int16 cmd, Int16 param);
   */
  public native static int ScanKernSetLocalParam(int refNum, int cmd, int param);

  /** PalmOS SysTrap: sysLibTrapScanKernGetLocalParam
   *
   * <P>Defined as: Err &ScanKernGetLocalParam(UInt16 refNum, UInt16 cmd);
   */
  public native static int ScanKernGetLocalParam(int refNum, int cmd);

  /** PalmOS SysTrap: sysLibTrapScanKernGetVersionString
   *
   * <P>Defined as: Err &ScanKernGetVersionString(UInt16 refNum, UInt16 cmd, CharBuf string, UInt16 len);
   */
  public native static int ScanKernGetVersionString(int refNum, int cmd, StringBuffer string, int len);

  /** PalmOS SysTrap: sysLibTrapScanGetPrefixSuffixValue
   *
   * <P>Defined as: Err &ScanGetPrefixSuffixValue(UInt16 refNum, CharPtr pPrefix, CharPtr pSuffix_1, CharPtr pSuffix_2);
   */
  public native static int ScanGetPrefixSuffixValue(int refNum, String pPrefix, String pSuffix_1, String pSuffix_2);
}
