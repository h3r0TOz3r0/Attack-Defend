######################################################
## Firewall Script                                  ##
## Bash Script for CentOS                           ##
##                                                  ##
## Author: Anna DeVries                             ##
## 5 April 2019                                     ##
##                                                  ##
######################################################

#!/usr/bin/bash

IP_ADDR=`hostname -I`
echo "Your IP Address is "$IP_ADDR
echo "" 
echo "WARNING!!!!! This script is vulnerable to reverse shells"
echo ""

echo "Checking dependencies..."
if [ ! -x "$(command -v iptables)" ]; then
	echo "Install 'sudo yum install iptables' and try again"
	exit 
else
	echo "Already downloaded iptables"
fi

echo ""

## Clean Up Existing Rules
/sbin/iptables -F
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT

## Allowed Input Traffic
echo "run 'sudo netstat -pant' to see services"
/sbin/iptables -A INPUT -i lo -j ACCEPT					# allows traffic in local interface
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT	# allows handshake traffic
/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport 22 -j ACCEPT		# allows SSH traffic

## Allow ICMP traffic
interface="$(ip route | grep default | awk '{print $5}')"
network="$(ip addr | grep enp1s0 | awk 'FNR==2{print $2}')"
/sbin/iptables -A OUTPUT -s "$network" -p icmp --icmp-type 0 -j ACCEPT	# allows echo reply response
/sbin/iptables -A OUTPUT -s "$network" -p icmp --icmp-type 8 -j ACCEPT	# allows echo request

echo ""

## Allow Specified Ports
if [ ! -x "($arg)" ]; then
	echo "No ports listed"
	echo "If this is incorrect, please re-run as './fw_ops.sh port_number' "
fi
for arg in "$@"
do
	/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport $arg -j ACCEPT
done

## Otherwise, drop all traffic (except output traffic)
/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -P OUTPUT ACCEPT
