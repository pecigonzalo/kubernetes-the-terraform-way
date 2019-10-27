#!/bin/bash
set -euo pipefail

instance="${1}"

NAMES=$(
  jq -r \
    '[.[].value | select(type == "object") | with_entries(select(.key|test("'"${instance}"'"))) | .[]] | join(",")' \
    nodes.json
)

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname="${instance},${NAMES}" \
  -profile=kubernetes \
  "${instance}"-csr.json | cfssljson -bare "${instance}"
