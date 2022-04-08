#!/bin/bash

case $1 in
start)
   minikube start --kubernetes-version=v1.23.0 --memory=3g --bootstrapper=kubeadm --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook --extra-config=scheduler.bind-address=0.0.0.0 --extra-config=controller-manager.bind-address=0.0.0.0 --driver=kvm2
   echo "Minikube running"
;;
stop)
   minikube delete
   echo "Minikube stopped"
;;
esac
