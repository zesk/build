#!/usr/bin/env bash
#
# prettier.sh
#
# Depends: apt npm
#
# prettier install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

me="$(basename "$0")"
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which prettier 2>/dev/null 1>&2; then
  exit 0
fi

./bin/build/install/npm.sh

requireFileDirectory "$quietLog"

consoleInfo -n "Installing prettier ..."
start=$(beginTiming)
if ! npm install -g prettier >>"$quietLog" 2>&1; then
  buildFailed "$quietLog"
fi
reportTiming "$start" OK
