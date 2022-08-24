#!/bin/env bash

os=$(go env GOOS)
arch=$(go env GOARCH)
version=1.0.8 # latest stable version

echo -e "Installing kubebuilder ..."
echo -e "\tOS      = ${os}"
echo -e "\tARCH    = ${arch}"
echo -e "\tVERSION = ${version}"

# download the release
curl -L -O "https://github.com/kubernetes-sigs/kubebuilder/releases/download/v${version}/kubebuilder_${version}_${os}_${arch}.tar.gz"

# extract the archive
tar -zxvf kubebuilder_${version}_${os}_${arch}.tar.gz
mv kubebuilder_${version}_${os}_${arch} kubebuilder && sudo mv kubebuilder /usr/local/

# update your PATH to include /usr/local/kubebuilder/bin
export PATH=$PATH:/usr/local/kubebuilder/bin
