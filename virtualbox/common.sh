#
#Modify to point to your ISO installation
#
export SERVER_ISO="./starlingx-intel-x86-64-cd.iso"

#Modify to point to your Virtual Storage Location.
export VIRTUAL_BOX_STORAGE="/Users/eraineri/VirtualBoxVMs/"

#Names of the VMS created.  Modify based on your needs.
export CONTROLLER_0="STX8-AIOSX"

#uncomment if running on a Xeon and you are having an issue with
# the installer
#export XEON_WORKAROUND=1

#
# From here down edit at will but not required this defaults to a basic
# install
#


# Min is 5
export CONTROLLER_CPUS=5
export CONTROLLER_MEMORY=8192
export CONTROLLER_STORAGE_DISK0=$((512*1024))
export CONTROLLER_STORAGE_DISK1=$((256*1024))

#used to turn on the set -x commands for each script.
#export DEBUG=yes
