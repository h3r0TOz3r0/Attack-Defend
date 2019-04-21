# Networking Basic Concepts

1. Clients and Servers--how services connect to the network

	A server is a computer containing services such as website or email. It holds the page and sends out data on request.

	Example) Google's search page, such as http://www.google.com

	A client is a computer that requests data from the server such as a phone.

2. IP Addresses--how devices can be found

	Think of home. At your house you have an address. This address is unique to you and you alone.

	Now if grandma wants to send you fresh baked cookies (not that they would be fresh once they go through the postal office...)

	All she must do is make the batter, cook the dough, package the cookies and send them to 1337 LEET Ave. Computertopia, LinuxNation

	Alright. Enough with the sappy made up story. To the point: IP addresses are very similar.

	These include public facing and private facing addresses unique to the device.

	Public facing IP addresses are unique addresses that allow devices to be found external to the network

	Private facing IP addresses are unique addresses within the network that allow other devices in the network to find them. 

	IP Addresses are the unique identifier in the TCP/IP protocol.
	
	There are two standard IP addresses:

		- IP Version 4 (IPv4): uses 32 binary bits, expressed by four numbers.

		Example) 192.168.1.1 

		- IP Version 6 (IPv6): uses 128 binary bits, expressed by eight groups of hex numbers

		Example) 2001:0db8:85a3:0000:0000:8a2e:0370:7334

3. Hardware--hubs, switches and cables; hardware building blocks

	- Wires: cables, connect things directly together, such as ethernet (not practical for big networks... unless you're into that kinda thing.)

	- Hubs: a better solution then cables alone. Allows many ethernet cables to connect together like spokes on a bike wheel.

	Repeats messages to everything.

	- Switches: even better than hubs. Eliminates unnecessary repition in a hub and sends messages only to the correct receiver. 

4. Routers and Firewalls--how to organize the flow of traffic

	Routers make the majority of the decisions on the flow of messages through a network.

	Routers have three main functions:

		- Separate and Bridge: routers separate networks into sections

		- Assign IPs: use Dynamic Host Configuration Protocol (DHCP) to assign IP addresses to new devices

		- Firewall and Protect: filter unwanted messges or prevent users from accessing private networks
	

# Resources

commotionwireless.net/docs/cck/networking/learn-networking-basics/

CCNA Self-Study CCNA Intro Exam Certification Guide; Wendell Odom, CCIE No. 1624
