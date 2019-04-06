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
	echo "Install 'sudo apt install iptables' and try again"
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
echo "Ensure only the following services are running at these ports: 53 = DNS, 22 = SSH, 443 = HTTPS, 80 = HTTP"
echo "run 'sudo netstat -pant' to see services"
/sbin/iptables -A INPUT -i lo -j ACCEPT					# allows traffic in local interface
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT	# allows handshake traffic
/sbin/iptables -A INPUT -d $IP_ADDR -p udp --dport 53 -j ACCEPT		# allows DNS traffic
/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport 22 -j ACCEPT		# allows SSH traffic
/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport 443 -j ACCEPT	# allows HTTPS traffic
/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport 80 -j ACCEPT		# allows HTTP traffic

## Allow ICMP traffic
interface="$(ip route | grep default | awk '{print $5}')"
network="$(ip addr | grep enp1s0 | awk 'FNR==2{print $2}')"
/sbin/iptables -A INPUT -s "$network" -p icmp --icmp-type 0 -j ACCEPT	# allows echo reply (only on local network)
/sbin/iptables -A INPUT -s "$network" -p icmp --icmp-type 3 -j ACCEPT	# allows unreachable reply (only on local network)
/sbin/iptables -A INPUT -s "$network" -p icmp --icmp-type 8 -j ACCEPT	# allows echo request (only on local network)
/sbin/iptables -A INPUT -s "$network" -p icmp --icmp-type 11 -j ACCEPT	# allows ttl exceeded reply (only on local network)
/sbin/iptables -A INPUT -s "$network" -p icmp --icmp-type 12 -j ACCEPT	# allows parameter problem reply (only on local network)
/sbin/iptables -A OUTPUT -s "$network" -p icmp --icmp-type 0 -j ACCEPT	# allows echo reply response
/sbin/iptables -A OUTPUT -s "$network" -p icmp --icmp-type 8 -j ACCEPT	# allows echo request

echo ""

## Allow Specified Ports
if [ ! -x "($arg)" ]; then
	echo "No ports listed; only ports 443, 22, and 80 authorized"
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
