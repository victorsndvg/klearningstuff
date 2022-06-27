#!/bin/env bash

#kubectl krew install trace

## Alternative
curl -L -o kubectl-trace.tar.gz https://github.com/iovisor/kubectl-trace/releases/download/v0.1.0-rc.1/kubectl-trace_0.1.0-rc.1_linux_amd64.tar.gz
tar -xvf kubectl-trace.tar.gz
mv kubectl-trace /usr/local/bin/kubectl-trace
