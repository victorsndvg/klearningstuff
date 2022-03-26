###############################
# require sudo privileges
###############################

kubeadm reset
kubeadm join 10.38.3.4:6443 --token htjtrp.kvqke4gvqdcd23ow \
        --discovery-token-ca-cert-hash sha256:0f7320c7c70c436fd7ad52eede4dfbe46bb5cba33dc94e7919de75067f92a14b 
