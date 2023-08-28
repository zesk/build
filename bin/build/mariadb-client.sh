#!/usr/bin/env bash
#
# mariadb-client.sh
#
# Depends: apt
#
# mariadb-client install if needed
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
mariadb=$(which mariadb 2>/dev/null || :)

# shellcheck source=/dev/null
. "./bin/build/colors.sh"

if [ -n "$mariadb" ]; then
  exit 0
fi

"./bin/build/apt-utils.sh"
requireFileDirectory "$quietLog"
consoleInfo -n "Install mariadb-client ... "
start=$(beginTiming)
if ! apt-get install -y mariadb-client >"$quietLog" 2>&1; then
  failed "$quietLog"
fi
reportTiming "$start" OK
