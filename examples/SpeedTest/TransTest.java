import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Math;
import portable.*;

public class TransTest extends Test
{
   public TransTest()
   {
   }
   
   void transendentals()
   {
      int i;
     double a=135.0, b=1.333, c=0, d = -3.1415926536;

     // arithmetic test
     start("Double abs");
     for (i=0; i<1000; i++)
       c = Math.abs(d);
     stop(1000);
     success( c > 3.1415926535 && c < 3.1415926537 );

     // arithmetic test
     start("Double square root");
     for (i=0; i<1000; i++)
       c = Math.sqrt(a);
     stop(1000);
     success( c > 11.61895003 && c < 11.61895005 );

     // arithmetic test
     start("Double sin");
     for (i=0; i<1000; i++)
       c = Math.sin(b);
     stop(1000);
     success( c > 0.971859433 && c < 0.971859435 );

     // arithmetic test
     start("Double log");
     for (i=0; i<1000; i++)
       c = Math.log(a*a*a)/Math.log(a);
     stop(2000);
     success( c > 3.0-2e-15 && c < 3.0+2e-15 );

     // arithmetic test
     start("Double pow");
     for (i=0; i<1000; i++)
       c = Math.pow(a,b);
     stop(1000);
     c -= 691.408816907179;
     success( c > -5e-13 && c < 5e-13 && Math.pow(14,1) == 14.0 );

//     Portable.trace( "c = " + c );
//     c = Math.pow(14,1)-14.0;
//     Portable.trace( "c is small: " + (c > -2e-15 && c < 2e-15) );
//     Portable.trace( "pow(14,1)-14.0 = " + (c*1e15) + "e-15" );
//
//     c = Math.log(14.0) - 2.6390573296152586145;
//     Portable.trace( "log(14.0) - 2.6390573296152586145 = " + (c*1e15) + "e-15" );
//
//     c = Math.exp(2.6390573296152586145)-14.0;
//     Portable.trace( "exp(2.6390573296152586145)-14.0 = " + (c*1e15) + "e-15" );
//
//     c = Math.exp( Math.log(14.0) ) - 14.0;
//     Portable.trace( "exp(log(14.0)) - 14.0 = " + (c*1e15) + "e-15" );
//
//     for (i=0; i<7; i++)
//     {
//       c = Math.pow(14,i);
//       Portable.trace( "pow(14," + i + ") = " + c );
//     }
   }

   
  public void run()
  {
    init();
    title(" - transendental");
    transendentals();
    total();
    Sound.beep();
  }
}


