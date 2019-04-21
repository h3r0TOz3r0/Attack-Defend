#!/bin/bash

###############################################
## Setup                                     ##
## Bash Script for Ubuntu Version 18.10      ##
##                                           ##
## Description: removes unnecessary services ##
## Author: Anna DeVries                      ##
## 30 March 2019                             ##
##                                           ##
## chmod u+x services.sh                     ##
## ./services.sh                             ##
##                                           ##
## requires: services.txt                    ##
###############################################

while read line
do
	OP=`echo $line | awk '{print $2}'`
	SERV=`echo $line | awk '{print $1}'`
	if [ "$OP" = "No" ]
	then
		sudo apt purge --yes $SERV
	fi
done <services.txt

	

