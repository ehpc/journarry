#!/usr/bin/env -S just --justfile

[group('dev')]
dev arg:
  just "dev-{{arg}}"

# Spin up development environment
[group('dev')]
dev-up:
  ./scripts/dev_up.sh

# Spin down development environment
[group('dev')]
dev-down:
  ./scripts/dev_down.sh

# Show development environment status
[group('dev')]
dev-status:
  k3d cluster list
  k3d registry list
  helm ls -A
