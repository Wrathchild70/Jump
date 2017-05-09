import waba.ui.*;
import waba.fx.*;
import waba.sys.*;

public class BenchTest extends Test
{
   class TestClass
   {
      public int field1 = 70;
      public int field2 = 80;

      public int method1(int value)
      {
         return (field1 % value) + field2 / 2;
      }

      public int method2(int value)
      {
         return (field2 % value) + field1 / 2;
      }
   }

   ////////// random - by Sean Luke /////////////////
   private static int lastSeed=234123;
   /** bits should be <= 31. used by the random method */
   private static int next(final int bits)
   {
      int IA = 16807;
      int IM = 2147483647;
      int IQ = 127773;
      int IR = 2836;
      int k = lastSeed/IQ;
      lastSeed = IA*(lastSeed-k*IQ)-IR*k;
      if (lastSeed < 0) lastSeed += IM;
      return lastSeed >> (31-bits);
   }
 /** This is a simple Linear Congruential Generator which
   * produces random numbers in the range [0,2^31), derived
   * from ran0 in Numerical Recipies. Note that ran0 isn't
   * wonderfully random -- there are much better generators
   * out there -- but it'll do the job, and it's fast and
   * has low memory consumption.
   * @param seed if > 0, sets the seed, if = 0, uses the last seed. You should call <code>Math.random(Vm.getTimeStamp());</code>
   * @returns a positive 32 bits random int
   */
   // guich@120: corrected so it uses the last rand if seed == 0.
   public static int rrandom(int _seed)
   {
      if (_seed != 0)
      {
         // strip out the minus-sign if any
         lastSeed = (_seed << 1) >>> 1;
      }
      /** public float nextFloat() {return next(24) / ((float)(1 << 24));} Returns a floating-point value in the half-open range [0,1). */
      int val = next(31);
      if (val < 0) val = -val;
      return val;
   }

   public int field1 = 70;
   public int field2 = 80;

   public BenchTest()
   {
   }
   
  public void run()
  {
    init();
    title(" - bench");
     
    // loop test
    start("Loop");
    int value = 100;
    for (int i = 0; i < 100000; i++)
    {
      value = value / 7;
      if (value == 0)
        value = i / 3;
    }
    stop();

    // field test
    TestClass test = new TestClass();
    start("Field");
    value = 100;
    for (int i = 0; i < 10000; i++)
    {
      value += test.field1 + test.field2;
      test.field1 = i;
      test.field2 = i;
      value = value % 100;
    }
    stop();

    // method test
    start("Method");
    value = 100;
    for (int i = 1; i < 10000; i++)
    {
      value = test.method1(i);
      value += test.method2(i);
      value = value % 100;
    }
    stop();

    // array test
    byte array[] = new byte[30];
    start("Array");
    for (int i = 0; i < 10000; i++)
      for (int j = 0; j < 30; j++)
        array[j] = (byte)(array[j] + (j / 2));
    stop();

    // string test
    String strings[] = new String[30];
    for (int i = 0; i < 30; i++)
      strings[i] = "Num" + i;
    start("String");
    for (int i = 0; i < 100; i++)
    {
      String z = "All";
      for (int j = 0; j < 30; j++)
        z += strings[j];
    }
    stop();
    total();
    Sound.beep();
  }
}

