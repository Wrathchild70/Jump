package palmos;

/** Created by MkApi for Jump 2.2.2 */
public class Palm {
/** Get memory location as an int. */
public static native int nativeGetInt(int palmMemPtr);
/** Get memory location as an short. */
public static native int nativeGetShort(int palmMemPtr);
/** Get memory location as an byte. */
public static native int nativeGetByte(int palmMemPtr);
/** Lock object and return address as int.
 * When using the 'huge' memory model the returned pointer is proxy object
 * which can be used for Palm OS calls. Unlocking the object with nativeOvjectUnlock
 * copies the proxy back to the original object. */
public static native int nativeObjectLock(Object obj);
/** Return address of object as int. */
public static native int nativeObjectAddress(Object obj);
/** Set memory location as an int. */
public static native void nativeSetInt(int palmMemPtr, int val);
/** Set memory location as an short. */
public static native void nativeSetShort(int palmMemPtr, short val);
/** Set memory location as an byte. */
public static native void nativeSetByte(int palmMemPtr, byte val);
/** Lock object locked by nativeObjectLock. */
public static native void nativeObjectUnlock(Object obj);

  /** PalmOS SysTrap: sysTrapAlmGetAlarm
   *
   * <P>Defined as: ULong    AlmGetAlarm(UInt cardNo, LocalID dbID, DWordPtr refP);
   */
  public native static int AlmGetAlarm(int cardNo, int dbID, IntHolder refP);
  /** PalmOS SysTrap: sysTrapAlmGetAlarm
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: ULong    AlmGetAlarm(UInt cardNo, LocalID dbID, DWordPtr refP);
   */
  public native static int AlmGetAlarm(int cardNo, int dbID, Integer refP);

  /** PalmOS SysTrap: sysTrapAlmSetAlarm
   *
   * <P>Defined as: Err      AlmSetAlarm(UInt cardNo, LocalID dbID, DWord ref, ULong alarmSeconds, Boolean quiet);
   */
  public native static int AlmSetAlarm(int cardNo, int dbID, int ref, int alarmSeconds, boolean quiet);

  /** PalmOS SysTrap: sysTrapBmpCreate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: BitmapPtr BmpCreate(Coord width, Coord height, byte depth, ColorTablePtr colortable, UIntPtr error);
   */
  public native static int BmpCreate(int width, int height, int depth, Object colortable, ShortHolder error);

  /** PalmOS SysTrap: sysTrapBmpDelete (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err       BmpDelete(BitmapPtr bitmapP);
   */
  public native static int BmpDelete(int bitmapP);

  /** PalmOS SysTrap: sysTrapBmpCompress (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err       BmpCompress(BitmapPtr bitmap, Enum compType );
   */
  public native static int BmpCompress(int bitmap, int compType);

  /** PalmOS SysTrap: sysTrapBmpGetBits (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: voidptr   BmpGetBits(BitmapPtr bitmap);
   */
  public native static int BmpGetBits(int bitmap);

  /** PalmOS SysTrap: sysTrapBmpGetColortable (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: ColorTablePtr BmpGetColortable(BitmapPtr bitmap);
   */
  public native static int BmpGetColortable(int bitmap);

  /** PalmOS SysTrap: sysTrapBmpSize (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: UInt      BmpSize(BitmapPtr bitmapP);
   */
  public native static int BmpSize(int bitmapP);

  /** PalmOS SysTrap: sysTrapBmpBitsSize (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: UInt      BmpBitsSize(BitmapPtr bitmapP);
   */
  public native static int BmpBitsSize(int bitmapP);

