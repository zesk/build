#!/usr/bin/env bash
#
# python.sh
#
# Depends: apt
#
# python3 install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
errEnv=1
export DEBIAN_FRONTEND=noninteractive

me=$(basename "$0")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. "./bin/build/colors.sh"

if which python 2>/dev/null 1>&2; then
  exit 0
fi

"./bin/build/apt-utils.sh"

requireFileDirectory "$quietLog"

start=$(beginTiming)
consoleCyan "Installing python3 python3-pip ..."
export DEBIAN_FRONTEND=noninteractive
if ! apt-get install -y python3 python3-pip >"$quietLog" 2>&1; then
  failed "$quietLog"
  exit "$errEnv"
fi
reportTiming "$start" OK
