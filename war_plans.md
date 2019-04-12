# War Plans / Instructables

General Steps on a CentOS

0. Drink Coffee amd copying scripts from one box to another

		scp <srv> <dst>
		scp <script.sh> tankers@<ip>:/home/tankers

1. Target enumeration

		./centos_targetenum.sh

2. Change root, admin, and user password (add password to bashrc, etc)

		sudo passwd <usr>
		# change both user and root password this way (replace usr with root, etc)
		# Hint: never log into "root" again
		
		# sudo dhclient <ethernet_name(ens33,eth0,etc)>
		# sudo dhclient -v
		# sudo ip addr add/del <static_IP> dev <ethernet_name>

3. Save VM Image

4. User Information
		
		cat /etc/passwd
		# check users/privs
		
		sudo useradd <usr>
		sudo userdel <usr>
		sudo usermod -aG wheel <usr> # escalates user to "sudo" privs

5. Run centos_setup.sh

		sudo ./centos_setup.sh

6. Check running services, process and open ports

		netstat -pan 
		systemctl list-unit-files
		# check services/ports 
		
		# Important ports: 
			# web server 172.16.*.2 (port 80) // could include 443
			# file share server 172.16.*.4 (port 139 and 445)
			# Domain Name System (DNS) server 172.16.*.6 (port 53 tcp and udp)
			# email server 172.16.*.8 (port 25, 110, 143)
			# database management system (DBMS) server 172.16.*.9 (port 1440) 

6. Save VM Image

7. Firewall
	
		./centos_fw.sh <portnum>
		
8. Save VM Image

9. Setup/Secure servers

	- DNS
	
		Make sure DNS Recursion is disabled
		Restrict zone transfers??? (Might not be against rules of competition)
		Configure firewall to detect and block DNS tunneling

	- Secure Email Server

		SMTP authentication? (Don't know if applicable to competition or what it is)
		Encrypt ingoing/outgoing mail
		Watch out for known metasploit exploits on popular linux email servers like zembra
		Look at sendmail (default for centOS mail servers)
		
	- Secure File Server

		Disable anonymous use or, if anonymous use required, ensure they don't have unauthorized access
		
		If Samba (likely), make sure version is greater than 4.6.4
		Make sure default keys are not used
		Settings found in /etc/samba/smb.conf
		Look at potentially using stunnel https://wiki.netbsd.org/tutorials/how_to_secure_samba_with_stunnel/
		
	- Securing Database Management System

		Use web application firewall
		Encrypt stored files (might not be applicable given competition)
		Enable security Controls
		     - Securing Web Server

		Look into apachetop command tool for monitoring web server
		Make sure SELinux is set to enforcer
		
		If Appache web server, disable trace http request
		make sure it's not running under root user
		Disable signature (hide which version of appache is running)
		Disable Banner
		Use TLS over SSL
		Disable directory listings
		make sure users cannot create own directories
		Examine CGI scripts (how others interact with web server)
		     -Consider CGI Scripts as separate from server and another thing to examine and secure
			i. limit allowable characters
		Upgrade to latest version of appache


10. Save VM Image
