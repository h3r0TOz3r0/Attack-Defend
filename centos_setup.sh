############################################################################
## Setup Script                                                           ##
## Bash Script for CentOS                                                 ##
##                                                                        ##
## Author: Anna DeVries                                                   ##
## 4 April 2019                                                           ##
############################################################################

#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Run again as root 'sudo ./centos_setup.sh'"
  exit
fi

## Update Box
yum check-update
yum upgrade
yum clean all

## Download required tools plus nano for skiddies
yum install nano tcpdump iptables net-tools traceroute

## Update Kernel
uname -r
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum repolist
yum --enablerepo=elrepo-kernel install kernel-ml
yum repolist all
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
grub2-set-default 0
grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
