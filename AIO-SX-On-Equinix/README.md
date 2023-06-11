# Installation and Deployment Flow

For details on simplex installation, see:
- [StarlingX on libvirt](libvirt/README.md)
- [StarlingX on virutalbox](virtualbox/reademe.md)
- And visit the [StarlingX Installation and deployment guide](https://docs.starlingx.io/deploy_install_guides/index-install-e083ca818006.html) page. 

---

For the purpose of time, both installation and initial ansible bootstrap have been completed. Next, lets go over the ansible override file. Theerefater we deploy the system.

see [Jumphost](../jumphost-setup/jump-host.md) for details on how the systems were prepared. 

### Ansible override file: /home/sysadmin/localhost.yml

This file overrides default values found in /usr/share/ansible/stx-ansible/playbooks/host_vars/bootstrap/default.yml -- system properties. So what are we overriding?

- system_mode:
- dns_servers:
- network properties
	- external_oam_subnet
	- external_oam_gateway
	- external_oam_floating_address
	- management_subnet
	- managment_start_address
	- managment_end_address
	- managment_multicast_address
	- cluster_host_subnet
	- cluster_pod_subnet
	- cluster_service_subnet
	

# Configure

# Unlock 

# Configure

# Unlock

# Labs


# Ceph configuration
