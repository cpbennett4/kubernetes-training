#!/usr/bin/env bash

name=$(whoami)
echo "launching port-forward for you ${name}"

namespace=ws-${name}
label=simple-deploy

echo "getting pod name... "
podname=$(kubectl -n ${namespace} get pod -l app=${label} -o jsonpath="{.items[0].metadata.name}")
echo "hmm $podname looks nice today"
command="kubectl -n ${namespace} port-forward ${podname} 1234:1234"
echo "Here's the command ${command}, hit ctrl-c when done"
${command}
