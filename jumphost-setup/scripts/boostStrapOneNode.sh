#!/bin/bash

sshp='sshpass -p St8rlingX* ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '
ANSIBLEPLAYBOOK=/usr/share/ansible/stx-ansible/playbooks/bootstrap.yml
ANSIBLECMD="ANSIBLE_LOG_PATH=~/ansible_$(date "+%Y%m%d%H%M%S").log ansible-playbook $ANSIBLEPLAYBOOK"

$sshp sysadmin@c3sxda-tc$1 time $ANSIBLECMD > logs/c3sxda-tc$1.boostrap.log
