############################################################################
## Target Enumeration Script                                              ##
## Bash Script for CentOS                                                 ##
##                                                                        ##
## 6 April 2019                                                           ##
##                                                                        ##
## ./centos_targetenum.sh                                                 ##
############################################################################

#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "If this fails attempt to run like:"
echo "sudo bash ./survey.sh"
echo "======================"

logginuser=`who | awk '{print $1;}'`
ipaddr=`hostname -i`
osname=`cat /etc/os-release | head -n 1 | grep -o '".*"'| sed 's/"//g' | awk '{print $1;}'`
osver=`cat /etc/os-release | grep VERSION_ID | grep -o '".*"'| sed 's/"//g' | awk '{print $1;}'`
RESULTFILE="/tmp/${osname}_${osver}_results.txt"


echo "========================= SYSINFO =========================" > `echo $RESULTFILE` 2>&1
uname -a >> `echo $RESULTFILE` 2>&1
echo "-------------- OS INFO  --------------" >> `echo $RESULTFILE` 2>&1
cat /etc/os-release >> `echo $RESULTFILE` 2>&1
echo "-------------- HARDWARE --------------" >> `echo $RESULTFILE` 2>&1
lshw -short >> `echo $RESULTFILE` 2>&1
echo "======================== DISK INFO ========================" >> `echo $RESULTFILE` 2>&1
df -h >> `echo $RESULTFILE` 2>&1
echo "==================== USER INFORMATION =====================" >> `echo $RESULTFILE` 2>&1
echo "-------------- PASSWD --------------" >> `echo $RESULTFILE` 2>&1
cat /etc/passwd >> `echo $RESULTFILE` 2>&1
echo "-------------- SHADOW --------------" >> `echo $RESULTFILE` 2>&1
cat /etc/shadow >> `echo $RESULTFILE` 2>&1
echo "-------------- GROUPS --------------" >> `echo $RESULTFILE` 2>&1
cat /etc/group >> `echo $RESULTFILE` 2>&1
echo "-------------- USERS  --------------" >> `echo $RESULTFILE` 2>&1
awk -F: '{ print $1}' /etc/passwd >> `echo $RESULTFILE` 2>&1
echo "------------- USER DIR -------------" >> `echo $RESULTFILE` 2>&1
ls -lisa /home >> `echo $RESULTFILE` 2>&1
echo "-------------- SUDOERS -------------" >> `echo $RESULTFILE` 2>&1
getent group sudo | cut -d: -f4 >> `echo $RESULTFILE` 2>&1
echo "---------- LOGGED IN USERS ---------" >> `echo $RESULTFILE` 2>&1
who >> `echo $RESULTFILE` 2>&1
echo "======================== NETWORKING ========================" >> `echo $RESULTFILE` 2>&1
echo "-------------- INTERFACES --------------" >> `echo $RESULTFILE` 2>&1
ip addr show >> `echo $RESULTFILE` 2>&1
ip route show >> `echo $RESULTFILE` 2>&1
echo "-------------- OPEN PORTS --------------" >> `echo $RESULTFILE` 2>&1
netstat -pant >> `echo $RESULTFILE` 2>&1
echo "========================= FIREWALL =========================" >> `echo $RESULTFILE` 2>&1
iptables -L >> `echo $RESULTFILE` 2>&1
ufw -status >> `echo $RESULTFILE` 2>&1
echo "========================= PROCESSES ========================" >> `echo $RESULTFILE` 2>&1
ps -ef | grep -v '\[' >> `echo $RESULTFILE` 2>&1
echo "========================= SERVICES =========================" >> `echo $RESULTFILE` 2>&1
systemctl list-units --type service >> `echo $RESULTFILE` 2>&1
echo "============================ JOBS ==========================" >> `echo $RESULTFILE` 2>&1
for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l >> `echo $RESULTFILE` 2>&1; done
echo "============================ LOGS ==========================" >> `echo $RESULTFILE` 2>&1
ls -lisa /var/log >> `echo $RESULTFILE` 2>&1

echo "Survey complete. file stored at $RESULTFILE"
echo "Please move the file off by running the following command from your host machine:"
echo "scp $logginuser@$ipaddr:$RESULTFILE ."
