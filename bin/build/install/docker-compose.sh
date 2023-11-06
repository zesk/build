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
me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if which docker-compose 2>/dev/null 1>&2; then
  exit 0
fi

requireFileDirectory "$quietLog"

./bin/build/install/python.sh

consoleInfo -n "Installing docker-compose ... "
start=$(beginTiming)
if ! pip install docker-compose >"$quietLog" 2>&1; then
  consoleError "pip install docker-compose failed $?"
  buildFailed "$quietLog"
fi
if ! which docker-compose 2>/dev/null; then
  consoleError "docker-compose not found after install"
  buildFailed "$quietLog"
fi
reportTiming "$start" OK
