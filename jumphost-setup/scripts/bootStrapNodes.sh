#!/bin/bash

scpp='sshpass -p St8rlingX* scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '
sshp='sshpass -p St8rlingX* ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '

for i in $(seq 18 18); do
	./scripts/bootStrapOneNode.sh $i &
	sleep 1;
done
