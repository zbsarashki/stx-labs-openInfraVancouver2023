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



