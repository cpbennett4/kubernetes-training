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
if [[ -f ~/.workshop ]]; then
  echo "override name" 1>2
  name=$(cat ~/.workshop)
fi

release=ot-env
chart=cluster-settings
namespace=ws-$name
if [[ ! -d "ws-charts/$chart" ]]; then
  echo "chart file ws-charts/$chart doesn't exist " 1>&2
  exit 1
fi
# validate all 3 and existence of values and chart
echo rendering  pod preset using: releasename=$release ...... chart=$chart.. namespace=$namespace 1>&2
helm template $release ws-charts/$chart --set namespace=$namespace --set kind=test --set env=ci --set region=rs

