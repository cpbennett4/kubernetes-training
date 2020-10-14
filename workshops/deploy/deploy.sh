#!/usr/bin/env bash

username=$(whoami)
echo "Adding ot helm repo"
helm repo add ot https://artifactory.otenv.com/artifactory/helm
helm repo update

echo "Ensuring namespace and podpresets exist"
helm template --set namespace="ws-$username" --set kind=test \
	 --set env=ci --set region=rs ./ws-charts/cluster-settings \
	 | kubectl -n "ws-$username" apply -f -

echo "Hit enter to generate objects with helm"
read -r
helm template -f ./test-ci-rs.yaml \
	 --set namespace="ws-$username" --version=0.0 --set image.tag=0.0.38-SNAPSHOT-149 \
	 --set clusterType=test --set environment=ci --set region=rs \
	 demo-server ot/service-base | less

echo "Hit enter to do the deploy"
read -r
helm upgrade --timeout 10m --atomic --install --debug --namespace "ws-$username" \
	 -f ./test-ci-rs.yaml --version=0.0 --set image.tag=0.0.38-SNAPSHOT-149 \
	 --set namespace="ws-$username" --set clusterType=test --set environment=ci \
	 --set region=rs demo-server ot/service-base
