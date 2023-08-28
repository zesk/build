#!/usr/bin/env bash
#
# apt-utils.sh
#
# Depends: apt
#
# apt-utils base setup
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

quietLog="./.build/$me.log"
markerFile="./.build/.$me.marker"
packages=(apt-utils figlet jq "$@")
apt=$(which apt-get || :)

# shellcheck source=/dev/null
. "./bin/build/colors.sh"

if [ -f "$markerFile" ]; then
  exit 0
fi

if [ -z "$apt" ]; then
  consoleInfo "No apt, continuing"
  exit 0
fi

export DEBIAN_FRONTEND=noninteractive

start=$(beginTiming)
consoleInfo -n "Updating apt-get ... "
requireFileDirectory "$quietLog"
if ! apt-get update >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $errEnv
fi
reportTiming "$start" OK
start=$(beginTiming)
consoleInfo -n "Installing ${packages[*]} ... "
if ! apt-get install -y "${packages[@]}" >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $errEnv
fi
date >"$markerFile"
reportTiming "$start" OK
