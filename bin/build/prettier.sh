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
errEnv=1

me="$(basename "$0")"
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. "./bin/build/colors.sh"

if which prettier 2>/dev/null 1>&2; then
  exit 0
fi

"./bin/build/apt-utils.sh"
"./bin/build/npm.sh"

requireFileDirectory "$quietLog"

consoleInfo -n "Installing prettier ..."
start=$(beginTiming)
if ! npm install -g prettier >>"$quietLog" 2>&1; then
  failed "$quietLog"
fi
reportTiming "$start" OK
