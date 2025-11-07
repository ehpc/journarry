#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="$1"

minikube -p ${CLUSTER_NAME} status

echo "Nodes in minikube cluster '${CLUSTER_NAME}':"
minikube -p ${CLUSTER_NAME} node list
echo ""

echo "Images in minikube cluster '${CLUSTER_NAME}':"
minikube -p ${CLUSTER_NAME} image ls
echo ""

echo "Services in minikube cluster '${CLUSTER_NAME}':"
kubectl -n ${CLUSTER_NAME} get svc
echo ""

echo "Pods in minikube cluster '${CLUSTER_NAME}':"
kubectl -n ${CLUSTER_NAME} get pods
