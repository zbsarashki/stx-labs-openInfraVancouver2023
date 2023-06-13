### Cyclic and Jitter Test
---------------

[About Cyclic Test](https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyclictest/start)<br/>
[About Pma_tools](https://wiki.fd.io/view/Pma_tools/jitter)<br/>

StarlingX supports isolating CPU cores through the isolcpu kernel command line. This is best suited for vRAN uses-cases such as Intel's FlexRAN and NVIDIA's AerialSDK, among others. In this segment we will Isolate four CPU's for cyclic test.

The actual results are sub-optimal and vary among the nodes because of variations in the BIOS and power managment settings.


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

#### Assign labels to node

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

This will reboot the system and apply the configuration. Upon reboot, create the pod with:

```
~(keystone_admin)]$ cat > cj.yml << EOF
apiVersion: v1
kind: Pod
metadata:
  name: fl0
  annotations:
spec:
  restartPolicy: Never
  containers:
  - name: fl0c1
    image: registry.local:9001/docker.io/windse/cyclictest:v1.0
    imagePullPolicy: IfNotPresent
    command: ["/bin/bash", "-ec", "sleep infinity"]
    securityContext:
      privileged: true # true Needed for tests
      capabilities:
        add:
          ["IPC_LOCK", "SYS_ADMIN"]
    resources:
      requests:
        memory: 1Gi
        windriver.com/isolcpus: 8
      limits:
        memory: 1Gi
        windriver.com/isolcpus: 8
EOF
~(keystone_admin)]$ kubectl create -f cj.yml
```

### Wait for the pod to start

```
# Exec into the pod
~(keystone_admin)]$ kubectl exec -it fl0 -- bash

[root@fl0 /]$ taskset -pc 1
 pid 1's current affinity list: 1-4,9-12
[root@fl0 /]$ taskset -c 1 cyclictest -p95 -d0 -t7 -a2-4,9-12
#...

# Jitter
[root@fl0 /]$ cd /
[root@fl0 jitter]$ git clone https://gerrit.fd.io/r/pma_tools
[root@fl0 jitter]$ cd /pma_tools/jitter
[root@fl0 jitter]$ make 
[root@fl0 jitter]$ ./jitter –c 9 –i200 -l80000
```
