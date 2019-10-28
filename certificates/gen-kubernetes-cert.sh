#!/bin/bash
set -euo pipefail -x

KUBERNETES_PUBLIC_ADDRESS=$(
  jq -r \
    '.lb_addresses.value' \
    nodes.json
)

KUBERNETES_IPS=$(
  jq -r \
    '[with_entries( select(.key|contains("private") )) | .[].value | .[]] | join(",")' \
    nodes.json
)

HOSTNAMES=(
  127.0.0.1 # localhost for proxy
  10.32.0.1 # POD CIDR
  kubernetes
  kubernetes.default
  kubernetes.default.svc
  kubernetes.default.svc.cluster
  kubernetes.svc.cluster.local
  "$KUBERNETES_PUBLIC_ADDRESS"
)

# Convert to , separated list
HOSTNAMES=$(
  IFS=,
  echo "${HOSTNAMES[*]}","${KUBERNETES_IPS}"
)

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname="${HOSTNAMES}" \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes
