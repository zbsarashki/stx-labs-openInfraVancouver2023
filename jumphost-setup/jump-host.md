# JumpHost 

---

JumpHost is at: 147.75.35.13<br/>
For target list and access to targets see: [StarlingX TargetList](jumphost-targets.md)

---

This machine has been setup to serve as JumpHost, [IPXE server](../equinix-metal-setup/IPXEServer.md)  , virtualization host, see [AIO-sx instance](../libvirt/README.md), and performs the initial target setup for the hands on.


---

The JumpHost:/var/www/html has the following directory Structure:

```
.
├── hosts
├── jump-host.md
├── jumphost-targets.md
├── nodes
│   ├── ............. 
├── overrides
│   ├── ............. 
└── scripts
    ├── prepNode.sh
	├── setPassword.exp
	├── setupNodes.sh
	├── setupOneNode.sh
	├── socat.sh
	├── sourceme.sh
	└── users.sh
```

***Where:***<br/>
***nodes/:***		Network interface config files.<br/>
***overrides/:***	Localhost Override files<br/>
***scripts/:***		Helper scripts to perform initial host-level configuration including prestaging and bootstrapping<br/>
***hosts:*** Target IP's


## Tasks performed by the jump host:

### Prestaging

StarlingX allows [prestaging](https://docs.starlingx.io/dist_cloud/kubernetes/prestage-a-subcloud-using-dcmanager-df756866163f.html) of nodes with software packages and container image archives that are required for the deployment.  This is the typical installation mode for sub-clouds and starts by updating the default Install Media with update-iso.sh tool. The resultant media is then used to pre-install the sub-clouds. Its main purpose is to speed up the deployment process.

### Network Configuration

Configures targets for IPV6 from Interface Configuration files under nodes/

### Configuration Override file

Copies user configuration overrides for the Ansible bootstrap playbook to sysadmin home directory on the target. This file overrides default values found in /usr/share/ansible/stx-ansible/playbooks/host_vars/bootstrap/default.yml.

### Bootstrap

Bootstraps target but does not complete the deployment. Deployment of the target is left as an exercise.

[Prev](../Readme.md)

