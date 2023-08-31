#!/usr/bin/env bash
#
# apt.sh
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
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

quietLog="./.build/$me.log"
packages=(apt-utils figlet jq "$@")
apt=$(which apt-get || :)

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if [ -z "$apt" ]; then
  consoleInfo "No apt, continuing"
  exit 0
fi

start=$(beginTiming)
consoleInfo -n "Updating apt-get ... "
aptUpdateOnce
reportTiming "$start" OK
start=$(beginTiming)
consoleInfo -n "Installing ${packages[*]} ... "
if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}" >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $errEnv
fi
reportTiming "$start" OK
