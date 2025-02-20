To scale run:

``` bash
ansible-playbook -i inventory/hetzner-a -u kadmin scale-up-controlplane.yaml -vv -b --become-user=root -l kube_control_plane  -e '{upgrade_cluster_setup: true}'
```

# Convert an existing node to control plane
If it the node is already in used but not as a control plane:
Remove /etc/kubernetes and /var/lib/kubelet/config.yaml on the node.

-> Alternative would be to improve the scripts to automate those steps
