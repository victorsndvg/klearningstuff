#!/usr/bin/bash

###########################
# requires sudo privileges
###########################

rm -rf /etc/kubernetes/manifests/*.yaml
kubeadm reset
IP=$(ip route get 1.2.3.4 | awk '{print $7}')
kubeadm init --apiserver-advertise-address=$IP --pod-network-cidr=10.38.3.0/24
#kubeadm init --apiserver-advertise-address=$IP 


