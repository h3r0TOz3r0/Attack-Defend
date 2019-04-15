##################################################################################
## Delete User                                   		  		##
## Bash Script for CentOS                           		  		##
##                                                  		   		##
## Author: Anna DeVries; Revised from "Wicked Cool Shell Scripts" pg 136-137	##
## 15 April 2019                                     		   		##
##################################################################################

#!/bin/bash

homedir="/home"
pwfile="/etc/passwd"
shadow="/etc/shadow"
newpwfile="/etc/passwd.new"
newshadow="/etc/shadow.new"
suspend="$(which suspenduser)"
locker="/etc/passwd.lock"

if [ "$EUID" -ne 0 ]
  then 
  echo "Run again as root 'sudo ./usrdel.sh'"
  exit
fi

# Suspend the Accounts
for arg in "$@"
do
	usermod -s /sbin/nologin $arg
	count=$count+1
done
read "There are $count users being deleted. Is this correct? (y/n)" ans
if [ $ans -eq "yY"

uid="$(grep -E "^${1}:" $pwfile | cut -d: -f3)"

if [ -z $uid ] ; then
	echo "Error: no account $1 found in $pwfile" >&2
	exit 1
fi

grep -vE "^${1}:" $pwfile > $newpwfile
grep -vE "^${1}:" $shadow > $newshadow

lockcmd="$(which lockfile)"
if [ ! -z $lockcmd ] ; then
	eval $lockcmd -r 15 $locker
else
	while [ -e $locker ] ; do
		echo "waiting for the password file"; sleep 1
	done
	touch $locker
fi

mv $newpwfile $pwfile
mv $newshadow $shadow
rm -f $locker

chmod 644 $pwfile
chmod 400 $shadow

rm -rf $homedir/$1

echo "Files still left to remove (if any):"
find / -uid $uid -print 2>/dev/null | sed 's/^/ /'

echo ""
echo "Account $1 (uid $uid) has been deleted, and their home directory"
echo "($homedir/$1) has been removed."

exit 0
