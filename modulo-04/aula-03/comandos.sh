#!/bin/bash
kubectl create -f pod.yaml
kubectl logs pod/communicate-apiserver