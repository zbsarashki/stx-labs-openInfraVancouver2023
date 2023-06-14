# Persistent storage example

The following is a very simple example of running a Kubernetes pod on StarlingX using persistent storage.

Before this can be done the systems might not be configured for persistent storage.  `system storage-backend-list` displays the current state.

> NOTE: For this hands-on configuring persistent storage is required.


# Configure Persistent storage

## From the active Controller, Persistent Storage backend

```
source /etc/platform/openrc
system storage-backend-add ceph --confirmed
    +------------+---------+-------------+-----------------------+----------+---------------+
    | name       | backend | state       | task                  | services | capabilities  |
    +------------+---------+-------------+-----------------------+----------+---------------+
    | ceph-store | ceph    | configuring | {'controller-0':      | None     | replication:  |
    |            |         |             | 'applying-manifests'} |          | 1 min_replica |
    |            |         |             |                       |          | tion: 1       |
    |            |         |             |                       |          |               |
    +------------+---------+-------------+-----------------------+----------+---------------+


```

### From the active Controller, Wait Persistent storage to finish

Run the following command until the `state` says **configured**.  

>NOTE: this takes about 5 minutes

```
system storage-backend-list
    +--------------------------------------+------------+---------+-------------+-------------------------+----------+--------------------+
    | uuid                                 | name       | backend | state       | task                    | services | capabilities       |
    +--------------------------------------+------------+---------+-------------+-------------------------+----------+--------------------+
->  | 0a09c5b2-1dcf-4f38-a947-665d1e8894fb | ceph-store | ceph    | configuring | {'controller-0':        | None     | replication: 1     |
    |                                      |            |         |             | 'applying-manifests'}   |          | min_replication: 1 |
    |                                      |            |         |             |                         |          |                    |
    +--------------------------------------+------------+---------+-------------+-------------------------+----------+--------------------+

system storage-backend-list
    +--------------------------------------+------------+---------+------------+------+----------+-------------------------------------------------+
    | uuid                                 | name       | backend | state      | task | services | capabilities                                    |
    +--------------------------------------+------------+---------+------------+------+----------+-------------------------------------------------+
->  | 0a09c5b2-1dcf-4f38-a947-665d1e8894fb | ceph-store | ceph    | configured | None | None     | replication: 1 min_replication: 1               |
    |                                      |            |         |            |      |          |                                                 |
    +--------------------------------------+------------+---------+------------+------+----------+-------------------------------------------------+
```

## From the active Controller, Check to see if there is a free disk 

This command provides a list of disks on the host.  Disks that are not configured will show space in the `available_gib` column.  In the example below this is /dev/sdb and we will configure CEPH to use it as an OSD.

```
system host-disk-list controller-0
    +--------------------------------------+-----------+---------+---------+-------+------------+-----+-----------+------------------------------------+
    | uuid                                 | device_no | device_ | device_ | size_ | available_ | rpm | serial_id | device_path                        |
    |                                      | de        | num     | type    | gib   | gib        |     |           |                                    |
    +--------------------------------------+-----------+---------+---------+-------+------------+-----+-----------+------------------------------------+
    | 474c72d2-0e52-4d5f-a57f-cf80ae5630f1 | /dev/sda  | 2048    | SSD     | 447.  | 0.0        | N/A | 19342370E | /dev/disk/by-path/pci-0000:00:17.  |
    |                                      |           |         |         | 13    |            |     | 8BE       | 0-ata-1.0                          |
    |                                      |           |         |         |       |            |     |           |                                    |
    | b6da6704-ee80-4b5a-b694-f4af6a72bb38 | /dev/sdb  | 2064    | SSD     | 447.  | 447.13     | N/A | 19342370E | /dev/disk/by-path/pci-0000:00:17.  |
    |                                      |           |         |         | 13    |            |     | A6B       | 0-ata-2.0                          |
    |                                      |           |         |         |       |            |     |           |                                    |
    +--------------------------------------+-----------+---------+---------+-------+------------+-----+-----------+------------------------------------+

```

## From the active Controller, Add OSD

```
DISK_UUID=$(system host-disk-list controller-0 | grep "/dev/sdb" | awk '{print $2}')
system host-stor-add controller-0 osd ${DISK_UUID}
    +------------------+--------------------------------------------------+
    | Property         | Value                                            |
    +------------------+--------------------------------------------------+
    | osdid            | 0                                                |
    | function         | osd                                              |
    | state            | configuring                                      |
    | journal_location | 07cc26a8-c03f-41be-8533-f83be54f142c             |
    | journal_size_gib | 1024                                             |
    | journal_path     | /dev/disk/by-path/pci-0000:00:17.0-ata-2.0-part2 |
    | journal_node     | /dev/sdb2                                        |
    | uuid             | 07cc26a8-c03f-41be-8533-f83be54f142c             |
    | ihost_uuid       | 59af5841-8135-4fb4-a638-f0b9abde2044             |
    | idisk_uuid       | b6da6704-ee80-4b5a-b694-f4af6a72bb38             |
    | tier_uuid        | 379d17b5-6bde-4dbc-8cd8-01c20e0ff42e             |
    | tier_name        | storage                                          |
    | created_at       | 2023-06-14T21:37:13.614076+00:00                 |
    | updated_at       | None                                             |
    +------------------+--------------------------------------------------+

```

## From the active Controller, Wait for the OSD to finish configuring

Wait for the `state` in the below command to be `configured`.

> NOTE: This step takes about 2 minutes

