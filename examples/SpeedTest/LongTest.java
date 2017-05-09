import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Math;
// import java.math.BigInteger;

public class LongTest extends Test
{
  public LongTest()
  {
  }
   
  void longArithmetic()
  {
    int i;
    long a=135, b=271, c=0, c1=0, c2=0;
    int q = -63;

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
    for (i=0; i<20000; i++)
      c = b / a;
    stop(20000);
    success( c == 2 );

    // arithmetic test
    start("Shift");
    for (i=0; i<33333; i++)
      c = a << 20;
    // arithmetic test
    for (i=0; i<33333; i++)
      c1 = a >> 20;
    // arithmetic test
    for (i=0; i<33334; i++)
      c2 = -1 >>> 20;
    stop(100000);
    long minusone = -1L;
    success(
      c == 141557760 &&
      c1 == 0 && (a >> q) == 67 &&
      c2 == 4095L && (135L >>> q) == 67L && (minusone >>> -1) == 1L
      );

    // BigInteger
    /*****
    start("BigInteger");
    BigInteger bi1 = new BigInteger("123456789123456789123456789123456789");
    BigInteger bi2 = new BigInteger("123456789");
    BigInteger bi3 = bi1.divide(bi2);
    stop(1);
    success( bi3.toString().equals("100000000100000001000000001") );
    *****/
  }
   
  void longConversions()
  {
    int i;
    long l = 0;
    float f = 123.5f;
    double d = 765.5f;
    
    start("int to long");
    for (i=0; i<100000; i++)
      l = i;
    stop(100000);
    success( l == 99999L );

    start("float to long");
    for (i=0; i<20000; i++)
      l = (long)f;
    stop(20000);
    success( l == 123L );

    start("double to long");
    for (i=0; i<40000; i++)
      l = (long)d;
    stop(40000);
    success( l == 765L );
  }
   
  public void run()
  {
    init();
    title(" - long");
    longArithmetic();
    longConversions();
    total();
    Sound.beep();
  }
}
