import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Math;

public class FloatTest extends Test
{
  public FloatTest()
  {
  }
   
  void floatArithmetic()
  {
    int i;
    float a=135.0f, b=271.0f, c=0;

    // arithmetic test
    start("Add");
    for (i=0; i<20000; i++)
      c = a + b;
    stop(20000);
    success( c == 406.0f );

    // arithmetic test
    start("Subtract");
    for (i=0; i<20000; i++)
      c = b - a;
    stop(20000);
    success( c == 136.0f );

    // arithmetic test
    start("Multiply");
    for (i=0; i<20000; i++)
      c = a * b;
    stop(20000);
    success( c == 36585.0f );

    // arithmetic test
    start("Divide");
    for (i=0; i<20000; i++)
      c = b / a;
    stop(20000);
    success( c > 2.00740f && c < 2.00741f );
  }
   
  void floatConversions()
  {
    int i;
    float f = 0.0F;
    double d = 123.5;
    
    start("int to float");
    for (i=0; i<20000; i++)
      f = i;
    stop(20000);
    success( f == 19999.0F );

    start("long to float");
    for (i=0; i<20000; i++)
      f = (long)i;
    stop(20000);
    success( f == 19999.0 );

    start("double to float");
    for (i=0; i<40000; i++)
      f = (float)d;
    stop(40000);
    success( f == 123.5F );
  }
   
  public void run()
  {
    init();
    title(" - float");
    floatArithmetic();
    floatConversions();
    total();
    Sound.beep();
  }
}


