/* Source Safe Version information
 * $Header: /Waba/Jump/source/palmos/NetLib.java 2     1/28/02 11:26a Rmontrose $
 * $Modtime: 1/27/02 4:50p $
 * $NoKeywords: $
 */

package palmos;

/**
 * Defined structures and constants needed to use the Palm NetLibrary
 *
 */
public class NetLib {
	
	//##### Network constants

	
	/** Flags values for the NetLibSend, NetLibReceive calls<br>
	 *	process out-of-band data */
	public static final int 	netIOFlagOutOfBand = 0x01; 
	/** peek at incoming message  */
	public static final int 	netIOFlagPeek = 0x02;
	/** send without using routing  */
	public static final int 	netIOFlagDontRoute = 0x04; 
	/** maximum lenght for a domain name */
	public static final int		netDNSMaxDomainName = 255;
	/** maximum part of the label of the domain */
	public static final int		netDNSMaxDomainLabel = 63;
	/** max # of aliases for a host */
	public static final int		netDNSMaxAliases = 1;
	/** max # of addresses for a host */
	public static final int		netDNSMaxAddresses = 4;
	/*
		/**   /
		public static final byte ;
	*/
	
	/**
	 * Defined the various types of sockets address. Currently just IP and Raw
	 * are defined.
	 */
	public static class NetSocketAddrEnum {
		/** For the addrType field. The RAW address of the connection (AF_UNSPEC, AF_RAW) */
		public static final short netSocketAddrRaw = 0; 
		/** For the addrType field. The Internet IP address of the connection (AF_INET) */
		public static final short netSocketAddrINET = 2;
    }
	
	/**
	 * Types of sockets
	 */
	public static class NetSocketTypeEnum {
		/** SOCK_STREAM */
		public static final byte netSocketTypeStream = 1;
		/** SOCK_DGRAM */
		public static final byte netSocketTypeDatagram = 2;
		/** SOCK_RAW */
		public static final byte netSocketTypeRaw = 3;
		/** SOCK_RDM */
		public static final byte netSocketTypeReliableMsg = 4;
		/** */
		public static final byte netSocketTypeLicensee = 8;		
	}
	
	/**
	 * Network Protocols supported
	 *
	 */
	public static class NetSocketProtocolEnum {
		/** IPPROTO_ICMP  */
		public static final int 	netSocketProtoIPICMP = 1;
		/** IPPROTO_TCP  */
		public static final int 	netSocketProtoIPTCP = 6;
		/** IPPROTO_UDP  */
		public static final int 	netSocketProtoIPUDP = 17;
		/** IPPROTO_RAW  */
		public static final int 	netSocketProtoIPRAW = 255;
    }
		
	
	/**
	 * Option constants that can be passed to NetSocketOptionSet and NetSocketOptionGet
	 * When an option is set or retrieved, both the level of the option and the
	 * option number must be specified. The level refers to which layer the option
	 * refers to, like the uppermost socket layer, for example.
	 */
	public static class NetSocketOptEnum {
		// IP Level options
		/** options in IP header (IP_OPTIONS) */
		public static final short netSocketOptIPOptions = 1;
		
		// TCP Level options
		/**  don't delay send to coalesce packets */
		public static final short netSocketOptTCPNoDelay = 1;
		/** TCP maximum segment size (TCP_MAXSEG)  */
		public static final short netSocketOptTCPMaxSeg = 2;
		
		// Socket level options
		/** turn on debugging info recording */
		public static final short netSocketOptSockDebug = 0x0001;
		/** socket has had listen  */
		public static final short netSocketOptSockAcceptConn = 0x0002;
		/** allow local address reuse  */
		public static final short netSocketOptSockReuseAddr = 0x0004;
		/** keep connections alive  */
		public static final short netSocketOptSockKeepAlive = 0x0008;
		/** just use interface addresses */
		public static final short netSocketOptSockDontRoute = 0x0010;
		/** permit sending of broadcast msgs */
		public static final short netSocketOptSockBroadcast = 0x0020;
		/** bypass hardware when possible */
		public static final short netSocketOptSockUseLoopback = 0x0040;
		/** linger on close if data present  */
		public static final short netSocketOptSockLinger = 0x0080;
		/** leave received OutOfBand data in line  */
		public static final short netSocketOptSockOOBInLine = 0x0100;
		/** send buffer size  */
		public static final short netSocketOptSockSndBufSize = 0x1001;
		/** receive buffer size  */
		public static final short netSocketOptSockRcvBufSize = 0x1002;
		/** send low-water mark */
		public static final short netSocketOptSockSndLowWater = 0x1003;
		/** receive low-water mark  */
		public static final short netSocketOptSockRcvLowWater = 0x1004;
		/** send timeout  */
		public static final short netSocketOptSockSndTimeout = 0x1005;
		/** receive timeout  */
		public static final short netSocketOptSockRcvTimeout = 0x1006;
		/** get error status and clear  */
		public static final short netSocketOptSockErrorStatus= 0x1007;
		/** get socket type  */
		public static final short netSocketOptSockSocketType = 0x1008;
	
		// The following are Pilot specific options
		/** set non-blocking mode on or off  */
		public static final short netSocketOptSockNonBlocking = 0x2000;
		/** return error from all further calls to socket
		 *  unless  netSocketOptSockErrorStatus is cleared.  */
		public static final short netSocketOptSockRequireErrClear = 0x2001;
		/** for SOCK_RDM (RMP) sockets. This is the fixed IP addr (i.e. Mobitex MAN #) 
		 *  to use for multiple packet requests  */
		public static final short netSocketOptSockMultiPktAddr = 0x2002;
	}
	
	/**
	 * Option levels for SocketOptionSet and SocketOptionGet
	 */
	public static class NetSocketOptLevelEnum {
		/** IP level options (IPPROTO_IP)  */
		public static final short netSocketOptLevelIP = 0;
		/** TCP level options (IPPROTO_TCP)  */
		public static final short netSocketOptLevelTCP = 6;
		/** Socket level options (SOL_SOCKET)  */
		public static final short netSocketOptLevelSocket = (short)0xFFFF;
		
	}
	
	/**
	 *
	 */
	public static class NetSocketDirEnum {
		/**   */
		public static final byte netSocketDirInput=0;
		/**   */
		public static final byte netSocketDirOutput=1;
		/**   */
		public static final byte netSocketDirBoth=2;
	}

}