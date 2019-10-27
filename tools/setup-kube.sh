#!/bin/bash
set -euo pipefail

KUBERNETES_PUBLIC_ADDRESS=$(
  jq -r '.lb_addresses.value' certificates/nodes.json
)
kubectl config set-cluster kttw \
  --certificate-authority=certificates/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials admin \
  --client-certificate=certificates/admin.pem \
  --client-key=certificates/admin-key.pem

kubectl config set-context kttw \
  --cluster=kttw \
  --user=admin

kubectl config use-context kttw
