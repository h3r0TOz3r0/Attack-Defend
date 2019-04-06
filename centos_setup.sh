#!/usr/bin/bash

############################################################################
## Instructions for Moving Script from OPS to Remote                      ##
## scp <src> <dst>                                                        ##
## scp centos-setup.sh bytesforeveryone@10.15.0.56:/home/bytesforeveryone ##
############################################################################

## Update Box
yum check-update
yum upgrade
yum clean all

## Download required tools
yum install nano lsof tcpdump iptables 

## Update Kernel
uname -r

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
yum --enablerepo=elrepo-kernel install kernel-ml

reboot
