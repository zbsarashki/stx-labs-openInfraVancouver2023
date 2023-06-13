# AIO-Simplex

Install and bootstrap overview:
1. Prep the node for Installation<br/>
2. Install StarlingX on node<br/>
3. Bootstrap the controller node<br/>
  3.1 Create the override file<br/>
  3.2 Bootstrap the system<br/>
4. Configure the controller node<br/>
5. Unlock the controller node<br/>

For the purpose of time, steps 1 through 2 have been completed and we will start with step 3. But first, let's go over the ansible override file.

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


### Bootstraping

***You must be sysadmin***
	
To bootstrap the node, ensure the above override file exists in sysadmin home directory and issue:

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


### Configure controller-0

In this step we will configure the node for the hands-on labs. To this end, we will configure the system with Persistent storage, and isolated CPU's.<br/>
See [StarlingX Target List](../jumphost-setup/jumphost-targets.md) for ***Port numbers***
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

***Persistent Storage backend:***

```
bash$ source /etc/platform/openrc
[sysadmin@controller-0 ~(keystone_admin)]$ system storage-backend-add ceph --confirmed
+..+------------+---------+-------------+-----------------------+----------+---------------+
|..| name       | backend | state       | task                  | services | capabilities  |
+..+------------+---------+-------------+-----------------------+----------+---------------+
|..| ceph-store | ceph    | configuring | {'controller-0':      | None     | replication:  |
|..|            |         |             | 'applying-manifests'} |          | 1 min_replica |
|..|            |         |             |                       |          | tion: 1       |
|..|            |         |             |                       |          |               |
+..+------------+---------+-------------+-----------------------+----------+---------------+
```


***Add OSD:*** Identify available disk for storage 

```
[sysadmin@controller-0 ~(keystone_admin)]$ system host-disk-list controller-0
+--------------------------------------+-------------+..+----------+---------------+..+
| uuid                                 | device_node |..| size_gib | available_gib |..|
+--------------------------------------+-------------+..+----------+---------------+..+
| 105b851a-d8b5-4c8d-be0d-751e28d0166f | /dev/sda    |..| 447.13   | 0.0           |..|
| ab3c393c-153b-405e-8173-7ad1c0a4e017 | /dev/sdb    |..| 447.13   | 447.127       |..|
+--------------------------------------+-------------+..+----------+---------------+..+
```

Disk /dev/sdb with UUID=ab3c393c-153b-405e-8173-7ad1c0a4e017 is available with 447Gib.


```
UUID=ab3c393c-153b-405e-8173-7ad1c0a4e017
system host-stor-add controller-0 osd $UUID
```

We select disk /dev/sdb with UUID=ab3c393c-153b-405e-8173-7ad1c0a4e017 for persistent storage.

```
+------------------+--------------------------------------------------+
| Property         | Value                                            |
+------------------+--------------------------------------------------+
| osdid            | 0                                                |
| function         | osd                                              |
| state            | configuring                                      |
| journal_location | 97ec02f0-8e16-4f10-8778-7e9c6b96c90a             |
| journal_size_gib | 1024                                             |
| journal_path     | /dev/disk/by-path/pci-0000:00:17.0-ata-2.0-part2 |
| journal_node     | /dev/sdb2                                        |
| uuid             | 97ec02f0-8e16-4f10-8778-7e9c6b96c90a             |
| ihost_uuid       | 9104025f-8697-4ad0-99ed-e88a3401d5c9             |
| idisk_uuid       | ab3c393c-153b-405e-8173-7ad1c0a4e017             |
| tier_uuid        | 90282b73-0230-4d8d-9637-907c86e855f7             |
| tier_name        | storage                                          |
| created_at       | 2023-06-13T04:25:14.773160+00:00                 |
| updated_at       | None                                             |
+------------------+--------------------------------------------------+
```


---
### IsolatedCPUs

StarlingX supports isolating CPU cores through the isolcpu kernel command line. This is best suited for vRAN uses-cases such as Intel's FlexRAN and NVIDIA's AerialSDK, among others. In this segment we will Isolate a number of CPU's.


