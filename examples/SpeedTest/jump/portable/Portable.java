package portable;

import waba.fx.*;
import palmos.*;

public class Portable
{
  public static void setBlack(Graphics g, boolean b)
  {
    int n = b ? 0 : 255;
    g.setColor( n, n, n );
  }

  public static int getTimeStamp()
  {
    return (Palm.TimGetTicks() * 10) & 0x3FFFFFFF;
  }

  public static void gc()
  {
    System.gc();
  }

  /** write a line of text to a MemoPad memo called
   * 'Jump log'
   */
  public static void trace(String s)
  {
    palmos.JumpLog.println( s );
  }

  public static void setUIStyle()
  {
  }
}