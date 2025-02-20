#!/bin/bash
#  NODE=$1
for node in `kubectl get nodes -o custom-columns=":{.metadata.name}"` ;do
    kubectl get node $node -o json > $node.json
    kubectl delete node $node
    cat $node.json | jq 'del(.spec.podCIDRs[1])' | kubectl create -f -
    sleep 1
done
