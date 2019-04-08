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
  then echo "Run again as root 'sudo ./centos_targetenum.sh'"
  exit
fi

echo -n "Which service is this box running?: "
read ans
echo $ans

echo "Target Enumeration Text File" > ${ans}_centos_attack_vector.txt
echo " " >> ${ans}_centos_attack_vector.txt

echo "-----System Information-----" >> ${ans}_centos_attack_vector.txt
cat /etc/centos-release >> ${ans}_centos_attack_vector.txt
echo "IP Address: " >> ${ans}_centos_attack_vector.txt
ip addr | grep "inet " >> ${ans}_centos_attack_vector.txt
echo "Kernel Information: " >> ${ans}_centos_attack_vector.txt
uname -a >> ${ans}_centos_attack_vector.txt
echo " " >> ${ans}_centos_attack_vector.txt

echo "-----User/Root Privs Information-----" >> ${ans}_centos_attack_vector.txt
echo "Password: " >> ${ans}_centos_attack_vector.txt
cat /etc/passwd >> ${ans}_centos_attack_vector.txt
echo "Shadow: " >> ${ans}_centos_attack_vector.txt
cat /etc/shadow >> ${ans}_centos_attack_vector.txt
echo "Groups: " >> ${ans}_centos_attack_vector.txt
cat /etc/group >> ${ans}_centos_attack_vector.txt









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
