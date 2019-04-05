#!/usr/bin/bash

## Update Box
yum check-update
yum upgrade
yum clean all

## Download required tools
yum install nano net-tools lsof bash-completion wireshark-qt

## Update Kernel
echo "Indictate if you'd like to upgrade the kernel with a y/n. Recommend upgrade if version <4.1"
uname -r
read -n 1 response 
if [ response == "y" ]
then
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
 	yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
 	yum --enablerepo=elrepo-kernel install kernel-ml
fi


