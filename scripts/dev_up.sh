#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="$1"
TRAEFIK_CONFIG_PATH=k8s/traefik-values-dev.yaml

# Check if minikube is running; if not, start it
MINIKUBE_STATUS=$(minikube -p ${CLUSTER_NAME} status --format '{{.Host}}' || true)
if [[ ! ${MINIKUBE_STATUS} =~ 'Running' ]]; then
  minikube -p ${CLUSTER_NAME} start
  minikube -p ${CLUSTER_NAME} addons enable metrics-server
fi

# Set up Docker environment to use minikube's Docker daemon
eval $(minikube -p ${CLUSTER_NAME} docker-env)
minikube profile ${CLUSTER_NAME}

# Install Traefik via Helm
if ! helm list -n ${CLUSTER_NAME} -o json | jq -e 'any(.[]; .name == "traefik")' > /dev/null; then
  helm --kube-context ${CLUSTER_NAME} repo add traefik https://traefik.github.io/charts
  helm --kube-context ${CLUSTER_NAME} repo update
  helm --kube-context ${CLUSTER_NAME} upgrade --install traefik traefik/traefik \
    -n ${CLUSTER_NAME} \
    --create-namespace \
    -f ${TRAEFIK_CONFIG_PATH}
fi

skaffold config set --global collect-metrics false
skaffold config set --kube-context ${CLUSTER_NAME} local-cluster true

echo "Development environment is up and running on minikube cluster '${CLUSTER_NAME}'."
