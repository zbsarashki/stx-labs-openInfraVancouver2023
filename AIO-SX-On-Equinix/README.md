# AIO-Simplex

Install and bootstrap overview:
1. Prep the node for Installation<br/>
2. Install StarlingX on node<br/>
3. Bootstrap the controller node<br/>
  3.1 Create the override file<br/>
  3.2 Bootstrap the system<br/>
4. Configure the controller node<br/>
5. Unlock the controller node<br/>


For details on the Equninix metal installs and bootstrap see [Jumphost](../jumphost-setup/jump-host.md).<br/>
For details on simplex installation, see:<br/>
- [StarlingX on libvirt](../libvirt/README.md)<br/>
- [StarlingX on virutalbox](../virtualbox/readme.md)<br/>
- And visit the [StarlingX Installation and deployment guide](https://docs.starlingx.io/deploy_install_guides/index-install-e083ca818006.html) page. <br/>

For the purpose of time, steps 1 through 3 have been completed and we will start with step 4. But first, let's go over the ansible override file.

### Ansible override file: /home/sysadmin/localhost.yml

This file overrides default values found in /usr/share/ansible/stx-ansible/playbooks/host_vars/bootstrap/default.yml. For the purposes of this workshop, we are overriding system and network properties.

```
system_mode: simplex
name: "c3sxda-tc9"
description: "STX8 Standalone SX"
location: "Dallas"
contact: "babak.sarashki@windriver.com"
timezone: UTC

dns_servers:
  - "2001:4860:4860::8888"
  - "2001:4860:4860::8844"

external_oam_subnet: "2604:1380:4642:a300::100/124"
external_oam_gateway_address: "2604:1380:4642:a300::101"
external_oam_floating_address: "2604:1380:4642:a300::102"

management_subnet: "fd00:4888:2000:1090::/64"
management_start_address: "fd00:4888:2000:1090::a"
management_end_address: "fd00:4888:2000:1090::ffff"
management_multicast_subnet: "ff05::18:1:0/64"

cluster_host_subnet: "fd00:4888:2000:109a::/64"
cluster_pod_subnet: "fd00:4888:2000:109b::/64"
cluster_service_subnet: "fd00:4888:2000:109b::/112"

admin_password: St8rlingX*
ansible_become_pass: St8rlingX*

additional_local_registry_images:
  - windse/cyclictest:v1.0
```


### Bootstraping
	
To bootstrap the node, place the above override file has been placed in /home/sysadmin/ and issue:

***You must be user sysadmin***
```
export ANSIBLE_LOG_PATH=~/ansible_$(date "+%Y%m%d%H%M%S").log
time ansible-playbook /usr/share/ansible/stx-ansible/playbooks/bootstrap.yml
```

The stdout of the above command has been captured and is on the [JumpHost](http://147.75.35.13/logs). This is in addition to the ansible.log file on the controller.

### LAB1: Configure controller-0

In this step we will configure the node for the hands-on labs. To this end, we will configure the system with Ceph storage, and isolated CPU's.<br/>
See [StarlingX Target List](../jumphost-setup/jumphost-targets.md) for ***Port numbers***
#### Step 0: OAM network address


Source the environment: ` source /etc/platform/openrc`

Determine the OAM interface: `ip -6 r  | grep ^default`<br/>
Identify OAM Interface: `default via 2604:1380:4642:a300::151 dev enp1s0f0 metric 1024 onlink pref medium`

***Next, assign network interface to OAM network***
```
OAMIF=enp1s0f0
C=controller-0

system host-if-modify $C $OAMIF -n oam0 -c platform
system interface-network-assign $C oam0 oam
system host-unlock $C
```

The above will reboot the system and apply the configuration. Next we will configure the system with Isolated CPU's and Ceph.

Upon reboot, [check system](check-system-upon-reboot.md) for any alarms and system status. If no errors are found, proceed with [ceph storage](ceph_storage.md) and configure the system for [isolated cpus](isolated_cpus.md).

# Labs


# Ceph configuration

# Once Installed Learn about StarlingX

Now that StarlingX is installed lets learn about [managing a StarlingX Cluster](Familiarization-of-StarlingX-Management.md)

# Example Apps

- [Cyclic Test](app-cyclictest.md)
- [StarlingX Hello World](app-hello-starlingx.md)
- [Kubernetes Dashboard](app-kubernetes-dashboard.md)
- [Persistent Strorage](app-hello-persistent-storage.md)
- [Install Metrix Server](https://docs.starlingx.io/admintasks/kubernetes/kubernetes-admin-tutorials-metrics-server.html)
