az vm list-ip-addresses -g dominando-kubernetes -n kube-worker-node-0 --query "[].virtualMachine.network.publicIpAddresses[0].ipAddress" --output tsv
ssh k8sadmin@20.127.54.225 -i ~/dominando-kubernetes.key
# executar comandos do bootstrap.sh

scp -i ~/dominando-kubernetes.key k8sadmin@20.168.214.50:/home/k8sadmin/.kube/config ./config
export KUBECONFIG=`pwd`/.config
