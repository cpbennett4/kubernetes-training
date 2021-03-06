#!/usr/bin/env bash

#set -o nounset -o errexit
if ! [[ -x "$(command -v helm)" ]]; then
	echo "Install helm please" 1>&2
	exit 1
fi

if ! [[ -x "$(command -v kubectl)" ]]; then
	echo "Install kubectl please" 1>&2
	exit 1
fi

name=$(whoami)
if [[ -z ${name} ]]; then
  echo "No name provided - whoami didnt work."  1>&2
  exit 1
fi
# emergency override
if [[ -f ~/.workshop ]]; then
  echo "override name" 1>&2
  name=$(cat ~/.workshop)
fi
echo "Welcome name = $name" 1>&2

release=$1
values=$2
chart=$3

if [[ -z "$release" ]]; then
  echo "No release provided (arg 1)"  1>&2
  exit 1
fi
if [[ -z "$values" ]]; then
  echo "No values file provided (arg 2)"  1>&2
  exit 1
fi

if [[ -z "$chart" ]]; then
  echo "No local chart file provided (arg 3)"  1>&2
  exit 1
fi
if [[ ! -f "$values" ]]; then
  echo "values file $values doesn't exist " 1>&2
  exit 1
fi
if [[ ! -d "ws-charts/$chart" ]]; then
  echo "chart file ws-charts/$chart doesn't exist " 1>&2
  exit 1
fi

ns=ws-$name
# test for pod-preset
PODPRESET=1
if [[ "$PODPRESET" == "1" ]]; then
  TEST=$(kubectl -n $ns get podpreset ot-env)
  if [[ "$?" == "1" ]]; then
    echo "Creating pod preset"  1>&2
    ws-charts/podpreset.sh > podpreset.yaml
    kubectl apply -f podpreset.yaml 1>&2
    rm podpreset.yaml
  fi
fi

# validate all 3 and existence of values and chart
echo rendering using: releasename=$release ... valuesloc=$values ... chart=$chart.. namespace=ws-$name 1>&2
helm template $release ws-charts/$chart -f $values --set namespace=$name --set needsExternalName=no
