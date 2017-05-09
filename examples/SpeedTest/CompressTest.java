import waba.ui.*;
import waba.fx.*;
import waba.sys.*;
// import waba.util.Compression;
// import waba.util.Math;

public class CompressTest extends Test
{
  public CompressTest()
  {
  }
   
  void compression()
  {
    String text = "This is a bit of text that I would like to be compressed";
    byte[] original = text.getBytes();
    byte[] shrunk=null;
    byte[] grown=null;
    int i;

    // compress a string test
    start("Compress string");
    for (i=0; i<1000; i++)
      shrunk = Compression.shrink(original,original.length);
    stop(1000);
    // portable.Portable.trace( "Original length "+original.length );
    // portable.Portable.trace( "Shrunk length "+shrunk.length );
    success( shrunk.length == 39 );

    // decompress a string test
    start("Decompress string");
    for (i=0; i<1000; i++)
      grown = Compression.grow(shrunk, shrunk.length);
    stop(1000);
    // success( original.length == grown.length );
    success( text.equals(new String(grown)) );
  }
   
  public void run()
  {
    init();
    title(" - compression");
    compression();
    total();
    Sound.beep();
  }
}


