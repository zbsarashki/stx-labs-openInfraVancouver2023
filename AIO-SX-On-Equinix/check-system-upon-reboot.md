# Check system alarms and inspect system upon reboot after first unlock

```
source /etc/platform/openrc

[sysadmin@controller-0 ~(keystone_admin)]$ system host-list
+----+--------------+-------------+----------------+-------------+--------------+
| id | hostname     | personality | administrative | operational | availability |
+----+--------------+-------------+----------------+-------------+--------------+
| 1  | controller-0 | controller  | unlocked       | enabled     | available    |
+----+--------------+-------------+----------------+-------------+--------------+


[sysadmin@controller-0 ~(keystone_admin)]$ system host-show controller-0
+------------------------+-------------------------------------------------...-+
| Property               | Value                                           ... |
+------------------------+-------------------------------------------------...-+
| action                 | none                                            ... |
| administrative         | unlocked                                        ... |
| apparmor               | disabled                                        ... |
| availability           | available                                       ... |
| bm_ip                  | None                                            ... |
| bm_type                | none                                            ... |
| bm_username            | None                                            ... |
| boot_device            | /dev/disk/by-path/pci-0000:00:17.0-ata-1.0      ... |
| capabilities           | {'is_max_cpu_configurable': 'configurable', 'Per... |
|                        | Active'}                                        ... |
| clock_synchronization  | ntp                                             ... |
| config_applied         | 66d66b55-7576-4e35-8059-cea8909f0091            ... |
| config_status          | None                                            ... |
| config_target          | 66d66b55-7576-4e35-8059-cea8909f0091            ... |
| console                | ttyS1,115200                                    ... |
| created_at             | 2023-06-11T20:25:53.426857+00:00                ... |
| device_image_update    | None                                            ... |
| hostname               | controller-0                                    ... |
| id                     | 1                                               ... |
| install_output         | graphical                                       ... |
| install_state          | None                                            ... |
| install_state_info     | None                                            ... |
| inv_state              | inventoried                                     ... |
| invprovision           | provisioned                                     ... |
| location               | {}                                              ... |
| max_cpu_mhz_allowed    | 5000                                            ... |
| max_cpu_mhz_configured | None                                            ... |
| mgmt_ip                | fd00:4888:2000:1090::b                          ... |
| mgmt_mac               | 00:00:00:00:00:00                               ... |
| operational            | enabled                                         ... |
| personality            | controller                                      ... |
| reboot_needed          | False                                           ... |
| reserved               | False                                           ... |
| rootfs_device          | /dev/disk/by-path/pci-0000:00:17.0-ata-1.0      ... |
| serialid               | None                                            ... |
| software_load          | 22.12                                           ... |
| subfunction_avail      | available                                       ... |
| subfunction_oper       | enabled                                         ... |
| subfunctions           | controller,worker,lowlatency                    ... |
| task                   |                                                 ... |
| tboot                  |                                                 ... |
| ttys_dcd               | False                                           ... |
| updated_at             | 2023-06-11T21:32:59.698271+00:00                ... |
| uptime                 | 602                                             ... |
| uuid                   | 56a29edb-d147-4450-b79f-f5a57bdc7624            ... |
| vim_progress_status    | services-enabled                                ... |
+------------------------+-------------------------------------------------...-+
```

#### Check for alarms:

```
[sysadmin@controller-0 ~(keystone_admin)]$ fm alarm-list

[sysadmin@controller-0 ~(keystone_admin)]$
```

### Check custom / 3rd party application images

```
[sysadmin@controller-0 ~(keystone_admin)]$ crictl images | grep cyclictest
registry.local:9001/docker.io/windse/cyclictest v1.0 078b7c45bbc0f 630MB
[sysadmin@controller-0 ~(keystone_admin)]$ system registry-image-list
+----------------------------------------------------------+
| Image Name                                               |
+----------------------------------------------------------+
| docker.io/fluxcd/helm-controller                         |
| docker.io/fluxcd/source-controller                       |
| docker.io/starlingx/armada-image                         |
| docker.io/starlingx/n3000-opae                           |
| docker.io/windse/cyclictest                              |
| ghcr.io/helm/tiller                                      |
| ghcr.io/k8snetworkplumbingwg/multus-cni                  |
| ghcr.io/k8snetworkplumbingwg/sriov-cni                   |
| ghcr.io/k8snetworkplumbingwg/sriov-network-device-plugin |
| k8s.gcr.io/coredns/coredns                               |
| k8s.gcr.io/defaultbackend-amd64                          |
| k8s.gcr.io/etcd                                          |
| k8s.gcr.io/ingress-nginx/controller                      |
| k8s.gcr.io/ingress-nginx/kube-webhook-certgen            |
| k8s.gcr.io/kube-apiserver                                |
| k8s.gcr.io/kube-controller-manager                       |
| k8s.gcr.io/kube-proxy                                    |
| k8s.gcr.io/kube-scheduler                                |
| k8s.gcr.io/pause                                         |
| quay.io/calico/cni                                       |
| quay.io/calico/kube-controllers                          |
| quay.io/calico/node                                      |
| quay.io/jetstack/cert-manager-acmesolver                 |
| quay.io/jetstack/cert-manager-cainjector                 |
| quay.io/jetstack/cert-manager-controller                 |
| quay.io/jetstack/cert-manager-ctl                        |
| quay.io/jetstack/cert-manager-webhook                    |
| quay.io/k8scsi/snapshot-controller                       |
| quay.io/stackanetes/kubernetes-entrypoint                |
+----------------------------------------------------------+
```
