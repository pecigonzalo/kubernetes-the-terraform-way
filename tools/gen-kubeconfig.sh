#!/bin/bash
set -euo pipefail

KUBERNETES_PUBLIC_ADDRESS=$(
  jq -r '.lb_addresses.value' certificates/nodes.json
)

# Workers
for instance in wrkr-0 wrkr-1 wrkr-2; do
  kubectl config set-cluster kttw \
    --certificate-authority=certificates/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kubeconfig/${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=certificates/${instance}.pem \
    --client-key=certificates/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfig/${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kttw \
    --user=system:node:${instance} \
    --kubeconfig=kubeconfig/${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfig/${instance}.kubeconfig
done

# kube-proxy
kubectl config set-cluster kttw \
  --certificate-authority=certificates/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=kubeconfig/kube-proxy.kubeconfig

kubectl config set-credentials system:kube-proxy \
  --client-certificate=certificates/kube-proxy.pem \
  --client-key=certificates/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kttw \
  --user=system:kube-proxy \
  --kubeconfig=kubeconfig/kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kubeconfig/kube-proxy.kubeconfig

# kube-controller
kubectl config set-cluster kttw \
  --certificate-authority=certificates/ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

kubectl config set-credentials system:kube-controller-manager \
  --client-certificate=certificates/kube-controller-manager.pem \
  --client-key=certificates/kube-controller-manager-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

kubectl config set-context default \
  --cluster=kttw \
  --user=system:kube-controller-manager \
  --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

kubectl config use-context default --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

# kube-scheduler
kubectl config set-cluster kttw \
  --certificate-authority=certificates/ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=kubeconfig/kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
  --client-certificate=certificates/kube-scheduler.pem \
  --client-key=certificates/kube-scheduler-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/kube-scheduler.kubeconfig

kubectl config set-context default \
  --cluster=kttw \
  --user=system:kube-scheduler \
  --kubeconfig=kubeconfig/kube-scheduler.kubeconfig

kubectl config use-context default --kubeconfig=kubeconfig/kube-scheduler.kubeconfig

# admin
kubectl config set-cluster kttw \
  --certificate-authority=certificates/ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=kubeconfig/admin.kubeconfig

kubectl config set-credentials admin \
  --client-certificate=certificates/admin.pem \
  --client-key=certificates/admin-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/admin.kubeconfig

kubectl config set-context default \
  --cluster=kttw \
  --user=admin \
  --kubeconfig=kubeconfig/admin.kubeconfig

kubectl config use-context default --kubeconfig=kubeconfig/admin.kubeconfig
