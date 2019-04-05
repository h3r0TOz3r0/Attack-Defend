# War Plans / Instructables

General Steps on a CentOS

1. Change root, admin, and user password (add password to bashrc, etc)

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

4. Run centos_setup.sh

5. Check running services, process and open ports

		x
	
6. Other target enumeration

		x
