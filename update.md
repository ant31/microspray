ansible-playbook playbooks/upgrade-controlplane.yaml -i inventory/sample/hosts.yml -b --become-user=root -e ansible_ssh_user=sampleadmin -K
ansible-playbook cluster.yml -i inventory/sample/hosts.yml -b --become-user=root -e ansible_ssh_user=sampleadmin -K -l k8s-worker-145340,k8s-master-158636
upgrade-k8s version: ansible-playbook upgrade-cluster.yml -i inventory/sample/hosts.yml -b --become-user=root -e ansible_ssh_user=sampleadmin -K --tags update-control-plane,facts
