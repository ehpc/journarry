#!/usr/bin/env bash
set -euo pipefail

K3D_CONFIG_PATH=k8s/k3d_config.yaml
TRAEFIK_CONFIG_PATH=k8s/traefik-values.yaml
CLUSTER_NAME=$(yq '.metadata.name' ${K3D_CONFIG_PATH})
CONTEXT=k3d-${CLUSTER_NAME}

# Spin up k3d cluster if it doesn't exist
if ! k3d cluster list | grep -q "^${CLUSTER_NAME}\b"; then
  k3d cluster create --config ${K3D_CONFIG_PATH}
fi

# Install Traefik via Helm
helm --kube-context ${CONTEXT} repo add traefik https://traefik.github.io/charts
helm --kube-context ${CONTEXT} repo update
helm --kube-context ${CONTEXT} upgrade --install traefik traefik/traefik \
  -n ${CLUSTER_NAME} \
  --create-namespace \
  -f ${TRAEFIK_CONFIG_PATH}

# devspace use namespace "${NS_DEV}"
# devspace dev -f tools/dev/devspace.yaml
