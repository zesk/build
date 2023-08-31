#!/usr/bin/env bash
#
# php.sh
#
# Depends: apt
#
# php install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# set -x
set -eo pipefail
errEnv=1
export DEBIAN_FRONTEND=noninteractive

me="$(basename "$0")"
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which php >/dev/null; then
  exit 0
fi

"./bin/build/install/apt-utils.sh"

requireFileDirectory "$quietLog"

consoleInfo -n "Installing php-cli ..."
export DEBIAN_FRONTEND=noninteractive
start=$(beginTiming)
if ! apt-get install -y php-cli >>"$quietLog" 2>&1; then
  failed "$quietLog"
fi
reportTiming "$start" OK