```
[sysadmin@controller-0 ~(keystone_admin)]$ system host-cpu-list controller-0
+------...---+-------+-----------+-------+--------+---------...------------+-------------------+
| uuid ...   | log_c | processor | phy_c | thread | processo...            | assigned_function |
|      ...   | ore   |           | ore   |        |         ...            |                   |
+------...---+-------+-----------+-------+--------+---------...------------+-------------------+
| bd668...70 | 0     | 0         | 0     | 0      | Intel(R)...  @ 3.40GHz | Platform          |
| 2b3c2...15 | 1     | 0         | 1     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| 56eff...af | 2     | 0         | 2     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| 0abc1...0b | 3     | 0         | 3     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| ea4c0...b5 | 4     | 0         | 4     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| e6082...ad | 5     | 0         | 5     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| 33f3d...ed | 6     | 0         | 6     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| 59677...74 | 7     | 0         | 7     | 0      | Intel(R)...  @ 3.40GHz | Application       |
| 362cc...51 | 8     | 0         | 0     | 1      | Intel(R)...  @ 3.40GHz | Platform          |
| bf866...11 | 9     | 0         | 1     | 1      | Intel(R)...  @ 3.40GHz | Application       |
| 2d43d...d0 | 10    | 0         | 2     | 1      | Intel(R)...  @ 3.40GHz | Application       |
| 8063c...e6 | 11    | 0         | 3     | 1      | Intel(R)...  @ 3.40GHz | Application       |
| 134cf...78 | 12    | 0         | 4     | 1      | Intel(R)...  @ 3.40GHz | Application       |
| 45d24...7e | 13    | 0         | 5     | 1      | Intel(R)...  @ 3.40GHz | Application       |
| 9d262...d1 | 14    | 0         | 6     | 1      | Intel(R)...  @ 3.40GHz | Application       |
| 222b1...57 | 15    | 0         | 7     | 1      | Intel(R)...  @ 3.40GHz | Application       |
+------...---+-------+-----------+-------+--------+---------...------------+-------------------+
```


#### Isolate 4 CPU Cores

##### Lock the host

```
system host-lock controller-0
```
##### Wait until node is locked
```
[sysadmin@controller-0 ~(keystone_admin)]$ system host-list
+----+--------------+-------------+----------------+-------------+--------------+
| id | hostname     | personality | administrative | operational | availability |
+----+--------------+-------------+----------------+-------------+--------------+
| 1  | controller-0 | controller  | locked         | disabled    | online       |
+----+--------------+-------------+----------------+-------------+--------------+
```
```
~(keystone_admin)]$ system host-cpu-modify controller-0 -f application-isolated -p0 4
+------...---+-------+-----------+-------+--------+---------...------------+----------------------+
| uuid ...   | log_c | processor | phy_c | thread | processo...            | assigned_function    |
|      ...   | ore   |           | ore   |        |         ...            |                      |
+------...---+-------+-----------+-------+--------+---------...------------+----------------------+
| bd668...70 | 0     | 0         | 0     | 0      | Intel(R)...  @ 3.40GHz | Platform             |
| 2b3c2...15 | 1     | 0         | 1     | 0      | Intel(R)...  @ 3.40GHz | Application-isolated |
| 56eff...af | 2     | 0         | 2     | 0      | Intel(R)...  @ 3.40GHz | Application-isolated |
| 0abc1...0b | 3     | 0         | 3     | 0      | Intel(R)...  @ 3.40GHz | Application-isolated |
| ea4c0...b5 | 4     | 0         | 4     | 0      | Intel(R)...  @ 3.40GHz | Application-isolated |
| e6082...ad | 5     | 0         | 5     | 0      | Intel(R)...  @ 3.40GHz | Application          |
| 33f3d...ed | 6     | 0         | 6     | 0      | Intel(R)...  @ 3.40GHz | Application          |
| 59677...74 | 7     | 0         | 7     | 0      | Intel(R)...  @ 3.40GHz | Application          |
| 362cc...51 | 8     | 0         | 0     | 1      | Intel(R)...  @ 3.40GHz | Platform             |
| bf866...11 | 9     | 0         | 1     | 1      | Intel(R)...  @ 3.40GHz | Application-isolated |
| 2d43d...d0 | 10    | 0         | 2     | 1      | Intel(R)...  @ 3.40GHz | Application-isolated |
| 8063c...e6 | 11    | 0         | 3     | 1      | Intel(R)...  @ 3.40GHz | Application-isolated |
| 134cf...78 | 12    | 0         | 4     | 1      | Intel(R)...  @ 3.40GHz | Application-isolated |
| 45d24...7e | 13    | 0         | 5     | 1      | Intel(R)...  @ 3.40GHz | Application          |
| 9d262...d1 | 14    | 0         | 6     | 1      | Intel(R)...  @ 3.40GHz | Application          |
| 222b1...57 | 15    | 0         | 7     | 1      | Intel(R)...  @ 3.40GHz | Application          |
+------...---+-------+-----------+-------+--------+---------...------------+----------------------+

```

