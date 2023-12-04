#!/bin/sh

# Instala o cliente etcd
sudo apt install etcd-client

# Consulta o etcd para obter informações sobre os deployments do Kubernetes
sudo ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key get /registry/deployments --prefix --write-out=json

# Decodifica a string base64 a partir do value do resultado acima
echo "L3JlZ2lzdHJ5L2RlcGxveW1lbnRzL2t1YmUtc3lzdGVtL2NvcmVkbnM=" | base64 -d

# Obtém informações sobre o deployment coredns no namespace kube-system
kubectl get deployments coredns -n kube-system -o json

# Define variáveis de ambiente para interagir com o etcd
export ETCDCTL_API=3
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key
export ETCDCTL_ENDPOINTS=https://127.0.0.1:2379

# Consulta novamente o etcd, mas agora com as variáveis de ambiente definidas
sudo -E etcdctl get /registry/deployments --prefix --write-out=json

# Salva um snapshot do etcd
sudo -E etcdctl snapshot save ~/snapshot.db

# Verifica o status do snapshot
sudo -E etcdctl snapshot status ~/snapshot.db --write-out=table

# Lista todos os pods em todos os namespaces
kubectl get pods -A

# Verifica o status do kube-apiserver
systemctl status kube-apiserver

# Verifica o status do kubelet
systemctl status kubelet

# Lista os manifestos do Kubernetes
ls /etc/kubernetes/manifests

# Lista todos os pods novamente
kubectl get pods -A

# Move o manifesto do kube-apiserver para a pasta home do usuário
sudo mv /etc/kubernetes/manifests/kube-apiserver.yaml ~/

# Lista todos os pods novamente
kubectl get pods -A

# Devolve o manifesto do kube-apiserver para o local original
sudo mv ~/kube-apiserver.yaml /etc/kubernetes/manifests/

# Lista todos os nodes do cluster
kubectl get nodes

# Drena o node kube-master-0 para manutenção, ignorando os daemonsets
kubectl drain kube-master-0 --ignore-daemonsets

# Lista os nodes novamente
kubectl get nodes

# Exibe o conteúdo do manifesto do etcd
sudo cat /etc/kubernetes/manifests/etcd.yaml

# Inicia um pod nginx após ter efetuado o backup do etcd
kubectl run nginx --image=nginx 

# Lista todos os pods novamente para consultar o status do pod nginx
kubectl get pods -A

# Restaura o snapshot do etcd
sudo -E etcdctl snapshot restore ~/snapshot.db 

# Lista o conteúdo do diretório atual
ls

# Move o manifesto do etcd para a pasta home do usuário
sudo mv /etc/kubernetes/manifests/etcd.yaml ~/

# Renomeia o diretório member para member.bak
sudo mv /var/lib/etcd/member /var/lib/etcd/member.bak

# Move o diretório member de default.etcd para o diretório /var/lib/etcd/
sudo mv default.etcd/member /var/lib/etcd/

# Devolve o manifesto do etcd para o local original
sudo mv ~/etcd.yaml /etc/kubernetes/manifests/

# Aguarde até 2 minutos para o etcd ser restaurado

# Lista todos os pods novamente
kubectl get pods -A

# Lista todos os nodes do cluster
kubecl get nodes

# Cancela a drenagem do node kube-master-0, permitindo que ele execute pods novamente
kubectl uncordon kube-master-0

# Lista os nodes novamente
kubecl get nodes
