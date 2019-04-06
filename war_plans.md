# War Plans / Instructables

General Steps on a CentOS

1. Change root, admin, and user password (add password to bashrc, etc)

		# Randomly assign workable IP Address to box
		sudo dhclient <ethernet_name(ens33,eth0,etc)>
		# Ensure your IP address is static
		sudo ip addr add <static_ip_address>
		# Change root password 
		sudo passwd root
		# Change user password
		sudo passwd <usr>
		# Note: no one should ever log into "root" again
		
		# Check users/privs  
		cat /etc/passwd
		# Add human-user profiles
		sudo useradd <user_name>
		# Delete extra human-user profiles
		sudo userdel <user_name>
		# Change user to be sudoer
		sudo usermod -aG wheel <user_name>

4. Run centos_setup.sh

		scp <src> <dst>
		scp centos_setup.sh tankers@<ip_addr>:/home/tankers

5. Check running services, process and open ports

		# Check out services
		netstat -pant
		# Ports: 
			# web server 172.16.*.2 (port 80) // could include 443
			# file share server 172.16.*.4 (port 139 and 445)
			# Domain Name System (DNS) server 172.16.*.6 (port 53 tcp and udp)
			# email server 172.16.*.8 (port 25, 110, 143)
			# database management system (DBMS) server 172.16.*.9 (port 1440) 
		# Run firewall script: sudo ./centos_fw.sh <port_number>
		./centos_fw.sh
		
6. Other target enumeration

		x