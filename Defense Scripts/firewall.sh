######################################################
## Firewall Script                                  ##
## Bash Script for Ubuntu Version 18.10             ##
##                                                  ##
## Description: basic firewall script to drop all   ##
## traffic except to ports 53, 22, and 443, and     ##
## all handshake traffic. You may also add extra    ##
## authorized ports.                                ##
## Author: Anna DeVries                             ##
## 1 April 2019                                     ##
##                                                  ##
## chmod u+x firewall.sh                            ##
## ./firewall.sh $port_num                          ##
##                                                  ##
## Note: will not allow nmap, etc.                  ##
## See fw_ops.sh for an ops related firewall.       ##
######################################################

########################UNDER CONSTRUCTION! Need to 1) work through restarts (save and automatically load) 
######################## 2) LOG

#!/usr/bin/bash

IP_ADDR=`hostname -I`
echo "Your IP Address is "$IP_ADDR

echo "" 

echo "Checking dependencies..."
if [ ! -x "$(command -v iptables)" ]; then
	echo "Install 'sudo apt install iptables' and try again"
	exit 
elif [ ! -x "$(command -v iptables-save)" ]; then
	echo "Install 'sudo apt install iptables-persistent' and try again"
	exit
else
	echo "Already downloaded iptables and iptables-persistent"
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
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT			# allows SSH traffic

## Allowed Output Traffic
/sbin/iptables -A OUTPUT -p udp --dport 53 -j ACCEPT			# allows DNS output traffic
/sbin/iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT			# allows SSH output traffic
/sbin/iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT			# allows HTTPS output traffic
/sbin/iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT			# allows HTTP output traffic
/sbin/iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT	# allows handshake traffic

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
	echo "If this is incorrect, please re-run as './firewall.sh port_number' "
fi
for arg in "$@"
do
	/sbin/iptables -A INPUT -d $IP_ADDR -p tcp --dport $arg -j ACCEPT
done

## Otherwise, drop all traffic
/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -P OUTPUT DROP

## Save iptable rules to be persistent
iptables-save > /etc/iptables/rules.v4

## Log Traffic
iptables -I FORWARD 1 -j LOG
iptables -I OUTPUT 1 -j LOG
iptables -I INPUT 1 -j LOG
echo ""
echo "Watch live logging 'tail -f /var/log/messages'" 
