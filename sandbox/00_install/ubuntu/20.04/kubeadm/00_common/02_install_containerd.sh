#!/usr/bin/env bash

###########################
# sudo privileges required
###########################


# Configure persistent loading of modules
tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

# Load at runtime
modprobe overlay
modprobe br_netfilter

# Ensure sysctl params are set
tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload configs
sysctl --system

# Install required packages
apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Add Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install containerd
apt update
apt install -y containerd.io

# Configure containerd and start service
mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml

# restart containerd
systemctl restart containerd
systemctl enable containerd
systemctl status  containerd

# to use systemd cgroup driver set plugins.cri.systemd_cgroup=true in /etc/containerd/config.toml
