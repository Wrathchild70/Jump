import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Math;

public class IntTest extends Test
{
  public IntTest()
  {
  }
   
  void intArithmetic()
  {
    int i, a=135, b=271, c=0, c1=0, c2=0;
    int minusthirtyone = -31, ten = 10, thirtythree = 33;
    int m9999 = -9999;

    // arithmetic test
    start("Add");
    for (i=0; i<100000; i++)
      c = a + b;
    stop(100000);
    success( c == 406 );

    // arithmetic test
    start("Subtract");
    for (i=0; i<100000; i++)
      c = a - b;
    stop(100000);
    success( c == -136 );

    // arithmetic test
    start("Multiply");
    for (i=0; i<100000; i++)
      c = a * b;
    stop(100000);
    success( c == 36585 );

    // arithmetic test
    start("Divide");
    for (i=0; i<100000; i++)
      c = b / a;
    stop(100000);
    success( c == 2  &&
      (minusthirtyone / 4) == (-31 / 4) && 
      (minusthirtyone % 4) == (-31 % 4) &&
      (minusthirtyone / 1024) == (-31 / 1024) &&
      (m9999 % 2048) == (-9999 % 2048) );

    // arithmetic test
    b = 20;
    start("Shift");
    for (i=0; i<33333; i++)
      c = a << b;
    // arithmetic test
    for (i=0; i<33333; i++)
      c1 = a >> b;
    // arithmetic test
    for (i=0; i<33334; i++)
      c2 = -1 >>> b;
    stop(100000);
    int minusone = -1;
    success(
      c == 141557760 &&
      c1 == 0 && (a >> minusthirtyone) == 67 &&
      c2 == 4095 && (135 >>> minusthirtyone) == 67 && (minusone >>> minusone) == 1 &&
      (ten >>> thirtythree) == 5 &&
      (minusthirtyone >> thirtythree) == -16 &&
      (ten << thirtythree) == 20
      );
    /* test
     int minusone = -1, onethreefive = 135, minustwo = -2;
     Vm.debug( " = " + (minusone >>> 20)  );
     Vm.debug( " = " + (onethreefive >>> -31) );
     Vm.debug( " = " + (minustwo >>> -1) );
     */
  }
   
  void intConversions()
  {
    int i, j=0;
    long l = 1937L;
    float f = 123.5f;
    double d = 765.5f;
    byte b=0;
    
    start("long to int");
    for (i=0; i<100000; i++)
      j = (int)l;
    stop(100000);
    success( j == 1937 );

    start("float to int");
    for (i=0; i<20000; i++)
      j = (int)f;
    stop(20000);
    success( j == 123 );

    start("double to int");
    for (i=0; i<40000; i++)
      j = (int)d;
    stop(40000);
    success( j == 765 );

    start("int to byte");
    for (i=0; i<100000; i++)
      b = (byte)j;
    stop(100000);
    success( b == -3 );

  }
   
  public void run()
  {
    init();
    title(" - integer");
    intArithmetic();
    intConversions();
    total();
    Sound.beep();
  }
}
