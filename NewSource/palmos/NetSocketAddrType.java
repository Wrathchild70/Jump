/* Source Safe Version information
 * $Header: /Waba/Jump/source/palmos/NetSocketAddrType.java 2     1/28/02 11:26a Rmontrose $
 * $Modtime: 1/27/02 4:49p $
 * $NoKeywords: $
 */

package palmos;

/**
* Structure used to hold a generic socket address. This is a generic struct 
* designed to hold any type of address including internet addresses. This 
* structure directly maps to the BSD unix struct sockaddr.
*/
public class NetSocketAddrType {
    /** Constant that means "use the local machine's IP address */
    public static final int netIPAddrLocal = 0;
	    
    /** Address family, one of the NetSocketAddrEnum values */
    public short family;
	    
    /** 14 bytes of address. This will vary depending on the type of address. If this
    *  is an internet address, the first 2 bytes will be the port number and the
    *  second 4 bytes will be the IP address in Network, and the rest zeros.
    *  UInt8 order */
    public byte b0;
    public byte b1;
    public byte b2;
    public byte b3;
    public byte b4;
    public byte b5;
    public byte b6;
    public byte b7;
    public byte b8;
    public byte b9;
    public byte b10;
    public byte b11;
    public byte b12;
    public byte b13;
	    
	private int	addrLenght;
	    
    /** Constructor. Nothing is specified
    */
    public NetSocketAddrType() {
    }
	    
    /** Constructor for a TCP/IP address, specifying the IP address and
    	*  port.
    */
    public NetSocketAddrType(int address, short portNum) {
    	setTCPIP();
    	setTCPIPPort (portNum);
    	setTCPIPAddress (address);
    }
	    
    /**
    * Sets this address for TCP/IP
    */
    public void setTCPIP() {
    	family = NetLib.NetSocketAddrEnum.netSocketAddrINET;
    	addrLenght = 8;
    }
	    
    /**
    * Sets the port number in our data
    */
    public void setTCPIPPort (short portNumber) {
    	b0 = (byte)((portNumber & 0xff00) >> 8);	// upper 8 bits
    	b1 = (byte)(portNumber & 0x00ff);			// lower 8 bits
    	addrLenght = 8;
    	//this.port = portNumber;
	    	
    }
	    
    /** 
    * Sets the TCP/IP address specified in the integer to our
    * address
    *
    */
    public void setTCPIPAddress (int address) {
    	b2 = (byte)((address >> 24) & 0xff);	// bits 25-32
    	b3 = (byte)((address >> 16) & 0xff);	// bits 17-24
    	b4 = (byte)((address >> 8) & 0xff);	// bits 9-16
    	b5 = (byte)((address) & 0xff);			// bits 1-8
    	addrLenght = 8;
    	//this.ipAddress = address;
	    	
    }
	    
    /**
    * Returns the length of this data. Fixed at 16 bytes
    */
    public int length() {
    	return addrLenght;
    }
} // NetSocketAddrType
