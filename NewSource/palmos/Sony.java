package palmos;

/** Created by MkApi for Jump 2.2.2 */
public class Sony {
  /** value of creator for FtrGet */
  public static final int sonySysFtrCreator = ((int)'S'<<24)|((int)'o'<<16)|((int)'N'<<8)|(int)'y';
  public static final int sonySysFtrNumSysInfoP = 1;
  public static final int sonySysFtrSysInfoLibrHR = 1;

  /** PalmOS SysTrap: sysLibTrapOpen (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err	HROpen(UInt16 refNum) = sysLibTrapOpen;
   */
  public native static int HROpen(int refNum);

  /** PalmOS SysTrap: sysLibTrapClose (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err	HRClose(UInt16 refNum) = sysLibTrapClose;
   */
  public native static int HRClose(int refNum);

  /** PalmOS SysTrap: sysLibTrapSleep (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err	HRSleep(UInt16 refNum) = sysLibTrapSleep;
   */
  public native static int HRSleep(int refNum);

  /** PalmOS SysTrap: sysLibTrapWake (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err	HRWake(UInt16 refNum) = sysLibTrapWake;
   */
  public native static int HRWake(int refNum);

  /** PalmOS SysTrap: HRTrapGetAPIVersion (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err	HRGetAPIVersion(UInt16 refNum, UIntPtr version) = HRTrapGetAPIVersion;
   */
  public native static int HRGetAPIVersion(int refNum, ShortHolder version);

