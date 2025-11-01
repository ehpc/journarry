

# Prereqs

Install [mise](https://mise.jdx.dev/)

Run `mise install`


# Arch

Build orchestration: [Bazel](https://bazel.build/)
k8s dev env: [DevSpace](https://www.devspace.sh/)
k8s package manager: [Helm](https://helm.sh/)


# TODO

- /web/helm (deployment, service, httproute)
- /llm_worker/helm (deployment, service, httproute)
- /infra/helm (gateway)
- devspace


helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik

