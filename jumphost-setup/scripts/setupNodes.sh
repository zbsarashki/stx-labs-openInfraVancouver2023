#!/bin/bash

for i in $(seq 19 20); do
	./scripts/setupOneNode.sh $i > logs/setupOneNode.sh.$i &
	sleep 1;
done
