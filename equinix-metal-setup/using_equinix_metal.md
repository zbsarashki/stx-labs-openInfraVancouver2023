# <p style="text-align: center;">OpenInfra Summit<br/>Vancouver  2023<br/>StarlingX Hands-on Lab<br/>Open Infrastructure Project Workspaces<br/><br/>Using Equinix Metal</p>

---

StarlingX installation on Equinix Metal requires custom-ipxe setup. To this end, an invitation email to join the project has been sent out from support@equninix.com. Once the invitation is accepted, login and add your ssh-key to the project. Thereafter, povision two systems:

0) One c3.small.x86 with debian/ubuntu for ipxe
1) One c3.small.x86 for the StarlingX AIO-Simplex target.

Follow the procedure outlined below to create and account and create the two on demand servers. We will use these systems through the handson. 

---
1) Create [Equinix account and add ssh pub keys](EquinixAccountSSHPUBs.md)<br/>
2) Create [Debian on Demand Metal](IPXEServer.md) and setup ipxe server with StarlingX8<br/>
3) Create on [StarlingX on Demand Metal](EquinixStarlingX.md)<br/>

[Prev](../Readme.md)
