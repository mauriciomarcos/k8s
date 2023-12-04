To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join dominando-kubernetes.eastus.cloudapp.azure.com:6443 --token bfy0bh.l7fc2ed2urgw2v99 \
        --discovery-token-ca-cert-hash sha256:3ffd741c5c6d57a9a441d18ab7bc7cb68dfe5a069952966195dbcad3ea5d5234 \
        --control-plane --certificate-key 128c6d18e29a20cd4ede4ffea4f3d478ece265df3a7bce2734ce338d87bc97c4

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join dominando-kubernetes.eastus.cloudapp.azure.com:6443 --token bfy0bh.l7fc2ed2urgw2v99 \
        --discovery-token-ca-cert-hash sha256:3ffd741c5c6d57a9a441d18ab7bc7cb68dfe5a069952966195dbcad3ea5d5234