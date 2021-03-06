#####################################################################
## Firewall Script                                  		   ##
## Bash Script for CentOS                           		   ##
##                                                  		   ##
## Author: Tanker DeVries 					   ##
## 5 April 2019                                     		   ##
#####################################################################

############ UNDER CONSTRUCTION ################### 

#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Run again as root 'sudo ./centos_targetenum.sh'"
  exit
fi

IP_ADDR=`hostname -I`
echo "Your IP Address is "$IP_ADDR
echo "" 

echo "Checking dependencies..."
if [ ! -x "$(command -v iptables)" ]; then
	echo "Install 'sudo yum install iptables' and try again"
	exit 
fi

echo ""

## Clean Up Existing Rules
/sbin/iptables -F
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT

## Allowed Traffic
echo "run 'sudo netstat -pant' or 'sudo ss -s' to see services"
/sbin/iptables -A INPUT -i lo -j ACCEPT					# allows traffic in local interface
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT	# allows input handshake traffic
/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport 22 -j ACCEPT		# allows SSH traffic
/sbin/iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT	# allows output handshake traffic

## Allow Specified Ports
for arg in "$@"
do
	if [ $arg -eq "53" ]; then
		echo "Adding UDP and TCP at Port 53"
		/sbin/iptables -A INPUT -d $IP_ADDR -p udp --dport $arg -j ACCEPT
		/sbin/iptables -A OUTPUT -d $IP_ADDR -p udp --sport $arg -j ACCEPT
	fi
	/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport $arg -j ACCEPT
	/sbin/iptables -A OUTPUT -d $IP_ADDR -p tcp --sport $arg -j ACCEPT
done

## Otherwise, drop all traffic (except output traffic)
/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -P OUTPUT DROP
