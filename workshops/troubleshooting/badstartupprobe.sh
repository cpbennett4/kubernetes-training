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

helm upgrade --timeout 3m --atomic --install --debug --namespace "ws-$name" \
	 -f ./test-ci-rs-startup-probe.yaml --version 0.0 --set image.tag=demo-server-with-cm \
	 --set namespace=ws-cflippin --set clusterType=test \
	 --set environment=ci --set region=rs demo-server ot/service-base
