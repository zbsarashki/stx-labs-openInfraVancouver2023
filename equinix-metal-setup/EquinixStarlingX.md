# <p style="text-align: center;">OpenInfra Summit<br/>Vancouver  2023<br/>StarlingX Hands-on Lab<br/>Open Infrastructure Project Workspaces<br/><br/>Create Starlingx on Demand</p>

---

Provision a Bare Metal server and configure its OS to install StarlingX over IPXE. The steps are identical to the previous segment, except instead of selecting Debian, select custom-ipxe. ***Make sure to select IPV6 with /124 prefix***

### Provision on Demand Equinix Metal



<img align="center" width="800" height="400" src="pngs/DebianOnDemand01.png"><br/>

### Select OS

<img align="center" width="800" height="200" src="pngs/StarlingXSelectOS.png"><br/>


<br/>***Next give a unique name to the machine***<br/>

For the naming of the host, follow this rule for Targets:

Name your server as: c3sxda-\<your username\>-***stx***, where<br/>
c3sx == c3.small.x86<br/>
da == Dallas<br/>

### Ensure ipv6 prefix is /124<br/>

<img align="center" width="800" height="400" src="pngs/StarlingXHostNameIPV6Preffix.png"><br/>
<br/>

***And Deploy the box***<br/>


[Prev: Debian on Demand Metal](IPXEServer.md)<br/>
[Prev: Using Equinix Metal](using_equinix_metal.md)<br/>
