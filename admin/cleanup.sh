#!/usr/bin/env bash

for ns in $(kubectl get ns | grep ws | awk '{print $1}'); do
	kubectl delete namespace "$ns"
done
