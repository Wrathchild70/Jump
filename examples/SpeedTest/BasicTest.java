import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
import portable.*;
// import waba.util.Math;

class Shape
{
  Shape left, right;
  Shape(Shape left, Shape right)
  {
    this.left = left;
    this.right = right;
  }
  
  Shape()
  {
  }

  public int total()
  {
    int n = size();
    if ( left != null )
      n += left.total();
    if ( right != null )
      n += right.total();
    return n;
  }
  
  int size() { return 1; };
}

class Polygon extends Shape
{
  Polygon(Shape left, Shape right)
  {
    this.left = left;
    this.right = right;
  }
  
  Polygon()
  {
  }

  int size() { return 2; };
}

class Circle extends Shape
{
  Circle(Shape left, Shape right)
  {
    this.left = left;
    this.right = right;
  }
  
  Circle()
  {
  }

  int size() { return 314; };
}

class Triangle extends Polygon
{
  Triangle(Shape left, Shape right)
  {
    this.left = left;
    this.right = right;
  }
  
  Triangle()
  {
  }

  int size() { return 3; };
}

class Square extends Polygon
{
  Square(Shape left, Shape right)
  {
    this.left = left;
    this.right = right;
  }
  
  Square()
  {
  }

  int size() { return 4; };
}

class Pentagon extends Polygon
{
  Pentagon(Shape left, Shape right)
  {
    this.left = left;
    this.right = right;
  }
  
  Pentagon()
  {
  }

  int size() { return 5; };
}

class SampleData
{
  public static class JointData 
  {
    /** The data point for the first collar */
    public int firstCollar;
    /** The data point for the second collar */
    public int secondCollar;
    /** The distance of the joint (real distance between the collars) */
    public float distance;
    /** The velocity we have calculated based on this information */
    public float velocity;
  }

  final static int MAX_JOINTDATA = 5;
  int numberJointData;
  JointData[] jointData;
}

class App
{
  SampleData sampleData = new SampleData();
}

class MyInt 
{
  int value;

  MyInt(int value)
  {
    this.value = value;
  }

  int getValue()
  {
    return value;
  }
}

public class BasicTest extends Test
{
  private static final int MAX_TEST_NUMBER = 3;
  static int testNumber = 1;

  App app =  new App();

  public BasicTest()
  {
  }

  static boolean staticBooleanValue = false;
  static boolean getStaticBooleanValue()
  {
    return staticBooleanValue;
  }

  static int staticIntValue = 1933;
  static int getStaticIntValue()
  {
    return staticIntValue;
  }
   
  boolean instanceBooleanValue = true;
  boolean getBooleanValue()
  {
    return instanceBooleanValue;
  }

  int instanceIntValue = 7531;
  int getIntValue()
  {
    return instanceIntValue;
  }

  void emptyLoop()
  {
    int i;
    // loop test
    start("Empty loop");
    for (i=0; i<100000; i++)
      ;      
    stop();
    success( i == 100000 );
    if ((app.sampleData.jointData == null) ||
      (app.sampleData.jointData.length != SampleData.MAX_JOINTDATA)) 
    {  // initialize the array if none
      app.sampleData.jointData = new SampleData.JointData[SampleData.MAX_JOINTDATA];
      app.sampleData.numberJointData = 0;
    }
    app.sampleData.jointData[app.sampleData.numberJointData] = new SampleData.JointData();
  }
   
  void simpleArithmetic()
  {
    int i, v=0, y=0;
    // arithmetic test
    start("Simple arithmetic");
    for (i=0; i<100000; i++)
    {
      y = 1000 - (i & 0x3FF);
      v += (i>>10) + y*5;
    }
    stop();
    success( v == 249674288 && y == 329 );
  }
   
  void floatArithmetic()
  {
    int i;
    float f1=0.0f, f2=1.0f;
    // Float test
    start("Float arithmetic");
    for (i=0; i<10000; i++)
    {
      f1 = (f1+f2) * 0.5f;
      f2 = 1.0f - f2;
    }
    stop();
    success( f1 > 0.333333f && f1 < 0.333334f );
  }
   
  void doubleArithmetic()
  {
    int i;
    double d1=0.0, d2=0.0;
    // loop test
    start("Double arithmetic");
    for (i=0; i<10000; i++)
    {
      d1 = (d1+d2) * 0.5;
      d2 = 1.0 - d2;
    }
    stop();
    success( d1 > 0.66666666 && d1 < 0.66666667 );
  }
   
  void transendentals()
  {
    int i;
    double d1, d2, err=0.0;
    double s=0.0, c=1.0, temp;
    double s1 = Math.sin(0.1), c1 = Math.cos(0.1);
    // transendental test
    start("Transendentals");
    for (d1=0.0, i=0; i<1000; d1+=0.1, i++)
    {
      err += Math.abs(d1 - Math.sqrt(d1*d1)) +
        Math.abs(s - Math.sin(d1)) +
        Math.abs(c - Math.cos(d1));
      temp = s*c1 + c*s1;
      c = c*c1 - s*s1;
      s = temp;
    }
    stop();
    success( err<1.0e-7 );
  }

