# <p style="text-align: center;">OpenInfra Summit<br/>Vancouver  2023<br/>StarlingX Hands-on Lab<br/>Open Infrastructure Project Workspaces<br/><br/></p>

Lab 0: Access the controller node: See [StarlingX Target List](jumphost-setup/jumphost-targets.md) for ***Port numbers***

```
alias scpp='sshpass -p St8rlingX* scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '
alias sshp='sshpass -p St8rlingX* ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '

sshp sysadmin@147.75.35.13 -p <SSH PROXY PORT> cat /etc/build.info
```
Expected Result:

```
SW_VERSION="22.12"
BUILD_TARGET="Host Installer"
BUILD_TYPE="Formal"
BUILD_ID="20230211T045208Z"
SRC_BUILD_ID="8"

JOB="STX_8.0_build_debian"
BUILD_BY="jenkins"
BUILD_NUMBER="9"
BUILD_HOST="starlingx_mirror"
BUILD_DATE="2023-02-11 04:52:08 +0000"
```
---

Hand-on Labs:

- [AIO-Simplex](AIO-SX-On-Equinix/README.md) installation and deployment flow

---
Left as exercise:
---
- StarlingX on [libvirt](libvirt/README.md) 
- StarlingX on [virtualbox](virtualbox/readme.md)
---
Workspace setup:
---
1) Equinix Metal [starlingX hands-on Workspace setup](equinix-metal-setup/using_equinix_metal.md)
2) Access [StarlingX Targets](jumphost-setup/jumphost-targets.md) through [Jumphost](jumphost-setup/jump-host.md)
4) To Install on equinix-metal see [StarlingX on Demand Metal](equinix-metal-setup/EquinixStarlingX.md)
