#!/usr/bin/env bash
#
# docker-compose.sh
#
# Depends: pip python
#
# install docker-compose and requirements
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

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which docker-compose 2>/dev/null 1>&2; then
  exit 0
fi

requireFileDirectory "$quietLog"

"./bin/build/python.sh"

consoleInfo -n "Installing docker-compose ... "
start=$(beginTiming)
if ! pip install docker-compose >"$quietLog" 2>&1; then
  consoleError "pip install docker-compose failed $?"
  failed "$quietLog"
fi
if ! which docker-compose 2>/dev/null; then
  consoleError "docker-compose not found after install"
  failed "$quietLog"
fi
reportTiming "$start" OK
