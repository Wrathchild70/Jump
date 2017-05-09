package palmos;

/**
	* The NetHostLookup class gives a object inteface to DNS
  *
	*/
public class NetHostLookup
{
  int[] netHostInfoBuf = new int[142];

  /** Specifies the name to lookup, returns net error or 0 */
  public int getHostByName(int libRef, String host, int timeout)
  {
    ShortHolder err = new ShortHolder();
    Palm.NetLibGetHostByName(libRef, host, netHostInfoBuf, 0, timeout, err);
    return err.value;
  }

  /** return an inet address for the lookup, typically as getTCPIPAddress(0) */
  public int getTCPIPAddress(int index)
  {
    if (index<0)
      return -1;

    return netHostInfoBuf[138+index];

    /*
    int addrListP = netHostInfoBuf[3];
    int ptr = Palm.nativeGetInt( (index<<2)+addrListP );
    return Palm.nativeGetInt(ptr);
    */
  }
}
	
