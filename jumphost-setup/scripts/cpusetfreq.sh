#!/bin/bash

expect -d << EOD
set timeout 600
spawn sudo bash
expect "*Password: " { send "St8rlingX*\r" ;}
expect "root*:/var/home/sysadmin# " { send "pwd\r" ;}
expect "root*:/var/home/sysadmin# " { send "cpupower frequency-set -u 2500000 > /dev/null\r"}
expect "root*:/var/home/sysadmin# " { send "exit\r" }
EOD
rm -f $0
