# Cyclic Test 
---------------

[About Cyclic Test](https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyclictest/start)
```
cat > cj.yml << EOF
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
```


### Cyclictest

#### Exec into the pod `kubectl exec -it fl0 -- bash`

#### Run cyclictest 

```
[root@fl0 /]# taskset -pc 1
 pid 1's current affinity list: 1-4,9-12
[root@fl0 /]# taskset -c 1 cyclictest -p95 -d0 -t7 -a2-4,9-12
```

#### Results are sub-optimal and vary between the systems because of variations in BIOS settings and optimizations of the BIOS.

# Run Jitter Test:

[About Pma_tools](https://wiki.fd.io/view/Pma_tools/jitter)


```
cd /
git clone https://gerrit.fd.io/r/pma_tools
cd /pma_tools/jitter
make 
[root@fl0 jitter]# ./jitter –c 9 –i200 -l80000
```
