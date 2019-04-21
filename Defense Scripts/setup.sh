#!/usr/bin/bash

sudo yum check-update
sudo yum upgrade
sudo yum clean all

sudo apt install net-tools 	# netstat -pant 
				# netstat -pant | grep 23

## Finding services running at ports
# sudo netstat -pant
# ps -ef | grep $pid (pid = process ID; the number in front of the service)
## This shows the actual service running; who it's running as; etc
# cd etc/<service_name>
# cat <service>.conf
## Within this file: see if it permits root activity, whether it allows unpriveleged authentication
## or any other misconfigurations
## disable service if necessary: sudo systemctl disable <service>
## TO NOTE! if not removing it: Anonymous should be no, 
## otherwise, fix file and restart

## If you're on CentOS, use "ss" instead of "netstat"
# sudo yum install iproute iproute-doc
# 

sudo apt install wireshark-qt	# select "no" and run as "sudo wireshark"


