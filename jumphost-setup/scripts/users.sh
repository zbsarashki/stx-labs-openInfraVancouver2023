#!/bin/bash


# St8rlingX*
PASSWORD='$y$j9T$gOZf9fDyFCthDLvXT.9w10$jk3xTFB/U2z8nd5rab.v60lVi0lpeD96xAOouElhxE3'

for f in $(seq 0 20); do 
	useradd -s /bin/bash -m -p "$PASSWORD"  user$f
done

