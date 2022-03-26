#!/usr/bin/env bash

##########################
# sudo privileges required
##########################

lsmod | grep br_netfilter
systemctl enable kubelet

kubeadm config images pull

# For multiple CRI sockets choose one of the following instead:
# CRI-O
# sudo kubeadm config images pull --cri-socket /var/run/crio/crio.sock
# Containerd
# sudo kubeadm config images pull --cri-socket /run/containerd/containerd.sock
# Docker
# sudo kubeadm config images pull --cri-socket /var/run/docker.sock

# Bootstrap cluster without DNS endpoint
kubeadm init --pod-network-cidr=192.168.0.0/16

# For multiple CRI sockets choose one of the following instead:
# CRI-O
# kubeadm init \
#  --pod-network-cidr=192.168.0.0/16 \
#  --cri-socket /var/run/crio/crio.sock \
#  --upload-certs \
#  --control-plane-endpoint=...
#
# Containerd
# kubeadm init \
#  --pod-network-cidr=192.168.0.0/16 \
#  --cri-socket /run/containerd/containerd.sock \
#  --upload-certs \
#  --control-plane-endpoint=...
#
# Docker
# kubeadm init \
#  --pod-network-cidr=192.168.0.0/16 \
#  --cri-socket /var/run/docker.sock \
#  --upload-certs \
#  --control-plane-endpoint=...

