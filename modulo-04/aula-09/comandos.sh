#!/bin/bash
kubectl create -f pod.yaml
watch kubectl get po