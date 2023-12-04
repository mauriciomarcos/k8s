#!/bin/bash
# Criando o grupo de recursos e a rede virtual
az group create -n dominando-kubernetes -l eastus

az network vnet create \
    --resource-group dominando-kubernetes \
    --name rede-k8s \
    --address-prefix 10.10.0.0/26 \
    --subnet-name k8s-subnet \
    --subnet-prefix 10.10.0.0/26

az network nsg create \
    --resource-group dominando-kubernetes \
    --name k8s-nsg

az network nsg rule create \
    --resource-group dominando-kubernetes \
    --nsg-name k8s-nsg \
    --name kubeadmssh \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow

az network nsg rule create \
    --resource-group dominando-kubernetes \
    --nsg-name k8s-nsg \
    --name kubeadmWeb \
    --protocol tcp \
    --priority 1001 \
    --destination-port-range 6443 \
    --access allow

az network vnet subnet update \
    -g dominando-kubernetes \
    -n k8s-subnet \
    --vnet-name rede-k8s \
    --network-security-group k8s-nsg

## Criando as VMs

ssh-keygen -t rsa -b 2048 -f dominando-kubernetes.key -N ''
cp dominando-kubernetes.key ~/
chmod 400 ~/dominando-kubernetes.key

 
az vm create -n kube-master-0 -g dominando-kubernetes \
--image Ubuntu2204 \
--vnet-name rede-k8s --subnet k8s-subnet \
--admin-username k8sadmin \
--ssh-key-value ./dominando-kubernetes.key.pub \
--size Standard_B2s \
--nsg k8s-nsg \
--public-ip-sku Standard \
--public-ip-address-dns-name dominando-kubernetes

az vm create -n kube-worker-node-0 -g dominando-kubernetes \
--image Ubuntu2204 \
--vnet-name rede-k8s --subnet k8s-subnet \
--admin-username k8sadmin \
--ssh-key-value ./dominando-kubernetes.key.pub \
--size Standard_B2s \
--nsg k8s-nsg \
--public-ip-sku Standard
