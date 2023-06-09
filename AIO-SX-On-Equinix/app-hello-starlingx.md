# Hello StarlingX

This is a very simple example of how to expose node port from the primary CNI to access the pod

# Copy the files to the controller

 Using the assigned [SSH proxy port](../jumphost-setup/jumphost-targets.md) copy the yaml files

For example:

```
scp -P 2201 sysadmin@147.75.35.13:yamls/app-hello-starlingx/*.yaml
```

# From the active Controller, Deploy

## Create the docker registry secret

> NOTE: The registry secret only needs to be created once and is used for all the app examples.  

```
PASSWORD=St8rlingX*
kubectl create secret docker-registry admin-registry-secret \
      --docker-server=registry.local:9001 --docker-username=admin --docker-password=$PASSWORD \
      --docker-email=noreply@windriver.com

```

# From the active Controller, Launch the application

```
kubectl apply -f hello-deployment.yaml 
kubectl apply -f nodeport.yaml
```

# Validate
Validate the container is running and accessible

## Verify the containers are running

```
kubectl get pods
NAME                              READY   STATUS    RESTARTS   AGE
hellodeployment-8d95c89db-nr6kh   1/1     Running   0          8s
hellodeployment-8d95c89db-vdgjj   1/1     Running   0          8s
```

## Using curl

```
IP=$(source /etc/platform/openrc;system oam-show |grep oam_ip | awk '{ print $4 }')
curl -6  http://[$IP]:30001
```

### Example Output

```
<CENTER><h2>Node Info WEBSERVER (v1.0)</h2></CENTER><CENTER><h4>[ Build Date: Sat Jun 10 08:56:21 CDT 2023 ]</h4></CENTER><CENTER><IMG SRC="/static/StarlingX.png" ALIGN="TOP"></CENTER><HR><b>Container:</b><br/><b>&nbsp&nbsp&nbsp&nbsp IP Address:</b> 172.15.192.72<br/><b>&nbsp&nbsp&nbsp&nbsp Container :</b> hellodeployment-5494dcd8dc-g9xxl<br/><br/><b>Host      :</b><br/><b>&nbsp&nbsp&nbsp&nbsp Platform  :</b> Linux-5.10.0-6-amd64-x86_64-with-debian-11.7<br/><b>&nbsp&nbsp&nbsp&nbsp Machine   :</b> x86_64<br/><b>&nbsp&nbsp&nbsp&nbsp Node      :</b> hellodeployment-5494dcd8dc-g9xxl<br/><b>&nbsp&nbsp&nbsp&nbsp System    :</b> Linux<br/><b>&nbsp&nbsp&nbsp&nbsp Release   :</b> 5.10.0-6-amd64<br/><b>&nbsp&nbsp&nbsp&nbsp Version   :</b> #1 SMP PREEMPT StarlingX Debian 5.10.152-1.stx.27 (2022-12-19)<br/><b>&nbsp&nbsp&nbsp&nbsp Uname     :</b> uname_result(system='Linux', node='hellodeployment-5494dcd8dc-g9xxl', release='5.10.0-6-amd64', version='#1 SMP PREEMPT StarlingX Debian 5.10.152-1.stx.27 (2022-12-19)', machine='x86_64', processor='')<br/><br/><b>Resources :</b><br/><b>&nbsp&nbsp&nbsp&nbsp CPUs      :</b> 4<br/><b>&nbsp&nbsp&nbsp&nbsp Memory(GB):</b> 28.61846160888672<br/><HR>
```

## Using Web Browser from a machine that can access the Cloud
Open a web browser and go to the [port your machine is assigned](../jumphost-setup/jumphost-targets.md) to for hello  `http:147.75.35.13:31003`

![Image missing](images/app-helloworld-web.png)

# From the active Controller, Cleanup

```
kubectl delete -f nodeport.yaml
kubectl delete -f hello-deployment.yaml 
kubectl delete  secret docker-registry admin-registry-secret
```