#### Assign labels for Kubernetes scheduler

```
[sysadmin@controller-0 ~(keystone_admin)]$ system host-label-assign controller-0 kube-cpu-mgr-policy=static
+-------------+--------------------------------------+
| Property    | Value                                |
+-------------+--------------------------------------+
| uuid        | e02919fc-bb50-421d-96e6-7cea0eb04f9b |
| host_uuid   | 9104025f-8697-4ad0-99ed-e88a3401d5c9 |
| label_key   | kube-cpu-mgr-policy                  |
| label_value | static                               |
+-------------+--------------------------------------+
[sysadmin@controller-0 ~(keystone_admin)]$ system host-label-assign controller-0 kube-topology-mgr-policy=restricted
+-------------+--------------------------------------+
| Property    | Value                                |
+-------------+--------------------------------------+
| uuid        | 1d87c290-0963-42e5-9116-5752bcbc2d66 |
| host_uuid   | 9104025f-8697-4ad0-99ed-e88a3401d5c9 |
| label_key   | kube-topology-mgr-policy             |
| label_value | restricted                           |
+-------------+--------------------------------------+
```

#### Unlock the host
```
[sysadmin@controller-0 ~(keystone_admin)]$ system host-unlock controller-0
+------------------------+----------------------------------------------
| Property               | Value                                        
+------------------------+----------------------------------------------
| action                 | none                                         
| administrative         | locked                                       
| apparmor               | disabled                                     
| availability           | online                                       
| bm_ip                  | None                                         
| bm_type                | none                                         
| bm_username            | None                                         
| boot_device            | /dev/disk/by-path/pci-0000:00:17.0-ata-1.0   
| capabilities           | {'is_max_cpu_configurable': 'configurable',
|                        |'stor_function': 'monitor'} 
| clock_synchronization  | ntp                                          
| config_applied         | 4dc646b6-9601-4cf4-8d15-17f804c1578d         
| config_status          | None                                         
| config_target          | 4dc646b6-9601-4cf4-8d15-17f804c1578d         
| console                | ttyS1,115200                                 
| created_at             | 2023-06-12T23:56:47.063443+00:00             
| device_image_update    | None                                         
| hostname               | controller-0                                 
| id                     | 1                                            
| install_output         | graphical                                    
| install_state          | None                                         
| install_state_info     | None                                         
| inv_state              | inventoried                                  
| invprovision           | provisioned                                  
| location               | {}                                           
| max_cpu_mhz_allowed    | 5000                                         
| max_cpu_mhz_configured | None                                         
| mgmt_ip                | fd00:4888:2000:1090::b                       
| mgmt_mac               | 00:00:00:00:00:00                            
| operational            | disabled                                     
| personality            | controller                                   
| reboot_needed          | False                                        
| reserved               | False                                        
| rootfs_device          | /dev/disk/by-path/pci-0000:00:17.0-ata-1.0   
| serialid               | None                                         
| software_load          | 22.12                                        
| subfunction_avail      | online                                       
| subfunction_oper       | disabled                                     
| subfunctions           | controller,worker,lowlatency                 
| task                   | Unlocking                                    
| tboot                  |                                              
| ttys_dcd               | False                                        
| updated_at             | 2023-06-13T04:40:58.816210+00:00             
| uptime                 | 2827                                         
| uuid                   | 9104025f-8697-4ad0-99ed-e88a3401d5c9         
| vim_progress_status    | services-disabled                            
+------------------------+----------------------------------------------
```
---

### Example Apps

- [Cyclic Test](app-cyclictest.md)
- [StarlingX Hello World](app-hello-starlingx.md)
- [Kubernetes Dashboard](app-kubernetes-dashboard.md)
- [Persistent Storage](app-hello-persistent-storage.md)
- [Install Matrix Server](https://docs.starlingx.io/admintasks/kubernetes/kubernetes-admin-tutorials-metrics-server.html)
