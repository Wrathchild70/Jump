import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
import portable.*;
// import waba.util.Math;

public class StringTest extends Test
{
  private static final int MAX_TEST_NUMBER = 3;
  static int testNumber = 1;
   
  String a = "0123456789", b = "abcdefgh0123456789ijklmnopqrstuvwxyz";

  public StringTest()
  {
  }

  void test1()
  {
    String c=null;
    int i, n = 0;
    boolean flag = false;
    String a = this.a, b = this.b;

    Portable.gc();

    // test
    start("valueOf(int)");
    for (i=0; i<10000; i++)
      c = String.valueOf(12345);
    stop(10000);
    success( c.equals("12345") );

    // test
    start("valueOf(long)");
    for (i=0; i<2000; i++)
      c = String.valueOf(12345L);
    stop(2000);
    success( c.equals("12345") );

    // test
    start("valueOf(float)");
    for (i=0; i<4000; i++)
      c = String.valueOf(123.45f);
    stop(4000);
    success( c.equals("123.45") );

    // test
    start("valueOf(double)");
    for (i=0; i<2000; i++)
      c = String.valueOf(123.45);
    stop(2000);
    success( c.equals("123.45") );

    // test
    start("valueOf(char)");
    for (i=0; i<10000; i++)
      c = String.valueOf('z');
    stop(10000);
    success( c.equals("z") );

    // test
    start("hashCode");
    for (i=0; i<10000; i++)
      n = b.hashCode();
    stop(10000);
    success( n == -499548302 );
  }
   
  void test2()
  {
    String c=null;
    int i, n = 0;
    boolean flag = false;
    String a = this.a, b = this.b;

    Portable.gc();

    // test
    start("Concatenate");
    for (i=0; i<10000; i++)
      c = a + b;
    stop(10000);
    success( c.length() == a.length() + b.length() );

    // test
    start("length");
    for (i=0; i<10000; i++)
      n = b.length();
    stop(10000);
    success( n == 36 );

    // test
      start("charAt");
      for (i=0; i<10000; i++)
        n = c.charAt(12);
      stop(10000);
      success( n == 'c' );

    // test
    start("substring");
    for (i=0; i<10000; i++)
      c = b.substring(8,18);
    stop(10000);
    success( c.equals(a) );

    // test
    start("equals");
    for (i=0; i<5000; i++)
      flag = c.equals(a);
    stop(5000);
    success( flag );

    // test
    c = a + b;
    start("compareTo");
    for (i=0; i<5000; i++)
      n = c.compareTo(a);
    stop(5000);
    success( n > 0 && c.compareTo(c) == 0 && a.compareTo(c) < 0 );

    // test
    c = a + b;
    start("startsWith");
    for (i=0; i<10000; i++)
      flag = c.startsWith(a);
    stop(10000);
    success( flag && !c.startsWith(b) && !a.startsWith(c) && c.startsWith(c) );

    // test
    c = b + a;
    start("endsWith");
    for (i=0; i<10000; i++)
      flag = c.endsWith(a);
    stop(10000);
    success( flag && !c.endsWith(b) && !a.endsWith(c) && c.endsWith(c) );
  }
   
  void test3()
  {
    String c=null;
    int i, n = 0;
    boolean flag = false;
    String a = this.a, b = this.b;

    Portable.gc();

    // test
    start("indexOf(int)");
    for (i=0; i<10000; i++)
      n = b.indexOf('1');
    stop(10000);
    success( n == 9 );

    // test
    start("indexOf(String)");
    for (i=0; i<10000; i++)
      n = b.indexOf(a);
    stop(10000);
    success( n == 8 );

    // test
    c = a + b;
    start("lastIndexOf(int)");
    for (i=0; i<10000; i++)
      n = c.lastIndexOf('0');
    stop(10000);
    success( n == 18 );

    // test
    /* not supported by SuperWaba
      start("lastIndexOf(String)");
      for (i=0; i<10000; i++)
        n = b.lastIndexOf(a);
      stop(10000);
      success( n == 8 );
      */

    // test
    start("toUpperCase");
    for (i=0; i<2000; i++)
      c = b.toUpperCase();
    stop(2000);
    success( c.charAt(4) == 'E' );

    // test
    c.intern(); // for intern of all literals.
    start("intern");
    for (i=0; i<2000; i++)
      c = b.intern();
    stop(2000);
    success( c == b );
  }
   
  public void run()
  {
    init();
    title(" - String " + testNumber + " of " + MAX_TEST_NUMBER);
    switch ( testNumber )
    {
    case 1:
      test1();
      break;
    case 2:
      test2();
      break;
    case 3:
      test3();
      break;
    }
    total();
    Sound.beep();
    testNumber++;
    if ( testNumber > MAX_TEST_NUMBER )
      testNumber = 1;
  }
}
