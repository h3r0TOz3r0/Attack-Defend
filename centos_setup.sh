############################################################################
## Setup Script                                                           ##
## Bash Script for CentOS                                                 ##
##                                                                        ##
## Author: Anna DeVries                                                   ##
## 4 April 2019                                                           ##
##                                                                        ##
## Instructions for Moving Script from OPS to Remote                      ##
## scp <src> <dst>                                                        ##
## scp centos-setup.sh bytesforeveryone@10.15.0.56:/home/bytesforeveryone ##
############################################################################

#!/usr/bin/bash

## Update Box
yum check-update
yum upgrade
yum clean all

## Download required tools
yum install nano lsof tcpdump iptables net-tools

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