  /** PalmOS SysTrap: HRTrapWinClipRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinClipRectangle(UInt16 refNum, RectanglePtr r) = HRTrapWinClipRectangle;
   */
  public native static void HRWinClipRectangle(int refNum, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinCopyRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinCopyRectangle(UInt16 refNum, WinHandle srcWin, WinHandle dstWin, RectanglePtr srcRect, Coord destX, Coord destY,  ScrOperation mode) = HRTrapWinCopyRectangle;
   */
  public native static void HRWinCopyRectangle(int refNum, int srcWin, int dstWin, Rectangle srcRect, int destX, int destY, int mode);

  /** PalmOS SysTrap: HRTrapWinCreateBitmapWindow (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: WinHandle HRWinCreateBitmapWindow(UInt16 refNum, BitmapPtr bitmap, UIntPtr error) = HRTrapWinCreateBitmapWindow;
   */
  public native static int HRWinCreateBitmapWindow(int refNum, int bitmap, ShortHolder error);

  /** PalmOS SysTrap: HRTrapWinCreateOffscreenWindow (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: WinHandle HRWinCreateOffscreenWindow(UInt16 refNum, Coord width, Coord height, WindowFormatType format, UIntPtr error) = HRTrapWinCreateOffscreenWindow;
   */
  public native static int HRWinCreateOffscreenWindow(int refNum, int width, int height, int format, ShortHolder error);

  /** PalmOS SysTrap: HRTrapWinCreateWindow (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: WinHandle HRWinCreateWindow(UInt16 refNum, RectanglePtr bounds, FrameType frame, Boolean modal, Boolean focusable, UIntPtr error) = HRTrapWinCreateWindow;
   */
  public native static int HRWinCreateWindow(int refNum, Rectangle bounds, int frame, boolean modal, boolean focusable, ShortHolder error);

  /** PalmOS SysTrap: HRTrapWinDisplayToWindowPt (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDisplayToWindowPt(UInt16 refNum, CoordPtr extentX, CoordPtr extentY) = HRTrapWinDisplayToWindowPt;
   */
  public native static void HRWinDisplayToWindowPt(int refNum, ShortHolder extentX, ShortHolder extentY);

  /** PalmOS SysTrap: HRTrapWinDrawBitmap (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawBitmap(UInt16 refNum, BitmapPtr bitmap, Coord x, Coord y) = HRTrapWinDrawBitmap;
   */
  public native static void HRWinDrawBitmap(int refNum, int bitmap, int x, int y);

  /** PalmOS SysTrap: HRTrapWinDrawChar (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawChar(UInt16 refNum, UInt16 ch, Coord x, Coord y) = HRTrapWinDrawChar;
   */
  public native static void HRWinDrawChar(int refNum, int ch, int x, int y);

  /** PalmOS SysTrap: HRTrapWinDrawChars (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawChars(UInt16 refNum, const CharPtr chars, Int16 len, Coord x, Coord y) = HRTrapWinDrawChars;
   */
  public native static void HRWinDrawChars(int refNum, String chars, int len, int x, int y);

  /** PalmOS SysTrap: HRTrapWinDrawGrayLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawGrayLine(UInt16 refNum, Coord x1, Coord y1, Coord x2, Coord y2) = HRTrapWinDrawGrayLine;
   */
  public native static void HRWinDrawGrayLine(int refNum, int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: HRTrapWinDrawGrayRectangleFrame (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawGrayRectangleFrame(UInt16 refNum, FrameType frame, RectanglePtr r) = HRTrapWinDrawGrayRectangleFrame;
   */
  public native static void HRWinDrawGrayRectangleFrame(int refNum, int frame, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinDrawInvertedChars (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawInvertedChars(UInt16 refNum, const CharPtr chars, Int16 len, Coord x, Coord y) = HRTrapWinDrawInvertedChars;
   */
  public native static void HRWinDrawInvertedChars(int refNum, String chars, int len, int x, int y);

  /** PalmOS SysTrap: HRTrapWinDrawLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawLine(UInt16 refNum, Coord x1, Coord y1, Coord x2, Coord y2) = HRTrapWinDrawLine;
   */
  public native static void HRWinDrawLine(int refNum, int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: HRTrapWinDrawPixel (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawPixel(UInt16 refNum, Coord x, Coord y) = HRTrapWinDrawPixel;
   */
  public native static void HRWinDrawPixel(int refNum, int x, int y);

  /** PalmOS SysTrap: HRTrapWinDrawRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawRectangle(UInt16 refNum, RectanglePtr r, UInt16 cornerDiam) = HRTrapWinDrawRectangle;
   */
  public native static void HRWinDrawRectangle(int refNum, Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: HRTrapWinDrawRectangleFrame (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawRectangleFrame(UInt16 refNum, FrameType frame, RectanglePtr r) = HRTrapWinDrawRectangleFrame;
   */
  public native static void HRWinDrawRectangleFrame(int refNum, int frame, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinDrawTruncChars (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinDrawTruncChars(UInt16 refNum, const CharPtr chars, Int16 len, Coord x, Coord y, Coord maxWidth) = HRTrapWinDrawTruncChars;
   */
  public native static void HRWinDrawTruncChars(int refNum, String chars, int len, int x, int y, int maxWidth);

  /** PalmOS SysTrap: HRTrapWinEraseChars (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinEraseChars(UInt16 refNum, const CharPtr chars, Int16 len, Coord x, Coord y) = HRTrapWinEraseChars;
   */
  public native static void HRWinEraseChars(int refNum, String chars, int len, int x, int y);

  /** PalmOS SysTrap: HRTrapWinEraseLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinEraseLine(UInt16 refNum, Coord x1, Coord y1, Coord x2, Coord y2) = HRTrapWinEraseLine;
   */
  public native static void HRWinEraseLine(int refNum, int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: HRTrapWinErasePixel (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinErasePixel(UInt16 refNum, Coord x, Coord y) = HRTrapWinErasePixel;
   */
  public native static void HRWinErasePixel(int refNum, int x, int y);

  /** PalmOS SysTrap: HRTrapWinEraseRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinEraseRectangle(UInt16 refNum, RectanglePtr r, UInt16 cornerDiam) = HRTrapWinEraseRectangle;
   */
  public native static void HRWinEraseRectangle(int refNum, Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: HRTrapWinEraseRectangleFrame (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinEraseRectangleFrame(UInt16 refNum, FrameType frame, RectanglePtr r) = HRTrapWinEraseRectangleFrame;
   */
  public native static void HRWinEraseRectangleFrame(int refNum, int frame, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinFillLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinFillLine(UInt16 refNum, Coord x1, Coord y1, Coord x2, Coord y2) = HRTrapWinFillLine;
   */
  public native static void HRWinFillLine(int refNum, int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: HRTrapWinFillRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinFillRectangle(UInt16 refNum, RectanglePtr r, UInt16 cornerDiam) = HRTrapWinFillRectangle;
   */
  public native static void HRWinFillRectangle(int refNum, Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: HRTrapWinGetClip (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinGetClip(UInt16 refNum, RectanglePtr r) = HRTrapWinGetClip;
   */
  public native static void HRWinGetClip(int refNum, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinGetDisplayExtent (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinGetDisplayExtent(UInt16 refNum, CoordPtr extentX, CoordPtr extentY) = HRTrapWinGetDisplayExtent;
   */
  public native static void HRWinGetDisplayExtent(int refNum, ShortHolder extentX, ShortHolder extentY);

  /** PalmOS SysTrap: HRTrapWinGetFramesRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinGetFramesRectangle(UInt16 refNum, FrameType frame, RectanglePtr r, RectanglePtr obscuredRect) = HRTrapWinGetFramesRectangle;
   */
  public native static void HRWinGetFramesRectangle(int refNum, int frame, Rectangle r, Rectangle obscuredRect);

  /** PalmOS SysTrap: HRTrapWinGetPixel (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Byte HRWinGetPixel(UInt16 refNum, Coord x, Coord y) = HRTrapWinGetPixel;
   */
  public native static byte HRWinGetPixel(int refNum, int x, int y);

  /** PalmOS SysTrap: HRTrapWinGetWindowBounds (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinGetWindowBounds(UInt16 refNum, RectanglePtr r) = HRTrapWinGetWindowBounds;
   */
  public native static void HRWinGetWindowBounds(int refNum, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinGetWindowExtent (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinGetWindowExtent(UInt16 refNum, CoordPtr extentX, CoordPtr extentY) = HRTrapWinGetWindowExtent;
   */
  public native static void HRWinGetWindowExtent(int refNum, ShortHolder extentX, ShortHolder extentY);

  /** PalmOS SysTrap: HRTrapWinGetWindowFrameRect (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinGetWindowFrameRect(UInt16 refNum, WinHandle winHandle, RectanglePtr r) = HRTrapWinGetWindowFrameRect;
   */
  public native static void HRWinGetWindowFrameRect(int refNum, int winHandle, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinInvertChars (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinInvertChars(UInt16 refNum, const CharPtr chars, Int16 len, Coord x, Coord y) = HRTrapWinInvertChars;
   */
  public native static void HRWinInvertChars(int refNum, String chars, int len, int x, int y);

  /** PalmOS SysTrap: HRTrapWinInvertLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinInvertLine(UInt16 refNum, Coord x1, Coord y1, Coord x2, Coord y2) = HRTrapWinInvertLine;
   */
  public native static void HRWinInvertLine(int refNum, int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: HRTrapWinInvertPixel (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinInvertPixel(UInt16 refNum, Coord x, Coord y) = HRTrapWinInvertPixel;
   */
  public native static void HRWinInvertPixel(int refNum, int x, int y);

  /** PalmOS SysTrap: HRTrapWinInvertRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinInvertRectangle(UInt16 refNum, RectanglePtr r, UInt16 cornerDiam) = HRTrapWinInvertRectangle;
   */
  public native static void HRWinInvertRectangle(int refNum, Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: HRTrapWinInvertRectangleFrame (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinInvertRectangleFrame(UInt16 refNum, FrameType frame, RectanglePtr r) = HRTrapWinInvertRectangleFrame;
   */
  public native static void HRWinInvertRectangleFrame(int refNum, int frame, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinPaintBitmap (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintBitmap(UInt16 refNum, BitmapPtr bitmap, Coord x, Coord y) = HRTrapWinPaintBitmap;
   */
  public native static void HRWinPaintBitmap(int refNum, int bitmap, int x, int y);

  /** PalmOS SysTrap: HRTrapWinPaintChar (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintChar(UInt16 refNum, UInt16 ch, Coord x, Coord y) = HRTrapWinPaintChar;
   */
  public native static void HRWinPaintChar(int refNum, int ch, int x, int y);

  /** PalmOS SysTrap: HRTrapWinPaintChars (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintChars(UInt16 refNum, const CharPtr chars, Int16 len, Coord x, Coord y) = HRTrapWinPaintChars;
   */
  public native static void HRWinPaintChars(int refNum, String chars, int len, int x, int y);

  /** PalmOS SysTrap: HRTrapWinPaintLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintLine(UInt16 refNum, Coord x1, Coord y1, Coord x2, Coord y2) = HRTrapWinPaintLine;
   */
  public native static void HRWinPaintLine(int refNum, int x1, int y1, int x2, int y2);

  /** PalmOS SysTrap: HRTrapWinPaintLines (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintLines(UInt16 refNum, UInt16 numLines, ShortArray lines) = HRTrapWinPaintLines;
   */
  public native static void HRWinPaintLines(int refNum, int numLines, short [] lines, int _lines_off);

  /** PalmOS SysTrap: HRTrapWinPaintPixel (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintPixel(UInt16 refNum, Coord x, Coord y) = HRTrapWinPaintPixel;
   */
  public native static void HRWinPaintPixel(int refNum, int x, int y);

  /** PalmOS SysTrap: HRTrapWinPaintPixels (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintPixels(UInt16 refNum, UInt16 numPoints, ShortArray pts) = HRTrapWinPaintPixels;
   */
  public native static void HRWinPaintPixels(int refNum, int numPoints, short [] pts, int _pts_off);

  /** PalmOS SysTrap: HRTrapWinPaintRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintRectangle(UInt16 refNum, RectanglePtr r, UInt16 cornerDiam) = HRTrapWinPaintRectangle;
   */
  public native static void HRWinPaintRectangle(int refNum, Rectangle r, int cornerDiam);

  /** PalmOS SysTrap: HRTrapWinPaintRectangleFrame (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinPaintRectangleFrame(UInt16 refNum, FrameType frame, RectanglePtr r) = HRTrapWinPaintRectangleFrame;
   */
  public native static void HRWinPaintRectangleFrame(int refNum, int frame, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinRestoreBits (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinRestoreBits(UInt16 refNum, WinHandle winHandle, Coord destX, Coord destY) = HRTrapWinRestoreBits;
   */
  public native static void HRWinRestoreBits(int refNum, int winHandle, int destX, int destY);

  /** PalmOS SysTrap: HRTrapWinSaveBits (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: WinHandle HRWinSaveBits(UInt16 refNum, RectanglePtr source, UIntPtr error) = HRTrapWinSaveBits;
   */
  public native static int HRWinSaveBits(int refNum, Rectangle source, ShortHolder error);

  /** PalmOS SysTrap: HRTrapWinScreenMode (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err HRWinScreenMode(UInt16 refNum, byte operation, ULongPtr width, ULongPtr height, ULongPtr depth, BooleanPtr enableColor) = HRTrapWinScreenMode;
   */
  public native static int HRWinScreenMode(int refNum, int operation, IntHolder width, IntHolder height, IntHolder depth, BoolHolder enableColor);

  /** PalmOS SysTrap: HRTrapWinScrollRectangle (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinScrollRectangle(UInt16 refNum, RectanglePtr r, DirectionType direction, Coord distance, RectanglePtr vacated) = HRTrapWinScrollRectangle;
   */
  public native static void HRWinScrollRectangle(int refNum, Rectangle r, int direction, int distance, Rectangle vacated);

  /** PalmOS SysTrap: HRTrapWinSetClip (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinSetClip(UInt16 refNum, RectanglePtr r) = HRTrapWinSetClip;
   */
  public native static void HRWinSetClip(int refNum, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinSetWindowBounds (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinSetWindowBounds(UInt16 refNum, WinHandle winHandle, RectanglePtr r) = HRTrapWinSetWindowBounds;
   */
  public native static void HRWinSetWindowBounds(int refNum, int winHandle, Rectangle r);

  /** PalmOS SysTrap: HRTrapWinWindowToDisplayPt (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void HRWinWindowToDisplayPt(UInt16 refNum, CoordPtr extentX, CoordPtr extentY) = HRTrapWinWindowToDisplayPt;
   */
  public native static void HRWinWindowToDisplayPt(int refNum, ShortHolder extentX, ShortHolder extentY);

  /** PalmOS SysTrap: HRTrapWinGetPixelRGB (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err HRWinGetPixelRGB(UInt16 refNum, Coord x, Coord y, ULongPtr rgb) = HRTrapWinGetPixelRGB;
   */
  public native static int HRWinGetPixelRGB(int refNum, int x, int y, IntHolder rgb);

  /** PalmOS SysTrap: HRTrapBmpBitsSize (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: UInt32 HRBmpBitsSize(UInt16 refNum, BitmapPtr bitmap) = HRTrapBmpBitsSize;
   */
  public native static int HRBmpBitsSize(int refNum, int bitmap);

  /** PalmOS SysTrap: HRTrapBmpSize (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: UInt32 HRBmpSize(UInt16 refNum, BitmapPtr bitmap) = HRTrapBmpSize;
   */
  public native static int HRBmpSize(int refNum, int bitmap);

  /** PalmOS SysTrap: HRTrapBmpCreate (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: BitmapPtr HRBmpCreate(UInt16 refNum, Coord width, Coord height, UInt8 depth, ColorTablePtr colortable, UIntPtr error) =  HRTrapBmpCreate;
   */
  public native static int HRBmpCreate(int refNum, int width, int height, int depth, Object colortable, ShortHolder error);

  /** PalmOS SysTrap: HRTrapFntGetFont (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: FontID HRFntGetFont(UInt16 refNum) = HRTrapFntGetFont;
   */
  public native static int HRFntGetFont(int refNum);

  /** PalmOS SysTrap: HRTrapFntSetFont (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: FontID HRFntSetFont(UInt16 refNum, FontID font) = HRTrapFntSetFont;
   */
  public native static int HRFntSetFont(int refNum, int font);

  /** PalmOS SysTrap: HRTrapFontSelect (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: FontID HRFontSelect(UInt16 refNum, FontID font) = HRTrapFontSelect;
   */
  public native static int HRFontSelect(int refNum, int font);

  /** PalmOS SysTrap: HRTrapFntBaseLine (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntBaseLine (UInt16 refNum) = HRTrapFntBaseLine;
   */
  public native static int HRFntBaseLine(int refNum);

  /** PalmOS SysTrap: HRTrapFntCharHeight (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntCharHeight (UInt16 refNum) = HRTrapFntCharHeight;
   */
  public native static int HRFntCharHeight(int refNum);

  /** PalmOS SysTrap: HRTrapFntLineHeight (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntLineHeight (UInt16 refNum) = HRTrapFntLineHeight;
   */
  public native static int HRFntLineHeight(int refNum);

  /** PalmOS SysTrap: HRTrapFntAverageCharWidth (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntAverageCharWidth (UInt16 refNum) = HRTrapFntAverageCharWidth;
   */
  public native static int HRFntAverageCharWidth(int refNum);

  /** PalmOS SysTrap: HRTrapFntCharWidth (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntCharWidth (UInt16 refNum, byte ch) = HRTrapFntCharWidth;
   */
  public native static int HRFntCharWidth(int refNum, int ch);

  /** PalmOS SysTrap: HRTrapFntWCharWidth (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntWCharWidth (UInt16 refNum, UInt16 iChar) = HRTrapFntWCharWidth;
   */
  public native static int HRFntWCharWidth(int refNum, int iChar);

  /** PalmOS SysTrap: HRTrapFntCharsWidth (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntCharsWidth (UInt16 refNum, const CharPtr chars, Int16 len) = HRTrapFntCharsWidth;
   */
  public native static int HRFntCharsWidth(int refNum, String chars, int len);

  /** PalmOS SysTrap: HRTrapFntWidthToOffset (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntWidthToOffset (UInt16 refNum, const CharPtr chars, UInt16 length, Int16 pixelWidth, BooleanPtr leadingEdge, IntPtr truncWidth) = HRTrapFntWidthToOffset;
   */
  public native static int HRFntWidthToOffset(int refNum, String chars, int length, int pixelWidth, BoolHolder leadingEdge, ShortHolder truncWidth);

  /** PalmOS SysTrap: HRTrapFntCharsInWidth (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void   HRFntCharsInWidth (UInt16 refNum, const CharPtr string, IntPtr stringWidth, IntPtr stringLength, BooleanPtr fitWithinWidth) = HRTrapFntCharsInWidth;
   */
  public native static void HRFntCharsInWidth(int refNum, String string, ShortHolder stringWidth, ShortHolder stringLength, BoolHolder fitWithinWidth);

  /** PalmOS SysTrap: HRTrapFntDescenderHeight (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntDescenderHeight (UInt16 refNum) = HRTrapFntDescenderHeight;
   */
  public native static int HRFntDescenderHeight(int refNum);

  /** PalmOS SysTrap: HRTrapFntLineWidth (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Int16  HRFntLineWidth (UInt16 refNum, const CharPtr chars, UInt16 length) = HRTrapFntLineWidth;
   */
  public native static int HRFntLineWidth(int refNum, String chars, int length);

  /** PalmOS SysTrap: HRTrapFntWordWrap (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: UInt16 HRFntWordWrap (UInt16 refNum, const CharPtr chars, UInt16 maxWidth) = HRTrapFntWordWrap;
   */
  public native static int HRFntWordWrap(int refNum, String chars, int maxWidth);

  /** PalmOS SysTrap: HRTrapFntWordWrapReverseNLines (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void   HRFntWordWrapReverseNLines (UInt16 refNum, const CharPtr chars, UInt16 maxWidth, UIntPtr linesToScroll, UIntPtr scrollPos) = HRTrapFntWordWrapReverseNLines;
   */
  public native static void HRFntWordWrapReverseNLines(int refNum, String chars, int maxWidth, ShortHolder linesToScroll, ShortHolder scrollPos);

  /** PalmOS SysTrap: HRTrapFntGetScrollValues (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: void   HRFntGetScrollValues (UInt16 refNum,  const CharPtr chars, UInt16 width, UInt16 scrollPos, UIntPtr lines, UIntPtr topLine) = HRTrapFntGetScrollValues;
   */
  public native static void HRFntGetScrollValues(int refNum, String chars, int width, int scrollPos, ShortHolder lines, ShortHolder topLine);

  /** PalmOS SysTrap: HRTrapSystem (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err HRSystem(UInt16 refNum, UInt16 operation, ULongPtr param1, ULongPtr param2, ULongPtr param3) = HRTrapSystem;
   */
  public native static int HRSystem(int refNum, int operation, IntHolder param1, IntHolder param2, IntHolder param3);

  /** PalmOS SysTrap: HRTrapGetInfo (<B>PalmOS 4.0</B>)
   * (<B>requires Sony Clie Specific</B>)
   *
   * <P>Defined as: Err HRGetInfo(UInt16 refNum, UIntPtr ptr1, UIntPtr ptr2) = HRTrapGetInfo;
   */
  public native static int HRGetInfo(int refNum, ShortHolder ptr1, ShortHolder ptr2);
}
