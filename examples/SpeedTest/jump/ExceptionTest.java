import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Math;

public class ExceptionTest extends Test
{
  class Cloner implements Cloneable
  {
    int value;
    Cloner(int value)
    {
      this.value = value;
    }

    protected Object clone() throws CloneNotSupportedException
    {
      return super.clone();
    }
  }

  public ExceptionTest()
  {
  }

  private static RuntimeException re;

  private static void except1(boolean doit) throws RuntimeException
  {
    except2(doit);
  }
   
  private static void except2(boolean doit) throws RuntimeException
  {
    except3(doit);
  }
   
  private static void except3(boolean doit) throws RuntimeException
  {
    except4(doit);
  }
   
  private static void except4(boolean doit) throws RuntimeException
  {
    if (doit)
      throw re;
  }
   
  void except()
  {
    int i, j;

    re = new RuntimeException("thrown");

    start("throw");
    for (j=i=0; i<50000; i++)
    {
      try
      {
        throw re;
      }
      catch ( RuntimeException e )
      {
        j++;
      }
    }
    stop(i);
    success( j == i );

    start("deep throw");
    for (j=i=0; i<30000; i++)
    {
      try
      {
        except1( true );
      }
      catch ( RuntimeException e )
      {
        j++;
      }
    }
    stop(i);
    success( j == i );

    Object o = null;
    start("not cloneable");
    for (j=i=0; i<10000; i++)
    {
      try
      {
        o = this.clone();
      }
      catch ( CloneNotSupportedException e )
      {
        j++;
      }
    }
    stop(i);
    success( j == i );

    Cloner c = new Cloner(5);
    start("clone class");
    for (j=i=0; i<10000; i++)
    {
      try
      {
        o = c.clone();
      }
      catch ( CloneNotSupportedException e )
      {
        j++;
      }
    }
    stop(i);
    success( j == 0 && o != c && ((Cloner)o).value == c.value );

    int[] a = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 };
    start("clone array");
    for (j=i=0; i<10000; i++)
    {
      o = a.clone();
    }
    stop(i);
    success( o != a );
  }
   
  public void run()
  {
    init();
    title(" - exceptions");
    except();
    total();
    Sound.beep();
  }
}


