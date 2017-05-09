
package palmos;

/*
 * This provides methods for writing records to the Jump log memo for logging.
 */

public class JumpLog
{
  /** report text in Jump log */
  public static final boolean USE_JUMPLOG = true;

  private final static int Jump = ('J'<<24)|('u'<<16)|('m'<<8)|'p';
  private final static int _log = (' '<<24)|('l'<<16)|('o'<<8)|'g';
  private final static int DATA = ('D'<<24)|('A'<<16)|('T'<<8)|'A';
  private final static int memo = ('m'<<24)|('e'<<16)|('m'<<8)|'o';

  /** cached record number of jump log */
  private static int recNum;

  /** global handle use for memo by Vm.debug() and Catalog */
  public static int memoHandle;

  /** flag to indicate that this is the first write to jump log.
   * Clearing this flag means that the next write to the log remove
   * any previous contents. The default bahavior is to clear the log
   * the first time text is added.
   */
  public static boolean appendNext;

  /** flag used to init the report interface. */
  static private boolean traceInitialized;

  /** write a string to record if record has right name. */
  static private boolean writeRecord( int dbHandle, int rec, String s )
  {
    int length = s.length();
    int recHandle = Palm.DmQueryRecord(dbHandle,rec);
    if ( recHandle != 0 )
    {
      int recPtr = Palm.MemHandleLock(recHandle);
      if ( Palm.nativeGetInt(recPtr) == Jump
        && Palm.nativeGetInt(recPtr+4) == _log
        && Palm.nativeGetByte(recPtr+8) == 10 )
      {
        int recPos =  Palm.MemHandleSize(recHandle)-1;
        // found memo 'Jump log'
        if ( !appendNext || recPos + length >= 8000 )
          recPos = 9; // truncate to top line
        int recSize = recPos + length + 2;
        Palm.MemHandleUnlock(recHandle);
        int ok = Palm.DmResizeRecord(dbHandle,rec,recSize);
        recHandle = Palm.DmGetRecord(dbHandle,rec);
        recPtr = Palm.MemHandleLock(recHandle);
        Palm.DmWrite(recPtr,recPos,s,length);
        Palm.DmWrite(recPtr,recPos+length,"\n",2);
        Palm.MemHandleUnlock(recHandle);
        Palm.DmReleaseRecord(dbHandle,rec,true);
        recPos = recSize - 1;
        recNum = rec;
        appendNext = true;
        return true;
      }
      else
        Palm.MemHandleUnlock(recHandle);
    }
    return false;
  }

  /** output message to Palm Reporter if enabled by -DREPORTER */
  public native static void reporter(String s);

  /** write a line of text to a MemoPad memo called
   * 'Jump log'
   */
  public static void println(String s)
  {
    if (USE_JUMPLOG)
    {
      int dbHandle = memoHandle;

      if ( memoHandle == 0 )
        dbHandle = Palm.DmOpenDatabaseByTypeCreator(DATA,memo,3);
      if ( dbHandle != 0 )
      {
        if ( !writeRecord( dbHandle, recNum, s ) )
        {
          int rec, numRecords = Palm.DmNumRecords(dbHandle);
          for (rec=numRecords; --rec >= 0 && !writeRecord( dbHandle, rec, s ); )
            ;
          if ( rec < 0 )
          {
            // didn't find the record so lets create one
            ShortHolder recHolder = new ShortHolder();
            int recHandle = Palm.DmNewRecord( dbHandle, recHolder, 10 );
            if ( recHandle != 0 )
            {
              // title is "Jump log"
              int recPtr = Palm.MemHandleLock(recHandle);
              Palm.DmWrite( recPtr, 0, "Jump log\n", 10 );
              Palm.MemHandleUnlock(recHandle);
              rec = recHolder.value;
              Palm.DmReleaseRecord( dbHandle, rec, true );
              writeRecord( dbHandle, rec, s );
            }
          }
        }
        // leave catalog open if was memo db
        if ( memoHandle == 0 )
          Palm.DmCloseDatabase(dbHandle);
      }
    }
    reporter(s);
  }
}