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
npm_version=${BUILD_NPM_VERSION:-latest}
set -eo pipefail
export DEBIAN_FRONTEND=noninteractive

me="$(basename "$0")"
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which php 2>/dev/null 1>&2; then
  exit 0
fi

./bin/build/install/apt.sh npm

requireFileDirectory "$quietLog"

start=$(beginTiming)
if ! npm i -g "npm@$npm_version" --force >>"$quietLog" 2>&1; then
  buildFailed "$quietLog"
fi
reportTiming "$start" OK
