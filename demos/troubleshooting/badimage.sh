#!/usr/bin/env bash

helm upgrade --atomic --install --debug --namespace "ws-cflippin" \
	 -f ./test-ci-rs.yaml --version 0.0 --set image.tag=foo \
	 --set namespace=ws-cflippin --set clusterType=test \
	 --set environment=ci --set region=rs demo-server ot/service-base