```
system host-stor-list controller-0
    +--------------------------------------+----------+-------+-------------+--------------------------------------+--------------------------------------------------+--------------+------------------+-----------+
    | uuid                                 | function | osdid | state       | idisk_uuid                           | journal_path                                     | journal_node | journal_size_gib | tier_name |
    +--------------------------------------+----------+-------+-------------+--------------------------------------+--------------------------------------------------+--------------+------------------+-----------+
->  | 07cc26a8-c03f-41be-8533-f83be54f142c | osd      | 0     | configuring | b6da6704-ee80-4b5a-b694-f4af6a72bb38 | /dev/disk/by-path/pci-0000:00:17.0-ata-2.0-part2 | /dev/sdb2    | 1                | storage   |
    +--------------------------------------+----------+-------+-------------+--------------------------------------+--------------------------------------------------+--------------+------------------+-----------+

system host-stor-list controller-0
    +--------------------------------------+----------+-------+------------+--------------------------------------+--------------------------------------------------+--------------+------------------+-----------+
    | uuid                                 | function | osdid | state      | idisk_uuid                           | journal_path                                     | journal_node | journal_size_gib | tier_name |
    +--------------------------------------+----------+-------+------------+--------------------------------------+--------------------------------------------------+--------------+------------------+-----------+
->  | 07cc26a8-c03f-41be-8533-f83be54f142c | osd      | 0     | configured | b6da6704-ee80-4b5a-b694-f4af6a72bb38 | /dev/disk/by-path/pci-0000:00:17.0-ata-2.0-part2 | /dev/sdb2    | 1                | storage   |
    +--------------------------------------+----------+-------+------------+--------------------------------------+--------------------------------------------------+--------------+------------------+-----------+
```

## From the active Controller, verify that the sdb drive on controller-0 is not in use

Once configured the following command shows at that the second disk (/dev/sdb) is no free space.

```
system host-disk-list controller-0
+--------------------------------------+-----------+---------+---------+-------+------------+-----+-----------+------------------------------------+
| uuid                                 | device_no | device_ | device_ | size_ | available_ | rpm | serial_id | device_path                        |
|                                      | de        | num     | type    | gib   | gib        |     |           |                                    |
+--------------------------------------+-----------+---------+---------+-------+------------+-----+-----------+------------------------------------+
| 474c72d2-0e52-4d5f-a57f-cf80ae5630f1 | /dev/sda  | 2048    | SSD     | 447.  | 0.0        | N/A | 19342370E | /dev/disk/by-path/pci-0000:00:17.  |
|                                      |           |         |         | 13    |            |     | 8BE       | 0-ata-1.0                          |
|                                      |           |         |         |       |            |     |           |                                    |
| b6da6704-ee80-4b5a-b694-f4af6a72bb38 | /dev/sdb  | 2064    | SSD     | 447.  | 0.0        | N/A | 19342370E | /dev/disk/by-path/pci-0000:00:17.  |
|                                      |           |         |         | 13    |            |     | A6B       | 0-ata-2.0                          |
|                                      |           |         |         |       |            |     |           |                                    |
+--------------------------------------+-----------+---------+---------+-------+------------+-----+-----------+------------------------------------+
```

# Create an Application that uses Persistent Storage

## Create the docker registry secret

> NOTE: The registry secret only needs to be created once and is used for all the app examples.  

```
PASSWORD=St8rlingX*
kubectl create secret docker-registry admin-registry-secret \
      --docker-server=registry.local:9001 --docker-username=admin --docker-password=$PASSWORD \
      --docker-email=noreply@windriver.com

```

## Copy the yaml files to the controller

Using the assigned [SSH proxy port](../jumphost-setup/jumphost-targets.md) copy the yaml files


```
scp -P 2201 sysadmin@147.75.35.13:yamls/app-pvc/*.yaml
```

## From the active Controller, create the application

This creates an application with the PVC mounted at /mnt.

```
kubectl create -f pvc-claim.yaml
kubectl create -f pvcpod.yaml
```

### From the active Controller, verify the pvc exists and the services exist

```
kubectl get persistentvolumeclaims
kubectl get pods
```

#### Expected output
```        
NAME          STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-claim1   Bound    pvc-a86d96f1-d5eb-4ecd-9124-1fe4a7710e6a   1Gi        RWO            general        85m

NAME                   READY   STATUS    RESTARTS   AGE
pvc-555d8c6c77-mngcn   1/1     Running   0          26s
```

### From the active Controller, Create a file on the PV

```
podname=$(kubectl get pods | grep pvc | awk '{print $1}')

kubectl exec -it $podname -- touch /mnt1/IAmHere
```

#### From the active Controller, verify the file
```
kubectl exec -it $podname -- ls /mnt1
    IAmHere lost+found
```

### From the active Controller, delete the pod

```
kubectl delete -f pvcpod.yaml
    deployment.apps "pvc" deleted
```

Use `kubectl get pods` to wait for the pod to be terminated

### From the active Controller, create the pod again 

```
kubectl create -f pvcpod.yaml
```

#### From the active Controller, get the pod

The `NAME` should be different from the above pod

```
kubectl get pods
    NAME                   READY   STATUS    RESTARTS   AGE
--> pvc-555d8c6c77-rl2bt   1/1     Running   0          119s
```

#### Verify the file persisted

```
podname=$(kubectl get pods | grep pvc | awk '{print $1}')
kubectl exec -it $podname -- ls /mnt1
    IAmHere  lost+found
```


