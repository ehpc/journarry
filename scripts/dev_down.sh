#!/usr/bin/env bash
set -euo pipefail

k3d cluster delete --config k3d_config.yaml
