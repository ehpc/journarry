#!/usr/bin/env -S just --justfile

CLUSTER_NAME := "minikube-journarry"

[group('dev')]
dev arg:
  just "dev-{{arg}}"

# Spin up development environment
[group('dev')]
dev-up:
  ./scripts/dev_up.sh {{CLUSTER_NAME}}

# Spin down development environment
[group('dev')]
dev-down:
  ./scripts/dev_down.sh {{CLUSTER_NAME}}

# Show development environment status
[group('dev')]
dev-status:
  ./scripts/dev_status.sh {{CLUSTER_NAME}}

# Describe all resources in the development namespace
[group('dev')]
dev-describe:
  kubectl describe gatewayClass,gateway,httproute,deployment,ingress,svc,pod -n {{CLUSTER_NAME}}
