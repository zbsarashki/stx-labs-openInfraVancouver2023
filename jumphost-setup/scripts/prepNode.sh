#!/bin/bash

IFFILE=$(echo ifcfg-*-$(hostname) | sed -e "s/-$(hostname)//g")
cp ifcfg-enp1s0f0-$(hostname) $IFFILE
IFFD=/etc/network/interfaces.d
BKUP=/opt/platform-backup
IPXESRV=147.75.35.13

expect -d << EOD
set timeout 600
spawn sudo bash
expect "*Password: " { send "St8rlingX*\r" ;}
expect "root*:/var/home/sysadmin# " { send "pwd\r" ;}
expect "root*:/var/home/sysadmin# " { send "cp ifcfg-*-$(hostname) $IFFD/$IFFILE\r"}
expect "root*:/var/home/sysadmin# " { send "wget http://$IPXESRV/prestageimages.tar.gz\r"}
expect "root*:/var/home/sysadmin# " { send "tar -C $BKUP -xzpf prestageimages.tar.gz\r"}
expect "root*:/var/home/sysadmin# " { send "tar -C $BKUP -xzpf $BKUP/ostree_repo.tar.gz\r"}
expect "root*:/var/home/sysadmin# " { send "rm -f $BKUP/ostree_repo.tar.gz\r"}
expect "root*:/var/home/sysadmin# " { send "rm -f prestageimages.tar.gz\r"}
expect "root*:/var/home/sysadmin# " { send "reboot\r"}
expect "root*:/var/home/sysadmin# " { send "exit\r" }
EOD
