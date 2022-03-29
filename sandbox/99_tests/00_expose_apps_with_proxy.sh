#!/usr/bin/env bash

IP=$(ip route get 1.2.3.4 | awk '{print $7}')
kubectl proxy --address=$IP --accept-hosts=.*

