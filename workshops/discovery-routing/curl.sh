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
echo "launching curl for you ${name} - note this only works for admins on normal clusters"

namespace=ws-${name}
kubectl -n ${namespace} run -i --tty curl --image=docker.otenv.com/k8s-training:curl --restart=Never --command -- sh && kubectl -n ${namespace} delete pod curl
