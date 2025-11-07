#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="$1"

# Uninstall Traefik
if helm list -n ${CLUSTER_NAME} -o json | jq -e 'any(.[]; .name == "traefik")' > /dev/null; then
  echo "Uninstalling Traefik from minikube cluster '${CLUSTER_NAME}'..."
  helm --kube-context ${CLUSTER_NAME} -n ${CLUSTER_NAME} uninstall traefik
fi

# Stop minikube if it's running
MINIKUBE_STATUS=$(minikube -p ${CLUSTER_NAME} status --format '{{.Host}}')
if [[ ${MINIKUBE_STATUS} =~ 'Running' ]]; then
  minikube -p ${CLUSTER_NAME} stop
  minikube -p ${CLUSTER_NAME} delete
fi

echo "Development environment on minikube cluster '${CLUSTER_NAME}' has been torn down."
