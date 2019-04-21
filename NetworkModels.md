# Networking Models

Let's call it "Networking Architecture" though, cause it's an acceptable term and it sounds cooler...

Anyway. These offer an organized description of networks, including protocols and hardware specifications.

CCNA mainly only cares about TCP/IP Networking Model with a little flavor of love for the OSI Model. So we'll look at both.

# TCP/IP Model

This is supported by all major operating systems whether be Microsoft, Linux, and UNIX. 

| TCP/IP Architecture Layer | Example Protocols     |
| ------------------------- |:---------------------:|
| Application               | HTTP, POP3, SMTP, HTML|
| Transport                 | TCP, UDP              |
| Internetwork              | IP                    |
| Network interface         | Ethernet, Frame Relay |

1) Application Layer

	Example: a web page

	HTTP = Hypertext Transfer Protocol; performs the request and transfer of files

	HTML = Hypertext Markup Language; defines how a web browser should interpret the text inside the file

2) Transport Layer

	Main focus of the transport layer is to guarantee delivery of data.

	Consists of two main protocols: 

	- Transmission Control Protocol (TCP): provides error recovery; consumes more bandwidth; uses more processing cycles. Requires a connection (exchange of msgs before data transfer)
		
		. Multiplexing using port numbers: enables the receiver to know which app to give data to; relies on a socket (IP addr, transport protocol, port number)

		. Error recovery (reliability): uses Sequence and Acknowledgment fields in both directions

		. Flow control using windowing: it's more efficient to send large amounts of data at once. But you want to do that reliably.
	
		Thus, you send a small amount, assuming no errors, you send a larger amount. And so on.

		. Connection establishment and termination: three way handshake... SYN sent, SYN and ACK received, ACK sent

		. End-to-end ordered data transfer: reassembling data into original order, i.e. due to sequence numbers

		. Segmentation: breaks continuous data streams into segments for transmission

		. Connection: other protocols that use this are LLC Type 2, Novell SPX, Frame Relay, ATM VCs, PPP

	- User Datagram Protocol (UDP): connectionless (does not require a transfer of data/ACK to send data)
		
		. Data transfer

		. Segmentation

		. Multiplexing using port numbers

		. Connectionless: other protocols that use this are TFTP, NetWare NCP, IP, and most Layer 3 protocols

| Function                 | TCP Description                                 | UDP Description |
| ------------------------ |:-----------------------------------------------:|:---------------:|
| Ordered data transfer    | Continuous steam of ordered data                | DNE             |
| Multiplexing using ports | Hosts decide apps for data based on port number | Same as TCP     |
| Reliable transfer        | ACK of data                                     | DNE             |
| Flow control             | Protects buffer space and routing devices       | DNE             |
| Connections              | Initializes port numbers and header fields      | Connectionless  |


# Open Systems Interconnection Networking Model

| Layer | Name         | Description                                                  | Examples                               |
| ----- |:------------:|:------------------------------------------------------------:|:--------------------------------------:|
|   7   | Application  | end user layer; web browser                                  | HTTP, FTP, IRC, SSH, DNS               |
|   6   | Presentation | syntax layer; defines data formats                           | SSL, SSH, IMAP, FTP, MPEG, JPEG        |
|   5   | Session      | synch+send to port; how to start, control, end conversations | API's, Sockets, WinSock                |
|   4   | Transport    | end-to-end connections; data delivery                        | TCP, UDP                               |
|   3   | Network      | packets; logical addressing, routing                         | IP, ICMP, IPSec, IGMP                  |
|   2   | Data Link    | frames                                                       | Ethernet, PPP, Switch, Bridge          |
|   1   | Physical     | physical structure (the best part)                           | Coax, Fiber, Wireless, Hubs, Repeaters, Electrical signals |

# Resources

CCNA Self-Study CCNA Intro Exam Certification Guide; Wendell Odom, CCIE No. 1624

