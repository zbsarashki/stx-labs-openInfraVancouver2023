# OpenInfra Summit Vancouver 2023 StarlingX


## Getting Started

For this hands on the machines have been pre-installed in order to save time.  The image we used is located at the [StarlingX Mirror Sites](http://mirror.starlingx.cengn.ca/mirror/starlingx/release/).

### Validate access to a machine


Login to the node from ***IPv4*** address: See [StarlingX Target List](jumphost-setup/jumphost-targets.md) for IPv4  ***Port numbers***

```
ssh sysadmin@147.75.35.13 -p <SSH PROXY PORT> cat /etc/build.info
Password: St8rlingX*
```


---

## AIO-Simplex Steps
The [StarlingX AIO-SX Install Guide](https://docs.starlingx.io/r/stx.8.0/deploy_install_guides/release/bare_metal/aio_simplex_install_kubernetes.html) provides details for installing an AIO SX.  The steps required are listed below.

Steps :

1. Prep the node for Installation<br/>
2. Install StarlingX on Controller-0<br/>
3. Bootstrap Controller-0<br/>
  3.1. Create localhost.yml override file<br/>
  3.2. Run ansible-playbook<br/>
4. Configure Controller-0<br/>
5. Unlock Controller-0<br/>

**For the purpose of time, steps 1 and 2 have been completed.**

### From the Controller, Bootstrap the system

>NOTE: You must be `sysadmin` the password is `St8rlingX*`
	
The ansible bootstrap process checks the /home/sysadmin/loclhost.yml for the override values
 (more on this after we start the ansible-playbook). Make sure this file exists on your controller and then run the playbook.

```
export ANSIBLE_LOG_PATH=~/ansible_$(date "+%Y%m%d%H%M%S").log
time ansible-playbook /usr/share/ansible/stx-ansible/playbooks/bootstrap.yml
```

#### Bootstrap Expected results:

Below is the final output of the playbook.  Note 0 failed plays

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

### About the ansible override file: /home/sysadmin/localhost.yml

This file overrides default values found in `/usr/share/ansible/stx-ansible/playbooks/host_vars/bootstrap/default.yml`. 
For the purposes of this workshop, we are overriding system and network properties anything in the `default.yml` file can be overridden in the localhost.yml file.  
By default the localhost.yml file is expected to be in the `/home/sysadmin` directory.

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

### From the Controller, Configure controller-0

In this step we will configure the node for the hands-on labs. To this end, we will configure the system with Persistent storage, and isolated CPU's.<br/>

#### From the Controller, Configure the OAM network address
For a AIO Simplex the [networking](https://docs.starlingx.io/planning/kubernetes/networks-for-a-simplex-system.html)  is very simple.  All that is required to define is the OAM.  The MGMT and Cluster host are automatically assigned to the loopback interface.

- Source the environment: ` source /etc/platform/openrc`

- Determine the OAM device interface: 
```
ip -6 r  | grep ^default
default via 2604:1380:4642:a300::151 dev enp1s0f0 metric 1024 onlink pref medium
```

**Use the above output to set the OAMIF below**

- Assign network interface to OAM network

```
OAMIF=enp1s0f0

system host-if-modify controller-0 $OAMIF -n oam0 -c platform
system interface-network-assign controller-0 oam0 oam
system ntp-modify ntpservers=0.pool.ntp.org,1.pool.ntp.org
```

#### Unlock controller

Unlocking the host will reboot the system and apply the configuration provided.  

>NOTE: In other scenarios more configuration can be applied before the unlock.  For example configuration data networks, huge pages, persistent storage, and CPU isolated cores.

```
system host-unlock controller-0
```

#### Verify the System us unlocked and in a good state

> NOTE: This will take a few minutes after the reboot to finish initializing

```
source /etc/platform/openrc
system host-list
```

##### Expected output
```
+----+--------------+-------------+----------------+-------------+--------------+
| id | hostname     | personality | administrative | operational | availability |
+----+--------------+-------------+----------------+-------------+--------------+
| 1  | controller-0 | controller  | unlocked       | enabled     | available    |
+----+--------------+-------------+----------------+-------------+--------------+
```

### Verify the system is alarm free

> If alarms exist the `fm alarm-list` command will follow up with the alarms.  If no alarms are present nothing will show.

```
source /etc/platform/openrc
fm alarm-list

```

### See what kubernetes pods are running

```
kubectl get pods -A
```

#### Expected Output

```
NAMESPACE      NAME                                             READY  STATUS   RESTARTS      AGE
armada         armada-api-5547f9c8d5-qd9pd                      2/2    Running  2 (6d7h ago)  6d7h
cert-manager   cm-cert-manager-6c47f6d6f5-9hcgh                 1/1    Running  1 (6d7h ago)  6d7h
cert-manager   cm-cert-manager-cainjector-6f8dc8f64d-wjktw      1/1    Running  1 (6d7h ago)  6d7h
cert-manager   cm-cert-manager-webhook-556b7d64d8-ph6s7         1/1    Running  1 (6d7h ago)  6d7h
flux-helm      helm-controller-759b895dbb-chbrb                 1/1    Running  1 (6d7h ago)  6d7h
flux-helm      source-controller-7f4bb65f88-gs7xg               1/1    Running  1 (6d7h ago)  6d7h
kube-system    calico-kube-controllers-567d594786-qsbv2         1/1    Running  1 (6d7h ago)  6d7h
kube-system    calico-node-dvmbr                                1/1    Running  1 (6d7h ago)  6d7h
kube-system    coredns-78dd5d75bd-bhncn                         1/1    Running  1 (6d7h ago)  6d7h
kube-system    ic-nginx-ingress-ingress-nginx-controller-s6jpg  1/1    Running  1 (6d7h ago)  6d7h
kube-system    kube-apiserver-controller-0                      1/1    Running  1 (6d7h ago)  6d7h
kube-system    kube-controller-manager-controller-0             1/1    Running  1 (6d7h ago)  6d7h
kube-system    kube-multus-ds-amd64-d2t4j                       1/1    Running  1 (6d7h ago)  6d7h
kube-system    kube-proxy-tbklg                                 1/1    Running  1 (6d7h ago)  6d7h
kube-system    kube-scheduler-controller-0                      1/1    Running  1 (6d7h ago)  6d7h
kube-system    kube-sriov-cni-ds-amd64-fzzqd                    1/1    Running  1 (6d7h ago)  6d7h
```

## Next Exercises
---
- [StarlingX Management overview](AIO-SX-On-Equinix/Familiarization-of-StarlingX-Management.md)
- [Cyclic Test](AIO-SX-On-Equinix/app-cyclictest.md)
- [StarlingX Hello World](AIO-SX-On-Equinix/app-hello-starlingx.md)
- [Kubernetes Dashboard](AIO-SX-On-Equinix/app-kubernetes-dashboard.md)
- [Persistent Storage](AIO-SX-On-Equinix/app-hello-persistent-storage.md)
- [Install Matrix Server](https://docs.starlingx.io/admintasks/kubernetes/kubernetes-admin-tutorials-metrics-server.html)
---

## Exercises for Home
---
- Running StarlingX on [libvirt](libvirt/README.md) 
- Running StarlingX on [virtualbox](virtualbox/readme.md)
---


## Hands On Setup
---
1) Equinix Metal [starlingX hands-on Workspace setup](equinix-metal-setup/using_equinix_metal.md)
2) Access [StarlingX Targets](jumphost-setup/jumphost-targets.md) through [Jumphost](jumphost-setup/jump-host.md)
4) To Install on equinix-metal see [StarlingX on Demand Metal](equinix-metal-setup/EquinixStarlingX.md)
