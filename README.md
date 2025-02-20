Microspray is an opiniated production ready Kubernetes distribution based on Kubespray
 
Need different OS/Options? Kubespray is a better choice.

## Baremetal first-class

All the clouds propose already a 'Managed' kubernetes service.
Microspray focus on non-cloud infrastructure (Baremetal/dedicated/On-premise...)

## Managing kubernetes clusters, the ecosystem

Being opinated help keeping all clusters deployments homogenous shape is essential to build the automations to upgrade, monitor and scale.

### Choices
 - No network manager
 - No app management
 - Separated Containerd / Crictl via another lifecycle
 - Separated Etcd via another lifecycle 
 - Separated Operating System via another lifecycle
 - uses Kubeadm
 - CoreDNS 
 - Opensource only
  
Supported Linux Distributions
- Ubuntu
 
