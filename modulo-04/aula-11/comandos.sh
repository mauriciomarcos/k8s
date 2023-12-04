#!/bin/bash
ssh -i /tmp/keys/private_ssh_key adminuser@4.246.206.150
sudo su
crictl ps
crictl inspect --output go-template --template '{{.info.pid}}' 38667dd0e420a
# Visualizar a interface de rede do pod
nsenter -t 26819 -n ip addr
# output: "10: eth0@if11"

# visualizar a veth dessa interface de rede no host
ip addr | grep -A5 "78:"