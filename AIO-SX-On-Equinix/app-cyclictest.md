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


# Run Cyclic Test with:

```
[root@fl0 /]# taskset -c 1 cyclictest -p95 -d0 -t7 -a2-4,9-12
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 3.35 3.75 3.21 1/2025 143

T: 0 (  137) P:95 I:1000 C:   2136 Min:      4 Act:    4 Avg:    4 Max:       5
T: 1 (  138) P:95 I:1000 C:   2136 Min:      4 Act:    4 Avg:    4 Max:       5
T: 2 (  139) P:95 I:1000 C:   2136 Min:      4 Act:    4 Avg:    4 Max:       5
T: 3 (  140) P:95 I:1000 C:   2136 Min:      3 Act:    3 Avg:    3 Max:       6
T: 4 (  141) P:95 I:1000 C:   2136 Min:      4 Act:    4 Avg:    4 Max:       6
T: 5 (  142) P:95 I:1000 C:   2136 Min:      4 Act:    4 Avg:    4 Max:       6
T: 6 (  143) P:95 I:1000 C:   2136 Min:      3 Act:    4 Avg:    4 Max:       6
[root@fl0 /]#
```

# Run Jitter Test:

[About Pma_tools](https://wiki.fd.io/view/Pma_tools/jitter)


```
cd /
git clone https://gerrit.fd.io/r/pma_tools
cd /pma_tools/jitter
make 
....
[root@fl0 jitter]# ./jitter –c 9 –i200 -l80000
Linux Jitter testing program version 1.9
The pragram will execute a dummy function 80000 times
Display is updated every 20000 displayUpdate intervals
Thread affinity will be set to core_id:1
Timings are in CPU Core cycles
Inst_Min:    Minimum Excution time during the display update interval(default is ~1 second)
Inst_Max:    Maximum Excution time during the display update interval(default is ~1 second)
Inst_jitter: Jitter in the Excution time during rhe display update interval. This is the value of interest
last_Exec:   The Excution time of last iteration just before the display update
Abs_Min:     Absolute Minimum Excution time since the program started or statistics were reset
Abs_Max:     Absolute Maximum Excution time since the program started or statistics were reset
tmp:         Cumulative value calcualted by the dummy function
Interval:    Time interval between the display updates in Core Cycles
Sample No:   Sample number

   Inst_Min   Inst_Max   Inst_jitter last_Exec  Abs_min    Abs_max      tmp       Interval     Sample No
    136608     138338       1730     136708     136608     138338     720764928 2735117054          1
    136608     138560       1952     136642     136608     138560    1068892160 2735167664          2
    136606     138372       1766     136640     136606     138560    1417019392 2735232868          3
    136608     138174       1566     136632     136606     138560    1765146624 2735128996          4
    136608     138242       1634     136618     136606     138560    2113273856 2735242064          5
    136608     137980       1372     136670     136606     138560    2461401088 2735160446          6
    136610     138082       1472     136708     136606     138560    2809528320 2735034828          7
    136610     137372        762     136668     136606     138560    3157655552 2734996106          8
    136610     137858       1248     136630     136606     138560    3505782784 2734999432          9
    136608     137984       1376     136658     136606     138560    3853910016 2735026816         10
    136608     137424        816     136672     136606     138560    4202037248 2735022718         11
    136608     138224       1616     136710     136606     138560     255197184 2735035116         12
    136610     138466       1856     136688     136606     138560     603324416 2735002046         13
    136608     137488        880     136662     136606     138560     951451648 2735004858         14
    136608     138174       1566     136700     136606     138560    1299578880 2735029860         15
    136606     137404        798     136642     136606     138560    1647706112 2734992188         16
```
