# War Plans / Instructables

General Steps on a CentOS

1. Download required tools

		Tools: wireshark-qt, net-tools 
		sudo yum install <service>

2. Update System

		sudo yum update

3. Change root, admin, and user password (add password to bashrc, etc)

		Set new root password: sudo passwd <root> 
		cat /etc/passwd # inspect extra users
		# make sure no SSH keys on box (save them if there are because you can use these on other boxes)
		# root = user whose password is being changed; it will prompt for passwd after

4. Update kernel

		# Note: if the kernal version is less than 4.1 then you NEED to update
		# If it doesn't boot properly after kernal update, go to "Advanced Options" in Grub and select old kernal
		# ensure it is updated; check https://www.kernel.org/ for most recent stable version
		# Any Linux distribution's kernal works the same
		# Make sure it has a static IP address enabled 
		uname -r 
		rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
		rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
		yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
		yum --enablerepo=elrepo-kernel install kernel-ml
		reboot

5. Check running services, process and open ports

		x
	
6. Other target enumeration

		CentOS:
