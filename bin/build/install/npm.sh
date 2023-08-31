#!/usr/bin/env bash
#
# php.sh
#
# Depends: apt
#
# npm install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
errEnv=1
export DEBIAN_FRONTEND=noninteractive

me="$(basename "$0")"
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which php 2>/dev/null 1>&2; then
  exit 0
fi

./bin/build/install/apt.sh npm

requireFileDirectory "$quietLog"

start=$(beginTiming)
if ! npm i -g npm@latest --force >>"$quietLog" 2>&1; then
  failed "$quietLog"
fi
reportTiming "$start" OK