  /** PalmOS SysTrap: sysTrapBmpColortableSize (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: UInt      BmpColortableSize(BitmapPtr bitmapP);
   */
  public native static int BmpColortableSize(int bitmapP);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpGetNextBitmapAnyDensity (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: BitmapPtr BmpGetNextBitmapAnyDensity(BitmapPtr bitmap) = sysTrapHighDensityDispatch selector HDSelectorBmpGetNextBitmapAnyDensity;
   */
  public native static int BmpGetNextBitmapAnyDensity(int bitmap);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpGetVersion (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: UInt8	  BmpGetVersion(const BitmapPtr bitmap) = sysTrapHighDensityDispatch selector (HDSelectorBmpGetVersion;
   */
  public native static int BmpGetVersion(int bitmap);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpGetCompressionType (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Enum	  BmpGetCompressionType(const BitmapPtr bitmap) = sysTrapHighDensityDispatch selector HDSelectorBmpGetCompressionType;
   */
  public native static int BmpGetCompressionType(int bitmap);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpGetDensity (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: UInt16	  BmpGetDensity(const BitmapPtr bitmap) = sysTrapHighDensityDispatch selector HDSelectorBmpGetDensity;
   */
  public native static int BmpGetDensity(int bitmap);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpSetDensity (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Err		  BmpSetDensity(BitmapPtr bitmap, UInt16 density) = sysTrapHighDensityDispatch selector HDSelectorBmpSetDensity;
   */
  public native static int BmpSetDensity(int bitmap, int density);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpGetTransparentValue (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Boolean	  BmpGetTransparentValue(const BitmapPtr bitmap, DWordPtr transparentValueP) = sysTrapHighDensityDispatch selector HDSelectorBmpGetTransparentValue;
   */
  public native static boolean BmpGetTransparentValue(int bitmap, IntHolder transparentValueP);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpSetTransparentValue (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void	  BmpSetTransparentValue(BitmapPtr bitmap, UInt32 transparentValue) = sysTrapHighDensityDispatch selector HDSelectorBmpSetTransparentValue;
   */
  public native static void BmpSetTransparentValue(int bitmap, int transparentValue);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorBmpCreateBitmapV3 (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: BitmapPtr BmpCreateBitmapV3(const BitmapPtr bitmap, UInt16 density, const voidptr bits, const ColorTablePtr colorTableP) = sysTrapHighDensityDispatch selector HDSelectorBmpCreateBitmapV3;
   */
  public native static int BmpCreateBitmapV3(int bitmap, int density, int bits, Object colorTableP);

  /** PalmOS SysTrap: sysTrapCategoryCreateListV10
   *
   * <P>Defined as: void     CategoryCreateList(DmOpenRef db, ListPtr lst, Word currentCategory, Boolean showAll) = sysTrapCategoryCreateListV10;
   */
  public native static void CategoryCreateList(int db, int lst, int currentCategory, boolean showAll);

  /** PalmOS SysTrap: sysTrapCategoryEditV10
   *
   * <P>Defined as: Boolean  CategoryEdit(DmOpenRef db, WordPtr category) = sysTrapCategoryEditV10;
   */
  public native static boolean CategoryEdit(int db, ShortHolder category);
  /** PalmOS SysTrap: sysTrapCategoryEditV10
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  CategoryEdit(DmOpenRef db, WordPtr category) = sysTrapCategoryEditV10;
   */
  public native static boolean CategoryEdit(int db, Short category);

  /** PalmOS SysTrap: sysTrapCategoryFind
   *
   * <P>Defined as: Word     CategoryFind(DmOpenRef db, CharPtr name);
   */
  public native static int CategoryFind(int db, String name);

  /** PalmOS SysTrap: sysTrapCategoryFreeListV10
   *
   * <P>Defined as: void     CategoryFreeList(DmOpenRef db, ListPtr list) = sysTrapCategoryFreeListV10;
   */
  public native static void CategoryFreeList(int db, int list);

  /** PalmOS SysTrap: sysTrapCategoryGetName
   *
   * <P>Defined as: void     CategoryGetName(DmOpenRef db, Word index, CharPtr name);
   */
  public native static void CategoryGetName(int db, int index, String name);

  /** PalmOS SysTrap: sysTrapCategoryGetNext
   *
   * <P>Defined as: Word     CategoryGetNext(DmOpenRef db, Word index);
   */
  public native static int CategoryGetNext(int db, int index);

  /** PalmOS SysTrap: sysTrapCategoryTruncateName
   *
   * <P>Defined as: void     CategoryTruncateName(CharPtr name, Word maxWidth);
   */
  public native static void CategoryTruncateName(String name, int maxWidth);

  /** PalmOS SysTrap: sysTrapCategorySetTriggerLabel
   *
   * <P>Defined as: void     CategorySetTriggerLabel(ControlPtr ctl, CharPtr name);
   */
  public native static void CategorySetTriggerLabel(int ctl, String name);

  /** PalmOS SysTrap: sysTrapCategorySelectV10
   *
   * <P>Defined as: Boolean  CategorySelect(DmOpenRef db, FormPtr frm, Word ctlID, Word lstID, Boolean title, WordPtr categoryP, CharPtr categoryName) = sysTrapCategorySelectV10;
   */
  public native static boolean CategorySelect(int db, int frm, int ctlID, int lstID, boolean title, ShortHolder categoryP, String categoryName);
  /** PalmOS SysTrap: sysTrapCategorySelectV10
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  CategorySelect(DmOpenRef db, FormPtr frm, Word ctlID, Word lstID, Boolean title, WordPtr categoryP, CharPtr categoryName) = sysTrapCategorySelectV10;
   */
  public native static boolean CategorySelect(int db, int frm, int ctlID, int lstID, boolean title, Short categoryP, String categoryName);

  /** PalmOS SysTrap: sysTrapCategoryEditV20 (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Boolean  CategoryEdit(DmOpenRef db, WordPtr category, ULong titleStrID) = sysTrapCategoryEditV20;
   */
  public native static boolean CategoryEdit(int db, ShortHolder category, int titleStrID);

  /** PalmOS SysTrap: sysTrapCategorySetName (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: void     CategorySetName(DmOpenRef db, Word index, CharPtr name);
   */
  public native static void CategorySetName(int db, int index, String name);

  /** PalmOS SysTrap: sysTrapCategoryEdit (<B>PalmOS 3.0</B>)
   *
   * <P>Defined as: Boolean  CategoryEdit(DmOpenRef db, WordPtr category, ULong titleStrID, Byte numUneditableCategories);
   */
  public native static boolean CategoryEdit(int db, ShortHolder category, int titleStrID, int numUneditableCategories);

  /** PalmOS SysTrap: sysTrapClipboardAddItem
   *
   * <P>Defined as: void     ClipboardAddItem(ClipboardFormatType format, VoidPtr ptr, Word length);
   */
  public native static void ClipboardAddItem(int format, Object ptr, int length);

  /** PalmOS SysTrap: sysTrapClipboardGetItem
   *
   * <P>Defined as: VoidHand ClipboardGetItem(ClipboardFormatType format, WordPtr length);
   */
  public native static int ClipboardGetItem(int format, ShortHolder length);
  /** PalmOS SysTrap: sysTrapClipboardGetItem
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: VoidHand ClipboardGetItem(ClipboardFormatType format, WordPtr length);
   */
  public native static int ClipboardGetItem(int format, Short length);

  /** PalmOS SysTrap: sysTrapCtlDrawControl
   *
   * <P>Defined as: void     CtlDrawControl(ControlPtr ControlP);
   */
  public native static void CtlDrawControl(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlEraseControl
   *
   * <P>Defined as: void     CtlEraseControl(ControlPtr ControlP);
   */
  public native static void CtlEraseControl(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlGetLabel
   *
   * <P>Defined as: CharPtr  CtlGetLabel(ControlPtr ControlP);
   */
  public native static String CtlGetLabel(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlGetValue
   *
   * <P>Defined as: short    CtlGetValue(ControlPtr ControlP);
   */
  public native static int CtlGetValue(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlHandleEvent
   *
   * <P>Defined as: Boolean  CtlHandleEvent(ControlPtr ControlP, EventPtr EventP);
   */
  public native static boolean CtlHandleEvent(int ControlP, Event EventP);

  /** PalmOS SysTrap: sysTrapCtlHideControl
   *
   * <P>Defined as: void     CtlHideControl(ControlPtr ControlP);
   */
  public native static void CtlHideControl(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlHitControl
   *
   * <P>Defined as: void     CtlHitControl(ControlPtr ControlP);
   */
  public native static void CtlHitControl(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlEnabled
   *
   * <P>Defined as: Boolean  CtlEnabled(ControlPtr ControlP);
   */
  public native static boolean CtlEnabled(int ControlP);

  /** PalmOS SysTrap: sysTrapCtlSetEnabled
   *
   * <P>Defined as: void     CtlSetEnabled(ControlPtr ControlP, Boolean enable);
   */
  public native static void CtlSetEnabled(int ControlP, boolean enable);

  /** PalmOS SysTrap: sysTrapCtlSetLabel
   *
   * <P>Defined as: void     CtlSetLabel(ControlPtr ControlP, CharPtr newLabel);
   */
  public native static void CtlSetLabel(int ControlP, String newLabel);

  /** PalmOS SysTrap: sysTrapCtlSetUsable
   *
   * <P>Defined as: void     CtlSetUsable(ControlPtr ControlP, Boolean usable);
   */
  public native static void CtlSetUsable(int ControlP, boolean usable);

  /** PalmOS SysTrap: sysTrapCtlSetValue
   *
   * <P>Defined as: void     CtlSetValue(ControlPtr ControlP, short newValue);
   */
  public native static void CtlSetValue(int ControlP, int newValue);

  /** PalmOS SysTrap: sysTrapCtlShowControl
   *
   * <P>Defined as: void     CtlShowControl(ControlPtr ControlP);
   */
  public native static void CtlShowControl(int ControlP);

  /** PalmOS SysTrap: sysTrapDlkGetSyncInfo
   *
   * <P>Defined as: Err      DlkGetSyncInfo(ULongPtr succSyncDate, ULongPtr lastSyncDate, UBytePtr syncState, CharBuf nameBuf, CharBuf logBuf, ULongPtr logLen);
   */
  public native static int DlkGetSyncInfo(IntHolder succSyncDate, IntHolder lastSyncDate, ByteHolder syncState, StringBuffer nameBuf, StringBuffer logBuf, IntHolder logLen);
  /** PalmOS SysTrap: sysTrapDlkGetSyncInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DlkGetSyncInfo(ULongPtr succSyncDate, ULongPtr lastSyncDate, UBytePtr syncState, CharBuf nameBuf, CharBuf logBuf, ULongPtr logLen);
   */
  public native static int DlkGetSyncInfo(Integer succSyncDate, Integer lastSyncDate, Byte syncState, StringBuffer nameBuf, StringBuffer logBuf, Integer logLen);

  /** PalmOS SysTrap: sysTrapDlkGetSyncInfo
   *
   * <P>Defined as: Err      DlkGetSyncInfoUserName(voidptr succSyncDate, voidptr lastSyncDate, voidptr syncState, CharBuf nameBuf, voidptr logBuf, voidptr logLen) = sysTrapDlkGetSyncInfo;
   */
  public native static int DlkGetSyncInfoUserName(int succSyncDate, int lastSyncDate, int syncState, StringBuffer nameBuf, int logBuf, int logLen);

  /** PalmOS SysTrap: sysTrapDmArchiveRecord
   *
   * <P>Defined as: Err      DmArchiveRecord(DmOpenRef dbR, UInt index);
   */
  public native static int DmArchiveRecord(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmAttachRecord
   *
   * <P>Defined as: Err      DmAttachRecord(DmOpenRef dbR, UIntPtr atP, Handle newH, Handle* oldHP);
   */
  public native static int DmAttachRecord(int dbR, ShortHolder atP, int newH, IntHolder oldHP);
  /** PalmOS SysTrap: sysTrapDmAttachRecord
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmAttachRecord(DmOpenRef dbR, UIntPtr atP, Handle newH, Handle* oldHP);
   */
  public native static int DmAttachRecord(int dbR, Short atP, int newH, Integer oldHP);

  /** PalmOS SysTrap: sysTrapDmAttachResource
   *
   * <P>Defined as: Err      DmAttachResource(DmOpenRef dbR, VoidHand newH, ULong resType, Int resID);
   */
  public native static int DmAttachResource(int dbR, int newH, int resType, int resID);

  /** PalmOS SysTrap: sysTrapDmCloseDatabase
   *
   * <P>Defined as: Err      DmCloseDatabase(DmOpenRef dbR);
   */
  public native static int DmCloseDatabase(int dbR);

  /** PalmOS SysTrap: sysTrapDmCreateDatabase
   *
   * <P>Defined as: Err      DmCreateDatabase(UInt cardNo, CharPtr nameP, ULong creator, ULong type, Boolean resDB);
   */
  public native static int DmCreateDatabase(int cardNo, String nameP, int creator, int type, boolean resDB);

  /** PalmOS SysTrap: sysTrapDmCreateDatabaseFromImage
   *
   * <P>Defined as: Err      DmCreateDatabaseFromImage(Ptr bufferP);
   */
  public native static int DmCreateDatabaseFromImage(Object bufferP);

  /** PalmOS SysTrap: sysTrapDmDatabaseInfo
   *
   * <P>Defined as: Err      DmDatabaseInfo(UInt cardNo, LocalID dbID, CharBuf nameP, UIntPtr attributesP, UIntPtr versionP, ULongPtr crDateP, ULongPtr modDateP, ULongPtr bckUpDateP, ULongPtr modNumP, LocalID* appInfoIDP, LocalID* sortInfoIDP, ULongPtr typeP, ULongPtr creatorP);
   */
  public native static int DmDatabaseInfo(int cardNo, int dbID, StringBuffer nameP, ShortHolder attributesP, ShortHolder versionP, IntHolder crDateP, IntHolder modDateP, IntHolder bckUpDateP, IntHolder modNumP, IntHolder appInfoIDP, IntHolder sortInfoIDP, IntHolder typeP, IntHolder creatorP);
  /** PalmOS SysTrap: sysTrapDmDatabaseInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmDatabaseInfo(UInt cardNo, LocalID dbID, CharBuf nameP, UIntPtr attributesP, UIntPtr versionP, ULongPtr crDateP, ULongPtr modDateP, ULongPtr bckUpDateP, ULongPtr modNumP, LocalID* appInfoIDP, LocalID* sortInfoIDP, ULongPtr typeP, ULongPtr creatorP);
   */
  public native static int DmDatabaseInfo(int cardNo, int dbID, StringBuffer nameP, Short attributesP, Short versionP, Integer crDateP, Integer modDateP, Integer bckUpDateP, Integer modNumP, Integer appInfoIDP, Integer sortInfoIDP, Integer typeP, Integer creatorP);

  /** PalmOS SysTrap: sysTrapDmDatabaseSize
   *
   * <P>Defined as: Err      DmDatabaseSize(UInt cardNo, LocalID dbID, ULongPtr numRecordsP, ULongPtr totalBytesP, ULongPtr dataBytesP);
   */
  public native static int DmDatabaseSize(int cardNo, int dbID, IntHolder numRecordsP, IntHolder totalBytesP, IntHolder dataBytesP);
  /** PalmOS SysTrap: sysTrapDmDatabaseSize
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmDatabaseSize(UInt cardNo, LocalID dbID, ULongPtr numRecordsP, ULongPtr totalBytesP, ULongPtr dataBytesP);
   */
  public native static int DmDatabaseSize(int cardNo, int dbID, Integer numRecordsP, Integer totalBytesP, Integer dataBytesP);

  /** PalmOS SysTrap: sysTrapDmDeleteDatabase
   *
   * <P>Defined as: Err      DmDeleteDatabase(UInt cardNo, LocalID dbID);
   */
  public native static int DmDeleteDatabase(int cardNo, int dbID);

  /** PalmOS SysTrap: sysTrapDmDeleteRecord
   *
   * <P>Defined as: Err      DmDeleteRecord(DmOpenRef dbR, UInt index);
   */
  public native static int DmDeleteRecord(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmDetachRecord
   *
   * <P>Defined as: Err      DmDetachRecord(DmOpenRef dbR, UInt index, Handle* oldHP);
   */
  public native static int DmDetachRecord(int dbR, int index, IntHolder oldHP);
  /** PalmOS SysTrap: sysTrapDmDetachRecord
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmDetachRecord(DmOpenRef dbR, UInt index, Handle* oldHP);
   */
  public native static int DmDetachRecord(int dbR, int index, Integer oldHP);

  /** PalmOS SysTrap: sysTrapDmDetachResource
   *
   * <P>Defined as: Err      DmDetachResource(DmOpenRef dbR, Int index, VoidHand* oldHP);
   */
  public native static int DmDetachResource(int dbR, int index, IntHolder oldHP);
  /** PalmOS SysTrap: sysTrapDmDetachResource
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmDetachResource(DmOpenRef dbR, Int index, VoidHand* oldHP);
   */
  public native static int DmDetachResource(int dbR, int index, Integer oldHP);

  /** PalmOS SysTrap: sysTrapDmFindDatabase
   *
   * <P>Defined as: LocalID  DmFindDatabase(UInt cardNo, CharPtr nameP);
   */
  public native static int DmFindDatabase(int cardNo, String nameP);

  /** PalmOS SysTrap: sysTrapDmFindRecordByID
   *
   * <P>Defined as: Err      DmFindRecordByID(DmOpenRef dbR, ULong uniqueID, UIntPtr indexP);
   */
  public native static int DmFindRecordByID(int dbR, int uniqueID, ShortHolder indexP);
  /** PalmOS SysTrap: sysTrapDmFindRecordByID
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmFindRecordByID(DmOpenRef dbR, ULong uniqueID, UIntPtr indexP);
   */
  public native static int DmFindRecordByID(int dbR, int uniqueID, Short indexP);

  /** PalmOS SysTrap: sysTrapDmFindResource
   *
   * <P>Defined as: Int      DmFindResource(DmOpenRef dbR, ULong resType, Int resID, VoidHand findResH);
   */
  public native static int DmFindResource(int dbR, int resType, int resID, int findResH);

  /** PalmOS SysTrap: sysTrapDmFindResourceType
   *
   * <P>Defined as: Int      DmFindResourceType(DmOpenRef dbR, ULong resType, Int typeIndex);
   */
  public native static int DmFindResourceType(int dbR, int resType, int typeIndex);

  /** PalmOS SysTrap: sysTrapDmGetAppInfoID
   *
   * <P>Defined as: LocalID  DmGetAppInfoID(DmOpenRef dbR);
   */
  public native static int DmGetAppInfoID(int dbR);

  /** PalmOS SysTrap: sysTrapDmGetDatabase
   *
   * <P>Defined as: LocalID  DmGetDatabase(UInt cardNo, UInt index);
   */
  public native static int DmGetDatabase(int cardNo, int index);

  /** PalmOS SysTrap: sysTrapDmGetLastErr
   *
   * <P>Defined as: Err      DmGetLastErr();
   */
  public native static int DmGetLastErr();

  /** PalmOS SysTrap: sysTrapDmGetNextDatabaseByTypeCreator
   *
   * <P>Defined as: Err      DmGetNextDatabaseByTypeCreator(Boolean newSearch, DmSearchStatePtr stateInfoP, ULong type, ULong creator, Boolean onlyLatestVers, UIntPtr cardNoP, LocalID* dbIDP);
   */
  public native static int DmGetNextDatabaseByTypeCreator(boolean newSearch, DmSearchState stateInfoP, int type, int creator, boolean onlyLatestVers, ShortHolder cardNoP, IntHolder dbIDP);
  /** PalmOS SysTrap: sysTrapDmGetNextDatabaseByTypeCreator
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmGetNextDatabaseByTypeCreator(Boolean newSearch, DmSearchStatePtr stateInfoP, ULong type, ULong creator, Boolean onlyLatestVers, UIntPtr cardNoP, LocalID* dbIDP);
   */
  public native static int DmGetNextDatabaseByTypeCreator(boolean newSearch, DmSearchState stateInfoP, int type, int creator, boolean onlyLatestVers, Short cardNoP, Integer dbIDP);

  /** PalmOS SysTrap: sysTrapDmGetRecord
   *
   * <P>Defined as: VoidHand DmGetRecord(DmOpenRef dbR, UInt index);
   */
  public native static int DmGetRecord(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmGetResource
   *
   * <P>Defined as: VoidHand DmGetResource(ULong type, Int ID);
   */
  public native static int DmGetResource(int type, int ID);

  /** PalmOS SysTrap: sysTrapDmGetResourceIndex
   *
   * <P>Defined as: VoidHand DmGetResourceIndex(DmOpenRef dbR, Int index);
   */
  public native static int DmGetResourceIndex(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmGet1Resource
   *
   * <P>Defined as: VoidHand DmGet1Resource(ULong type, Int ID);
   */
  public native static int DmGet1Resource(int type, int ID);

  /** PalmOS SysTrap: sysTrapDmMoveCategory
   *
   * <P>Defined as: Err      DmMoveCategory(DmOpenRef dbR, UInt toCategory, UInt fromCategory, Boolean dirty);
   */
  public native static int DmMoveCategory(int dbR, int toCategory, int fromCategory, boolean dirty);

  /** PalmOS SysTrap: sysTrapDmMoveRecord
   *
   * <P>Defined as: Err      DmMoveRecord(DmOpenRef dbR, UInt from, UInt to);
   */
  public native static int DmMoveRecord(int dbR, int from, int to);

  /** PalmOS SysTrap: sysTrapDmNewHandle
   *
   * <P>Defined as: VoidHand DmNewHandle(DmOpenRef dbR, ULong size);
   */
  public native static int DmNewHandle(int dbR, int size);

  /** PalmOS SysTrap: sysTrapDmNextOpenDatabase
   *
   * <P>Defined as: DmOpenRef DmNextOpenDatabase(DmOpenRef currentP);
   */
  public native static int DmNextOpenDatabase(int currentP);

  /** PalmOS SysTrap: sysTrapDmNextOpenResDatabase
   *
   * <P>Defined as: DmOpenRef DmNextOpenResDatabase(DmOpenRef dbR);
   */
  public native static int DmNextOpenResDatabase(int dbR);

  /** PalmOS SysTrap: sysTrapDmNewRecord
   *
   * <P>Defined as: VoidHand DmNewRecord(DmOpenRef dbR, UIntPtr atP, ULong size);
   */
  public native static int DmNewRecord(int dbR, ShortHolder atP, int size);
  /** PalmOS SysTrap: sysTrapDmNewRecord
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: VoidHand DmNewRecord(DmOpenRef dbR, UIntPtr atP, ULong size);
   */
  public native static int DmNewRecord(int dbR, Short atP, int size);

  /** PalmOS SysTrap: sysTrapDmNewResource
   *
   * <P>Defined as: VoidHand DmNewResource(DmOpenRef dbR, ULong resType, Int resID, ULong size);
   */
  public native static int DmNewResource(int dbR, int resType, int resID, int size);

  /** PalmOS SysTrap: sysTrapDmNumDatabases
   *
   * <P>Defined as: UInt     DmNumDatabases(UInt cardNo);
   */
  public native static int DmNumDatabases(int cardNo);

  /** PalmOS SysTrap: sysTrapDmNumRecords
   *
   * <P>Defined as: UInt     DmNumRecords(DmOpenRef dbR);
   */
  public native static int DmNumRecords(int dbR);

  /** PalmOS SysTrap: sysTrapDmNumRecordsInCategory
   *
   * <P>Defined as: UInt     DmNumRecordsInCategory(DmOpenRef dbR, UInt category);
   */
  public native static int DmNumRecordsInCategory(int dbR, int category);

  /** PalmOS SysTrap: sysTrapDmNumResources
   *
   * <P>Defined as: UInt     DmNumResources(DmOpenRef dbR);
   */
  public native static int DmNumResources(int dbR);

  /** PalmOS SysTrap: sysTrapDmOpenDatabase
   *
   * <P>Defined as: DmOpenRef DmOpenDatabase(UInt cardNo, LocalID dbID, UInt mode);
   */
  public native static int DmOpenDatabase(int cardNo, int dbID, int mode);

  /** PalmOS SysTrap: sysTrapDmOpenDatabaseByTypeCreator
   *
   * <P>Defined as: DmOpenRef DmOpenDatabaseByTypeCreator(ULong type, ULong creator, UInt mode);
   */
  public native static int DmOpenDatabaseByTypeCreator(int type, int creator, int mode);

  /** PalmOS SysTrap: sysTrapDmOpenDatabaseInfo
   *
   * <P>Defined as: Err      DmOpenDatabaseInfo(DmOpenRef dbR, LocalID* dbIDP, UIntPtr openCountP, UIntPtr modeP, UIntPtr cardNoP, BooleanPtr resDBP);
   */
  public native static int DmOpenDatabaseInfo(int dbR, IntHolder dbIDP, ShortHolder openCountP, ShortHolder modeP, ShortHolder cardNoP, BoolHolder resDBP);
  /** PalmOS SysTrap: sysTrapDmOpenDatabaseInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmOpenDatabaseInfo(DmOpenRef dbR, LocalID* dbIDP, UIntPtr openCountP, UIntPtr modeP, UIntPtr cardNoP, BooleanPtr resDBP);
   */
  public native static int DmOpenDatabaseInfo(int dbR, Integer dbIDP, Short openCountP, Short modeP, Short cardNoP, Boolean resDBP);

  /** PalmOS SysTrap: sysTrapDmPositionInCategory
   *
   * <P>Defined as: UInt     DmPositionInCategory(DmOpenRef dbR, UInt index, UInt category);
   */
  public native static int DmPositionInCategory(int dbR, int index, int category);

  /** PalmOS SysTrap: sysTrapDmQueryNextInCategory
   *
   * <P>Defined as: VoidHand DmQueryNextInCategory(DmOpenRef dbR, UIntPtr indexP, UInt category);
   */
  public native static int DmQueryNextInCategory(int dbR, ShortHolder indexP, int category);
  /** PalmOS SysTrap: sysTrapDmQueryNextInCategory
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: VoidHand DmQueryNextInCategory(DmOpenRef dbR, UIntPtr indexP, UInt category);
   */
  public native static int DmQueryNextInCategory(int dbR, Short indexP, int category);

  /** PalmOS SysTrap: sysTrapDmQueryRecord
   *
   * <P>Defined as: VoidHand DmQueryRecord(DmOpenRef dbR, UInt index);
   */
  public native static int DmQueryRecord(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmRecordInfo
   *
   * <P>Defined as: Err      DmRecordInfo(DmOpenRef dbR, UInt index, WordPtr attr, ULongPtr uniqueIDP, LocalID* chunkIDP);
   */
  public native static int DmRecordInfo(int dbR, int index, ShortHolder attr, IntHolder uniqueIDP, IntHolder chunkIDP);
  /** PalmOS SysTrap: sysTrapDmRecordInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmRecordInfo(DmOpenRef dbR, UInt index, WordPtr attr, ULongPtr uniqueIDP, LocalID* chunkIDP);
   */
  public native static int DmRecordInfo(int dbR, int index, Short attr, Integer uniqueIDP, Integer chunkIDP);

  /** PalmOS SysTrap: sysTrapDmResourceInfo
   *
   * <P>Defined as: Err      DmResourceInfo(DmOpenRef dbR, Int index, ULongPtr resTypeP, IntPtr resIDP, LocalID* chunkLocalIDP);
   */
  public native static int DmResourceInfo(int dbR, int index, IntHolder resTypeP, ShortHolder resIDP, IntHolder chunkLocalIDP);
  /** PalmOS SysTrap: sysTrapDmResourceInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmResourceInfo(DmOpenRef dbR, Int index, ULongPtr resTypeP, IntPtr resIDP, LocalID* chunkLocalIDP);
   */
  public native static int DmResourceInfo(int dbR, int index, Integer resTypeP, Short resIDP, Integer chunkLocalIDP);

  /** PalmOS SysTrap: sysTrapDmReleaseRecord
   *
   * <P>Defined as: Err      DmReleaseRecord(DmOpenRef dbR, UInt index, Boolean dirty);
   */
  public native static int DmReleaseRecord(int dbR, int index, boolean dirty);

  /** PalmOS SysTrap: sysTrapDmReleaseResource
   *
   * <P>Defined as: Err      DmReleaseResource(VoidHand resourceH);
   */
  public native static int DmReleaseResource(int resourceH);

  /** PalmOS SysTrap: sysTrapDmRemoveRecord
   *
   * <P>Defined as: Err      DmRemoveRecord(DmOpenRef dbR, UInt index);
   */
  public native static int DmRemoveRecord(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmRemoveResource
   *
   * <P>Defined as: Err      DmRemoveResource(DmOpenRef dbR, Int index);
   */
  public native static int DmRemoveResource(int dbR, int index);

  /** PalmOS SysTrap: sysTrapDmRemoveSecretRecords
   *
   * <P>Defined as: Err      DmRemoveSecretRecords(DmOpenRef dbR);
   */
  public native static int DmRemoveSecretRecords(int dbR);

  /** PalmOS SysTrap: sysTrapDmResetRecordStates
   *
   * <P>Defined as: Err      DmResetRecordStates(DmOpenRef dbR);
   */
  public native static int DmResetRecordStates(int dbR);

  /** PalmOS SysTrap: sysTrapDmResizeRecord
   *
   * <P>Defined as: VoidHand DmResizeRecord(DmOpenRef dbR, UInt index, ULong newSize);
   */
  public native static int DmResizeRecord(int dbR, int index, int newSize);

  /** PalmOS SysTrap: sysTrapDmResizeResource
   *
   * <P>Defined as: VoidHand DmResizeResource(VoidHand resourceH, ULong newSize);
   */
  public native static int DmResizeResource(int resourceH, int newSize);

  /** PalmOS SysTrap: sysTrapDmSearchRecord
   *
   * <P>Defined as: Int      DmSearchRecord(VoidHand recH, DmOpenRef* dbRP);
   */
  public native static int DmSearchRecord(int recH, IntHolder dbRP);
  /** PalmOS SysTrap: sysTrapDmSearchRecord
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Int      DmSearchRecord(VoidHand recH, DmOpenRef* dbRP);
   */
  public native static int DmSearchRecord(int recH, Integer dbRP);

  /** PalmOS SysTrap: sysTrapDmSearchResource
   *
   * <P>Defined as: Int      DmSearchResource(ULong resType, Int resId, VoidHand resH, DmOpenRef* dbRP);
   */
  public native static int DmSearchResource(int resType, int resId, int resH, IntHolder dbRP);
  /** PalmOS SysTrap: sysTrapDmSearchResource
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Int      DmSearchResource(ULong resType, Int resId, VoidHand resH, DmOpenRef* dbRP);
   */
  public native static int DmSearchResource(int resType, int resId, int resH, Integer dbRP);

  /** PalmOS SysTrap: sysTrapDmSeekRecordInCategory
   *
   * <P>Defined as: Err      DmSeekRecordInCategory(DmOpenRef dbR, UIntPtr indexP, Int offset, Int direction, UInt category);
   */
  public native static int DmSeekRecordInCategory(int dbR, ShortHolder indexP, int offset, int direction, int category);
  /** PalmOS SysTrap: sysTrapDmSeekRecordInCategory
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmSeekRecordInCategory(DmOpenRef dbR, UIntPtr indexP, Int offset, Int direction, UInt category);
   */
  public native static int DmSeekRecordInCategory(int dbR, Short indexP, int offset, int direction, int category);

  /** PalmOS SysTrap: sysTrapDmSet
   *
   * <P>Defined as: Err      DmSet(VoidPtr recordP, ULong offset, ULong bytes, Byte value);
   */
  public native static int DmSet(Object recordP, int offset, int bytes, int value);

  /** PalmOS SysTrap: sysTrapDmSetDatabaseInfo
   *
   * <P>Defined as: Err      DmSetDatabaseInfo(UInt cardNo, LocalID dbID, CharPtr nameP, UIntPtr attributesP, UIntPtr versionP, ULongPtr crDateP, ULongPtr modDateP, ULongPtr bckUpDateP, ULongPtr modNumP, LocalID* appInfoIDP, LocalID* sortInfoIDP, ULongPtr typeP, ULongPtr creatorP);
   */
  public native static int DmSetDatabaseInfo(int cardNo, int dbID, String nameP, ShortHolder attributesP, ShortHolder versionP, IntHolder crDateP, IntHolder modDateP, IntHolder bckUpDateP, IntHolder modNumP, IntHolder appInfoIDP, IntHolder sortInfoIDP, IntHolder typeP, IntHolder creatorP);
  /** PalmOS SysTrap: sysTrapDmSetDatabaseInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmSetDatabaseInfo(UInt cardNo, LocalID dbID, CharPtr nameP, UIntPtr attributesP, UIntPtr versionP, ULongPtr crDateP, ULongPtr modDateP, ULongPtr bckUpDateP, ULongPtr modNumP, LocalID* appInfoIDP, LocalID* sortInfoIDP, ULongPtr typeP, ULongPtr creatorP);
   */
  public native static int DmSetDatabaseInfo(int cardNo, int dbID, String nameP, Short attributesP, Short versionP, Integer crDateP, Integer modDateP, Integer bckUpDateP, Integer modNumP, Integer appInfoIDP, Integer sortInfoIDP, Integer typeP, Integer creatorP);

  /** PalmOS SysTrap: sysTrapDmSetRecordInfo
   *
   * <P>Defined as: Err      DmSetRecordInfo(DmOpenRef dbR, UInt index, WordPtr attr, ULongPtr uniqueIDP);
   */
  public native static int DmSetRecordInfo(int dbR, int index, ShortHolder attr, IntHolder uniqueIDP);
  /** PalmOS SysTrap: sysTrapDmSetRecordInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmSetRecordInfo(DmOpenRef dbR, UInt index, WordPtr attr, ULongPtr uniqueIDP);
   */
  public native static int DmSetRecordInfo(int dbR, int index, Short attr, Integer uniqueIDP);

  /** PalmOS SysTrap: sysTrapDmSetResourceInfo
   *
   * <P>Defined as: Err      DmSetResourceInfo(DmOpenRef dbR, Int index, ULongPtr resTypeP, IntPtr resIDP);
   */
  public native static int DmSetResourceInfo(int dbR, int index, IntHolder resTypeP, ShortHolder resIDP);
  /** PalmOS SysTrap: sysTrapDmSetResourceInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      DmSetResourceInfo(DmOpenRef dbR, Int index, ULongPtr resTypeP, IntPtr resIDP);
   */
  public native static int DmSetResourceInfo(int dbR, int index, Integer resTypeP, Short resIDP);

  /** PalmOS SysTrap: sysTrapDmStrCopy
   *
   * <P>Defined as: Err      DmStrCopy(VoidPtr recordP, ULong offset, CharPtr src);
   */
  public native static int DmStrCopy(Object recordP, int offset, String src);

  /** PalmOS SysTrap: sysTrapDmWrite
   *
   * <P>Defined as: Err      DmWrite(VoidPtr recordP, ULong ofset, VoidPtr src, ULong bytes);
   */
  public native static int DmWrite(Object recordP, int ofset, Object src, int bytes);

  /** PalmOS SysTrap: sysTrapDmWrite
   *
   * <P>Defined as: Err      DmWrite(voidptr recordP, ULong offset, VoidPtr src, ULong bytes);
   */
  public native static int DmWrite(int recordP, int offset, Object src, int bytes);

  /** PalmOS SysTrap: sysTrapDmWrite
   *
   * <P>Defined as: Err      DmWrite(VoidPtr recordP, ULong offset, ByteArray src, ULong bytes);
   */
  public native static int DmWrite(Object recordP, int offset, byte [] src, int _src_off, int bytes);

  /** PalmOS SysTrap: sysTrapDmWrite
   *
   * <P>Defined as: Err      DmWrite(voidptr recordP, ULong offset, ByteArray src, ULong bytes);
   */
  public native static int DmWrite(int recordP, int offset, byte [] src, int _src_off, int bytes);

  /** PalmOS SysTrap: sysTrapDmWriteCheck
   *
   * <P>Defined as: Err      DmWriteCheck(VoidPtr recordP, ULong ofset, ULong bytes);
   */
  public native static int DmWriteCheck(Object recordP, int ofset, int bytes);

  /** PalmOS SysTrap: sysTrapDmDeleteCategory (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Err      DmDeleteCategory(DmOpenRef dbR, UInt categoryNum);
   */
  public native static int DmDeleteCategory(int dbR, int categoryNum);

  /** PalmOS SysTrap: sysTrapErrDisplayFileLineMsg
   *
   * <P>Defined as: void     ErrDisplayFileLineMsg(CharPtr filename, UInt lineno, CharPtr msg);
   */
  public native static void ErrDisplayFileLineMsg(String filename, int lineno, String msg);

  /** PalmOS SysTrap: sysTrapEvtAddEventToQueue
   *
   * <P>Defined as: void     EvtAddEventToQueue(EventPtr event);
   */
  public native static void EvtAddEventToQueue(Event event);

  /** PalmOS SysTrap: sysTrapEvtCopyEvent
   *
   * <P>Defined as: void     EvtCopyEvent(EventPtr source, EventPtr dest);
   */
  public native static void EvtCopyEvent(Event source, Event dest);

  /** PalmOS SysTrap: sysTrapEvtDequeuePenPoint
   *
   * <P>Defined as: Err      EvtDequeuePenPoint(PointType* retP);
   */
  public native static int EvtDequeuePenPoint(PointType retP);

  /** PalmOS SysTrap: sysTrapEvtDequeuePenStrokeInfo
   *
   * <P>Defined as: Err      EvtDequeuePenStrokeInfo(PointType* startPtP, PointType* endPtP);
   */
  public native static int EvtDequeuePenStrokeInfo(PointType startPtP, PointType endPtP);

  /** PalmOS SysTrap: sysTrapEvtEnableGraffiti
   *
   * <P>Defined as: void     EvtEnableGraffiti(Boolean enable);
   */
  public native static void EvtEnableGraffiti(boolean enable);

  /** PalmOS SysTrap: sysTrapEvtEnqueueKey
   *
   * <P>Defined as: Err      EvtEnqueueKey(UInt ascii, UInt keycode, UInt modifiers);
   */
  public native static int EvtEnqueueKey(int ascii, int keycode, int modifiers);

  /** PalmOS SysTrap: sysTrapEvtFlushKeyQueue
   *
   * <P>Defined as: Err      EvtFlushKeyQueue();
   */
  public native static int EvtFlushKeyQueue();

  /** PalmOS SysTrap: sysTrapEvtFlushNextPenStroke
   *
   * <P>Defined as: Err      EvtFlushNextPenStroke();
   */
  public native static int EvtFlushNextPenStroke();

  /** PalmOS SysTrap: sysTrapEvtFlushPenQueue
   *
   * <P>Defined as: Err      EvtFlushPenQueue();
   */
  public native static int EvtFlushPenQueue();

  /** PalmOS SysTrap: sysTrapEvtGetEvent
   *
   * <P>Defined as: void     EvtGetEvent(EventPtr event, Long timeout);
   */
  public native static void EvtGetEvent(Event event, int timeout);

  /** PalmOS SysTrap: sysTrapEvtGetPen
   *
   * <P>Defined as: void     EvtGetPen(SWord* pScreenX, SWord* pScreenY, Boolean* pPenDown);
   */
  public native static void EvtGetPen(ShortHolder pScreenX, ShortHolder pScreenY, BoolHolder pPenDown);
  /** PalmOS SysTrap: sysTrapEvtGetPen
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     EvtGetPen(SWord* pScreenX, SWord* pScreenY, Boolean* pPenDown);
   */
  public native static void EvtGetPen(Short pScreenX, Short pScreenY, Boolean pPenDown);

  /** PalmOS SysTrap: sysTrapEvtKeyQueueEmpty
   *
   * <P>Defined as: Boolean  EvtKeyQueueEmpty();
   */
  public native static boolean EvtKeyQueueEmpty();

  /** PalmOS SysTrap: sysTrapEvtKeyQueueSize
   *
   * <P>Defined as: ULong    EvtKeyQueueSize();
   */
  public native static int EvtKeyQueueSize();

  /** PalmOS SysTrap: sysTrapEvtPenQueueSize
   *
   * <P>Defined as: ULong    EvtPenQueueSize();
   */
  public native static int EvtPenQueueSize();

  /** PalmOS SysTrap: sysTrapEvtProcessSoftKeyStroke
   *
   * <P>Defined as: Err      EvtProcessSoftKeyStroke(PointType* startPtP, PointType* endPtP);
   */
  public native static int EvtProcessSoftKeyStroke(PointType startPtP, PointType endPtP);

  /** PalmOS SysTrap: sysTrapEvtResetAutoOffTimer
   *
   * <P>Defined as: Word     EvtResetAutoOffTimer();
   */
  public native static int EvtResetAutoOffTimer();

  /** PalmOS SysTrap: sysTrapEvtWakeup
   *
   * <P>Defined as: Err      EvtWakeup();
   */
  public native static int EvtWakeup();

  /** PalmOS SysTrap: sysTrapEvtEventAvail (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Boolean  EvtEventAvail();
   */
  public native static boolean EvtEventAvail();

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expInit
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpInit() = sysTrapExpansionDispatch selector expInit;
   */
  public native static int ExpInit();

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotDriverInstall
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpSlotDriverInstall(UInt32 dbCreator, UIntPtr slotLibRefNumP) = sysTrapExpansionDispatch selector expSlotDriverInstall;
   */
  public native static int ExpSlotDriverInstall(int dbCreator, ShortHolder slotLibRefNumP);
  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotDriverInstall
   * (<B>requires Expansion Manager Feature Set</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err ExpSlotDriverInstall(UInt32 dbCreator, UIntPtr slotLibRefNumP) = sysTrapExpansionDispatch selector expSlotDriverInstall;
   */
  public native static int ExpSlotDriverInstall(int dbCreator, Short slotLibRefNumP);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotDriverRemove
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpSlotDriverRemove(UInt16 slotLibRefNum) = sysTrapExpansionDispatch selector expSlotDriverRemove;
   */
  public native static int ExpSlotDriverRemove(int slotLibRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotLibFind
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpSlotLibFind(UInt16 slotRefNum, UIntPtr slotLibRefNum) = sysTrapExpansionDispatch selector expSlotLibFind;
   */
  public native static int ExpSlotLibFind(int slotRefNum, ShortHolder slotLibRefNum);
  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotLibFind
   * (<B>requires Expansion Manager Feature Set</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err ExpSlotLibFind(UInt16 slotRefNum, UIntPtr slotLibRefNum) = sysTrapExpansionDispatch selector expSlotLibFind;
   */
  public native static int ExpSlotLibFind(int slotRefNum, Short slotLibRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotRegister
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpSlotRegister(UInt16 slotLibRefNum, UIntPtr slotRefNum) = sysTrapExpansionDispatch selector expSlotRegister;
   */
  public native static int ExpSlotRegister(int slotLibRefNum, ShortHolder slotRefNum);
  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotRegister
   * (<B>requires Expansion Manager Feature Set</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err ExpSlotRegister(UInt16 slotLibRefNum, UIntPtr slotRefNum) = sysTrapExpansionDispatch selector expSlotRegister;
   */
  public native static int ExpSlotRegister(int slotLibRefNum, Short slotRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotUnregister
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpSlotUnregister(UInt16 slotRefNum) = sysTrapExpansionDispatch selector expSlotUnregister;
   */
  public native static int ExpSlotUnregister(int slotRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expCardInserted
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpCardInserted(UInt16 slotRefNum) = sysTrapExpansionDispatch selector expCardInserted;
   */
  public native static int ExpCardInserted(int slotRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expCardRemoved
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpCardRemoved(UInt16 slotRefNum) = sysTrapExpansionDispatch selector expCardRemoved;
   */
  public native static int ExpCardRemoved(int slotRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expCardPresent
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpCardPresent(UInt16 slotRefNum) = sysTrapExpansionDispatch selector expCardPresent;
   */
  public native static int ExpCardPresent(int slotRefNum);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotEnumerate
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpSlotEnumerate(UIntPtr slotRefNumP, ULongPtr slotIteratorP) = sysTrapExpansionDispatch selector expSlotEnumerate;
   */
  public native static int ExpSlotEnumerate(ShortHolder slotRefNumP, IntHolder slotIteratorP);
  /** PalmOS SysTrap: sysTrapExpansionDispatch/expSlotEnumerate
   * (<B>requires Expansion Manager Feature Set</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err ExpSlotEnumerate(UIntPtr slotRefNumP, ULongPtr slotIteratorP) = sysTrapExpansionDispatch selector expSlotEnumerate;
   */
  public native static int ExpSlotEnumerate(Short slotRefNumP, Integer slotIteratorP);

  /** PalmOS SysTrap: sysTrapExpansionDispatch/expCardGetSerialPort
   * (<B>requires Expansion Manager Feature Set</B>)
   *
   * <P>Defined as: Err ExpCardGetSerialPort(UInt16 slotRefNum, ULongPtr portP) = sysTrapExpansionDispatch selector expCardGetSerialPort;
   */
  public native static int ExpCardGetSerialPort(int slotRefNum, IntHolder portP);
  /** PalmOS SysTrap: sysTrapExpansionDispatch/expCardGetSerialPort
   * (<B>requires Expansion Manager Feature Set</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err ExpCardGetSerialPort(UInt16 slotRefNum, ULongPtr portP) = sysTrapExpansionDispatch selector expCardGetSerialPort;
   */
  public native static int ExpCardGetSerialPort(int slotRefNum, Integer portP);

  /** PalmOS SysTrap: sysTrapFindStrInStr
   *
   * <P>Defined as: void     FindStrInStr(CharPtr strToSearch, CharPtr strToFind, WordPtr posP);
   */
  public native static void FindStrInStr(String strToSearch, String strToFind, ShortHolder posP);
  /** PalmOS SysTrap: sysTrapFindStrInStr
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     FindStrInStr(CharPtr strToSearch, CharPtr strToFind, WordPtr posP);
   */
  public native static void FindStrInStr(String strToSearch, String strToFind, Short posP);

  /** PalmOS SysTrap: sysTrapFldCalcFieldHeight
   *
   * <P>Defined as: Word     FldCalcFieldHeight(CharPtr chars, Word maxWidth);
   */
  public native static int FldCalcFieldHeight(String chars, int maxWidth);

  /** PalmOS SysTrap: sysTrapFldCompactText
   *
   * <P>Defined as: void     FldCompactText(FieldPtr fld);
   */
  public native static void FldCompactText(int fld);

  /** PalmOS SysTrap: sysTrapFldCopy
   *
   * <P>Defined as: void     FldCopy(FieldPtr fld);
   */
  public native static void FldCopy(int fld);

  /** PalmOS SysTrap: sysTrapFldCut
   *
   * <P>Defined as: void     FldCut(FieldPtr fld);
   */
  public native static void FldCut(int fld);

  /** PalmOS SysTrap: sysTrapFldDelete
   *
   * <P>Defined as: void     FldDelete(FieldPtr fld, Word start, Word end);
   */
  public native static void FldDelete(int fld, int start, int end);

  /** PalmOS SysTrap: sysTrapFldDirty
   *
   * <P>Defined as: Boolean  FldDirty(FieldPtr fld);
   */
  public native static boolean FldDirty(int fld);

  /** PalmOS SysTrap: sysTrapFldDrawField
   *
   * <P>Defined as: void     FldDrawField(FieldPtr fld);
   */
  public native static void FldDrawField(int fld);

  /** PalmOS SysTrap: sysTrapFldEraseField
   *
   * <P>Defined as: void     FldEraseField(FieldPtr fld);
   */
  public native static void FldEraseField(int fld);

  /** PalmOS SysTrap: sysTrapFldFreeMemory
   *
   * <P>Defined as: void     FldFreeMemory(FieldPtr fld);
   */
  public native static void FldFreeMemory(int fld);

  /** PalmOS SysTrap: sysTrapFldGetAttributes
   *
   * <P>Defined as: void     FldGetAttributes(FieldPtr fld, FieldAttrPtr attrP);
   */
  public native static void FldGetAttributes(int fld, FieldAttr attrP);

  /** PalmOS SysTrap: sysTrapFldGetBounds
   *
   * <P>Defined as: void     FldGetBounds(FieldPtr fld, RectanglePtr rect);
   */
  public native static void FldGetBounds(int fld, Rectangle rect);

  /** PalmOS SysTrap: sysTrapFldGetFont
   *
   * <P>Defined as: FontID   FldGetFont(FieldPtr fld);
   */
  public native static int FldGetFont(int fld);

  /** PalmOS SysTrap: sysTrapFldGetInsPtPosition
   *
   * <P>Defined as: Word     FldGetInsPtPosition(FieldPtr fld);
   */
  public native static int FldGetInsPtPosition(int fld);

  /** PalmOS SysTrap: sysTrapFldGetMaxChars
   *
   * <P>Defined as: Word     FldGetMaxChars(FieldPtr fld);
   */
  public native static int FldGetMaxChars(int fld);

  /** PalmOS SysTrap: sysTrapFldGetScrollPosition
   *
   * <P>Defined as: Word     FldGetScrollPosition(FieldPtr fld);
   */
  public native static int FldGetScrollPosition(int fld);

  /** PalmOS SysTrap: sysTrapFldGetScrollValues
   *
   * <P>Defined as: void     FldGetScrollValues(FieldPtr fld, WordPtr scrollPos, WordPtr textHeight, WordPtr fieldHeight);
   */
  public native static void FldGetScrollValues(int fld, ShortHolder scrollPos, ShortHolder textHeight, ShortHolder fieldHeight);
  /** PalmOS SysTrap: sysTrapFldGetScrollValues
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     FldGetScrollValues(FieldPtr fld, WordPtr scrollPos, WordPtr textHeight, WordPtr fieldHeight);
   */
  public native static void FldGetScrollValues(int fld, Short scrollPos, Short textHeight, Short fieldHeight);

  /** PalmOS SysTrap: sysTrapFldGetSelection
   *
   * <P>Defined as: void     FldGetSelection(FieldPtr fld, WordPtr startPosition, WordPtr endPosition);
   */
  public native static void FldGetSelection(int fld, ShortHolder startPosition, ShortHolder endPosition);
  /** PalmOS SysTrap: sysTrapFldGetSelection
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     FldGetSelection(FieldPtr fld, WordPtr startPosition, WordPtr endPosition);
   */
  public native static void FldGetSelection(int fld, Short startPosition, Short endPosition);

  /** PalmOS SysTrap: sysTrapFldGetTextAllocatedSize
   *
   * <P>Defined as: Word     FldGetTextAllocatedSize(FieldPtr fld);
   */
  public native static int FldGetTextAllocatedSize(int fld);

  /** PalmOS SysTrap: sysTrapFldGetTextHandle
   *
   * <P>Defined as: Handle   FldGetTextHandle(FieldPtr fld);
   */
  public native static int FldGetTextHandle(int fld);

  /** PalmOS SysTrap: sysTrapFldGetTextHeight
   *
   * <P>Defined as: Word     FldGetTextHeight(FieldPtr fld);
   */
  public native static int FldGetTextHeight(int fld);

  /** PalmOS SysTrap: sysTrapFldGetTextLength
   *
   * <P>Defined as: Word     FldGetTextLength(FieldPtr fld);
   */
  public native static int FldGetTextLength(int fld);

  /** PalmOS SysTrap: sysTrapFldGetTextPtr
   *
   * <P>Defined as: CharPtr  FldGetTextPtr(Handle fld);
   */
  public native static String FldGetTextPtr(int fld);

  /** PalmOS SysTrap: sysTrapFldGetVisibleLines
   *
   * <P>Defined as: Word     FldGetVisibleLines(FieldPtr fld);
   */
  public native static int FldGetVisibleLines(int fld);

  /** PalmOS SysTrap: sysTrapFldGrabFocus
   *
   * <P>Defined as: void     FldGrabFocus(FieldPtr fld);
   */
  public native static void FldGrabFocus(int fld);

  /** PalmOS SysTrap: sysTrapFldHandleEvent
   *
   * <P>Defined as: Boolean  FldHandleEvent(FieldPtr fld, EventPtr EventP);
   */
  public native static boolean FldHandleEvent(int fld, Event EventP);

  /** PalmOS SysTrap: sysTrapFldInsert
   *
   * <P>Defined as: Boolean  FldInsert(FieldPtr fld, CharPtr insertChars, Word insertLen);
   */
  public native static boolean FldInsert(int fld, String insertChars, int insertLen);

  /** PalmOS SysTrap: sysTrapFldMakeFullyVisible
   *
   * <P>Defined as: Boolean  FldMakeFullyVisible(FieldPtr fld);
   */
  public native static boolean FldMakeFullyVisible(int fld);

  /** PalmOS SysTrap: sysTrapFldPaste
   *
   * <P>Defined as: void     FldPaste(FieldPtr field);
   */
  public native static void FldPaste(int field);

  /** PalmOS SysTrap: sysTrapFldRecalculateField
   *
   * <P>Defined as: void     FldRecalculateField(FieldPtr fld, Boolean redraw);
   */
  public native static void FldRecalculateField(int fld, boolean redraw);

  /** PalmOS SysTrap: sysTrapFldReleaseFocus
   *
   * <P>Defined as: void     FldReleaseFocus(FieldPtr fld);
   */
  public native static void FldReleaseFocus(int fld);

  /** PalmOS SysTrap: sysTrapFldScrollable
   *
   * <P>Defined as: Boolean  FldScrollable(FieldPtr fld, DirectionType direction);
   */
  public native static boolean FldScrollable(int fld, int direction);

  /** PalmOS SysTrap: sysTrapFldScrollField
   *
   * <P>Defined as: void     FldScrollField(FieldPtr fld, Word linesToScroll, DirectionType direction);
   */
  public native static void FldScrollField(int fld, int linesToScroll, int direction);

  /** PalmOS SysTrap: sysTrapFldSendChangeNotification
   *
   * <P>Defined as: void     FldSendChangeNotification(FieldPtr fld);
   */
  public native static void FldSendChangeNotification(int fld);

  /** PalmOS SysTrap: sysTrapFldSendHeightChangeNotification
   *
   * <P>Defined as: void     FldSendHeightChangeNotification(FieldPtr fld);
   */
  public native static void FldSendHeightChangeNotification(int fld);

  /** PalmOS SysTrap: sysTrapFldSetAttributes
   *
   * <P>Defined as: void     FldSetAttributes(FieldPtr fld, FieldAttrPtr attrP);
   */
  public native static void FldSetAttributes(int fld, FieldAttr attrP);

  /** PalmOS SysTrap: sysTrapFldSetBounds
   *
   * <P>Defined as: void     FldSetBounds(FieldPtr fld, RectanglePtr rect);
   */
  public native static void FldSetBounds(int fld, Rectangle rect);

  /** PalmOS SysTrap: sysTrapFldSetDirty
   *
   * <P>Defined as: void     FldSetDirty(FieldPtr fld, Boolean dirty);
   */
  public native static void FldSetDirty(int fld, boolean dirty);

  /** PalmOS SysTrap: sysTrapFldSetFont
   *
   * <P>Defined as: void     FldSetFont(FieldPtr fld, FontID fontID);
   */
  public native static void FldSetFont(int fld, int fontID);

  /** PalmOS SysTrap: sysTrapFldSetInsPtPosition
   *
   * <P>Defined as: void     FldSetInsPtPosition(FieldPtr fld, Word pos);
   */
  public native static void FldSetInsPtPosition(int fld, int pos);

  /** PalmOS SysTrap: sysTrapFldSetMaxChars
   *
   * <P>Defined as: void     FldSetMaxChars(FieldPtr fld, Word maxChars);
   */
  public native static void FldSetMaxChars(int fld, int maxChars);

  /** PalmOS SysTrap: sysTrapFldSetScrollPosition
   *
   * <P>Defined as: void     FldSetScrollPosition(FieldPtr fld, Word pos);
   */
  public native static void FldSetScrollPosition(int fld, int pos);

  /** PalmOS SysTrap: sysTrapFldSetSelection
   *
   * <P>Defined as: void     FldSetSelection(FieldPtr fld, Word startPosition, Word endPosition);
   */
  public native static void FldSetSelection(int fld, int startPosition, int endPosition);

  /** PalmOS SysTrap: sysTrapFldSetText
   *
   * <P>Defined as: void     FldSetText(FieldPtr fld, VoidHand textHandle, Word offset, Word size);
   */
  public native static void FldSetText(int fld, int textHandle, int offset, int size);

  /** PalmOS SysTrap: sysTrapFldSetTextAllocatedSize
   *
   * <P>Defined as: void     FldSetTextAllocatedSize(FieldPtr fld, Word allocatedSize);
   */
  public native static void FldSetTextAllocatedSize(int fld, int allocatedSize);

  /** PalmOS SysTrap: sysTrapFldSetTextHandle
   *
   * <P>Defined as: void     FldSetTextHandle(FieldPtr fld, Handle textHandle);
   */
  public native static void FldSetTextHandle(int fld, int textHandle);

  /** PalmOS SysTrap: sysTrapFldSetTextPtr
   *
   * <P>Defined as: void     FldSetTextPtr(FieldPtr fld, CharPtr textP);
   */
  public native static void FldSetTextPtr(int fld, String textP);

  /** PalmOS SysTrap: sysTrapFldSetUsable
   *
   * <P>Defined as: void     FldSetUsable(FieldPtr fld, Boolean usable);
   */
  public native static void FldSetUsable(int fld, boolean usable);

  /** PalmOS SysTrap: sysTrapFldUndo
   *
   * <P>Defined as: void     FldUndo(FieldPtr fld);
   */
  public native static void FldUndo(int fld);

  /** PalmOS SysTrap: sysTrapFldWordWrap
   *
   * <P>Defined as: Word     FldWordWrap(CharPtr chars, Word maxWidth);
   */
  public native static int FldWordWrap(String chars, int maxWidth);

  /** PalmOS SysTrap: sysTrapFldNewField (<B>PalmOS 3.0</B>)
   *
   * <P>Defined as: FieldPtr FldNewField (Ptr formPP, UInt16 id, Coord x, Coord y, Coord width, Coord height, FontID font, UInt32 maxChars, Boolean editable, Boolean underlined, Boolean singleLine, Boolean dynamicSize, JustificationType justification, Boolean autoShift, Boolean hasScrollBar, Boolean numeric);
   */
  public native static int FldNewField(Object formPP, int id, int x, int y, int width, int height, int font, int maxChars, boolean editable, boolean underlined, boolean singleLine, boolean dynamicSize, int justification, boolean autoShift, boolean hasScrollBar, boolean numeric);

  /** PalmOS SysTrap: sysTrapFntAverageCharWidth
   *
   * <P>Defined as: short    FntAverageCharWidth();
   */
  public native static int FntAverageCharWidth();

  /** PalmOS SysTrap: sysTrapFntBaseLine
   *
   * <P>Defined as: short    FntBaseLine();
   */
  public native static int FntBaseLine();

  /** PalmOS SysTrap: sysTrapFntCharHeight
   *
   * <P>Defined as: short    FntCharHeight();
   */
  public native static int FntCharHeight();

  /** PalmOS SysTrap: sysTrapFntCharsInWidth
   *
   * <P>Defined as: void     FntCharsInWidth(CharPtr string, Int* stringWidthP, Int* stringLengthP, Boolean* fitWithinWidth);
   */
  public native static void FntCharsInWidth(String string, ShortHolder stringWidthP, ShortHolder stringLengthP, BoolHolder fitWithinWidth);
  /** PalmOS SysTrap: sysTrapFntCharsInWidth
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     FntCharsInWidth(CharPtr string, Int* stringWidthP, Int* stringLengthP, Boolean* fitWithinWidth);
   */
  public native static void FntCharsInWidth(String string, Short stringWidthP, Short stringLengthP, Boolean fitWithinWidth);

  /** PalmOS SysTrap: sysTrapFntCharsWidth
   *
   * <P>Defined as: short    FntCharsWidth(CharPtr chars, Word length);
   */
  public native static int FntCharsWidth(String chars, int length);

  /** PalmOS SysTrap: sysTrapFntCharsWidth
   *
   * <P>Defined as: short    FntCharsWidth(CharPtr+ chars, Word length);
   */
  public native static int FntCharsWidth(String chars, int _chars_off, int length);

  /** PalmOS SysTrap: sysTrapFntCharsWidth
   *
   * <P>Defined as: short    FntCharsWidth(ByteArray chars, Word length);
   */
  public native static int FntCharsWidth(byte [] chars, int _chars_off, int length);

  /** PalmOS SysTrap: sysTrapFntCharsWidth
   *
   * <P>Defined as: short    FntCharsWidth(CharArray chars, Word length);
   */
  public native static int FntCharsWidth(char [] chars, int _chars_off, int length);

  /** PalmOS SysTrap: sysTrapFntCharWidth
   *
   * <P>Defined as: short    FntCharWidth(byte ch);
   */
  public native static int FntCharWidth(int ch);

  /** PalmOS SysTrap: sysTrapFntDefineFont
   *
   * <P>Defined as: Err      FntDefineFont (FontID font, FontPtr fontP);
   */
  public native static int FntDefineFont(int font, int fontP);

  /** PalmOS SysTrap: sysTrapFntDescenderHeight
   *
   * <P>Defined as: short    FntDescenderHeight();
   */
  public native static int FntDescenderHeight();

  /** PalmOS SysTrap: sysTrapFntGetFont
   *
   * <P>Defined as: FontID   FntGetFont();
   */
  public native static int FntGetFont();

  /** PalmOS SysTrap: sysTrapFntGetFontPtr
   *
   * <P>Defined as: FontPtr  FntGetFontPtr();
   */
  public native static int FntGetFontPtr();

  /** PalmOS SysTrap: sysTrapFntLineHeight
   *
   * <P>Defined as: short    FntLineHeight();
   */
  public native static int FntLineHeight();

  /** PalmOS SysTrap: sysTrapFntLineWidth
   *
   * <P>Defined as: short    FntLineWidth(CharPtr chars, Word length);
   */
  public native static int FntLineWidth(String chars, int length);

  /** PalmOS SysTrap: sysTrapFntLineWidth
   *
   * <P>Defined as: short    FntLineWidth(CharPtr+ chars, Word length);
   */
  public native static int FntLineWidth(String chars, int _chars_off, int length);

  /** PalmOS SysTrap: sysTrapFntLineWidth
   *
   * <P>Defined as: short    FntLineWidth(const ByteArray chars, Word length);
   */
  public native static int FntLineWidth(byte [] chars, int _chars_off, int length);

  /** PalmOS SysTrap: sysTrapFntLineWidth
   *
   * <P>Defined as: short    FntLineWidth(const CharArray chars, Word length);
   */
  public native static int FntLineWidth(char [] chars, int _chars_off, int length);

  /** PalmOS SysTrap: sysTrapFntSetFont
   *
   * <P>Defined as: FontID   FntSetFont(FontID fontID);
   */
  public native static int FntSetFont(int fontID);

  /** PalmOS SysTrap: sysTrapFontSelect
   *
   * <P>Defined as: FontID FontSelect (FontID fontID);
   */
  public native static int FontSelect(int fontID);

  /** PalmOS SysTrap: sysTrapFrmAlert
   *
   * <P>Defined as: Word     FrmAlert(Word alertId);
   */
  public native static int FrmAlert(int alertId);

  /** PalmOS SysTrap: sysTrapFrmCloseAllForms
   *
   * <P>Defined as: void     FrmCloseAllForms();
   */
  public native static void FrmCloseAllForms();

  /** PalmOS SysTrap: sysTrapFrmCopyLabel
   *
   * <P>Defined as: void     FrmCopyLabel(FormPtr frm, Word labelID, CharPtr newLabel);
   */
  public native static void FrmCopyLabel(int frm, int labelID, String newLabel);

  /** PalmOS SysTrap: sysTrapFrmCopyTitle
   *
   * <P>Defined as: void     FrmCopyTitle(FormPtr frm, CharPtr newTitle);
   */
  public native static void FrmCopyTitle(int frm, String newTitle);

  /** PalmOS SysTrap: sysTrapFrmCustomAlert
   *
   * <P>Defined as: Word     FrmCustomAlert(Word alertId, CharPtr s1, CharPtr s2, CharPtr s3);
   */
  public native static int FrmCustomAlert(int alertId, String s1, String s2, String s3);

  /** PalmOS SysTrap: sysTrapFrmDeleteForm
   *
   * <P>Defined as: void     FrmDeleteForm(FormPtr frm);
   */
  public native static void FrmDeleteForm(int frm);

  /** PalmOS SysTrap: sysTrapFrmDispatchEvent
   *
   * <P>Defined as: Boolean  FrmDispatchEvent(EventPtr eventP);
   */
  public native static boolean FrmDispatchEvent(Event eventP);

  /** PalmOS SysTrap: sysTrapFrmDoDialog
   *
   * <P>Defined as: Word     FrmDoDialog(FormPtr frm);
   */
  public native static int FrmDoDialog(int frm);

  /** PalmOS SysTrap: sysTrapFrmDrawForm
   *
   * <P>Defined as: void     FrmDrawForm(FormPtr frm);
   */
  public native static void FrmDrawForm(int frm);

  /** PalmOS SysTrap: sysTrapFrmEraseForm
   *
   * <P>Defined as: void     FrmEraseForm(FormPtr frm);
   */
  public native static void FrmEraseForm(int frm);

  /** PalmOS SysTrap: sysTrapFrmGetActiveForm
   *
   * <P>Defined as: FormPtr  FrmGetActiveForm();
   */
  public native static int FrmGetActiveForm();

  /** PalmOS SysTrap: sysTrapFrmGetActiveFormID
   *
   * <P>Defined as: Word     FrmGetActiveFormID();
   */
  public native static int FrmGetActiveFormID();

  /** PalmOS SysTrap: sysTrapFrmGetControlGroupSelection
   *
   * <P>Defined as: Byte     FrmGetControlGroupSelection(FormPtr frm, Byte groupNum);
   */
  public native static byte FrmGetControlGroupSelection(int frm, int groupNum);

  /** PalmOS SysTrap: sysTrapFrmGetControlValue
   *
   * <P>Defined as: short    FrmGetControlValue(FormPtr frm, Word objIndex);
   */
  public native static int FrmGetControlValue(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmGetFirstForm
   *
   * <P>Defined as: FormPtr  FrmGetFirstForm();
   */
  public native static int FrmGetFirstForm();

  /** PalmOS SysTrap: sysTrapFrmGetFocus
   *
   * <P>Defined as: Word     FrmGetFocus(FormPtr frm);
   */
  public native static int FrmGetFocus(int frm);

  /** PalmOS SysTrap: sysTrapFrmGetFormBounds
   *
   * <P>Defined as: void     FrmGetFormBounds(FormPtr frm, RectanglePtr r);
   */
  public native static void FrmGetFormBounds(int frm, Rectangle r);

  /** PalmOS SysTrap: sysTrapFrmGetFormId
   *
   * <P>Defined as: Word     FrmGetFormId(FormPtr frm);
   */
  public native static int FrmGetFormId(int frm);

  /** PalmOS SysTrap: sysTrapFrmGetFormPtr
   *
   * <P>Defined as: FormPtr  FrmGetFormPtr(Word formId);
   */
  public native static int FrmGetFormPtr(int formId);

  /** PalmOS SysTrap: sysTrapFrmGetGadgetData
   *
   * <P>Defined as: VoidPtr  FrmGetGadgetData(FormPtr frm, Word objIndex);
   */
  public native static int FrmGetGadgetData(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmGetLabel
   *
   * <P>Defined as: CharPtr  FrmGetLabel(FormPtr frm, Word labelID);
   */
  public native static String FrmGetLabel(int frm, int labelID);

  /** PalmOS SysTrap: sysTrapFrmGetNumberOfObjects
   *
   * <P>Defined as: Word     FrmGetNumberOfObjects(FormPtr frm);
   */
  public native static int FrmGetNumberOfObjects(int frm);

  /** PalmOS SysTrap: sysTrapFrmGetObjectBounds
   *
   * <P>Defined as: void     FrmGetObjectBounds(FormPtr frm, Word ObjIndex, RectanglePtr r);
   */
  public native static void FrmGetObjectBounds(int frm, int ObjIndex, Rectangle r);

  /** PalmOS SysTrap: sysTrapFrmGetObjectId
   *
   * <P>Defined as: Word     FrmGetObjectId(FormPtr frm, Word objIndex);
   */
  public native static int FrmGetObjectId(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmGetObjectIndex
   *
   * <P>Defined as: Word     FrmGetObjectIndex(FormPtr frm, Word objID);
   */
  public native static int FrmGetObjectIndex(int frm, int objID);

  /** PalmOS SysTrap: sysTrapFrmGetObjectPosition
   *
   * <P>Defined as: void     FrmGetObjectPosition(FormPtr frm, Word objIndex, SWordPtr x, SWordPtr y);
   */
  public native static void FrmGetObjectPosition(int frm, int objIndex, ShortHolder x, ShortHolder y);
  /** PalmOS SysTrap: sysTrapFrmGetObjectPosition
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     FrmGetObjectPosition(FormPtr frm, Word objIndex, SWordPtr x, SWordPtr y);
   */
  public native static void FrmGetObjectPosition(int frm, int objIndex, Short x, Short y);

  /** PalmOS SysTrap: sysTrapFrmGetObjectPtr
   *
   * <P>Defined as: Handle   FrmGetObjectPtr(FormPtr frm, Word objIndex);
   */
  public native static int FrmGetObjectPtr(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmGetObjectType
   *
   * <P>Defined as: FormObjectKind FrmGetObjectType(FormPtr frm, Word objIndex);
   */
  public native static int FrmGetObjectType(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmGetTitle
   *
   * <P>Defined as: CharPtr  FrmGetTitle(FormPtr frm);
   */
  public native static String FrmGetTitle(int frm);

  /** PalmOS SysTrap: sysTrapFrmGetUserModifiedState
   *
   * <P>Defined as: Boolean  FrmGetUserModifiedState(FormPtr frm);
   */
  public native static boolean FrmGetUserModifiedState(int frm);

  /** PalmOS SysTrap: sysTrapFrmGetWindowHandle
   *
   * <P>Defined as: WinHandle FrmGetWindowHandle(FormPtr frm);
   */
  public native static int FrmGetWindowHandle(int frm);

  /** PalmOS SysTrap: sysTrapFrmGotoForm
   *
   * <P>Defined as: void     FrmGotoForm(Word formId);
   */
  public native static void FrmGotoForm(int formId);

  /** PalmOS SysTrap: sysTrapFrmHandleEvent
   *
   * <P>Defined as: Boolean  FrmHandleEvent(FormPtr frm, EventPtr event);
   */
  public native static boolean FrmHandleEvent(int frm, Event event);

  /** PalmOS SysTrap: sysTrapFrmHelp
   *
   * <P>Defined as: void     FrmHelp(Word helpMsgId);
   */
  public native static void FrmHelp(int helpMsgId);

  /** PalmOS SysTrap: sysTrapFrmHideObject
   *
   * <P>Defined as: void     FrmHideObject(FormPtr frm, Word objIndex);
   */
  public native static void FrmHideObject(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmInitForm
   *
   * <P>Defined as: FormPtr  FrmInitForm(Word rscID);
   */
  public native static int FrmInitForm(int rscID);

  /** PalmOS SysTrap: sysTrapFrmPopupForm
   *
   * <P>Defined as: void     FrmPopupForm(Word formId);
   */
  public native static void FrmPopupForm(int formId);

  /** PalmOS SysTrap: sysTrapFrmReturnToForm
   *
   * <P>Defined as: void     FrmReturnToForm(Word formId);
   */
  public native static void FrmReturnToForm(int formId);

  /** PalmOS SysTrap: sysTrapFrmSaveAllForms
   *
   * <P>Defined as: void     FrmSaveAllForms();
   */
  public native static void FrmSaveAllForms();

  /** PalmOS SysTrap: sysTrapFrmSetActiveForm
   *
   * <P>Defined as: void     FrmSetActiveForm(FormPtr formptr);
   */
  public native static void FrmSetActiveForm(int formptr);

  /** PalmOS SysTrap: sysTrapFrmSetCategoryLabel
   *
   * <P>Defined as: void     FrmSetCategoryLabel(FormPtr formptr, Word objIndex, CharPtr newLabel);
   */
  public native static void FrmSetCategoryLabel(int formptr, int objIndex, String newLabel);

  /** PalmOS SysTrap: sysTrapFrmSetControlGroupSelection
   *
   * <P>Defined as: void     FrmSetControlGroupSelection(FormPtr formptr, Byte groupNum, Word controlID);
   */
  public native static void FrmSetControlGroupSelection(int formptr, int groupNum, int controlID);

  /** PalmOS SysTrap: sysTrapFrmSetControlValue
   *
   * <P>Defined as: void     FrmSetControlValue(FormPtr formptr, Word objIndex, short newValue);
   */
  public native static void FrmSetControlValue(int formptr, int objIndex, int newValue);

  /** PalmOS SysTrap: sysTrapFrmSetEventHandler
   *
   * <P>Defined as: void     FrmSetEventHandler(FormPtr formptr, const FormEventHandlerPtr handler);
   */
  public native static void FrmSetEventHandler(int formptr, FormEventHandler handler);

  /** PalmOS SysTrap: sysTrapFrmSetFocus
   *
   * <P>Defined as: void     FrmSetFocus(FormPtr frm, Word objIndex);
   */
  public native static void FrmSetFocus(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmSetGadgetData
   *
   * <P>Defined as: void     FrmSetGadgetData(FormPtr frm, Word objIndex, VoidPtr data);
   */
  public native static void FrmSetGadgetData(int frm, int objIndex, Object data);

  /** PalmOS SysTrap: sysTrapFrmSetNotUserModified
   *
   * <P>Defined as: void     FrmSetNotUserModified(FormPtr frm);
   */
  public native static void FrmSetNotUserModified(int frm);

  /** PalmOS SysTrap: sysTrapFrmSetObjectPosition
   *
   * <P>Defined as: void     FrmSetObjectPosition(FormPtr frm, Word objIndex, SWord x, SWord y);
   */
  public native static void FrmSetObjectPosition(int frm, int objIndex, int x, int y);

  /** PalmOS SysTrap: sysTrapFrmSetTitle
   *
   * <P>Defined as: void     FrmSetTitle(FormPtr frm, CharPtr newTitle);
   */
  public native static void FrmSetTitle(int frm, String newTitle);

  /** PalmOS SysTrap: sysTrapFrmShowObject
   *
   * <P>Defined as: void     FrmShowObject(FormPtr frm, Word objIndex);
   */
  public native static void FrmShowObject(int frm, int objIndex);

  /** PalmOS SysTrap: sysTrapFrmUpdateScrollers
   *
   * <P>Defined as: void     FrmUpdateScrollers(FormPtr frm, Word upIndex, Word downIndex, Boolean scrollableUp, Boolean scrollableDown);
   */
  public native static void FrmUpdateScrollers(int frm, int upIndex, int downIndex, boolean scrollableUp, boolean scrollableDown);

  /** PalmOS SysTrap: sysTrapFrmUpdateForm
   *
   * <P>Defined as: void     FrmUpdateForm(Word formId, Word updateCode);
   */
  public native static void FrmUpdateForm(int formId, int updateCode);

  /** PalmOS SysTrap: sysTrapFrmVisible
   *
   * <P>Defined as: Boolean  FrmVisible(FormPtr frm);
   */
  public native static boolean FrmVisible(int frm);

  /** PalmOS SysTrap: sysTrapFrmNewForm (<B>PalmOS 3.0</B>)
   *
   * <P>Defined as: FormPtr  FrmNewForm (Word formID, CharPtr titleStrP, Coord x, Coord y, Coord width, Coord height, Boolean modal, Word defaultButton, Word helpRscID, Word menuRscID);
   */
  public native static int FrmNewForm(int formID, String titleStrP, int x, int y, int width, int height, boolean modal, int defaultButton, int helpRscID, int menuRscID);

  /** PalmOS SysTrap: sysTrapFrmValidatePtr (<B>PalmOS 3.0</B>)
   *
   * <P>Defined as: Boolean  FrmValidatePtr (FormPtr formP);
   */
  public native static boolean FrmValidatePtr(int formP);
        /** value of creator for FtrGet */
        public static final int sysFtrCreator = ((int)'p'<<24)|((int)'s'<<16)|((int)'y'<<8)|(int)'s';
        public static final int sysFtrNumROMVersion     = 1;
        public static final int sysFtrNumBacklight = 3;
        public static final int sysFtrNumEncryption = 4;
        public static final int sysFtrNumCountry = 5;
        public static final int sysFtrNumLanguage = 6;
        public static final int sysFtrNumDisplayDepth = 7;
        public static final int sysFtrNumIntlMgr = 10;
        public static final int sysFtrNumEncoding = 11;
        public static final int sysFtrDefaultFont = 12;
        public static final int sysFtrDefaultBoldFont = 13;
        public static final int sysFtrNumGremlinsSupportGlobals = 14;
        public static final int sysFtrNumVendor = 15;
        public static final int sysFtrNumCharEncodingFlags = 16;
        public static final int sysFtrNumNotifyMgrVersion = 17;
        public static final int sysFtrNumOEMROMVersion = 18;
        public static final int sysFtrNumErrorCheckLevel = 19;
        public static final int sysFtrNumOEMCompanyID = 20;
        public static final int sysFtrNumOEMDeviceID = 21;
        public static final int sysFtrNumOEMHALID = 22;
        public static final int sysFtrNumDefaultCompression = 23;
        public static final int sysFtrNumWinVersion = 24;
        public static final int sysFtrNumAccessorTrapPresent = 25;
        public static final int sysFtrNumInputAreaFlags = 26;
        /** value of creator for FtrGet */
        public static final int sysFileCSerialMgr = ((int)'s'<<24)|((int)'m'<<16)|((int)'g'<<8)|(int)'r';
        public static final int sysFtrNewSerialPresent = 1;
        public static final int sysFtrNewSerialVersion = 2;
        /** value of creator for FtrGet */
        public static final int sysFileCExpansionMgr = ((int)'e'<<24)|((int)'x'<<16)|((int)'p'<<8)|(int)'n';
        public static final int expFtrIDVersion = 0;
        /** value of creator for FtrGet */
        public static final int sysFileCVFSMgr = ((int)'v'<<24)|((int)'f'<<16)|((int)'s'<<8)|(int)'m';
        public static final int vfsFtrIDVersion = 0;
        public static final int vfsFtrIDDefaultFS = 1;
        /** value of creator for FtrGet */
        public static final int netFtrCreator = ((int)'n'<<24)|((int)'e'<<16)|((int)'t'<<8)|(int)'l';
        public static final int netFtrNumVersion = 0;

  /** PalmOS SysTrap: sysTrapFtrGet
   *
   * <P>Defined as: Err      FtrGet(DWord creator, UInt featureNum, DWordPtr value);
   */
  public native static int FtrGet(int creator, int featureNum, IntHolder value);
  /** PalmOS SysTrap: sysTrapFtrGet
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      FtrGet(DWord creator, UInt featureNum, DWordPtr value);
   */
  public native static int FtrGet(int creator, int featureNum, Integer value);

  /** PalmOS SysTrap: sysTrapFtrGet
   *
   * <P>Defined as: Err      FtrGet(DWord creator, UInt featureNum, IntArray value);
   */
  public native static int FtrGet(int creator, int featureNum, int [] value, int _value_off);

  /** PalmOS SysTrap: sysTrapFtrGetByIndex
   *
   * <P>Defined as: Err      FtrGetByIndex(UInt index, Boolean romTable, DWordPtr creatorP, UIntPtr numP, DWordPtr valueP);
   */
  public native static int FtrGetByIndex(int index, boolean romTable, IntHolder creatorP, ShortHolder numP, IntHolder valueP);
  /** PalmOS SysTrap: sysTrapFtrGetByIndex
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      FtrGetByIndex(UInt index, Boolean romTable, DWordPtr creatorP, UIntPtr numP, DWordPtr valueP);
   */
  public native static int FtrGetByIndex(int index, boolean romTable, Integer creatorP, Short numP, Integer valueP);

  /** PalmOS SysTrap: sysTrapFtrSet
   *
   * <P>Defined as: Err      FtrSet(DWord creator, UInt featureNum, DWord newValue);
   */
  public native static int FtrSet(int creator, int featureNum, int newValue);

  /** PalmOS SysTrap: sysTrapFtrUnregister
   *
   * <P>Defined as: Err      FtrUnregister(DWord creator, UInt featureNum);
   */
  public native static int FtrUnregister(int creator, int featureNum);

  /** PalmOS SysTrap: sysTrapGrfAddMacro
   *
   * <P>Defined as: Err      GrfAddMacro(CharPtr nameP, VoidPtr macroDataP, Word dataLen);
   */
  public native static int GrfAddMacro(String nameP, Object macroDataP, int dataLen);

  /** PalmOS SysTrap: sysTrapGrfAddPoint
   *
   * <P>Defined as: Err      GrfAddPoint(PointType* ptP);
   */
  public native static int GrfAddPoint(PointType ptP);

  /** PalmOS SysTrap: sysTrapGrfCleanState
   *
   * <P>Defined as: Err      GrfCleanState();
   */
  public native static int GrfCleanState();

  /** PalmOS SysTrap: sysTrapGrfDeleteMacro
   *
   * <P>Defined as: Err      GrfDeleteMacro(Word index);
   */
  public native static int GrfDeleteMacro(int index);

  /** PalmOS SysTrap: sysTrapGrfFindBranch
   *
   * <P>Defined as: Err      GrfFindBranch(Word flags);
   */
  public native static int GrfFindBranch(int flags);

  /** PalmOS SysTrap: sysTrapGrfFilterPoints
   *
   * <P>Defined as: Err      GrfFilterPoints();
   */
  public native static int GrfFilterPoints();

  /** PalmOS SysTrap: sysTrapGrfFlushPoints
   *
   * <P>Defined as: Err      GrfFlushPoints();
   */
  public native static int GrfFlushPoints();

  /** PalmOS SysTrap: sysTrapGrfGetAndExpandMacro
   *
   * <P>Defined as: Err      GrfGetAndExpandMacro(CharPtr nameP, VoidPtr macroDataP, WordPtr dataLenP);
   */
  public native static int GrfGetAndExpandMacro(String nameP, Object macroDataP, ShortHolder dataLenP);
  /** PalmOS SysTrap: sysTrapGrfGetAndExpandMacro
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      GrfGetAndExpandMacro(CharPtr nameP, VoidPtr macroDataP, WordPtr dataLenP);
   */
  public native static int GrfGetAndExpandMacro(String nameP, Object macroDataP, Short dataLenP);

  /** PalmOS SysTrap: sysTrapGrfGetGlyphMapping
   *
   * <P>Defined as: Err      GrfGetGlyphMapping(Word glyphID, WordPtr flagsP, void* dataPtrP, WordPtr dataLenP, WordPtr uncertainLenP);
   */
  public native static int GrfGetGlyphMapping(int glyphID, ShortHolder flagsP, Object dataPtrP, ShortHolder dataLenP, ShortHolder uncertainLenP);
  /** PalmOS SysTrap: sysTrapGrfGetGlyphMapping
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      GrfGetGlyphMapping(Word glyphID, WordPtr flagsP, void* dataPtrP, WordPtr dataLenP, WordPtr uncertainLenP);
   */
  public native static int GrfGetGlyphMapping(int glyphID, Short flagsP, Object dataPtrP, Short dataLenP, Short uncertainLenP);

  /** PalmOS SysTrap: sysTrapGrfGetMacro
   *
   * <P>Defined as: Err      GrfGetMacro(CharPtr nameP, VoidPtr macroDataP, WordPtr dataLenP);
   */
  public native static int GrfGetMacro(String nameP, Object macroDataP, ShortHolder dataLenP);
  /** PalmOS SysTrap: sysTrapGrfGetMacro
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      GrfGetMacro(CharPtr nameP, VoidPtr macroDataP, WordPtr dataLenP);
   */
  public native static int GrfGetMacro(String nameP, Object macroDataP, Short dataLenP);

  /** PalmOS SysTrap: sysTrapGrfGetMacroName
   *
   * <P>Defined as: Err      GrfGetMacroName(Word index, CharPtr nameP);
   */
  public native static int GrfGetMacroName(int index, String nameP);

  /** PalmOS SysTrap: sysTrapGrfGetNumPoints
   *
   * <P>Defined as: Err      GrfGetNumPoints(WordPtr numPtsP);
   */
  public native static int GrfGetNumPoints(ShortHolder numPtsP);
  /** PalmOS SysTrap: sysTrapGrfGetNumPoints
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      GrfGetNumPoints(WordPtr numPtsP);
   */
  public native static int GrfGetNumPoints(Short numPtsP);

  /** PalmOS SysTrap: sysTrapGrfGetPoint
   *
   * <P>Defined as: Err      GrfGetPoint(Word index, PointType* pointP);
   */
  public native static int GrfGetPoint(int index, PointType pointP);

  /** PalmOS SysTrap: sysTrapGrfGetState
   *
   * <P>Defined as: Err      GrfGetState(Boolean* capsLockP, Boolean* numLockP, WordPtr tempShiftP, Boolean* autoShiftedP);
   */
  public native static int GrfGetState(BoolHolder capsLockP, BoolHolder numLockP, ShortHolder tempShiftP, BoolHolder autoShiftedP);
  /** PalmOS SysTrap: sysTrapGrfGetState
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      GrfGetState(Boolean* capsLockP, Boolean* numLockP, WordPtr tempShiftP, Boolean* autoShiftedP);
   */
  public native static int GrfGetState(Boolean capsLockP, Boolean numLockP, Short tempShiftP, Boolean autoShiftedP);

  /** PalmOS SysTrap: sysTrapGrfInitState
   *
   * <P>Defined as: Err      GrfInitState();
   */
  public native static int GrfInitState();

  /** PalmOS SysTrap: sysTrapGrfProcessStroke
   *
   * <P>Defined as: Err      GrfProcessStroke(PointType* startPtP, PointType* endPtP, Boolean upShift);
   */
  public native static int GrfProcessStroke(PointType startPtP, PointType endPtP, boolean upShift);

  /** PalmOS SysTrap: sysTrapGrfSetState
   *
   * <P>Defined as: Err      GrfSetState(Boolean capsLock, Boolean numLock, Boolean upperShift);
   */
  public native static int GrfSetState(boolean capsLock, boolean numLock, boolean upperShift);

  /** PalmOS SysTrap: sysTrapGsiEnable
   *
   * <P>Defined as: void     GsiEnable(Boolean enableIt);
   */
  public native static void GsiEnable(boolean enableIt);

  /** PalmOS SysTrap: sysTrapGsiEnabled
   *
   * <P>Defined as: Boolean  GsiEnabled();
   */
  public native static boolean GsiEnabled();

  /** PalmOS SysTrap: sysTrapGsiInitialize
   *
   * <P>Defined as: void     GsiInitialize();
   */
  public native static void GsiInitialize();

  /** PalmOS SysTrap: sysTrapGsiSetLocation
   *
   * <P>Defined as: void     GsiSetLocation(short x, short y);
   */
  public native static void GsiSetLocation(int x, int y);

  /** PalmOS SysTrap: sysTrapGsiSetShiftState
   *
   * <P>Defined as: void     GsiSetShiftState(Word lockFlags, Word tempShift);
   */
  public native static void GsiSetShiftState(int lockFlags, int tempShift);

  /** PalmOS SysTrap: sysTrapHwrBacklight
   *
   * <P>Defined as: Boolean  HwrBacklight(Boolean set, Boolean newState);
   * <P>Only for OS 3.5 and earlier
   */
  public native static boolean HwrBacklight(boolean set, boolean newState);

  /** PalmOS SysTrap: sysTrapHwrDisplayAttributes (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err      HwrDisplayAttributes(Boolean set, UInt8 hwrDisplayAttrType, VoidPtr dataP);
   */
  public native static int HwrDisplayAttributes(boolean set, int hwrDisplayAttrType, Object dataP);

  /** PalmOS SysTrap: sysTrapInsPtEnable
   *
   * <P>Defined as: void     InsPtEnable(Boolean enableIt);
   */
  public native static void InsPtEnable(boolean enableIt);

  /** PalmOS SysTrap: sysTrapInsPtEnabled
   *
   * <P>Defined as: Boolean  InsPtEnabled();
   */
  public native static boolean InsPtEnabled();

  /** PalmOS SysTrap: sysTrapInsPtGetHeight
   *
   * <P>Defined as: short    InsPtGetHeight();
   */
  public native static int InsPtGetHeight();

  /** PalmOS SysTrap: sysTrapInsPtGetLocation
   *
   * <P>Defined as: void     InsPtGetLocation(shortPtr x, shortPtr y);
   */
  public native static void InsPtGetLocation(ShortHolder x, ShortHolder y);
  /** PalmOS SysTrap: sysTrapInsPtGetLocation
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     InsPtGetLocation(shortPtr x, shortPtr y);
   */
  public native static void InsPtGetLocation(Short x, Short y);

  /** PalmOS SysTrap: sysTrapInsPtSetHeight
   *
   * <P>Defined as: void     InsPtSetHeight(short height);
   */
  public native static void InsPtSetHeight(int height);

  /** PalmOS SysTrap: sysTrapInsPtSetLocation
   *
   * <P>Defined as: void     InsPtSetLocation(short x, short y);
   */
  public native static void InsPtSetLocation(int x, int y);

  /** PalmOS SysTrap: sysTrapKeyCurrentState
   *
   * <P>Defined as: DWord    KeyCurrentState();
   */
  public native static int KeyCurrentState();

  /** PalmOS SysTrap: sysTrapKeyRates
   *
   * <P>Defined as: Err      KeyRates(Boolean set, WordPtr initDelayP, WordPtr periodP, WordPtr doubleTapDelayP, BooleanPtr queueAheadP);
   */
  public native static int KeyRates(boolean set, ShortHolder initDelayP, ShortHolder periodP, ShortHolder doubleTapDelayP, BoolHolder queueAheadP);
  /** PalmOS SysTrap: sysTrapKeyRates
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      KeyRates(Boolean set, WordPtr initDelayP, WordPtr periodP, WordPtr doubleTapDelayP, BooleanPtr queueAheadP);
   */
  public native static int KeyRates(boolean set, Short initDelayP, Short periodP, Short doubleTapDelayP, Boolean queueAheadP);

  /** PalmOS SysTrap: sysTrapLstDrawList
   *
   * <P>Defined as: void     LstDrawList(ListPtr ListP);
   */
  public native static void LstDrawList(int ListP);

  /** PalmOS SysTrap: sysTrapLstEraseList
   *
   * <P>Defined as: void     LstEraseList(ListPtr ListP);
   */
  public native static void LstEraseList(int ListP);

  /** PalmOS SysTrap: sysTrapLstGetNumberOfItems
   *
   * <P>Defined as: Word     LstGetNumberOfItems(ListPtr ListP);
   */
  public native static int LstGetNumberOfItems(int ListP);

  /** PalmOS SysTrap: sysTrapLstGetSelection
   *
   * <P>Defined as: Word     LstGetSelection(ListPtr ListP);
   */
  public native static int LstGetSelection(int ListP);

  /** PalmOS SysTrap: sysTrapLstGetSelectionText
   *
   * <P>Defined as: CharPtr  LstGetSelectionText(ListPtr ListP, Word itemNum);
   */
  public native static String LstGetSelectionText(int ListP, int itemNum);

  /** PalmOS SysTrap: sysTrapLstHandleEvent
   *
   * <P>Defined as: Boolean  LstHandleEvent(ListPtr ListP, EventPtr pEvent);
   */
  public native static boolean LstHandleEvent(int ListP, Event pEvent);

  /** PalmOS SysTrap: sysTrapLstMakeItemVisible
   *
   * <P>Defined as: void     LstMakeItemVisible(ListPtr ListP, Word itemNum);
   */
  public native static void LstMakeItemVisible(int ListP, int itemNum);

  /** PalmOS SysTrap: sysTrapLstPopupList
   *
   * <P>Defined as: short    LstPopupList(ListPtr ListP);
   */
  public native static int LstPopupList(int ListP);

  /** PalmOS SysTrap: sysTrapLstSetHeight
   *
   * <P>Defined as: void     LstSetHeight(ListPtr ListP, Word visibleItems);
   */
  public native static void LstSetHeight(int ListP, int visibleItems);

  /** PalmOS SysTrap: sysTrapLstSetListChoices
   *
   * <P>Defined as: void     LstSetListChoices(ListPtr ListP, char** itemsText, UInt numItems);
   */
  public native static void LstSetListChoices(int ListP, CharPtrArray itemsText, int numItems);

  /** PalmOS SysTrap: sysTrapLstSetPosition
   *
   * <P>Defined as: void     LstSetPosition(ListPtr ListP, short x, short y);
   */
  public native static void LstSetPosition(int ListP, int x, int y);

  /** PalmOS SysTrap: sysTrapLstSetSelection
   *
   * <P>Defined as: void     LstSetSelection(ListPtr ListP, Word itemNum);
   */
  public native static void LstSetSelection(int ListP, int itemNum);

  /** PalmOS SysTrap: sysTrapLstSetTopItem
   *
   * <P>Defined as: void     LstSetTopItem(ListPtr ListP, UInt itemNum);
   */
  public native static void LstSetTopItem(int ListP, int itemNum);

  /** PalmOS SysTrap: sysTrapMemCardInfo
   *
   * <P>Defined as: Err      MemCardInfo(UInt cardNo, CharBuf cardNameP, CharBuf manufNamP, UIntPtr versionP, ULongPtr crDateP, ULongPtr romSizeP, ULongPtr ramSizeP, ULongPtr freeBytesP);
   */
  public native static int MemCardInfo(int cardNo, StringBuffer cardNameP, StringBuffer manufNamP, ShortHolder versionP, IntHolder crDateP, IntHolder romSizeP, IntHolder ramSizeP, IntHolder freeBytesP);
  /** PalmOS SysTrap: sysTrapMemCardInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      MemCardInfo(UInt cardNo, CharBuf cardNameP, CharBuf manufNamP, UIntPtr versionP, ULongPtr crDateP, ULongPtr romSizeP, ULongPtr ramSizeP, ULongPtr freeBytesP);
   */
  public native static int MemCardInfo(int cardNo, StringBuffer cardNameP, StringBuffer manufNamP, Short versionP, Integer crDateP, Integer romSizeP, Integer ramSizeP, Integer freeBytesP);

  /** PalmOS SysTrap: sysTrapMemChunkFree
   *
   * <P>Defined as: Err      MemChunkFree(voidptr chunkDataP);
   */
  public native static int MemChunkFree(int chunkDataP);

  /** PalmOS SysTrap: sysTrapMemDebugMode
   *
   * <P>Defined as: Word     MemDebugMode();
   */
  public native static int MemDebugMode();

  /** PalmOS SysTrap: sysTrapMemHandleDataStorage
   *
   * <P>Defined as: Boolean  MemHandleDataStorage(VoidHand h);
   */
  public native static boolean MemHandleDataStorage(int h);

  /** PalmOS SysTrap: sysTrapMemHandleCardNo
   *
   * <P>Defined as: UInt     MemHandleCardNo(VoidHand h);
   */
  public native static int MemHandleCardNo(int h);

  /** PalmOS SysTrap: sysTrapMemHandleFree
   *
   * <P>Defined as: Err      MemHandleFree(VoidHand h);
   */
  public native static int MemHandleFree(int h);

  /** PalmOS SysTrap: sysTrapMemHandleHeapID
   *
   * <P>Defined as: UInt     MemHandleHeapID(VoidHand h);
   */
  public native static int MemHandleHeapID(int h);

  /** PalmOS SysTrap: sysTrapMemHandleLock
   *
   * <P>Defined as: VoidPtr  MemHandleLock(VoidHand h);
   */
  public native static int MemHandleLock(int h);

  /** PalmOS SysTrap: sysTrapMemHandleNew
   *
   * <P>Defined as: VoidHand MemHandleNew(ULong size);
   */
  public native static int MemHandleNew(int size);

  /** PalmOS SysTrap: sysTrapMemHandleResize
   *
   * <P>Defined as: Err      MemHandleResize(VoidHand h, ULong newSize);
   */
  public native static int MemHandleResize(int h, int newSize);

  /** PalmOS SysTrap: sysTrapMemHandleSize
   *
   * <P>Defined as: ULong    MemHandleSize(VoidHand h);
   */
  public native static int MemHandleSize(int h);

  /** PalmOS SysTrap: sysTrapMemHandleToLocalID
   *
   * <P>Defined as: LocalID  MemHandleToLocalID(VoidHand h);
   */
  public native static int MemHandleToLocalID(int h);

  /** PalmOS SysTrap: sysTrapMemHandleUnlock
   *
   * <P>Defined as: Err      MemHandleUnlock(VoidHand h);
   */
  public native static int MemHandleUnlock(int h);

  /** PalmOS SysTrap: sysTrapMemHeapCheck
   *
   * <P>Defined as: Err      MemHeapCheck(UInt heapID);
   */
  public native static int MemHeapCheck(int heapID);

  /** PalmOS SysTrap: sysTrapMemHeapCompact
   *
   * <P>Defined as: Err      MemHeapCompact(UInt heapID);
   */
  public native static int MemHeapCompact(int heapID);

  /** PalmOS SysTrap: sysTrapMemHeapDynamic
   *
   * <P>Defined as: Boolean  MemHeapDynamic(UInt heapID);
   */
  public native static boolean MemHeapDynamic(int heapID);

  /** PalmOS SysTrap: sysTrapMemHeapFlags
   *
   * <P>Defined as: UInt     MemHeapFlags(UInt heapID);
   */
  public native static int MemHeapFlags(int heapID);

  /** PalmOS SysTrap: sysTrapMemHeapFreeBytes
   *
   * <P>Defined as: Err      MemHeapFreeBytes(UInt heapID, ULongPtr freeP, ULongPtr maxP);
   */
  public native static int MemHeapFreeBytes(int heapID, IntHolder freeP, IntHolder maxP);
  /** PalmOS SysTrap: sysTrapMemHeapFreeBytes
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      MemHeapFreeBytes(UInt heapID, ULongPtr freeP, ULongPtr maxP);
   */
  public native static int MemHeapFreeBytes(int heapID, Integer freeP, Integer maxP);

  /** PalmOS SysTrap: sysTrapMemHeapID
   *
   * <P>Defined as: UInt     MemHeapID(UInt cardNo, UInt heapIndex);
   */
  public native static int MemHeapID(int cardNo, int heapIndex);

  /** PalmOS SysTrap: sysTrapMemHeapScramble
   *
   * <P>Defined as: Err      MemHeapScramble(UInt heapID);
   */
  public native static int MemHeapScramble(int heapID);

  /** PalmOS SysTrap: sysTrapMemHeapSize
   *
   * <P>Defined as: ULong    MemHeapSize(UInt heapID);
   */
  public native static int MemHeapSize(int heapID);

  /** PalmOS SysTrap: sysTrapMemLocalIDKind
   *
   * <P>Defined as: LocalIDKind MemLocalIDKind(LocalID local);
   */
  public native static int MemLocalIDKind(int local);

  /** PalmOS SysTrap: sysTrapMemLocalIDToGlobal
   *
   * <P>Defined as: VoidPtr  MemLocalIDToGlobal(LocalID local, UInt cardNo);
   */
  public native static int MemLocalIDToGlobal(int local, int cardNo);

  /** PalmOS SysTrap: sysTrapMemLocalIDToLockedPtr
   *
   * <P>Defined as: VoidPtr  MemLocalIDToLockedPtr(LocalID local, UInt cardNo);
   */
  public native static int MemLocalIDToLockedPtr(int local, int cardNo);

  /** PalmOS SysTrap: sysTrapMemLocalIDToPtr
   *
   * <P>Defined as: VoidPtr  MemLocalIDToPtr(LocalID local, UInt cardNo);
   */
  public native static int MemLocalIDToPtr(int local, int cardNo);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(voidptr dst, voidptr src, ULong numBytes);
   */
  public native static int MemMove(int dst, int src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(VoidPtr dst, voidptr src, ULong numBytes);
   */
  public native static int MemMove(Object dst, int src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(voidptr dst, VoidPtr src, ULong numBytes);
   */
  public native static int MemMove(int dst, Object src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(VoidPtr dst, VoidPtr src, ULong numBytes);
   */
  public native static int MemMove(Object dst, Object src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(ByteArray dst, ByteArray src, ULong numBytes);
   */
  public native static int MemMove(byte [] dst, int _dst_off, byte [] src, int _src_off, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(voidptr dst, ByteArray src, ULong numBytes);
   */
  public native static int MemMove(int dst, byte [] src, int _src_off, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(ByteArray dst, voidptr src, ULong numBytes);
   */
  public native static int MemMove(byte [] dst, int _dst_off, int src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(CharBuf dst, voidptr src, ULong numBytes);
   */
  public native static int MemMove(StringBuffer dst, int src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemMove
   *
   * <P>Defined as: Err      MemMove(voidptr dst, CharPtr src, ULong numBytes);
   */
  public native static int MemMove(int dst, String src, int numBytes);

  /** PalmOS SysTrap: sysTrapMemNumCards
   *
   * <P>Defined as: UInt     MemNumCards();
   */
  public native static int MemNumCards();

  /** PalmOS SysTrap: sysTrapMemNumHeaps
   *
   * <P>Defined as: UInt     MemNumHeaps(UInt cardNo);
   */
  public native static int MemNumHeaps(int cardNo);

  /** PalmOS SysTrap: sysTrapMemNumRAMHeaps
   *
   * <P>Defined as: UInt     MemNumRAMHeaps(UInt cardNo);
   */
  public native static int MemNumRAMHeaps(int cardNo);

  /** PalmOS SysTrap: sysTrapMemPtrCardNo
   *
   * <P>Defined as: UInt     MemPtrCardNo(voidptr chunkP);
   */
  public native static int MemPtrCardNo(int chunkP);

  /** PalmOS SysTrap: sysTrapMemPtrDataStorage
   *
   * <P>Defined as: Boolean  MemPtrDataStorage(voidptr p);
   */
  public native static boolean MemPtrDataStorage(int p);

  /** PalmOS SysTrap: sysTrapMemPtrFree
   *
   * <P>Defined as: Err      MemPtrFree(voidptr p);
   */
  public native static int MemPtrFree(int p);

  /** PalmOS SysTrap: sysTrapMemPtrHeapID
   *
   * <P>Defined as: UInt     MemPtrHeapID(voidptr p);
   */
  public native static int MemPtrHeapID(int p);

  /** PalmOS SysTrap: sysTrapMemPtrToLocalID
   *
   * <P>Defined as: LocalID  MemPtrToLocalID(voidptr chunkP);
   */
  public native static int MemPtrToLocalID(int chunkP);

  /** PalmOS SysTrap: sysTrapMemPtrNew
   *
   * <P>Defined as: VoidPtr  MemPtrNew(ULong size);
   */
  public native static int MemPtrNew(int size);

  /** PalmOS SysTrap: sysTrapMemPtrRecoverHandle
   *
   * <P>Defined as: VoidHand MemPtrRecoverHandle(voidptr p);
   */
  public native static int MemPtrRecoverHandle(int p);

  /** PalmOS SysTrap: sysTrapMemPtrSetOwner
   *
   * <P>Defined as: Err      MemPtrSetOwner(DWord ptr, int owner);
   */
  public native static int MemPtrSetOwner(int ptr, int owner);

  /** PalmOS SysTrap: sysTrapMemPtrResize
   *
   * <P>Defined as: Err      MemPtrResize(voidptr p, ULong newSize);
   */
  public native static int MemPtrResize(int p, int newSize);

  /** PalmOS SysTrap: sysTrapMemSet
   *
   * <P>Defined as: Err      MemSet(voidptr dst, ULong numBytes, Byte value);
   */
  public native static int MemSet(int dst, int numBytes, int value);

  /** PalmOS SysTrap: sysTrapMemSet
   *
   * <P>Defined as: Err      MemSet(ByteArray dst, ULong numBytes, Byte value);
   */
  public native static int MemSet(byte [] dst, int _dst_off, int numBytes, int value);

  /** PalmOS SysTrap: sysTrapMemSetDebugMode
   *
   * <P>Defined as: Err      MemSetDebugMode(Word flags);
   */
  public native static int MemSetDebugMode(int flags);

  /** PalmOS SysTrap: sysTrapMemPtrSize
   *
   * <P>Defined as: ULong    MemPtrSize(voidptr p);
   */
  public native static int MemPtrSize(int p);

  /** PalmOS SysTrap: sysTrapMemPtrUnlock
   *
   * <P>Defined as: Err      MemPtrUnlock(voidptr p);
   */
  public native static int MemPtrUnlock(int p);

  /** PalmOS SysTrap: sysTrapMemStoreInfo
   *
   * <P>Defined as: Err      MemStoreInfo(UInt cardNo, UInt storeNumber, UIntPtr versionP, UIntPtr flagsP, CharBuf nameP, ULongPtr crDateP, ULongPtr bckUpDateP, ULongPtr heapListOffsetP, ULongPtr initCodeOffset1P, ULongPtr initCodeOffset2P, LocalID* databaseDirIDP);
   */
  public native static int MemStoreInfo(int cardNo, int storeNumber, ShortHolder versionP, ShortHolder flagsP, StringBuffer nameP, IntHolder crDateP, IntHolder bckUpDateP, IntHolder heapListOffsetP, IntHolder initCodeOffset1P, IntHolder initCodeOffset2P, IntHolder databaseDirIDP);
  /** PalmOS SysTrap: sysTrapMemStoreInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      MemStoreInfo(UInt cardNo, UInt storeNumber, UIntPtr versionP, UIntPtr flagsP, CharBuf nameP, ULongPtr crDateP, ULongPtr bckUpDateP, ULongPtr heapListOffsetP, ULongPtr initCodeOffset1P, ULongPtr initCodeOffset2P, LocalID* databaseDirIDP);
   */
  public native static int MemStoreInfo(int cardNo, int storeNumber, Short versionP, Short flagsP, StringBuffer nameP, Integer crDateP, Integer bckUpDateP, Integer heapListOffsetP, Integer initCodeOffset1P, Integer initCodeOffset2P, Integer databaseDirIDP);

  /** PalmOS SysTrap: sysTrapMenuDispose
   *
   * <P>Defined as: void     MenuDispose(MenuBarPtr MenuP);
   */
  public native static void MenuDispose(int MenuP);

  /** PalmOS SysTrap: sysTrapMenuDrawMenu
   *
   * <P>Defined as: void     MenuDrawMenu(MenuBarPtr MenuP);
   */
  public native static void MenuDrawMenu(int MenuP);

  /** PalmOS SysTrap: sysTrapMenuEraseStatus
   *
   * <P>Defined as: void     MenuEraseStatus(MenuBarPtr MenuP);
   */
  public native static void MenuEraseStatus(int MenuP);

  /** PalmOS SysTrap: sysTrapMenuGetActiveMenu
   *
   * <P>Defined as: MenuBarPtr MenuGetActiveMenu();
   */
  public native static int MenuGetActiveMenu();

  /** PalmOS SysTrap: sysTrapMenuHandleEvent
   *
   * <P>Defined as: Boolean  MenuHandleEvent(MenuBarPtr MenuP, EventPtr event, WordPtr error);
   */
  public native static boolean MenuHandleEvent(int MenuP, Event event, ShortHolder error);
  /** PalmOS SysTrap: sysTrapMenuHandleEvent
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  MenuHandleEvent(MenuBarPtr MenuP, EventPtr event, WordPtr error);
   */
  public native static boolean MenuHandleEvent(int MenuP, Event event, Short error);

  /** PalmOS SysTrap: sysTrapMenuInit
   *
   * <P>Defined as: MenuBarPtr MenuInit(Word resourceId);
   */
  public native static int MenuInit(int resourceId);

  /** PalmOS SysTrap: sysTrapMenuSetActiveMenu
   *
   * <P>Defined as: MenuBarPtr MenuSetActiveMenu(MenuBarPtr MenuP);
   */
  public native static int MenuSetActiveMenu(int MenuP);

  /** PalmOS SysTrap: sysTrapAbtShowAbout
   *
   * <P>Defined as: void     AbtShowAbout(ULong creator);
   */
  public native static void AbtShowAbout(int creator);

  /** PalmOS SysTrap: sysTrapCrc16CalcBlock
   *
   * <P>Defined as: Word     Crc16CalcBlock(VoidPtr bufP, UInt count, Word crc);
   */
  public native static int Crc16CalcBlock(Object bufP, int count, int crc);

  /** PalmOS SysTrap: sysTrapDayHandleEvent
   *
   * <P>Defined as: Boolean  DayHandleEvent(DaySelectorPtr pSelector, EventPtr pEvent);
   */
  public native static boolean DayHandleEvent(DaySelector pSelector, Event pEvent);

  /** PalmOS SysTrap: sysLibTrapNetLibOpen
   *
   * <P>Defined as: Err      &NetLibOpen(UInt16 libRefnum, ErrPtr netIFErrsP);
   */
  public native static int NetLibOpen(int libRefnum, ShortHolder netIFErrsP);

  /** PalmOS SysTrap: sysLibTrapNetLibOpenCount
   *
   * <P>Defined as: Err      &NetLibOpenCount(UInt16 libRefnum, WordPtr countP);
   */
  public native static int NetLibOpenCount(int libRefnum, ShortHolder countP);
  /** PalmOS SysTrap: sysLibTrapNetLibOpenCount
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &NetLibOpenCount(UInt16 libRefnum, WordPtr countP);
   */
  public native static int NetLibOpenCount(int libRefnum, Short countP);

  /** PalmOS SysTrap: sysLibTrapNetLibClose
   *
   * <P>Defined as: Err      &NetLibClose(UInt16 libRefnum, UInt16 immediate);
   */
  public native static int NetLibClose(int libRefnum, int immediate);

  /** PalmOS SysTrap: sysLibTrapNetLibConnectionRefresh
   *
   * <P>Defined as: Err      &NetLibConnectionRefresh(UInt16 libRefnum, Boolean refresh, UBytePtr allUp, ErrPtr errP);
   */
  public native static int NetLibConnectionRefresh(int libRefnum, boolean refresh, ByteHolder allUp, ShortHolder errP);
  /** PalmOS SysTrap: sysLibTrapNetLibConnectionRefresh
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &NetLibConnectionRefresh(UInt16 libRefnum, Boolean refresh, UBytePtr allUp, ErrPtr errP);
   */
  public native static int NetLibConnectionRefresh(int libRefnum, boolean refresh, Byte allUp, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSleep
   *
   * <P>Defined as: Err      &NetLibSleep(UInt16 libRefnum);
   */
  public native static int NetLibSleep(int libRefnum);

  /** PalmOS SysTrap: sysLibTrapNetLibWake
   *
   * <P>Defined as: Err      &NetLibWake(UInt16 libRefnum);
   */
  public native static int NetLibWake(int libRefnum);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketOpen
   *
   * <P>Defined as: NetSocketRef &NetLibSocketOpen(UInt16 libRefnum, NetSocketAddrEnum domain, NetSocketTypeEnum type, Int16 protocol, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketOpen(int libRefnum, int domain, int type, int protocol, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketClose
   *
   * <P>Defined as: Err      &NetLibSocketClose(UInt16 libRefnum, NetSocketRef socket, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketClose(int libRefnum, int socket, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketOptionGet
   *
   * <P>Defined as: Err      &NetLibSocketOptionGet(UInt16 libRefnum, NetSocketRef socket, NetSocketOptLevelEnum level, NetSocketOptEnum option, VoidPtr optValueP, UIntPtr optValueLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketOptionGet(int libRefnum, int socket, int level, int option, Object optValueP, ShortHolder optValueLenP, int timeout, ShortHolder errP);
  /** PalmOS SysTrap: sysLibTrapNetLibSocketOptionGet
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &NetLibSocketOptionGet(UInt16 libRefnum, NetSocketRef socket, NetSocketOptLevelEnum level, NetSocketOptEnum option, VoidPtr optValueP, UIntPtr optValueLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketOptionGet(int libRefnum, int socket, int level, int option, Object optValueP, Short optValueLenP, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketOptionSet
   *
   * <P>Defined as: Err      &NetLibSocketOptionSet(UInt16 libRefnum, NetSocketRef socket, NetSocketOptLevelEnum level, NetSocketOptEnum option, VoidPtr optValueP, UInt16 optValueLen, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketOptionSet(int libRefnum, int socket, int level, int option, Object optValueP, int optValueLen, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketConnect
   *
   * <P>Defined as: Err      &NetLibSocketConnect(UInt16 libRefnum, NetSocketRef socket, NetSocketAddrTypePtr sockAddrP, Int16 addrLen, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketConnect(int libRefnum, int socket, NetSocketAddrType sockAddrP, int addrLen, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketBind
   *
   * <P>Defined as: Err      &NetLibSocketBind(UInt16 libRefnum, NetSocketRef socket, NetSocketAddrTypePtr sockAddrP, Int16 addrLen, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketBind(int libRefnum, int socket, NetSocketAddrType sockAddrP, int addrLen, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketListen
   *
   * <P>Defined as: Err      &NetLibSocketListen(UInt16 libRefnum, NetSocketRef socket, UInt16 queueLen, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketListen(int libRefnum, int socket, int queueLen, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketAccept
   *
   * <P>Defined as: Err      &NetLibSocketAccept(UInt16 libRefnum, NetSocketRef socket, NetSocketAddrTypePtr sockAddrP, UIntPtr addrLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketAccept(int libRefnum, int socket, NetSocketAddrType sockAddrP, ShortHolder addrLenP, int timeout, ShortHolder errP);
  /** PalmOS SysTrap: sysLibTrapNetLibSocketAccept
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &NetLibSocketAccept(UInt16 libRefnum, NetSocketRef socket, NetSocketAddrTypePtr sockAddrP, UIntPtr addrLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketAccept(int libRefnum, int socket, NetSocketAddrType sockAddrP, Short addrLenP, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSocketShutdown
   *
   * <P>Defined as: Err      &NetLibSocketShutdown(UInt16 libRefnum, NetSocketRef socket, Int16 direction, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSocketShutdown(int libRefnum, int socket, int direction, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSend
   *
   * <P>Defined as: Err      &NetLibSend(UInt16 libRefNum, NetSocketRef socket, ByteArray bufP, UInt16 bufLen, UInt16 flags, UInt32 toAddrP, UInt16 toLen, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSend(int libRefNum, int socket, byte [] bufP, int _bufP_off, int bufLen, int flags, int toAddrP, int toLen, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibSend
   *
   * <P>Defined as: Err      &NetLibSend(UInt16 libRefNum, NetSocketRef socket, ByteArray bufP, UInt16 bufLen, UInt16 flags,NetSocketAddrTypePtr toAddrP, UInt16 toLen, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibSend(int libRefNum, int socket, byte [] bufP, int _bufP_off, int bufLen, int flags, NetSocketAddrType toAddrP, int toLen, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibReceive
   *
   * <P>Defined as: Err      &NetLibReceive(UInt16 libRefNum, NetSocketRef socket, ByteArray bufP, UInt16 bufLen, UInt16 flags, UInt32 fromAddrP, UInt32 fromLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibReceive(int libRefNum, int socket, byte [] bufP, int _bufP_off, int bufLen, int flags, int fromAddrP, int fromLenP, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibReceive
   *
   * <P>Defined as: Err      &NetLibReceive(UInt16 libRefNum, NetSocketRef socket, ByteArray bufP, UInt16 bufLen, UInt16 flags, NetSocketAddrTypePtr fromAddrP, UIntPtr fromLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibReceive(int libRefNum, int socket, byte [] bufP, int _bufP_off, int bufLen, int flags, NetSocketAddrType fromAddrP, ShortHolder fromLenP, int timeout, ShortHolder errP);
  /** PalmOS SysTrap: sysLibTrapNetLibReceive
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &NetLibReceive(UInt16 libRefNum, NetSocketRef socket, ByteArray bufP, UInt16 bufLen, UInt16 flags, NetSocketAddrTypePtr fromAddrP, UIntPtr fromLenP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibReceive(int libRefNum, int socket, byte [] bufP, int _bufP_off, int bufLen, int flags, NetSocketAddrType fromAddrP, Short fromLenP, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapNetLibAddrINToA
   *
   * <P>Defined as: CharPtr  &NetLibAddrINToA(UInt16 libRefnum, NetIPAddr inet, CharBuf addressStr);
   */
  public native static String NetLibAddrINToA(int libRefnum, int inet, StringBuffer addressStr);

  /** PalmOS SysTrap: sysLibTrapNetLibAddrAToIN
   *
   * <P>Defined as: NetIPAddr &NetLibAddrAToIN(UInt16 libRefnum, CharPtr addressStr);
   */
  public native static int NetLibAddrAToIN(int libRefnum, String addressStr);

  /** PalmOS SysTrap: sysLibTrapNetLibGetHostByName
   *
   * <P>Defined as: Ptr &NetLibGetHostByName(UInt16 libRefNum, CharPtr nameP, IntArray bufP, Int32 timeout, ErrPtr errP);
   */
  public native static int NetLibGetHostByName(int libRefNum, String nameP, int [] bufP, int _bufP_off, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysTrapPceNativeCall (<B>PalmOS 5.0</B>)
   *
   * <P>Defined as: UInt32 PceNativeCall(voidptr nativeFuncP, voidptr userDataP);
   */
  public native static int PceNativeCall(int nativeFuncP, int userDataP);

  /** PalmOS SysTrap: sysTrapPenCalibrate
   *
   * <P>Defined as: Err      PenCalibrate(PointType* digTopLeftP, PointType* digBotRightP, PointType* scrTopLeftP, PointType* scrBotRightP);
   */
  public native static int PenCalibrate(PointType digTopLeftP, PointType digBotRightP, PointType scrTopLeftP, PointType scrBotRightP);

  /** PalmOS SysTrap: sysTrapPenResetCalibration
   *
   * <P>Defined as: Err      PenResetCalibration();
   */
  public native static int PenResetCalibration();

  /** PalmOS SysTrap: sysTrapPrefGetAppPreferencesV10
   *
   * <P>Defined as: Boolean  PrefGetAppPreferences(ULong type, Int version, VoidPtr prefs, Word prefsSize) = sysTrapPrefGetAppPreferencesV10;
   */
  public native static boolean PrefGetAppPreferences(int type, int version, Object prefs, int prefsSize);

  /** PalmOS SysTrap: sysTrapPrefGetPreferences
   *
   * <P>Defined as: void     PrefGetPreferences(SystemPreferencesPtr p);
   */
  public native static void PrefGetPreferences(SystemPreferences p);

  /** PalmOS SysTrap: sysTrapPrefOpenPreferenceDBV10
   *
   * <P>Defined as: DmOpenRef PrefOpenPreferenceDB() = sysTrapPrefOpenPreferenceDBV10;
   */
  public native static int PrefOpenPreferenceDB();

  /** PalmOS SysTrap: sysTrapPrefSetAppPreferencesV10
   *
   * <P>Defined as: void     PrefSetAppPreferences(ULong type, Int version, VoidPtr prefs, Word prefsSize) = sysTrapPrefSetAppPreferencesV10;
   */
  public native static void PrefSetAppPreferences(int type, int version, Object prefs, int prefsSize);

  /** PalmOS SysTrap: sysTrapPrefSetPreferences
   *
   * <P>Defined as: void     PrefSetPreferences(SystemPreferencesPtr p);
   */
  public native static void PrefSetPreferences(SystemPreferences p);

  /** PalmOS SysTrap: sysTrapPrefGetAppPreferences (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Int16    PrefGetAppPreferences(UInt32 creator, UInt16 id, VoidPtr prefs, UIntPtr prefsSize, Boolean saved);
   */
  public native static int PrefGetAppPreferences(int creator, int id, Object prefs, ShortHolder prefsSize, boolean saved);

  /** PalmOS SysTrap: sysTrapPrefSetAppPreferences (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: void     PrefSetAppPreferences(UInt32 creator, UInt16 id, Int16 version, VoidPtr prefs, UInt16 prefsSize, Boolean saved);
   */
  public native static void PrefSetAppPreferences(int creator, int id, int version, Object prefs, int prefsSize, boolean saved);

  /** PalmOS SysTrap: sysTrapPrefGetPreference (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: UInt32   PrefGetPreference(Enum pref);
   */
  public native static int PrefGetPreference(int pref);

  /** PalmOS SysTrap: sysTrapSclDrawScrollBar
   *
   * <P>Defined as: void     SclDrawScrollBar(ScrollBarPtr scrlPtr);
   */
  public native static void SclDrawScrollBar(int scrlPtr);

  /** PalmOS SysTrap: sysTrapSclGetScrollBar
   *
   * <P>Defined as: void     SclGetScrollBar(ScrollBarPtr scrlPtr, WordPtr value, WordPtr min, WordPtr max, WordPtr pageSize);
   */
  public native static void SclGetScrollBar(int scrlPtr, ShortHolder value, ShortHolder min, ShortHolder max, ShortHolder pageSize);
  /** PalmOS SysTrap: sysTrapSclGetScrollBar
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     SclGetScrollBar(ScrollBarPtr scrlPtr, WordPtr value, WordPtr min, WordPtr max, WordPtr pageSize);
   */
  public native static void SclGetScrollBar(int scrlPtr, Short value, Short min, Short max, Short pageSize);

  /** PalmOS SysTrap: sysTrapSclHandleEvent
   *
   * <P>Defined as: Boolean  SclHandleEvent(ScrollBarPtr scrlPtr, EventPtr event);
   */
  public native static boolean SclHandleEvent(int scrlPtr, Event event);

  /** PalmOS SysTrap: sysTrapSclSetScrollBar
   *
   * <P>Defined as: void     SclSetScrollBar(ScrollBarPtr scrlPtr, Word value, Word min, Word max, Word pageSize);
   */
  public native static void SclSetScrollBar(int scrlPtr, int value, int min, int max, int pageSize);

  /** PalmOS SysTrap: sysLibTrapSerOpen
   *
   * <P>Defined as: Err      &SerOpen(UInt refNum, UInt port, ULong baud);
   */
  public native static int SerOpen(int refNum, int port, int baud);

  /** PalmOS SysTrap: sysLibTrapSerClose
   *
   * <P>Defined as: Err      &SerClose(UInt refNum);
   */
  public native static int SerClose(int refNum);

  /** PalmOS SysTrap: sysLibTrapSerSleep
   *
   * <P>Defined as: Err      &SerSleep(UInt refNum);
   */
  public native static int SerSleep(int refNum);

  /** PalmOS SysTrap: sysLibTrapSerWake
   *
   * <P>Defined as: Err      &SerWake(UInt refNum);
   */
  public native static int SerWake(int refNum);

  /** PalmOS SysTrap: sysLibTrapSerGetSettings
   *
   * <P>Defined as: Err      &SerGetSettings(UInt refNum, SerSettingsPtr settingsP);
   */
  public native static int SerGetSettings(int refNum, SerSettings settingsP);

  /** PalmOS SysTrap: sysLibTrapSerSetSettings
   *
   * <P>Defined as: Err      &SerSetSettings(UInt refNum, SerSettingsPtr settingsP);
   */
  public native static int SerSetSettings(int refNum, SerSettings settingsP);

  /** PalmOS SysTrap: sysLibTrapSerGetStatus
   *
   * <P>Defined as: Word     &SerGetStatus(UInt refNum, BooleanPtr ctsOnP, BooleanPtr dtsOnP);
   */
  public native static int SerGetStatus(int refNum, BoolHolder ctsOnP, BoolHolder dtsOnP);
  /** PalmOS SysTrap: sysLibTrapSerGetStatus
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Word     &SerGetStatus(UInt refNum, BooleanPtr ctsOnP, BooleanPtr dtsOnP);
   */
  public native static int SerGetStatus(int refNum, Boolean ctsOnP, Boolean dtsOnP);

  /** PalmOS SysTrap: sysLibTrapSerClearErr
   *
   * <P>Defined as: Err      &SerClearErr(UInt refNum);
   */
  public native static int SerClearErr(int refNum);

  /** PalmOS SysTrap: sysLibTrapSerSend10
   *
   * <P>Defined as: Err      &SerSend(UInt refNum, const ByteArray bufP, ULong size) = sysLibTrapSerSend10;
   */
  public native static int SerSend(int refNum, byte [] bufP, int _bufP_off, int size);

  /** PalmOS SysTrap: sysLibTrapSerSend10
   *
   * <P>Defined as: Err      &SerSend(UInt refNum, VoidPtr bufP, ULong size) = sysLibTrapSerSend10;
   */
  public native static int SerSend(int refNum, Object bufP, int size);

  /** PalmOS SysTrap: sysLibTrapSerSend10
   *
   * <P>Defined as: Err      &SerSend10(UInt refNum, ByteArray bufP, ULong size);
   */
  public native static int SerSend10(int refNum, byte [] bufP, int _bufP_off, int size);

  /** PalmOS SysTrap: sysLibTrapSerSend10
   *
   * <P>Defined as: Err      &SerSend10(UInt refNum, VoidPtr bufP, ULong size);
   */
  public native static int SerSend10(int refNum, Object bufP, int size);

  /** PalmOS SysTrap: sysLibTrapSerSendWait
   *
   * <P>Defined as: Err      &SerSendWait(UInt refNum, Long timeout);
   */
  public native static int SerSendWait(int refNum, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerSendCheck
   *
   * <P>Defined as: Err      &SerSendCheck(UInt refNum, ULongPtr numBytesP);
   */
  public native static int SerSendCheck(int refNum, IntHolder numBytesP);
  /** PalmOS SysTrap: sysLibTrapSerSendCheck
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &SerSendCheck(UInt refNum, ULongPtr numBytesP);
   */
  public native static int SerSendCheck(int refNum, Integer numBytesP);

  /** PalmOS SysTrap: sysLibTrapSerSendFlush
   *
   * <P>Defined as: Err      &SerSendFlush(UInt refNum);
   */
  public native static int SerSendFlush(int refNum);

  /** PalmOS SysTrap: sysLibTrapSerReceive10
   *
   * <P>Defined as: Err      &SerReceive(UInt refNum, ByteArray bufP, ULong bytes, Long timeout) = sysLibTrapSerReceive10;
   */
  public native static int SerReceive(int refNum, byte [] bufP, int _bufP_off, int bytes, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerReceive10
   *
   * <P>Defined as: Err      &SerReceive(UInt refNum, VoidPtr bufP, ULong bytes, Long timeout) = sysLibTrapSerReceive10;
   */
  public native static int SerReceive(int refNum, Object bufP, int bytes, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerReceive10
   *
   * <P>Defined as: Err      &SerReceive10(UInt refNum, ByteArray bufP, ULong bytes, Long timeout);
   */
  public native static int SerReceive10(int refNum, byte [] bufP, int _bufP_off, int bytes, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerReceive10
   *
   * <P>Defined as: Err      &SerReceive10(UInt refNum, VoidPtr bufP, ULong bytes, Long timeout);
   */
  public native static int SerReceive10(int refNum, Object bufP, int bytes, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerReceiveWait
   *
   * <P>Defined as: Err      &SerReceiveWait(UInt refNum, ULong bytes, Long timeout);
   */
  public native static int SerReceiveWait(int refNum, int bytes, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerReceiveCheck
   *
   * <P>Defined as: Err      &SerReceiveCheck(UInt refNum, ULongPtr numBytesP);
   */
  public native static int SerReceiveCheck(int refNum, IntHolder numBytesP);
  /** PalmOS SysTrap: sysLibTrapSerReceiveCheck
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &SerReceiveCheck(UInt refNum, ULongPtr numBytesP);
   */
  public native static int SerReceiveCheck(int refNum, Integer numBytesP);

  /** PalmOS SysTrap: sysLibTrapSerReceiveFlush
   *
   * <P>Defined as: void     &SerReceiveFlush(UInt refNum, Long timeout);
   */
  public native static void SerReceiveFlush(int refNum, int timeout);

  /** PalmOS SysTrap: sysLibTrapSerSetReceiveBuffer
   *
   * <P>Defined as: Err      &SerSetReceiveBuffer(UInt refNum, VoidPtr bufP, UInt bufSize);
   */
  public native static int SerSetReceiveBuffer(int refNum, Object bufP, int bufSize);

  /** PalmOS SysTrap: sysLibTrapSerReceiveWindowOpen
   *
   * <P>Defined as: Err      &SerReceiveWindowOpen(UInt refNum, ByteArray bufPP, ULongPtr sizeP);
   */
  public native static int SerReceiveWindowOpen(int refNum, byte [] bufPP, int _bufPP_off, IntHolder sizeP);
  /** PalmOS SysTrap: sysLibTrapSerReceiveWindowOpen
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &SerReceiveWindowOpen(UInt refNum, ByteArray bufPP, ULongPtr sizeP);
   */
  public native static int SerReceiveWindowOpen(int refNum, byte [] bufPP, int _bufPP_off, Integer sizeP);

  /** PalmOS SysTrap: sysLibTrapSerReceiveWindowClose
   *
   * <P>Defined as: Err      &SerReceiveWindowClose(UInt refNum, ULong bytesPulled);
   */
  public native static int SerReceiveWindowClose(int refNum, int bytesPulled);

  /** PalmOS SysTrap: sysLibTrapSerPrimeWakeupHandler
   *
   * <P>Defined as: Err      &SerPrimeWakeupHandler(UInt refNum, UInt minBytes);
   */
  public native static int SerPrimeWakeupHandler(int refNum, int minBytes);

  /** PalmOS SysTrap: sysLibTrapSerControl
   *
   * <P>Defined as: Err      &SerControl(UInt refNum, UInt op, VoidPtr valueP, UIntPtr valueLenP);
   */
  public native static int SerControl(int refNum, int op, Object valueP, ShortHolder valueLenP);
  /** PalmOS SysTrap: sysLibTrapSerControl
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      &SerControl(UInt refNum, UInt op, VoidPtr valueP, UIntPtr valueLenP);
   */
  public native static int SerControl(int refNum, int op, Object valueP, Short valueLenP);

  /** PalmOS SysTrap: sysLibTrapSerControl
   *
   * <P>Defined as: Err      &SerControl(UInt refNum, UInt op, ULong valueP, ULong valueLenP);
   */
  public native static int SerControl(int refNum, int op, int valueP, int valueLenP);

  /** PalmOS SysTrap: sysLibTrapSerSend (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: ULong    &SerSend(UInt refNum, ByteArray bufP, ULong count, ErrPtr errP);
   */
  public native static int SerSend(int refNum, byte [] bufP, int _bufP_off, int count, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapSerSend (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: ULong    &SerSend(UInt refNum, VoidPtr bufP, ULong count, ErrPtr errP);
   */
  public native static int SerSend(int refNum, Object bufP, int count, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapSerReceive (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: ULong    &SerReceive(UInt refNum, ByteArray bufP, ULong count, Long timeout, ErrPtr errP);
   */
  public native static int SerReceive(int refNum, byte [] bufP, int _bufP_off, int count, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysLibTrapSerReceive (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: ULong    &SerReceive(UInt refNum, VoidPtr bufP, ULong count, Long timeout, ErrPtr errP);
   */
  public native static int SerReceive(int refNum, Object bufP, int count, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysTrapSlkClose
   *
   * <P>Defined as: Err      SlkClose();
   */
  public native static int SlkClose();

  /** PalmOS SysTrap: sysTrapSlkCloseSocket
   *
   * <P>Defined as: Err      SlkCloseSocket(UInt socket);
   */
  public native static int SlkCloseSocket(int socket);

  /** PalmOS SysTrap: sysTrapSlkFlushSocket
   *
   * <P>Defined as: Err      SlkFlushSocket(UInt socket, Long timeout);
   */
  public native static int SlkFlushSocket(int socket, int timeout);

  /** PalmOS SysTrap: sysTrapSlkOpen
   *
   * <P>Defined as: Err      SlkOpen();
   */
  public native static int SlkOpen();

  /** PalmOS SysTrap: sysTrapSlkOpenSocket
   *
   * <P>Defined as: Err      SlkOpenSocket(UInt libRefNum, UIntPtr socketP, Boolean staticSocket);
   */
  public native static int SlkOpenSocket(int libRefNum, ShortHolder socketP, boolean staticSocket);
  /** PalmOS SysTrap: sysTrapSlkOpenSocket
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SlkOpenSocket(UInt libRefNum, UIntPtr socketP, Boolean staticSocket);
   */
  public native static int SlkOpenSocket(int libRefNum, Short socketP, boolean staticSocket);

  /** PalmOS SysTrap: sysTrapSlkReceivePacket
   *
   * <P>Defined as: Err      SlkReceivePacket(UInt socket, Boolean andOtherSockets, SlkPktHeaderPtr headerP, void* bodyP, UInt bodySize, Long timeout);
   */
  public native static int SlkReceivePacket(int socket, boolean andOtherSockets, SlkPktHeader headerP, Object bodyP, int bodySize, int timeout);

  /** PalmOS SysTrap: sysTrapSlkSocketRefNum
   *
   * <P>Defined as: Err      SlkSocketRefNum(UInt socket, UIntPtr refNumP);
   */
  public native static int SlkSocketRefNum(int socket, ShortHolder refNumP);
  /** PalmOS SysTrap: sysTrapSlkSocketRefNum
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SlkSocketRefNum(UInt socket, UIntPtr refNumP);
   */
  public native static int SlkSocketRefNum(int socket, Short refNumP);

  /** PalmOS SysTrap: sysTrapSlkSocketSetTimeout
   *
   * <P>Defined as: Err      SlkSocketSetTimeout(UInt socket, Long timeout);
   */
  public native static int SlkSocketSetTimeout(int socket, int timeout);

  /** PalmOS SysTrap: sysTrapSndDoCmd
   *
   * <P>Defined as: Err      SndDoCmd(VoidPtr chanP, SndCommandPtr cmdP, Boolean noWait);
   */
  public native static int SndDoCmd(Object chanP, SndCommand cmdP, boolean noWait);

  /** PalmOS SysTrap: sysTrapSndGetDefaultVolume
   *
   * <P>Defined as: void     SndGetDefaultVolume(UIntPtr alarmAmpP, UIntPtr sysAmpP, UIntPtr defAmpP);
   */
  public native static void SndGetDefaultVolume(ShortHolder alarmAmpP, ShortHolder sysAmpP, ShortHolder defAmpP);
  /** PalmOS SysTrap: sysTrapSndGetDefaultVolume
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     SndGetDefaultVolume(UIntPtr alarmAmpP, UIntPtr sysAmpP, UIntPtr defAmpP);
   */
  public native static void SndGetDefaultVolume(Short alarmAmpP, Short sysAmpP, Short defAmpP);

  /** PalmOS SysTrap: sysTrapSndPlaySystemSound
   *
   * <P>Defined as: void     SndPlaySystemSound(SndSysBeepType beepID);
   */
  public native static void SndPlaySystemSound(int beepID);

  /** PalmOS SysTrap: sysTrapSndSetDefaultVolume
   *
   * <P>Defined as: void     SndSetDefaultVolume(UIntPtr alarmAmpP, UIntPtr sysAmpP, UIntPtr defAmpP);
   */
  public native static void SndSetDefaultVolume(ShortHolder alarmAmpP, ShortHolder sysAmpP, ShortHolder defAmpP);
  /** PalmOS SysTrap: sysTrapSndSetDefaultVolume
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     SndSetDefaultVolume(UIntPtr alarmAmpP, UIntPtr sysAmpP, UIntPtr defAmpP);
   */
  public native static void SndSetDefaultVolume(Short alarmAmpP, Short sysAmpP, Short defAmpP);
    /** sound manager feature ID */
    public final static int sysFileCSoundMgr = ('s'<<24)|('n'<<16)|('d'<<8)|'m';
    /** get sound manager feature version */
    public final static int sndFtrIDVersion = 0;

  /** PalmOS SysTrap: sysTrapSndPlayResource (<B>PalmOS 3.5</B>)
   * (<B>requires Sound Stream Feature Set</B>)
   *
   * <P>Defined as: Err      SndPlayResource(voidptr snd, Int32 volume, UInt32 flags);
   */
  public native static int SndPlayResource(int snd, int volume, int flags);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialInstall
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SerialMgrInstall() = sysTrapSerialDispatch selector sysSerialInstall;
   */
  public native static int SerialMgrInstall();

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialOpen
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmOpen(UInt32 port, UInt32 baud, UIntPtr newPortIdP) = sysTrapSerialDispatch selector sysSerialOpen;
   */
  public native static int SrmOpen(int port, int baud, ShortHolder newPortIdP);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialOpen
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmOpen(UInt32 port, UInt32 baud, UIntPtr newPortIdP) = sysTrapSerialDispatch selector sysSerialOpen;
   */
  public native static int SrmOpen(int port, int baud, Short newPortIdP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialClose
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmClose(UInt16 portId) = sysTrapSerialDispatch selector sysSerialClose;
   */
  public native static int SrmClose(int portId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSleep
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmSleep() = sysTrapSerialDispatch selector sysSerialSleep;
   */
  public native static int SrmSleep();

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialWake
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmWake() = sysTrapSerialDispatch selector sysSerialWake;
   */
  public native static int SrmWake();

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialGetDeviceCount
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmGetDeviceCount(UIntPtr numOfDevices) = sysTrapSerialDispatch selector sysSerialGetDeviceCount;
   */
  public native static int SrmGetDeviceCount(ShortHolder numOfDevices);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialGetDeviceCount
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmGetDeviceCount(UIntPtr numOfDevices) = sysTrapSerialDispatch selector sysSerialGetDeviceCount;
   */
  public native static int SrmGetDeviceCount(Short numOfDevices);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialGetStatus
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmGetStatus(UInt16 portId, ULongPtr statusField, UIntPtr lineErrs) = sysTrapSerialDispatch selector sysSerialGetStatus;
   */
  public native static int SrmGetStatus(int portId, IntHolder statusField, ShortHolder lineErrs);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialGetStatus
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmGetStatus(UInt16 portId, ULongPtr statusField, UIntPtr lineErrs) = sysTrapSerialDispatch selector sysSerialGetStatus;
   */
  public native static int SrmGetStatus(int portId, Integer statusField, Short lineErrs);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialClearErr
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmClearErr(UInt16 portId) = sysTrapSerialDispatch selector sysSerialClearErr;
   */
  public native static int SrmClearErr(int portId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialControl
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmControl(UInt16 portId, UInt16 op, voidptr valueP, UIntPtr valueLen) = sysTrapSerialDispatch selector sysSerialControl;
   */
  public native static int SrmControl(int portId, int op, int valueP, ShortHolder valueLen);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialControl
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmControl(UInt16 portId, UInt16 op, voidptr valueP, UIntPtr valueLen) = sysTrapSerialDispatch selector sysSerialControl;
   */
  public native static int SrmControl(int portId, int op, int valueP, Short valueLen);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialControl
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmControl(UInt16 portId, UInt16 op, ULongPtr value, UIntPtr valueLen) = sysTrapSerialDispatch selector sysSerialControl;
   */
  public native static int SrmControl(int portId, int op, IntHolder value, ShortHolder valueLen);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialControl
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmControl(UInt16 portId, UInt16 op, ULongPtr value, UIntPtr valueLen) = sysTrapSerialDispatch selector sysSerialControl;
   */
  public native static int SrmControl(int portId, int op, Integer value, Short valueLen);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialControl
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmControl(UInt16 portId, UInt16 op, ByteArray value, UIntPtr valueLen) = sysTrapSerialDispatch selector sysSerialControl;
   */
  public native static int SrmControl(int portId, int op, byte [] value, int _value_off, ShortHolder valueLen);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialControl
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmControl(UInt16 portId, UInt16 op, ByteArray value, UIntPtr valueLen) = sysTrapSerialDispatch selector sysSerialControl;
   */
  public native static int SrmControl(int portId, int op, byte [] value, int _value_off, Short valueLen);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSend
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: UInt32   SrmSend (UInt16 portId, voidptr bufP, UInt32 count, ErrPtr errP) = sysTrapSerialDispatch selector sysSerialSend;
   */
  public native static int SrmSend(int portId, int bufP, int count, ShortHolder errP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSend
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: UInt32   SrmSend (UInt16 portId, ByteArray bufP, UInt32 count, ErrPtr errP) = sysTrapSerialDispatch selector sysSerialSend;
   */
  public native static int SrmSend(int portId, byte [] bufP, int _bufP_off, int count, ShortHolder errP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSendWait
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmSendWait(UInt16 portId) = sysTrapSerialDispatch selector sysSerialSendWait;
   */
  public native static int SrmSendWait(int portId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSendCheck
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmSendCheck(UInt16 portId, ULongPtr numBytesP) = sysTrapSerialDispatch selector sysSerialSendCheck;
   */
  public native static int SrmSendCheck(int portId, IntHolder numBytesP);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSendCheck
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmSendCheck(UInt16 portId, ULongPtr numBytesP) = sysTrapSerialDispatch selector sysSerialSendCheck;
   */
  public native static int SrmSendCheck(int portId, Integer numBytesP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSendFlush
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmSendFlush(UInt16 portId) = sysTrapSerialDispatch selector sysSerialSendFlush;
   */
  public native static int SrmSendFlush(int portId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialReceive
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: UInt32   SrmReceive(UInt16 portId, voidptr rcvBufP, UInt32 count, Int32 timeout, ErrPtr errP) = sysTrapSerialDispatch selector sysSerialReceive;
   */
  public native static int SrmReceive(int portId, int rcvBufP, int count, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialReceive
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: UInt32   SrmReceive(UInt16 portId, ByteArray rcvBufP, UInt32 count, Int32 timeout, ErrPtr errP) = sysTrapSerialDispatch selector sysSerialReceive;
   */
  public native static int SrmReceive(int portId, byte [] rcvBufP, int _rcvBufP_off, int count, int timeout, ShortHolder errP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialReceiveWait
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmReceiveWait(UInt16 portId, UInt32 bytes, Int32 timeout) = sysTrapSerialDispatch selector sysSerialReceiveWait;
   */
  public native static int SrmReceiveWait(int portId, int bytes, int timeout);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialReceiveCheck
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmReceiveCheck(UInt16 portId,  ULongPtr numBytesP) = sysTrapSerialDispatch selector sysSerialReceiveCheck;
   */
  public native static int SrmReceiveCheck(int portId, IntHolder numBytesP);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialReceiveCheck
   * (<B>requires New Serial Manager</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmReceiveCheck(UInt16 portId,  ULongPtr numBytesP) = sysTrapSerialDispatch selector sysSerialReceiveCheck;
   */
  public native static int SrmReceiveCheck(int portId, Integer numBytesP);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialReceiveFlush
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmReceiveFlush(UInt16 portId, Int32 timeout) = sysTrapSerialDispatch selector sysSerialReceiveFlush;
   */
  public native static int SrmReceiveFlush(int portId, int timeout);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSetRcvBuffer
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmSetReceiveBuffer(UInt16 portId, ByteArray bufP, UInt16 bufSize) = sysTrapSerialDispatch selector sysSerialSetRcvBuffer;
   */
  public native static int SrmSetReceiveBuffer(int portId, byte [] bufP, int _bufP_off, int bufSize);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSetRcvBuffer
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmSetReceiveBuffer(UInt16 portId, VoidPtr bufP, UInt16 bufSize) = sysTrapSerialDispatch selector sysSerialSetRcvBuffer;
   */
  public native static int SrmSetReceiveBuffer(int portId, Object bufP, int bufSize);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialRcvWindowClose
   * (<B>requires New Serial Manager</B>)
   *
   * <P>Defined as: Err      SrmReceiveWindowClose(UInt16 portId, UInt32 bytesPulled) = sysTrapSerialDispatch selector sysSerialRcvWindowClose;
   */
  public native static int SrmReceiveWindowClose(int portId, int bytesPulled);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialOpenBkgnd
   * (<B>requires New Serial Manager 2.0</B>)
   *
   * <P>Defined as: Err      SrmOpenBackground(UInt32 port, UInt32 baud, UIntPtr newPortId) = sysTrapSerialDispatch selector sysSerialOpenBkgnd;
   */
  public native static int SrmOpenBackground(int port, int baud, ShortHolder newPortId);
  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialOpenBkgnd
   * (<B>requires New Serial Manager 2.0</B>)
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SrmOpenBackground(UInt32 port, UInt32 baud, UIntPtr newPortId) = sysTrapSerialDispatch selector sysSerialOpenBkgnd;
   */
  public native static int SrmOpenBackground(int port, int baud, Short newPortId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialOpenV4 (<B>PalmOS 4.0</B>)
   * (<B>requires New Serial Manager 2.0</B>)
   *
   * <P>Defined as: Err      SrmExtOpen(UInt32 port, SrmOpenConfigPtr config, UInt16 configSize, UIntPtr newPortId) = sysTrapSerialDispatch selector sysSerialOpenV4;
   */
  public native static int SrmExtOpen(int port, SrmOpenConfig config, int configSize, ShortHolder newPortId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialOpenBkgndV4 (<B>PalmOS 4.0</B>)
   * (<B>requires New Serial Manager 2.0</B>)
   *
   * <P>Defined as: Err      SrmExtOpenBackground(UInt32 port, SrmOpenConfigPtr config, UInt16 configSize, UIntPtr newPortId) = sysTrapSerialDispatch selector sysSerialOpenBkgndV4;
   */
  public native static int SrmExtOpenBackground(int port, SrmOpenConfig config, int configSize, ShortHolder newPortId);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialSetWakeupHandler (<B>PalmOS 4.0</B>)
   * (<B>requires New Serial Manager 2.0</B>)
   *
   * <P>Defined as: Err      SrmSetWakeupHandler(UInt16 portId, const WakeupHandlerProcPtr handler, UInt32 refCon) = sysTrapSerialDispatch selector sysSerialSetWakeupHandler;
   */
  public native static int SrmSetWakeupHandler(int portId, WakeupHandler handler, int refCon);

  /** PalmOS SysTrap: sysTrapSerialDispatch/sysSerialPrimeWakeupHandler (<B>PalmOS 4.0</B>)
   * (<B>requires New Serial Manager 2.0</B>)
   *
   * <P>Defined as: Err      SrmPrimeWakeupHandler(UInt16 portId, UInt16 minBytes) = sysTrapSerialDispatch selector sysSerialPrimeWakeupHandler;
   */
  public native static int SrmPrimeWakeupHandler(int portId, int minBytes);

  /** PalmOS SysTrap: sysTrapStrAToI
   *
   * <P>Defined as: Int      StrAToI(CharPtr str);
   */
  public native static int StrAToI(String str);

  /** PalmOS SysTrap: sysTrapStrCaselessCompare
   *
   * <P>Defined as: Int      StrCaselessCompare(CharPtr s1, CharPtr s2);
   */
  public native static int StrCaselessCompare(String s1, String s2);

  /** PalmOS SysTrap: sysTrapStrCompare
   *
   * <P>Defined as: Int      StrCompare(CharPtr s1, CharPtr s2);
   */
  public native static int StrCompare(String s1, String s2);

  /** PalmOS SysTrap: sysTrapStrLen
   *
   * <P>Defined as: UInt     StrLen(CharPtr str);
   */
  public native static int StrLen(String str);

  /** PalmOS SysTrap: sysTrapSysAppLaunch
   *
   * <P>Defined as: Err      SysAppLaunch(UInt cardNo, LocalID dbID, UInt launchFlags, Word cmd, Ptr cmpPBP, DWord* resultP);
   */
  public native static int SysAppLaunch(int cardNo, int dbID, int launchFlags, int cmd, Object cmpPBP, IntHolder resultP);
  /** PalmOS SysTrap: sysTrapSysAppLaunch
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SysAppLaunch(UInt cardNo, LocalID dbID, UInt launchFlags, Word cmd, Ptr cmpPBP, DWord* resultP);
   */
  public native static int SysAppLaunch(int cardNo, int dbID, int launchFlags, int cmd, Object cmpPBP, Integer resultP);

  /** PalmOS SysTrap: sysTrapSysAppLaunch
   *
   * <P>Defined as: Err      SysAppLaunch(UInt cardNo, LocalID dbID, UInt launchFlags, Word cmd, Handle cmpPBP, DWord* resultP);
   */
  public native static int SysAppLaunch(int cardNo, int dbID, int launchFlags, int cmd, int cmpPBP, IntHolder resultP);
  /** PalmOS SysTrap: sysTrapSysAppLaunch
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SysAppLaunch(UInt cardNo, LocalID dbID, UInt launchFlags, Word cmd, Handle cmpPBP, DWord* resultP);
   */
  public native static int SysAppLaunch(int cardNo, int dbID, int launchFlags, int cmd, int cmpPBP, Integer resultP);

  /** PalmOS SysTrap: sysTrapSysFatalAlert
   *
   * <P>Defined as: Err      SysFatalAlert(CharPtr msg);
   */
  public native static int SysFatalAlert(String msg);

  /** PalmOS SysTrap: sysTrapSysBatteryInfo
   *
   * <P>Defined as: UInt     SysBatteryInfo(Boolean set, UIntPtr warnThresholdP, UIntPtr criticalThresholdP, UIntPtr maxTicksP, SysBatteryKind* kindP, Boolean* pluggedIn);
   */
  public native static int SysBatteryInfo(boolean set, ShortHolder warnThresholdP, ShortHolder criticalThresholdP, ShortHolder maxTicksP, ShortHolder kindP, BoolHolder pluggedIn);
  /** PalmOS SysTrap: sysTrapSysBatteryInfo
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: UInt     SysBatteryInfo(Boolean set, UIntPtr warnThresholdP, UIntPtr criticalThresholdP, UIntPtr maxTicksP, SysBatteryKind* kindP, Boolean* pluggedIn);
   */
  public native static int SysBatteryInfo(boolean set, Short warnThresholdP, Short criticalThresholdP, Short maxTicksP, Short kindP, Boolean pluggedIn);

  /** PalmOS SysTrap: sysTrapSysBroadcastActionCode
   *
   * <P>Defined as: Err      SysBroadcastActionCode(Word cmd, Ptr cmdPBP);
   */
  public native static int SysBroadcastActionCode(int cmd, Object cmdPBP);

  /** PalmOS SysTrap: sysTrapSysCopyStringResource
   *
   * <P>Defined as: void     SysCopyStringResource(CharBuf string, UInt theID);
   */
  public native static void SysCopyStringResource(StringBuffer string, int theID);

  /** PalmOS SysTrap: sysTrapSysCurAppDatabase
   *
   * <P>Defined as: Err      SysCurAppDatabase(UIntPtr cardNoP, LocalID* dbIDP);
   */
  public native static int SysCurAppDatabase(ShortHolder cardNoP, IntHolder dbIDP);
  /** PalmOS SysTrap: sysTrapSysCurAppDatabase
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SysCurAppDatabase(UIntPtr cardNoP, LocalID* dbIDP);
   */
  public native static int SysCurAppDatabase(Short cardNoP, Integer dbIDP);

  /** PalmOS SysTrap: sysTrapSysFormPointerArrayToStrings
   *
   * <P>Defined as: VoidHand SysFormPointerArrayToStrings(CharPtr c, Int stringCount);
   */
  public native static int SysFormPointerArrayToStrings(String c, int stringCount);

  /** PalmOS SysTrap: sysTrapSysHandleEvent
   *
   * <P>Defined as: Boolean  SysHandleEvent(EventPtr eventP);
   */
  public native static boolean SysHandleEvent(Event eventP);

  /** PalmOS SysTrap: sysTrapSysKeyboardDialogV10
   *
   * <P>Defined as: void     SysKeyboardDialog() = sysTrapSysKeyboardDialogV10;
   */
  public native static void SysKeyboardDialog();

  /** PalmOS SysTrap: sysTrapSysLibFind
   *
   * <P>Defined as: Word     SysLibFind(CharPtr name, UIntPtr refNum);
   */
  public native static int SysLibFind(String name, ShortHolder refNum);
  /** PalmOS SysTrap: sysTrapSysLibFind
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Word     SysLibFind(CharPtr name, UIntPtr refNum);
   */
  public native static int SysLibFind(String name, Short refNum);

  /** PalmOS SysTrap: sysTrapSysRandom
   *
   * <P>Defined as: Int      SysRandom(ULong newSeed);
   */
  public native static int SysRandom(int newSeed);

  /** PalmOS SysTrap: sysTrapSysReset
   *
   * <P>Defined as: void     SysReset();
   */
  public native static void SysReset();

  /** PalmOS SysTrap: sysTrapSysSetAutoOffTime
   *
   * <P>Defined as: UInt     SysSetAutoOffTime(UInt seconds);
   */
  public native static int SysSetAutoOffTime(int seconds);

  /** PalmOS SysTrap: sysTrapSysTaskDelay
   *
   * <P>Defined as: Err      SysTaskDelay(Long delay);
   */
  public native static int SysTaskDelay(int delay);

  /** PalmOS SysTrap: sysTrapSysUIAppSwitch
   *
   * <P>Defined as: Err      SysUIAppSwitch(UInt cardNo, LocalID dbID, Word cmd, Ptr cmdPBP);
   */
  public native static int SysUIAppSwitch(int cardNo, int dbID, int cmd, Object cmdPBP);

  /** PalmOS SysTrap: sysTrapSysUIAppSwitch
   *
   * <P>Defined as: Err      SysUIAppSwitch(UInt cardNo, LocalID dbID, Word cmd, Handle cmdPBP);
   */
  public native static int SysUIAppSwitch(int cardNo, int dbID, int cmd, int cmdPBP);

  /** PalmOS SysTrap: sysTrapSysLibRemove (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Err      SysLibRemove(UInt refNum);
   */
  public native static int SysLibRemove(int refNum);

  /** PalmOS SysTrap: sysTrapSysLibLoad (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Err      SysLibLoad(ULong libType, ULong libCreator, UIntPtr refNumP);
   */
  public native static int SysLibLoad(int libType, int libCreator, ShortHolder refNumP);

  /** PalmOS SysTrap: sysTrapSysTicksPerSecond (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: UInt huge SysTicksPerSecond();
   */
  public native static int SysTicksPerSecond();

  /** PalmOS SysTrap: sysTrapSysKeyboardDialog (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: void     SysKeyboardDialog(KeyboardType kbd);
   */
  public native static void SysKeyboardDialog(int kbd);

  /** PalmOS SysTrap: sysTrapSysGetTrapAddress (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: voidptr  SysGetTrapAddress(UInt16 trapNum);
   */
  public native static int SysGetTrapAddress(int trapNum);

  /** PalmOS SysTrap: sysTrapSysGetOSVersionString (<B>PalmOS 3.0</B>)
   *
   * <P>Defined as: CharPtr  SysGetOSVersionString();
   */
  public native static String SysGetOSVersionString();

  /** PalmOS SysTrap: sysTrapHwrGetROMToken
   *
   * <P>Defined as: Err      SysGetROMToken(UInt16 cardNo, UInt32 token, ULongPtr dataP, UIntPtr sizeP) = sysTrapHwrGetROMToken;
   */
  public native static int SysGetROMToken(int cardNo, int token, IntHolder dataP, ShortHolder sizeP);
  /** PalmOS SysTrap: sysTrapHwrGetROMToken
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Err      SysGetROMToken(UInt16 cardNo, UInt32 token, ULongPtr dataP, UIntPtr sizeP) = sysTrapHwrGetROMToken;
   */
  public native static int SysGetROMToken(int cardNo, int token, Integer dataP, Short sizeP);

  /** PalmOS SysTrap: sysLibTrapOpen
   *
   * <P>Defined as: Err		 SysLibOpen(UInt16 refNum) = sysLibTrapOpen;
   */
  public native static int SysLibOpen(int refNum);

  /** PalmOS SysTrap: sysLibTrapClose
   *
   * <P>Defined as: Err		 SysLibClose(UInt16 refNum) = sysLibTrapClose;
   */
  public native static int SysLibClose(int refNum);

  /** PalmOS SysTrap: sysLibTrapSleep
   *
   * <P>Defined as: Err	     SysLibSleep(UInt16 refNum) = sysLibTrapSleep;
   */
  public native static int SysLibSleep(int refNum);

  /** PalmOS SysTrap: sysLibTrapWake
   *
   * <P>Defined as: Err      SysLibWake(UInt16 refNum) = sysLibTrapWake;
   */
  public native static int SysLibWake(int refNum);

  /** PalmOS SysTrap: sysTrapTblDrawTable
   *
   * <P>Defined as: void     TblDrawTable(TablePtr table);
   */
  public native static void TblDrawTable(int table);

  /** PalmOS SysTrap: sysTrapTblEditing
   *
   * <P>Defined as: Boolean  TblEditing(TablePtr table);
   */
  public native static boolean TblEditing(int table);

  /** PalmOS SysTrap: sysTrapTblEraseTable
   *
   * <P>Defined as: void     TblEraseTable(TablePtr table);
   */
  public native static void TblEraseTable(int table);

  /** PalmOS SysTrap: sysTrapTblFindRowData
   *
   * <P>Defined as: Boolean  TblFindRowData(TablePtr table, ULong data, WordPtr rowP);
   */
  public native static boolean TblFindRowData(int table, int data, ShortHolder rowP);
  /** PalmOS SysTrap: sysTrapTblFindRowData
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  TblFindRowData(TablePtr table, ULong data, WordPtr rowP);
   */
  public native static boolean TblFindRowData(int table, int data, Short rowP);

  /** PalmOS SysTrap: sysTrapTblFindRowID
   *
   * <P>Defined as: Boolean  TblFindRowID(TablePtr table, Word id, WordPtr rowP);
   */
  public native static boolean TblFindRowID(int table, int id, ShortHolder rowP);
  /** PalmOS SysTrap: sysTrapTblFindRowID
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  TblFindRowID(TablePtr table, Word id, WordPtr rowP);
   */
  public native static boolean TblFindRowID(int table, int id, Short rowP);

  /** PalmOS SysTrap: sysTrapTblGetBounds
   *
   * <P>Defined as: void     TblGetBounds(TablePtr table, RectanglePtr r);
   */
  public native static void TblGetBounds(int table, Rectangle r);

  /** PalmOS SysTrap: sysTrapTblGetColumnSpacing
   *
   * <P>Defined as: Word     TblGetColumnSpacing(TablePtr table, Word column);
   */
  public native static int TblGetColumnSpacing(int table, int column);

  /** PalmOS SysTrap: sysTrapTblGetColumnWidth
   *
   * <P>Defined as: Word     TblGetColumnWidth(TablePtr table, Word column);
   */
  public native static int TblGetColumnWidth(int table, int column);

  /** PalmOS SysTrap: sysTrapTblGetCurrentField
   *
   * <P>Defined as: FieldPtr TblGetCurrentField(TablePtr table);
   */
  public native static int TblGetCurrentField(int table);

  /** PalmOS SysTrap: sysTrapTblGetItemBounds
   *
   * <P>Defined as: void     TblGetItemBounds(TablePtr table, Word row, Word column, RectanglePtr r);
   */
  public native static void TblGetItemBounds(int table, int row, int column, Rectangle r);

  /** PalmOS SysTrap: sysTrapTblGetItemInt
   *
   * <P>Defined as: Word     TblGetItemInt(TablePtr table, Word row, Word column);
   */
  public native static int TblGetItemInt(int table, int row, int column);

  /** PalmOS SysTrap: sysTrapTblGetLastUsableRow
   *
   * <P>Defined as: Word     TblGetLastUsableRow(TablePtr table);
   */
  public native static int TblGetLastUsableRow(int table);

  /** PalmOS SysTrap: sysTrapTblGetNumberOfRows
   *
   * <P>Defined as: Word     TblGetNumberOfRows(TablePtr table);
   */
  public native static int TblGetNumberOfRows(int table);

  /** PalmOS SysTrap: sysTrapTblGetRowData
   *
   * <P>Defined as: ULong    TblGetRowData(TablePtr table, Word row);
   */
  public native static int TblGetRowData(int table, int row);

  /** PalmOS SysTrap: sysTrapTblGetRowHeight
   *
   * <P>Defined as: Word     TblGetRowHeight(TablePtr table, Word row);
   */
  public native static int TblGetRowHeight(int table, int row);

  /** PalmOS SysTrap: sysTrapTblGetRowID
   *
   * <P>Defined as: Word     TblGetRowID(TablePtr table, Word row);
   */
  public native static int TblGetRowID(int table, int row);

  /** PalmOS SysTrap: sysTrapTblGetSelection
   *
   * <P>Defined as: Boolean  TblGetSelection(TablePtr table, WordPtr rowP, WordPtr columnP);
   */
  public native static boolean TblGetSelection(int table, ShortHolder rowP, ShortHolder columnP);
  /** PalmOS SysTrap: sysTrapTblGetSelection
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  TblGetSelection(TablePtr table, WordPtr rowP, WordPtr columnP);
   */
  public native static boolean TblGetSelection(int table, Short rowP, Short columnP);

  /** PalmOS SysTrap: sysTrapTblGrabFocus
   *
   * <P>Defined as: void     TblGrabFocus(TablePtr table, Word row, Word column);
   */
  public native static void TblGrabFocus(int table, int row, int column);

  /** PalmOS SysTrap: sysTrapTblHandleEvent
   *
   * <P>Defined as: Boolean  TblHandleEvent(TablePtr table, EventPtr event);
   */
  public native static boolean TblHandleEvent(int table, Event event);

  /** PalmOS SysTrap: sysTrapTblInsertRow
   *
   * <P>Defined as: void     TblInsertRow(TablePtr table, Word row);
   */
  public native static void TblInsertRow(int table, int row);

  /** PalmOS SysTrap: sysTrapTblMarkRowInvalid
   *
   * <P>Defined as: void     TblMarkRowInvalid(TablePtr table, Word row);
   */
  public native static void TblMarkRowInvalid(int table, int row);

  /** PalmOS SysTrap: sysTrapTblMarkTableInvalid
   *
   * <P>Defined as: void     TblMarkTableInvalid(TablePtr table);
   */
  public native static void TblMarkTableInvalid(int table);

  /** PalmOS SysTrap: sysTrapTblRedrawTable
   *
   * <P>Defined as: void     TblRedrawTable(TablePtr table);
   */
  public native static void TblRedrawTable(int table);

  /** PalmOS SysTrap: sysTrapTblReleaseFocus
   *
   * <P>Defined as: void     TblReleaseFocus(TablePtr table);
   */
  public native static void TblReleaseFocus(int table);

  /** PalmOS SysTrap: sysTrapTblRemoveRow
   *
   * <P>Defined as: void     TblRemoveRow(TablePtr table, Word row);
   */
  public native static void TblRemoveRow(int table, int row);

  /** PalmOS SysTrap: sysTrapTblRowInvalid
   *
   * <P>Defined as: Boolean  TblRowInvalid(TablePtr table, Word row);
   */
  public native static boolean TblRowInvalid(int table, int row);

  /** PalmOS SysTrap: sysTrapTblRowSelectable
   *
   * <P>Defined as: Boolean  TblRowSelectable(TablePtr table, Word row);
   */
  public native static boolean TblRowSelectable(int table, int row);

  /** PalmOS SysTrap: sysTrapTblRowUsable
   *
   * <P>Defined as: Boolean  TblRowUsable(TablePtr table, Word row);
   */
  public native static boolean TblRowUsable(int table, int row);

  /** PalmOS SysTrap: sysTrapTblSelectItem
   *
   * <P>Defined as: void     TblSelectItem(TablePtr table, Word row, Word column);
   */
  public native static void TblSelectItem(int table, int row, int column);

  /** PalmOS SysTrap: sysTrapTblSetColumnSpacing
   *
   * <P>Defined as: void     TblSetColumnSpacing(TablePtr table, Word column, Word spacing);
   */
  public native static void TblSetColumnSpacing(int table, int column, int spacing);

  /** PalmOS SysTrap: sysTrapTblSetColumnUsable
   *
   * <P>Defined as: void     TblSetColumnUsable(TablePtr table, Word column, Boolean usable);
   */
  public native static void TblSetColumnUsable(int table, int column, boolean usable);

  /** PalmOS SysTrap: sysTrapTblSetColumnWidth
   *
   * <P>Defined as: void     TblSetColumnWidth(TablePtr table, Word column, Word width);
   */
  public native static void TblSetColumnWidth(int table, int column, int width);

  /** PalmOS SysTrap: sysTrapTblSetCustomDrawProcedure
   *
   * <P>Defined as: void     TblSetCustomDrawProcedure(TablePtr table, Word column, const TableDrawItemFuncPtr drawCallback);
   */
  public native static void TblSetCustomDrawProcedure(int table, int column, TableDrawItemHandler drawCallback);

  /** PalmOS SysTrap: sysTrapTblSetItemInt
   *
   * <P>Defined as: void     TblSetItemInt(TablePtr table, Word row, Word column, Word value);
   */
  public native static void TblSetItemInt(int table, int row, int column, int value);

  /** PalmOS SysTrap: sysTrapTblSetItemPtr
   *
   * <P>Defined as: void     TblSetItemPtr(TablePtr table, Word row, Word column, VoidPtr value);
   */
  public native static void TblSetItemPtr(int table, int row, int column, Object value);

  /** PalmOS SysTrap: sysTrapTblSetItemPtr
   *
   * <P>Defined as: void     TblSetItemPtr(TablePtr table, Word row, Word column, voidptr value);
   */
  public native static void TblSetItemPtr(int table, int row, int column, int value);

  /** PalmOS SysTrap: sysTrapTblSetItemStyle
   *
   * <P>Defined as: void     TblSetItemStyle(TablePtr table, Word row, Word column, TableItemStyleType type);
   */
  public native static void TblSetItemStyle(int table, int row, int column, int type);

  /** PalmOS SysTrap: sysTrapTblSetLoadDataProcedure
   *
   * <P>Defined as: void     TblSetLoadDataProcedure(TablePtr table, Word column, TableLoadDataFuncPtr loadDataCallback);
   */
  public native static void TblSetLoadDataProcedure(int table, int column, TableLoadDataHandler loadDataCallback);

  /** PalmOS SysTrap: sysTrapTblSetRowData
   *
   * <P>Defined as: void     TblSetRowData(TablePtr table, Word row, ULong data);
   */
  public native static void TblSetRowData(int table, int row, int data);

  /** PalmOS SysTrap: sysTrapTblSetRowHeight
   *
   * <P>Defined as: void     TblSetRowHeight(TablePtr table, Word row, Word height);
   */
  public native static void TblSetRowHeight(int table, int row, int height);

  /** PalmOS SysTrap: sysTrapTblSetRowID
   *
   * <P>Defined as: void     TblSetRowID(TablePtr table, Word row, Word id);
   */
  public native static void TblSetRowID(int table, int row, int id);

  /** PalmOS SysTrap: sysTrapTblSetRowSelectable
   *
   * <P>Defined as: void     TblSetRowSelectable(TablePtr table, Word row, Boolean selectable);
   */
  public native static void TblSetRowSelectable(int table, int row, boolean selectable);

  /** PalmOS SysTrap: sysTrapTblSetRowUsable
   *
   * <P>Defined as: void     TblSetRowUsable(TablePtr table, Word row, Boolean usable);
   */
  public native static void TblSetRowUsable(int table, int row, boolean usable);

  /** PalmOS SysTrap: sysTrapTblSetSaveDataProcedure
   *
   * <P>Defined as: void     TblSetSaveDataProcedure(TablePtr table, Word column, TableSaveDataFuncPtr saveDataCallback);
   */
  public native static void TblSetSaveDataProcedure(int table, int column, TableSaveDataHandler saveDataCallback);

  /** PalmOS SysTrap: sysTrapTblUnhighlightSelection
   *
   * <P>Defined as: void     TblUnhighlightSelection(TablePtr table);
   */
  public native static void TblUnhighlightSelection(int table);

  /** PalmOS SysTrap: sysTrapTblSetRowStaticHeight (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: void TblSetRowStaticHeight(TablePtr table,Int16 row, Boolean staticHeight);
   */
  public native static void TblSetRowStaticHeight(int table, int row, boolean staticHeight);

  /** PalmOS SysTrap: sysTrapTblSetItemFont (<B>PalmOS 3.0</B>)
   *
   * <P>Defined as: void TblSetItemFont(TablePtr table, Int16 row, Int16 column, FontID fontID);
   */
  public native static void TblSetItemFont(int table, int row, int column, int fontID);

  /** PalmOS SysTrap: sysTrapTblSetColumnMasked (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void TblSetColumnMasked (TablePtr table, Int16 column, Boolean masked);
   */
  public native static void TblSetColumnMasked(int table, int column, boolean masked);

  /** PalmOS SysTrap: sysTrapTblSetRowMasked (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void TblSetRowMasked(TablePtr table, Int16 row, Boolean masked);
   */
  public native static void TblSetRowMasked(int table, int row, boolean masked);

  /** PalmOS SysTrap: sysTrapTblRowMasked (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Boolean TblRowMasked(TablePtr table, Int16 row);
   */
  public native static boolean TblRowMasked(int table, int row);

  /** PalmOS SysTrap: sysTrapTblGetNumberOfColumns (<B>PalmOS 4.0</B>)
   *
   * <P>Defined as: Int16 TblGetNumberOfColumns(TablePtr table);
   */
  public native static int TblGetNumberOfColumns(int table);

  /** PalmOS SysTrap: sysTrapTblGetTopRow (<B>PalmOS 4.0</B>)
   *
   * <P>Defined as: Int16 TblGetTopRow(TablePtr table);
   */
  public native static int TblGetTopRow(int table);

  /** PalmOS SysTrap: sysTrapTblSetSelection (<B>PalmOS 4.0</B>)
   *
   * <P>Defined as: void TblSetSelection(TablePtr table, Int16 row, Int16 column);
   */
  public native static void TblSetSelection(int table, int row, int column);

  /** PalmOS SysTrap: sysTrapDateAdjust
   *
   * <P>Defined as: void     DateAdjust(DatePtr dateP, Long adjustment);
   */
  public native static void DateAdjust(Date dateP, int adjustment);

  /** PalmOS SysTrap: sysTrapDateDaysToDate
   *
   * <P>Defined as: void     DateDaysToDate(ULong days, DatePtr dateP);
   */
  public native static void DateDaysToDate(int days, Date dateP);

  /** PalmOS SysTrap: sysTrapDateSecondsToDate
   *
   * <P>Defined as: void     DateSecondsToDate(ULong seconds, DatePtr dateP);
   */
  public native static void DateSecondsToDate(int seconds, Date dateP);

  /** PalmOS SysTrap: sysTrapDateToAscii
   *
   * <P>Defined as: void     DateToAscii(Byte months, Byte days, Word years, DateFormatType dateFormat, CharBuf pString);
   */
  public native static void DateToAscii(int months, int days, int years, int dateFormat, StringBuffer pString);

  /** PalmOS SysTrap: sysTrapDateToDays
   *
   * <P>Defined as: ULong    DateToDays(DateType date);
   */
  public native static int DateToDays(int date);

  /** PalmOS SysTrap: sysTrapDateToDOWDMFormat
   *
   * <P>Defined as: void     DateToDOWDMFormat(Byte months, Byte days, Word years, DateFormatType dateFormat, CharBuf pString);
   */
  public native static void DateToDOWDMFormat(int months, int days, int years, int dateFormat, StringBuffer pString);

  /** PalmOS SysTrap: sysTrapDayOfMonth
   *
   * <P>Defined as: UInt     DayOfMonth(UInt month, UInt day, UInt year);
   */
  public native static int DayOfMonth(int month, int day, int year);

  /** PalmOS SysTrap: sysTrapDayOfWeek
   *
   * <P>Defined as: UInt     DayOfWeek(UInt month, UInt day, UInt year);
   */
  public native static int DayOfWeek(int month, int day, int year);

  /** PalmOS SysTrap: sysTrapDaysInMonth
   *
   * <P>Defined as: UInt     DaysInMonth(UInt month, UInt year);
   */
  public native static int DaysInMonth(int month, int year);

  /** PalmOS SysTrap: sysTrapSelectDayV10
   *
   * <P>Defined as: Boolean  SelectDay(int* month, int* day, int* year, CharPtr title) = sysTrapSelectDayV10;
   */
  public native static boolean SelectDay(ShortHolder month, ShortHolder day, ShortHolder year, String title);
  /** PalmOS SysTrap: sysTrapSelectDayV10
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: Boolean  SelectDay(int* month, int* day, int* year, CharPtr title) = sysTrapSelectDayV10;
   */
  public native static boolean SelectDay(Short month, Short day, Short year, String title);

  /** PalmOS SysTrap: sysTrapDayDrawDaySelector
   *
   * <P>Defined as: void     DayDrawDaySelector(const DaySelectorPtr pSelector);
   */
  public native static void DayDrawDaySelector(DaySelector pSelector);

  /** PalmOS SysTrap: sysTrapTimAdjust
   *
   * <P>Defined as: void     TimAdjust(DateTimePtr dateTimeP, Long adjustment);
   */
  public native static void TimAdjust(DateTime dateTimeP, int adjustment);

  /** PalmOS SysTrap: sysTrapTimDateTimeToSeconds
   *
   * <P>Defined as: ULong    TimDateTimeToSeconds(DateTimePtr dateTimeP);
   */
  public native static int TimDateTimeToSeconds(DateTime dateTimeP);

  /** PalmOS SysTrap: sysTrapTimGetSeconds
   *
   * <P>Defined as: ULong    TimGetSeconds();
   */
  public native static int TimGetSeconds();

  /** PalmOS SysTrap: sysTrapTimGetTicks
   *
   * <P>Defined as: ULong huge TimGetTicks();
   */
  public native static int TimGetTicks();

  /** PalmOS SysTrap: sysTrapTimSecondsToDateTime
   *
   * <P>Defined as: void     TimSecondsToDateTime(ULong seconds, DateTimePtr dateTimeP);
   */
  public native static void TimSecondsToDateTime(int seconds, DateTime dateTimeP);

  /** PalmOS SysTrap: sysTrapTimSetSeconds
   *
   * <P>Defined as: void     TimSetSeconds(ULong seconds);
   */
  public native static void TimSetSeconds(int seconds);

  /** PalmOS SysTrap: sysTrapTimeToAscii
   *
   * <P>Defined as: void     TimeToAscii(Byte hours, Byte minutes, TimeFormatType timeFormat, CharBuf pString);
   */
  public native static void TimeToAscii(int hours, int minutes, int timeFormat, StringBuffer pString);

  /** PalmOS SysTrap: sysTrapSelectDay (<B>PalmOS 2.0</B>)
   *
   * <P>Defined as: Boolean SelectDay(int selectDayBy, int* month, int* day, int* year, const CharPtr title);
   */
  public native static boolean SelectDay(int selectDayBy, ShortHolder month, ShortHolder day, ShortHolder year, String title);

  /** PalmOS SysTrap: sysTrapSelectOneTime (<B>PalmOS 3.1</B>)
   *
   * <P>Defined as: Boolean  SelectOneTime(int* hour, int* minute, const CharPtr title);
   */
  public native static boolean SelectOneTime(ShortHolder hour, ShortHolder minute, String title);

  /** PalmOS SysTrap: sysTrapSelectTimeV33 (<B>PalmOS 3.3</B>)
   *
   * <P>Defined as: Boolean SelectTime(TimePtr startTime, TimePtr endTime, Boolean untimed, CharPtr title, Int16 startOfDay) = sysTrapSelectTimeV33;
   */
  public native static boolean SelectTime(Time startTime, Time endTime, boolean untimed, String title, int startOfDay);

  /** PalmOS SysTrap: sysTrapSelectTime (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Boolean SelectTime(TimePtr startTime, TimePtr endTime, Boolean untimed, const CharPtr title, Int16 startOfDay, Int16 endOfDay, Int16 startOfDisplay);
   */
  public native static boolean SelectTime(Time startTime, Time endTime, boolean untimed, String title, int startOfDay, int endOfDay, int startOfDisplay);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapInit (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSInit() = sysTrapVFSMgr selector vfsTrapInit;
   */
  public native static int VFSInit();

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileCreate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileCreate(UInt16 volRefNum, const CharPtr pathName) = sysTrapVFSMgr selector vfsTrapFileCreate;
   */
  public native static int VFSFileCreate(int volRefNum, String pathName);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileOpen (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileOpen(UInt16 volRefNum, const CharPtr pathName, UInt16 openMode, FileRefPtr fileRefP) = sysTrapVFSMgr selector vfsTrapFileOpen;
   */
  public native static int VFSFileOpen(int volRefNum, String pathName, int openMode, IntHolder fileRefP);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileClose (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileClose(FileRef fileRef) = sysTrapVFSMgr selector vfsTrapFileClose;
   */
  public native static int VFSFileClose(int fileRef);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileReadData (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileReadData(FileRef fileRef, UInt32 numBytes, ByteArray bufBase, UInt32 offset, DWordPtr numBytesRead) = sysTrapVFSMgr selector vfsTrapFileReadData;
   */
  public native static int VFSFileReadData(int fileRef, int numBytes, byte [] bufBase, int _bufBase_off, int offset, IntHolder numBytesRead);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileRead (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileRead(FileRef fileRef, UInt32 numBytes, ByteArray buf, DWordPtr numBytesRead) = sysTrapVFSMgr selector vfsTrapFileRead;
   */
  public native static int VFSFileRead(int fileRef, int numBytes, byte [] buf, int _buf_off, IntHolder numBytesRead);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileWrite (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileWrite(FileRef fileRef, UInt32 numBytes, const ByteArray data, DWordPtr numBytesWritten) = sysTrapVFSMgr selector vfsTrapFileWrite;
   */
  public native static int VFSFileWrite(int fileRef, int numBytes, byte [] data, int _data_off, IntHolder numBytesWritten);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileDelete (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileDelete(UInt16 volRefNum, const CharPtr pathName) = sysTrapVFSMgr selector vfsTrapFileDelete;
   */
  public native static int VFSFileDelete(int volRefNum, String pathName);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileRename (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileRename(UInt16 volRefNum, const CharPtr pathName, const CharPtr newName) = sysTrapVFSMgr selector vfsTrapFileRename;
   */
  public native static int VFSFileRename(int volRefNum, String pathName, String newName);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileSeek (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileSeek(FileRef fileRef, UInt16 origin, Int32 offset) = sysTrapVFSMgr selector vfsTrapFileSeek;
   */
  public native static int VFSFileSeek(int fileRef, int origin, int offset);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileEOF (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileEOF(FileRef fileRef) = sysTrapVFSMgr selector vfsTrapFileEOF;
   */
  public native static int VFSFileEOF(int fileRef);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileTell (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileTell(FileRef fileRef, DWordPtr filePos) = sysTrapVFSMgr selector vfsTrapFileTell;
   */
  public native static int VFSFileTell(int fileRef, IntHolder filePos);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileSize (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileSize(FileRef fileRef, DWordPtr fileSize) = sysTrapVFSMgr selector vfsTrapFileSize;
   */
  public native static int VFSFileSize(int fileRef, IntHolder fileSize);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileResize (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileResize(FileRef fileRef, UInt32 newSize) = sysTrapVFSMgr selector vfsTrapFileResize;
   */
  public native static int VFSFileResize(int fileRef, int newSize);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileGetAttributes (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileGetAttributes(FileRef fileRef, DWordPtr attributes) = sysTrapVFSMgr selector vfsTrapFileGetAttributes;
   */
  public native static int VFSFileGetAttributes(int fileRef, IntHolder attributes);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileSetAttributes (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileSetAttributes(FileRef fileRef, UInt32 attributes) = sysTrapVFSMgr selector vfsTrapFileSetAttributes;
   */
  public native static int VFSFileSetAttributes(int fileRef, int attributes);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileGetDate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileGetDate(FileRef fileRef, UInt16 whichDate, DWordPtr date) = sysTrapVFSMgr selector vfsTrapFileGetDate;
   */
  public native static int VFSFileGetDate(int fileRef, int whichDate, IntHolder date);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapFileSetDate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSFileSetDate(FileRef fileRef, UInt16 whichDate, UInt32 date) = sysTrapVFSMgr selector vfsTrapFileSetDate;
   */
  public native static int VFSFileSetDate(int fileRef, int whichDate, int date);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapDirCreate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSDirCreate(UInt16 volRefNum, const CharPtr dirName) = sysTrapVFSMgr selector vfsTrapDirCreate;
   */
  public native static int VFSDirCreate(int volRefNum, String dirName);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapVolumeEnumerate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSVolumeEnumerate(WordPtr volRefNum, DWordPtr volIterator) = sysTrapVFSMgr selector vfsTrapVolumeEnumerate;
   */
  public native static int VFSVolumeEnumerate(ShortHolder volRefNum, IntHolder volIterator);

  /** PalmOS SysTrap: sysTrapVFSMgr/vfsTrapDirEntryEnumerate (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err     VFSDirEntryEnumerate(FileRef dirRef, DWordPtr dirEntryIterator, FileInfoTypePtr info) = sysTrapVFSMgr selector vfsTrapDirEntryEnumerate;
   */
  public native static int VFSDirEntryEnumerate(int dirRef, IntHolder dirEntryIterator, FileInfoType info);

  /** PalmOS SysTrap: sysTrapWinAddWindow
   *
   * <P>Defined as: void     WinAddWindow(WinHandle winHandle);
   */
  public native static void WinAddWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinClipRectangle
   *
   * <P>Defined as: void     WinClipRectangle(RectanglePtr r);
   */
  public native static void WinClipRectangle(Rectangle r);

  /** PalmOS SysTrap: sysTrapWinCopyRectangle
   *
   * <P>Defined as: void     WinCopyRectangle(WinHandle srcWin, WinHandle dstWin, RectanglePtr srcRect, SWord destX, SWord destY, ScrOperation mode);
   */
  public native static void WinCopyRectangle(int srcWin, int dstWin, Rectangle srcRect, int destX, int destY, int mode);

  /** PalmOS SysTrap: sysTrapWinCreateWindow
   *
   * <P>Defined as: WinHandle WinCreateWindow(RectanglePtr bounds, FrameType frame, Boolean modal, Boolean focusable, WordPtr error);
   */
  public native static int WinCreateWindow(Rectangle bounds, int frame, boolean modal, boolean focusable, ShortHolder error);
  /** PalmOS SysTrap: sysTrapWinCreateWindow
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: WinHandle WinCreateWindow(RectanglePtr bounds, FrameType frame, Boolean modal, Boolean focusable, WordPtr error);
   */
  public native static int WinCreateWindow(Rectangle bounds, int frame, boolean modal, boolean focusable, Short error);

  /** PalmOS SysTrap: sysTrapWinCreateOffscreenWindow
   *
   * <P>Defined as: WinHandle WinCreateOffscreenWindow(SWord width, SWord height, WindowFormatType format, WordPtr error);
   */
  public native static int WinCreateOffscreenWindow(int width, int height, int format, ShortHolder error);
  /** PalmOS SysTrap: sysTrapWinCreateOffscreenWindow
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: WinHandle WinCreateOffscreenWindow(SWord width, SWord height, WindowFormatType format, WordPtr error);
   */
  public native static int WinCreateOffscreenWindow(int width, int height, int format, Short error);

  /** PalmOS SysTrap: sysTrapWinDeleteWindow
   *
   * <P>Defined as: void     WinDeleteWindow(WinHandle winHandle, Boolean eraseIt);
   */
  public native static void WinDeleteWindow(int winHandle, boolean eraseIt);

  /** PalmOS SysTrap: sysTrapWinDisableWindow
   *
   * <P>Defined as: void     WinDisableWindow(WinHandle winHandle);
   */
  public native static void WinDisableWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinDisplayToWindowPt
   *
   * <P>Defined as: void     WinDisplayToWindowPt(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinDisplayToWindowPt(ShortHolder extentX, ShortHolder extentY);
  /** PalmOS SysTrap: sysTrapWinDisplayToWindowPt
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     WinDisplayToWindowPt(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinDisplayToWindowPt(Short extentX, Short extentY);

  /** PalmOS SysTrap: sysTrapWinDrawBitmap
   *
   * <P>Defined as: void     WinDrawBitmap(BitmapPtr bitmap, SWord x, SWord y);
   */
  public native static void WinDrawBitmap(int bitmap, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawChars
   *
   * <P>Defined as: void huge WinDrawChars(CharPtr chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawChars(String chars, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawChars
   *
   * <P>Defined as: void huge WinDrawChars(CharPtr+ chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawChars(String chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawChars
   *
   * <P>Defined as: void huge WinDrawChars(CharArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawChars(char [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawChars
   *
   * <P>Defined as: void huge WinDrawChars(ByteArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawChars(byte [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawGrayLine
   *
   * <P>Defined as: void     WinDrawGrayLine(SWord x1, SWord y1, SWord x2, SWord y2);
   */
  public native static void WinDrawGrayLine(int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: sysTrapWinDrawGrayRectangleFrame
   *
   * <P>Defined as: void     WinDrawGrayRectangleFrame(FrameType frame, RectanglePtr r);
   */
  public native static void WinDrawGrayRectangleFrame(int frame, Rectangle r);

  /** PalmOS SysTrap: sysTrapWinDrawInvertedChars
   *
   * <P>Defined as: void huge WinDrawInvertedChars(CharPtr chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawInvertedChars(String chars, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawInvertedChars
   *
   * <P>Defined as: void huge WinDrawInvertedChars(CharPtr+ chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawInvertedChars(String chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawInvertedChars
   *
   * <P>Defined as: void huge WinDrawInvertedChars(CharArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawInvertedChars(char [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawInvertedChars
   *
   * <P>Defined as: void huge WinDrawInvertedChars(ByteArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinDrawInvertedChars(byte [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawLine
   *
   * <P>Defined as: void     WinDrawLine(SWord x1, SWord y1, SWord x2, SWord y2);
   */
  public native static void WinDrawLine(int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: sysTrapWinDrawRectangle
   *
   * <P>Defined as: void     WinDrawRectangle(RectanglePtr r, Word cornerDiam);
   */
  public native static void WinDrawRectangle(Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: sysTrapWinDrawRectangleFrame
   *
   * <P>Defined as: void     WinDrawRectangleFrame(FrameType frame, RectanglePtr r);
   */
  public native static void WinDrawRectangleFrame(int frame, Rectangle r);

  /** PalmOS SysTrap: sysTrapWinDrawWindowFrame
   *
   * <P>Defined as: void     WinDrawWindowFrame();
   */
  public native static void WinDrawWindowFrame();

  /** PalmOS SysTrap: sysTrapWinEnableWindow
   *
   * <P>Defined as: void     WinEnableWindow(WinHandle winHandle);
   */
  public native static void WinEnableWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinEraseChars
   *
   * <P>Defined as: void huge WinEraseChars(CharPtr chars, Word len, SWord x, SWord y);
   */
  public native static void WinEraseChars(String chars, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinEraseChars
   *
   * <P>Defined as: void huge WinEraseChars(CharPtr+ chars, Word len, SWord x, SWord y);
   */
  public native static void WinEraseChars(String chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinEraseChars
   *
   * <P>Defined as: void huge WinEraseChars(CharArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinEraseChars(char [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinEraseChars
   *
   * <P>Defined as: void huge WinEraseChars(ByteArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinEraseChars(byte [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinEraseLine
   *
   * <P>Defined as: void     WinEraseLine(SWord x1, SWord y1, SWord x2, SWord y2);
   */
  public native static void WinEraseLine(int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: sysTrapWinEraseRectangle
   *
   * <P>Defined as: void     WinEraseRectangle(RectanglePtr r, Word cornerDiam);
   */
  public native static void WinEraseRectangle(Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: sysTrapWinEraseRectangleFrame
   *
   * <P>Defined as: void     WinEraseRectangleFrame(FrameType frame, RectanglePtr r);
   */
  public native static void WinEraseRectangleFrame(int frame, Rectangle r);

  /** PalmOS SysTrap: sysTrapWinEraseWindow
   *
   * <P>Defined as: void     WinEraseWindow();
   */
  public native static void WinEraseWindow();

  /** PalmOS SysTrap: sysTrapWinFillLine
   *
   * <P>Defined as: void     WinFillLine(SWord x1, SWord y1, SWord x2, SWord y2);
   */
  public native static void WinFillLine(int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: sysTrapWinFillRectangle
   *
   * <P>Defined as: void     WinFillRectangle(RectanglePtr r, Word cornerDiam);
   */
  public native static void WinFillRectangle(Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: sysTrapWinGetActiveWindow
   *
   * <P>Defined as: WinHandle WinGetActiveWindow();
   */
  public native static int WinGetActiveWindow();

  /** PalmOS SysTrap: sysTrapWinGetClip
   *
   * <P>Defined as: void     WinGetClip(RectanglePtr r);
   */
  public native static void WinGetClip(Rectangle r);

  /** PalmOS SysTrap: sysTrapWinGetDisplayExtent
   *
   * <P>Defined as: void     WinGetDisplayExtent(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinGetDisplayExtent(ShortHolder extentX, ShortHolder extentY);
  /** PalmOS SysTrap: sysTrapWinGetDisplayExtent
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     WinGetDisplayExtent(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinGetDisplayExtent(Short extentX, Short extentY);

  /** PalmOS SysTrap: sysTrapWinGetDisplayWindow
   *
   * <P>Defined as: WinHandle WinGetDisplayWindow();
   */
  public native static int WinGetDisplayWindow();

  /** PalmOS SysTrap: sysTrapWinGetDrawWindow
   *
   * <P>Defined as: WinHandle WinGetDrawWindow();
   */
  public native static int WinGetDrawWindow();

  /** PalmOS SysTrap: sysTrapWinGetFirstWindow
   *
   * <P>Defined as: WinHandle WinGetFirstWindow();
   */
  public native static int WinGetFirstWindow();

  /** PalmOS SysTrap: sysTrapWinGetFramesRectangle
   *
   * <P>Defined as: void     WinGetFramesRectangle(FrameType frame, RectanglePtr r, RectanglePtr obscuredRect);
   */
  public native static void WinGetFramesRectangle(int frame, Rectangle r, Rectangle obscuredRect);

  /** PalmOS SysTrap: sysTrapWinGetWindowBounds
   *
   * <P>Defined as: void     WinGetWindowBounds(RectanglePtr r);
   */
  public native static void WinGetWindowBounds(Rectangle r);

  /** PalmOS SysTrap: sysTrapWinGetWindowExtent
   *
   * <P>Defined as: void     WinGetWindowExtent(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinGetWindowExtent(ShortHolder extentX, ShortHolder extentY);
  /** PalmOS SysTrap: sysTrapWinGetWindowExtent
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     WinGetWindowExtent(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinGetWindowExtent(Short extentX, Short extentY);

  /** PalmOS SysTrap: sysTrapWinGetWindowFrameRect
   *
   * <P>Defined as: void     WinGetWindowFrameRect(WinHandle winHandle, RectanglePtr r);
   */
  public native static void WinGetWindowFrameRect(int winHandle, Rectangle r);

  /** PalmOS SysTrap: sysTrapWinInitializeWindow
   *
   * <P>Defined as: void     WinInitializeWindow(WinHandle winHandle);
   */
  public native static void WinInitializeWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinInvertChars
   *
   * <P>Defined as: void huge WinInvertChars(CharPtr chars, Word len, SWord x, SWord y);
   */
  public native static void WinInvertChars(String chars, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinInvertChars
   *
   * <P>Defined as: void huge WinInvertChars(CharPtr+ chars, Word len, SWord x, SWord y);
   */
  public native static void WinInvertChars(String chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinInvertChars
   *
   * <P>Defined as: void huge WinInvertChars(CharArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinInvertChars(char [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinInvertChars
   *
   * <P>Defined as: void huge WinInvertChars(ByteArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinInvertChars(byte [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinInvertLine
   *
   * <P>Defined as: void     WinInvertLine(SWord x1, SWord y1, SWord x2, SWord y2);
   */
  public native static void WinInvertLine(int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: sysTrapWinInvertRectangle
   *
   * <P>Defined as: void     WinInvertRectangle(RectanglePtr r, Word cornerDiam);
   */
  public native static void WinInvertRectangle(Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: sysTrapWinInvertRectangleFrame
   *
   * <P>Defined as: void     WinInvertRectangleFrame(FrameType frame, RectanglePtr r);
   */
  public native static void WinInvertRectangleFrame(int frame, Rectangle r);

  /** PalmOS SysTrap: sysTrapWinModal
   *
   * <P>Defined as: Boolean  WinModal(WinHandle winHandle);
   */
  public native static boolean WinModal(int winHandle);

  /** PalmOS SysTrap: sysTrapWinPushDrawState
   *
   * <P>Defined as: void     WinPushDrawState();
   */
  public native static void WinPushDrawState();

  /** PalmOS SysTrap: sysTrapWinPopDrawState
   *
   * <P>Defined as: void     WinPopDrawState();
   */
  public native static void WinPopDrawState();

  /** PalmOS SysTrap: sysTrapWinRemoveWindow
   *
   * <P>Defined as: void     WinRemoveWindow(WinHandle winHandle);
   */
  public native static void WinRemoveWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinResetClip
   *
   * <P>Defined as: void     WinResetClip();
   */
  public native static void WinResetClip();

  /** PalmOS SysTrap: sysTrapWinRestoreBits
   *
   * <P>Defined as: void     WinRestoreBits(WinHandle winHandle, SWord destX, SWord destY);
   */
  public native static void WinRestoreBits(int winHandle, int destX, int destY);

  /** PalmOS SysTrap: sysTrapWinSaveBits
   *
   * <P>Defined as: WinHandle WinSaveBits(RectanglePtr sourceP, WordPtr error);
   */
  public native static int WinSaveBits(Rectangle sourceP, ShortHolder error);
  /** PalmOS SysTrap: sysTrapWinSaveBits
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: WinHandle WinSaveBits(RectanglePtr sourceP, WordPtr error);
   */
  public native static int WinSaveBits(Rectangle sourceP, Short error);

  /** PalmOS SysTrap: sysTrapWinScrollRectangle
   *
   * <P>Defined as: void     WinScrollRectangle(RectanglePtr r, DirectionType direction, SWord distance, RectanglePtr vacated);
   */
  public native static void WinScrollRectangle(Rectangle r, int direction, int distance, Rectangle vacated);

  /** PalmOS SysTrap: sysTrapWinSetActiveWindow
   *
   * <P>Defined as: void     WinSetActiveWindow(WinHandle winHandle);
   */
  public native static void WinSetActiveWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinSetClip
   *
   * <P>Defined as: void     WinSetClip(RectanglePtr r);
   */
  public native static void WinSetClip(Rectangle r);

  /** PalmOS SysTrap: sysTrapWinSetDrawWindow
   *
   * <P>Defined as: WinHandle huge WinSetDrawWindow(WinHandle winHandle);
   */
  public native static int WinSetDrawWindow(int winHandle);

  /** PalmOS SysTrap: sysTrapWinSetUnderlineMode
   *
   * <P>Defined as: UnderlineModeType WinSetUnderlineMode(UnderlineModeType mode);
   */
  public native static int WinSetUnderlineMode(int mode);

  /** PalmOS SysTrap: sysTrapWinWindowToDisplayPt
   *
   * <P>Defined as: void     WinWindowToDisplayPt(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinWindowToDisplayPt(ShortHolder extentX, ShortHolder extentY);
  /** PalmOS SysTrap: sysTrapWinWindowToDisplayPt
   *  @deprecated Use the xxxHolder version instead.
   *
   * <P>Defined as: void     WinWindowToDisplayPt(SWordPtr extentX, SWordPtr extentY);
   */
  public native static void WinWindowToDisplayPt(Short extentX, Short extentY);

  /** PalmOS SysTrap: sysTrapWinCreateBitmapWindow (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: WinHandle WinCreateBitmapWindow(BitmapPtr bitmap, UIntPtr error);
   */
  public native static int WinCreateBitmapWindow(int bitmap, ShortHolder error);

  /** PalmOS SysTrap: sysTrapWinGetBitmap (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: BitmapPtr WinGetBitmap(WinHandle winHandle);
   */
  public native static int WinGetBitmap(int winHandle);

  /** PalmOS SysTrap: sysTrapWinPaintBitmap (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void     WinPaintBitmap(BitmapPtr bitmap, SWord x, SWord y);
   */
  public native static void WinPaintBitmap(int bitmap, int x, int y);

  /** PalmOS SysTrap: sysTrapWinRGBToIndex (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Byte huge WinRGBToIndex(RGBColorTypePtr color);
   */
  public native static byte WinRGBToIndex(RGBColor color);

  /** PalmOS SysTrap: sysTrapWinSetForeColor (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Byte huge WinSetForeColor(Byte foreColorIndex);
   */
  public native static byte WinSetForeColor(int foreColorIndex);

  /** PalmOS SysTrap: sysTrapWinPalette (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err      WinPalette(UInt8 operation, Int16 startIndex, UInt16 paletteEntries, VoidPtr table);
   */
  public native static int WinPalette(int operation, int startIndex, int paletteEntries, Object table);

  /** PalmOS SysTrap: sysTrapWinScreenMode (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Err      WinScreenMode(byte operation, ULongPtr width, ULongPtr height, ULongPtr depth, BooleanPtr enableColor);
   */
  public native static int WinScreenMode(int operation, IntHolder width, IntHolder height, IntHolder depth, BoolHolder enableColor);

  /** PalmOS SysTrap: sysTrapWinGetPixel (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Byte huge WinGetPixel(int x, int y);
   */
  public native static byte WinGetPixel(int x, int y);

  /** PalmOS SysTrap: sysTrapWinDrawPixel (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinDrawPixel(int x, int y);
   */
  public native static void WinDrawPixel(int x, int y);

  /** PalmOS SysTrap: sysTrapWinPaintPixel (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinPaintPixel(int x, int y);
   */
  public native static void WinPaintPixel(int x, int y);

  /** PalmOS SysTrap: sysTrapWinErasePixel (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinErasePixel(int x, int y);
   */
  public native static void WinErasePixel(int x, int y);

  /** PalmOS SysTrap: sysTrapWinPaintLine (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void     WinPaintLine(SWord x1, SWord y1, SWord x2, SWord y2);
   */
  public native static void WinPaintLine(int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: sysTrapWinPaintRectangle (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void     WinPaintRectangle(RectanglePtr r, Word cornerDiam);
   */
  public native static void WinPaintRectangle(Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: sysTrapWinSetTextColor (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Byte huge WinSetTextColor(Byte textColorIndex);
   */
  public native static byte WinSetTextColor(int textColorIndex);

  /** PalmOS SysTrap: sysTrapWinSetBackColor (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Byte huge WinSetBackColor(Byte backColorIndex);
   */
  public native static byte WinSetBackColor(int backColorIndex);

  /** PalmOS SysTrap: sysTrapWinSetDrawMode (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: Int16    WinSetDrawMode(Byte mode);
   */
  public native static int WinSetDrawMode(int mode);

  /** PalmOS SysTrap: sysTrapWinPaintChars (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinPaintChars(CharPtr chars, Word len, SWord x, SWord y);
   */
  public native static void WinPaintChars(String chars, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinPaintChars (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinPaintChars(CharPtr+ chars, Word len, SWord x, SWord y);
   */
  public native static void WinPaintChars(String chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinPaintChars (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinPaintChars(CharArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinPaintChars(char [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapWinPaintChars (<B>PalmOS 3.5</B>)
   *
   * <P>Defined as: void huge WinPaintChars(ByteArray chars, Word len, SWord x, SWord y);
   */
  public native static void WinPaintChars(byte [] chars, int _chars_off, int len, int x, int y);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinSetCoordinateSystem (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: UInt16   WinSetCoordinateSystem(UInt16 coordSys) = sysTrapHighDensityDispatch selector HDSelectorWinSetCoordinateSystem;
   */
  public native static int WinSetCoordinateSystem(int coordSys);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinGetCoordinateSystem (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: UInt16   WinGetCoordinateSystem() = sysTrapHighDensityDispatch selector HDSelectorWinGetCoordinateSystem;
   */
  public native static int WinGetCoordinateSystem();

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinScaleCoord (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Coord    WinScaleCoord(Coord coord, Boolean ceiling) = sysTrapHighDensityDispatch selector HDSelectorWinScaleCoord;
   */
  public native static int WinScaleCoord(int coord, boolean ceiling);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinUnscaleCoord (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Coord    WinUnscaleCoord(Coord coord, Boolean ceiling) = sysTrapHighDensityDispatch selector HDSelectorWinUnscaleCoord;
   */
  public native static int WinUnscaleCoord(int coord, boolean ceiling);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinScalePoint (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     WinScalePoint(PointType* pointP, Boolean ceiling) = sysTrapHighDensityDispatch selector HDSelectorWinScalePoint;
   */
  public native static void WinScalePoint(PointType pointP, boolean ceiling);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinUnscalePoint (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     WinUnscalePoint(PointType* pointP, Boolean ceiling) = sysTrapHighDensityDispatch selector HDSelectorWinUnscalePoint;
   */
  public native static void WinUnscalePoint(PointType pointP, boolean ceiling);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinScaleRectangle (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     WinScaleRectangle(RectanglePtr rect) = sysTrapHighDensityDispatch selector HDSelectorWinScaleRectangle;
   */
  public native static void WinScaleRectangle(Rectangle rect);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinUnscaleRectangle (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     WinUnscaleRectangle(RectanglePtr rect) = sysTrapHighDensityDispatch selector HDSelectorWinUnscaleRectangle;
   */
  public native static void WinUnscaleRectangle(Rectangle rect);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinScreenGetAttribute (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Err      WinScreenGetAttribute(WinScreenAttrType selector, DWordPtr attr) = sysTrapHighDensityDispatch selector HDSelectorWinScreenGetAttribute;
   */
  public native static int WinScreenGetAttribute(int selector, IntHolder attr);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinPaintTiledBitmap (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     WinPaintTiledBitmap(BitmapPtr bitmap, RectanglePtr rect) = sysTrapHighDensityDispatch selector HDSelectorWinPaintTiledBitmap;
   */
  public native static void WinPaintTiledBitmap(int bitmap, Rectangle rect);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinGetSupportedDensity (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: Err	     WinGetSupportedDensity(WordPtr densityP) = sysTrapHighDensityDispatch selector HDSelectorWinGetSupportedDensity;
   */
  public native static int WinGetSupportedDensity(ShortHolder densityP);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorEvtGetPenNative (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     EvtGetPenNative(WinHandle winH, WordPtr pScreenX, WordPtr pScreenY, Boolean* pPenDown) = sysTrapHighDensityDispatch selector HDSelectorEvtGetPenNative;
   */
  public native static void EvtGetPenNative(int winH, ShortHolder pScreenX, ShortHolder pScreenY, BoolHolder pPenDown);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinPaintRoundedRectangleFrame (<B>PalmOS 5.0</B>)
   * (<B>requires High-Density Display Feature Set</B>)
   *
   * <P>Defined as: void     WinPaintRoundedRectangleFrame(const RectanglePtr r, Coord width, Coord cornerRadius, Coord shadowWidth) = sysTrapHighDensityDispatch selector HDSelectorWinPaintRoundedRectangleFrame;
   */
  public native static void WinPaintRoundedRectangleFrame(Rectangle r, int width, int cornerRadius, int shadowWidth);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinSetScalingMode (<B>PalmOS 5.0</B>)
   * (<B>requires 1.5x Display Feature Set</B>)
   *
   * <P>Defined as: UInt32   WinSetScalingMode(UInt32 mode) = sysTrapHighDensityDispatch selector HDSelectorWinSetScalingMode;
   */
  public native static int WinSetScalingMode(int mode);

  /** PalmOS SysTrap: sysTrapHighDensityDispatch/HDSelectorWinGetScalingMode (<B>PalmOS 5.0</B>)
   * (<B>requires 1.5x Display Feature Set</B>)
   *
   * <P>Defined as: UInt32   WinGetScalingMode() = sysTrapHighDensityDispatch selector HDSelectorWinGetScalingMode;
   */
  public native static int WinGetScalingMode();
    /** used for WinGet/SetCoordinate system */
    public final static int kCoordinatesNative = 0;
    /** used for WinGet/SetCoordinate system */
    public final static int kCoordinatesStandard = 72;
    /** used for WinGet/SetCoordinate system */
    public final static int kCoordinatesOneAndAHalf = 108;
    /** used for WinGet/SetCoordinate system */
    public final static int kCoordinatesDouble = 144;
    /** used for WinGet/SetCoordinate system */
    public final static int kCoordinatesTriple = 216;
    /** used for WinGet/SetCoordinate system */
    public final static int kCoordinatesQuadruple = 288;

    /** used for Bitmap V3 */
    public final static int kDensityStandard = 72;
    /** used for Bitmap V3 */
    public final static int kDensityOneAndAHalf = 108;
    /** used for Bitmap V3 */
    public final static int kDensityDouble = 144;
    /** used for Bitmap V3 */
    public final static int kDensityTriple = 216;
    /** used for Bitmap V3 */
    public final static int kDensityQuadruple = 288;

    /** WinScreengetAttribute value */    
	public final static int winScreenWidth = 0;
    /** WinScreengetAttribute value */    
	public final static int winScreenHeight = 1;
    /** WinScreengetAttribute value */    
	public final static int winScreenRowBytes = 2;
    /** WinScreengetAttribute value */    
	public final static int winScreenDepth = 3;
    /** WinScreengetAttribute value */    
	public final static int winScreenAllDepths = 4;
    /** WinScreengetAttribute value */    
	public final static int winScreenDensity = 5;
    /** WinScreengetAttribute value */    
	public final static int winScreenPixelFormat = 6;
    /** WinScreengetAttribute value */    
	public final static int winScreenResolutionX = 7;
    /** WinScreengetAttribute value */    
	public final static int winScreenResolutionY = 8;

  /** PalmOS SysTrap: sysTrapHsSelector/hsSelExtKeyboardEnable
   * (<B>requires Handspring extensions</B>)
   *
   * <P>Defined as: Err HsExtKeyboardEnable(Boolean enable) = sysTrapHsSelector selector16 hsSelExtKeyboardEnable;
   */
  public native static int HsExtKeyboardEnable(boolean enable);
  /** Output string from POSE to the Palm Reporter. */
  public static void ReporterTraceOutput(String txt)
  {
    ReporterTraceOutput(0x8000,txt);    // hostAppClass
  }
  
  /** Output string from POSE to the Palm Reporter. specifying app class */
  public static void ReporterTraceOutput(int appClass, String txt)
  {
    ReporterTraceOutput(appClass, "%s", txt);
  }

  /** PalmOS SysTrap: sysTrapHostControl/hostSelectorTraceInit
   *
   * <P>Defined as: void ReporterTraceInit() = sysTrapHostControl selector16 hostSelectorTraceInit;
   */
  public native static void ReporterTraceInit();

  /** PalmOS SysTrap: sysTrapHostControl/hostSelectorTraceClose
   *
   * <P>Defined as: void ReporterTraceClose() = sysTrapHostControl selector16 hostSelectorTraceClose;
   */
  public native static void ReporterTraceClose();

  /** PalmOS SysTrap: sysTrapHostControl/hostSelectorTraceOutputTL
   *
   * <P>Defined as: void ReporterTraceOutput(int appClass, CharPtr fmt, CharPtr txt) = sysTrapHostControl selector16 hostSelectorTraceOutputTL;
   */
  public native static void ReporterTraceOutput(int appClass, String fmt, String txt);
    /** Convert a memory address range to a byte array */
    public static byte[] Memory(int address, int length)
    {
        byte[] bytes = new byte[length];
        for (int i=0; i<length; i++)
            bytes[i] = (byte)Palm.nativeGetByte(address+i);
        return bytes;
    }
}
