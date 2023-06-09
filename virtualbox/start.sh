#!/bin/bash

set -x -e
source common.sh

# Use this for serial console
VBoxManage startvm ${CONTROLLER_0} --type headless
socat UNIX-CONNECT:/tmp/${CONTROLLER_0}_serial stdio,raw,echo=0,icanon=0,escape=0x11

# Use this for standard console
#VBoxManage startvm $CONTROLLER_0
