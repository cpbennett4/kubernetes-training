#!/usr/bin/env bash

name=$(whoami)
if [[ -z ${name} ]]; then
  echo "No name provided - whoami didnt work."  1>&2
  exit 1
fi
# emergency override
if [[ -f ~/.workshop ]]; then
  echo "override name"
  name=$(cat ~/.workshop)
fi
echo "launching port-forward for you ${name}"

namespace=ws-${name}
label=simple-deploy

echo "getting pod name... "
podname=$(kubectl -n ${namespace} get pod -l app=${label} -o jsonpath="{.items[0].metadata.name}")
echo "hmm $podname looks nice today"
command="kubectl -n ${namespace} port-forward ${podname} 8080:8080"
echo "Here's the command ${command}, hit ctrl-c when done"
${command}
