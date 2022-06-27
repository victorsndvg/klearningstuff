#!/usr/bin/bash

######################################
# sudo privileges required
######################################

# Your Kubernetes control-plane has initialized successfully!

# To start using your cluster, you need to run the following as a regular user:

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Alternatively, if you are the root user, you can run:
#
#  export KUBECONFIG=/etc/kubernetes/admin.conf
#
# You should now deploy a pod network to the cluster.
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
#  https://kubernetes.io/docs/concepts/cluster-administration/addons/
# Example:
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#
# Then you can join any number of worker nodes by running the following on each as root:
#
# kubeadm join 10.38.3.4:6443 --token htjtrp.kvqke4gvqdcd23ow \
# 	--discovery-token-ca-cert-hash sha256:0f7320c7c70c436fd7ad52eede4dfbe46bb5cba33dc94e7919de75067f92a14b 
