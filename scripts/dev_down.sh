#!/usr/bin/env bash
set -euo pipefail

K3D_CONFIG_PATH=k8s/k3d_config.yaml

devspace purge
k3d cluster delete --config ${K3D_CONFIG_PATH}
