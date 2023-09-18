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
installedLog="./.build/apt.packages"
packages=(apt-utils figlet jq "$@")
apt=$(which apt-get || :)

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if [ -z "$apt" ]; then
  consoleWarning "No apt, continuing anyway ..."
  exit 0
fi

aptUpdateOnce

touch "$installedLog"
actualPackages=()
for p in "${packages[@]}"; do
  if ! grep -q -e "^$p$" "$installedLog"; then
    actualPackages+=("$p")
    echo "$p" >>"$installedLog"
  fi
done

if [ "${#actualPackages[@]}" -eq 0 ]; then
  if [ -n "$*" ]; then
    consoleSuccess "Already installed: $*"
  fi
  exit 0
fi
start=$(beginTiming)
consoleInfo -n "Installing ${actualPackages[*]} ... "
requireFileDirectory "$quietLog"
if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "${actualPackages[@]}" >>"$quietLog" 2>&1; then
  buildFailed "$quietLog"
  exit $errEnv
fi
reportTiming "$start" OK
