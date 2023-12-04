#!/bin/bash
kubectl get ns
ls ~/.kube
export KUBECONFIG=`pwd`/.config
ls
kubectl get ns
kubectl get ns --kubeconfig ~/.kube/config