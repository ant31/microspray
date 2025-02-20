inventory ?= inventory/sample
ADMIN ?= kadmin

01_create-etcd:
	ansible-playbook -i $(inventory)  -u $(ADMIN)  01_create_etcd.yaml  -vv  -b --become-user=root $(OPTIONS)

02_initialize:
	ansible-playbook -i $(inventory)  -u $(ADMIN)  02_initialize-hosts.yaml  -vv  -b --become-user=root $(OPTIONS)

03_init_cluster:
	ansible-playbook -i $(inventory) -u $(ADMIN) 03_intialize_k8s_master.yaml -vv -b --become-user=root -l kube_node[0],etcd,etcd-events,kube_control_plane $(OPTIONS)

04_fetch_kubecfg:
	ansible-playbook -i $(inventory) -u $(ADMIN) playbooks/075_kubernetes_client_conf.yaml -vv -b --become-user=root

05_scale-up-workers:
	ansible-playbook -i $(inventory) -u $(ADMIN) 04_scale-up-workers.yaml -vv -b --become-user=root $(OPTIONS) -l kube_control_plane[0]:kube_node

06_node_labels: update-node-labels

# limit to first master and all the nodes to add
add-workers:
	ansible-playbook -i $(inventory) -u $(ADMIN) 04_scale-up-workers.yaml -l "kube_control_plane[0]:$(NEW_NODES)" -vv -b --become-user=root $(OPTIONS)

backup-etcd:
	ansible-playbook -i $(inventory) playbooks/backup-etcd.yaml -vv -u $(ADMIN) -b --become-user=root

upgrade-k8s:
	ansible-playbook -i $(inventory)  upgrade-cluster.yml -vv -u $(ADMIN) -b --become-user=root $(OPTIONS)

upgrade-etcd: backup-etcd
	ansible-playbook -i $(inventory)  -u $(ADMIN)  upgrade_etcd.yaml  -vv  -b --become-user=root $(OPTIONS)

update-vendors:
	cd vendors && make update-vendors

update-node-labels:
	ANSIBLE_HASH_BEHAVIOUR=merge ansible-playbook -i $(inventory)  05_label-nodes.yaml -u $(ADMIN) -b --become-user=root $(OPTIONS)

clean:
	rm -rf dist/
	rm *.retry
