#!/bin/bash
kubectl create deployment scheduler-demo --image=nginx:1.11.10-alpine --replicas=3 --dry-run=client -o yaml > deployment_v1.yaml
kubectl create -f deployment_v1.yaml

# Atualizar a versao
kubectl create deployment scheduler-demo --image=nginx:alpine --replicas=3 --dry-run=client -o yaml > deployment_v2.yaml
kubectl apply -f deployment_v2.yaml

# Atualizar a versao
kubectl create deployment scheduler-demo --image=nginx:1.23.2 --replicas=3 --dry-run=client -o yaml > deployment_v3.yaml
kubectl apply -f deployment_v2.yaml
watch kubectl get po

# mostrar que o scheduler não consegue achar um node que atende aos requisitos desse pod
kubectl set resources deployment scheduler-demo --requests=cpu=1,memory=32G
kubectl get po
kubectl describe pod scheduler-demo-8647d77b64-pp4bc