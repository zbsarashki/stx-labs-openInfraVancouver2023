#!/bin/bash

scpp='sshpass -p St8rlingX* scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '
sshp='sshpass -p St8rlingX* ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '


scripts/setPassword.exp c3sxda-tc$1
$scpp overrides/localhost.yml-c3sxda-tc$1 sysadmin@c3sxda-tc$1:~/localhost.yml
$scpp nodes/ifcfg-*-c3sxda-tc$1 sysadmin@c3sxda-tc$1:~/
$scpp scripts/prepNode.sh  sysadmin@c3sxda-tc$1:~/
$sshp sysadmin@c3sxda-tc$1 ./prepNode.sh
$sshp sysadmin@c3sxda-tc$1 rm -f prestageimages.tar.gz
