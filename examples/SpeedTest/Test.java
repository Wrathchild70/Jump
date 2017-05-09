import waba.sys.*;
import waba.fx.*;
import waba.ui.*;
import portable.*;

class TestResult
{
  String name;
  String result;
  int millis = -1;
  boolean ok = false;
  boolean hasSuccess = false;
  TestResult next;

  TestResult( String name)
  {
    this.name = name;
  }
}

public class Test
{
  static String title;
  static TestResult resultList = null;
  static TestResult first = null;
  static int startTime;
  static boolean haveTotal = false;
  static int emptyLoopTime = 0;

  public static void paint(Graphics g)
  {
    int ypos=0, xpos, x2;
    int lineHeight;
    int totalTime=0;
    String s;
    // g.setColor( 255, 255, 255 );
    // g.fillRect(0,0,160,160);
    MainWindow mw = MainWindow.getMainWindow();
    Rect r = mw.getRect();
    Font font = new Font("Helvetica", Font.BOLD, 12);
    FontMetrics fm = new FontMetrics(font, mw );
    lineHeight = fm.getHeight() + fm.getLeading();
    if ( title != null)
    {
      g.setFont(font);
      Portable.setBlack( g, true );
      x2=fm.getTextWidth(title)+6;
      g.fillRect(0,0,x2,lineHeight);
      g.drawLine(0,lineHeight, r.width-1, lineHeight);
      g.drawLine(0,lineHeight+1, r.width-1, lineHeight+1);
      Portable.setBlack( g, false );
      g.drawText( title, 3, ypos );
      g.drawLine(0,0,0,0);
      g.drawLine(x2-1,0,x2-1,0);
      ypos += 2;
    }
    font = new Font("Helvetica", Font.PLAIN, 12);
    g.setFont(font);
    fm = new FontMetrics(font, mw );
    Portable.setBlack( g, true );
    ypos += lineHeight;
    for (TestResult t = first; t != null; t = t.next)
    {
      int millis = t.millis;
      g.drawText( t.name, 9, ypos );
      xpos = fm.getTextWidth(t.name) + 9;
      if (millis >= 0)
      {
        s = t.result;
        totalTime += millis;
        x2 = r.width-4-fm.getTextWidth(s);
        g.drawText( s, x2+3, ypos );
        int y = ypos + fm.getAscent();
        for (int x = (xpos+10) & 0xFF8; x<x2; x+=8)
          g.drawLine(x,y,x,y);
        if ( t.hasSuccess )
          drawSuccess( g, t.ok, ypos+2 );
      }
      ypos += lineHeight;
    }
    if (haveTotal)
    {
      ypos += 2;
      g.drawLine( 9, ypos, r.width-3, ypos);
      ypos++;
      g.drawText( "Run time", 9, ypos );
      s = totalTime+" ms";
      x2 = r.width-1-fm.getTextWidth(s);
      g.drawText( s, x2, ypos );
      ypos += lineHeight+1;
      g.drawLine( 9, ypos, r.width-3, ypos);
      ypos += 2;
    }
    /*
        int a = 65, b = -31;
        g.drawText( a + " << " + b + " = " + (a << b), 9, 107 );
        g.drawText( a + " >>> " + b + " = " + (a >>> b), 9, 121 );
        g.drawText( a + " >> " + b + " = " + (a >> b), 9, 135 );
        */
  }
    
  public void run()
  {
    int i,a;

    init();
    title("");
    // loop test
    start("Empty loop");
    for (a=0, i=0; i<100000; i++)
      a=i;      
    emptyLoopTime = stop(100000)/100; // *1000L/100000
    success( a == 99999 );
  }

  public static void title( String t )
  {
    title = "SpeedTest" + t;
    Portable.trace( " " );
    Portable.trace( title );
  }

  public static void redraw()
  {
    Graphics g = MainWindow.getMainWindow().createGraphics();
    paint( g );
    g.free();
  }

  public static void init()
  {
    first = null;
    resultList = null;
    haveTotal = false;
    MainWindow mw = MainWindow.getMainWindow();
    Rect r = mw.getRect();
    Graphics g = mw.createGraphics();
    Portable.setBlack( g, false );
    g.fillRect(0,0,r.width,r.height*130/160);
    g.free();
  }

  public static void total()
  {
    haveTotal = true;
    redraw();
  }

  static void start( String name )
  {
    TestResult t = new TestResult(name);
    if (first == null)
    {
      first = t;
      resultList = t;
    }
    else
    {
      resultList.next = t;
      resultList = resultList.next;
    }
    redraw();
    int ts = Portable.getTimeStamp();
    do
    {
      startTime = Portable.getTimeStamp();
    } while ( startTime == ts );
  }

  static int stop()
  {
    int timestamp = Portable.getTimeStamp();
    return stop( 1000, timestamp, 0, " ms" );
  }

  static int stop( int cycles )
  {
    int timestamp = Portable.getTimeStamp();
    return stop( cycles, timestamp, emptyLoopTime, " \u00B5s" );
  }

  static private int stop( int cycles, int timestamp, int empty, String units )
  {
    resultList.millis = (timestamp - startTime) & 0x3FFFFFFF; // wrap rule for timestamps.
    return stop( (resultList.millis*1000L/cycles-empty) + units );
  }

  static private int stop( String result )
  {
    resultList.result = result;
    redraw();
    // report using fixed pitch chars
    String msg = resultList.name + "  " + (". . . . . . . . . . . . . . . . . . . ".substring(resultList.name.length()));
    // Portable.trace( msg.substring(0, msg.length()-resultList.result.length()) + "  " + resultList.result );
    Portable.trace( resultList.name + "\t" + resultList.result );
    return resultList.millis;
  }

  static void notAvailable()
  {
    resultList.millis = 0;
    stop( "N/A" );
    success(false);
  }

  static void progress(String s)
  {
    resultList.millis = 0;
    resultList.result = s;
    redraw();
  }

  static void success(boolean ok)
  {
    resultList.ok = ok;
    resultList.hasSuccess = true;
    redraw();
    if ( !ok )
      Portable.trace( "*** FAIL ***" );
  }

  static void drawSuccess(Graphics g, boolean ok, int y)
  {
    if (ok)
    {
      y += 3;
      // draw a tick
      for (int x = 0; x < 7; x++)
      {
        g.drawLine(x, y, x, y + 2);
        if (x < 2)
          y++;
        else
          y--;
      }
    }
    else
    {
      // draw a cross
      g.drawLine(0,y,6,y+6);
      g.drawLine(0,y+1,6,y+7);
      g.drawLine(6,y,0,y+6);
      g.drawLine(6,y+1,0,y+7);
    }
  }
}
