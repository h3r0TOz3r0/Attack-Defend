# War Plans / Instructables

General Steps on a CentOS

0. Troubleshooting 
		
		# Network Troubleshooting
		sudo dhclient <ethernet_name(ens33,eth0,etc)>
		sudo dhclient -v
		sudo ip addr add/del <static_IP> dev <ethernet_name>

1. Copying scripts from one box to another

		scp <srv> <dst>
		scp <script.sh> tankers@<ip>:/home/tankers

2. Target enumeration

		sudo ./centos_targetenum.sh

3. Change root, admin, and user password; add user for team (add password to bashrc, etc)

		sudo passwd root
		sudo passwd admin
		sudo useradd tankers
		sudo passwd tankers
		# Hint: never log into "root" again

4. Save VM Image

5. Run centos_setup.sh

		sudo ./centos_setup.sh
		
6. User Information
		
		cat /etc/passwd
		cat /etc/shadow
		# check users/privs
		
		sudo useradd <usr>
		sudo userdel <usr>
		sudo usermod -aG wheel <usr> # escalates user to "sudo" privs

7. Check running services, process and open ports

		sudo netstat -pan 
		systemctl list-unit-files		
		# Important ports: 
			# web server 172.16.*.2 (port 80) // could include 443
			# file share server 172.16.*.4 (port 139 and 445)
			# Domain Name System (DNS) server 172.16.*.6 (port 53 tcp and udp)
			# email server 172.16.*.8 (port 25, 110, 143)
			# database management system (DBMS) server 172.16.*.9 (port 1440) 

8. Save VM Image

9. Firewall
	
		sudo ./centos_fw.sh <portnum>
		
8. Save VM Image

9. Setup/Secure servers

	- DNS: port 

	- Secure Email Server
		
	- Secure File Server
		
	- Securing Database Management System

10. Save VM Image

11. Network Monitoring
