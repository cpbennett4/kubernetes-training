#!/usr/bin/env bash

#set -o nounset -o errexit
if ! [[ -x "$(command -v helm)" ]]; then
	echo "Install helm please" 1>&2
	exit 1
fi

if ! [[ -x "$(command -v kubectl)" ]]; then
	echo "error" "Install kubectl please" 1>&2
	exit 1
fi

name=${whoami}
if [[ -z ${name }]]; then
  echo "No name provided"
  exit 1
fi


release=$1
values=$2
chart=$3

# validate all 3 and existence of values and chart

helm template $release $chart -f $values --set namespace=$name
