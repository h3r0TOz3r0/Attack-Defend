#!/usr/bin/bash

## Update Box
yum check-update
yum upgrade
yum clean all

## Download required tools
yum install nano net-tools lsof bash-completion

