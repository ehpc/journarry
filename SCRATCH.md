

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

A quick way to debug would be to re-run `devspace init --reconfigure` and 
when asked "Do you want to develop this project with DevSpace or just 
deploy it?", answer with "I just want to deploy this project". 
Once you have the generated devspace.yaml, you can run 
`devspace deploy --render --debug` and that should show you a 
more descriptive error. Once the error is fixed and the chart can be 
rendered correctly, you can re-run `devspace init --reconfigure` to 
generate a new devspace.yaml with the develop option selected.

`sudo apt install libnss-myhostname` for *.localhost

