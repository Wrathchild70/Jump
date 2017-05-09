import waba.ui.*;
import waba.fx.*;
import waba.sys.*;

public class SpeedTest extends MainWindow
{
  Button intButton, longButton, floatButton, doubleButton, transButton, basicButton,
         benchButton, wabamarkButton, compressButton, exceptButton, objButton, stringButton;
  Button allButton;

  /** Position for next button */
  int xpos;
  int ypos;

  public SpeedTest()
  {
    portable.Portable.setUIStyle();
    ypos = height;
    xpos = width;
  }

  public void onStart()
  {
    allButton      = addButton("ALL");
    intButton      = addButton("int");
    longButton     = addButton("long");
    floatButton    = addButton("flt");
    doubleButton   = addButton("dbl");
    transButton    = addButton("trans");
    basicButton    = addButton("basic");
    compressButton = addButton("comp");
    benchButton    = addButton("bench");
    wabamarkButton = addButton("wm");
    exceptButton   = addButton("exc");
    objButton      = addButton("gc");
    stringButton   = addButton("String");
    new Test().run();
  }

  /** add a button horizintally. */
  Button addButton(String caption)
  {
    Button b = new Button(caption);
    FontMetrics fm = b.getFontMetrics( new Font("SW", Font.PLAIN, 12) );
    int w = fm.getTextWidth(caption)+width*6/160;
    // if button won't fit start on line above
    if ( xpos+w >= width )
    {
      xpos = 0;
      ypos -= height*15/160;
    }
    b.setRect(xpos, ypos, w, height*14/160);
    xpos += w + width/160;
    add(b);
    return b;
  }

  public void onPaint(Graphics g)
  {
    Test.paint(g);
    // int a = -7;
    // g.drawText( "(-7) % 4 = " + ((-7) % 4) + " = " + (a % 4), 0, 50 );
    // g.drawText( "(-7) % 1 = " + ((-7) % 1) + " = " + (a % 1), 0, 65 );
  }

  boolean doButton( Object target )
  {
    if ( target == intButton )
      new IntTest().run();
    else if ( target == longButton )
      new LongTest().run();
    else if ( target == floatButton )
      new FloatTest().run();
    else if ( target == doubleButton )
      new DoubleTest().run();
    else if ( target == transButton )
      new TransTest().run();
    else if ( target == basicButton )
      new BasicTest().run();
    else if ( target == compressButton )
      new CompressTest().run();
    else if ( target == benchButton )
      new BenchTest().run();
    else if ( target == wabamarkButton )
      new WabaMarkTest().run();
    else if ( target == exceptButton )
      new ExceptionTest().run();
    else if ( target == objButton )
      new ObjectTest().run();
    else if ( target == stringButton )
      new StringTest().run();
    else if ( target == allButton )
    {
      new IntTest().run();
      new LongTest().run();
      new FloatTest().run();
      new DoubleTest().run();
      new TransTest().run();
      new BasicTest().run();
      new BasicTest().run();
      new BasicTest().run();
      new CompressTest().run();
      new WabaMarkTest().run();
      new ExceptionTest().run();
      new ObjectTest().run();
      new StringTest().run();
      new StringTest().run();
      new StringTest().run();
    }
    else
      return false;
    return true;
  }
  
  public void onEvent( Event e )
  {
    if (e.type == ControlEvent.PRESSED )
    {
      doButton( e.target );
    }
  }

  public void onExit()
  {
    portable.Portable.trace( "Finished" );
  }
}

