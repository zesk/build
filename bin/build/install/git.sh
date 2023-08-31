#!/usr/bin/env bash
#
# git.sh
#
# Depends: apt
#
# git install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1
export DEBIAN_FRONTEND=noninteractive

me=$(basename "$0")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi
quietLog="./.build/$me.log"

set -eo pipefail

if ! which git 2>/dev/null 1>&2; then
  "./bin/build/install/apt-utils.sh"

  requireFileDirectory "$quietLog"

  consoleInfo -n "Installing git ..."
  start=$(beginTiming)
  if ! apt-get install -y git >"$quietLog" 2>&1; then
    failed "$quietLog"
  fi
  reportTiming "$start" OK
fi
