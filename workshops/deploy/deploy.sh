#!/usr/bin/env bash

name=$(whoami)
if [[ -z ${name} ]]; then
  echo "No name provided - whoami didnt work."  1>&2
  exit 1
fi
if [[ -f ~/.workshop ]]; then
  echo "override name"
  name=$(cat ~/.workshop)
fi

echo "Adding ot helm repo"
helm repo add ot https://artifactory.otenv.com/artifactory/helm
helm repo update

echo "Ensuring namespace exists"
helm template --set namespace="ws-$name" --set kind=test \
	 --set env=ci --set region=rs ./ws-charts/cluster-settings \
	 | kubectl -n "ws-$name" apply -f -

echo
echo "Running this command"
echo "helm template -f ./test-ci-rs.yaml \\"
echo "  --set namespace=\"ws-$name\" --version=0.0 --set image.tag=demo-server-with-cm \\"
echo "  --set clusterType=test --set environment=ci --set region=rs \\"
echo "  demo-server ot/service-base | less"
echo -n "Hit enter generate yaml with helm: "
read -r
helm template -f ./test-ci-rs.yaml \
	 --set namespace="ws-$name" --version=0.0 --set image.tag=demo-server-with-cm \
	 --set clusterType=test --set environment=ci --set region=rs \
	 demo-server ot/service-base | less

echo
echo "Running this command"
echo "helm upgrade --timeout 10m --atomic --install --debug --namespace \"ws-$name\" \\"
echo "  -f ./test-ci-rs.yaml --version=0.0 --set image.tag=demo-server-with-cm \\"
echo "  --set namespace=\"ws-$name\" --set clusterType=test --set environment=ci \\"
echo "  --set region=rs demo-server ot/service-base"
echo -n "Hit enter to do the deploy"
read -r
helm upgrade --timeout 10m --atomic --install --debug --namespace "ws-$name" \
	 -f ./test-ci-rs.yaml --version=0.0 --set image.tag=demo-server-with-cm \
	 --set namespace="ws-$name" --set clusterType=test --set environment=ci \
	 --set region=rs demo-server ot/service-base
