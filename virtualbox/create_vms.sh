#!/bin/bash

# 01_create_vms.txt - create VMs for basic demo (3 nodes)

set -x -e
source common.sh

#
# setupController -- Setup a controller
# Parameters: controller name
#
# ie setupController "controller-0" "mgmt_nic" "oam_nic"
#
setupController ()
{
    CONTROLLER=$1
    MGMT_NIC=$2
    OAM_NIC=$3

	if [ -f "${VIRTUAL_BOX_STORAGE}/${CONTROLLER}" ]; then
		echo "Error ${CONTROLLER} already exists please remove the old controller"
		return -1
	fi


	VBoxManage createvm --name "${CONTROLLER}" --register
	VBoxManage modifyvm "${CONTROLLER}" --ostype Linux_64 --memory ${CONTROLLER_MEMORY} \
        	--cpus ${CONTROLLER_CPUS} --ioapic on --vram 16
	VBoxManage modifyvm "${CONTROLLER}" --uart1 0x3f8 4 --uartmode1 server /tmp/${CONTROLLER}_serial
	# OAM Network
	VBoxManage modifyvm "${CONTROLLER}" --nic1 nat \
    	--nictype1 82540EM --nicpromisc2 Deny

	# Setup nat rules for local machine to connect (ssh -p 2221
	# sysadmin@localhost
	vboxmanage modifyvm "${CONTROLLER}" --natpf1 "ssh,tcp,,2221,,22"
	vboxmanage modifyvm "${CONTROLLER}" --natpf1 "http,tcp,,8181,,8080"
	vboxmanage modifyvm "${CONTROLLER}" --natpf1 "kubedashboard,tcp,,31000,,30000"

	#MGMT Network
    VBoxManage modifyvm "${CONTROLLER}" --audio none
    VBoxManage modifyvm "${CONTROLLER}" --x2apic on
    VBoxManage modifyvm "${CONTROLLER}" --largepages on
    VBoxManage modifyvm "${CONTROLLER}" --rtcuseutc on

    VBoxManage modifyvm "${CONTROLLER}" --chipset ich9
        
    VBoxManage storagectl "${CONTROLLER}" --name "storagectl-0" --add sata --controller IntelAhci --hostiocache on --portcount 2

    VBoxManage createhd --filename "${VIRTUAL_BOX_STORAGE}/${CONTROLLER}/${CONTROLLER}_disk-0.vdi" \
    	--size ${CONTROLLER_STORAGE_DISK0}
	VBoxManage storageattach "${CONTROLLER}" --storagectl "storagectl-0" --port 0 --device 0 \
    	--type hdd --medium "${VIRTUAL_BOX_STORAGE}/${CONTROLLER}/${CONTROLLER}_disk-0.vdi" \
    	--nonrotational on

	# if not using storage nodes, a secondary disk must be created
	VBoxManage createhd --filename "${VIRTUAL_BOX_STORAGE}/${CONTROLLER}/${CONTROLLER}_disk-1.vdi" \
    	--size ${CONTROLLER_STORAGE_DISK1}

	VBoxManage storageattach "${CONTROLLER}" --storagectl "storagectl-0" --port 1 --device 0 \
    	--type hdd --medium "${VIRTUAL_BOX_STORAGE}/${CONTROLLER}/${CONTROLLER}_disk-1.vdi" \
    	--nonrotational on

	return 0
}

#
# setupController
#
setupController0 ()
{
	################################################################################
	## Controller 0: Required
	##
	################################################################################
	setupController "${CONTROLLER_0}" "${CONTROLLER0_MGMT_NIC}" "${CONTROLLER0_OAM_NIC}"
	if [ $? -ne 0 ]; then
		return -1
	fi

	VBoxManage storagectl "${CONTROLLER_0}" --name "storagectl-1" --add ide --controller PIIX4 --portcount 2
	VBoxManage storageattach "${CONTROLLER_0}" --storagectl "storagectl-1" --port 0 --device 0 \
       	--type dvddrive --medium "${SERVER_ISO}"
	VBoxManage modifyvm "${CONTROLLER_0}" --nicbootprio1 1 --boot1 disk --boot2 dvd \
     	--boot3 net --boot4 none

	return 0
}

### Main beginning ###
if [ ! -z ${DEBUG} ]; then
	set -x
fi

if [ ! -f ${SERVER_ISO} ]; then
	echo "Can't find installation ISO please set SERVER_ISO in common.sh"
	exit -1
fi

if [ ! -d ${VIRTUAL_BOX_STORAGE} ]; then
  mkdir -p ${VIRTUAL_BOX_STORAGE}
fi

setupController0

if [ ! -z ${XEON_WORKAROUND} ]; then
	echo "Setting the Xeon workaround"
	VBoxManage setextradata ${CONTROLLER_0} VBoxInternal/CPUM/EnableHVP 1
fi
if [ ! -z ${DEBUG} ]; then
	set +x
fi
