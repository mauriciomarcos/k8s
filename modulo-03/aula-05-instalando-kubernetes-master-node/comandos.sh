#!/bin/bash

az vm list-ip-addresses -g dominando-kubernetes -n kube-master-0 --query "[].virtualMachine.network.publicIpAddresses[0].ipAddress" --output tsv
ssh k8sadmin@20.127.54.225 -i ~/dominando-kubernetes.key
# executar comandos do bootstrap.sh