  private int hanoi( int size, int from, int to, int via )
  {
    if (size == 1)
      return from+to+via; // always 6 but compiler doesn't know
    int result  = hanoi( size-1, from, via, to );
    result += hanoi( 1, from, to, via );
    result += hanoi( size-1, via, to, from );
    return result;
  }
   
  void recursion()
  {
    final int size = 17;
    // simple recursive call test
    // a better test might be to build and traverse a tree.
    start("Hanoi "+size);
    int result = hanoi(size, 1, 3, 2 );
    stop();
    success( result == ((1<<size)-1)*6 );
  }

  public static int Tak (int x, int y, int z) 
  {
    if (y >= x) return z;
    else return Tak(Tak(x-1, y, z), Tak(y-1, z, x), Tak(z-1, x, y));   
  
  }

  void takInteger()
  {
    final int loops = 5;
    // simple recursive call test
    start("Tak "+loops);
    int result=0;
    for (int i=0; i<loops; i++)
      result = Tak(18,12,6);
    stop();
    success( result == 7 );
  }

  void timer()
  {
    // test speed of getTimeStamp test
    start("Time stamp");
    for (int i=0; i<10000; i++)
    {
      Portable.getTimeStamp();
    }
    stop();
    // no result to test
  }
   
  void virtualCalls()
  {
    // test speed of virtual calls
    int result=0;
    Shape tree =
      new Circle(
      new Triangle(
      new Shape(),
      new Pentagon(null, new Pentagon())
      ),
      new Square(
      new Polygon(null, new Circle()),
      new Triangle(
      new Circle(new Shape(), null),
      new Square(new Polygon(), null)
      )
      )
      );
    start("Virtual calls");
    for (int i=0; i<10000; i++)
    {
      result = tree.total();      
    }
    stop();
    success( result == 972 );
  }
  
  void test1()
  {
    timer();
    emptyLoop();
    simpleArithmetic();
    recursion();
    takInteger();
    virtualCalls();
    floatArithmetic();
    doubleArithmetic();
    transendentals();
  }

  int testValue;
  MyInt miv;
  BasicTest self;
  void test2()
  {
    int i, a = 0;
    boolean b = false;

    start( "int getter method" );
    for ( i=0; i < 100000; i++ )
      a = getIntValue();
    stop( i );

    // Check when there are two objects and the fields are accessed
    // from pointer that are not locals or parameters.
    // This catches a problem that Rod Montrose had with inlined getter
    // but the problem is not limited to that case.
    miv = new MyInt(76543);
    self = this;
    testValue = 345678;
    // self.testValue = miv.value;
    self.testValue = miv.getValue();
    success( a == instanceIntValue && testValue == 76543 );

    start( "boolean getter method" );
    for ( i=0; i < 100000; i++ )
      b = getBooleanValue();
    stop( i );
    success( b == instanceBooleanValue );

    start( "static int getter method" );
    for ( i=0; i < 100000; i++ )
      a = getStaticIntValue();
    stop( i );
    success( a == staticIntValue );

    start( "static boolean getter method" );
    for ( i=0; i < 100000; i++ )
      b = getStaticBooleanValue();
    stop( i );
    success( b == staticBooleanValue );

    start( "testing static boolean" );
    for ( i=0; i < 100000; i++ )
    {
      if ( getStaticBooleanValue() )
        a = 3;
    }
    stop( i );
    success( b == staticBooleanValue && a != 3 );
  }

  void test3()
  {
    int k, j=3;

  {
    byte b = 0;
    byte[] ba = new byte[5];
    ba[3] = 5;

    start( "byte []" );
    for ( k=0; k < 100000; k++ )
      b = ba[j];
    stop( k );
    success( b == 5 );
  }

  {
    short s = 0;
    short[] sa = new short[5];
    sa[3] = 6;

    start( "short []" );
    for ( k=0; k < 100000; k++ )
      s = sa[j];
    stop( k );
    success( s == 6 );
  }

  {
    int i = 0;
    int[] ia = new int[5];
    ia[3] = 8;

    start( "int []" );
    for ( k=0; k < 100000; k++ )
      i = ia[j];
    stop( k );
    success( i == 8 );
  }

  {
    long l = 0;
    long[] la = new long[5];
    la[3] = 12;

    start( "long []" );
    for ( k=0; k < 100000; k++ )
      l = la[j];
    stop( k );
    success( l == 12 );
  }

  {
    float f = 0.0F;
    float[] fa = new float[5];
    fa[3] = 6.1F;

    start( "float []" );
    for ( k=0; k < 100000; k++ )
      f = fa[j];
    stop( k );
    success( f == 6.1F );
  }

  {
    double d = 0.0;
    double[] da = new double[5];
    da[3] = 3.1415926536;

    start( "double []" );
    for ( k=0; k < 100000; k++ )
      d = da[j];
    stop( k );
    success( d == 3.1415926536 );
  }
  }

  public void run()
  {
    init();
    title(" - basic " + testNumber + " of " + MAX_TEST_NUMBER);
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


