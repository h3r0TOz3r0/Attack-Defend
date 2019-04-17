#!/bin/bash
#####
## This script automates reading, and executing files in subdirectories.
## Must pass IP/PORT to the script
## usage: sudo ./thrower.sh 2> /dev/null
#####

#WEB='172.16.x.2'
WEB_PORT=80

#FILESHARE='172.16.x.4'
FS_PORT=99

#DNS='172.16.x.6'
DNS_PORT=53

#EMAIL='172.16.x.8'
EMAIL_PORT=25

#DBMS='172.16.x.9'
DBMS_PORT=1433

# Change this array to have the target network ips
targets=( 1 2 3 4 )
while true; do
    for i in "${targets[@]}"
    do
        #throw web exploits
        for file in ./exploit_web/*.py; do
            python $file 172.16.${i}.2 $WEB_PORT
        done
        for file in ./exploit_web/*.sh; do
            bash $file 172.16.${i}.2 $WEB_PORT
        done

        #throw fileshare exploits
        for file in ./exploit_fss/*.py; do
            python $file 172.16.${i}.4 $FS_PORT
        done
        for file in ./exploit_fss/*.sh; do
            bash $file 172.16.${i}.4 $FS_PORT
        done

        #throw dns exploits
        for file in ./exploit_dns/*.py; do
            python $file 172.16.${i}.6 $DNS_PORT
        done
        for file in ./exploit_dns/*.sh; do
            bash $file 172.16.${i}.6 $DNS_PORT
        done

        #throw email exploits
        for file in ./exploit_smtp/*.py; do
            python $file 172.16.${i}.8 $SMTP_PORT
        done
        for file in ./exploit_smtp/*.sh; do
            bash $file 172.16.${i}.8 $SMTP_PORT
        done

        #throw DBMS exploits
        for file in ./exploit_dbms/*.py; do
            python $file 172.16.${i}.9 $DBMS_PORT
        done
        for file in ./exploit_dbms/*.sh; do
            bash $file 172.16.${i}.9 $DBMS_PORT
        done
    done
    sleep 300
done