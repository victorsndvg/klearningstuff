#!/usr/bin/env bash

###############################
# needs sudo privileges
###############################

# set host name
hostnamectl set-hostname kmaster
echo "127.0.01 kmaster" >> /etc/hosts

# disable swap
swapoff -a

# add Kubernetes key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# add Kubernetes repository
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
apt update

# install Kubernetes tools
apt install -y kubeadm conntrack cri-tools ebtables kubectl kubelet kubernetes-cni socat --allow-unauthenticated

# install Docker
apt install docker.io
# modify /usr/lib/systemd/system/docker.service
# with ExecStart=/usr/bin/dockerd ...   --exec-opt native.cgroupdriver=systemd


# Enable overlay and netfilter modules
modprobe overlay
modprobe br_netfilter

# Enable IP forwarding
echo "net.bridge.bridge-nf-call-iptables  = 1" >> /etc/sysctl.d/99-kubernetes-cri.conf
echo "net.ipv4.ip_forward                 = 1" >> /etc/sysctl.d/99-kubernetes-cri.conf
echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.d/99-kubernetes-cri.conf
sysctl --system
