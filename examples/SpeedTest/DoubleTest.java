import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Math;

public class DoubleTest extends Test
{
   public DoubleTest()
   {
   }
   
   void doubleArithmetic()
   {
     int i;
     double a=135.0, b=271.0, c=0;

     // arithmetic test
     start("Add");
     for (i=0; i<20000; i++)
       c = a + b;
     stop(20000);
     success( c == 406.0 );

     // arithmetic test
     start("Subtract");
     for (i=0; i<20000; i++)
       c = a - b;
     stop(20000);
     success( c == -136.0 );

     // arithmetic test
     start("Multiply");
     for (i=0; i<20000; i++)
       c = a * b;
     stop(20000);
     success( c == 36585.0 );

     // arithmetic test
     start("Divide");
     for (i=0; i<20000; i++)
       c = b / a;
     stop(20000);
     success( c > 2.007407406 && c < 2.007407408 );
   }

  void doubleConversions()
  {
    int i;
    double d = 0.0;
    float f = 123.5f;
    
    start("int to double");
    for (i=0; i<20000; i++)
      d = i;
    stop(20000);
    success( d == 19999.0 );

    start("long to double");
    for (i=0; i<20000; i++)
      d = (long)i;
    stop(20000);
    success( d == 19999.0 );

    start("float to double");
    for (i=0; i<40000; i++)
      d = f;
    stop(40000);
    success( d == 123.5 );
  }
   
  public void run()
  {
    init();
    title(" - double");
    doubleArithmetic();
    doubleConversions();
    total();
    Sound.beep();
  }
}


