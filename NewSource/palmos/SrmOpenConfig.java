package palmos;

public final class SrmOpenConfig {
  int   baud;
  int   function;
  /** A pointer to a data block managed using native memory allocation.
   * Allocate the block with MemPtrNew(int) and free with MemPtrFree(int).
   */
  int   drvrDataP;   // contains a data pointer
  /** The size of the data block pointed to by drvrDataP */
  short drvrDataSize;
  int   sysReserved1;
  int   sysReserved2;
}
