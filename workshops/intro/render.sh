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

name=$(whoami)
if [[ -z ${name} ]]; then
  echo "No name provided - whoami didnt work."  1>&2
  exit 1
fi

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
# validate all 3 and existence of values and chart
echo $release ... $values .... $chart 1>&2
helm template $release ws-charts/$chart -f $values --set namespace=$name
