#!/usr/bin/env bash

###########################
# sudo privileges required
###########################


# Fonts:
# https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/
# https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/

# Prepare environment

apt-get install apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d
apt-get update

# Install Kubernetes

apt-get install -y kubelet kubeadm kubectl kubernetes-cni
apt-mark hold kubelet kubeadm kubectl kubernetes-cni

# Disable swap memory
# Comment /swapfile in fstab file

sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a

# Set Hostname

hostnamectl set-hostname k-control-plane

# Configure Iptables to see bridged traffic
# load br_netfilter module
# Set net.bridge.bridge-nf-call-iptables 1 

modprove overlay
modprobe br_netfilter

sysctl net.bridge.bridge-nf-call-iptables=1
sysctl net.bridge.bridge-nf-call-ip6tables=1
sysctl net.ipv4.ip_forward=1
sysctl --system

# Install container runtime

apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-update
apt install -y containerd.io docker-ce docker-ce-cli
mkdir -p /etc/systemd/system/docker.service.d
tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
systemctl daemon-reload
systemctl restart docker
systemctl enable docker

