import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
import portable.*;
// import waba.util.Math;

class Linker
{
  Linker next;
  Linker right;

  Linker() { }
  Linker(Linker next) { this.next = next; }
  Linker(Linker next, Linker right) { this.next = next; this.right = right; }

  static Linker tree(int n)
  {
    if (n==0)
      return null;
    if (n==1)
      return new Linker(null);
    return new Linker(tree(n>>1), tree(n-1-(n>>1)));
  }

  int count()
  {
    int count = 1;
    if (next != null)
      count += next.count();
    if (right != null)
      count += right.count();
    return count;
  }
}

class FLinker
{
  FLinker next;
  FLinker right;

  static int counter;

  FLinker(FLinker next) { counter++; this.next = next; }
  FLinker(FLinker next, FLinker right) { counter++; this.next = next; this.right = right; }

  static FLinker tree(int n)
  {
    if (n==0)
      return null;
    if (n==1)
      return new FLinker(null);
    return new FLinker(tree(n>>1), tree(n-1-(n>>1)));
  }

  int count()
  {
    int count = 1;
    if (next != null)
      count += next.count();
    if (right != null)
      count += right.count();
    return count;
  }

  protected void finalize()
  {
    counter--;
  }
}

public class ObjectTest extends Test
{
  public ObjectTest()
  {
  }
   
  void garbage()
  {
    final int loops = 1000;
    final int items = 100000;
    // final int items = 10000;
    int i;

    // time garbage collection
    start("Garbage");
    for (i=0; i<loops; i++)
      Portable.gc();
    stop(loops);

    // create a balanced tree
    start("Allocate tree");
    Linker l = Linker.tree( items );
    stop();
    success( l.count() == items );

    // clean up
    l  = null;
  }

  void linkedList(int loops)
  {
    int i, ticks, ticksmax=0;
    Linker l = null, l1 = null;
    start("Create list "+loops);
    for (i=0; i<loops; i++)
    {
      l = new Linker(l);
    }
    // progress("                              ");
    stop();
    for (l1=l,i=0; l1 != null && i<=loops; i++)
      l1 = l1.next;
    l1 = null;
    success( i == loops );

    // time collect when list is live (lots of live objects in a chain)
    start("GC with list");
    Portable.gc();
    stop();
    for (l1=l,i=0; l1 != null && i<=loops; i++)
      l1 = l1.next;
    l1 = null;
    success( i == loops );

    l = null;
  }

  void forName()
  {
    Class c = null;
    String s = "AnObjectTestString";
    String name = s.substring(2,12); // ObjectTest
    int i = 0;

    start("forName");
    try
    {
      for (; i<1000; i++)
        c = Class.forName(name);
    }
    catch ( ClassNotFoundException e)
    {
    }
    stop(1000);

    // catch the class not found
    boolean excepted = false;
    Class c1 = null;
    try
    {
      c1 = Class.forName(s);
    }
    catch ( ClassNotFoundException e)
    {
      excepted = true;
    }
    // success( i == 1000 && c == getClass() && excepted && c1 == null);
    success( i == 1000 && excepted && c1 == null);

    start("newInstance");
    try
    {
      c = Class.forName("Linker");
      Linker l = null;
      for (i=0; i<10000; i++)
        l = (Linker)c.newInstance();
      stop(i);
      int n = l.count();
      success( n == 1 && l instanceof Linker );
    }
    catch ( Exception e)
    {
      stop(1);
      success( false );
      Portable.trace( "ObjectTest exception " + e );
    }
  }

  void finality()
  {
    final int items = 1000;

    // create a balanced tree
    start("finalize");
    FLinker fl = FLinker.tree( items );
    int i = fl.count();
    int j = FLinker.counter;
    stop();
    fl = null;
    // clean up
    Portable.gc();
    success( i == items && j == items && FLinker.counter == 0 );
    // Portable.trace( "i = " + i + ", FLinker.count = " + FLinker.count );
  }

  public void run()
  {
    init();
    title(" - garbage");
    garbage();
    Portable.gc();
    linkedList(1000);
    Portable.gc();
    linkedList(5000);
    Portable.gc();
    finality();
    forName();
    // linkedList(25000); // takes far too long with old collector
    // garbage();
    // Portable.gc();
    total();
    Sound.beep();
  }
}
