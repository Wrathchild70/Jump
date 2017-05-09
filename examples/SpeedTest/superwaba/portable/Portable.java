package portable;

import waba.fx.*;
import waba.sys.*;

public class Portable
{
  public static void setBlack(Graphics g, boolean b)
  {
    Color c = b ? Color.BLACK : Color.WHITE;
    g.setForeColor( c );
    g.setBackColor( c );
  }

  public static int getTimeStamp()
  {
    return Vm.getTimeStamp();
  }

  public static void gc()
  {
    Vm.gc();
  }

  public static void trace(String s)
  {
    Vm.debug( s );
  }

  public static void setUIStyle()
  {
    Settings.setPalmOSStyle(true);
  }
}