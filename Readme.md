## OpenInfra Summit Vancouver 2023 StarlingX
### Project Workspaces

Login to the controller node: See [StarlingX Target List](jumphost-setup/jumphost-targets.md) for ***Port numbers***

```
ssh sysadmin@147.75.35.13 -p <SSH PROXY PORT> cat /etc/build.info
Password: St8rlingX*
```
---
#### AIO-Simplex
[StarlingX AIO-SX Install Guide](https://docs.starlingx.io/r/stx.8.0/deploy_install_guides/release/bare_metal/aio_simplex_install_kubernetes.html)

Install and bootstrap overview:
1. Prep the node for Installation<br/>
2. Install StarlingX on node<br/>
3. Bootstrap controller node<br/>
  3.1 Create localhost.yml override file<br/>
  3.2 Run ansible-playbook<br/>
4. Configure controller node<br/>
5. Unlock controller node<br/>

For the purpose of time, steps 1 and 2 have been completed.

### Bootstraping

***You must be sysadmin***
	
The ansible bootstrap process checks the /home/sysadmin/loclhost.yml for the override values (more on this after we start the ansible-playbook). Make sure this file exists on your controller and then run the playbook.

```
export ANSIBLE_LOG_PATH=~/ansible_$(date "+%Y%m%d%H%M%S").log
time ansible-playbook /usr/share/ansible/stx-ansible/playbooks/bootstrap.yml
```

Expected results:

```
real    33m1.924s
user    14m28.441s
sys     1m43.510s
...
PLAY RECAP *********************************************************************
localhost                  : ok=465  changed=261  unreachable=0    failed=0    skipped=446  rescued=0    ignored=0   

Tuesday 13 June 2023  00:20:38 +0000 (0:00:00.457)       0:33:39.459 ********** 
=============================================================================== 
bootstrap/persist-config : Wait for service endpoints reconfiguration to complete - 381.91s
bootstrap/apply-manifest : Applying puppet bootstrap manifest --------- 374.91s
bootstrap/bringup-essential-services : Wait for 120 seconds to ensure kube-system pods are all started - 120.55s
bootstrap/bringup-essential-services : Load image from archive /opt/platform-backup/22.12/container-image1.tar.gz - 119.67s
bootstrap/persist-config : Wait for sysinv inventory ------------------- 62.54s
bootstrap/bringup-bootstrap-applications : Wait until application is in the applied state -- 58.70s
bootstrap/persist-config : Find old registry secrets in Barbican ------- 51.77s
bootstrap/bringup-essential-services : Load image from archive /opt/platform-backup/22.12/container-image2.tar.gz -- 46.83s
bootstrap/validate-config : Generate config ini file for python sysinv db population script -- 37.56s
bootstrap/bringup-bootstrap-applications : Wait until application is in the applied state -- 32.71s
bootstrap/bringup-bootstrap-applications : pause ----------------------- 30.02s
bootstrap/bringup-essential-services : Check controller-0 is in online state -- 20.44s
bootstrap/bringup-essential-services : Add loopback interface ---------- 19.91s
bootstrap/persist-config : Saving config in sysinv database ------------ 19.90s
bootstrap/bringup-bootstrap-applications : Save the current system and network config for reference in subsequent replays -- 19.66s
common/fluxcd-controllers : Get wait tasks results --------------------- 13.86s
common/bringup-kubemaster : Initializing Kubernetes master ------------- 13.61s
bootstrap/persist-config : Restart sysinv-agent and sysinv-api to pick up sysinv.conf update -- 12.20s
bootstrap/bringup-essential-services : Load image from archive /opt/platform-backup/22.12/container-image3.tar.gz -- 11.44s
bootstrap/bringup-essential-services : Pause a few seconds for docker to clean up its temp directory -- 10.02s
```



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
  - kubernetesui/dashboard:v2.7.0
  - kubernetesui/metrics-scraper:v1.0.8
```



### Configure controller-0

In this step we will configure the node for the hands-on labs. To this end, we will configure the system with Persistent storage, and isolated CPU's.<br/>
#### Step 0: OAM network address


Source the environment: ` source /etc/platform/openrc`

Determine the OAM interface: `ip -6 r  | grep ^default`<br/>
Identify OAM Interface: `default via 2604:1380:4642:a300::151 dev enp1s0f0 metric 1024 onlink pref medium`

***Next, assign network interface to OAM network***
```
OAMIF=enp1s0f0

system host-if-modify controller-0 $OAMIF -n oam0 -c platform
system interface-network-assign controller-0 oam0 oam
system ntp-modify ntpservers=0.pool.ntp.org,1.pool.ntp.org
```

#### Unlock controller

```
[sysadmin@controller-0 ~(keystone_admin)]$ system host-unlock controller-0
+------------------------+---------------------------------------------+
| Property               | Value                                       |
+------------------------+---------------------------------------------+
| action                 | none                                        |
| administrative         | locked                                      |
| apparmor               | disabled                                    |
| availability           | online                                      |
| bm_ip                  | None                                        |
| bm_type                | none                                        |
| bm_username            | None                                        |
| boot_device            | /dev/disk/by-path/pci-0000:00:17.0-ata-1.0  |
| capabilities           | {'is_max_cpu_configurable': 'configurable'} |
| clock_synchronization  | ntp                                         |
| config_applied         | 56f0f83e-d506-42d4-8563-6392d6fde791        |
| config_status          | None                                        |
| config_target          | d7d4468a-6c00-469d-b994-1dbc1c58e11f        |
| console                | ttyS1,115200                                |
| created_at             | 2023-06-12T23:56:47.063443+00:00            |
| device_image_update    | None                                        |
| hostname               | controller-0                                |
| id                     | 1                                           |
| install_output         | graphical                                   |
| install_state          | None                                        |
| install_state_info     | None                                        |
| inv_state              | inventoried                                 |
| invprovision           | provisioning                                |
| location               | {}                                          |
| max_cpu_mhz_allowed    | 5000                                        |
| max_cpu_mhz_configured | None                                        |
| mgmt_ip                | fd00:4888:2000:1090::b                      |
| mgmt_mac               | 00:00:00:00:00:00                           |
| operational            | disabled                                    |
| personality            | controller                                  |
| reboot_needed          | False                                       |
| reserved               | False                                       |
| rootfs_device          | /dev/disk/by-path/pci-0000:00:17.0-ata-1.0  |
| serialid               | None                                        |
| software_load          | 22.12                                       |
| subfunction_avail      | online                                      |
| subfunction_oper       | disabled                                    |
| subfunctions           | controller,worker,lowlatency                |
| task                   | Unlocking                                   |
| tboot                  |                                             |
| ttys_dcd               | False                                       |
| updated_at             | 2023-06-13T03:43:43.538745+00:00            |
| uptime                 | 14384                                       |
| uuid                   | 9104025f-8697-4ad0-99ed-e88a3401d5c9        |
| vim_progress_status    | None                                        |
+------------------------+---------------------------------------------+
```

Unlocking the host will reboot the system and apply the configuration. 

---

- [StarlingX Management overview](AIO-SX-On-Equinix/Familiarization-of-StarlingX-Management.md)
- [Cyclic Test](AIO-SX-On-Equinix/app-cyclictest.md)
- [StarlingX Hello World](AIO-SX-On-Equinix/app-hello-starlingx.md)
- [Kubernetes Dashboard](AIO-SX-On-Equinix/app-kubernetes-dashboard.md)
- [Persistent Storage](AIO-SX-On-Equinix/app-hello-persistent-storage.md)
- [Install Matrix Server](https://docs.starlingx.io/admintasks/kubernetes/kubernetes-admin-tutorials-metrics-server.html)
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
