package palmos;

public class SlkPktHeader {
  public short signature1;
  public byte  signature2;
  public byte  dest;
  public byte  src;
  public byte  type;
  public short bodySize;
  public byte  transId;
  public byte  checksum;
}
